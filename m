Return-Path: <linux-kernel+bounces-375777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 066C79A9AA8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B5B61F24F02
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E6A149E13;
	Tue, 22 Oct 2024 07:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFqLeoOw"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1C71494CE;
	Tue, 22 Oct 2024 07:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729581253; cv=none; b=ZZPcFZUKCaD7MsiT5v0a4DIcoSJUkAV50vT3dxjMc74XZZqohxmzyLEiAulpg6VpoxOrqttqDK2oJ6X2vmhjz9Iv1csV0ZlcgFbidCj6M3aHHn+sRFVPtgSSAWcNM9xScaUblJEjDO6a3YuU9MJb7BO/z1KFgOQ7P3f578zOVEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729581253; c=relaxed/simple;
	bh=FaTJrnKvTNc+V3dbBhAL3Glgo+sHMhxk4md12E05/ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XkBhBWYj50JepntslHMgA5l2eTq5ng49D8paNc2JhgfZVmBTMh/he/RSb/Q3i7O3l/URUGvxx+oapwwGVYUDfW6J15WJvsCQ7/26ZhrJvai0lRJ/wLXkZs8HufTYsZ9US0ir5APz3ZNljJ7iyscWf7H2siRs3vVm5mcag1z2CI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFqLeoOw; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7c1324be8easo4418897a12.1;
        Tue, 22 Oct 2024 00:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729581251; x=1730186051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaTJrnKvTNc+V3dbBhAL3Glgo+sHMhxk4md12E05/ng=;
        b=QFqLeoOwPQgQDO8/6JIP2kEVd25ePpBBxzBHnimMdjeGu2C01wWypeqHBICWZtSuSQ
         FgP9Zo4Fc/0NrhQeN0wbJ3ciGO5TFQ44YTO+dnwVm/6rGDM/jy8nsOrSa6KrN1nkf2gO
         EO1QCJPNIKM0LLwnbH2k+YYMNQPWwbRK5iS9B0bAzZk2Lu+m5rgoe/oBjEq2haDtLoks
         +9nLMBjMRzVc/dbrJgiKJJrf0aE1K821agswmzBFXZ78ilcYNXJinZoCZ9oOybWQAVdU
         iFYuj39iIUsrP/PYwL+vUSeZlY1QDmbI5woB/4ossPPSvgaKIjFpfL9ljuqaWThRzyvS
         QH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729581251; x=1730186051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FaTJrnKvTNc+V3dbBhAL3Glgo+sHMhxk4md12E05/ng=;
        b=DOKCopGW59e6MxwAd0M0ch8Oz11MjAJQ8m5/lhewDbgHNFgsWUfKdUmPI0miX23RiI
         CbAn1HJlru1UYhRlHmemQLPAULJSXi0KlUTMdlvwXDv0eVu1X15TjSpmj4vPo6WrIi0p
         wboyHaR8MLILHaLmpAj+jH5t2xEEhFA5J2Bkvj5JqR678qW5hmoUPTuvndlbmelfthFk
         am2bZkItcO6yvEEQ5rzUxLajLBuBTaaWu3GczE2A2HnSmfOgVmUqFcSbzZnsnQPvym5N
         8kDtsz7c7Tsn4M27fiHy0hKTMCtO3iYOKzeUX9aVSxVghaC8BjKW4OzjCd/PzKFkbBFP
         Yn5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbKwvXr+Z71a/XHR03XZf0kOwTnrV90YV9h0Ggel/JSZqBouRZ8eESeYzT6J0iSh3RAtO/bQN+YW21cbqN@vger.kernel.org, AJvYcCVA8T1CHs1bUBwtYC7MHruClAg4OEUV5uzNeigJoRAE2xOgb+qoxBVyEfJK2qVn1Kg2jXPDevIJJPqc@vger.kernel.org, AJvYcCVC0a0ZHoHyOR8Ya3+fCjuOr14zq7E0zpOuOR9KYMcIdjBugBPog25nqaL5oGMMGGH8QMr+gRMwGOVvK7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0tVbUESEzn2j6eJCGuwkA+6eQAlNmTD73VRt0GYQY8B30huZd
	Q4GifY8iYV/1nwKTmu2pzMH/Kr03g3Y+RZDDrrJuLTnEFRusnzV+
