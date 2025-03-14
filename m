Return-Path: <linux-kernel+bounces-561234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE436A60F0F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750D01B618E3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9B01DDA33;
	Fri, 14 Mar 2025 10:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L/8FmuL3"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CAE1F4CAD
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948486; cv=none; b=NDDre6OfsLy6lpvAgL/Ug5w6yDNiey9SvtE7mCCl+tnXsWeWDneL+2V0gBDrL3Uj7XPYRG5IVaHOFXfIaQX0c1e1PYw4QE8Lq0nO8psYaoob1FaxrxVtNyCMxQhIMZVxecwS7raPmZz9wnGL5rYFynagYk6Wg8n8yBy73BtGADg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948486; c=relaxed/simple;
	bh=aL0gXB6mSCGXve79f+GXoCVzELUaAGFZyR3q5Z30UuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i2rktRqbi6M80xbdXmoXhKYtKNn38uCnbccCZ4tfn5EF1XlcGe30ME1D8RO7xU5ATEbBbq64GGhGwlqvJ8bWu5w38EA+niyTvlfCYV6EQrEhaVG27eVCtW9oZ/wbD7OF5asDicLddcC8Q82loHPLMoUlbC1a+9DCXP31/vE3vME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L/8FmuL3; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5499e3ec54dso2039527e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741948482; x=1742553282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXFlL4FEs/n/rX4YOPitVgbikcIXGJdQJLDY1EsOF8w=;
        b=L/8FmuL3f1IHAid3EGYNfElweO601ecHo+1Xs6kAHjAqDaMrX8RnRwhJHnRkW1u4T7
         1bF3g9xNOYrP7h9Ku07UmrBhNuZDp10f1xLsOTRlSmMGgf12qGno7CZatu2NousSrdl5
         yNh5PSJ7FoGDYymPiJeLnEQB7M7PicuOwQD+CIqrT6rII4dgBAgam/EaC3qxArCON+av
         J686h58ZpUUcLYHRyNdgSdmzYEhCB08ETmwCaIs1fBoJ7IxviU0HFF0qtSKBdhzz6rGx
         DUwGpcals95bLPjjY1du+n0B0XECrl9vvA4bH38+slQwu+mF6/4fzccPAPZSL77OWSZf
         ZSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741948482; x=1742553282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXFlL4FEs/n/rX4YOPitVgbikcIXGJdQJLDY1EsOF8w=;
        b=oAdZNYJT0nbm7fdiNGbFeZR/39z1cSTWy2BxxiHQrQXGMN7oQsML7nc0lawVNxIBwE
         OJL2mhHeiId5hCjnQarVww1epD/LJsBFkJnpeMga5pKK8m1/RIYzvvYSQLkwaSttqjtT
         RifOpauMZrvxQIVGqfUALrxoESCUBexD2jnIaqKJJPWQd0EseRKnWPt0fC/TtT4zEDdc
         AnSL+LsBWeRS2+D/eAuFskHbZjI3cGtNQMDzWX9BvWLufN3YGBmDlSfPf99dXrzj4G0H
         UuOyMciRKwDhz9ILITuObWU+sTTr/Wrg/+yH8Z9d9uB/76Vhn08CuWqNoBaXRAl6x9QP
         DCiA==
X-Forwarded-Encrypted: i=1; AJvYcCVVV5odNXjr/41ZEbJMqfKjpsOrKi1nD+1W4U5a05XiMYtjZDr5pICwdKAoanOfTT4ImrBRArmrUo4+Mko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8RkFxEGHQLmIfVqN++oPEmYcwuGktBVW9mA6GMNwy/CStpzeM
	OZg8sQ7b0zCsnEgaAkI8GiL47O60nVvp/wnPLjpVrnOmHBfDf7Uo1PcvcUfZbrfcwFhoddCcciB
	pbi0YhQ91ytcW8AwujaREMVw56l0hODjcoAvBHg==
X-Gm-Gg: ASbGnctbsbLIZUlyzAHn/E2ONjJ/k5lOPQBRvefYNh4pBST+XXFe7gBMirjotxqrnFO
	LwZCwMGhIRYyONgoT4Zm0TLa61EvUARmNaHpGZP2vt07ET/tlSuTT82Irz3q6zc5Kx/PvlCw6C5
	zifXy85pTKdjJ3B+B/tySPqmk=
X-Google-Smtp-Source: AGHT+IH59Nam3QzVYLK/m6Rs0Q0Qn2HE9pRubALNnpoj2NMRzj++gf0khsat6J38n/8gCO1y3XF2MUrlrRs2zD0uS3w=
X-Received: by 2002:a05:6512:398c:b0:549:31e4:9ea with SMTP id
 2adb3069b0e04-549c3c9897amr675717e87.52.1741948482182; Fri, 14 Mar 2025
 03:34:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <617f4c77-7837-4e24-9f4d-620ecfedf924@stanley.mountain>
In-Reply-To: <617f4c77-7837-4e24-9f4d-620ecfedf924@stanley.mountain>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Mar 2025 11:34:30 +0100
X-Gm-Features: AQ5f1JqMDr8pDqL2jIXtFwweqNigXKcsgGd2oHbNPaqU9RFqX-TDqejST3Ot0yI
Message-ID: <CACRpkdZkpJR--x=qgzXVmRsSexobBV9eRyQ0BecGZ4+dNBcXQg@mail.gmail.com>
Subject: Re: [PATCH next] pinctrl: amd: isp411: Fix IS_ERR() vs NULL check in probe()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Pratap Nirujogi <pratap.nirujogi@amd.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 11:52=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:

> The platform_get_resource() returns NULL on error.  It doesn't
> return error pointers.  Fix the error checking to match.
>
> Fixes: e97435ab09f3 ("pinctrl: amd: isp411: Add amdisp GPIO pinctrl")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Patch applied!

Yours,
Linus Walleij

