Return-Path: <linux-kernel+bounces-286474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB3B951B53
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F670B23E4F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32721B1407;
	Wed, 14 Aug 2024 13:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gqe7U6Ab"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A13381D4
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723640570; cv=none; b=mSH0tT7OawQZ2AA/VlCAm4oR7mLusu7BhCk6JAKzJ79OMN2ngupBTPLFKLA4ROzRZAvwkQx8VnvEqdOZSwjyd+syZ8uOc7wgqCuxAf5EAOzFn762JC/kDjSI7QDXwL5iHxusP3JtyFTd/TlusbmpXanikPrM2Gif5ZY/QTlBbdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723640570; c=relaxed/simple;
	bh=NT+wGZ9R/+yI3DIAo9Gmeit9wV4Vawzv31a8JT9RhX4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=WoGRCuJws4oo5CTD5p+OmzKk+wyyi+TsT6Pj+kCHUtnpEghFMJ3JYga8k/VgN6CDZGMnVYIN5986eOvu8KFJYrUFBOmz2BV9UjCf5FkZRZe9QU+GfESalCm03/X1P4y/OifgwLQPcmkeHI2mFhl1V8+T3tkzQfM47Y6MnGpFOyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gqe7U6Ab; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-429d2d7be1eso5128665e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 06:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723640566; x=1724245366; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4K4BDaLCEtdbulY6HtobHdsh36KQUSnYp7/rzF5PLA=;
        b=gqe7U6AbuiiG03QJujRb18WTRgcI1loYGO2DdPtPX+l4oMNGikH3gKC6FQ0G1Vh2MW
         RovaleWSzXqeSiE55LQjdgREpvfJpuhhibALpgeowscT0qJCEz0YOgcdFbt+wzGqZfky
         Ks6+Xh9UkckYm55GSmgLaLNdnLxvnyXOngdLPhPVZc1YQDYf1VMtmlbJ8+XmOhz5HURI
         SQt8jF+OoIHE3AAi1k6k/FUW7CEplqMVy+j8/+JyKWrFS8W9Lms5a/xHPOCStY3GFgi+
         xCQee99xylX0ZoqJ6bpCI8byvWzBVWiRTKJL935G/XSS2r48QXz4cjIe5caKPNdjueZ0
         gFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723640566; x=1724245366;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O4K4BDaLCEtdbulY6HtobHdsh36KQUSnYp7/rzF5PLA=;
        b=lgR6ty+LzKlxS2XjQRqqTtZx8gLFznv9K3ucluLMu0axE0WfnTB3mHhiK7dpvWL8NN
         EqpWJYMklK/5Em7v2lwkY2+atrji8rFfOxJg17DHfMxQ7PDw5kvm9PqNyQqbBsnXrGgm
         nXkea9yYOXIYwYgIj98HWt4ZTW2bonRYKEkbKWV0+E3Heq2qmH3YzICfs2BnYG5vsq5N
         8I7rH5RgkLmy6mdcCfpDT1VIhSJ+gwE9swSiOs2GO1b82y6XOf9Ez7Z7entq5cNc9ytt
         JMukhaYq6ikHyvFagMFsoaPtMCEnUovh3SQN8LbiIbWV33myM3wNhMDjKSWI55ICjms1
         Vn4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWuuFl9O17BXreiU3iTt2NTjmsYJYVcSJTri3nzK+WxQcOoFcAotv6ipsCN5d8XIG+XV+iCC1kklMMlHpMD19tjq9ifOouk7kNczyPa
X-Gm-Message-State: AOJu0Yx2j9/8bwFf66/3hD9YrkHZ4hcvm428xaul7YHEy300bhK0hK0r
	6pKrNBccuDhZgwR4gDttxJ/tErB3vYPiwjP5k1vu/YA1jpN4OJ12hJzIsPpMWrE=
