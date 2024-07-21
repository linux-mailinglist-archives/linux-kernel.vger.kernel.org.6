Return-Path: <linux-kernel+bounces-258180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC169384C8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 15:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6441F21300
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 13:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD081667D8;
	Sun, 21 Jul 2024 13:37:19 +0000 (UTC)
Received: from mailscanner04.zoner.fi (mailscanner04.zoner.fi [5.44.246.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1749161916
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.44.246.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721569039; cv=none; b=NLY5RJO6h5C6SXT+Ki2APyW4O5ZZNWlB9KcmNU8J3lpjh3JMZtj+O18KRwF1IUUJ5i7sTmJAiu5NTWOVpy73NoqT98vBsbI08QiiAyBmFo3iTkhmB4MEaDvGGenM9Y/uTJYCSMvj54MjDrzLSEWQAfHimYE7FCGHEKr3bGXRWco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721569039; c=relaxed/simple;
	bh=TDkuymGTHyPK5qlz75o1KXXkhPuoBm/rx9+sjJ+AAGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukZIcc3yzdyHx2FcbSn95GOOEbAoYndDoA1QDhtJXte2cXLr4TJmI3va0qTyWhCjN1Uqxu+Er75cG5sLhNdGQSd1VYhnUn89ZiFRgNINpXiaS8AG1s4rPZ+ymuBRow6soq6kzs8TsfgCp+X3PQ8j13B33sElqVsB2+LuP5Upduk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org; spf=pass smtp.mailfrom=tukaani.org; arc=none smtp.client-ip=5.44.246.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tukaani.org
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
	by mailscanner04.zoner.fi (Postfix) with ESMTPS id 0017E21345;
	Sun, 21 Jul 2024 16:37:15 +0300 (EEST)
Received: from mail.zoner.fi ([84.34.147.244])
	by www25.zoner.fi with esmtp (Exim 4.97.1)
	(envelope-from <lasse.collin@tukaani.org>)
	id 1sVWkR-00000001SmU-2J1D;
	Sun, 21 Jul 2024 16:37:14 +0300
From: Lasse Collin <lasse.collin@tukaani.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lasse Collin <lasse.collin@tukaani.org>,
	Sam James <sam@gentoo.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/16] xz: Optimize for-loop conditions in the BCJ decoders
Date: Sun, 21 Jul 2024 16:36:25 +0300
Message-ID: <20240721133633.47721-11-lasse.collin@tukaani.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240721133633.47721-1-lasse.collin@tukaani.org>
References: <20240721133633.47721-1-lasse.collin@tukaani.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compilers cannot optimize the addition "i + 4" away since theoretically
it could overflow.

Reviewed-by: Sam James <sam@gentoo.org>
Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>
---
 lib/xz/xz_dec_bcj.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/lib/xz/xz_dec_bcj.c b/lib/xz/xz_dec_bcj.c
index ab9237ed6db8..e0b4bf4999c0 100644
--- a/lib/xz/xz_dec_bcj.c
+++ b/lib/xz/xz_dec_bcj.c
@@ -161,7 +161,9 @@ static size_t bcj_powerpc(struct xz_dec_bcj *s, uint8_t *buf, size_t size)
 	size_t i;
 	uint32_t instr;
 
-	for (i = 0; i + 4 <= size; i += 4) {
+	size &= ~(size_t)3;
+
+	for (i = 0; i < size; i += 4) {
 		instr = get_unaligned_be32(buf + i);
 		if ((instr & 0xFC000003) == 0x48000001) {
 			instr &= 0x03FFFFFC;
@@ -218,7 +220,9 @@ static size_t bcj_ia64(struct xz_dec_bcj *s, uint8_t *buf, size_t size)
 	/* Instruction normalized with bit_res for easier manipulation */
 	uint64_t norm;
 
-	for (i = 0; i + 16 <= size; i += 16) {
+	size &= ~(size_t)15;
+
+	for (i = 0; i < size; i += 16) {
 		mask = branch_table[buf[i] & 0x1F];
 		for (slot = 0, bit_pos = 5; slot < 3; ++slot, bit_pos += 41) {
 			if (((mask >> slot) & 1) == 0)
@@ -266,7 +270,9 @@ static size_t bcj_arm(struct xz_dec_bcj *s, uint8_t *buf, size_t size)
 	size_t i;
 	uint32_t addr;
 
-	for (i = 0; i + 4 <= size; i += 4) {
+	size &= ~(size_t)3;
+
+	for (i = 0; i < size; i += 4) {
 		if (buf[i + 3] == 0xEB) {
 			addr = (uint32_t)buf[i] | ((uint32_t)buf[i + 1] << 8)
 					| ((uint32_t)buf[i + 2] << 16);
@@ -289,7 +295,12 @@ static size_t bcj_armthumb(struct xz_dec_bcj *s, uint8_t *buf, size_t size)
 	size_t i;
 	uint32_t addr;
 
-	for (i = 0; i + 4 <= size; i += 2) {
+	if (size < 4)
+		return 0;
+
+	size -= 4;
+
+	for (i = 0; i <= size; i += 2) {
 		if ((buf[i + 1] & 0xF8) == 0xF0
 				&& (buf[i + 3] & 0xF8) == 0xF8) {
 			addr = (((uint32_t)buf[i + 1] & 0x07) << 19)
@@ -317,7 +328,9 @@ static size_t bcj_sparc(struct xz_dec_bcj *s, uint8_t *buf, size_t size)
 	size_t i;
 	uint32_t instr;
 
-	for (i = 0; i + 4 <= size; i += 4) {
+	size &= ~(size_t)3;
+
+	for (i = 0; i < size; i += 4) {
 		instr = get_unaligned_be32(buf + i);
 		if ((instr >> 22) == 0x100 || (instr >> 22) == 0x1FF) {
 			instr <<= 2;
-- 
2.45.2


