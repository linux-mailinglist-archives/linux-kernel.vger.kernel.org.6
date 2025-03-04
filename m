Return-Path: <linux-kernel+bounces-543537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD40A4D6E7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2111886233
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544381FC0FD;
	Tue,  4 Mar 2025 08:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bKShz5m8"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A23190468
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077958; cv=none; b=Yffs5hGVO16qHz+NR4NoPonT3DjX+Mb7UZiK+ue3Q6JqThZGKYyhFVfdYSdx307+RqOHYFduzCx5XWMs7+eboeigPXgSsvrmME0dldMBRTmO4E51F/Yo766t8mkHJ/B+7B0vJru5mi4864WVSWsvrcjFgJlJAdtaaKfdYUWUTUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077958; c=relaxed/simple;
	bh=/0SJkcPrDcWFOUGtF0J/DGFOTXNav/MeYdDkxX2pjFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJWO4UeQeeYxmXtMrqkn17aJENdBNQ93+oPMgZG5eMqNpWvdUC1aAVhcK7tLMnZqO7qQs/+ZOQaNcoIdDG+yrfbYtm7xyLPeqHsEPE7FiPyk+sntJkKrre/8MSglZ7dP/fAdWKRMsgGvqxUSoq6FHnHt0fZ6wVdjpjvWpnQsd58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bKShz5m8; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5493b5bc6e8so6318507e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 00:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741077954; x=1741682754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0SJkcPrDcWFOUGtF0J/DGFOTXNav/MeYdDkxX2pjFM=;
        b=bKShz5m81i3KkHbzcyXPBe4Pjl5YJrkLhMFFvQI8K7kmMdOzSC+uB/NOUN4WPEalua
         ClFDTUB+RiGkXa9HHi8JsxvDDkzd0WLtderAUzCnFHXKqhouHp/KtIS2+fm/zhcGhTfl
         iwNl3/h7T1ONhryTk3HEJrGOd+OcnSukGwHG7SMRcJe2Bcb1IQI+zDzECuwyepNMOxlU
         YjiVIcJgmZuui+1vXa5wM1E4m8ZLd/z+ri5Z4ObakGdpK1+PtOg7FuKHuhoBmk47cg+h
         lTnBQhxzbMLUzZ18DcKewvWMEv0z/O4iJjBxQ1KtG3dwbzBF4LTbr8o5pJFpJWLpedy4
         MbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741077954; x=1741682754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0SJkcPrDcWFOUGtF0J/DGFOTXNav/MeYdDkxX2pjFM=;
        b=iku6Y5oFSwDSirvNR/6JTW4chexGLAqV+07dvpwYPUOuG+juU1mFaJNYbXoDISY0lj
         A/kj3+GNl183FBp8NgOizb5OuLrRgEpu6gFTd+I7OZFO/tyJZ5Z/F0z487lWXrexxrx7
         m8MWlwqTxcKNs166BmrDjkzssuCi7x4braA8ilSyV6+gvtazbsoQvcUIG6abbHg6VJ7I
         +RAYsOC96fVyf/O3kg8N4NVS2cHGU1kHIUuD6U4ie/zreAEgAxPhfO+12s6AXeRMmV+v
         6FI5jtSi762zRWM7H1J5v5/oVO7gtrcRQ/hW54LaZXDvrQ7rzka0uJVe1KeBl5EAWnxI
         ZqRg==
X-Forwarded-Encrypted: i=1; AJvYcCUERufEqqYCVYrv1b8eX4NvqE20PKPCwf3WwQogqpXJBmpsbt+D+fSagya+3DuMIyu/nCPh9uUchs9Uvjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUEAoZ4myWKPp5L/EgMKHy8Crkx5BobJTBJuwTmbH9Pggxf5sp
	K8cAe+YvvKiyIDLmYXoBYg1PHKGxMuGXV+vkAkWs0fg1LDOZab034QlwOt+XQgGzv7kGDh4g+HC
	Lmc8KFp1bhz0f36yDlKVEp0D6YyNlkuSM+/D8oQ==
X-Gm-Gg: ASbGnctArcNbAxcMJBTuev6WF6aU8i29RBED+x5pySU/8tYuZUud9GdmixIzkf9dlQ0
	QeOCI5HKltZPGOjivhOsQTvqApQ22WyvaQcu429PEdFqqYQRtJ/N5clbCIYoMHMtyP+bo8MRey4
	CalX3G5JqnHK5jj4nIgBS2tQC/CQ==
X-Google-Smtp-Source: AGHT+IHsVxclGliNqaEX2rQGkMgJ98ubJoLnko5L4jIGDJ4jURzN0K+jt3I2W3bQVmw/PNLGXa3fvCQ+389PMRa318A=
X-Received: by 2002:a05:6512:128e:b0:545:958:180d with SMTP id
 2adb3069b0e04-5494c37d98cmr5919737e87.38.1741077954243; Tue, 04 Mar 2025
 00:45:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303160341.1322640-1-andriy.shevchenko@linux.intel.com>
 <20250303160341.1322640-4-andriy.shevchenko@linux.intel.com> <Z8XUMRAlR3H13zha@smile.fi.intel.com>
In-Reply-To: <Z8XUMRAlR3H13zha@smile.fi.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 4 Mar 2025 09:45:43 +0100
X-Gm-Features: AQ5f1JrkaHhT1A9qOrQA_wrC0Y5xjg5i_-rTm_Muy8k7fJlbX2FpNCXPxucoweQ
Message-ID: <CACRpkdaxnCK6arrYBi7j7qBQXqxYma8owb4kZj--y4BNQmfD=g@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] gpiolib: Rename gpio_do_set_config() --> gpiod_do_set_config()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mika Westerberg <westeri@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 5:09=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, Mar 03, 2025 at 06:00:34PM +0200, Andy Shevchenko wrote:
> > In order to reduce the 'gpio' namespace when operate over GPIO descript=
or
> > rename gpio_do_set_config() to gpiod_do_set_config().
>
> This change was made against my custom tree and I forgot about that.
> I will wait for the overall response to this series and if okay I
> may issue the correct patch.

For the correct patch, with the same idea:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

