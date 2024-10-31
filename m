Return-Path: <linux-kernel+bounces-390326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE959B7872
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 600BE1C2340C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7A912B169;
	Thu, 31 Oct 2024 10:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uLsI4n1a"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765BE1953A2
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730369552; cv=none; b=ddMj4d5QZByZHEnB0M/ZrxYSqI0C+4owskUKonHWTMdjdkEZP9iaIAuV1i9EKT8y6xRuTt88NDijw7EaVFIDu5BkEUNNKvORl6Bovyhx3CB/oooXvRpyIfGtv+5xduNJU3va9UypLhOQf4sgW4daGYodjHca5wVAf5Oz77rQlOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730369552; c=relaxed/simple;
	bh=T35wMVs1MNW3myHz/mrvwXNZ7HSH/Zu34Y04Hh5lKAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cvld9pFqXM2vd00izBFfLvlotyaZY4GVqvO7mMbMT1/P3Xy9EyTjGwN7sFQ6kYfatAUHcvUkFCC4Cp0P7klmI7ulk0MgjEDNO9Y2SBJNYbFuke/wSBkmfHJOTh4SrYu33gwZaZfZMNCWrOxP19mZf4BsRxa74JFmbYfYNzRBT9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uLsI4n1a; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e3a97a6010so7876647b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 03:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730369549; x=1730974349; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T35wMVs1MNW3myHz/mrvwXNZ7HSH/Zu34Y04Hh5lKAk=;
        b=uLsI4n1a5fllndcUeZW6rxJGQcwDJIbID5YPjcLyH+X5hKDiGu513j/2dCm9N/407S
         SpwA/vN/p33kpGh6Cpq5eXZWWxs8oPId0614pz57/JZNJsLaqsNcgSY57Ta/RbcBQXne
         vhlrz9K48Z5aoX7yn3P922/7504Yn9Taqe6OFJXeNG18S5M8GCPaKCHg3LwI0YtcdF/f
         g4EXn89mka2dSyHzKimCtycGldyhYyTx4ddCpdNMffXk7S0eVvj4/BbaKj/Q7xVMaE65
         CTLxZ8KSQynJdV/Zzcqfoftf42cVxlZJPEUca7u8AhzkEkHQwvy5Ac9rzhRlC6S21QMj
         12Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730369549; x=1730974349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T35wMVs1MNW3myHz/mrvwXNZ7HSH/Zu34Y04Hh5lKAk=;
        b=p9AH9MQEZaLCHfInh8PYmaLHTtgJlPi4WMh3FQ2x6epy/Qlhrt8QZivbEEj5RFmJ+b
         KxUZOndd2ebRAWGS5d0IM2kMC/Z7QcuFYkaVHrHCRwUwwzVishE1r8ABcTWRUundauzi
         3UiTM4J3nlUnXHGx5KFoFv9lIGvnqW4VyFINAWKZ+CXR6+hE9tYuIo9Waovwrd2ghmEr
         M9lyhhpn6C1/cuA/T/+6t0hE3als6hT2TFyH//VTruvIQQoib9HTfsHVVS/e+8YuiQej
         b3u+XJcY3K7OOAdlybBc455StlJH+eqjiNuNJUAGrHMcWnr9mZKblE7EqMH2Blmlz75U
         fMiw==
X-Forwarded-Encrypted: i=1; AJvYcCWZp7yqVCod3A6gXDT6lsSUHdJhoMEYMALKPJWxPenNpQINXXbyZTfbEFwNAqAiKH15rUQ+s26LorreQhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9bKJHGWI1NuiLq7rNAzdZ+/qiolMBGTrgwpDXbc/zcaCjPsko
	yDfPy/0iCJYn2W6INfM5MVofdV7PcS/iSKzuzVtYD7J6Aeha5Em/fxBE+QiFi8gCt6TSSlckz0b
	3ovC8bTQ4ap4emxWwcdAUgjE6p4LHJqkNiZVRpQ==
X-Google-Smtp-Source: AGHT+IFa7GpMRcZBsCmM7CXrwXH4F/9S0bZVX2rOTwZ8gwWPISz40Itv+XpN30B/P4QqbSfNO35YnVdPLxOpi1AIrVk=
X-Received: by 2002:a05:690c:ecf:b0:6db:9b55:80df with SMTP id
 00721157ae682-6e9d8acaffcmr188192657b3.33.1730369549381; Thu, 31 Oct 2024
 03:12:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906-lpm-v6-10-constraints-pmdomain-v4-0-4055557fafbc@baylibre.com>
 <173029317079.2440963.17313738472826934777.b4-ty@ti.com> <CAPDyKFptHq6xkKSAmeHsEuhBoEhzvudcMf2+nG08MFPwnMi+ew@mail.gmail.com>
 <7hv7x9qsvt.fsf@baylibre.com>
In-Reply-To: <7hv7x9qsvt.fsf@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 31 Oct 2024 11:11:52 +0100
Message-ID: <CAPDyKFpdgg+kM_Ot5GPTpMUtjmBF-pUhCeRpVb=j852_7qm=3A@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] pmdomain: ti_sci: collect and send low-power mode constraints
To: Kevin Hilman <khilman@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org, Vibhore Vardhan <vibhore@ti.com>, 
	Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Oct 2024 at 20:43, Kevin Hilman <khilman@baylibre.com> wrote:
>
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
> > On Wed, 30 Oct 2024 at 14:01, Nishanth Menon <nm@ti.com> wrote:
> >>
> >> Hi Kevin Hilman,
> >>
> >> On Fri, 06 Sep 2024 09:14:48 -0700, Kevin Hilman wrote:
> >> > The latest (10.x) version of the firmware for the PM co-processor (aka
> >> > device manager, or DM) adds support for a "managed" mode, where the DM
> >> > firmware will select the specific low power state which is entered
> >> > when Linux requests a system-wide suspend.
> >> >
> >> > In this mode, the DM will always attempt the deepest low-power state
> >> > available for the SoC.
> >> >
> >> > [...]
> >>
> >> I have applied the following to branch ti-drivers-soc-next on [1].
> >> Thank you!
> >>
> >> Ulf, based on your ack[2], I have assumed that you want me to pick
> >> this series up. Let me know if that is not the case and I can drop the
> >> series.
> >
> > Well, that was a while ago. The reason was because there was a
> > dependency to another series [2], when this was posted.
> >
> > If that's not the case anymore, I think it's better to funnel this via
> > my pmdomain tree. Please let me know how to proceed.
>
> The build-time dependency on [2] still exists, and since that was just
> queued up by Nishanth, I think this series should (still) go along with
> it to keep things simple.
>
> Kevin

Right, that makes perfect sense to me too. If we discover conflicts,
let's deal with them then.

[...]

Kind regards
Uffe

