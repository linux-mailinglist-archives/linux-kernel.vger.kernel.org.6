Return-Path: <linux-kernel+bounces-520883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0180CA3B074
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 05:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5181897800
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 04:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EB21ADC95;
	Wed, 19 Feb 2025 04:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qfn7nshH"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D759146593;
	Wed, 19 Feb 2025 04:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739940458; cv=none; b=uGJ7aL4kngv3OUki6mkEfU2RWZfloY/Q3MOW+Mw4Ahw6GhvQZhFOqHVul7LCZV+f4b68e0DNI1+uXnhH5OgiYR+dl2nRdoKpxuUtQ0c+iohuYafvbS8hk7Jvlnsr1kpSOnAbgZNsBvcq9Jagby7oQksMkY8cMfOoiwZSBgV2PMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739940458; c=relaxed/simple;
	bh=j/FGScFKYIvNF8gNYGwyaBT7JxKCpP+A94CkyRWi/Uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5Ro8Y7TWmG92nWIB0gg9yBlCeIOBJURsjBKubuNgHJKycvnNTVi13cf5nVHY7PPfC2pkJXdDeAmw6PI8s6Qe4vLKaAi1VhINbp8NOLA7A1ualj5TwR/aTZGwuiYmTXIkhaS+3gfWoYI3NMh7XhM/u9QKc1DMrIPBzwtz2Nv824=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qfn7nshH; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-47200236004so15455551cf.3;
        Tue, 18 Feb 2025 20:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739940456; x=1740545256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QS3nGYs5YKxyOBVxJ1oYq+XkO0+0BktASGS0GSAFnog=;
        b=Qfn7nshHvH9QGNtPQAUA/DBSUoGx3o+kg5OKZp7IEsPNcs5umHKNvRb/Dd8gMftZXD
         nJamyTXv9YTB1EKKfZeBAASKbQSD13/I3izH5OOmFNEvf+dNoHyKq/Huk48DPuC/ioMk
         /JdAolXB06OqKB0K6noR01a3iQIOJzod3/HCZjJKinsh5rWGlE3QsRp1WhsHgg4S6K4H
         hxhxekoZ26iYKCT/wDCDgUSDgrxCApM1ww65XRLtQrAaoAg9J2rtF3bD2Rs+0TBcXpd9
         /04W6mqrMIfdQzMpjs3ovtqSxX1fgg6d0voMxP3yt0eRrX5VScAYPrK+BKKI2YCX+twf
         Iq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739940456; x=1740545256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QS3nGYs5YKxyOBVxJ1oYq+XkO0+0BktASGS0GSAFnog=;
        b=OVBZN8TSKaUu/4arD46YI1Wo136yUUaVF87q3ANS7Hc/HflMdOueFctboOLdDp+lg3
         T5vLJMIIFznOK5zrUUlNisCt3slCAHmlm3w96iOvCfKgHQgEJVqXRcZL9B64VuRJ6f+h
         3YeTVaDhah7PuXiFKgxPQrkJ55d6ok1XqnF6TnBo8wq1Y0crLkd1Buwn3XbyP3jeoGgt
         hTHoS919058B66LcWyfoIlPjnHFKe+nDmw96+MlHhJ8adsDDSBGn3f01fL5qA67N8FaV
         1SM4KrrU6al/zlfa8vC5BhtBYr3gf+tgEvey1Sj1XeA/H0L1ieDnlRQ9+Wesas0E9igs
         C4Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUsAQ4ZGZQ6TUrURX5mQ2iTFHAQVqAgnwNQxokgPnbh5H5py5/98DD5VONBk0EG+m6Uxfyis4osnw+va4ZY@vger.kernel.org, AJvYcCVWeiiw4ft0/zqVc3S/0H3o8fP8+2hF1VDuH8rvmRdL3Clk5s7iFjcPLLB/kPNG6SHKpf4w21c23PbEPdU=@vger.kernel.org, AJvYcCW1oOdRn5hwUS0o+P5tKkMYMQAPDjKgMdK79a5ehpOIr5x+fcub9YSBaKaecM4VuMwD56lmR400EsKT38M=@vger.kernel.org, AJvYcCXsDFSzyJNAG2qNbKwVkUFoSKhJ67KeVxDxmZ0LMDXmhlfc/f3nx64wPzHpy76QWUoQFuIPF43WlRMj@vger.kernel.org
