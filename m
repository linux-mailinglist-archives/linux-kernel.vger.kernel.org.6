Return-Path: <linux-kernel+bounces-300036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6320795DDF7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 15:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8EDF2830BA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 13:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B626D16BE1E;
	Sat, 24 Aug 2024 13:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWzLagzr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4954D36AF5
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 13:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724504497; cv=none; b=JpZj9uMpA61maSPHLgv9TWImV4GHvjur1iW/aUDHipjXeYJ4+72pDqB6NuEdWquWpMAvLpPHBOgOOuTS89zMS7iA38JLCjsDUh525eZf7k+Qp1LcPd5BrbdHC56kWkzFDb0/mqDDlKR9HQ3JTlWxLwm2MgO8Vgm/A4sMcU0g4w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724504497; c=relaxed/simple;
	bh=txq7DO81bdpkm3hwLQ7WHxXwThBlQ1xOCo1W6LasbYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l/hSc2vOyNWb1VsPxf5te04/wIe63BLFKLAltA9dtQi9kh8L9b9CCTcy6ZnO3dp3GX+ubM1ZwQAMz8FJQQgT8p1vFvh+exEScO32ITlakAJaYlv0XDGFREcWhL5JwIlo1xPYUbVterYD56kiMbS1qN9vofmm5XUn288/ArvLA1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWzLagzr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724504494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3FmGV9S+PKzy5WFR+E3I+u/SEWt+C3olz4p/lxi1sdQ=;
	b=XWzLagzrSISic7ZQRx9OfKu/kvtLdvztqTmhaSqtfDJTFuNYnVuxUKO003nk3BW8C58F86
	p2vAMof0kmh7GCl0H52pUJ6wncOYZjvKA56RycGndhkkNuazfU+hl6gkVhQm008X8xExcB
	GOSKtAFame4XF1kSKZcKSXv2AvFToDk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-ODn0tfMWNvK7DE8owOBhHA-1; Sat, 24 Aug 2024 09:01:32 -0400
X-MC-Unique: ODn0tfMWNvK7DE8owOBhHA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a867bc4f3c4so504246166b.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 06:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724504491; x=1725109291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3FmGV9S+PKzy5WFR+E3I+u/SEWt+C3olz4p/lxi1sdQ=;
        b=mMNDv+qXcHJ/jd/sAdZBnxj0CzMWVYzs8l2sgmpS8aKypXFBCu2y6cf2eagBxKGJLp
         Bc08s4jz53atyDrGxhkvxpMyiX0qxC8Y+bR/ETPSKoaxtYmwEl8tfPRhiYskcqRZwCaU
         8WnTAfUkXMt+MwEwKgww01OPfxy2n3OktvLYwOUidhkDkNqCxB8Z/6zcGcU/Ztgkv7x2
         YVT/hW6PuishWWSaq5l0lY6lTLC0HZVEFoe44AGIIYGyU027CCMNaKVu9JqadF9Z5EX2
         6DovijFMwKMRlaKxBwROc34ghAMlDmJG9wKjIa8beQpPtKg0ZdE3bhn2zqfPJ0FQi7IZ
         qbjA==
X-Forwarded-Encrypted: i=1; AJvYcCXKyLmJ/3+ZC/mGFouB4JjvcTT2kuZ2+eS/2ngRhHOVd6NkTf5S6FgfwmjKp7zI0VyKUovzOLpVVHI2FUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOq2ox0uYDb9baSu1U9MbvZQRp7+QIxDv7tM8PJUnsswKp2Vq3
	XndJJCjhAJE/+mwUs8J0A5/j1SnB+8oaKYMLKpOCJD48c9q4SzjfurgiQDoZj3QAUaTzxaNdM3+
	GVadjc+CZxkVJv/FcDnCFpdAOkb++h2+2Qo1tuIapQ19S2T4zMj9l49qH1DXqG7BBO3NN+g==
X-Received: by 2002:a17:906:c104:b0:a6f:5609:954f with SMTP id a640c23a62f3a-a86a2f5b717mr457304066b.12.1724504491363;
        Sat, 24 Aug 2024 06:01:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIlvjwfMDr+3ljghp15zPa9PqNiFkpbLpFR5kJ3s1umBFTgioTVRXj5KR0gyqDekiG4WMxEA==
X-Received: by 2002:a17:906:c104:b0:a6f:5609:954f with SMTP id a640c23a62f3a-a86a2f5b717mr457298466b.12.1724504490308;
        Sat, 24 Aug 2024 06:01:30 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f220561sm397568766b.37.2024.08.24.06.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Aug 2024 06:01:29 -0700 (PDT)
Message-ID: <ee22ddd6-0edd-4168-b435-8b422990f24a@redhat.com>
Date: Sat, 24 Aug 2024 15:01:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] platform/x86/intel/ifs: Fix SBAF title underline
 length
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Jithu Joseph <jithu.joseph@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>, Tony Luck <tony.luck@intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shankar Ravi V <ravi.v.shankar@intel.com>
References: <20240823184337.2923179-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240823184337.2923179-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/23/24 8:43 PM, Kuppuswamy Sathyanarayanan wrote:
> In commit # 0a3e4e94d137 ("platform/x86/intel/ifs: Add SBAF test image
> loading support"), the documentation for "Structural Based Functional
> Test at Field (SBAF)" had an incomplete underline. This resulted in the
> following build warning:
> 
> Documentation/arch/x86/ifs:2: drivers/platform/x86/intel/ifs/ifs.h:131: WARNING: Title underline too short.
> 
> Fix it by extending the dotted lines to match the length of the title.
> 
> Fixes: 0a3e4e94d137 ("platform/x86/intel/ifs: Add SBAF test image loading support")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/lkml/20240820134354.2aec355d@canb.auug.org.au/T/#u
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
>  drivers/platform/x86/intel/ifs/ifs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
> index b261be46bce8..5c3c0dfa1bf8 100644
> --- a/drivers/platform/x86/intel/ifs/ifs.h
> +++ b/drivers/platform/x86/intel/ifs/ifs.h
> @@ -129,7 +129,7 @@
>   *
>   *
>   * Structural Based Functional Test at Field (SBAF):
> - * ------------------------------------------------
> + * -------------------------------------------------
>   *
>   * SBAF is a new type of testing that provides comprehensive core test
>   * coverage complementing Scan at Field (SAF) testing. SBAF mimics the


