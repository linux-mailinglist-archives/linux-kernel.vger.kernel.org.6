Return-Path: <linux-kernel+bounces-190654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1B38D00F5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B6621F25BAC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE0F161914;
	Mon, 27 May 2024 13:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LcqLreLS"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1EB15ECFB
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716814926; cv=none; b=quISXMxK2gU7MwcxXAGsn5LYu4Uuu+ZkCPGRqqnHmqk2/rzgtU4Dnc6wcjTJNYFMu1IjfjbDrX2lWDrMjSdh8Wg0+PNvcDRTCU2LwYqvcyncbLQ0dvoR4ICYOiax9qw3JXFomOINWFjSLT3CdZHBce7IQ2zLzHfzaVwS916HYPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716814926; c=relaxed/simple;
	bh=wgk7WXRbuBVOxXeNcCecE0I5Ssrmoyonz0n5453vRtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c5QsEekZH6aeaTvqAa2ggDDreNdw3CGyBLJzDK5QdTZ4I5++PhnSADIgNyZpLPMeJt/IMlbcu3fECnFZOo597w8rSn5Wb0uK1dR+uw+5N3sdqKF8t9HXdILMbH0WeEE+8wDjmbrTuIrdFc92CVkSeJNvad1iKudtn3j5xfW1EWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LcqLreLS; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-62a088f80f6so22747167b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716814924; x=1717419724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgk7WXRbuBVOxXeNcCecE0I5Ssrmoyonz0n5453vRtw=;
        b=LcqLreLSmAOol1+iWp/9g0SzC/1PUcBnGPP3KY5R6MZnZsCy6DA4f9yTcjS7x3A/NI
         GtSBvZ+XvQZJeWqoz4IP+LWsClzO2UjuB496CdfIe+ezaDVmy2mr1T533k27TIudY3o4
         LQwiZs9Ib+Iku1u5f6p748brGTcjmsEEOt8pbJan41KfKE7djDER8ZP74cL9cSm1aUtn
         QSF1G6q4uQWRHPLpEJ/VZ1N/Pd9Oroi80VFaO2RI5FM5gQoLr8LfvqtuQt64uCrkvqe6
         GZKz5zbMTSpXWZO0bayrz8NDVDvYbKXfT3OotW6XiK2WkxzH5owMJHxHHH29PxxTnrXF
         +xzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716814924; x=1717419724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wgk7WXRbuBVOxXeNcCecE0I5Ssrmoyonz0n5453vRtw=;
        b=esBAp6eElFUPPDA7sg1tH8DbDemfJkcTppaCAZ5F0C3TMMnvBSDPj0V1J/cZ4hCCo5
         gpvYQ23Ay/Ccy+Bt7KpeeiP/M2PDG8zI0qnaJImkvIqMPEXuEfls4mzd9Fkvo+JbeBWV
         Y/rUer3fMCoFTxB5umadNQAYNGN44P+pCive2ceJ9x2P4TIFSzLNgan0/0Cd0hm0YNuq
         428LBNiCQH7Xn2NqH1v0d+22bB2eGp3/TiDaa+tMD2j+G81HRKFodyyrNwG2fFFpi0Ey
         QLvG0sKDYuigU4RWfUwSGH7upU9iBi032qojBfZcPekrujytDW37DY03BPs3AgsICjnn
         QX+g==
X-Forwarded-Encrypted: i=1; AJvYcCVbWiqc0ot6XZjAZEuQ8ud1aRgYTNt6pFczyZopv6pPAWehfC9um09KonQbIz01Xnc0kKAnAR5XorjAddBUzeU928ndvhwGrntrFA2q
X-Gm-Message-State: AOJu0YwOnGKcKgJZ/MxbqV4sajaOyc1x4a6hgox3L7qpJI6i9Gh9jVpW
	nD2038yxhAMiojKbUDsYULcnxDbLTLHJpm2ZwzjHlgpoXyF4tNiA0WlSK89YzxipO95FwdAa3Mp
	5/xZSoiuRErnjc3J5b7NML2DdKEB1p6jrRoPUgUyw72h0MJ/CTHSsWw==
X-Google-Smtp-Source: AGHT+IE7lfH95P9CZ75FsUEqTbZ6lMKUg3CE06+7S2ZlNbsftLNAwXmGR02nDIY6dJYKm+SYL7/4iLQAHH1jddPM7CM=
X-Received: by 2002:a25:838d:0:b0:df4:dbdb:40b with SMTP id
 3f1490d57ef6-df77094a5fcmr7149710276.5.1716814923932; Mon, 27 May 2024
 06:02:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507144821.12275-1-johan+linaro@kernel.org> <20240507144821.12275-4-johan+linaro@kernel.org>
In-Reply-To: <20240507144821.12275-4-johan+linaro@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 May 2024 15:01:53 +0200
Message-ID: <CACRpkdZjG4FrKsWARpMO_Gx0Eo21EQyofPx9KUdut2ENxdwROQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] dt-bindings: HID: i2c-hid: elan: add
 'no-reset-on-power-off' property
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
	Bjorn Andersson <andersson@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Douglas Anderson <dianders@chromium.org>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 4:48=E2=80=AFPM Johan Hovold <johan+linaro@kernel.or=
g> wrote:

> When the power supply is shared with other peripherals the reset line
> can be wired in such a way that it can remain deasserted regardless of
> whether the supply is on or not.
>
> This is important as it can be used to avoid holding the controller in
> reset for extended periods of time when it remains powered, something
> which can lead to increased power consumption. Leaving reset deasserted
> also avoids leaking current through the reset circuitry pull-up
> resistors.
>
> Add a new 'no-reset-on-power-off' devicetree property which can be used
> by the OS to determine when reset needs to be asserted on power down.
>
> Note that this property can also be used when the supply cannot be
> turned off by the OS at all.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

