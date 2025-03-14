Return-Path: <linux-kernel+bounces-561277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CE9A60F8D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C9018957ED
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEEE1FCFE3;
	Fri, 14 Mar 2025 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Alc408NF"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0B11A5B82
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 11:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741950313; cv=none; b=sDL641yB3hxr7lB8V+oVEdQ4LokbHv/A6H8N7Xw5ZpRPVNXQxsaU2n3qVPz4JpozTuPx5m7l8vUVlrKLfV+EQHS8DDcmmmLYyRN4onlW8GRPJqV9I8nl5ADVmyGAtNvXruaK1hZgyeiaqZONucZYNOcqP0AZg6K30TMz9/Yzc6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741950313; c=relaxed/simple;
	bh=mSti1lSdkZu5pzlNVnJFPEzIQmYvJ2JTwDXM6hAfHUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K50/jwUAqM0cmOU+gQjTTTetPcNiUXB0M7OQqoh5myosRzJiOBO1tmtERX1K61M5E5a4E42yrytV/JQW8z07AXumFSBPMjDwB6i4EibXrP9rQMUBJ4QCBT6agEYpuJVh0IqwpszofxH9c9bIVEK1fzODZxzZLYjNx1IFc/3f8E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Alc408NF; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5498c742661so2177524e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 04:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741950309; x=1742555109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLwu4BItx7GSozI0hELmEc6ksU5EqrfITEr4tkmZScU=;
        b=Alc408NFuXrlMzvZCbDAayfA98kdAg18P0E69FKzsxBVjjinS54OiueI9EYdMTsd/0
         q1kKiFEwBZOcL5EWbhfTLS9711J9ISkrqtZIDSA9TWWz7894q95PDiiZ0sn2V2YwPPZl
         uWhtMpgAnvX7T8z34HqDOkaYXIeb6tSGUn6bzsH6c5Ky8FyUKjTw7D9p7s5OvaWKEJFW
         9DWwlzuzC2IlRazjmXYzjmrXw7YM7gq4x3LTIm1AVaJOdUrEYhJbDAFgL6qM8p4vNmvf
         HYX9r/Bt4/0TKbpc76NE0UNYuXO7ncIx5yEkHeDJqOnraA7qD4PoVHsj8N/H4O98x9bR
         NGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741950309; x=1742555109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLwu4BItx7GSozI0hELmEc6ksU5EqrfITEr4tkmZScU=;
        b=vVSroa7mi25Y6Pi03f+DW6PnzpIKyfAS/wKDsVrEl5xKTST9Tbn/AlDOrA62OV2kEB
         XOHSbne4sxoC2S/3FlzZ9gekeLF9rAxZFgN9t4VKSLIlkLrhINoSc0LeOx5rGIFdqcEG
         mQLk1yrgk0tfrGN3zBqWdFO/RhROvC+j57yUpR9SM9X9GsT4pqBoUT6EhMsnBnKF8qXf
         gZ7arqIJYqKHkiubo7MECijpRnGTuTjNTOj9RvuB5Z3kvhitIQe/epPJWq4l2nYG0tFC
         5UEQvPpqYpzcGcLUrGMzxIBATyBKKe9vuG7gTMXI43Bt5Y83kSIp/eeonou6Z5V7IyPE
         q9bg==
X-Forwarded-Encrypted: i=1; AJvYcCXMENYdHdNaAeX3OGvARijVwFx6vVEIWbwZSGzBhxNxtK4XWeOG1oISlHKVsg364hBKj1qFD5rx79RGl4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywaqp5Z4P+WQ/AylBU2LMZzbd+xMAkW0a4khWm0ct2I+FnI5xZJ
	7ngMJrOsqFs2sFvVZ86W7pTP+EO9piEHU30OXQFNWtJZLrGKQjfCkQvDKL9yK/482wxQU1fmW5Z
	oUR8bnqJ96yd2Porb1UXk82j2yPJ49NyTwQOlNA==
X-Gm-Gg: ASbGnctIWNnwW2TWU5FHhByRDMNPzlcaWru0EJYoYWpEFwI5f66VbN/J5l3ACtEm/+k
	FaEklXjs3IksoWvIYFUCcLIuL5phldWORrlBvoJ6b2pvsPdaCHcT2GD3l8E6RV14b703lmfqClR
	VnW6/Dg86ApRiHgxvGV+U/ZNE=
