Return-Path: <linux-kernel+bounces-320899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 204F49711C0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7151F22B33
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693D71B2EF8;
	Mon,  9 Sep 2024 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="D8u633kz"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119E71B2ECE
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725870000; cv=none; b=dF7Nx7WSECUhzrCdS4ZzLpkxZ1suLJwgXmQN2T54rrXzTZQCu30zUU4jIFb85AGoWWL92sRz5+333pYac/0l0oV2DVg0wtTm8YFeobkf6YAJQvgh2KK8cpKyFAqVDiRJhe/zJlBKpFND9/zHhKFyaWCGPEckXSgRyoKwhkDbJcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725870000; c=relaxed/simple;
	bh=nK4KanhWlRZSYU1GucfWC16J4+koH/HjKOEGZSUcp98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dvOtzLBNjWlyFpPy24dG99ksyhXWbVTCPk1iyAaA83i2d/bbAkyyc4naWX9L6YRZU9LSPN2hUiSoQ2A32XTJWTkOsBZLpWiOPZwEWC0eYR6zr13rI0pVfdjn0J207K7jrYuGJGrRLUBydOeXcrjNO9OaIkZYRPyGwvuh0pmpTyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=D8u633kz; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5365b71a6bdso3124418e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 01:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725869997; x=1726474797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nK4KanhWlRZSYU1GucfWC16J4+koH/HjKOEGZSUcp98=;
        b=D8u633kzu1BPSXPo/61PD85CTLAP1HGKAfe5cnFXGpm7JjGJhoDPsFewAJCrz/hmDF
         iL2JOEixPzvULMTJMoOsWEFIT6hQuWOpZ/SjwrnJoWzoKbKWZIlyT4YD+DmyNMqv8VzT
         lWjW3acONuQk/w7CY7kzxJBAPqKM5Qi/mEiBvlHv0+YFlnlQDwMO/WnVLfYJ4egvvekA
         KF5+ev9r7DuwKesgIdJUe9hXKRrNap13GK4r+HfygVITh44JCH42CqAu7Dp3nzoghqhE
         EeWBaDmae7julUJoXqvgigVWHJBMHVQUy6XhBFXzqyc9VODHOfAjYOJtbRu2U0MryjMU
         MKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725869997; x=1726474797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nK4KanhWlRZSYU1GucfWC16J4+koH/HjKOEGZSUcp98=;
        b=G1u3nWMa4VW5oJ2BERjpgm66xkkxxRO7aqOFsLQv0UNO5opJ2xS6jnmh95qkZQOVKi
         M54NMRo8O0aRIsDBiwX/aH12Dj9Zk19+3ujqTF0gkJrC7lmcdZZu/6yIvB1KMrgMKcbP
         XLyfcDWoiV+nMMiI2f7kheSuubQ4YIWnHBsFrrm0hVhtIqCVVQH9XTaVOj8ToTZIF2bJ
         uUR/o6npIOvuqzarsJtKLWfA5+93rPgllKJgBcoLnsDMMxqqpL86lyexeJDOT3zpn4lN
         9XiyxuDjs+gAQaH0cMovrFfvXAap6siN0nBk882/Sb0P5u4pnNwo0YJqeoWbhfEH2gvc
         gn2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVK/f7EfgQpxhjwD0p2AWoj7QDegpGGjLLdvWbch3qB/8zXRd/GYxVst76H0oKWvJWT1FoJdGcHYtE+fWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Hmq83fb8XW/PwdrcvO8BqRzvR/NtOWUFHi7N8ky7mCSJCTG7
	esILtn4Ivs3rM0sbg2g8Tb8lAjNSznVvbjIQUAv2tN1RvOGkL8m7lE66FhoZAgOFwOhydZoDfz8
	iW+YZ6AwdacCAPDvvNqy8QBhCvpcaRabxzb1PKA==
X-Google-Smtp-Source: AGHT+IHxT+bODhO8JSo/tiDz8IhrsZj4aQ7sUddKJwKAAWcGwi3uMKWPvMrXkLnRaBJd7bYB8HRQme7uZiCnsN4k1KI=
X-Received: by 2002:a05:6512:4023:b0:535:6b9e:bcdd with SMTP id
 2adb3069b0e04-536587c73f8mr7930705e87.33.1725869996139; Mon, 09 Sep 2024
 01:19:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814082301.8091-1-brgl@bgdev.pl> <87a5hcyite.fsf@kernel.org>
 <CAMRc=Mcr7E0dxG09_gYPxg57gYAS4j2+-3x9GCS3wOcM46O=NQ@mail.gmail.com>
 <87y146ayrm.fsf@kernel.org> <CAMRc=Mfes+=59WP8dcMsiUApqjsFrY9iVFEdKU6FbTKAFP1k_A@mail.gmail.com>
 <878qw6hs4s.fsf@kernel.org> <CAMRc=Mc_Qy6-Rgsw_uOweUXtoiZGMR0D22Ou9nXUJDDdPCZqLw@mail.gmail.com>
 <1e77b503-36ff-4a97-993b-f87d658c9970@quicinc.com>
In-Reply-To: <1e77b503-36ff-4a97-993b-f87d658c9970@quicinc.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 9 Sep 2024 10:19:44 +0200
Message-ID: <CAMRc=Mc9kzC6PLZM2-kmuC-FtzdM8P9e-YRVxWjg28tAc7BRgg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] dt-bindings: net: ath11k: document the inputs
 of the ath11k on WCN6855
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 8:38=E2=80=AFPM Jeff Johnson <quic_jjohnson@quicinc.=
com> wrote:
>
> On 9/6/2024 12:44 AM, Bartosz Golaszewski wrote:
> > For upstream - if you're using the WCN6855, you must specify the
> > inputs for the WLAN module so it's only fair they be described as
> > "required". For out-of-tree DTS I couldn't care less.
> >
> > You are not correct saying that "M.2 boards don't need these" because
> > as a matter of fact: the WLAN module on your M.2 card takes these
> > inputs from the PMU inside the WCN6855 package.
>
> Let me start by saying that DT is one area where I'm a newbie, so I hope =
I can
> get some education.
>
> I'd like to start with an observation: I've used both WCN6855 with ath11k=
 and
> WCN7850 with ath12k on an x86 laptop without any device tree, so from tha=
t
> perspective none of the device tree stuff is "required" -- these modules =
"just
> work".
>

Yes. This is what I refer to as "fully dynamic" M.2 cards, where the
card typically has an on-board PMIC that handles the power-up of the
device, respecting all timings etc. No custom pins are used. You don't
need device-tree. DT bindings don't concern this case. Even it this
was an ARM, DT-based platform, you wouldn't need the DT entry.

> However I also realize that when these are installed on Qualcomm ARM plat=
forms
> that there are GPIO pins that control things like XO clock, WLAN enable &
> Bluetooth enable, as well as voltage regulators, and the device is
> non-functional without those configured, so the device tree items are req=
uired
> in that environment.
>
> So just from that perspective saying something is "required" is confusing=
 when
> there are platforms where it isn't required. And perhaps that is what is
> confusing Kalle as well?
>

The properties are required IF you have a DT representation. Because
if you're modeling the physical package, this is what it looks like.
The one on your "fully dynamic" M.2 card is the same - it also has the
same internal inputs and outputs but you're not modeling the external
package in the first place so you don't need to care about them. But
if you do represent the chipset and not as a black box WCN6855 in its
entirety but its WLAN, BT and PMU modules separately then it warrants
making the true inputs of the WLAN module mandatory in the schema.

Please let me know if this is enough of an explanation.

Bart

