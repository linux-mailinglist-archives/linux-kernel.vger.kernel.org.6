Return-Path: <linux-kernel+bounces-176053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E758C294E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 19:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7F81F23D7A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 17:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245431BDC8;
	Fri, 10 May 2024 17:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MKMFiRVN"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F8C18037
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 17:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715362260; cv=none; b=hZpGiIc69LmzzoOgNWJeF2DBuOg0VDYAhIshSG6RWDH3ThlkEnlvn8f295EuLJVFSpjRy3aSxROosaJCfpvqsJtXtud0t6VL+9dVuaHMA6dxBIYcUow7kFwVdQxvVXerLKOKsGUX/LYitAzdhE6YfvzbUE2xw17OxMCb0TVqNVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715362260; c=relaxed/simple;
	bh=XqrCfizCQyF2KKw0/WdajRp4//EIlKPiWT2wjme1sQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7EsSndsBFkFLEwAuZ1wdQeLejjeaQGTAyjsBGR77Fz3RcJ3fnDql2IWWlwGIxZFW3tvNUESig/CUb5yM3MASAdRhxHbiz2qszRVWh/yZTg4OuEQLIAW7vX/URSVSdPzP3qroQVgh4DSoC4mcKHOgpMZaF1md2X2z/C2s3qqOBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MKMFiRVN; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e1d6166521so28714911fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 10:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715362257; x=1715967057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Occ+O3gQaZXJydVURkKGuh31GRbkBBYoYZRwqv9bgzU=;
        b=MKMFiRVNAcyzIJGC2QnIM1QG7lmYziPooPnFU2OAmhysGLxVjbf6sjZ1sWW+6g/UN1
         5V9yI6E6A1f/TlYlKrW5wokEQly/x2Dx5a6tHyut5iMoGruVjkmG4L60vnTmCNLBd6Fk
         jpy6tlsln4szy9nwGBJx/AEQeZheYLJ4f+Dys+3XMr7eJAf29IU/hGopikjjI8fuFJRf
         M/udYs83RH17iIGCVrrsAD/oPPA41c9PmaeUaU20hEGjFLmDoA3nOSBNiFwjui80je4M
         LFYiZtgrgBm/tMHG5R8lyJT/RL/uQ8VDPpj500UNYrM4Woj2/0bPrlD7IEGHjri4SGO3
         n4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715362257; x=1715967057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Occ+O3gQaZXJydVURkKGuh31GRbkBBYoYZRwqv9bgzU=;
        b=A2Ayy+0MnjudnnJk13Fob1xv3k+QNNJ0H0mc1MBLq1XAl9JtaDc2opf4TiC+3qhuQH
         xntCupHLW7G8rvsmKojXZihpd2GiwpMyYhWE/c/hyl5M6prn+unnILXAssjTkxmTS0Dg
         4cfLJY3STq2I21l1n5+DeQMla1NsyJxKquHdVig94zV1wZIHY+lZ3b8FC3FjqkWqP50E
         8y/sCchUf38eeb7L68qiupDjq8eJ/LVMledlbCxlGtRbo3dIpVOsmotKGTn10lXQBKwu
         03BT9RXhWw/t0W9DcvmTaXHY6Qaf32tGxCqp8Mp3X0o7LINDsmLbbU2qARWjtyYcJl+y
         iDmA==
X-Forwarded-Encrypted: i=1; AJvYcCVhTedVjjeehdBBn/OA7qTcyHX/6KIbsfaQQjXm+/jsKomoVIdObpO+31w/ymY9u6Hcex41QM6wsbYbfyEbqz806fZXtWIqjCkHcCU1
X-Gm-Message-State: AOJu0YydjVrllnTXWQwuiu5bOXzB2QG5DXj/vIrLB63hG1PB+VuQFr5r
	muV3sO9LqeGRFViI9EWgILMCM5nACFeOq8dXQyJXcGcsrrsGWfzqfSixRHuLIFFfxPQLKopW9WH
	frJoKghXjEZt5IyJJJTYR3wffwKzB89Vpg0VB2A==
X-Google-Smtp-Source: AGHT+IEth9+yiMEnT0dyi6WAr5+H1hY9rOJ8pfNbE7ESLJAECOzbNoW9ASNpZO6jpztELqcXrloxCo8atIKPBbyxWz8=
X-Received: by 2002:a05:651c:c7:b0:2db:2385:d024 with SMTP id
 38308e7fff4ca-2e4b1ad9c2amr17614851fa.26.1715362256957; Fri, 10 May 2024
 10:30:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510064053.278257-1-Mariel.Tinaco@analog.com>
In-Reply-To: <20240510064053.278257-1-Mariel.Tinaco@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 May 2024 12:30:46 -0500
Message-ID: <CAMknhBHd2XCJH4rgYDq=vbCL5E_tM3FxFPWbNy9PvxLCJL4tcA@mail.gmail.com>
Subject: Re: [PATCH 0/2] add AD8460 DAC driver
To: Mariel Tinaco <Mariel.Tinaco@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
	Dimitri Fedrau <dima.fedrau@gmail.com>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 1:42=E2=80=AFAM Mariel Tinaco <Mariel.Tinaco@analog=
com> wrote:
>
> The AD8460 is a 14-bit, high power +-40V 1A, high-speed DAC,
> with dual digital input modes, programmable supply current and
> fault monitoring and protection settings for output current,
> output voltage and junction temperature.
>
> The fault monitoring and shutdown protection features were
> supported in the earlier versions of the IIO driver but was
> scrapped due to uncertainties if the functionalities belong to
> the IIO driver. However, it would be best to implement it for
> the device's quality of life. I'd like to know if it's better
> suited as a stand-alone HWMON driver.
>
> The following are the configurable and readable parameters
> through SPI that could be implemented on the HWMON driver:
>   * An enable bit to arm/protect the device on overcurrent,
> overvoltage or overtemperature events. The device is shut down
> upon detection.
>   * A configurable range/threshold for voltage, current and
> temperature that raises alarm when exceeded while the device is
> armed.
>   * Flags that can be polled to raise alarm upon detection of
> overcurrent, overvoltage or overtemperature events, and apply
> additional protective measures.
>   * Programmable quiescent current (optional)
>   * Thermal monitoring is done by measuring voltage on TMP pin
> (unlikely to be included)
>

Adding myself to the cc: here since I'm interested to see what
Jonathan (or anyone else) has to say about the fault monitoring.