X-Google-Smtp-Source: AGHT+IEyxeKdaSkt651+21OQXccVtgFy+5WZ9uKiJGH8I9fe/+huCQCgBkk3lIUQsz0H+FIvtBdc8x1f/cGJIM8GB0c=
X-Received: by 2002:a05:6512:3f1d:b0:549:8e5e:9d8e with SMTP id
 2adb3069b0e04-549c362983cmr681438e87.0.1741950308554; Fri, 14 Mar 2025
 04:05:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312-pinctrl-msm-type-latch-v1-1-ce87c561d3d7@linaro.org>
In-Reply-To: <20250312-pinctrl-msm-type-latch-v1-1-ce87c561d3d7@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Mar 2025 12:04:57 +0100
X-Gm-Features: AQ5f1Jr_N7K7lEmvAgWDKBNNbb6WNXI3ALMBHl9pGsmXAlMGAySw6CoFSe50v9k
Message-ID: <CACRpkdY-zRy9h9bg-sJRr4Ux9rC8ZnjGxN04OQ_ZaDzN3X-SDA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: Clear latched interrupt status when
 changing IRQ type
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Douglas Anderson <dianders@chromium.org>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Stephen Boyd <swboyd@chromium.org>, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 2:19=E2=80=AFPM Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:

> When submitting the TLMM test driver, Bjorn reported that some of the tes=
t
> cases are failing for GPIOs that not are backed by PDC (i.e. "non-wakeup"
> GPIOs that are handled directly in pinctrl-msm). Basically, lingering
> latched interrupt state is still being delivered at IRQ request time, e.g=
.:
>
>   ok 1 tlmm_test_silent_rising
>   tlmm_test_silent_falling: ASSERTION FAILED at drivers/pinctrl/qcom/tlmm=
-test.c:178
>   Expected atomic_read(&priv->intr_count) =3D=3D 0, but
>       atomic_read(&priv->intr_count) =3D=3D 1 (0x1)
>   not ok 2 tlmm_test_silent_falling
>   tlmm_test_silent_low: ASSERTION FAILED at drivers/pinctrl/qcom/tlmm-tes=
t.c:178
>   Expected atomic_read(&priv->intr_count) =3D=3D 0, but
>       atomic_read(&priv->intr_count) =3D=3D 1 (0x1)
>   not ok 3 tlmm_test_silent_low
>   ok 4 tlmm_test_silent_high
>
> Whether to report interrupts that came in while the IRQ was unclaimed
> doesn't seem to be well-defined in the Linux IRQ API. However, looking
> closer at these specific cases, we're actually reporting events that do n=
ot
> match the interrupt type requested by the driver:
>
>  1. After "ok 1 tlmm_test_silent_rising", the GPIO is in low state and
>     configured for IRQF_TRIGGER_RISING.
>
>  2. (a) In preparation for "tlmm_test_silent_falling", the GPIO is switch=
ed
>         to high state. The rising interrupt gets latched.
>     (b) The GPIO is re-configured for IRQF_TRIGGER_FALLING, but the latch=
ed
>         interrupt isn't cleared.
>     (c) The IRQ handler is called for the latched interrupt, but there
>         wasn't any falling edge.
>
>  3. (a) For "tlmm_test_silent_low", the GPIO remains in high state.
>     (b) The GPIO is re-configured for IRQF_TRIGGER_LOW. This seems to
>         result in a phantom interrupt that gets latched.
>     (c) The IRQ handler is called for the latched interrupt, but the GPIO
>         isn't in low state.
>
>  4. (a) For "tlmm_test_silent_high", the GPIO is switched to low state.
>     (b) This doesn't result in a latched interrupt, because RAW_STATUS_EN
>         was cleared when masking the level-triggered interrupt.
>
> Fix this by clearing the interrupt state whenever making any changes to t=
he
> interrupt configuration. This includes previously disabled interrupts, bu=
t
> also any changes to interrupt polarity or detection type.
>
> With this change, all 16 test cases are now passing for the non-wakeup
> GPIOs in the TLMM.
>
> Cc: stable@vger.kernel.org
> Fixes: cf9d052aa600 ("pinctrl: qcom: Don't clear pending interrupts when =
enabling")
> Reported-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> Closes: https://lore.kernel.org/r/20250227-tlmm-test-v1-1-d18877b4a5db@os=
s.qualcomm.com/
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>

Patch applied!

Yours,
Linus Walleij

