Return-Path: <linux-kernel+bounces-513589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27F2A34C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6034B7A2497
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A0F28A2BD;
	Thu, 13 Feb 2025 17:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POwGeouU"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CD620409A;
	Thu, 13 Feb 2025 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739468156; cv=none; b=ADxd3OzlbHwDHrHB9AAZ0hsjuQRMdWWtgYmMGuEAfqM2UhC2CsWjbQhgZxYrKofUohVeZOt8InEEs5tRQ/w4v+oN2pLepHQNjIL+JIyAqlvqOOXc6sOq4Oy+EmfC2El4Aa2jjpf+YIYJpFnRtTjWbMpLy0eTK61pr4DgFZF2Zwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739468156; c=relaxed/simple;
	bh=YQq0NVsq8jz1OjuxiXdAWFkTr+laei83KpjusFxQA8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VAQztjrPKGy0GQX1f51zQ26dEPvFRbGzB2isaB/Ctercn6A2vzz8xXv68l6xA7J8kUBXkVxW017F45A7LJffeRrKd5ogEItzNfAI2ZkfMRbs6fLfGtZcBeDY/isupL3yuOE7dpVaOdUnDz/JtE/5VnWXxUFrwMyJOMSoxdYkyQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POwGeouU; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30762598511so13009111fa.0;
        Thu, 13 Feb 2025 09:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739468152; x=1740072952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qAMpVDOhtGjLWY8rXJglFjJtR265JZ5195CB8+cKFo=;
        b=POwGeouUZeLfxEiLjQBIwVtup2ySCZUbZSa2AdsWsVX3srNT2Vb+KFzCxcp20MeIeQ
         mm52hOGaIN4QpvQkDzc6pbq2QQ9hqzmU6NaPT24WHHnw+z6yGGO8+Qk2Wdef2sTQTs/9
         2zaj9tNlHiEkHTsV31a4wSzjoQr1PAq7C3Mf3ZNHxsFVinveuM5GGOZrYoH8FyVaKSFF
         MMZTmaPyf2XEKsXUGIh6HuaGO8imAdEpJDteKhnLLE5gKeEPQtAXA5Su/NRONE9WXxuj
         /L7t5BOoLC4Ug33O9LtVXGb9L8zmfM5FaA7QSAbrHNcGqQuwt/9s9JeezQ4g4KdPdY8b
         zbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739468152; x=1740072952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qAMpVDOhtGjLWY8rXJglFjJtR265JZ5195CB8+cKFo=;
        b=hdqXY7CfRnRGle6y96RPq8ZC7hUcAJzChQ8ZrACVNMbadNuo6vMejdR196Jlkd/Llc
         aa9k4UW1vDIbHqzZ1PkpJGkx3YdCuWnmvSgVRv1thxYUZ60yWY9hFxXNacd+2oLd6e4D
         L4rDv8pew2JjoLD1vw7s3PK5GJlZMqw1kkcSC6pzqQH7hDv4/Yf1tdYecLZIubi83cdk
         I7dNA9RxOFXkLQRifZPP+U7ZeQgqgAoo2xAr3baYOucCMldnMLjGxE8Q+Ce0w0GZZmz+
         2nBSfgw8AB6KbHO1qDNZ7y79S6KPkT4axUkpd21f/ZhZ7rRjFTDFMgDxJ2hHoHOV65kN
         LAmA==
X-Forwarded-Encrypted: i=1; AJvYcCXlxMOVr4TxTs7DdrRVqTMj8GJsQI9hRXrh6NIPmijLn5K+01hxMLz0zOqCoHeO4HKpbPW22w9V4n8FTRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAmbVKML3+lS54TF7u64BdcJoms65D2UpnjQElsG9Jm7wheZeJ
	/3qMe0Cj0dTxIG+KQYFTSKMpLTLRZSrl0KMZWMuZvkKEAlg8CQ13NRWZfS/TjgTzM6b5xVDEbty
	uKssQyNzv1WqTsWz/T6uS/53D/hw=
X-Gm-Gg: ASbGnctW0negaMtnnJNW/EBLeMHHk41nVGcMoy8h1S3+pdkt0AvVbea5qCUh79PXCD4
	OuKEh19snitxiImwV7S4AdvrsWFRPhCQHByNU/j+1YWSAEsSXHeX7TVlYbvuxeACLOlJ7s97S96
	9BjyafyQJW0C+sst1QgI1Hyufko4pqFQ==
