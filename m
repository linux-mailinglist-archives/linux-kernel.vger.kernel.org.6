Return-Path: <linux-kernel+bounces-311034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E6E96842A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41DF1B24EB7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8046113C9DE;
	Mon,  2 Sep 2024 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DuNOvwJM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B54313C9C0
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271828; cv=none; b=q7KF+Z3sQ8mQhFbllnP4tppvCd8Nn+K1IahLSzgkfZc48UJPpQA15RQzp1YnyPRhtWg/n8vR7ty7XOJ/EqXIZvqOgj2N6LPZ6d9tAPGgu8v+HHPaRUz2xOz7w2x77Hz8dpogFhhcvNAk3JxFEbrebrYKIcIyaFcKMItZqAGgOZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271828; c=relaxed/simple;
	bh=CJfBp+zz9O8U9TodfKkkb1LMYA7hqNM0ZKFm/w+kJw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GvLaQgXZj2x5TYrliFwFs6TjVfJQlaKXFUmd7sF8LswglUbtU5T9CKgjtq9VKVStfot07T0MgI/kx7zrZfM/r2mvedOkFgdPcnZZo6ilsAUyr/kX65zucFyvxR3Dhg4T+y1ZwlQZ81zEp5SfL2PZmXbVwE2N65wyEhEmsWGWUaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DuNOvwJM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725271826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zbcesK30dFCAjKEHF6Iech8QUJGNsrD1K+Bsbth5WGA=;
	b=DuNOvwJMx9q50nUhZnvGa7Kx6OpXsRmcv8hKW2BQOHZgM5Y+LoMOJkxYp+emDHGNc+0bTn
	IkmaYUVTcabeaRZloBrBCoASOjACfsRfy4yQyx5MCZtHCwAIDfgjz5khQHzNDDp1/pvm1g
	Mrg/DQdHXPsiED58asrRu8CwJofjTYo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-Vcbt0pEHMuK_EpYuXPlpSA-1; Mon, 02 Sep 2024 06:10:24 -0400
X-MC-Unique: Vcbt0pEHMuK_EpYuXPlpSA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5334efaf344so4724042e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725271823; x=1725876623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zbcesK30dFCAjKEHF6Iech8QUJGNsrD1K+Bsbth5WGA=;
        b=XkhaVYkCXU1ZrAcuI01B/Z5Ny4x8ia/4I+u3J7OEH4TuLIZW1/H0zBKiykBxNN/GQx
         EyWL2be/WVEnhe9nYqsiaE2GNYFLqNLOHS1MBbeazGmc332fqgayVZWrtF0xHnFV5KZO
         qbfER8ryWKAa0XVe7G9jl2VY95ml+xuo0oEcWH1wwY5YKkR7E5l+TYL8R1jgOteV6t9c
         z2DRYMVd58GJjTVyzeOdb15DpqynNU2s8m4Oo7PgeF3Sm80eKyzok2oVA3ME6XYrtbPj
         uGFV7zhT+0zMLaNdqUYM4oU6Sw61hG8LyXeegmpfNP7C+p1tuEXtiwifMqc+NwtK+59K
         EN7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVybS3Qu8dd0JVzMtEn+M/3LUhonzQ1cHtvwm8rp3wD7orwm7pQaIfPB7URisu+RIn9DK0MZUMT5YZueHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp8AI6Wdjz0dtwdIag2U1YVBEJqHl8SOYEuHIcr9kklS78ccsv
	EiiIJNLbNlopk54ZEAuJaQRih1lAj1to/unYnVbh6uqE5CTUyznbb1Q+bjTFc50LXjjPCvQNjTN
	nMR++IlCiMJ9gJSgIrnkGPvodVq65ZAR6em6tPe7130pqHGnuszMgEQkWJp6MNg==
X-Received: by 2002:a05:6512:1088:b0:533:482f:afbe with SMTP id 2adb3069b0e04-53546b23dfemr6932472e87.24.1725271823250;
        Mon, 02 Sep 2024 03:10:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKM4RT19+f2nGX8fLMo4BLPojDh8vT2rKLAiyfS6RWsdsrTL0I9CqEd31GLPnQavcUL93/SQ==
X-Received: by 2002:a05:6512:1088:b0:533:482f:afbe with SMTP id 2adb3069b0e04-53546b23dfemr6932433e87.24.1725271822625;
        Mon, 02 Sep 2024 03:10:22 -0700 (PDT)
Received: from [192.168.171.203] ([109.38.145.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989196a86sm537216166b.127.2024.09.02.03.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 03:10:22 -0700 (PDT)
Message-ID: <d6724490-1f43-4bbd-a80f-575aa31af47f@redhat.com>
Date: Mon, 2 Sep 2024 12:10:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: atomisp: Fix trailing statement in
 ia_css_de.host.c
To: Kathara Sasikumar <katharasasikumar007@gmail.com>
Cc: ~lkcamp/patches@lists.sr.ht, mchehab@kernel.org,
 sakari.ailus@linux.intel.com, gregkh@linuxfoundation.org,
 linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, helen.koike@collabora.com
References: <20240730082725.2524-1-katharasasikumar007@gmail.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240730082725.2524-1-katharasasikumar007@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/30/24 10:27 AM, Kathara Sasikumar wrote:
> Fix checkpatch diagostic of Error : Trailing statements should be on the
> next line
> 
> Signed-off-by: Kathara Sasikumar <katharasasikumar007@gmail.com>

Thank you for your patch(es).

I have merged this/these in my media-atomisp branch:
https://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git/log/?h=media-atomisp

And this/these will be included in my next pull-request to
Mauro (to media subsystem maintainer)

Regards,

Hans


> ---
> Hi,  
> 
> This is my first patch for the kernel. 
> Big thanks to Helen Koike for the guidance 
> at her Debconf24 workshop.
> 
> Thank you,
> Kathara
>  .../media/atomisp/pci/isp/kernels/de/de_1.0/ia_css_de.host.c   | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/isp/kernels/de/de_1.0/ia_css_de.host.c b/drivers/staging/media/atomisp/pci/isp/kernels/de/de_1.0/ia_css_de.host.c
> index 25e3f0822..e66faeda3 100644
> --- a/drivers/staging/media/atomisp/pci/isp/kernels/de/de_1.0/ia_css_de.host.c
> +++ b/drivers/staging/media/atomisp/pci/isp/kernels/de/de_1.0/ia_css_de.host.c
> @@ -47,7 +47,8 @@ ia_css_de_dump(
>      const struct sh_css_isp_de_params *de,
>      unsigned int level)
>  {
> -	if (!de) return;
> +	if (!de)
> +		return;
>  	ia_css_debug_dtrace(level, "Demosaic:\n");
>  	ia_css_debug_dtrace(level, "\t%-32s = %d\n",
>  			    "de_pixelnoise", de->pixelnoise);


