Return-Path: <linux-kernel+bounces-180777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B196C8C72F1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E27E01C22610
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032581411CB;
	Thu, 16 May 2024 08:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YrtLsCNT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E617BEAD7
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715848543; cv=none; b=XWkeWdVZ3Bv5Jbe4dP+K9GtI++qF5vTQ7dnZjY+TG5TAuxVZhyI0kyIoT92IQpAmlyeazjfbyTZQ8qcKscTNnUFIVVT2yX3/Dm5yB7/wMwGp7DcySkv/6YbBgwLVRMOAFuq0xRlC8TBJu4CmUBbidTuzpTv3URt8l454yr1PVNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715848543; c=relaxed/simple;
	bh=oo8O8Dcaaijl0P4hmnJdYe/yUNgFhAJcyi9f3JA3zPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=co86v95Rfpx+Yjz2sa/oBFg6bQ8a7Fhv1GAxGJZuRtYTQDlpMbgSixdVKOev1NaotKc3WzhlgoMkP82U7wifNP31Hm3XDInMSntDLGJdveJwZCboaLrCqiFKs0poRtwRmdg715Yw/Y1ndJ4higH7Q1G4QGg2TuCmHmZSfnOAgRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YrtLsCNT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715848540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SYmuujxXBhD2mn7on4bQ5dzfou146JwBEZ+r/yhSuTg=;
	b=YrtLsCNTX3Bh3paCyrY98KmlaGp/d4FIA/J3Nvmqh56C9uBP4vP1gGIfslDLJHb+WQO6EU
	cc8HGVgLtMh8RtFKQug9FJGqR+GCAg4EGFYGNhqJztE4fdhJlINrd+eMxlwrMmMbWrl+rR
	HS2U0MrP5xfPg7JPrcELMJSbzie7CXs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-T9asFGBSN5a_qYD235zGaQ-1; Thu, 16 May 2024 04:35:30 -0400
X-MC-Unique: T9asFGBSN5a_qYD235zGaQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52395bc1813so1453451e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 01:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715848529; x=1716453329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SYmuujxXBhD2mn7on4bQ5dzfou146JwBEZ+r/yhSuTg=;
        b=bd9O2PSwVjdzLJs+0VaZhFugnnF+z5ES3mEMyJ9eTkHBCnf69fHYDjlAvumxr+qN6W
         wYfOAiQeeRPfhWkIe6NoOK58lLSNjn49S1YHH2p5pqpdzilB0rw4XYPunD0xQQYnDSLj
         htNGs6hUP+ReukPAEkl4FjN6MYKBIm9iaMjUMxk/1rM7UlmIxn3is56lFStIoc+qug/7
         WfYFuS2gEHChBg00zaFdB9mABu8PJ3kyzIq/gfPM2BEouJ+RWEj3oJSp2O51YGvhiMhn
         hE/3oTkx/znMXErm3nr3EdSCVTDXYJgCilH4y/g9OgC/cx0aPtPSRdKTW0GRuyCZdRqC
         1RWw==
X-Gm-Message-State: AOJu0Yy+EzkGDZLIua/VHld6EeMXO5noziEj64skh1YjxKy50nr+OmqR
	uF/v61647LySo1Wvwbjayq+apcgol0qyN97ro9i76VesiNTLZIM6uzG6rgUrKI2NQEFVyV94rSa
	ZnSzBVBA073ttYUTQVl2ke9bWF2f+J1/VtpyVCEU2MNudSjenVaOKS3yBQZLTFQ==
X-Received: by 2002:a05:6512:158d:b0:519:5df9:d945 with SMTP id 2adb3069b0e04-5220fb77429mr16542555e87.4.1715848529103;
        Thu, 16 May 2024 01:35:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHj3vDyFOlnPaeCzyl328j8BfErkTQsUgK6I5x9aUnU3vXkenCsOHvyVEAgMrpq3mhh9Pl7lA==
X-Received: by 2002:a05:6512:158d:b0:519:5df9:d945 with SMTP id 2adb3069b0e04-5220fb77429mr16542526e87.4.1715848528671;
        Thu, 16 May 2024 01:35:28 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bed72bbsm10232486a12.57.2024.05.16.01.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 01:35:28 -0700 (PDT)
Message-ID: <5161bd95-d51e-49cc-bcbd-523fbb747e4b@redhat.com>
Date: Thu, 16 May 2024 10:35:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] ACPI: EC: Install EC address space handler at the
 namespace root
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <w_armin@gmx.de>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <12437901.O9o76ZdvQC@kreacher>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <12437901.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5/15/24 9:39 PM, Rafael J. Wysocki wrote:
> Hi Everyone,
> 
> This is an update of
> 
> https://lore.kernel.org/linux-acpi/5787281.DvuYhMxLoT@kreacher/
> 
> which was a follow up for the discussion in:
> 
> https://lore.kernel.org/linux-acpi/CAJZ5v0hiXdv08PRcop7oSYqgr_g5rwzRTj7HgdNCCGjXeV44zA@mail.gmail.com/T/#t
> 
> Patch [1/2] has been updated to avoid possible issues related to
> systems with defective platform firmware and patch [2/2] is a resend
> with a couple of tags added.

Thanks, the series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

I assume you are going to send this in as a fix for 6.10 ?

In that case feel free to merge both patches through the
linux-pm tree.

Regards,

Hans




