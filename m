Return-Path: <linux-kernel+bounces-283283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F3294EF8E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54AF52841F1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79356181B87;
	Mon, 12 Aug 2024 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K92HdXbg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A61181337
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723472996; cv=none; b=OwhVEfPwW4BpHp/KjPKNSUfFEfNirg+QfN33wt53r9SvIriD7U2WnDYzipOSey6c4pXK+PPgw/eJn/8expMZScAKYCLzWz+mn4kFjcS93EAMFPJP6v4wCdgasT/jsIQCgZ0jdXZspkCZPU+vjuH/c9YX8p26kvP5MtaxfvqR6eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723472996; c=relaxed/simple;
	bh=id+cinWoh0HX1vNZVJENoaAqLpfhtEodxd9YXluVEIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F4MZs1gmisxMpDgG+JPl3U/U9KNk9hEQ0Z4ggIJ/ogKgptD2sVIKj0MAzdRx0zayAS6+FfO6UwvpYG4O0gI7p8coh9ldO/q+zsuNrAGOsEOfJJNnKsSYB2mwowbfx4we2sKVE4w5NEGPPcUby8Z7Gwc+k17HKK8aesjwcusEXHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K92HdXbg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723472993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nowmtH7b9dRQxR0SqMGGItLP2W74cRVJT97tMEoitUk=;
	b=K92HdXbgvl14MzTaFM8rhqt4PfeWygjze9PuTJ7rrSsswR1QbnSVnefxwECW3OxLWLNydS
	vUG+EdeNGRcZGrdLEMSEj+5kyhcKtGRU4XbZ8LJPxkRj0pQl1WVcrKIgjMwVWAF5F9Rkz4
	ZbfYne5zHQ8O8S+GmtghbUU4fdCYrJ8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-uhWHHIJaN2Knep1u-9Mk4g-1; Mon, 12 Aug 2024 10:29:52 -0400
X-MC-Unique: uhWHHIJaN2Knep1u-9Mk4g-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a7aa26f342cso349317566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 07:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723472991; x=1724077791;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nowmtH7b9dRQxR0SqMGGItLP2W74cRVJT97tMEoitUk=;
        b=GtB4xdoaCt/nXZaraNpUSevZQQrX2pSTl7VUy11sh025FIt9Uk9FUOAs/3TpPrpAUO
         1syJvL12X8Wa4XF+fqNXLfA/h5LDSFvN0mNzSDe5ubEQkaK1Ao1aS9nKgFbY+holKzS6
         F7gM/ALV5/NHRj5S55jJNLUgX54n0FOqsFOGy6kC8m1fYRlMiBiDb7L7HRnTsULEwiq7
         d3m19s8LknUKwIvDI933vcr6TgCa35fKA8QPTAETkK4IMMc2QkzU4RZCC7iSgBDHXkXW
         T5046tY17PDrMRgYEWvv92qxeA64HmnENVW2K0p8l/4fKzLKs16ZJ8wpmnDm57df9qux
         NsOA==
X-Forwarded-Encrypted: i=1; AJvYcCXMbdjj5JElK0UW2Af2PzQuGpfuvMhgHs2Rf4m3CGc0yICOcezgtb6dWOFFS1Xnewe3PtdbgSzq5UHfIo74+XLHZSyvH6gkYnhCMH6c
X-Gm-Message-State: AOJu0YxiCFVQhXH6Wm6Z6blPT1/UEP5UWPkLn+g8oVt4Jij+V+f5NNiH
	sOvUClp4SiDOZ7CoSVHaQ5P9UoWh5ou8/sA0CiSJxhGxTSPH92FL3ccJH8eZMdbsat/cW9bbUDG
	MoLePFVbtQq1S4N0/9OYdgPk32F6KsiNDE7pX2BP9+YAfQVrW3i/os5WGQQTI2qCSXuUsQw==
X-Received: by 2002:a17:906:6a0a:b0:a7d:edb2:220f with SMTP id a640c23a62f3a-a80ed2d617amr32927866b.59.1723472991051;
        Mon, 12 Aug 2024 07:29:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3ce01ffkOj4R4jJIKBNnGjeGJxL000i2dwMze7FlQ3NqttbVoJYHDOL/8zlsGcsJx7f/kRA==
X-Received: by 2002:a17:906:6a0a:b0:a7d:edb2:220f with SMTP id a640c23a62f3a-a80ed2d617amr32925666b.59.1723472990474;
        Mon, 12 Aug 2024 07:29:50 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb2421b3sm234785666b.194.2024.08.12.07.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 07:29:50 -0700 (PDT)
Message-ID: <3c1fad80-e0c2-4bc2-bcd5-4409ed1f0c4c@redhat.com>
Date: Mon, 12 Aug 2024 16:29:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] platform: x86: Use backlight power constants
To: Thomas Zimmermann <tzimmermann@suse.de>, ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240731125220.1147348-1-tzimmermann@suse.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240731125220.1147348-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/31/24 2:50 PM, Thomas Zimmermann wrote:
> Commit a1cacb8a8e70 ("backlight: Add BACKLIGHT_POWER_ constants for
> power states") introduced dedicated constants for backlight power states.
> Convert X86 platform drivers to the new constants.
> 
> The new constants replace the fbdev constants. This is part of a larger
> effort to make kernel subsystems more independent from fbdev code and
> headers.
> 
> Thomas Zimmermann (10):
>   platform/x86: acer-wmi:  Use backlight power constants
>   platform/x86: asus-laptop: Use backlight power constants
>   platform/x86: asus-nb-wmi: Use backlight power constants
>   platform/x86: asus-wmi: Use backlight power constants
>   platform/x86: eeepc-laptop: Use backlight power constants
>   platform/x86: eeepc-wmi: Use backlight power constants
>   platform/x86: fujitsu-laptop: Use backlight power constants
>   platform/x86: ideapad-laptop: Use backlight power constants
>   platform/x86: oaktrail: Use backlight power constants
>   platform/x86: samsung-laptop: Use backlight power constants

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans





>  drivers/platform/x86/acer-wmi.c       |  3 +--
>  drivers/platform/x86/asus-laptop.c    |  3 +--
>  drivers/platform/x86/asus-nb-wmi.c    |  4 ++--
>  drivers/platform/x86/asus-wmi.c       | 17 ++++++++---------
>  drivers/platform/x86/eeepc-laptop.c   |  3 +--
>  drivers/platform/x86/eeepc-wmi.c      |  4 ++--
>  drivers/platform/x86/fujitsu-laptop.c |  9 ++++-----
>  drivers/platform/x86/ideapad-laptop.c |  7 +++----
>  drivers/platform/x86/intel/oaktrail.c |  3 +--
>  drivers/platform/x86/samsung-laptop.c |  5 ++---
>  10 files changed, 25 insertions(+), 33 deletions(-)
> 