X-Google-Smtp-Source: AGHT+IGY0srE7wji4W9bLp26kLxH0QGCdWUi5EwnHnmRRB8roSRmEHIwTufI5RAZRQ0k86nA9jKtQdN81/gcY/A+yK8=
X-Received: by 2002:a2e:a913:0:b0:308:f6cf:3611 with SMTP id
 38308e7fff4ca-3090dd06b8cmr17279501fa.10.1739468151884; Thu, 13 Feb 2025
 09:35:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207165325.3998-1-pranav.tyagi03@gmail.com>
 <Z6bKR9K16-oYMLFl@archie.me> <CAH4c4jKe7Q-E1LhA0KxOxEjK-gn=JY7e=2GN13X=yutaO8k3Pw@mail.gmail.com>
In-Reply-To: <CAH4c4jKe7Q-E1LhA0KxOxEjK-gn=JY7e=2GN13X=yutaO8k3Pw@mail.gmail.com>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Thu, 13 Feb 2025 23:05:39 +0530
X-Gm-Features: AWEUYZn6qEdgw-FWu9wGm9trUEcco7CIRDetR6lShyMK3GR9NJoIyLrnadYOLAI
Message-ID: <CAH4c4j+kOYMfzO5QOBg+hGe2zt4kN4f7v+mrri-2GMLzYtCPrw@mail.gmail.com>
Subject: Re: [PATCH] vgaarbiter: documentation grammar correction
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Documentation <linux-doc@vger.kernel.org>, 
	Linux DRI Development <dri-devel@lists.freedesktop.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-kernel-mentees@lists.linux.dev, 
	skhan@linuxfoundation.org, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Just a gentle follow-up on this patch. It has been reviewed but hasn't
been applied yet.

Regards
Pranav Tyagi


On Thu, Feb 13, 2025 at 10:54=E2=80=AFPM Pranav Tyagi <pranav.tyagi03@gmail=
.com> wrote:
>
> Hi,
>
> Just a gentle follow-up on this patch. It has been reviewed by Bagas Sanj=
aya but hasn't been applied yet.
>
> Regards,
>
> Pranav Tyagi
>
>
> On Sat, Feb 8, 2025 at 8:36=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.co=
m> wrote:
>>
>> On Fri, Feb 07, 2025 at 10:23:25PM +0530, Pranav Tyagi wrote:
>> > Corrects the following grammatical issues in the VGA Arbiter documenta=
tion:
>> > - Fixes subject-verb agreement by changing "co-exists" to "co-exist"
>> > - Corrects pluralization by changing "server" to "servers"
>> > - Improves sentence structure for clarity
>> >
>>
>> +Cc: DRM folks.
>>
>> > Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
>> > ---
>> >  Documentation/gpu/vgaarbiter.rst | 6 +++---
>> >  1 file changed, 3 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/Documentation/gpu/vgaarbiter.rst b/Documentation/gpu/vgaa=
rbiter.rst
>> > index bde3c0afb059..d1e953712cc2 100644
>> > --- a/Documentation/gpu/vgaarbiter.rst
>> > +++ b/Documentation/gpu/vgaarbiter.rst
>> > @@ -11,9 +11,9 @@ Section 7, Legacy Devices.
>> >
>> >  The Resource Access Control (RAC) module inside the X server [0] exis=
ted for
>> >  the legacy VGA arbitration task (besides other bus management tasks) =
when more
>> > -than one legacy device co-exists on the same machine. But the problem=
 happens
>> > +than one legacy device co-exist on the same machine. But the problem =
happens
>> >  when these devices are trying to be accessed by different userspace c=
lients
>> > -(e.g. two server in parallel). Their address assignments conflict. Mo=
reover,
>> > +(e.g. two servers in parallel). Their address assignments conflict. M=
oreover,
>> >  ideally, being a userspace application, it is not the role of the X s=
erver to
>> >  control bus resources. Therefore an arbitration scheme outside of the=
 X server
>> >  is needed to control the sharing of these resources. This document in=
troduces
>> > @@ -106,7 +106,7 @@ In-kernel interface
>> >  libpciaccess
>> >  ------------
>> >
>> > -To use the vga arbiter char device it was implemented an API inside t=
he
>> > +To use the vga arbiter char device, an API was implemented inside the
>> >  libpciaccess library. One field was added to struct pci_device (each =
device
>> >  on the system)::
>> >
>>
>> The diff looks OK.
>>
>> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
>>
>> --
>> An old man doll... just what I always wanted! - Clara

