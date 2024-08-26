Return-Path: <linux-kernel+bounces-301094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF5B95EC49
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 970B8B247F6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800E213C693;
	Mon, 26 Aug 2024 08:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ASfzsf84"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A68912BF25
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724661825; cv=none; b=BbN/cs/Dx3wJzQcpcDaAXhglVCRI4RiChHljogvio4rT69upgTnRwJO7GXfQIFR1C/cA61fH1GL/cbPxFmtYHPNl9GpibmIubOcQ0v0tt8zcprSQiYV9S1xoW6/Q0j2hzPt1w1HzGP1E8JnpbtvaaViErvDofZEYo1uEByKqqrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724661825; c=relaxed/simple;
	bh=usDRGHjYoH2Eb1/rWVsYCToPL3nAPYOEug0n3l3P8zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qikNLMnALXbTX/9kHgJ9zVF8Xgej6P1oyL5VTEDbmXt9oOsINHGZbRAiJzlL/IDJLSNQa28Dn4EClJ3ckBIqRwUG29z8kKqhjADpXkPiOJqNnZ353SyMsDexNOzLDHes8u6E/MHFysgspuzSW6kDI5+JpFvo8LNV/hJqxxnDfM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ASfzsf84; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5343eeb4973so2932698e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 01:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724661822; x=1725266622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usDRGHjYoH2Eb1/rWVsYCToPL3nAPYOEug0n3l3P8zk=;
        b=ASfzsf845MQ2ug1YLhMNsKapOsBT10x+lujSQ3a/M5zVjNyE+tO7bUYJrPTJMEKB8y
         9mqDo7GkGxpKt4c5UmghJuFBbc3s6CdFlh1lLhKplmW2q684dPDquMVaejV0wEnyAByY
         IRwTvfikxQD/Upk43RfwHCWC3kyfS3p8xYx4OMaPfK834VTomAZR2we8YPI42ZTpBpz0
         M+a22xojpzdgowj2IzUVbLGFVwIFXkp/s57dcRPUf70L3gPU5QjulxUony+q6812hOuj
         KdHShZX6L9tVAJnRwM1tOQw6zwps5KzApT4b6LCigPuooyB8oR2lc+IAyy22DTqVmHTH
         8zug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724661822; x=1725266622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usDRGHjYoH2Eb1/rWVsYCToPL3nAPYOEug0n3l3P8zk=;
        b=hXQoZVDavGviDYlzpaWqhDBt7oab4HAPvqFF+okAY65jsyPeiyAKvJ6rbNDlylLUpJ
         mwpygG/ZsI4eTKT59nmv6e6Pmf2zOPzKpfgwrlcb65LnI+PJyvaVvPYUUptSnMiviNaw
         w37XrdY0ZkTiNCmxVgJHlMOpC6eLn4ibxJs4q+WMcrCb3YP4EHXEsNbRZau0I4AzG3Zo
         4uTtN56pvQj+F/c/nKGhWxhk+f2+quMI8yyGTbHJCsUZrdrPPb/HuRAaaMN0jsLgmu7/
         szn2L1lOgg6W1lrVh5QHiJ3bXwx9h6ZxwDvh3O6MU9DtGIV+qdoeG6bGrHOSvN9yTfEg
         H+IA==
X-Forwarded-Encrypted: i=1; AJvYcCU4kTc1W+rclbTywTpUUliNTxJ98uEhv5VEwX1Pnois+ffzoCD6g36BPmU8s5eJCIbhmHhwAFG5rHrXxvA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz89TbryIBL95HYAhG7CO7YUWkz98nuQVf42v4T8BfCuqKxJHfy
	G5KHDPkPcpZ2sUK7d0VPxdlQsNs+MVISguVKYPcBGufTUD8EK9IMFakYi8HJjVxSaf01Ehh3oTe
	XpSmYwiESykikFafwCGgpBCkolOG9jBuxi8guAA==
X-Google-Smtp-Source: AGHT+IFkTwcnJo5plPnhMtYmhDhxW2lAptg33ugIK5nbnJLQ9OpWsCc40r4XaS/o/lq2TPBd3L9MmYP9X8UpcBmDy6k=
X-Received: by 2002:a05:6512:3188:b0:52e:932d:88ab with SMTP id
 2adb3069b0e04-5343884705cmr8992095e87.23.1724661821948; Mon, 26 Aug 2024
 01:43:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822223332.705560-1-andy.shevchenko@gmail.com>
In-Reply-To: <20240822223332.705560-1-andy.shevchenko@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 26 Aug 2024 10:43:30 +0200
Message-ID: <CACRpkdYZSaONG6BMLv_j4Qe0x=8cka3rjMkf-uJ7WDtqc24HOw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: ixp4xx: Replace of_node_to_fwnode() with
 more suitable API
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
	Imre Kaloz <kaloz@openwrt.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 12:33=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> of_node_to_fwnode() is a IRQ domain specific implementation of
> of_fwnode_handle(). Replace the former with more suitable API.
>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Neat, nice with the small cleanup as well.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

