Return-Path: <linux-kernel+bounces-371367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E489A3A1C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68BF1C221E3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458361FF7B3;
	Fri, 18 Oct 2024 09:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="IpMGg66U"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A811FF60F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729244125; cv=none; b=M0s2dlXle4LSiDmhhnJDmiOnEpOdfWu5g6h/sMLO5uhLNosBe+S6myRbcDIXaai1v09OqPCu/q8AI1wp2J4eJ+piZY+6uuj7+I1jHpZMZC/tRnPPhdy/6pBfT4Bgf9II7PPNQO/cunWh++K41tGFw2LqOVXzCmla3D+pTGhtzJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729244125; c=relaxed/simple;
	bh=bek+YrEWpRyaKUYvuqdDyBQjCYE6eaX5Fqmn+FxpHoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfJm9hUyTNeXa8axnj/x6yMXmKemYJyPNAytaDUbEXVXxntwfgVwFfN9GqT+rWrJ0I2CShFYYF94rSvEulfFjtJYJkgQshXoNm3Mk3dV1MlZcpACGW99xqgryNfAAxmI7fDhTptenDnwQEKKkqKw25pM8zZU3jEoOeay5l+H9jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=IpMGg66U; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e8586b53so2493186e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 02:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729244122; x=1729848922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bek+YrEWpRyaKUYvuqdDyBQjCYE6eaX5Fqmn+FxpHoM=;
        b=IpMGg66UlA/L6DgoesaSBV/b2cj/PaELs51vHPtUzf05TRBkYwfj9/MWCZgWA9p9sx
         5bJ3KH1HNyAg30BTmyVQ4fas5XNY+qep7Yafg6rEl7qgwyvJtaR6y+OrGJb3QY3PxqHc
         /cWF41tMQSKmvNsIS0RAzwKNcQ0ZcH6QlDAfo17jaFt2gX1n4okgDZRX2kpzaucwSDv5
         SxuPx0cBmUZewQJrcciZwWaeo9Xuc0j80p7HuNnbvd6soqTzcZjQXlK7BP+JbnoeR6dx
         zRb6SFC6pyq9toweWl1yzKB5rZZjzIXWFal6jiSFrF/Pyi+zY4fSruLjpZsU9p2vhyIA
         pBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729244122; x=1729848922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bek+YrEWpRyaKUYvuqdDyBQjCYE6eaX5Fqmn+FxpHoM=;
        b=uioG+600cVO1AyVfelq8bPQQMxVRUzREqUfa0ZLamKielSPvfK5taJwI8bo7UiSRFN
         d318H583lxfN5/5RsUB45h0H/5mFLwaof+OeHgAyv1gIiBeQKFKS6XyQtlpiX5V7QIS9
         Ld08H84dNufUUZ8B+iBYiB7XKZn6HIB5cfELPWHZnuzNHTPQg0cStruK1WCVSr/Pfpjz
         k4P1UEpt0Q4IvlwNGpl0M5td8owN0wv+re7R99Ri5jnyjvsbrYh9MPYjCnwaVvPoy9qM
         jhGHvcfQRZVKjfiWKzxOpJFQbJIjKTJwBMVWCEAOKqoJYYsIjV6eMcNVydDSylC1HZhO
         RInw==
X-Forwarded-Encrypted: i=1; AJvYcCXqC3G6iYGTU4pRqobrHl39KP0FKiP99/zsGHxjFZF7Kesgu+LPG/LW3Kwg60HOTiwnNSdZLhVCVs8YgsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS7eiXfkz8QTr24P5VQJCZHi6ASOZkWguuYYpY1JbgGWR78UZI
	w6CFFccYOdA3Sda/5yQoo8zKEsuiVXNdxBnoAusfgrmTQin03JwCVVuYXFt/JtmBlIUmo8WAHGC
	iezOhlBrpYvxLuily+s/aQWeTnudN3w5KfDsYlQ==
X-Google-Smtp-Source: AGHT+IFgPE68BnFk2E/viiVozXsEhEPq4/B2uBNfhDuMdWqDAqf1efDOBxlm8jQ3zwqOQ2eqZnNBlTBsM9ySv4GdgEw=
X-Received: by 2002:a05:6512:110e:b0:539:8ee8:749e with SMTP id
 2adb3069b0e04-53a0c6a58bemr1991127e87.3.1729244122351; Fri, 18 Oct 2024
 02:35:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007092447.18616-1-brgl@bgdev.pl>
In-Reply-To: <20241007092447.18616-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 18 Oct 2024 11:35:11 +0200
Message-ID: <CAMRc=MdK7Xjf6t+9zNohahmLFWQAqczJd6v6TZepg+23vyzzxQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/pwrctl: pwrseq: abandon QCom WCN probe on
 pre-pwrseq device-trees
To: Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 11:24=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Old device trees for some platforms already define wifi nodes for the WCN
> family of chips since before power sequencing was added upstream.
>
> These nodes don't consume the regulator outputs from the PMU and if we
> allow this driver to bind to one of such "incomplete" nodes, we'll see
> a kernel log error about the infinite probe deferral.
>
> Let's extend the driver by adding a platform data struct matched against
> the compatible. This struct will now contain the pwrseq target string as
> well as a validation function called right after entering probe(). For
> Qualcomm WCN models, we'll check the existence of the regulator supply
> property that indicates the DT is already using power sequencing and
> return -ENODEV if it's not there, indicating to the driver model that
> the device should not be bound to the pwrctl driver.
>
> Fixes: 6140d185a43d ("PCI/pwrctl: Add a PCI power control driver for powe=
r sequenced devices")
> Reported-by: Johan Hovold <johan@kernel.org>
> Closes: https://lore.kernel.org/all/Zv565olMDDGHyYVt@hovoldconsulting.com=
/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Bjorn (Andersson), gentle ping. Does this work better for you?

Bartosz

