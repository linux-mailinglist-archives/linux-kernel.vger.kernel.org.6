Return-Path: <linux-kernel+bounces-251024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C67992FFEB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 19:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE9101C20C4C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41DC176ADF;
	Fri, 12 Jul 2024 17:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="w5cZG0Dp";
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="0evCQ1wb"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25F743AA9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720806116; cv=none; b=VfWy4JgNVs7bTW8PT7rYK5v9zsYoHnXZigxih7K1w9sJuLqxxDg5QHEJty7qomuoKS8onqRhF+ZJ5RRL1GpuHftiWlUltMZQXMZXF90dcDPdLAr+/l3NYwhM388YKeoUeTTw9Nd3itpe1LgK8UJJWidOEKnRhJ5X1JnfoDzo2vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720806116; c=relaxed/simple;
	bh=iIEQHyI+TXMW7DAkLVqLEtRI5rmuYOxbENf9/9JAH98=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=m6uS2FVLxe4qVp6AWxfbuZiLKl5XJNkaJaL0hJ4xGjMsH88yWFpNZEVdpnkAtuzoE+rscw8QMjiJv3qNt9p8Ps4s3hHI35Nwyfh+eyvxPp+9Mm/x8Taqaw6OEaWCcxOI0ehtmEh6vkbUglgmYj6wIvaGeBDvo9nmYtpk8YC0Jwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=w5cZG0Dp; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=0evCQ1wb; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A16820A97;
	Fri, 12 Jul 2024 13:41:48 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:message-id:mime-version:content-type; s=sasl; bh=
	iIEQHyI+TXMW7DAkLVqLEtRI5rmuYOxbENf9/9JAH98=; b=w5cZG0DpTPXbxw8d
	LxTI4+g8mXZeDuF6+DLtYiIz2sTkdyuAQKVeVpT6hOtk3GT4F/bOcpR2tXbvdTlw
	yOuzOX7/Z6jCpNgNzv5mb6p/encHUC7RjMX3P51Sbq6XoQSdojh7xlsQUnNvKZA6
	Fc2rwiJugMIolGfq1lpqVCs5b+Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2219320A95;
	Fri, 12 Jul 2024 13:41:48 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2016-12.pbsmtp; bh=iIEQHyI+TXMW7DAkLVqLEtRI5rmuYOxbENf9/9JAH98=;
 b=0evCQ1wbzffABDOIC88Z+X8ADprrt2JEfSJP45w/rpY5xAdu3OU3ibeOzX/00gR7ED6Putkk3KHcqftk+6ne0fPgF113Ea16o8xXq9XbwJXEW7mUslP6AkmAVpwn8TbDHTXF/o7DPleRxhtklsZ3OeQg1fD0nfmDl8YiV8mYeDY=
Received: from yoda.fluxnic.net (unknown [184.162.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 959C220A94;
	Fri, 12 Jul 2024 13:41:47 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 7FC7CD48E35;
	Fri, 12 Jul 2024 13:41:46 -0400 (EDT)
Date: Fri, 12 Jul 2024 13:41:46 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Andrew Morton <akpm@linux-foundation.org>
cc: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, 
    linux-kernel@vger.kernel.org
Subject: [PATCH] mul_u64_u64_div_u64: avoid undefined shift value
Message-ID: <7rrs9pn1-n266-3013-9q6n-1osp8r8s0rrn@syhkavp.arg>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID:
 033B29A0-4076-11EF-B317-965B910A682E-78420484!pb-smtp2.pobox.com

From: Nicolas Pitre <npitre@baylibre.com>

Shifting a value to its type's size or beyond is undefined. This may 
happen if the product of a * b is not more than 64 bits despite
ilog2(a) + ilog2(b) being 63 and c having no trailing 0 bits.
We end up with shift=0 and n_lo >> shift | (n_hi << (64 - shift).
Take care of that case and add such case to the test module.

Using __builtin_ctzll() with 0 is also undefined so take care of that
case too.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202407121652.69e657c5-oliver.sang@intel.com
---

Andrew: up to you to fold this in the original or queue it as is.

diff --git a/lib/math/div64.c b/lib/math/div64.c
index b7fc752463..5faa29208b 100644
--- a/lib/math/div64.c
+++ b/lib/math/div64.c
@@ -212,11 +212,18 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
 
 #endif
 
+	/* make sure c is not zero, trigger exception otherwise */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wdiv-by-zero"
+	if (unlikely(c == 0))
+		return 1/0;
+#pragma GCC diagnostic pop
+
 	int shift = __builtin_ctzll(c);
 
 	/* try reducing the fraction in case the dividend becomes <= 64 bits */
 	if ((n_hi >> shift) == 0) {
-		u64 n = (n_lo >> shift) | (n_hi << (64 - shift));
+		u64 n = shift ? (n_lo >> shift) | (n_hi << (64 - shift)) : n_lo;
 
 		return div64_u64(n, c >> shift);
 		/*
diff --git a/lib/math/test_mul_u64_u64_div_u64.c b/lib/math/test_mul_u64_u64_div_u64.c
index a25640d349..58d058de4e 100644
--- a/lib/math/test_mul_u64_u64_div_u64.c
+++ b/lib/math/test_mul_u64_u64_div_u64.c
@@ -23,6 +23,7 @@ static test_params test_values[] = {
 {        0x1ffffffff,        0x1ffffffff,                0x4, 0xffffffff00000000 },
 { 0xffff000000000000, 0xffff000000000000, 0xffff000000000001, 0xfffeffffffffffff },
 { 0x3333333333333333, 0x3333333333333333, 0x5555555555555555, 0x1eb851eb851eb851 },
+{ 0x7fffffffffffffff,                0x2,                0x3, 0x5555555555555554 },
 { 0xffffffffffffffff,                0x2, 0x8000000000000000,                0x3 },
 { 0xffffffffffffffff,                0x2, 0xc000000000000000,                0x2 },
 { 0xffffffffffffffff, 0x4000000000000004, 0x8000000000000000, 0x8000000000000007 },