X-Google-Smtp-Source: AGHT+IEiuMuerzIZhsH7pz9MJFOaYB3RXunMQWiFhAXvL252urYZEie5hvV1BugT/j84AicdA4rzZA==
X-Received: by 2002:a05:600c:19c9:b0:424:a7f1:ba2 with SMTP id 5b1f17b1804b1-429d62fe113mr51591955e9.17.1723640563879;
        Wed, 14 Aug 2024 06:02:43 -0700 (PDT)
Received: from localhost ([2a01:e0a:448:76e0:3b04:df6a:3044:6b7d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded327f8sm19376945e9.18.2024.08.14.06.02.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 06:02:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Aug 2024 15:02:42 +0200
Message-Id: <D3FNL323ZXLQ.2D0QLACO67VTP@baylibre.com>
Subject: Re: [PATCH RFC 0/5] iio: adc: ad4030: new driver for AD4030 and
 similar ADCs
From: "Esteban Blanc" <eblanc@baylibre.com>
To: "Jonathan Cameron" <jic23@kernel.org>
Cc: "Lars-Peter Clausen" <lars@metafoo.de>, "Michael Hennerich"
 <Michael.Hennerich@analog.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Nuno Sa" <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David
 Lechner" <dlechner@baylibre.com>
X-Mailer: aerc 0.17.0
References: <20240627-eblanc-ad4630_v1-v1-0-fdc0610c23b0@baylibre.com>
 <20240629174039.3e6053e5@jic23-huawei>
In-Reply-To: <20240629174039.3e6053e5@jic23-huawei>

On Sat Jun 29, 2024 at 6:40 PM CEST, Jonathan Cameron wrote:
> On Thu, 27 Jun 2024 13:59:11 +0200
> Esteban Blanc <eblanc@baylibre.com> wrote:
>
> > This is adding DT bindings and a new driver for AD4030, AD4630 and
> > AD4632 ADCs.
> >=20
> > This work is being done in collaboration with Analog Devices Inc.,
> > hence they are listed as maintainers rather than me.
> >=20
> > The code has been tested on a Zedboard with an EVAL-AD4030-24FMCZ,
> > an EVAL-AD4630-24FMCZ and an EVAL-AD4630-16FMCZ. As there is no eval
> > board for AD4632 the support can't be tested at the moment. The main
> > difference is the reduced throughput.
> >=20
> > This series is taged as RFC because I think I'm misusing
> > IIO_CHAN_INFO_CALIB*. For CALIBBIAS the doc in sysfs-bus-iio says
> > "Hardware applied calibration offset (assumed to fix production
> > inaccuracies)" but AD4030 offset in on 24bits and I would argue that at
> > this point it's not just here to fix production inaccuracies. Same this
> > for CALIBSCALE. What IIO attributes should I use instead?
>
> Interesting.   So awkward question for you.  What's the point in applying
> a digital offset?  calibbias is normally about tweaking the Analog side.
> This just seems to be adding a value on.  I'm not sure it affects what
> can actually be captured without saturation.

True, both scale and offset applied with thoses registers can lead to
saturation.

> Maybe it has influence by changing the input range and scale for the
> block averaging filter?  I'm not sure.
>
> You can use offset for this given it's a simple linear value and not
> anything to do with calibration. It's a little awkward though as that
> is post scale rather than the other way around which is rather more
> common.
> Controls are in the form
> voltage =3D (raw + offset) * scale=20
>
> So here
> voltage =3D (raw + offset_reg / (gain_reg * other scaling)) * gain_reg * =
otherscaling.
>
> Hence your offset is a bit fiddly to compute.

After talking to ADI engineer about this, the conclusion is that I was
wrong and this is indeed mostly for calibration. They left the range
of values quite wide in case a user wanted to use this to apply an
offset or scale to the raw value directly in order to avoid doing some
post processing later on. But the main goal is calibration.

If that's ok with you I will keep CALIBBIAS and CALIBSCALE for the next
round and remove the RFC tag.

Thanks for your time and sorry for the confusion,

--=20
Esteban "Skallwar" Blanc
BayLibre


