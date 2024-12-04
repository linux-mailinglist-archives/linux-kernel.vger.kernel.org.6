Return-Path: <linux-kernel+bounces-431323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A3A9E3BF5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A227285513
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF611F75A9;
	Wed,  4 Dec 2024 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJvs1OAk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1E91F7590
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320847; cv=none; b=ELUcJ4c77OwvnqE3TD8KRAJGWjefoFmHzkeXZ8sB3vDznr50Bm7ulzRMtWqZvaXdbQcoTCfJ7mgUo+9rSoaRsWtjRD6RrpfStHBa0C9qs5GXF78M6HvjY+pd62ekPKhxvPLGBPCQVVg7/STzI6Q1GQvxlJd/7LZ6Byz8yLVEvOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320847; c=relaxed/simple;
	bh=K5XkhdPpHqBscx9cuL2xc9SfulCNC53nfSWJYshtIgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C1Ibt3lSSf8a4mzTTu9bkyEPfkE7y7KeGGU7oFFLJ7nvm9nYYdQ/EUmSzMQ4M1U34xj35k1IKeUWwcFhqHxzqAmoLI8YbhL2YYZUqmBmj5TOZD4JwuCCTDpx7Tk6oSGqkM+9ql+Df1+SoixZ655FI6fwwQUsoNkZUQYyBeuQjV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AJvs1OAk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733320844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pd0pcYkSUAXYAkPdvS5Z/9VshciCSve8tgQub98YvW4=;
	b=AJvs1OAkSmulOov1wnFwhZFbQIAb3zcYSCdtZrVblRvRXC/Z6ISvyN/eo7kgQ8gI4Q36n+
	D45ADGyFh1hTaIMaxNF7hscVwIozDDaFENNpYLUVSFeuVEvGFyOMxM97dSeubAzcFne6SF
	/UIJwyOIq/QQaqVGk/Zw1cSnfhGcR7M=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-F2JthX6IMyyomNfSEclP-w-1; Wed, 04 Dec 2024 09:00:43 -0500
X-MC-Unique: F2JthX6IMyyomNfSEclP-w-1
X-Mimecast-MFC-AGG-ID: F2JthX6IMyyomNfSEclP-w
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5cfad454c02so4664136a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 06:00:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733320841; x=1733925641;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pd0pcYkSUAXYAkPdvS5Z/9VshciCSve8tgQub98YvW4=;
        b=P57lU1D8pxgrZkpAAkq3RtWGuIMfZVAX+iVOro0eInm/ZHGm63YC+tmjj8aSXIKhC2
         UrEkjgd3uASlUnpaZDVNdBSsOnGrhSUN76xfDSqYXQiaC/5o33Wut3FfJ5Q3v06y/WFp
         Q4599v9ZLKgcOCmC4P0z6almQXAqzmdlgMWwHuIm264W2ZM8wLcaceem46fDUZ8FoFnK
         JVM88xXQ0ft6euxRJYbYeVZBS1P7MOerOtkrR5H8hMtbxtq8dhQRJmjP737H4mB3FLHe
         ol0Oq89YTLHPRzXS+3d7nryRYiYHQ4E+kVELJj8Iz+UpYjnm4mewR5KicjBuWl69RqjS
         FuFA==
X-Gm-Message-State: AOJu0YwMDY4RBeH9gdJntS2geNCcbG52ZTllSC5mQvQ7d8AKDrhWTi+2
	wNS8ViQof1X3cileMeywRN3LcMrxFGuN13MvjPoS4F2g2Z5wTVmvtRQVi1wTSMJ89TVBLqKZe+d
	Wxt9i4BVNQ2F2yZBvOOKvjRdFXUd37LLLiw5d/ZMySrC1rTI5DR7PMTv24rWW7w==
X-Gm-Gg: ASbGncsj16V2uZGkxQYrVwrv89oaiUtAZMs0Xzb++97mG8kZKnhkk9CJ1wMz/48s3fE
	9Gr729uIYOSSGk99yU5vb84MI+u9uxYoFJxKdUVfvjCr+Dl7HRUvIO+w1uGi3WAbgvnjCnAYtPW
	/saluelHVWtaICLHUBS9IPtusFUJA7XiGwnguMI4RPWgcvxIyf5Ah5qWO3IuxTZAEEAOTumwD9i
	pG1T3gGKs4w75zfibxPRkAvY/m501zcFV45c9K7Ghf2GyKCVnYbAemJpS2e51ho4BaZOepdoERd
	g7Pa5s90PfjoyH42HRaLiXsmbtQJ20IAwK9WhJiLO8JFHed98unGsXQvU5bwBAe9f/nL2fWbk63
	FRISqIuHIGQ4yCp+alG7tKAyG
X-Received: by 2002:a05:6402:270c:b0:5d0:d311:dd4 with SMTP id 4fb4d7f45d1cf-5d10cb81b94mr6097514a12.22.1733320840762;
        Wed, 04 Dec 2024 06:00:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeZUJPH3qksYgzj+j2Ik055uUV0znVH3V1OqEMo7YPDSZPvLXpT2JePuXn1yrYMCeFxYxLZA==
X-Received: by 2002:a05:6402:270c:b0:5d0:d311:dd4 with SMTP id 4fb4d7f45d1cf-5d10cb81b94mr6097102a12.22.1733320836460;
        Wed, 04 Dec 2024 06:00:36 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0e75a2315sm3767619a12.39.2024.12.04.06.00.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 06:00:35 -0800 (PST)
Message-ID: <b982d20d-2f34-492e-8910-dfaf3adde552@redhat.com>
Date: Wed, 4 Dec 2024 15:00:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add missing file entries for the USB video
 class driver
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20241117213833.22952-1-laurent.pinchart@ideasonboard.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241117213833.22952-1-laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 17-Nov-24 10:38 PM, Laurent Pinchart wrote:
> The USB video class driver is missing a few F: entries for files related
> to the driver that have been added to the kernel over the years. Add
> them.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f65f00392789..af018330f6fd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24076,7 +24076,11 @@ L:	linux-media@vger.kernel.org
>  S:	Maintained
>  W:	http://www.ideasonboard.org/uvc/
>  T:	git git://linuxtv.org/media_tree.git
> +F:	Documentation/userspace-api/media/drivers/uvcvideo.rst
> +F:	Documentation/userspace-api/media/v4l/metafmt-uvc.rst
> +F:	drivers/media/common/uvc.c
>  F:	drivers/media/usb/uvc/
> +F:	include/linux/usb/uvc.h
>  F:	include/uapi/linux/uvcvideo.h
>  
>  USB WEBCAM GADGET
> 
> base-commit: 5516200c466f92954551406ea641376963c43a92


