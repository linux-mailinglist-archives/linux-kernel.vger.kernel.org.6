Return-Path: <linux-kernel+bounces-229669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E5E91729B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 22:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5B54B21FDD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A1817D883;
	Tue, 25 Jun 2024 20:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxSr6+9H"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB42817C7DF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 20:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719348104; cv=none; b=ueyt8dl+nOP/eDki2In2etUwfAsUpaN0aVx0UNgcfXWQqxoUoGN82VLJG4plqCfZ2U5WRylAnpYWtVeitdJn/wcZ6lyu5RjOoIezCf8zKAwMTkQSsPbNftlxYgqHWKQpBmbP/tKty2WU00kCh7sqUTUIC6MtI89t1K2wDKdYivE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719348104; c=relaxed/simple;
	bh=v4bIIXMSSC0LaXZqyDX6rTDcuqrMuULpKD9l4Xlfw2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I3qaEAfAFJ6fRUzeoI11kpBCfaSQ2b62aL8DurCZeTbjg6kVIxVhP5bkTKS4b20/WU5JP1Bh/INKcttoOtsT5MlcICAbnxsKPjSjTRT6xKswOH5pPkjGeILqHOWhTfyc3+uM+Do0BkIwulbTw1Avvrxz8ck9/RjsCJaqI2GYNmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxSr6+9H; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4218e647d62so5148665e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719348101; x=1719952901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I/9KE0BK0ee2qg6LCrOG48n+PXoynes4UpdD40xRo2s=;
        b=NxSr6+9HKUEFpekpm2EemvTN6E/tgFyqBbgV6jvwCip13oiPkHl84Gmz80McKIueuq
         UiEA8g5jAkCTVXmRKV2mmSyqBVd+PUR293Cx8dC1QY4ZEQhOYV66PyFhbYy6OIdljwyF
         KEF5MhT4ykmCQj0N5+NJEZicQnLgynhnxaR4bL9wirBEIwnURaTDgCaK810QLDLqBpc0
         xOkraEeeJOWwT1HXyri2qoyihuBHB5mFzfuseTG1K9touIqWiA7+7sqEXVEijzXZoxHn
         ldIznTUK6wnJgDLVT4VM4+HO8zYQHSY2E8JEFtNn5HbokAf206tUGJ04q2X0IRhfljuf
         WaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719348101; x=1719952901;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I/9KE0BK0ee2qg6LCrOG48n+PXoynes4UpdD40xRo2s=;
        b=qhYlpjD9HldRWiLZwCN9Zrrzp7v/oYvTI/wwbMF6qkWAI3BqYdrhX9pnq5PpNs/Nmp
         xoM5pyDXoqgfoDtepcxkYrBsS7Rycf32DgmaihyDfc2AZ8M2LEvinUJ3vGMC7bMww+ye
         UA3Q5SFstPWTSVKhlPt0uq+i6NXux973FRZJSImuEu+KV0zBcjhxwgVr4hKrmvrEVS9d
         mhwhUoBEBFob0sTqBBxMaxWNVwo/Q2LEIpXHGs4a9J0bZylk51lcA0e3KmbooGsNp8RZ
         8QsCnuWPAuScpGtFP4r3WSV07gsplfn+DNOR3SKvyo33aH3bYcZFyfRf4DziSaGwtLIh
         u+6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5heAobitK1rL+hY31i118Nii3/gEySW8yyz+th3CC92V7aJTMkv5t6HRm3jb1MOfjolmnN5gwMc6WsnbjCcupS5q10Y1GemjIfG3x
X-Gm-Message-State: AOJu0Yzz1bE/OC2oDdU4KmQwvv8KxaFQHYu1j3DXKoRwKlwYec+YvtiW
	6yaJGqzsZ6PKq4UI1ZkZ7PwLiuNdY4B87pXnSZ1dyGrmdZSZDzP+kI1YLg==
X-Google-Smtp-Source: AGHT+IHOqxNKCJ8QakIaa6HNPUZRURWVbtfQaLA0Jy9yfw3+xWjqYZUBYRNbRPxAOYsIk2fGWsTHlg==
X-Received: by 2002:a05:600c:860f:b0:424:892e:4c4e with SMTP id 5b1f17b1804b1-424892e4f49mr73041675e9.1.1719348100971;
        Tue, 25 Jun 2024 13:41:40 -0700 (PDT)
Received: from [192.168.0.103] (p57935a9b.dip0.t-ipconnect.de. [87.147.90.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c82519bdsm622985e9.13.2024.06.25.13.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 13:41:40 -0700 (PDT)
Message-ID: <eb6adf15-d56b-4a23-8833-b9340081614f@gmail.com>
Date: Tue, 25 Jun 2024 22:41:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Staging: rtl8192e: rtllib_rx: fixed alignment
To: Yusef Aslam <yuzi54780@outlook.com>, greg-kh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <CWLP265MB6516C4904E979DB10F00F9F8FDD52@CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <CWLP265MB6516C4904E979DB10F00F9F8FDD52@CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/24 17:25, Yusef Aslam wrote:
> ixed alignment.From 3acc0622bca28c1a00696e7abd7c305ca5ad1f72 Mon Sep 17 00:00:00 2001
> From: Yusef Aslam<YUZi54780@outlook.com>
> Date: Tue, 25 Jun 2024 15:03:08 +0100
> Subject: [PATCH] Staging: rtl8192e: rtllib_rx: fixed alignment
> 
> Fixed alignment.
> 
> Signed-off-by: Yusef Aslam<YUZi54780@outlook.com>
> ---
>   drivers/staging/rtl8192e/rtllib_rx.c | 98 ++++++++++++++--------------
>   1 file changed, 49 insertions(+), 49 deletions(-)

Hi Yusef,

I cannot apply your patch.

Please check against which git repo you develop.

git remote show origin
* remote origin
   Fetch URL: 
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
...
git branch -a
my branch: staging-testing

Thanks

Bye Philipp

