Return-Path: <linux-kernel+bounces-311039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8370D968438
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DCA3281C85
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B557183CB7;
	Mon,  2 Sep 2024 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fe8m+bT3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16268149C6F
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271850; cv=none; b=YA4uwtZUyJ8t1I6jjuo/naBPwCUabgPoEni/8OpVqL2bDwo3FwTTwTwa5yKOKu6DYgl4fJYczn+93Rsrjycd+Bfgp8guqSBne8IMyamyKr40jPTAr4MK86WaT2M7YXwIDSGsREQaFxtPW8sjmIiQexqCTsu3i48w6kM6dRFQIeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271850; c=relaxed/simple;
	bh=vjEG4yTZwz2x2AHPoS0jcARdsLxSSxZ+JUhFPRRJUIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UPVfq2XN8pT+cOzPGgb2TkmEvMpHL1DJVs8l8p1WE08/tNAJ2I6tJP0TdoJTssR0LxVVrCTew//lmHww6viOZbRtdLtC3mcuGkhN0DyrNYYppTtFOVCDYQPx0yOLjkWtrcmyGOwwrSBnUURVW2zba5UjlbZr7WcqyvWKcKYGASk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fe8m+bT3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725271848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H9RKF9H7s72V4OZfPOTUgjyYaIyw8mcKokBoElqIGAw=;
	b=fe8m+bT30rJT2I+27TytAmsJikIu37VrTtKkCqktbt9HF1GW9V8mg26qUxdSVbbDzEoFGG
	QGScUB3K9OwvBa5kNrs90dQfDfIbURxW4KsvRAEjTYZMvpk3S5lcybHnI81aMJDf1Jh+nr
	vvfHkjZHraMn0gR9NDz7qNC3VkdGFCM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-hNsDgpNdO4eFjeHj6wcHaA-1; Mon, 02 Sep 2024 06:10:46 -0400
X-MC-Unique: hNsDgpNdO4eFjeHj6wcHaA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-53340bcd229so4858319e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725271845; x=1725876645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H9RKF9H7s72V4OZfPOTUgjyYaIyw8mcKokBoElqIGAw=;
        b=shLDpfYJBPDHzlIVq81d3XnNaiZ/HXT3UyN+6T4qthvXtPjkfuCy+txb0RVoAOgL3Y
         1n5vTBZ+LQRsIRkz943lkRKQRotVb5w2FgAZCaSB05dCVHoF0JZ7lTV1VFMPRYr23nRb
         1C62rl5azJkDKlsa636wwZ38MGO5X4eES9awQ/ZogvibUC92EJNcqu86DR9FFqJcrEAz
         SJ6xgkNrpHZFHCcwQbLNmdxTe52FVorCGw/RlFWtsGsuSUyFGEXrJn20D2TdJ1fevGTZ
         g2k07Xvh3wHQetR/OBYDxee3nkJfUULwzHl7zyWalNMoW9ivUK/rd/PkU8eBEIhlsFr2
         de+w==
X-Forwarded-Encrypted: i=1; AJvYcCXxqWkUagyvQDOx5DUe7ublXFqpJHMBbG8Rt53DLO64StaWPHUyKsjo+LLbui45mNI6ZUMMYy0PnB89QGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBAZKwntjjRbA43Za6nK9ytPTMiT8UjmuBnJKmpSYhpQ+s9YlQ
	TPj3RgzYQ7oZZ6YrLAJ90fZK+DgsExlwTIvnDCvmKrfnTCHoTke4tKBjxGMYyyvfjEabmgNjIKS
	Or7lCQ4KjI3cjwUGX2zqjQrVTpTPPkTNfec7A4+/1O9kemUj6oWKwAuEJQq2Mcw==
X-Received: by 2002:a05:6512:b15:b0:52e:976a:b34b with SMTP id 2adb3069b0e04-53546b33aadmr8012011e87.15.1725271845228;
        Mon, 02 Sep 2024 03:10:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYItbefjD4lhCqtpm3GS4ZxCJzNfGCn2KlBrohSSQm0qTa4hwnKBwDrS5pTLOuniFpdKxW/Q==
X-Received: by 2002:a05:6512:b15:b0:52e:976a:b34b with SMTP id 2adb3069b0e04-53546b33aadmr8011985e87.15.1725271844799;
        Mon, 02 Sep 2024 03:10:44 -0700 (PDT)
Received: from [192.168.171.203] ([109.38.145.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feb410sm540035566b.21.2024.09.02.03.10.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 03:10:44 -0700 (PDT)
Message-ID: <389b81a7-a7be-48c0-adc0-40d313a38c5d@redhat.com>
Date: Mon, 2 Sep 2024 12:10:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: atomisp: move trailing statement to next line.
To: Sakirnth Nagarasa <sakirnth@gmail.com>, mchehab@kernel.org,
 sakari.ailus@linux.intel.com, gregkh@linuxfoundation.org,
 linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: ~lkcamp/patches@lists.sr.ht, helen.koike@collabora.com
References: <sakirnth@gmail.com> <20240730084220.38204-1-sakirnth@gmail.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240730084220.38204-1-sakirnth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/30/24 10:42 AM, Sakirnth Nagarasa wrote:
> Fix checkpath error "ERROR: trailing statements should be on next line"
> in ia_css_fpn.host.c:46.
> 
> Signed-off-by: Sakirnth Nagarasa <sakirnth@gmail.com>


Thank you for your patch(es).

I have merged this/these in my media-atomisp branch:
https://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git/log/?h=media-atomisp

And this/these will be included in my next pull-request to
Mauro (to media subsystem maintainer)

Regards,

Hans




> ---
> 
> Hello, this is my first patch to the kernel.
> ---
>  .../atomisp/pci/isp/kernels/fpn/fpn_1.0/ia_css_fpn.host.c      | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/isp/kernels/fpn/fpn_1.0/ia_css_fpn.host.c b/drivers/staging/media/atomisp/pci/isp/kernels/fpn/fpn_1.0/ia_css_fpn.host.c
> index 57b5e11e1..8ccfa99c6 100644
> --- a/drivers/staging/media/atomisp/pci/isp/kernels/fpn/fpn_1.0/ia_css_fpn.host.c
> +++ b/drivers/staging/media/atomisp/pci/isp/kernels/fpn/fpn_1.0/ia_css_fpn.host.c
> @@ -43,7 +43,8 @@ ia_css_fpn_dump(
>      const struct sh_css_isp_fpn_params *fpn,
>      unsigned int level)
>  {
> -	if (!fpn) return;
> +	if (!fpn)
> +		return;
>  	ia_css_debug_dtrace(level, "Fixed Pattern Noise Reduction:\n");
>  	ia_css_debug_dtrace(level, "\t%-32s = %d\n",
>  			    "fpn_shift", fpn->shift);


