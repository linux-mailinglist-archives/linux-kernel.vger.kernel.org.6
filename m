Return-Path: <linux-kernel+bounces-510943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 811B6A323E5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CBEA3A7960
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46EC209693;
	Wed, 12 Feb 2025 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W97030vc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601A02AF19
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739357474; cv=none; b=Q8iYI8Kzs4W6ZblU5r60Wkinct57gNsv4ojkRB4gg62fzI0Kr7RcA+nhx08v629OJeubV7TJxEhoxrkc/6dqrFGI1r9WjoEO5aegWw5mtChEoLF2FF8+V7Mw/vCMD+rcUh4wWKPImJTkZ1aZnNkWz2PjobpYoxgnhJ0ocX7ltMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739357474; c=relaxed/simple;
	bh=KlnxEBAxUrkY2A98rI5NO0qXoZMuruaHKYYwrLiJZvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H9cYOAAJlfdinTyuoT7QdLAn7bUPEFYzuEi4vYeFgVoP+x2aoeT+kdCpo3fpIJStx3O5k9tcc6h8GY/rLt2IfJVyvsgVqgOAr79V99KzupaXIxVAkO4Yi4BfYEIIKXSwWDWQceG8lwJfVb099a7xyGPj1gCOojzVVOvxzHZeTVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W97030vc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739357471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+NVWfHrBC3Lh67poyMCVhjWSuRg6nFdzuXOVckKcJ5M=;
	b=W97030vc7r8z9Ipmvj8FlMVfL+BidIEgXCT36ZGpUy8zrleH0Q0CchD2yGBjzzeMGSmYJx
	lRvjHSIorOxwOgszxdisr7Ym+y4KF9F7S/x1N82nRfV8MZXDwrPuheiLYDOF3f0zlHEd1G
	1VWOc1q9CcfUD0UG/gNESW+Ylanky28=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-ZMJynF3aPh6d9IsCBdivCg-1; Wed, 12 Feb 2025 05:51:10 -0500
X-MC-Unique: ZMJynF3aPh6d9IsCBdivCg-1
X-Mimecast-MFC-AGG-ID: ZMJynF3aPh6d9IsCBdivCg
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ab7d2d60e88so209884966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:51:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739357469; x=1739962269;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+NVWfHrBC3Lh67poyMCVhjWSuRg6nFdzuXOVckKcJ5M=;
        b=dalfMOlKOnXgSXVcDHjOBBNd7eNob8TgrlxaERdOhz53ZsHizbQ/iQlz9zqV2RFx1T
         NDCqHgxy+AkEzrvN58WiOy0R4BEyvDmDdf4R1mxsrDvBjdkNxJD7quFc20POgmCsxBOy
         8Uz4B80C9jUX0nDbvbc+tJxsU8iJDRjSeujuNj4WTyZBUYQxVyC0GqdNQ/g4hMmFOa0V
         o6Fz9TkXZTF9s5iUuqaOW/wtgYa/P8lmBI+eTj2qIyFqSWptR90fa28beW8rW/HNFTQG
         c5dAWlkoUllE2zlyVrMQ2AaS7cheqJ0hUajgm9DUyo5di3yLQp8G2O0o6hoMeLDu5CLC
         EBiw==
X-Forwarded-Encrypted: i=1; AJvYcCWtjMH5j8Vi5lAMsYYTAteeRij6l/z9/CWA6nHvBF3rYs6O3B/m8xS/ML84fxTHlEC/97SD+oCZPVEhuIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiZgK5/gtB4dMWPcSnEKDrpS7Bxr/2fxNigHZ7IImWtks98QNJ
	vhOpvTMZ5SKM5XMZDHx+vmDUwZIaxeLKKgfVBbVrBhhteqttdq5nLKx0stEyf98bXanWbpUmGHE
	dyyLaStkRRNEHYqXF5cGCpPWuLTx/4oZvec5f89YF2I7DjL36PYGn5UeTpcj+Nw==
