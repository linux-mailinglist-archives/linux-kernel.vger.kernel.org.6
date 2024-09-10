Return-Path: <linux-kernel+bounces-323431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D6D973D36
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E8121F24E8A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A28519E81F;
	Tue, 10 Sep 2024 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HmNQf6qh"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B62191F96
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985692; cv=none; b=lROcKPduDAN2eFcA7I5M90DatMshZNsi9pES0zBqFD22BUkiyo1QUjJJx8fONhA6LS58cKhzdJas7aLCkZrIQpUKou9je/H8RazMUtRxrOb2XKWcTpvDgjyX0Ej7yqWYsZezWGrN5qrQpbOaOfkF96bmhepH2amiWs27BRA2RTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985692; c=relaxed/simple;
	bh=nc6L1a1kt+M75fOyCymB95iw5s7FW51EBIJetPi+Ga0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P7ni9eURtzcry8G9jqYUSdWQjfrqFCqES/AE44vB0Pwq9M5Vx64B4lXhma48rEcssTcLwunNBF+Roa7OSpcxbQ57TnF24lw4cOtUM/OoiDX1rATjJsVseYtUXRjEX7cgDqCMvotv8oxXQ0UXdbWNqa+nrV6odvmuxSSIlqKveS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HmNQf6qh; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e05a5f21afso379601b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725985689; x=1726590489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Mjmns4x/7EVV+qDU/F3wKaCqU4XFsHHFoqKF9eOnTg=;
        b=HmNQf6qhYuKkotK4QiHEWFFtsbcQoCs1tvJjlyhz/GFExDt/WDKuPbz2lVhhSTRQXG
         RjJ5s7NKD2X344F1QO27imzdIuMllesA7jbpanLdvCnbF/QwVMvPuzLfX52O62gRFCO7
         prCD0bAH6/UhsSnkFr9LsOB7AHYjwbud6zCwNBDQsRk7tUJE/5eBuBXwoXRNpiKh5Dol
         3nThsUnNlFIMhN4oICeUdWS2f4wYKNI2NhZUZMQZ4pBMZj5hGRDR1z3FWUhL7EHKqTwP
         TvShC4ML63GtGQXH9TQ0o8yMN0hqyW/20Wn8LCxnoDzGeCSCe0iH6W7lxqzm1xKryBOK
         z9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725985689; x=1726590489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Mjmns4x/7EVV+qDU/F3wKaCqU4XFsHHFoqKF9eOnTg=;
        b=NYVZ0Mwa3eInR2BoBrdGTvaiJ8bQ7tXeHntQs3FmDTlRtZu1JUihGqHahn/StzCgW5
         RGgKinFYWcRWDeqGn5YbA+Gagj/VDGAkS6A9MNi22V9T0y8W1WXDPZUCpAShbadNX2NF
         7ABpxUkteo62snVr7AoBpg7J1OMTMnBDn2lA55KlvdlnBsauC8VU9nJ2VOdcxy/Lme8i
         +w6Z6WbEtLLFKurjbvHecjyBpGExHT9vVOvAG2q89UObwQ2DaK3q4GGoZj+D9RAWcpYs
         vY4PdIFM6XKcmUiV3n/OOJZbzUJDlHaJm8Mg+UIEP3C3Phgw2q8+9/rsfySnPNsz8iYZ
         AhTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx5P8xuo8GOmrlgsbAC3iTLyF9S1/pJikvYxWyGsd35Icw7XCtCVFDmTC/PurTgC2IJi5EyG9OY/8b6VA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxFRRpahU1oxPzIBtqBgd6egUCunE+rX0ei/1kfNvIK69Ks0lT
	SAvD023i69A76i99gnEbNXbWM3EWZEY3eG+V7NJ81P9xesHyEMdJ0mk1fQZ2Qh/8X2sMmqySsoL
	zALJx0u2fgQXN4uPq6/0AWQKeJt6iParG4K38
X-Google-Smtp-Source: AGHT+IE0rrBpIrEahQs3yVx8XPX2VRZnRoc81Y5f1nO5oAV+NDZyofL2XVOs7O9mS6FIkUpEuqdWE/H7PGb/ao0dswc=
X-Received: by 2002:a05:6808:1586:b0:3e0:817:85e8 with SMTP id
 5614622812f47-3e037a63d68mr6641943b6e.1.1725985689060; Tue, 10 Sep 2024
 09:28:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909-fix_amba-v1-0-4658eed26906@quicinc.com>
 <CAGETcx9X0m3=8PPtVsHp=AAjyCoUZ0-53H5RzVd4HCDtWRS0Fw@mail.gmail.com> <a4cf15fb-bbaa-4ed0-a1d5-c362b7a5c6e2@icloud.com>
