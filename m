Return-Path: <linux-kernel+bounces-424001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E16E9DAF31
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 23:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D18165BEF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 22:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DE9193079;
	Wed, 27 Nov 2024 22:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rGn5/6jR"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C0E1BC3F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 22:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732745342; cv=none; b=XHhQT5inH3w5bU88JqfTDFfOohuGltsuFkUkNy+Pc1fqmv2NGx2VIVFnRnTipXKvlJhY1TaIsQ15Ev0Mc3JIdF4x3cX5sW6fi/v9otYgatg4gEhLX4wPOR7oztprrWMTObTSvMN/xrDhpQmBZ4dAlQDMXJpUiRU73y98CIgkHsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732745342; c=relaxed/simple;
	bh=D6CeHxyHlJjM0EiErlnE3Tg17NsYmw3YM8We/RaWPYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=igr3+nN4wnYFxbC9Z2JFdPcdVwXY3Ta4Z1srKHCJ2LjaccNZmIJZFllL9gd8ivetb1hoWN9LJP8vE8Tf0IUyMK38OHiwVsQlaDN1AkbTADskY0MFO6awvS8HqDLSMzo3m3BctlOfRvRTLni5htZjB6bcLTShD1Bek4i6lrsUTG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rGn5/6jR; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9e44654ae3so15281666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 14:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732745339; x=1733350139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkve5WAVjMepZp0/DONLTBXVNw+VncqEY4zViqb/VN4=;
        b=rGn5/6jRTiaZsLjzTEo5wN1hLAiFavj0ichSt0zAjoWlcKk6CWPREeofD05tVAtxT7
         1r9WlLCPzzV9zgLr2hI6ivIPCH02e0Y+hKCuVESB/wyWsp26XKo0Ix5yGAsCvWYOsMJF
         edGWly1EmcIRGobvkimR6Jy2gWaS/3VIyVur4y5i9ljAYkFkFMuxp9Eh4n1I2x0/RtcR
         TWytCukBLxs0vcaZKmoUgliLlAbNQJxJ4XKnAPZnaldqaASBriqV/JfC5djT/LWMIQfk
         iNmw01kXJir8xkeHICg/JxLx8FrzO8INMrx1B0rv6WY9PHjA3X+vJeEf2KVzv+mg1wEe
         xC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732745339; x=1733350139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkve5WAVjMepZp0/DONLTBXVNw+VncqEY4zViqb/VN4=;
        b=c4CRvIRlQs53McQ1RHcuv0tS2sJ3Itl9ls7M1UuzhPk42FkgGrJyYT7NRfUuJzcHXQ
         iwruMRNy8I2c+yAOWOluXdX01huNb8PaQsQfNRErSK29z8OOfiCeweX49vSpSRK3088a
         wnl/JoQwM0F58bkDo5di9uIaNwiNP96R2TMIocQ90bJ15QA4gAz97TLIyag2yFNxNv7d
         O9mfoLDyMCTx9z3RlJuHv+CQDuAi/obgNys4LoQxK4c95CDpnzlLDZgd4QDRSPOF+O6h
         jDkz4qCt9ZckLpovwBi2IhKVMn6+VQFZeWXUI8Q1Votg7phiC0Qrj02MbXUbEYLT2pnc
         6rZA==
X-Forwarded-Encrypted: i=1; AJvYcCVtocWr13SiEIOUmuh56YAyepQ4bx8vxcecyDAVyP864FjOXBC1UzkQ5u9XWgVdfl2fw/401s+NdgWP+hU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4HE/5CIdfY4AqQXyWC/1GmPfB8MPqW4WMp0SxbbtcFDWB95b8
	bdkn9Xh97F2bKkzKifSYo+K7eDn77LMVy5ZRq5EGm0CU0L3OsPJWhf664h/ZzKgvvUMkTN4dhkn
	DQ0sffQXpLlprR9g+F6iD6xfYMWPtoNe2MGU=
X-Gm-Gg: ASbGncuPZMKv6GW+iGLj4jr3BFYC5vYjtdSXHnu+uXhObSxNKyAgptbocCtav8GIzUz
	DsiWAUEeRMZBPnZfwEKMAtHWlMhZWYSU+2efaQ/9EdF4sNho9zle5mQ1Nnjvx
X-Google-Smtp-Source: AGHT+IH8osHx8jZL5ptZv5UFWejA+lId7D19yGIcV1y6QuD/JZOvlRu9pG+ae1BciuWU5Ct58ILF3j/OdCM2/4zsG7M=
X-Received: by 2002:a17:906:23ea:b0:a9e:b281:a212 with SMTP id
 a640c23a62f3a-aa581073993mr345465766b.51.1732745339020; Wed, 27 Nov 2024
 14:08:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031115448.978498636@linutronix.de> <20241031120328.599430157@linutronix.de>
 <387b120b-d68a-45e8-b6ab-768cd95d11c2@roeck-us.net>
In-Reply-To: <387b120b-d68a-45e8-b6ab-768cd95d11c2@roeck-us.net>
From: John Stultz <jstultz@google.com>
Date: Wed, 27 Nov 2024 14:08:47 -0800
Message-ID: <CANDhNCo1RtcfqUJsuAQ+HdS7E29+gByfek5-4KYiAk3Njk4M3Q@mail.gmail.com>
Subject: Re: [patch 2/2] timekeeping: Always check for negative motion
To: Guenter Roeck <linux@roeck-us.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 24, 2024 at 4:48=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
> On Thu, Oct 31, 2024 at 01:04:08PM +0100, Thomas Gleixner wrote:
> > clocksource_delta() has two variants. One with a check for negative mot=
ion,
> > which is only selected by x86. This is a historic leftover as this func=
tion
> > was previously used in the time getter hot paths.
> >
> > Since 135225a363ae timekeeping_cycles_to_ns() has unconditional protect=
ion
> > against this as a by-product of the protection against 64bit math overf=
low.
> >
> > clocksource_delta() is only used in the clocksource watchdog and in
> > timekeeping_advance(). The extra conditional there is not hurting anyon=
e.
> >
> > Remove the config option and unconditionally prevent negative motion of=
 the
> > readout.
> >
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>
> This patch causes the kuda-bmc qemu emulation to stall. Reverting it fixe=
s
> the problem.
>

I'm not familiar with kuda-bmc and I'm not finding too many details
searching on it.
From other qemu bmc reults I'm guessing this is an arm32 architecture?

Do you have any more details about where it's stalling?  Also dmesg
details might help illuminate what clocksource was used, etc.
I'm wondering if the clocksource mask value is incorrect for the
clocksource being used here?

thanks
-john

