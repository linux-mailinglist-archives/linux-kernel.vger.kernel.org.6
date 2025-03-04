Return-Path: <linux-kernel+bounces-545558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611F3A4EE90
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D47E16616C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C180E25F997;
	Tue,  4 Mar 2025 20:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayf9ZlxL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C8825290A;
	Tue,  4 Mar 2025 20:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741120831; cv=none; b=ROF5vqBLxxsASfym6iT/0zSWl11LhToLpKIF5vWdMW0WyooJPOf0qgr/4yd3bIADwh2aLcIU3MbLYV2hWXttjoRUcHHVDQoFNx9pi2sh+dwFs8kaME3bQSlWfHuOFbc1zFdl6dkz/eHxmkHZx7pfPsdFGLa9OkztDWhxh2Ly1M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741120831; c=relaxed/simple;
	bh=uYP7mj7qSPBcCxpr8OPM5qt366XPadgekuwnWrQgxb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qzhfumuaw6kDH135ncI47/D6GYr/bRR7OOIsAXiZI/n4O7AunQ7NMySN5ysy4STyBlVURLKORmHkzRsnKWMnWcOKVu0H30NShAAiOna+9rzK3BgErZD5F1+mMOk3RflYtcD9RQ2aYpRsRaTHcksgYXjTHcER9mW984zSGtY9qLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayf9ZlxL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9B6C4CEEB;
	Tue,  4 Mar 2025 20:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741120830;
	bh=uYP7mj7qSPBcCxpr8OPM5qt366XPadgekuwnWrQgxb0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ayf9ZlxLzvWJz3iEb+2grPf84eQiqHgTsMu1UW3jZcKUOIqyA4TLh3xShr6eOdLcJ
	 0GK2ILttOshvvXKYfqwLUK4fViKZMEFj8XDjkA/WSmzd/80AwW6Y1kC+7XN4L4xJgo
	 zzQ2ha5slVdDhHHo8Op5LpV2PgMtOIu2THelBHfnO5NWqDDi16IkAG7Shku9FmeNzg
	 cbqQsL9kZo4IZ0CEAIPSANVy8KLDmP3u09B74inPtB1F/ISJyhnZVwIayGk98C31nL
	 6tDQJaNVZ/YKHq/rUzmsFGkbfdhb536Epz0ejLK9LcoNDDqToXxYgyUTCkKaXz/mZq
	 W0vjFcj8wOFpQ==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so1128673766b.3;
        Tue, 04 Mar 2025 12:40:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVTLyUKdq9lhkZMSYiGorWa53DRC6dCH9e8vY/IL0fDStyh/d8nsUyVLtAm/cryDS15k/B17HuomYsx@vger.kernel.org, AJvYcCXOM7Iu0k/omg5PCOMog6VsuDxJwkP456c1+SBq2wvF9p7HsWdENSxQdSJoJQJP6YWOcZstRT1eZOrWRal7@vger.kernel.org
X-Gm-Message-State: AOJu0YwVAvjrjkIVUOxEgxy2IBAGdwzaTvWweZiB4sn2fix+31O+SAzo
	77Pmx9depFJKZPc5L5E7ObSA1g9w2RJgN4vxTcdo78N0gSPLEQWXFI8XATyRQtU9Db9UPxjF3j8
	v0+isMgOBLpbx4h5Yj/3dvOi0pg==
X-Google-Smtp-Source: AGHT+IHpC7vQAEBl+RVwSZdBZTP875fHqIHXh+UlFq6qH4uze+X3a7pNBnsJ0k1OnI/x7vczZytg/dt8Oe5JxOfF88I=
X-Received: by 2002:a17:907:9687:b0:abf:75b8:cb38 with SMTP id
 a640c23a62f3a-ac20da87899mr69490566b.36.1741120828958; Tue, 04 Mar 2025
 12:40:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304102306.2977836-1-c-vankar@ti.com> <20250304102306.2977836-2-c-vankar@ti.com>
 <20250304153959.GA2654372-robh@kernel.org> <66283781-69d6-4d0a-ada4-3a6bf4744a37@ti.com>
In-Reply-To: <66283781-69d6-4d0a-ada4-3a6bf4744a37@ti.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 4 Mar 2025 14:40:17 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq++DUv5_LHg7sPNXDJZ84JtS94Rwr-WAb9hDWp6rJqZLQ@mail.gmail.com>
X-Gm-Features: AQ5f1JpkJYj0hTvhVDOsV4QKBZ_hEtjJaTF846fPcP96SKLQbxBGQ3BrCLs5a_o
Message-ID: <CAL_Jsq++DUv5_LHg7sPNXDJZ84JtS94Rwr-WAb9hDWp6rJqZLQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] devicetree: bindings: mux: reg-mux: Update
 bindings for reg-mux for new property
To: "Vankar, Chintan" <c-vankar@ti.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Peter Rosin <peda@axentia.se>, s-vadapalli@ti.com, danishanwar@ti.com, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 1:03=E2=80=AFPM Vankar, Chintan <c-vankar@ti.com> wr=
ote:
>
> Hello Rob,
>
> On 3/4/2025 9:09 PM, Rob Herring wrote:
> > On Tue, Mar 04, 2025 at 03:53:05PM +0530, Chintan Vankar wrote:
> >> DT-binding of reg-mux is defined in such a way that one need to provid=
e
> >> register offset and mask in a "mux-reg-masks" property and correspondi=
ng
> >> register value in "idle-states" property. This constraint forces to de=
fine
> >> these values in such a way that "mux-reg-masks" and "idle-states" must=
 be
> >> in sync with each other. This implementation would be more complex if
> >> specific register or set of registers need to be configured which has
> >> large memory space. Introduce a new property "mux-reg-masks-state" whi=
ch
> >> allow to specify offset, mask and value as a tuple in a single propert=
y.
> >
> > Maybe in hindsight that would have been better, but having 2 ways to
> > specify the same thing that we have to maintain forever is not an
> > improvement.
> >
> > No one is making you use this binding. If you have a large number of
> > muxes, then maybe you should use a specific binding.
> >
>
> Thank you for reviewing the patch. The reason behind choosing mux
> subsystem is working and implementation of mmio driver. As we can see
> that implementing this new property in mux-controller is almost
> identical to mmio driver, and it would make it easier to define and
> extend mux-controller's functionality. If we introduce the new driver
> than that would be most likely a clone of mmio driver.

I'm talking about the binding, not the driver. They are independent.
Generic drivers are great. I love them. Generic bindings, not so much.

> Let me know if implementation would be accepted by adding a new
> compatible for it.

Adding a new compatible to the mmio driver? Certainly. That happens
all the time.

I also didn't say don't use this binding as-is. That's fine too.

Rob

