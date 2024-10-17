Return-Path: <linux-kernel+bounces-369832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBF49A233B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB2F1C28A97
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8EF1DE3B7;
	Thu, 17 Oct 2024 13:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pExeC9Hc"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B468C1DE3B0
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729170710; cv=none; b=odDbHIDWJIFwazuT0nJaqdatEuBIC1/s8yuzii5mH8rmzoZVrHtiMQUbRPgAnjE+OkHt/qW1Ez4nr9p6RnmP/CMVQT48MLZpSARcM9Q3VkMFDG8zaddG0TDcN+KaxjvpSiF5FnvhcSuCI12F4a0Xwj/sNDkXckApdQ0lwIlcMmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729170710; c=relaxed/simple;
	bh=aLH7OvsOxUR3HLTNUe4piVOzHeynBPMA8XfCziKa29A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hCUfn7GUEtVC1PELPpI6DK7hCCY+vaWPiLJcBybZAVJPpCRt9KVgMH5bND7qVKg40x7m5UheM0bzAqatXr6gjzKcu7CVBoDX3hXeMKqpp4UWa6KpCa9jJKWdirFvBou4WuCpOHDZpPXEU9g/UAbZrG1+TnF7+ZdvKV/YTmkDD1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pExeC9Hc; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb58980711so11891551fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 06:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729170705; x=1729775505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLH7OvsOxUR3HLTNUe4piVOzHeynBPMA8XfCziKa29A=;
        b=pExeC9HciYEFfNZmn5qfftyaoppmm5uv8usNTbFg/QPS3dehG2VzWjTpD7UsyQjhCW
         yEnxh8PN4eJW8gbs+3CwC7NPB9/w7GSLuOpWAhv99lxi0pPYNiU2XHxT1DIjFIHzzwDy
         7sDLXRZYg56+evuQuctwEOPcmeXv0KsWnsHj/GwAzCFwldgdVG/vnqN21/UNasSkXI4h
         101NjmzInx90KAxISZ0/ZyNMTuUu0C8cvk9AXvNQnPYyLpW6AzhrT/Mkg1TXADL5/c+6
         4tSqtW/lflygakVzFzdOYmyUM0Zcl82PmmN1QnCxTxo7KbF9uiQ4Xtm7GAYDZf2g0dTQ
         AObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729170705; x=1729775505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLH7OvsOxUR3HLTNUe4piVOzHeynBPMA8XfCziKa29A=;
        b=TPMEu+hDAsvAcfosyoin2b5Ip8SfM+kDnPw/aibMs3JhUVwmP864WE9ZYX6GfpeLsa
         PLP8nO/pzgWuko7bzQ4F2Ad2tDNiQbb+nVvpv35V50zg389/rxUUzs8H+CUduGWc3Fwa
         bgItoOYBJ5GxdIJH7TtV7ziKPgfHFg1VhdyippswXK0gLh14ygHZttP3xd9MIl89P7l/
         hPwKaivyynbp7GL+22yrzqs90evKi+E00ajKKYenf+It1e8J+Ge4UA283l899dWw0/aj
         BJvmKmUxSTn6AxxJa59ghyTjCW8QJ5LMQ6p5O6YSEb3ovlZOwj5pfFH43GuHhgl9PdzB
         RaeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZLp2NV+HPLHy21H1ldMRVaiDndLwY/rj9UR+Gvf08WIyurfD+b4dakm5KvsOsDG7Okc5YGZmgXpxi0P0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhZwp+WBOo6iWDJ0uo33NWXaivRj7ls2g1PXXezZFau+/8IAWQ
	FxIiZAykeeA47BjrnvjE4O6b+zgCj38aLAzbZY+VGFpu2sSeYFNlYRiDX379ENuVCxFTBJkgoxO
	FDllwWxteAHUMoauplCrwnmY/O/9njZApSK/PZ9xu4oFMZWr7
X-Google-Smtp-Source: AGHT+IGeczUw0X+jpBNy92OMjij6ePEZ5fWwDiYlvhidwPPcE35grKujR1BomvUIeWB7B+SgmhXrxKpCwxOVWLw9fkw=
X-Received: by 2002:a2e:b8c1:0:b0:2fb:4428:e0fa with SMTP id
 38308e7fff4ca-2fb61bbdf56mr46303941fa.36.1729170704854; Thu, 17 Oct 2024
 06:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017121447.73754-1-brgl@bgdev.pl>
In-Reply-To: <20241017121447.73754-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 17 Oct 2024 15:11:33 +0200
Message-ID: <CACRpkdZ83=ivQrq2Sr5kk33MSSNrQXw6Wx-kwmF_hBCdFgeLMQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: max730x: use devres to shrink and simplify code
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 2:14=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Use managed variants of gpiochip_add_data() and mutex_init() to drop a
> label and lose a couple LOC.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

