Return-Path: <linux-kernel+bounces-296688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B9295ADD1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DDEDB22909
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B54113C3D3;
	Thu, 22 Aug 2024 06:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="w7nmEjcd"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD75313C682
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308954; cv=none; b=OV2yW0FA1OuFZp1ucRgmZS9LGnfY/k6MUNUgbEO/5dZZKptVfiNH8sjKs1KeEDfadFG0QuLp6JWxrlmfg7izVMX/H6XIpWwJS1M3GTl3amSzr8XAjQoyNKyj9rVsrFN5fi/iSmgWLtNYXIpMxFJgMsUpPyPaBazs8ObNIahzG1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308954; c=relaxed/simple;
	bh=XbEWD+SZscEVzUqSA9JTq094eECxMz/BNNSMHZzRRQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QNJT4dzuy1i53SGHbFbx4RZTWfMaK6CDpX7v9nbozSAMgbAQxU3WpBEYNH83cI4IwXVAOAtp+BqolGu41/MStUvWwyYkzJBXWY4aGz31zHGaVEcPMeDJGqMwRh+Nz6PU40CKJ3NVgOKA6JQiboVGaKZgC2fIhVZ6a7a1aLQMrCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=w7nmEjcd; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724308945; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/TEjJg1I0GY/zm8x44TBeZAab8V/IW5s160lNw1qqcU=;
	b=w7nmEjcd6TBUufigGgEFaEfPTEAXERiBU536V/iAGXtM/sALD6LI6j5OQdHEpZmAp/Ok1EFPm7mB3GuamebDgQARweI7PpB3MYvEhv7Lt6lCNJIX+huGLlvR2RAn0K2LkHCQ1wouKpt76LUxz/r3r6781k2+l/+J3xdUP4g1ADg=
Received: from 30.221.130.46(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDOEXYB_1724308943)
          by smtp.aliyun-inc.com;
          Thu, 22 Aug 2024 14:42:24 +0800
Message-ID: <517ca52f-7886-4e05-a977-59094892422f@linux.alibaba.com>
Date: Thu, 22 Aug 2024 14:42:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Prevent entering an infinite loop when i is 0
To: liujinbao1 <jinbaoliu365@gmail.com>, xiang@kernel.org
Cc: chao@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, liujinbao1 <liujinbao1@xiaomi.com>
References: <20240822062749.4012080-1-jinbaoliu365@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240822062749.4012080-1-jinbaoliu365@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2024/8/22 14:27, liujinbao1 wrote:
> From: liujinbao1 <liujinbao1@xiaomi.com>
> 
> When i=0 and err is not equal to 0,
> the while(-1) loop will enter into an
> infinite loop. This patch avoids this issue.

Missing your Signed-off-by here.

> ---
>   fs/erofs/decompressor.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index c2253b6a5416..1b2b8cc7911c 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -539,6 +539,8 @@ int __init z_erofs_init_decompressor(void)
>   	for (i = 0; i < Z_EROFS_COMPRESSION_MAX; ++i) {
>   		err = z_erofs_decomp[i] ? z_erofs_decomp[i]->init() : 0;
>   		if (err) {
> +			if (!i)
> +				return err;
>   			while (--i)
>   				if (z_erofs_decomp[i])
>   					z_erofs_decomp[i]->exit();


Thanks for catching this, how about the following diff (space-demaged).

If it looks good to you, could you please send another version?

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index c2253b6a5416..c9b2bc1309d2 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -534,18 +534,16 @@ int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)

  int __init z_erofs_init_decompressor(void)
  {
-       int i, err;
+       int i, err = 0;

         for (i = 0; i < Z_EROFS_COMPRESSION_MAX; ++i) {
                 err = z_erofs_decomp[i] ? z_erofs_decomp[i]->init() : 0;
-               if (err) {
+               if (err && i)
                         while (--i)
                                 if (z_erofs_decomp[i])
                                         z_erofs_decomp[i]->exit();
-                       return err;
-               }
         }
-       return 0;
+       return err;
  }

