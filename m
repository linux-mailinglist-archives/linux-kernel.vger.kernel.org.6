Return-Path: <linux-kernel+bounces-241080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D098F9276D9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E5B21C20C18
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0F71AE858;
	Thu,  4 Jul 2024 13:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="esgc8V5l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F55846F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720098438; cv=none; b=Qozc27OZkZ4kkYIpT9+IFYNW4jNxq1eU67QWPwfkKWsIYlQ02qNkipxl1yJkmrASJQjRu3zuHhL6f9mKCowIEHkoLeJ95HGdyEzBLGNFTFmZuc+rkhszmfJdBRQEGkmApA0LknkJDKh85+G09iuAgXkztRtnN//+SS/3erF3fW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720098438; c=relaxed/simple;
	bh=SctyzHhEpvQYkpqbYkYxNspdRRbz4yH9gYPXXglV6Ns=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=L6NnqUyxB7wWbQ4YBWn0KncZNfdHA4bB7XOsMoGjZHbNNU/kMTdY0pjlITfpqUuX+HVEClP6wqZPGM0oPk1pD4ftfVHmObZoJ0dXbzToGYduUgYmhVW4Iyz/f4MHY94iBqkAcpZtNDydkQsI/GTuf2+gYbzF2zHC31MP4gRDxzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=esgc8V5l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720098435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rr5UKMrUGkjJYiUKKYb5e8+Q4alDGlhVFcwMM1toc3Y=;
	b=esgc8V5l0yGby/1iV8ym6rwSiZ9/dcxnX7WJISyv++B1gqXuE1KTpL2xTmKXrChmqsrZNG
	J4Mamh1hFrqpL1XhPUGq7BQ1OBvy8qqE37DtN3Kk06CJs2DYAau4g7H2Y1lwyC/KN6bl69
	6pHisk0v9tCoB61/nGRgN69urB1KIpU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-6by-m3acOlWhCDMlYQ6ldw-1; Thu, 04 Jul 2024 09:07:14 -0400
X-MC-Unique: 6by-m3acOlWhCDMlYQ6ldw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a7293303843so59000966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 06:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720098432; x=1720703232;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rr5UKMrUGkjJYiUKKYb5e8+Q4alDGlhVFcwMM1toc3Y=;
        b=NOc7o5o6YS20dxFh8SvrzZPKZN0AlifHV4v5H2lmuD4s1//sDa871zXtLNICHcLLL0
         kJr2nI37ljmVwmJf+iNrLAZaQ98ctlyAbVu0sWEGszYsFmCwRZBAByCuSfyg5qJk1vTk
         znSxAjE5BuJ0gG76WOR6lt9uiqNQZ4xqsuCBBPYG2il3NKToG65Jeca64Tt8ZbR6IHCV
         6IyLQ+LrLlXK9UYGOz1Knvhqe6Prb/nsvO863aUCx67AevSHOmtPvmyDDwScG/gdIGrO
         3MFkbKcAlDdy9+Z2NoFJOeityWkv2zOH6plisDzM8QOFzE6KkC08iBT+0klOXUgzy725
         eLmQ==
X-Gm-Message-State: AOJu0Yy6XZO28MGYmb9oZ1ZwQJw6m06URgnI8TRzmD7Pzwfh+zki+gYU
	bgUUEHOpkT4AVPENfQX9YsDe9nTvAIJ9g6Fke1DHaWrqdhz6tnUHwPg7bakLlHgmxTR3umKM0DD
	+gO+3L0iygjL+CgyvmxdYH8MtbpSGJcbTTYSW5sOmRJFC/t0pX+ISmmGIJjzufw==
X-Received: by 2002:a17:907:3f1d:b0:a6f:bae6:f56c with SMTP id a640c23a62f3a-a77ba460b68mr119136566b.3.1720098432273;
        Thu, 04 Jul 2024 06:07:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLaQAe30WMvfZKaAWc99XjUUuw3odz3gTOq/73LF5X0dy2EwygPq+G0nwt2hNVYycpwy9afg==
X-Received: by 2002:a17:907:3f1d:b0:a6f:bae6:f56c with SMTP id a640c23a62f3a-a77ba460b68mr119134666b.3.1720098431820;
        Thu, 04 Jul 2024 06:07:11 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab065187sm599306866b.139.2024.07.04.06.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 06:07:11 -0700 (PDT)
Message-ID: <acea1e0e-995c-4aae-aefd-e8fc11d20d80@redhat.com>
Date: Thu, 4 Jul 2024 15:07:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.10-5
From: Hans de Goede <hdegoede@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Armin Wolf <W_Armin@gmx.de>
References: <1cf4578a-3499-47e2-85de-03887de1f05f@redhat.com>
Content-Language: en-US, nl
In-Reply-To: <1cf4578a-3499-47e2-85de-03887de1f05f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/4/24 3:05 PM, Hans de Goede wrote:
> Hi Linus,
> 
> Here is (hopefully) the last platform-drivers-x86 fixes pull-request
> for 6.10.
> 
> This contains a single fix for a regression in toshiba_acpi introduced
> in 6.10-rc1.
> 
> Highlights:
>  -  Fix lg-laptop driver not working with 2024 LG laptop models
>  -  Add missing MODULE_DESCRIPTION() macros to various modules
>  -  nvsw-sn2201: Add check for platform_device_add_resources

Ugh, these highlights are from the previous platform-drivers-x86-v6.10-4
pull-request and I forgot to delete them, please ignore.

Regards,
 
Hans




> The following changes since commit 7add1ee34692aabd146b86a8e88abad843ed6659:
> 
>   platform/x86: add missing MODULE_DESCRIPTION() macros (2024-06-24 13:33:20 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.10-5
> 
> for you to fetch changes up to e527a6127223b644e0a27b44f4b16e16eb6c7f0a:
> 
>   platform/x86: toshiba_acpi: Fix quickstart quirk handling (2024-07-02 16:01:45 +0200)
> 
> ----------------------------------------------------------------
> platform-drivers-x86 for v6.10-5
> 
> Highlights:
>  -  Fix regression in toshiba_acpi introduced in 6.10-rc1
> 
> The following is an automated git shortlog grouped by driver:
> 
> toshiba_acpi:
>  -  Fix quickstart quirk handling
> 
> ----------------------------------------------------------------
> Armin Wolf (1):
>       platform/x86: toshiba_acpi: Fix quickstart quirk handling
> 
>  drivers/platform/x86/toshiba_acpi.c | 31 ++++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 13 deletions(-)
> 


