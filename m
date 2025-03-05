Return-Path: <linux-kernel+bounces-545906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E560A4F35F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF5716F4BD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 01:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9B613B7AE;
	Wed,  5 Mar 2025 01:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vm0DwhJJ"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5595FDA7;
	Wed,  5 Mar 2025 01:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741137568; cv=none; b=PfAbZh7xInBo8yD8uFQEOOrP/eEVeA2QzbYlMIR0bCZa1O3VPXxYQPWVA/ltGg1ebn004wdvtEFZ+2jjxPqqogrgbOMYc3QRUQdjWHbl+NLqJQBxrDSKC36sbree1AuhpPDMeaVFlneTcqC9UjRsl7mXYvX1nDHCkqgUppNf9W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741137568; c=relaxed/simple;
	bh=aj7oEpRtbuTIufQ2FwedlFlVEGKMaqVdWjGFOoq8rgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uaHVk1hK3aiLKRjLw7CcMAZWSoNeHhLRFCWE16cVrWR/kXshRNV9Tkepbaw5S0tc/LQnIvjC5Yn14FaT7+EUI2+f7AeaBw73kLRGdW9P3dU6Qyj4LCgrWneRksHOudm8lbl2+ePJQp+3O4NKwQEQsOfkEA+w4NrRQy6hejoJdNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vm0DwhJJ; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-474e0bd966dso27152651cf.0;
        Tue, 04 Mar 2025 17:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741137566; x=1741742366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aj7oEpRtbuTIufQ2FwedlFlVEGKMaqVdWjGFOoq8rgo=;
        b=Vm0DwhJJBhnfy06HdxFNgXYFO9PdkmAvX3uxVTjGjqBA0710xqf3NjG+jiAO60ZWqB
         0HDkbjj/daocmJh9LpmmSS3BfVdNhYZ4cruDgUQuC3Zy9MqtvpSOi47hhyxIizlR3IBC
         Suq5tw3vbX5wbpsjPHYw8JbGmP0IkRz0h4S+hOJitfYo10McyoETIDYcVfqc5upCuHaa
         Yg4R62+j6iC2fUXHA81OkzFnuHV67QE0BU1JxlFW4w/8B8H1cdLRLhpyWFCWBseO3jtg
         CBv5yqVHeOw59/WVkDpfdbCPQ1UQ/X3swnAcbfvVmfJ8jfAugbKzQqzFDsURmhwB3H6W
         RePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741137566; x=1741742366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aj7oEpRtbuTIufQ2FwedlFlVEGKMaqVdWjGFOoq8rgo=;
        b=LDXobvd+RF+ZwQxnO058nNCOnG5jCyS4sUhUvTtGa2GZsLcNRWLcftNyeHZ7N66jvr
         RebR4nWaa0ZexWTEF4AivGEfAg/8yyQo9XYVRyfO+lWbXaJOaLb9pSgbtRRNrwV2HHeD
         mrihnJqUYoEQUotH/QXO48F6QVHmE8jFl0Fjw1bPkgEpVi0GXjKfonTL3d14l3zyA1NB
         UXO8fTaPx+TAfJpFO4rFLsjKx3PjSRshnSdMgRY7XON2h7+LZ3DYWB6CgaBIqa7+HqhO
         UCBuotBwfaRNJCulPQzZ164ZlcA+oVKbQ7jdKwkUNsB6fnQce9yDOckvPs9FHwJHQS7M
         imZw==
