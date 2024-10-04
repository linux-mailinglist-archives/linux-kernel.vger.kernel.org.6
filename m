Return-Path: <linux-kernel+bounces-349855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A453C98FC45
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 04:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F1B51F22017
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 02:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188741BF24;
	Fri,  4 Oct 2024 02:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCw2pAoC"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D465528FD
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 02:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728008391; cv=none; b=HJqXlYSg+YkxDWw7iqqK1xBWuXTPAT5KWoHg/wbwcIdHVXAYdsPzmzWKtUsS3g9Jw3K4gYpZ8S6ypOTlldoEkivrdglyU4+fSDbHdPsIJ/esdzNiI3zOhRHCmGJdryi7LPXJcBN7QJ1sB1RQjxLCvd3nDPpMeQV18XxafIYLjzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728008391; c=relaxed/simple;
	bh=4Kpa3DwSuusZ/ojSRABiA3m3vD/yFFaWn/vC3z7JZzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DkiQVabCO6cmHmSi2PjR9ScNuE0ntQP4p4snOptUPJrJwlE2LY8vAa5W0TsxK86alJ5DJfsowafcLa0+iA8Pt1/vjQBVDFYPcMWB7Ld+Q4+hicS+UapdZkqkJEvLf9feoW5/uyy/VjsfkXVuUREgdI2ILDgtc6EEm+u+rD1Zwsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCw2pAoC; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fac187eef2so21503581fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 19:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728008388; x=1728613188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Kpa3DwSuusZ/ojSRABiA3m3vD/yFFaWn/vC3z7JZzQ=;
        b=CCw2pAoCrstr7dSz5z3QaxMh6UnIm5uKRIJQX3PlUAQBtz2+yQVC1xvFaLmGFAfkKa
         TyV1L6d5oYsvQQpqPxngeApz0IK46AW9KawqOszx27X7KHFLqV8D6PlK9ejkl43vz0z4
         xjTrBjyan9Udj6cKsrz3n6t3mW1P6+PhPFX/SitOBPFQ/PK+t7wujBfOvgnaalFR8fPs
         G5uTJ+r9DaO7Lery3CGIyqXU5sVIfJ3tRhlHuZ73b+ODlc2gW+rmXuebyxwuxfHDHjE4
         rRCnEcRyl/qIBhzLZuOqJFIzomg9LEp0nlf9qEvTCq01by8brq9tGSOIfh+hZbik219i
         BRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728008388; x=1728613188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Kpa3DwSuusZ/ojSRABiA3m3vD/yFFaWn/vC3z7JZzQ=;
        b=O4cy4r8kJDeVznk66aF3Q1S+43bxsmVAzvSC7Vw7/ptgwddt5qq/IKFb295q5iHBTM
         LmU974AcJs5K0qw3h1qs1rHjkuYTmOxtMnJA2ytZYRHvQMjUaiYcem3f9pyWYiunialB
         rc/XLjITFRn16A83U4Xg2uGeSV3vsKGOSBfmLrps8iTsJaCiZIl5mOaOVn+jFBhQo+E6
         C26SIk+iDkfc91+wiB/Id38uKFLaLeVYLtxgg/lMvVJWM/FlZaV850LJijtEUg3HXzwE
         xKJDgtYcqy3CsDmm1ztAGsmxq46dZ7MGkwBHNO6b7XLrkruuAoPiXl8zmrIjJkFMfBe7
         N0fA==
X-Forwarded-Encrypted: i=1; AJvYcCUCZhzF8HcSXxdlysPIeg2+/HHwoikyAlqUrnTpLfIOpotxtaedDUPGLKg3+Ypn+8p+4UC9iXvinc30kww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8BajWaxlzBwpTQ5skzAzrMZosFjUETXo1OpX+FDrC4gRnmUOn
	SIAIcVyGgR8nlaj5Dj4Njt04/OXtVOroSoyIoOkJNAZ6VRnuut/jDL0Tqs7NRf3j4coz5gTpL5C
	wJJJiSviRENWiyAMbYRI/sx6uWjE=
X-Google-Smtp-Source: AGHT+IHF4VPBKIS+sDYmzIH9bctmUXNB3P/PpWHCO+5NhQWj31HI3wo19MO+IB2pjH3uouNm3DUaP1bpq5XK+eSitd0=
X-Received: by 2002:a2e:809:0:b0:2fa:de13:5c18 with SMTP id
 38308e7fff4ca-2faf3da5c06mr4200651fa.42.1728008387530; Thu, 03 Oct 2024
 19:19:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003211720.1339468-1-CFSworks@gmail.com> <697604f4-ea38-4cfd-a4a8-3a346d4735db@broadcom.com>
In-Reply-To: <697604f4-ea38-4cfd-a4a8-3a346d4735db@broadcom.com>
From: Sam Edwards <cfsworks@gmail.com>
Date: Thu, 3 Oct 2024 19:19:36 -0700
Message-ID: <CAH5Ym4gTtRTAn=rn8Hb1jctcCjuMurLNXjHSA2kQLbfRSDaQnA@mail.gmail.com>
Subject: Re: [PATCH] phy: usb: fix Broadcom driver table indexing error
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Justin Chen <justin.chen@broadcom.com>, Al Cooper <alcooperx@gmail.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 3:47=E2=80=AFPM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> On 10/3/24 14:17, Sam Edwards wrote:
> > The Broadcom USB PHY driver contains a lookup table
> > (`reg_bits_map_tables`) to resolve register bitmaps unique to certain
> > versions of the USB PHY as found in various Broadcom chip families.
> > Historically, this table was just kept carefully in sync with the
> > "selector" enum every time the latter changed to ensure consistency.
> > However, a recent commit (see 'fixes' tag) introduced two new
> > enumerators but did not adjust the array for BCM4908, thus breaking the
> > xHCI controller (and boot process) on this platform and revealing the
> > fragility of this approach.
> >
> > Since these arrays are a little sparse (many elements are zero) and the
> > position of the array elements is significant only insofar as they agre=
e
> > with the enumerators, designated initializers are a better fit than
> > positional initializers here. Convert this table accordingly, fixing th=
e
> > boot-time crash on BCM4908 in the process.
> >
> > Fixes: 4536fe9640b6 ("phy: usb: suppress OC condition for 7439b2")
> > Signed-off-by: Sam Edwards <CFSworks@gmail.com>

Hi Florian,

>
> Thanks a bunch for the fix, good catch! Sorry to ask you this, but since
> this is intended to be backported to stable trees at some point, would
> you mind breaking this up in two commits:
>
> - one which is easy to review and audit and which adjusts the BCM4908 ent=
ry
> - another one which converts to using designated index constants?

Not a problem at all! I'd much rather address feedback like this
myself so I can practice the proper formatting than have you take care
of it. I'll send a split-up v2 in a moment. :)

Kind regards,
Sam

>
> Thanks!
> --
> Florian