X-Google-Smtp-Source: AGHT+IFpezyYg40TMB0QgVk9F9LufBMXE2hWRts318j7F5wsWf804p9uSDbl2tZNPQIm+93G+p4R+g==
X-Received: by 2002:a05:6a20:e347:b0:1d9:3acf:8bdd with SMTP id adf61e73a8af0-1d96c40ecf7mr3433222637.22.1729581251406;
        Tue, 22 Oct 2024 00:14:11 -0700 (PDT)
Received: from setsuna.localnet (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec132ffb8sm4082732b3a.50.2024.10.22.00.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 00:14:11 -0700 (PDT)
From: James Calligeros <jcalligeros99@gmail.com>
To: Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
 Neal Gompa <neal@gompa.dev>
Cc: Martin =?UTF-8?B?UG92acWhZXI=?= <povik+lin@cutebit.org>,
 David Rhodes <david.rhodes@cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 asahi@lists.linux.dev, linux-sound@vger.kernel.org,
 patches@opensource.cirrus.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 1/3] dt-bindings: sound: Add CS42L84 codec
Date: Tue, 22 Oct 2024 17:14:03 +1000
Message-ID: <10547772.nUPlyArG6x@setsuna>
In-Reply-To: <e1d35dc6-4c58-490a-87d3-1e9694b3c650@sirena.org.uk>
References:
 <20241020-cs42l84-v2-0-37ba2b6721d9@gmail.com>
 <20241021192632.GA965116-robh@kernel.org>
 <e1d35dc6-4c58-490a-87d3-1e9694b3c650@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi all,

On Mon, Oct 21, 2024 at 02:26:32PM -0500, Rob Herring wrote:
> On Sun, Oct 20, 2024 at 12:47:31AM +1000, James Calligeros wrote:
> > CS42L84 is a headphone jack codec made by Cirrus Logic and seen in Apple
> > computer models starting with 2021 Macbook Pros. It is not a publicly
> > documented part. To a degree the part is similar to the public CS42L42.
> > (The L84 superseded L83 seen in earlier Apple models, and the L83 was
> > pretty much the same as L42.)
>=20
> Why can't this be added to
> Documentation/devicetree/bindings/sound/cirrus,cs42l42.yaml?
>=20
> I guess perhaps you don't know what the supplies look like? Do any of
> the custom properties apply?

I suppose the original thinking around creating a new binding was simply ne=
w=20
driver, new chip, new binding. We also don't describe the power supply of t=
he=20
chip at all, as this is all handled by lower level firmware.

Some of the custom properties (e.g. tip sense debounce) should technically=
=20
work if we teach the driver how to set them at probe time, however given th=
at=20
the chip is almost certainly never going to be used outside of the Apple=20
Silicon context we went with static values that were first observed under m=
acOS=20
and then optimised once we had enough of a working stack to play around in=
=20
Linux. The values that go into the registers for each property appear to be=
=20
identical to CS42L42, so it should be possible to implement at least some o=
f=20
these properties if that is what is preferred.

On Tuesday 22 October 2024 8:15:50=E2=80=AFAM AEST Mark Brown wrote:
> I don't know if the Cirrus people who are listed as maintainers of that
> binding might have concerns about doing things that acknowledge this
> particular part.

I suspect, based on the past behaviour of Apple vendors including Cirrus=20
themselves, that they either won't or can't publicly acknowledge the existe=
nce=20
of this chip. Given this, and the fact that the chip will almost certainly=
=20
never be used on any other platform, it is probably better for everyone=20
involved if we cut them out of the loop.

Regards,
James