X-Gm-Message-State: AOJu0YzyPnocteX1fB+2d48rJf5eIY768pI4QmeOZXLJNn4qacUzHEEC
	hGMlD0FrHSyW9o6sx3am5fRj4u6L5J0G9/JR4wCVOlqCK6ojp6DpfvhWZsmaZfB8A1ncsVsdV28
	T0BWJm2cdxKs6Wl4dOsRRnAB8W3FSSjPRd8c=
X-Gm-Gg: ASbGncs4EZYuvaH4lZIBlaHrtFxnEqRnlKWWn891YLOT55CsOQowI0KlBErSmpnkfX8
	LH53oT7GmDP0wJ0ckJ1CJqzSvzp4w5Ur8d8WNL+P40MLYHoL7CbgvWiuJx01jLpMEUEe/rW0=
X-Google-Smtp-Source: AGHT+IGrYhj6Gx1SpOFsGXGJgvmhAlAoqQFszNmC5NEGHxmqY4dRbJCZ6QFbIRC7yBQuaRyXOgmzghwDfIcQ4wY8hFA=
X-Received: by 2002:ac8:5e4e:0:b0:471:bd14:a77c with SMTP id
 d75a77b69052e-472082a97c3mr30546691cf.44.1739940455934; Tue, 18 Feb 2025
 20:47:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
 <20250218-apple-codec-changes-v2-20-932760fd7e07@gmail.com> <Z7SoL3HN7Xb3HUTm@finisterre.sirena.org.uk>
In-Reply-To: <Z7SoL3HN7Xb3HUTm@finisterre.sirena.org.uk>
From: James Calligeros <jcalligeros99@gmail.com>
Date: Wed, 19 Feb 2025 14:47:04 +1000
X-Gm-Features: AWEUYZnqxv5OtWJXczEOpJ1iX6Kd6zGGSMM0m7kJKbH_xe86Di0nRmqCnpc3oHU
Message-ID: <CAHgNfTwmR57GyiMk+-_x3jVNjxCpgLvS4dY2wbZkJN68PgSdjQ@mail.gmail.com>
Subject: Re: [PATCH v2 20/29] ASoC: tas2764: Add SDZ regulator
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>, 
	Dan Murphy <dmurphy@ti.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shi Fu <shifu0704@thundersoft.com>, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	=?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
	Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	asahi@lists.linux.dev, linux-hwmon@vger.kernel.org, 
	Neal Gompa <neal@gompa.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Wed, Feb 19, 2025 at 1:33=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Tue, Feb 18, 2025 at 06:35:54PM +1000, James Calligeros wrote:
>
> > Multiple amps can be connected to the same SDZ GPIO. Using raw GPIOs fo=
r
> > this breaks, as there is no concept of refcounting/sharing. In order to
> > model these platforms, introduce support for an SDZ "regulator". This
> > allows us to represent the SDZ GPIO as a simple regulator-fixed, and
> > then the regulator core takes care of refcounting so that all codecs ar=
e
> > only powered down once all the driver instances are in the suspend
> > state.
>
> I get that the reference counting that the regulator API does is useful
> here but this isn't a regulator so shouldn't be exposed as such,
> particularly since this winds up being visible in the DT ABI.  I
> could've sworn that someone did some helpers for this case but now I go
> looking I can't find them, we certainly don't use any in the regulator
> core.

From what I recall, no attempt at shared GPIO infrastructure has actually
landed. The multiple {de}assertions of SDZ put each chip on the same line
into an unusable state that requires a full power cycle to clear, so
we can't live without
handling the shared GPIO somewhat sensibly.

One alternative off the top of my head is adding a dummy reset controller
to the DTs and integrating it into the ASoC machine driver (which we have
downstream). We could then put the GPIO behind a shared reset line, and hit
that instead of the GPIO. This does seem a little complex/odd, and IIRC we
considered this at some point and decided against it.

Is there any other option that may work here? I'm open to ideas.

Regards,
James

