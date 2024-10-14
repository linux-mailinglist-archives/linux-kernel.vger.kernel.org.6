Return-Path: <linux-kernel+bounces-363048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5C699BD4A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 03:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF4A31C214B2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 01:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1707134BD;
	Mon, 14 Oct 2024 01:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b6hNeeUa"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33FAF9DA
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728869204; cv=none; b=nm7YBsExT2zDgQLocFVc9DUn/NKhltip9WXrWCxL7T8bjFQws8OY4rZTaLHuk1u6PVRQxg0OxsIBtsdmFjIHMJLFCS2Z5rm+0MQscqDfH4sqKtW72SV2Xms2H7fMfOg10P4sct+MDirdRO3wm7/ah3S+6YnigvdWlMnc5qiAf/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728869204; c=relaxed/simple;
	bh=wGbE5+zdi5Fv7zEAsXsLy+Qkc3iJQ4qPOdngLBOuAtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gAKB8kR2ux148vuSrImoS8WvyHEDKbuzo4xCTWDkxtmi/6MdIqO55QdSu+MwyqyohKU5zGrPVBVaBxAMgi0VOk3p5WKs5snZU7S5AZk/fiUyWZlzomwCtbSMZY+BKMveXpMfaA/mqD5fXnFlLTen6r42QB8dsr8T/e1h+fteDFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b6hNeeUa; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6d8fa4ef-e230-4313-bdca-e51a43db0e27@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728869200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6NvdnnwZo/raDSaO9HQyfJYGI8ca1niI5ok8I9tGboY=;
	b=b6hNeeUacH5mlpDU/zS7UyNYzmh+PBTYSD4eU7KtdDezQBRhszZRukJu06F6tVLLJGM2Sb
	zTWycvGzLUcmaEg/mtkjZ0ZL75FJA5jTPfPQVNItwkYgJn/Bq7EMcY2f9wvCqGY1RAPkWf
	cF3+l2vL6ppKYvdeYMiLkqjXuRs/2Tk=
Date: Mon, 14 Oct 2024 09:26:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bcachefs: Simplify code in bch2_dev_alloc()
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Youling Tang <tangyouling@kylinos.cn>
References: <20241012075902.1320946-1-youling.tang@linux.dev>
 <4iwneao62n6xuniitihvhp7ojvt2pkjtisnrnax7hyzztyktxm@yn4unwrqqjpb>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <4iwneao62n6xuniitihvhp7ojvt2pkjtisnrnax7hyzztyktxm@yn4unwrqqjpb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi, Kent

On 2024/10/13 01:30, Kent Overstreet wrote:

> On Sat, Oct 12, 2024 at 03:59:02PM GMT, Youling Tang wrote:
>> From: Youling Tang <tangyouling@kylinos.cn>
>>
>> - Remove unnecessary variable 'ret'.
>> - Remove unnecessary bch2_dev_free() operations.
>>
>> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> the 'goto err' style is more readable when you're staring at tons of
> code
Well.

But 'ret' is not needed here.
Does not execute bch2_dev_free() if the ca in the err path is NULL,
so it can be removed.
Can be modified as follows if necessary:
-- a/fs/bcachefs/super.c
+++ b/fs/bcachefs/super.c
@@ -1352,7 +1352,6 @@ static int bch2_dev_alloc(struct bch_fs *c, 
unsigned dev_idx)
  {
         struct bch_member member = bch2_sb_member_get(c->disk_sb.sb, 
dev_idx);
         struct bch_dev *ca = NULL;
-       int ret = 0;

         if (bch2_fs_init_fault("dev_alloc"))
                 goto err;
@@ -1364,10 +1363,9 @@ static int bch2_dev_alloc(struct bch_fs *c, 
unsigned dev_idx)
         ca->fs = c;

         bch2_dev_attach(c, ca, dev_idx);
-       return ret;
+       return 0;
  err:
-       if (ca)
-               bch2_dev_free(ca);
         return -BCH_ERR_ENOMEM_dev_alloc;

  }

Thanks,
Youling.

