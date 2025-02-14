Return-Path: <linux-kernel+bounces-514716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1471DA35AB5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 774093AEA78
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5858324293C;
	Fri, 14 Feb 2025 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k6vFLql8"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585E72163A5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739526454; cv=none; b=S7kqCW5af07amM4c+QMPJ7VpTwqgvhUWC1JR7/VEt3oKZjTg0okGW4b4A5IH/0J/p24IlJuPJfMjlDA1NFkNIbST7ETQzD0C71JvExcmyS3vr+0nN8tNWd8FCBc1d7Dwf+ZYmLmsk3qcFfCieqDLnbOzS2srLIbSYCpx6rhNPn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739526454; c=relaxed/simple;
	bh=iWY7ja7UwmuXlbTC+SdiHmLKKlAd/FexZHJ1iIoOUyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IxHUEwn1kEmQ6eDLgKVqKe10MJy6MoqXkUVmeLXQFO5BRwjJBN2UikHB+3W0NiPiTorZIwj8Thzi0YHcTnTwolDKCKr0iv0DQCmgtuBLEwMF3VWPuJQvvwK3Nuk4xYaFxUr9i3IKVHcGrjZ94vDE9BioChhHpfDeHWhp4S+FAYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k6vFLql8; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5452e6f2999so43391e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 01:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739526450; x=1740131250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWY7ja7UwmuXlbTC+SdiHmLKKlAd/FexZHJ1iIoOUyY=;
        b=k6vFLql8ROlnSEZrhC4NdBBznFQ3C38XKhdA5TiKcHPmdr+C59VWyOpn5AAUNU9ttF
         Blq+lWdlxHrCVytSxxyj1MK7QZKuk0Hi0kaf2dC+gssDqV1hNDsosOKE9huGUShzL7hr
         N1ldBjEBKIrfYaagjRCIpdK3lKbVb4C/r9QRzprVatL0Zda9xiI+q8r2JnIAmFHZrlNN
         tLNKdFfIELMZUGElZ9y/KPY5QhUBMI/5Pj+wHkYxS9c+TcJF5cOhIE7x/kupyoFHdZ6Z
         uMnMu2czBjlADOKEjHNkt0lORhwJSMZkuFKN07wEy1FWCVrF3xznK1vlqL8pYy8Ly77F
         M0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739526450; x=1740131250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWY7ja7UwmuXlbTC+SdiHmLKKlAd/FexZHJ1iIoOUyY=;
        b=fegM3gglmYLvDnV5KxzcLry8ndge/Bl+FjSbLoSxWMBbw1JjtzSMR1rkm/0Ua89Kft
         LE4dNEpf+4Tkh6EROGpbqStc/YSuV/dQj9A1O/D7PRZNPLz67bZe/dtdYEUfUFLaaDuH
         gfIRpnGfO3K6W1h8dZCGNRKh6rdtf2i6N6pAM7A0K7utE30FWJx57ujHFg4ISg9B15p1
         LLhiEP9QQFVuWuT9R3gwenz7TKAKzcF23FI7f3lvuTktAjte+otXQSfU+tMzCfnd77zx
         xdTK2pErYI0qRh6+jvzapykFOtL7HZ6SVu1VJEybeRaxsizDhbrObBSy3lM3dTZwqSIK
         Hmqw==
X-Forwarded-Encrypted: i=1; AJvYcCX7RaE05PdZzfsJB6vbY4UZeet2dT2hupMN1yUE+u2riLgJ5XsyVEJzbzvcsZhqg0CS5bmJWYY7DTYOJIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz41wcQ1FgN+C9S9oQOfn7WOimzDw3B80jQ7OyTr1bZqSW8bI/Y
	qvG3SDCpMwi9yfJWIOS3SZ9xsbxiuKB5K5kfIHksQpfJZF7gqEK3Q5Suxgx5g4fzIac6zCZQjRS
	6IaNCn291KOXBBW5GNuQXDSFX4QWavohFY7spRw==
X-Gm-Gg: ASbGncsSYAYMS2f7LaUozqEvt896PxbF7YljnlVEfRGIVtIMyiTJDfrdSUmVXyMpDjD
	REjdqAVaiqMNn/GP2XzXpIGJfwQwGKNJc5UUF94tjlw4FWYQgUkOCBtKxB18wvONpMVIObRbT
X-Google-Smtp-Source: AGHT+IGsVHCl29HYDG1NhwBtr+SJRsm0EHnF9ZUrWXRkU5DCNBBxAGHBC27Cu+0jzm6I8M4nBvjNYCMzV77t5Den0uU=
X-Received: by 2002:a05:6512:2244:b0:545:11fa:caf0 with SMTP id
 2adb3069b0e04-5451dd84c15mr2266055e87.6.1739526449521; Fri, 14 Feb 2025
 01:47:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211120847.42437-1-brgl@bgdev.pl> <20250211120847.42437-2-brgl@bgdev.pl>
In-Reply-To: <20250211120847.42437-2-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Feb 2025 10:47:18 +0100
X-Gm-Features: AWEUYZnb7U0WXJs0yLUVl5mVvgJsY3A2dqLGhhpos7WoxgsSICOd3mvm6j3gj2E
Message-ID: <CACRpkdadUTEGW4oAMRrkbn4o6GOqcQxSLUXrHK8seni=WMj7ZQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: latch: store the address of pdev->dev in a
 helper variable
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 1:08=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Make the code a bit more readable by using a helper variable to store
> the address of pdev->dev in probe().
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

