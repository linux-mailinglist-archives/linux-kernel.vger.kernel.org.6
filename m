Return-Path: <linux-kernel+bounces-360159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 853EA999546
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 00:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CC571F24695
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 22:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4E01E7C1B;
	Thu, 10 Oct 2024 22:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wa9j1rSx"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5661E4938
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 22:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728599802; cv=none; b=V8FXYUMOiDN7v26wDCLcxCv+JiCLly+ro+IFCu/qdnTPuhFhwk/TtOL+aAXoBoeRZIrit3qxJvhltPf4kUd4TCG+bo1ApjeORoI3wfJuW4zJ02jQBAhXZ6ubJE7z+soFQLoF4CQunlaS5undop/n+Pk9aNRE1Mwwsh//DqmvuTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728599802; c=relaxed/simple;
	bh=ndGUOdbmf0XLXi5qOt0/OM43ZwpMxj5j0YR7mZtrb0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rIZQ7IsZOxtl8cLyykI09R6x7QT2PRZmeg3ptWgJ0H38XA9ZQEs3lsmfWFKTzLXvz9+XNaCnHov9dj3SOdVT9URoPz9JLwGQcm6WBg5p8SMVsV/UAN4awSf2oFUkAzfdaID/pZOMmY+nAorXNV4zyx2XmTMNR1sHV8n8zd6/SmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Wa9j1rSx; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5398e7dda5fso1432823e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 15:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728599796; x=1729204596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyyxlBvtxdIx44gC6sdEnPAxTnLbnwRQOcfiWPcHmqE=;
        b=Wa9j1rSxtkPuaG2PLhc1lMwrXA3NrJHkqCdfv4ccIwGm28b7A1+vXWde6ATyk9H8VM
         3ggLieKpgCmnkMzSEiC4mkpRH+n+Yqc9+YRskfJ4ygFPzs5jy2kDPypDteNjw7g9XvK2
         tn9N+00xm58W35PV6dmdV3k8h8co4c3kY8tno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728599796; x=1729204596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyyxlBvtxdIx44gC6sdEnPAxTnLbnwRQOcfiWPcHmqE=;
        b=VRCZ10soANBHCFkvMb2JrV9l8iyuQeKSFxJSvs5ZjIDIW//4mwmJenVy/L4+Y1pLyl
         SE2SMSVhLDID0u9rByBwhPJNbIaw+W3rCVCzdfu9eihH/BDGa9DRf6N7KOPVl61Ggbvx
         gFQZJfATvrM5IMkFr2R9jrasq/jGByz/N0IG5ugi1JRYU4p1IzQpXaGdmsS2l4JLOBjM
         kBxmJue1ofN0sTgJ2GSA+aMkkMRx3gpZ3J0BK+djFvQ2CLD5vAYliZvtkjwPTwm/fSye
         SK/rBSoezgDSYpl2IxZYemhZWVroe5AQA46fAuk+WxULOdlP68mldFWVgSi4Vqsz8q+f
         ZV/A==
X-Forwarded-Encrypted: i=1; AJvYcCUK8tAu7xtu/kcBhpA/Q/00/TcAkbrPF5izzzdwBvktyDPfbW8G30y2CitPC+rJ0AlOqnR76neXJ3fafdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwewCYtlLsLjHtNGgPAVQKcMi8iOFIhz9DVbZ/NTYUHqsjOtX2c
	ZWAVdPs+gnlRUf6D0HIWuGy4xhcTs2mL95Dml8wwDlXI2UmqOCiIJOncmQkSIvaRS6TkEcG8ErW
	9Z8SG
X-Google-Smtp-Source: AGHT+IGqNMINeJ69i7f6N2U8QwO1DQmGUXNVCfBCA/E15suZqbhY5nXvrsWOjWVp2+r32oTeMi6XUg==
X-Received: by 2002:ac2:4e10:0:b0:536:55cf:3148 with SMTP id 2adb3069b0e04-539da4e16b1mr202918e87.31.1728599795843;
        Thu, 10 Oct 2024 15:36:35 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539cb905a8bsm408739e87.276.2024.10.10.15.36.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 15:36:35 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5398e7dda5fso1432766e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 15:36:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqiRXid8b4O3e8viuLHYKoKEeICae6UJSflb687urcgt2FWQg9Zq/+02BcAWATeEWD0jwfzt2iLoVgHuc=@vger.kernel.org
X-Received: by 2002:a05:6512:3189:b0:535:6cbf:51a3 with SMTP id
 2adb3069b0e04-539da3d5293mr199479e87.25.1728599794291; Thu, 10 Oct 2024
 15:36:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009145110.16847-1-johan+linaro@kernel.org> <20241009145110.16847-2-johan+linaro@kernel.org>
In-Reply-To: <20241009145110.16847-2-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 10 Oct 2024 15:36:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WvpOx1RHFdo7NSss3m922VqRSdsV6G+NnxyCjcp2XMVA@mail.gmail.com>
Message-ID: <CAD=FV=WvpOx1RHFdo7NSss3m922VqRSdsV6G+NnxyCjcp2XMVA@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] serial: qcom-geni: fix polled console initialisation
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 9, 2024 at 7:51=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> The polled console (KGDB/KDB) implementation must not call port setup
> unconditionally as the port may already be in use by the console or a
> getty.
>
> Only make sure that the receiver is enabled, but do not enable any
> device interrupts.
>
> Fixes: d8851a96ba25 ("tty: serial: qcom-geni-serial: Add a poll_init() fu=
nction")
> Cc: stable@vger.kernel.org      # 6.4
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

