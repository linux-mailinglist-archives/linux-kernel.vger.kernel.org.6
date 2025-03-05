Return-Path: <linux-kernel+bounces-546819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 084AAA4FF11
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE9517014A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1D4245032;
	Wed,  5 Mar 2025 12:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QmBPsZUy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC371FCF6D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 12:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741179316; cv=none; b=JaC/tEQVfRZ86YGjg8hvXypN6/om/0Lpo0IitCbhouTpi7qOcp6xFqR5iJNM+QoG0vIB8OnM3015oidAvL1wU95fp0EaymTr1RO4o2tWZbg/+K1hXLpwynjTOlY9AaxhRW8iVbUBSF3DA9rzGlNynB+ijXHOgRBhQRGvyzje2dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741179316; c=relaxed/simple;
	bh=YNboN6HasUd8fdaZmn76+5CG2qlIfABQ284AytGS6lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IC2k5kEXTB87ZQZiWizRpNQO8Eouvwm065Q7QMmjv+ybh+nRwRTEl3Llh68fgqyKBeKRgYdy2ITVGXVY0XGO33YKXb1Sj6AVq6s1fd/p76/m/kY23w0MY6htCJpm94EcnHqu2eotv/+JiGY93oj4t3dkHZ2XjjAYgWehgs3v/yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QmBPsZUy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741179314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R+I52jkpTGKKh5i8x7etc2AkECbsYxHYCuFAnAyZIoQ=;
	b=QmBPsZUy2CxTrRMPSP0NuV5rC4BTcohs/ujq6EWLFrWfLX5eXX5yevEFnhrYYe2EeDIeNF
	SsJ+EQhqNXnYDiBrnUykfXvuiJiq6CfvenX48SncWAZ9UQpobCmB1bU5fHa9lFKmdUpb7Q
	gXjFug2VDZVXFZVGLGY2PNRuipDCVcI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-nW4U7NIFOqmuUGdCtEp6rQ-1; Wed, 05 Mar 2025 07:55:12 -0500
X-MC-Unique: nW4U7NIFOqmuUGdCtEp6rQ-1
X-Mimecast-MFC-AGG-ID: nW4U7NIFOqmuUGdCtEp6rQ_1741179311
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5e550e71d33so4078475a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 04:55:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741179311; x=1741784111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+I52jkpTGKKh5i8x7etc2AkECbsYxHYCuFAnAyZIoQ=;
        b=GgWjJwSLUEhZ2og1gj7ghEAZd9w9FEImkqBgvB8aY5/M5Gq/LalZnilb0si8JYbm7L
         utdeIqziirgyxOF6iX0RwBxh7TkahPRbON2+5pQPQoHW5KXDRmSpHVpNmi2uc+0HfKiZ
         ffQh2GNzdwaxvcep+soZeEbATw+1HQFwJqxRxzLJQTqCfjAEgLQKoS10RECf3YjmRCQh
         kt2U065UL/5s1omC0uHvtxCg2EjDqLJ+IFmjDD9r+2ZDk+gAQckSYK5KO+MGG6NFZ7w3
         QbXc48iSqFBVtElmrfVYmIWlV92+5RwdkOngapJ6ZsXEdgKltfHGMI/iG/oE1oR6t71q
         lOCw==
X-Forwarded-Encrypted: i=1; AJvYcCVEc5rMgLgzZDjrJ1X7B7yyckNSzXBIxSxLlLUaeakNFmwsefvIA/gA/HN3xWkwxkLF/qm5fRkDTjvkE30=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTu7VM3UbK+j5/IbJqCQmVUuHYVO7E7sqstOCD4eKmp2aMro2a
	+aFhBPKaXJU7Yf8fYX5t46pBA3RTlsK9kcuNkurFws68Rw4ajK9GjSszRlqT1PnWgIPCWOLQM48
	RBFbM3IRoUjmvqgIAcvGUJ39pEao71CxqBMAo1RggTkdHW+mfuXf3w3LR6e8wiQ==
X-Gm-Gg: ASbGncsOG5/OTFLrQ9z+NOA4oSCia+FhPe6TdA3Y9ZIQkQH0Q6KvKw2pJXhNrjUHi8C
	g/7WDIFHQ/FdrjrEkykjkNtde/zgxvqpSO/q5XLx0zShGj7fw/xeuN4/+W4TwPQCqFZvuVLqcpg
	SnaNWRmiq/05xXnYm2RSmmJjH22I9wUTFEAlKr/g0M81zMyBh66YSLce/o0X9qaTYsgT4GbCG90
	qHGp7aEu71Awp80BSqLDJ6zpH+gASp50wKMpe1PoHyF799vWs6HudMFCx8rH4zrZkfDc7aezsFG
	GUGFknKhKAPNKsY0vQ0IXyKijLm7GgexTdBwwGC1kTI0+HJAaD8p8IVvGreSq5IfV5+ACkwoCAO
	NFzV9ifXWlm+fclH6YsqJ/SR7fx2Mf0Qg0oPmqHtVcLzjfUUoXbETiHzdSiL+7wF3Yg==
X-Received: by 2002:a05:6402:5109:b0:5e5:2d8c:7fa8 with SMTP id 4fb4d7f45d1cf-5e59f4a48eemr2821281a12.31.1741179311435;
        Wed, 05 Mar 2025 04:55:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNhQ4Yxbj6HpL5AMkaYg0O4lq4C1AslkF+2EMDH6GYW4hEnJ3ulGuOIG+oOC0bGtzW+rS94w==
X-Received: by 2002:a05:6402:5109:b0:5e5:2d8c:7fa8 with SMTP id 4fb4d7f45d1cf-5e59f4a48eemr2821253a12.31.1741179311069;
        Wed, 05 Mar 2025 04:55:11 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3bc80b1sm9739558a12.47.2025.03.05.04.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 04:55:10 -0800 (PST)
Message-ID: <18da2efb-c0c2-4417-8c99-623f6ecb2b21@redhat.com>
Date: Wed, 5 Mar 2025 13:55:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] Input: atkbd - map F21 key to support touchpad
 toggle keys
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Werner Sembach <wse@tuxedocomputers.com>
Cc: mario.limonciello@amd.com, ilpo.jarvinen@linux.intel.com,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250303190442.551961-1-wse@tuxedocomputers.com>
 <Z8f1EzASdCfa2h_7@google.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Z8f1EzASdCfa2h_7@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5-Mar-25 7:54 AM, Dmitry Torokhov wrote:
> Hi Werner,
> 
> On Mon, Mar 03, 2025 at 08:04:34PM +0100, Werner Sembach wrote:
>> In the default xkeyboard-config used by both X11 and wayland touchpad
>> toggle is assigned to F21.
> 
> We have dedicated KEY_TOUCHPAD_TOGGLE that is being used by several
> platform drivers:

Ah right that is a good point.

Werner, we were using F21 in the past because we could not use evdev
keycodes >= 248 (256 - 8 modifier keys) because of Xorg limitations.

But recently the mapping of things like KEY_TOUCHPAD_TOGGLE /
KEY_TOUCHPAD_ON / KEY_TOUCHPAD_OFF to F2x keys has been moved to
xorg-x11-drv-libinput which gets the full range key-codes from
libinput and can then do this mapping before passing the keys
to the X-server.

So it is no longer necessary to use KEY_F21 and even in the past
we used to do the mapping in udev / hwdb rules not in the kernel
in the kernel we've always (with a few exceptions which are my
fault) used KEY_TOUCHPAD_TOGGLE as that is the correct keycode.

Regards,

Hans