X-Gm-Gg: ASbGncvneDpNHsDuJx1CgAUBGTOVbUERgUby+NvwNrJtS0crqamCxIq/J/zGk1pk2RD
	b5MmCiisoTE+UTeFjpjE0J6lhHAKLmpE9uq5ec/ekzrqRZSIbkE09HWUGVBJtsE0oMUh72w1u67
	5tlBLR0a85nLlBNXmw3+a6FUZGI6te0nENussQS1gYOtJWydr70meWpz3kA8JwPZY6KwC27oBsA
	J/9TzyWrzTUNtLQEhoKQmMRvccyNiW1uNEP1Xw+B/TFJYC/OR5H7mV539QzR5Ayb5+bFDwSgRv2
	DJ9J0ml84iJQQ9Is9cPtWLjGkn+hAUw9o3fVKnbSlZ/zuEoYJCeBE0zYxnOcDrYdshl3Pn/WSvP
	GVEkSDL7UCG+Va6JWbRT8Wn0t7+ykJ6yhrgKy3qyGNL6jqiJeSPluwfo=
X-Received: by 2002:a17:907:720a:b0:ab7:b9b5:60e7 with SMTP id a640c23a62f3a-ab7f347e265mr223616666b.40.1739357468708;
        Wed, 12 Feb 2025 02:51:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHs132jIFP9s0HY3xqKoTb1xOmtPbhJ3uXSXHZ17eVzFXXSL5pSxjUDItBcM4Rtwp/jiCtuA==
X-Received: by 2002:a17:907:720a:b0:ab7:b9b5:60e7 with SMTP id a640c23a62f3a-ab7f347e265mr223613966b.40.1739357468288;
        Wed, 12 Feb 2025 02:51:08 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab794509fcesm996858566b.34.2025.02.12.02.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 02:51:07 -0800 (PST)
Message-ID: <6abc98bd-5ef9-491e-985b-7ed8a848c96e@redhat.com>
Date: Wed, 12 Feb 2025 11:51:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Handheld gaming PC panel orientation quirks
To: Thomas Zimmermann <tzimmermann@suse.de>, John Edwards <uejji@uejji.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Andrew Wyatt <fewtarius@steamfork.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250124204648.56989-2-uejji@uejji.net>
 <b3caa748-2dbd-4911-968f-878fcd118a9b@suse.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <b3caa748-2dbd-4911-968f-878fcd118a9b@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Thomas,

On 11-Feb-25 2:55 PM, Thomas Zimmermann wrote:
> Hi
> 
> Am 24.01.25 um 21:46 schrieb John Edwards:
>> Hello.
>>
>> I am submitting a small number of patches to add panel rotation quirks for
>> a few handheld gaming PCs.  These patches were created by the SteamFork
>> team and are in daily use by us and/or members of our community.
>>
>> The following devices are covered by these patches:
>> 1: AYANEO 2S
>> 2: AYANEO Flip DS, AYANEO Flip KB
>> 3: AYANEO Slide, Antec Core HS
>> 4: GPD Win 2 (with correct DMI strings)
>> 5: OneXPlayer Mini (Intel)
>>
>> Thank you for your consideration and for taking the time to review these
>> patches.
> 
> Did you ever receive any response to this series? If not, then
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

I had the following remark for 3 new entries added in patches 2/5 + 3/5:

"Since this '}' is closing the .matches initializer it should be indented 2 tabs"

With that fixed, you can add my:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

to the entire series.

> for the series. Let me know if you need assistance for getting the patch files merged.

Normally I pickup/merge these panel orientation quirks, but I've been swamped
which is why these have just been sitting on the list.

Thomas, I would appreciate it if you can merge the set into drm-misc-fixes, with
the 3 minor indentation issues fixed.

Regards,

Hans




>> v2:
>> - Minor rewording of commit messages
>> - Include Tested-by tag for Paco Avelar in AYANEO Flip DS/KB patch
>> - Add OneXPlayer Mini (Intel) patch
>>
>> v1:
>> https://lore.kernel.org/dri-devel/20250116155049.39647-2-uejji@uejji.net/
>>
>> Andrew Wyatt (5):
>>    drm: panel-orientation-quirks: Add support for AYANEO 2S
>>    drm: panel-orientation-quirks: Add quirks for AYA NEO Flip DS and KB
>>    drm: panel-orientation-quirks: Add quirk for AYA NEO Slide
>>    drm: panel-orientation-quirks: Add new quirk for GPD Win 2
>>    drm: panel-orientation-quirks: Add quirk for OneXPlayer Mini (Intel)
>>
>>   .../gpu/drm/drm_panel_orientation_quirks.c    | 40 ++++++++++++++++++-
>>   1 file changed, 38 insertions(+), 2 deletions(-)
>>
> 


