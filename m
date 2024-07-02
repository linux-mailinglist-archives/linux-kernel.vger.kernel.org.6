Return-Path: <linux-kernel+bounces-238073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAE39242F7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7871F23017
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C9C1BC096;
	Tue,  2 Jul 2024 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cozWUnlm"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFA926AE4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719935812; cv=none; b=HXLrzSYWXifEFedyITORYshruLq1nZh+A37UjYiMsmRCU/+21QziCbr0Mmm4YmeYPA08NzCYVsl7MRyCSDqHq1uvrreMbRGQ2c8QshEHHKUSTi6XldA84dbmU1YNe2qbQKQdnhlSs66TUEg8AHl8nCY3vZIqlLggYFLDZNu25Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719935812; c=relaxed/simple;
	bh=8ner41gRskw+GSfgxISqqxmCp4VWSYH/4KdQPpuLGM0=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=JJFQrjSwr/qac0Rj8aCfoA/eOhhY0OwnvBx+IsregrCyoUkvTg0Y7/13HzILdTDzSgG7RMQS8bP18qBkxRBvynra8qsm3zVKTaqZEaDOl5IQ4MNLt99lYvGtZrGxMIbwJmLZeoRdQRy6yuBVwhhcrBWOlXqCpNuRoZ1EB7fgf3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cozWUnlm; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b5db7936b3so2574526d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 08:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1719935809; x=1720540609; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FB8UHDOaIKLrgIWEE8g4mg51WR8c0nOJoFegB46Qoig=;
        b=cozWUnlmfWxoQ4IxgusiFt3R70S1Q5Q1L5rX1VNTvO2ckMWFW+SrWmJILBcizGo7yi
         UaD7sbtTaGxIkOPC+AMzcRuBZuRRqaPhrllVoKODDuQGmAZyuQxvlnNSI2A0tdMvFeVi
         HErL97dxR3z34ThGYBTeEUhRExQUzGX8p1PlxA7AMrm1f9wXd4F17vOCVEdesHKrHg3K
         E8CL5eOx241hTcxzLcxAz5HN5x1PoETA9ym/aWleTpVWrYcZEh7qwhQFYWcj4yC7odzm
         SsC/fNhVoVo8gKT7QhwAhIOHGgIOtjwmXSNjrvUNGdlRVlbMwkvSQHu8VreI3yhjG76O
         L3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719935809; x=1720540609;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FB8UHDOaIKLrgIWEE8g4mg51WR8c0nOJoFegB46Qoig=;
        b=QVO2h55Z01uNwbquGS2SL0J+AfxgPDT5IAuFr/V3Ksmjpjo4qsbwIXs0fY+JgvUgI2
         jTVp8+R18OEYUeEuBTOKuDtAacU33fe9cWkjP4dFpnhR5kFbLRQ5p5IMduZ17F2I9gDm
         2NUoYLuaBb+KP3BtsCEhH2MGVhXCACxyxyafvm7XukO33K0ImOr+ZF60Eb8Cd+wBSGA8
         oaLEJsbpJaRdWhO39vcl5sotZijsEkV3kubp0Yf6Ez8xPr8KTXnmB+5EsPfhVbLFNLv3
         nWhKSC14qr6Lnli4wjBh6YHF3oX2EeOZRA05vpEiv6XDcLdQH+TbXMkX597daX1Cfdp+
         v86g==
X-Forwarded-Encrypted: i=1; AJvYcCUT+PlWUZQ0zoAoY6jaTtRCcDs3JaR7Mg1HAjNoevYh9R3YIpq6zJ50hCPDB8FY+rxCyr4h1rKZhyvvLwxJlV+8PiCCq1Pt34rSrWOd
X-Gm-Message-State: AOJu0YxT525+ec9YbBa+vSFAh/sN4lXjlWd3qD8LZsMV7VDkvXfGokh1
	MPCPf0DvxgbAv6pVD9E3U6yEXcBnX7Cg7k96UWWODVnydCZncUmS10TjE6QPZg==