In-Reply-To: <a4cf15fb-bbaa-4ed0-a1d5-c362b7a5c6e2@icloud.com>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 10 Sep 2024 09:27:10 -0700
Message-ID: <CAGETcx_YMUXRLye3OUOQ9O4Cw9nqLcVOts0hTMgORuLmQ7tAZw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] amba: bus: Move reading periphid operation from
 amba_match() to amba_probe()
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Isaac Manjarres <isaacmanjarres@google.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 5:17=E2=80=AFAM Zijun Hu <zijun_hu@icloud.com> wrot=
e:
>
> On 2024/9/9 15:24, Saravana Kannan wrote:
> > On Sun, Sep 8, 2024 at 4:38=E2=80=AFPM Zijun Hu <zijun_hu@icloud.com> w=
rote:
> >>
> >> This patch series is to make amba_match(), as bus_type @amba_bustype's
> >> match(), also follow below ideal rule:
> >>
> >> bus_type's match() should only return bool type compatible integer 0 o=
r
> >> 1 ideally since its main operations are lookup and comparison normally=
.
> >>
> >> Which has been followed by match() of all other bus_types in current
> >> kernel tree.
> >
> > The intent or need for this patch series is completely unclear. The
> > code you are moving around was also pretty delicate and hard to get
> > right.
> >
> > Without a much better description for why we need this, I'd like to
> > give this a NACK.
> >
> > Also, patch 3/3 is not at all easy to understand and seems to be doing
> > way more than what the commit message is trying to do.
> >
>
> thanks for your code review.
>
> let me explain the issue here firstly to go on with discussion, will
> correct it by next revision.
>
> amba_match(), as bus_type @amba_bustype's match(), operate hardware to
> read id, may return -EPROBE_DEFER consequently.
>
> this design is not very good and has several disadvantages shown below:
>
> 1) it is not good time to operate hardware in a bus_type's match().
>    hardware is not ready to operate normally in a bus_type's match()
>    as driver_probe_device() shown, there are still many preparations
>    to make hardware to operate after a bus_type's match(), for example,
>    resuming device and its ancestors, ensuring all its suppliers have
>    drivers bound, activating its power domain, ...
>
> 2) it should not operate hardware in a bus_type's match().
>    a bus_type's match() will obviously be triggered frequently, and
> hardware operation is slow normally, it will reduce efficiency for
> device attaching driver if operate hardware in a bus_type's match().
>
>    a bus_type's match() will become not reentry for a device and driver
>    if operating hardware is failed but can't recover initial hardware sta=
te.
>
> 3) for driver_attach(), a bus_type's match() are called without
>    device_lock(dev) firstly, it often causes concurrent issue when
> operate hardware within a bus_type's match(), look at below AMBA related
> fix:
>    Commit: 25af7406df59 ("ARM: 9229/1: amba: Fix use-after-free in
> amba_read_periphid()")
>    which introduce an extra @periphid_lock to fix this issue.
>
> 4) it may not be proper for a bus_type's match() to return -EPROBE_DEFER
> which will stop driver API bus_rescan_devices() from scanning other
> remaining devices, that is not expected as discussed by below thread:
>
> https://lore.kernel.org/all/20240904-bus_match_unlikely-v1-3-122318285261=
@quicinc.com/
>
> 5) amba_match() is the only bus_type's match which breaks below ideal
> rule in current kernel tree:
>    bus_type's match() should only return bool type compatible integer 0
> or 1 ideally since its main operations are lookup and comparison normally=
.

All of this used to happen even if the bus match wasn't doing what
it's doing today. You don't seem to have full context on how amba
devices are added and probed. What you see now is a clean
up/simplification of how things used to work.

Please go read this patch history and git log history for these files
to get more context.

Nack for the entire series. It'll never go in.

-Saravana

>
>
> Our purpose is to solve this issue then enforce the ideal rule mentioned
> in 5).
>
> so we send this patch series to start a topic about how to solve this
> issue (^^).
>
> > -Saravana
> >
>
>

