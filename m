Return-Path: <linux-kernel+bounces-349438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D46DD98F61F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 20:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6AE1C21793
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 18:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21471AAE37;
	Thu,  3 Oct 2024 18:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ky77V5bT"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5816E2BE
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727980232; cv=none; b=jPCYpYqX7TuC6SfiQjW9p7+LSjGBFZwwcsXw+mn+Xnb0aPoZLYV6A7LQfAH22MLjP9pWbs98/Nyd2xbIY04TZ9OfNCSroJ1BdnkSLIaEj9r83tHFAyMiDtICCFusZmUB1rs7WH1Q1g7RWEcZQyh9F8495YvAOViyHcqFCiztY6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727980232; c=relaxed/simple;
	bh=c++Lte/udt0jLRhLlSKN7fA6Bnq9Rxf2y0Cj+HWhPvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IgGtE7V+pmtxJ70kEf++tNd0GnuvwOEsLo8EeKGpSTBTCZMWX/bErXgbM97L7DcmtS52MI8WAP4ryiOkzS6FtPBwCHn5wsmvPLILHyubk9JaW8R9Ie25R0+EI95I1FcT+zY/8j3B37nk7qWOAgfIHu0S5Gu+q5a7tb74aoUk4xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ky77V5bT; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5398e33155fso1681011e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 11:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727980226; x=1728585026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c++Lte/udt0jLRhLlSKN7fA6Bnq9Rxf2y0Cj+HWhPvA=;
        b=Ky77V5bT+NZ4VKyF9ecjsztDbl4sUMB85rtmpfY9RbzwnC9mgGcmj+VCeya9/gfnUu
         dyeApDNXP4EzK5xS0sx9OcCA1EB/sW1vMMo7woNGNnrzb5fVQWX5HTn5Q0A53nVjxPwj
         xyC5C9AstbYoLyVC1pWI8F/WGgnbGJQ4QrH48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727980226; x=1728585026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c++Lte/udt0jLRhLlSKN7fA6Bnq9Rxf2y0Cj+HWhPvA=;
        b=IFhF3BQ+Fjy1cSNZWoy0C13RSQgmwg8iliW+zWVh8O2SpSjaxzV4drLYPb+J3S+zQ2
         FyVcDteQbojHnk19pZ1EdeSQ+Kxpa9s+lNt0sZwqsl00VviJLR2HxcNeTmVGMXHU6RiV
         neSL1VL+IPTz0mqmC/fRk2PVydFcQfeKRm7fDK2TqXrOej41JfPWEVZSLkkJoPBrhQ9p
         qKRYZfBQk8ROYu3Eqimc7mkdad+LBs+e3kJUAEvXrV3VHzjcVE/fIULuRMvVlnX7kahz
         biHBY4h3RmelREaTNP/FgpKTdn+/SFOt7xtyuTeLkJytCDURmhUMheGNW595VR5MDhDD
         0Wfg==
X-Forwarded-Encrypted: i=1; AJvYcCWbhlmlL/CHcdudhcl1DsAsQ75+q8tpbRoR+iI4QrPWaHM9cFlevaR8c5UnlfjgRM9Tk2JVAcGyi+rBTbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR59V355B0lEIwvvZrGsKYhjAeOAy7WSjusGH5RCF61EZ6d083
	xGFd0K6D6HCu37ndLHHNMfyeA/POtgqh4KArergsepKvMjw3owApjb/vhZggVZtFUD6XSueJuZf
	9fJdE
X-Google-Smtp-Source: AGHT+IHXxtiX+ahXkyiHXhHhb11//X5+RoIClypKSI3W5jemKT+rUED9O3UIlfmGk1sHGURRHY2Vvg==
X-Received: by 2002:a05:6512:1247:b0:533:46cc:a71e with SMTP id 2adb3069b0e04-539ab9ec756mr182436e87.54.1727980226235;
        Thu, 03 Oct 2024 11:30:26 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539a8297746sm235753e87.127.2024.10.03.11.30.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 11:30:25 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53995380bb3so1658996e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 11:30:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXS4ANkEu6p9gB8mdTq7H33cj/ffBDMKNOclWwwvfRNmruOBihJIPuHoBPk5nRp8JuAuYuciVsm4ZAZGiQ=@vger.kernel.org
X-Received: by 2002:a05:6512:2211:b0:539:9155:e8b4 with SMTP id
 2adb3069b0e04-539ab85c137mr174931e87.2.1727980224394; Thu, 03 Oct 2024
 11:30:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001125033.10625-1-johan+linaro@kernel.org> <20241001125033.10625-3-johan+linaro@kernel.org>
In-Reply-To: <20241001125033.10625-3-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 3 Oct 2024 11:30:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UoU5Nd7sW66cjQzor+BP+W_f7uw0MGRaF6y7PH7KRN_g@mail.gmail.com>
Message-ID: <CAD=FV=UoU5Nd7sW66cjQzor+BP+W_f7uw0MGRaF6y7PH7KRN_g@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] serial: qcom-geni: fix shutdown race
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, stable@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 1, 2024 at 5:51=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> A commit adding back the stopping of tx on port shutdown failed to add
> back the locking which had also been removed by commit e83766334f96
> ("tty: serial: qcom_geni_serial: No need to stop tx/rx on UART
> shutdown").

Hmmm, when I look at that commit it makes me think that the problem
that commit e83766334f96 ("tty: serial: qcom_geni_serial: No need to
stop tx/rx on UART shutdown") was fixing was re-introduced by commit
d8aca2f96813 ("tty: serial: qcom-geni-serial: stop operations in
progress at shutdown"). ...and indeed, it was. :(

I can't interact with kgdb if I do this:

1. ssh over to DUT
2. Kill the console process (on ChromeOS stop console-ttyMSM0)
3. Drop in the debugger (echo g > /proc/sysrq-trigger)

This bug predates your series, but since it touches the same code
maybe you could fix it at the same time? I will note that commit
e83766334f96 ("tty: serial: qcom_geni_serial: No need to stop tx/rx on
UART shutdown") mentions that it wasn't required for FIFO mode--only
DMA...

Aside from the pre-existing bug, I agree that the locking should be there.


-Doug

