Return-Path: <linux-kernel+bounces-561278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE0CA60F8F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1752178E40
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D551D1FCFE7;
	Fri, 14 Mar 2025 11:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RgZ684Ni"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6841A5B82
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 11:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741950359; cv=none; b=PSnbmy/XxmllvxnNexyiHTd7mnQDXwGicjJxSmGYrRhLJScAkfwxIpXN1VFxBdAwo+fcaLhZuAmOiGacx9q+ZdL++JgW/Je9P0g5y1NFcBpL/lhnLusLiP5Evn55WRk+KD/Yeo/ZmLLkUhH0JyWxI35zUlSuUzyRpat30HN5at0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741950359; c=relaxed/simple;
	bh=XxBikUZY8aio3BzZ0PwzUhcA6cIoxXU6nbqOx8gyLzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JVAm53UNt5hLzaZXULy+yk73Tnf7QLHMiK0BSehCGhJGC7/6NyFIZHpMBWZ8m6OooKfqIC2Wh9YTGq1CEF8cMMmHwPa61kUkC5jPX2fYNlG1FpYNyc0PHLfTXk4iLVqA34TCsmBGtIsRIQYKbk1uX2zhvXjFe+6Z4j0+Q/kBzFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RgZ684Ni; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5499bd3084aso1968111e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 04:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741950356; x=1742555156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxBikUZY8aio3BzZ0PwzUhcA6cIoxXU6nbqOx8gyLzc=;
        b=RgZ684NiMVxyjEe2ggUmSWm2pHyOHmOvvAZFazNWOrukjHbCWik9Y+T2u1tEIHfN/s
         TtVhc09UAZgtCKrJLijakB4GP22ymg6rW8qf0i3ENDs+83HczkfNXJVyNMzE4WEOEirA
         jSbtVQ1thXolsIbG7YXmhuRjSn1yfV9j8LVjIfudMU+Y1NWbLAVac3+iwrjoB8S1O4Kp
         CLtczlp6cyZ4zsvacrp1niD9jZlL4A95svrv9io+QKyqFx/X9HmU0zsUyUTzYZhRlLui
         Oc6IxH8J9SxIz+RSgCegQKaNVKtzXhjMl3oLCsp5VFyryy1QGCRf/hwA8oFjJIxYaVxQ
         m2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741950356; x=1742555156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxBikUZY8aio3BzZ0PwzUhcA6cIoxXU6nbqOx8gyLzc=;
        b=JEWoxBmfWaTMlOfVqbKbeCUXYUL9XbKgX1rVPajNNckomY/PLAA2Lbdd+ffUBjSQLQ
         OxchmCfy+0ewLrN99hhQu/+DT6v0larpbfewYuh6a80FA2MEVplQs7n3aJ+gOlSbexOY
         3rblNcYDmfSAjVqhO4d9GDdwX3kpFFTwEyl5Y87qspfrZILyaZFSILi51U89G87pVTq2
         +M2a6NMN2MUMT4AJa+QEAAnV9woPH1Xirlg4KX6Mu1s5lM6fKLemjGo+9HpfrLLj3URo
         RPEUHJ2v3ATM6rDP7h+n4FOjfoJ6frPbN7mHxWuJgi4hQ0tfpvBh5CJTytq+ooEhdMcw
         lcmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyenfHmK0F04L76lxHXhtuCP1POB48vvrNR3WpXsbLCwfaT8Lguo0F0Eu1VMwgDj2IF2s0Lwr9HNUpAp4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3urszXIG5A5/PB5jihdH+6paQ8gIM5YiimdPibwm1NUWalcyK
	D0cQ0QMwbpuSgU072NoPF8Zhtr9bp/3yZteEFWVbfZZR4QuXsfXDxhdepI9rC4fxoRUfs3ozxch
	lUGdA7Tk7we5MkR2qz4kx6ybvyarNFb9OMMa4Kw==
X-Gm-Gg: ASbGncsybFm/m/WATubROJ40NC6JKoM8pN6koqlunnajKcTZO+l12rnKQD1UwGNIj+6
	HEJzxXaso7BxYd7Bndm57xh2nPfQTuSWBU3JxXH5j5FqNgbSda44U57uc6MR02ME73rwiMlNN29
	WEbl7ftHnZASldegdwuMRW2i4=
X-Google-Smtp-Source: AGHT+IEtWG3hGAPpwZpW2Kb03ek5XF1oybcCjHGNlFQDEQWQLDYho05PNF9pKqd+gnKE83MT+G5mKyZ2nU0ypW9l18U=
X-Received: by 2002:a05:6512:696:b0:549:8b24:9896 with SMTP id
 2adb3069b0e04-549c360f4a4mr746105e87.0.1741950355704; Fri, 14 Mar 2025
 04:05:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313-tlmm-test-disabled-irq-delivered-v1-1-f0be903732ac@oss.qualcomm.com>
In-Reply-To: <20250313-tlmm-test-disabled-irq-delivered-v1-1-f0be903732ac@oss.qualcomm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Mar 2025 12:05:44 +0100
X-Gm-Features: AQ5f1JquHlFLF2H3luwsKOipVRgfi7l4qhjJICzwca1VCtyRkDi9-duvsKNCvNc
Message-ID: <CACRpkdaXQ9=9+ec3VNSE1YXADbRttKx2wJQB+o+WHmzaNj5ZVw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: tlmm-test: Validate irq_enable delivers
 edge irqs
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Douglas Anderson <dianders@chromium.org>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 10:21=E2=80=AFPM Bjorn Andersson
<bjorn.andersson@oss.qualcomm.com> wrote:

> In commit 'cf9d052aa600 ("pinctrl: qcom: Don't clear pending interrupts
> when enabling")' Doug establishes an expectation that edge interrupts
> occurring while an interrupt is disabled should be delivered once the
> interrupt is enabled again.
>
> Implement a test to validate that this is the case.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

Patch applied!

Yours,
Linus Walleij

