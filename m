Return-Path: <linux-kernel+bounces-190541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8C08CFFAC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D6A283F01
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AF415E5D9;
	Mon, 27 May 2024 12:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="fZHcM75B"
Received: from mail02.habana.ai (habanamailrelay.habana.ai [213.57.90.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37A015DBCB
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.57.90.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716811994; cv=none; b=PQ2yd8ayGyAHySKHxVCH0n9Udz1qI/3ZZuLcRw2yBadBw40Fvjr3yU0qHUOkLzUSTdAQ+RwHzN+kjYOZgs3P9+uTbxCU++zjVD+o6Aiyvu9kaRbBHsj8utejdp9WjZzOIichhKundUaf4t70mGcEZG4bTaQgA/hnoLufYdsZ/6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716811994; c=relaxed/simple;
	bh=hikixPhgw118twEP+21boqHR0BCJuA1UyHNIo4eFSHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fsf09ArrBNzSORVmyy7oOgFeHFiCKRb09zSJRbVRWVHquq1GbQAYouncxjupDLkFZLGWBA35z+YOr5dSunAZ+rgh/Z7arwn7AZo8gt7LL6nOM2AWZIM6788XOvqdrDEJ6NCRnzxE+wz4Zha6xL9GG/Hw5FlqwaFepEsGNlrMvLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=fZHcM75B; arc=none smtp.client-ip=213.57.90.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
	t=1716811993; bh=hikixPhgw118twEP+21boqHR0BCJuA1UyHNIo4eFSHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fZHcM75BM/ZPCm5dogM9PnM2+U6VWsKfHNApocPn57lLGXJ8tUPoYjLT1F86ne5cr
	 mEOtlWPuSo6frJzyxu3p8jU4NhvJpASqHThmvzrDpawGeN3riUTZ+YW8P95ddU4kmt
	 VMYYDPnEmluzgrRQPDKLYCNsUe0C8UGa1np/60FHiKRBJYLGLsi0yOJEICtk5m8tYf
	 oWQU7qildiZgUmLj0YfvGe66zMDKLz9crvlzbG4NhUFlZJSXBsqa29lUdW1VKs/VhD
	 zF2tz5ULOMOzoTHx6+xnWogyd5u4mLIfrkz+m8hohlIxI4N7YxC5hw5yCWRd6PYV6L
	 DlXsPryuK/8Uw==
Received: from obitton-vm-u22.habana-labs.com (localhost [127.0.0.1])
	by obitton-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 44RCCuaw1921351;
	Mon, 27 May 2024 15:12:57 +0300
From: Ofir Bitton <obitton@habana.ai>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 6/8] accel/habanalabs: separate nonce from max_size in cpucp_packet struct
Date: Mon, 27 May 2024 15:12:52 +0300
Message-Id: <20240527121254.1921306-6-obitton@habana.ai>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527121254.1921306-1-obitton@habana.ai>
References: <20240527121254.1921306-1-obitton@habana.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dani Liberman <dliberman@habana.ai>

In struct cpucp_packet both nonce and data_max_size members are in an
union overlapping each other. This is a problem as they both are used
in attestation and info_signed packets.
The solution here is to move the nonce member to a different union under
the same structure.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Ofir Bitton <obitton@habana.ai>
---
 include/linux/habanalabs/cpucp_if.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/habanalabs/cpucp_if.h b/include/linux/habanalabs/cpucp_if.h
index 1ac1d68193e3..0913415243e8 100644
--- a/include/linux/habanalabs/cpucp_if.h
+++ b/include/linux/habanalabs/cpucp_if.h
@@ -859,9 +859,6 @@ struct cpucp_packet {
 		 * result cannot be used to hold general purpose data.
 		 */
 		__le32 status_mask;
-
-		/* random, used once number, for security packets */
-		__le32 nonce;
 	};
 
 	union {
@@ -870,6 +867,9 @@ struct cpucp_packet {
 
 		/* For Generic packet sub index */
 		__le32 pkt_subidx;
+
+		/* random, used once number, for security packets */
+		__le32 nonce;
 	};
 };
 
-- 
2.34.1