X-Forwarded-Encrypted: i=1; AJvYcCUMeqxZ7XplCDbDv8x0cssAQHT7jSgeLEYH9IJzaeudssJimMg6oT804wte5Ot9MyFhYIT//di2aZPB@vger.kernel.org, AJvYcCW8PevYiAf/AB67ZHQVqgBxgquF5H7cmMdcZTjz2E/d5psgQGpxWCY85WztgN3M99ieIXkpWTkPZiPZJhNf@vger.kernel.org, AJvYcCWIQdsfx7Hy8u2k5Bn+9OkdbszHEyGvxrP9Z+cMJ0U5MD/U4iRVtnVIVCAz0M9c7QIZzd7jNi7OGBEU8vg=@vger.kernel.org, AJvYcCXL3hEJpsJ5vBwDJ4aIXmuc5XEulo9ULBLfwRCmtFcTw0nh+f5Pt6kNtUzQlP3hDvHUN5DLFnckvo+TXZw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp++0VfUn2T0SAGW/TzVt2IbwnV+sXxF/Uhb7EzlzjZt0yYP+0
	/ARDbcDrxgk2L8M7lPKIEnQkzLDJ+XAgmx6awwpv/Sj3VYLOGPvNH3cZ2GI9VjtxViVQG8q5nY1
	QSr+3W1v88WjcJMTGXXlSglY4I2k=
X-Gm-Gg: ASbGncu+lgITgzGvvSVuRt8ntNInYlS/wzwtgEPCJfDwuyCLzS/O6d58SzufgQJR19J
	1j1S5qvH8Y05UrWXzL6Z7+pKoojD7loJdpdCMqmylqj0k37p9SvFfDEt9fnmHwFfP2YsStSPrNS
	hLs13C4aGWKhVvGMj70/pj3+pqPjMv3YA2+pIbWmJRoqx/LSLuzDPL2oIE
X-Google-Smtp-Source: AGHT+IH/gZVl6njT5r5xmoZsHMsCaVy4AHjZ3IvtwdL5qtNx7CdcXOgj41fRuij/xZmHZN7CAquryIOYCVl/RGfL4qE=
X-Received: by 2002:ac8:5750:0:b0:471:cfa9:2612 with SMTP id
 d75a77b69052e-4750b4c62abmr19008121cf.32.1741137566103; Tue, 04 Mar 2025
 17:19:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227-apple-codec-changes-v3-0-cbb130030acf@gmail.com>
 <20250227-apple-codec-changes-v3-17-cbb130030acf@gmail.com> <20250304135050.GA2485358-robh@kernel.org>
In-Reply-To: <20250304135050.GA2485358-robh@kernel.org>
From: James Calligeros <jcalligeros99@gmail.com>
Date: Wed, 5 Mar 2025 01:19:15 +0000
X-Gm-Features: AQ5f1JqKhAwj6qTqSfRCe3oGAAXCdiK5LgUlvxIRex-ch881UGzuk3RJ4ynlZPQ
Message-ID: <CAHgNfTyVKFuT0fZ3Qj=MdcXs67KscwkSepAH95xkAAKWM1g8Xg@mail.gmail.com>
Subject: Re: [PATCH v3 17/20] ASoC: dt-bindings: tas2770: add flags for SDOUT
 pulldown and zero-fill
To: Rob Herring <robh@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shenghao Ding <shenghao-ding@ti.com>, 
	Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shi Fu <shifu0704@thundersoft.com>, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	=?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
	Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	asahi@lists.linux.dev, linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 1:50=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:
> Can't you align this with the other property you added? Or extend the
> existing TDM properties we have.

I don't think either option makes sense given the functionality. This chip
behaves differently to TAS2764, and instead of using a bitmask to determine
which slots to ignore, we only get a single bit to tell the chip whether we=
 want
it to fill or pull down *all* inactive slots. The property being a u32 mask
therefore does not make sense here.

Building the logic off the existing generic TDM slot properties would alter
behaviour of existing implementations where zero-fill and pulldown may not =
be
required or even wanted. This may continue to be the case going forward so =
I'd
rather make it an explicit opt-in rather than some unconditional thing we t=
ry to
turn on heuristically.

I gave some thought to flipping these bits if a TDM slot mask is passed to =
the
driver, however it can still be the case that we don't want both zero-fill =
*and*
pulldown active at the same time, or as above some implementations may want
neither, so we still need to be able to specify them individually.

Regards,
James