X-Google-Smtp-Source: AGHT+IGjBlHimts/oaQ3Af8rs53H92WprPl+hFmtp0WMpy+HhR/2A4KlwlRph0QRmPf5uT43vkBHAw==
X-Received: by 2002:a05:6214:2422:b0:6b0:763c:e069 with SMTP id 6a1803df08f44-6b5b7098a37mr126280576d6.18.1719935809612;
        Tue, 02 Jul 2024 08:56:49 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5a705bc83sm41082046d6.131.2024.07.02.08.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 08:56:49 -0700 (PDT)
Date: Tue, 02 Jul 2024 11:56:48 -0400
Message-ID: <0c6a49b11150cb088f3be6a8e49fdd02@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Canfeng Guo <guocanfeng@uniontech.com>
Cc: stephen.smalley.work@gmail.com, omosnace@redhat.com, selinux@vger.kernel.org, linux-kernel@vger.kernel.org, Canfeng Guo <guocanfeng@uniontech.com>
Subject: Re: [PATCH] selinux: Streamline type determination in  security_compute_sid
References: <20240629041124.156720-1-guocanfeng@uniontech.com>
In-Reply-To: <20240629041124.156720-1-guocanfeng@uniontech.com>

On Jun 29, 2024 Canfeng Guo <guocanfeng@uniontech.com> wrote:
> 
> Simplifies the logic for determining the security context type in
> security_compute_sid, enhancing readability and efficiency.
> 
> Consolidates default type assignment logic next to type transition
> checks, removing redundancy and improving code flow.
> 
> Signed-off-by: Canfeng Guo <guocanfeng@uniontech.com>
> ---
>  security/selinux/ss/services.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index e33e55384b75..0c07ebf0b1e7 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1804,21 +1804,7 @@ static int security_compute_sid(u32 ssid,
>  			newcontext.role = OBJECT_R_VAL;
>  	}
>  
> -	/* Set the type to default values. */
> -	if (cladatum && cladatum->default_type == DEFAULT_SOURCE) {
> -		newcontext.type = scontext->type;
> -	} else if (cladatum && cladatum->default_type == DEFAULT_TARGET) {
> -		newcontext.type = tcontext->type;
> -	} else {
> -		if ((tclass == policydb->process_class) || sock) {
> -			/* Use the type of process. */
> -			newcontext.type = scontext->type;
> -		} else {
> -			/* Use the type of the related object. */
> -			newcontext.type = tcontext->type;
> -		}
> -	}
> -
> +	/* Set the type. */
>  	/* Look for a type transition/member/change rule. */
>  	avkey.source_type = scontext->type;
>  	avkey.target_type = tcontext->type;
> @@ -1837,9 +1823,23 @@ static int security_compute_sid(u32 ssid,
>  		}
>  	}
>  
> +	/* If a permanent rule is found, use the type from */
> +	/* the type transition/member/change rule. Otherwise, */
> +	/* set the type to its default values. */

In general this patch looks fine with the exception of the comment
block above, you can either follow the multi-line comment used elsewhere
in this source file, example:

 /* line one
    line two
    line three */

... or you can follow the generally accepted style for multi-line
comments in the Linux kernel:

 /* line one
  * line two
  * line three
  */

See the link below for more information:

* https://docs.kernel.org/process/coding-style.html#commenting

>  	if (avnode) {
> -		/* Use the type from the type transition/member/change rule. */
>  		newcontext.type = avnode->datum.u.data;
> +	} else if (cladatum && cladatum->default_type == DEFAULT_SOURCE) {
> +		newcontext.type = scontext->type;
> +	} else if (cladatum && cladatum->default_type == DEFAULT_TARGET) {
> +		newcontext.type = tcontext->type;
> +	} else {
> +		if ((tclass == policydb->process_class) || sock) {
> +			/* Use the type of process. */
> +			newcontext.type = scontext->type;
> +		} else {
> +			/* Use the type of the related object. */
> +			newcontext.type = tcontext->type;
> +		}
>  	}
>  
>  	/* if we have a objname this is a file trans check so check those rules */
> -- 
> 2.20.1

--
paul-moore.com

