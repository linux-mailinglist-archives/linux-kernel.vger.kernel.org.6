Return-Path: <linux-kernel+bounces-208677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3831902802
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19FE31C220F2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C5214B96C;
	Mon, 10 Jun 2024 17:50:50 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552EB143742
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718041849; cv=none; b=XF8crI6qlxpJxBVgd0DP8rjXGhjXZ01+QS4kUhhBuJMGBlNTo0Qj7JvyVESu81DLqqjtWijFdgmXnjTsxlb3XANeI/4vi4OB7bcxhs3MiLw3nMEQjcT1V9LKerUGc1ogi5Hwm5S26zst1HuaaV0VazbjlDZ3x4bGEdX4Nyk+Ps0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718041849; c=relaxed/simple;
	bh=ruWNEcf0BDSZHErPpwcsr9VitpsVDWtnotTNfWKkD1U=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OUvX7ta4F7ARdUIDF30/1vQ2v1uEoQvKjLlnw1/wh4XgekTSFE0PoFoiHtBOVIC0B1QPzSi8bjmSzsRMWtQm6ELljvMOUvFlqstSEYGhxN3hSGXpi/TsN1a0qEvrjnRfsC2yFyBGGms1va86H6+pPCUfgLXPy/VdKc+iAS4bUiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (178.176.78.79) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 10 Jun
 2024 20:50:36 +0300
Subject: Re: [PATCH] udf: balloc: prevent integer overflow in
 udf_bitmap_free_blocks()
To: Roman Smirnov <r.smirnov@omp.ru>, Jan Kara <jack@suse.com>,
	<linux-kernel@vger.kernel.org>
CC: <lvc-project@linuxtesting.org>
References: <20240610072523.12002-1-r.smirnov@omp.ru>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <4ca63af4-df02-32e6-3531-1e5df154c13e@omp.ru>
Date: Mon, 10 Jun 2024 20:50:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240610072523.12002-1-r.smirnov@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 06/10/2024 17:37:56
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 185843 [Jun 10 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 20 0.3.20
 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_phishing_log_reg_60_70}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.78.79 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: {rdns complete}
X-KSE-AntiSpam-Info: {fromrtbl complete}
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.78.79
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=none header.from=omp.ru;spf=none
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/10/2024 17:41:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/10/2024 2:11:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 6/10/24 10:25 AM, Roman Smirnov wrote:

> An overflow may occur if the function is called with the last
> block and an offset greater than zero. It is necessary to add
> a check to avoid this.
> 
> Found by Linux Verification Center (linuxtesting.org) with Svace.
> 
> Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
> ---
>  fs/udf/balloc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
> index ab3ffc355949..cd83bbc7d890 100644
> --- a/fs/udf/balloc.c
> +++ b/fs/udf/balloc.c
> @@ -151,6 +151,13 @@ static void udf_bitmap_free_blocks(struct super_block *sb,
>  	block = bloc->logicalBlockNum + offset +
>  		(sizeof(struct spaceBitmapDesc) << 3);

   Hm, I can't say I understand this code well... Is the block variable here
counted in blocks or bytes?

>  

   As I've already said, we hardly need an empty line here -- just
don't add an empty line after your *if*...

> +	if (block < offset + (sizeof(struct spaceBitmapDesc) << 3)) {

   Thinking about this again, this addition may overflow 32 bits as well,
so it's better to compare block with bloc->logicalBlockNum...

[...]

MBR, Sergey

