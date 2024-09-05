Return-Path: <linux-kernel+bounces-316287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A65C496CD80
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F941F270E6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84B5131E38;
	Thu,  5 Sep 2024 03:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RFQew6v2"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD849138490
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 03:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725508367; cv=none; b=c46urrloXfaHpW4EoTrbQMy9N58aPf+UeLjsx4qbqfvPbl1cIjwwFTWP6271cgDWY/XcqSnHYEkCo+kSxlawvD3MOAYMhyy3fG3oIBzkU1/tq4INIKn8hHkA/FQtiSzlzYvTz1kZXo/usKxDEjVGL2BoK86zluow1Z8Fthkkd2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725508367; c=relaxed/simple;
	bh=su/8gj6ks5K85/I3PIYZHz4bzmuYkE7mRyHvpRMnZhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUwS3+/7h3MoYpcb+eb83i0p5jgqDWGeFZn+41eu713j3CXmM1ByJyJZnsdKFUdKc3U4CyBh81h0W13VmE4kYmwqaGi9nSzgV3KVZbpm1zO8EG4r2ZrwiCvtZ+HorVN8co71G8kesHXvHFzxiX/yRwYW33iTsw03UzFwAjx6TMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RFQew6v2; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5334a8a1b07so211672e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 20:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725508364; x=1726113164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRIIgJ7S3hsBk6289/S+wOJS+zjzXBK17nuyOQXg1gQ=;
        b=RFQew6v2H2RSVsC5zXcTD6NPoVUP8rC4ngRO26FnEtEXE33zWqplCFXsAojoxCDk9w
         3jKXMjTvIWiDfBjZwGOtERjZmGe79jhk4jXmbQ1YGWP3zUHPs8ABv0uqZSY67QOYzk/B
         GUUu82pqiF1qtQbMBvsiHC9N7CNp/owZhwEqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725508364; x=1726113164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRIIgJ7S3hsBk6289/S+wOJS+zjzXBK17nuyOQXg1gQ=;
        b=aqKkDFjMwk8N6NInZiQqxE4+N7V3nYLx69XJKIoVMkho0IiVNBlkW4oHHZ268wuvkC
         GQ/KOMFD0OzQWYbVIhJQs9SFDgslN24Bmgr5V7jxuEIwYxVe1tvlWdbAgzdP8c8oBqPt
         i8vADqrMAKa+f4YCGkPp/mVweY79CS2/YWVDHZ/iUNNtqz2L5HyEtZgskFbf6mQkXDm4
         uZLEApP9eHmB23QtHhdZyZSjTC3jKG1EKt6laGZf2a3sXRC9GGHQAhdzsZmqxS8ulTnq
         CwKFbAoRwATLYZJPyt3VPWLO5cv5OWJfXCf7DKRSOR85vjasHMPLyQcAg1R/wtcUoTk+
         Iyxg==
X-Forwarded-Encrypted: i=1; AJvYcCVWOI3YxhlioNq4ZO/94VsAbBZEu7sPtkBSFGm29TCDBDy1sTPp+T6BQS4+vyFTZzWScYjEWV0zeT63tHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHxs036vUqIFOGaig2bvZvOozqZN6TIpbiVQvgHXoLmYrBS0g5
	roFtBzv+AILAHMZWx2ILyLctK05iB2m0yf8/mvFMUATVJHTyyo8H2o/qHs9j7d0wMNyFFgvB9zk
	Fy4cQqP/Pmmd0VhJAqUH4+z51UrUEo9UjAByA
X-Google-Smtp-Source: AGHT+IFf4LunjDbLMZ4JbahUyowVfro0pxQijuaHaPzJX7btNK9HgFjL//PjfHIonl230ee/BtNVKcZVy4RESHnFt3A=
X-Received: by 2002:a05:6512:350e:b0:535:66ff:c681 with SMTP id
 2adb3069b0e04-53566ffc733mr2025998e87.48.1725508363601; Wed, 04 Sep 2024
 20:52:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904090016.2841572-1-wenst@chromium.org> <20240904090016.2841572-12-wenst@chromium.org>
 <Ztgxlmhnkn7NVC81@google.com>
In-Reply-To: <Ztgxlmhnkn7NVC81@google.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 5 Sep 2024 11:52:32 +0800
Message-ID: <CAGXv+5GpKu-b4_dbRcuSG4NxQi_FKh9p7iMh6DfgavkLFdLLdQ@mail.gmail.com>
Subject: Re: [PATCH v6 11/12] platform/chrome: Introduce device tree hardware prober
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wolfram Sang <wsa@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Mark Brown <broonie@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, chrome-platform@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Douglas Anderson <dianders@chromium.org>, Johan Hovold <johan@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 6:08=E2=80=AFPM Tzung-Bi Shih <tzungbi@kernel.org> w=
rote:
>
> On Wed, Sep 04, 2024 at 05:00:13PM +0800, Chen-Yu Tsai wrote:
> > diff --git a/drivers/platform/chrome/chromeos_of_hw_prober.c b/drivers/=
platform/chrome/chromeos_of_hw_prober.c
> [...]
> > +static int chromeos_of_hw_prober_probe(struct platform_device *pdev)
> > +{
> > +     for (size_t i =3D 0; i < ARRAY_SIZE(hw_prober_platforms); i++) {
> > +             int ret;
> > +
> > +             if (!of_machine_is_compatible(hw_prober_platforms[i].comp=
atible))
> > +                     continue;
> > +
> > +             ret =3D hw_prober_platforms[i].prober(&pdev->dev, hw_prob=
er_platforms[i].data);
> > +             /* Ignore unrecoverable errors and keep going through oth=
er probers */
> > +             if (ret =3D=3D -EPROBE_DEFER)
> > +                     return ret;
>
> Is it harmless if some of the components get probed multiple times?  E.g.=
:
> comp1 probed -> comp2 probed -> comp3 returned -EPROBE_DEFER -> some time
> later, chromeos_of_hw_prober_probe() gets called again.

Yes it is harmless. Components already enabled will not get disabled
in the error path. And the prober that enabled that component will see
that a component was enabled, and skip doing the whole process again.

So something like:

    comp1 probed -> comp2 probed -> comp3 -EPROBE_DEFER ->
        comp1 skip -> comp2 skip -> comp3 probed


ChenYu

