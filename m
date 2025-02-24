Return-Path: <linux-kernel+bounces-529117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 416C7A41FE8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA338161B9C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC8423BCF1;
	Mon, 24 Feb 2025 13:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MNU0CSVl"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40141519BB
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402450; cv=none; b=f4gOf6YxSSPt1o4UhJjc37n3MxQOAVbUHjuXyeljk475fnU9f/ld+AhudKj1AVAtip00h+QPM11tRts6/CFXtBJiyy5t0vX/+wA4nxwlqBZP++VBD3XcQoZOMaZ0hqTQ7qgwGgZLXZtaxnZ160aptJH0Dyw3MWJiA0nZTEDRs1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402450; c=relaxed/simple;
	bh=kbvYAHcOMEF3zuu9GAbFxmN+S3FQSLBvwqIO+5P0ugw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ShD2sAF72c82MkEAW9HXrt7/gxm9dWrDw/DQ+EWjM9WRSzzMzpqB8HPNzuUMGUSykhySzyfJUl0IsJ4S7C+YBThhUYGnWRifPWfjSCrGV/DQp3YjjcbinHQYd56XXGZOLzjQTRBCc2XMr8e3wYAqx8Jo2FgvCPaIh5AZz3LVbOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MNU0CSVl; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e589c258663so4731787276.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 05:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740402447; x=1741007247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nc5rKtMTivBSO31lMNwmxphOCn4SiIT76aGPtY1BoCM=;
        b=MNU0CSVldVSW8glqalOhmPi5cQFd2WaZM05tdbDkGFEngv0F/q+aXu6RZ/zjS3OZoJ
         j2IPhJ214s8YYaelqTHB7LV5Vky857y9hYXRIQDKs/WyLnjbAnaxkgr1iePCaB6SmUCz
         WtIqN3RepFjZQ2O1wZ0Ddq31qaKcG4V7QTCfImpldidxjXc+STLn3VDffq5R8T9ojLd5
         TIWnHzoTkf/LWrPjGQ7GJHBPke3kKqgrAnOLjJ3qKMP0EuRvkj9SUscB1grTAjRtRAHZ
         NibpsvqWR2ehkceYBosQye3tRUXzhuER86/fylL8y8+YDHtkE9GfpepmyOSJ9zGPNY0d
         VD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740402447; x=1741007247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nc5rKtMTivBSO31lMNwmxphOCn4SiIT76aGPtY1BoCM=;
        b=ajGHHRF/H7BqQT7q5jrWuyReJ4L7eKZpOlHXnECNfz9v/S1O7/TywiVTW0q+lmsRWO
         FQZIOy6f8DVQb3lRfceReP0dwv7sW4M0wVDt3F8/YJCHUcXUN1i/SfSTRzHqMlT6mSZZ
         4KPiRiEm26Zgy0H+Bn/jgGTUpIdjZaXZZgPoQxD0F50SqccopfaY4BQXbrpZNgajEsGr
         v7q6GaWJRJwKqmKbOf71xmHOIT4dThYZF2Hje+SnAW0fa4PQG0wb2pOB8d9LTSQpU6nA
         YZzax1coB50lYxHuncb1ZES/lM4FsZpSRbGGy3wVRbTm+c98HFxBWW2Qs6vDjxgcQD6B
         aQAw==
X-Forwarded-Encrypted: i=1; AJvYcCV3jOOhdayyDDbPr9Dlu1FK8rC3+BrV5TBDpTm48WIMGJISMDIqQikO/6sVHGBTFuvRWjORbnKgcRtwnFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/fZM+PCG6fu0bVbHJiNhuxxURE79rA5X0YEFqNQq6KkLWXrFO
	ah40oViEC+yHxtGX0CwVknlEfDmwdI6euGfWiRtOgnYRJBkv8NDl2DrCmiqQGL0SEqrZjg3n3R4
	f6G2xYOKDSh6dP/COgJ1vroqmTPT+bLVCLPjp
X-Gm-Gg: ASbGncsQN+keOJV2Co9dJMHPRB7aRegP6ikPLIrcO3rXLoNeltj9GNE/0JJAjEUln9q
	AAWv1PYM6jfFzsHiGnhY/8N+ubxOkA25BgbAp41EhADEthXa1XbslEAgtneZjAZPah6bX87WgHL
	P2Jeattg==
X-Google-Smtp-Source: AGHT+IEV3q7j/GBNYuP6STmsBrXJoXFtqy8DofxgLX/o1rmJQALIJXeF2DGTDQI9siFCB1pmyk0Rymfqne0NWC/QBZU=
X-Received: by 2002:a05:6902:c04:b0:e5d:dda6:d25 with SMTP id
 3f1490d57ef6-e5e2468d860mr7648480276.45.1740402444995; Mon, 24 Feb 2025
 05:07:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224022447.1141413-1-chharry@google.com> <2ab0d1c5-1bfe-4ef3-b23d-fee0ae1d7ad6@molgen.mpg.de>
In-Reply-To: <2ab0d1c5-1bfe-4ef3-b23d-fee0ae1d7ad6@molgen.mpg.de>
From: Hsin-chen Chuang <chharry@google.com>
Date: Mon, 24 Feb 2025 21:06:58 +0800
X-Gm-Features: AWEUYZnd8U_F2uM2IG7tbgS7xAsShwX6094V8UakZbkeRwsajumLDL99ZQaPLnQ
Message-ID: <CADg1FFfBNSZSAV6Ygudmr959X2VsfThZaTMAj_OZ24B0TisDog@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Configure altsetting for USER_CHANNEL
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, 
	gregkh@linuxfoundation.org, chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Ying Hsu <yinghsu@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Mon, Feb 24, 2025 at 4:42=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Hsin-chen,
>
>
> Thank you for your patch.
>
> Am 24.02.25 um 03:24 schrieb Hsin-chen Chuang:
> > From: Hsin-chen Chuang <chharry@chromium.org>
> >
> > Automatically configure the altsetting for USER_CHANNEL when a SCO is
> > connected or disconnected. This adds support for the USER_CHANNEL to
> > transfer SCO data over USB transport.
>
> Should you re-spin, it=E2=80=99d be great if you elaborated a little more=
.
> Especially for the motivation. It=E2=80=99d be also great, if you added h=
ow to
> test this.

Sure and I'll update this to the commit message in the next patch version.

The motivation is to enable the HCI_USER_CHANNEL user to send out SCO
data through USB Bluetooth chips, which is mainly used for
bidirectional audio transfer (voice call).
This was not capable because
- Per Bluetooth Core Spec v5, Vol 4, Part B, 2.1, the corresponding
  alternate setting should be set based on the air mode in order to
  transfer SCO data.
- The Linux Bluetooth HCI_USER_CHANNEL exposes the Bluetooth Host
  Controller Interface to the user space, which is something above the
  USB layer. The user space is not able to configure the USB alt while
  keeping the channel open.

This patch intercepts the specific packets that indicate the air mode
change, and configure the alt setting transparently in btusb.
I tested this patch on ChromeOS devices which are now using the
Android Bluetooth stack built on top of the HCI_USER_CHANNEL. The USB
Bluetooth models could work without a customized kernel.


>
> > Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control =
USB alt setting")
> > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> > ---
> >
> >   drivers/bluetooth/btusb.c | 224 +++++++++++++++++++++++++++++++------=
-
> >   1 file changed, 186 insertions(+), 38 deletions(-)
>
> [=E2=80=A6]
>
>
> Kind regards,
>
> Paul

--
Best Regards,
Hsin-chen

