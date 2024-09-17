Return-Path: <linux-kernel+bounces-331847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D720597B1F5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D0F3B2AB58
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A97817BEA0;
	Tue, 17 Sep 2024 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="yStfJrlM"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FEF176FA1
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726586003; cv=none; b=ZbUQrg4ro/gEANelqjX250lw3p8EcwxvlW4I/PXPEwywh/I4iE9I0J02KiELVLPrMoGLROq1Cd37OT8fyY8UJPRhiyqCiyGwpM9Wa1BfXCNPIBwdSvFJroUHgb6misMYaYZZ/uSslNVrGs7AiKgBrS/1SBnXdlxks8b3LcZ3pJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726586003; c=relaxed/simple;
	bh=C6BIJE5gYeC/g2Oak4zV9l7IfmZQnQtGYVUJTeQWod0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O7GVmhy5XQud+QdVgOD+Ff6ziSyprj5wN4PZyk6/sDYHpCsfxkLMR9jOvkvIELVFAL/rHEs05EU0u2QWpZTZwx9nk7RkjmwcIgPx2CDQ8mnBQefmjx2kVYaEfiWx67q/AJT+QkJXoBHYI6o7tqtBOd1l2CJZp3hflUIJ7BbELEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=yStfJrlM; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f75f116d11so49181481fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 08:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1726585999; x=1727190799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9QCqlRh9eT2CMbCDWw6auXzAwjAo/ozmjDpAB5cjRo=;
        b=yStfJrlMhN4gbrtmJKgz2O1MF4AD9CH88Hy2nqW1pq8ElVywcJ9EWqGDOdgYxXttK3
         bpwNR7HMVpke9eioC5kp4efzUPDBtbLw/zwKnyiwwVTAUtoc+MnnWa/Bxdgmh/hA44HT
         BHGIcFBfWSANWEvCNbEIUIlgPA0j4hRcZKBaIr8Cc5ol4CGb5cAjzT7KNzezLATyMX+c
         V9FSbsT3RqhDYQgR65gGd6NEEakSeeB55APgcKITHi9TYhWNxuCYEfS/99nmVCfbM7Ra
         fv3smgOYTpVcrx0MNpN3lNBkS/txwcAoq6MUCn9iDgRrr08mWSWix2kSc8OyzXPobYka
         GWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726585999; x=1727190799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H9QCqlRh9eT2CMbCDWw6auXzAwjAo/ozmjDpAB5cjRo=;
        b=BLFCa0E4LZr32E8AthNqFKKZj1Cil5MeDjrOz1HUP01fP/GAFMhyQddqSTm5GpYN2M
         xWq/c9ACjjgU0vW4NHeKyvI/RQ+XCw4RL+nF32sgQpcKsLCAFUolKLSoJ/zJ7AT30w2Q
         t2jDF1UjqeA9KLQoRulAPdXujQCNboxA6/0f5yg1wRdTKtS1040msr6J7UXx9jpwlTvH
         JJsPYQ8LzT3eykHYZW0dX1ElHYPeNPfQiBhKgaC/ileodCnTfkhw0lIfDNXKhlSEwCDT
         ZG4o5rvmNSEgsrke3lvuz0RKjd5psjN5S2bhWP9zOKiMtg5lnnzwCTIwOKj4u5rVFVqs
         XDTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCxoSo5QJNEq6c/PooACx4KwjODClyvicoo4NMVeJJ9baAYZ/NPoPl885BG1/PnvwbRDQGUmG0O9W7nDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/gE8FULUnmfBjbil1GUsTLVgCzFtyn/QQKeRkeqTrYdem9oNq
	7Q6DqkC3GS9fpsqTCMJtyJl7VmaflNyy9JUYcUDR3KDHOrGcdlK3X4oMPVKGn1AYZjHsqye53Dd
	9/54GPSLIxjYamBeVioQ+gRzVCEpQFVAIZ+lXpg==
X-Google-Smtp-Source: AGHT+IEjk8ZHjlHyyFFjPJuCGwJFKhZ0kGO8bejy0WGDuXef54JZ6Xsqkq0B58+CUBKCRRCNpr78RpMazH22iNaAcZ8=
X-Received: by 2002:a2e:bc19:0:b0:2f7:5e7f:b4e1 with SMTP id
 38308e7fff4ca-2f791b4d3fcmr82055101fa.30.1726585998980; Tue, 17 Sep 2024
 08:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916172642.7814-1-johan+linaro@kernel.org> <20240916172642.7814-3-johan+linaro@kernel.org>
In-Reply-To: <20240916172642.7814-3-johan+linaro@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 17 Sep 2024 17:13:07 +0200
Message-ID: <CAMRc=Md-B3MCdjBA6Z03Tn09Qdq_O=2Gij=0kr8HiLtpp11kVg@mail.gmail.com>
Subject: Re: [PATCH 2/3] serial: qcom-geni: fix shutdown race
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	stable@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 7:27=E2=80=AFPM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> A commit adding back the stopping of tx on port shutdown failed to add
> back the locking which had also been removed by commit e83766334f96
> ("tty: serial: qcom_geni_serial: No need to stop tx/rx on UART
> shutdown").
>
> Holding the port lock is needed to serialise against the console code,
> which may update the interrupt enable register and access the port
> state.
>
> The call to stop rx that was added by the same commit is redundant as
> serial core will already have taken care of that and can thus be
> removed.
>
> Fixes: d8aca2f96813 ("tty: serial: qcom-geni-serial: stop operations in p=
rogress at shutdown")
> Fixes: 947cc4ecc06c ("serial: qcom-geni: fix soft lockup on sw flow contr=
ol and suspend")
> Cc: stable@vger.kernel.org      # 6.3
> Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 9ea6bd09e665..88ad5a6e7de2 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1096,10 +1096,10 @@ static void qcom_geni_serial_shutdown(struct uart=
_port *uport)
>  {
>         disable_irq(uport->irq);
>
> +       uart_port_lock_irq(uport);
>         qcom_geni_serial_stop_tx(uport);
> -       qcom_geni_serial_stop_rx(uport);
> -
>         qcom_geni_serial_cancel_tx_cmd(uport);
> +       uart_port_unlock_irq(uport);
>  }
>
>  static void qcom_geni_serial_flush_buffer(struct uart_port *uport)
> --
> 2.44.2
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

