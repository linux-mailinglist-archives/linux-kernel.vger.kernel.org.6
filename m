Return-Path: <linux-kernel+bounces-274346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA27947707
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 974F81F21AF9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E9514B970;
	Mon,  5 Aug 2024 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zF1//vbV"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B74A95B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722845797; cv=none; b=fii236asgAEZZbJx/SenXgzAsb95KG6hcStM3+8rjL1nSl6CffrC+pmEORtp+skmDIjKSKk5N1f9mqR9tm7eokdrzbpueru+ObEw83D2daNRMQAKEivanb8OjZKv+c4gz2bFVVWFP5gqiPuQePMMnRqUmqYKSDE2kg83NHXfO/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722845797; c=relaxed/simple;
	bh=5unLlgc6A6zclb59BucjBaezsg4VcXs/IowJ1jRLzcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXdxh2UclM6Z2L1stWuSqM3XcQJAoNi1b7rkI/seRMpVLKY7nVnQGNkkeujZIIu94A8pZcAuPu0CYF834qa2Qi/r9ND7pTE5Ge/VbOvtewBb3ixpNZ4qukErl7LQt5GPQXg9YK0SYUbYxn5VNsESgyGHZHdt/UbZXWdKae6q9Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zF1//vbV; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52f00ad303aso15099478e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 01:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722845794; x=1723450594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5unLlgc6A6zclb59BucjBaezsg4VcXs/IowJ1jRLzcA=;
        b=zF1//vbVzdClJz35M2lTfM1iGNvwUq7MAMV5x84wurR/Aw29fSXAIl+GtjS8cHui9O
         xisw+QcXNOidbYEm6eYRGdcaRSKAXWiCZRQYOBmzeBsRIs5olxWPBD7zRlp7GnIlM3sl
         zJQaFPVZ3/2L4h0p2ySGgJr8tnQqhyq3XblDpWsSncK3/C2yuA8Im5C3p16+HAkd1OVN
         lVvOZeu8jbs5rdLyEEAHxg4FOdzIdvtJkJO3XQmhIPVOtqAz5fPfefmvKwkzliWfWolK
         EtF8J0qAGBBfEDwLPxqUNdTDRpyVdZNjKGrMxpjiX8b+IOOL782Ui+N6IlRGJRZSmIak
         9+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722845794; x=1723450594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5unLlgc6A6zclb59BucjBaezsg4VcXs/IowJ1jRLzcA=;
        b=XcvrWT1jwhwp4tP2WMglULLMJ5FhNm2A+/2J7fvcksnISdkajUvfZauo+Cb1nGw7Gk
         1ilovUPjyr2CrhfDaD7tnQKvDVY1RVpv9HplqKiT3MZOdp+N1fHddxH9EWZnKRrQUn/H
         ibqgEtSe58P2IGA1W9GsaNYL/Mf1A8bHOHeWVmuYeoY+qCY/8ckB1cEZhCUVXwnKGWtv
         KEVDRtAcqpfpTB4MfakUnrNazCLGbgm2OXgYAW482JKmtMLTZJFunHDJkSoEhcJ+o2lS
         Jozpa927C/A4zZdyRLltLCOGNPKQZjHYVGR2E8QvJS2E/hJIn/ivXBv0WnHZWn2Qc35k
         UItg==
X-Forwarded-Encrypted: i=1; AJvYcCXFzQYM7DD9StkEEcuYRuVAqCmg8ZrnSjftLWlYBy5gRtbp+Kd/vOL30AbBUrF7fierUHDMSp7MBdkCj47jA5SnD0gI1Oa+bttwCqLK
X-Gm-Message-State: AOJu0YxShYbycCVXsN3jXZQIH9k1k4kYVJU61HwxM0EQfK2DGl7uufV8
	HfeAfVH9uEEv5xwC4Ohg77gsZW7MHT839Ac/i/kIJkOmQBx6nYQ+Drwqa0YK2V3zH36j2/vLQrM
	h3GCokdb2lnRLIy7s7i+bovyfS5yTn4frqu+pxqfhxRb80sD2TZc=
X-Google-Smtp-Source: AGHT+IH3RK3cbhFuy8fuCp+3vtZx2KcsiayetJDkYeKN58B24FoHtQcGq9smDLZXRdkzF4xXi3Z4oUykfCeFy0UYzUc=
X-Received: by 2002:a05:6512:2310:b0:52c:8df9:2e6f with SMTP id
 2adb3069b0e04-530bb3d4333mr8370398e87.42.1722845793449; Mon, 05 Aug 2024
 01:16:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZrAgj9rG6oVqfdoK@google.com>
In-Reply-To: <ZrAgj9rG6oVqfdoK@google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 5 Aug 2024 10:16:22 +0200
Message-ID: <CACRpkdYV3AZLLShnnstKK8SrenDoWzhnC9XO13OUWKgWgG7CKQ@mail.gmail.com>
Subject: Re: [PATCH] Input: cyttsp - use devm_regulator_bulk_get_enable()
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 2:45=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> The driver does not try to power down the rails at system suspend or
> when touchscreen is not in use, but rather enables regulators at probe
> time. Power savings are achieved by requesting the controller to enter
> low power mode.
>
> Switch to devm_regulator_bulk_get_enable() instead of separately
> requesting regulators, enabling them, and installing a custom
> devm-action to disable them on unbind/remove, which simplifies the
> code.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

