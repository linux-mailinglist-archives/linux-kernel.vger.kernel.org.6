Return-Path: <linux-kernel+bounces-201098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C833E8FB96E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C1C1F262C8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7F4148830;
	Tue,  4 Jun 2024 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howett-net.20230601.gappssmtp.com header.i=@howett-net.20230601.gappssmtp.com header.b="hP7bzKYm"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91C113D607
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717519623; cv=none; b=Qb1XeIORkkKB7md4lAyLIgzAF/zFzPqkXh0Fy6d4XXDaoK8EsjVIuPe6urQO/4u74ujLWH4xNPAF7TiVcBv3i5kBl5XJ7cRWZ0ZlZLEqA7QhmRYEGVDb+P4iZj+laCZ3yvZZmmUnM5xnR+cj808oYn6tdd5xHaCm/x6NL1/9F5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717519623; c=relaxed/simple;
	bh=oVSrnWYW3Dy+qbnzyP2YK4spEY/t8FU2eqyIxSQiOCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lw/zj2eUpQElEyXC6Pyd8YsBMgPLP0yUY52J0LXIXg5uJ3AAQ3xhaDu1lTywq88rGZaFYW/hT5BgAGTkuSsL+tiuhf1arb6vU+v/dqn6IFNfWeewaCwhBMU91NW902B64H9wG1JYtqWZARkTMui4yJTVzW10lQQC/iemJrpfeso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howett.net; spf=none smtp.mailfrom=howett.net; dkim=pass (2048-bit key) header.d=howett-net.20230601.gappssmtp.com header.i=@howett-net.20230601.gappssmtp.com header.b=hP7bzKYm; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howett.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=howett.net
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dfa7ab78ef2so4424773276.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 09:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=howett-net.20230601.gappssmtp.com; s=20230601; t=1717519620; x=1718124420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVSrnWYW3Dy+qbnzyP2YK4spEY/t8FU2eqyIxSQiOCk=;
        b=hP7bzKYmi+nZBbMB0RvCeSSXA9djGswKA39IVSq+SqKE0nnLxmE04+ydxts+vMPY+T
         wB+hjENSqc4hvPBg2Pi7i+qbd5UGNqe1VhcYljf0Zjdqo7MCPJZDWYWlSgsMYTxxUg5z
         kWdJdZwKup5I1oIyDEzwQvQd8fFPIbD+ppO2efG9jRd0g6AuiolPLwmMivBKEsunKBbZ
         DKpVnH5r2cKw1ukwJ4KZNtu7fKGuGHjcT9tYNiTZe+suDg3zc8q2lUsRdoJUU4TaTxPi
         OXVTLDxMVw1cVcxU3XD1r/tKkbHAwr2sAnHzXVfTRuzTHoIxa/CGyqL7pWTk6PPv6X6e
         NBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717519620; x=1718124420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVSrnWYW3Dy+qbnzyP2YK4spEY/t8FU2eqyIxSQiOCk=;
        b=i+b8V+2inY6fph1rcopouZYybkk7W/EHfXp/a6Qb4lPoCON6Ki073i4EJ8oNYIQiT1
         pVq0vdQP7VCXw9Bf+WJh7HpI8ttIrmPahFBy2EaEwK8DdQqinxJq1OqShxgJAGwYIhp8
         Ro0I0zL068G3hICB+xMZ3EAIVwdOeQm2n1AEZMXoQJcG/w2CmH/8ugXgZIXoanm/dc4P
         /Uyj4D+03OXB7QNDNa1q0cJ+b/vNPeady572Jst9i8tkYAnF/mb8quVhO8gcVAWSxsja
         H4eXjAdNBeSge4HHMsdqVWowZQOQum6qPIXqtaF+P6avu5HJzjH8vAHqpV3Bdy6mZK+H
         H2uw==
X-Forwarded-Encrypted: i=1; AJvYcCX6rxBI+1pQ+ZUgGQyPrAZwhG2ddyXZ2n0fAK2hxNMeSwsgncbT4huzO19QUu5NKRGAiCaM05W7xrHf8gYO+wBxgzYcQRf9YUhFL3fS
X-Gm-Message-State: AOJu0YyzHfwhy45DSa62sMWDMDRRni/qnez9GpdE/TTXgoZ0U9qe7yZM
	fEPBFH0T0HdgJsFvAlB8E7tYRSGIGQE9YODsIZWK0gyKaSH6OtO4jhzqWMdcv1XGtC09BS5ywxi
	ax17X/pEmbFbgzJ/Sz/L/fEUf6GVvFed7iBt82O6kj1pCmYOBmQ==
X-Google-Smtp-Source: AGHT+IHMdgVbp4edXz1RYg3r+v3zS6jex/OYdamIOc4mz+GjXYTa50U8xGQcjwpv2rX/qXq+oLJeXSLJiUuBGNHgjT4=
X-Received: by 2002:a25:aba7:0:b0:df4:dd91:4524 with SMTP id
 3f1490d57ef6-dfa73dbb8bfmr12794384276.44.1717519619696; Tue, 04 Jun 2024
 09:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603-led-trigger-flush-v1-1-c904c6e2fb34@weissschuh.net>
In-Reply-To: <20240603-led-trigger-flush-v1-1-c904c6e2fb34@weissschuh.net>
From: Dustin Howett <dustin@howett.net>
Date: Tue, 4 Jun 2024 11:46:48 -0500
Message-ID: <CA+BfgNKowam5s==47KcrO-JRc2QfR2od1T=9z52t1AJZFkc0yw@mail.gmail.com>
Subject: Re: [PATCH] leds: triggers: flush pending brightness before
 activating trigger
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
	Jacek Anaszewski <jacek.anaszewski@gmail.com>, linux-leds@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 4:45=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisssc=
huh.net> wrote:
>
> Dustin, could you validate that this fixes the issue you encountered in
> the cros_ec led driver?

Thanks for the quick patch. Yes, it fixes the issue I encountered with
leds_cros_ec!

Tested-by: Dustin L. Howett <dustin@howett.net>

Cheers,
d

