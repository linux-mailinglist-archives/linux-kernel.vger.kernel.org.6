Return-Path: <linux-kernel+bounces-295523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1BD959C47
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA13281357
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B03191F6A;
	Wed, 21 Aug 2024 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="q41EhNWt"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F381155307
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244368; cv=none; b=IfbofDuiXluSOIePklS1BitWmOPYP/Z1isXaDOUllfbsu4Pn5JNn19W9Q6EJNPLg8ktLkxfr10nLEElOuL/1GocK40NJ4j/La4G45yCsfy5MPFzmNhMfGNQK+dxhp3F/8aKXtBaOm1DyK2Il8BD9mgn0GzMbtZs9hmCTMhf6LEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244368; c=relaxed/simple;
	bh=hiR1Haq30NxfLMtsVDbu0nnLT6exfBNX71lnvpiNLFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8F5M+2IMoDVzmvfdlg7u8aWacvOaHQAgqvkAzw6iHlG19zayfMdX92GKRKJj8BeajNE5xcjeVg3qCsJ0H7+VL1Gy8jlTbC2au2CLDCtkP5eruWDkKGQg0DMQXYeKgQiyX326CpB3gY5yu+2sXleWFktoiCw7qicAl2a3kImDHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=q41EhNWt; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f3ea86377aso19389071fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 05:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724244364; x=1724849164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiR1Haq30NxfLMtsVDbu0nnLT6exfBNX71lnvpiNLFY=;
        b=q41EhNWtgX8WLc6zeVbeAUGL/bhDtQNP57p8MR9CIvV6qidK8MSNXaTR9jKmPbhexl
         SxpalRgAYEJcNlNbkbw2L+gVhMu0QEc84TH88T89GrasXdxvHcrleezy3a4SpgZCuhzX
         FwRUGTE4FTyoUxvPcuR7Rh4/3HEU/yz3yemSs9OJMqlcmYLZ6NtgZ4nN9eqUvTue1Tpp
         hb01vAAluNrP5QwRFlmeuyq1c90bKNZ0KqC6sLAzCxvYsA9Ual9oZouklMMV+nvLhn8d
         J8sNZisZUhMlmxZuHclBzeXBmZJ9ug6zsW5wEnQkiCLeCylQo2sYyG2JhyekCCQwiuH0
         /c3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724244364; x=1724849164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiR1Haq30NxfLMtsVDbu0nnLT6exfBNX71lnvpiNLFY=;
        b=IwBLPGK+adNZUR+5L0ZX2vcLLmZyHfM80stz5NDqWHa9Hf3yepOgemfzdsqc6KscRp
         z+B5VFn/sJNxGltf7OVJfDAuOpXR/fqA0mxfaNB9idCA/i/929bsMubmDVtQRElGocvG
         LemkKS7n2Gv1R42DLMxeIk5lF0O7PP5L0bnqFRTDZt0oXRfh8if6OysGW/u6l3G4bNNp
         j8q/fFOkyvUHgUHXNVLruAls+A/IT9CpTbJwxEfa0LafMqc8dxLI/og5cPGg7sr+PUXF
         XptSk1D72cYiLUobUcxK5D2/dka1aUJWA7TsgmmU1x/k3v+ShgcVwi+pClictjxzrsEI
         StuA==
X-Forwarded-Encrypted: i=1; AJvYcCUoH1Cw38s8srjUHXXs5/9Ob10VlBqnacDccQJ6zb0H7l7W3pJiJgSLfdyLlLDmzGFX5OWbZXyHInUToGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzagKS+iiW3ORi4A3/p6abqnQcgei1/D4gMkNJo6wqZnfvsf3Hr
	M1+X5meOuxFzC2T7RIprsm9xfN94QtNLiGxIgcLkbxi8MFrHOhkcDaNopzfUmQpzQKNU0O8z+SH
	0FAy7VKolbLDADnY1E5vlaUi2b0u5K0I/9p6pcg==
X-Google-Smtp-Source: AGHT+IEoyoaFzaTuBjS7UWRKkhT5wQ2XOqzoc1U9KRDb2oPtaGqMo9RjMJ/MuacPyZChbEXTgMD4LzxduCDtp+Rqrpc=
X-Received: by 2002:a05:651c:1507:b0:2ef:1d8d:21fd with SMTP id
 38308e7fff4ca-2f3f87e0c7amr14835921fa.2.1724244363623; Wed, 21 Aug 2024
 05:46:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821122530.20529-1-brgl@bgdev.pl> <bd793119-3a0f-40c8-8c78-201e2fcf9664@lunn.ch>
In-Reply-To: <bd793119-3a0f-40c8-8c78-201e2fcf9664@lunn.ch>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 21 Aug 2024 14:45:52 +0200
Message-ID: <CAMRc=MeaVe=JcT9KF4YaP-2jsPH=ApRjfhomwuJ+L9GLhh-Dng@mail.gmail.com>
Subject: Re: [PATCH net-next] net: mdio-gpio: remove support for platform data
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 2:42=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Aug 21, 2024 at 02:25:29PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > There are no more board files defining platform data for this driver so
> > remove the header and drop the support.
>
> There are a number of out of tree x86 boards which use this, flying in
> various aircraft, so have a long life, and do get kernel updates.
>
> I'm happy to support this code, and as a PHYLIB Maintainer, it adds
> little overhead to my maintenance works. If you really insist, i can
> try to get code added to drivers/platform/x86/ which use this.
>

We typically don't care about out-of-tree board files upstream. Having
users for this struct in mainline would of course be great and a
perfect reason to keep it.

Bart

