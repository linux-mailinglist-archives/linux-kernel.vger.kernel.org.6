Return-Path: <linux-kernel+bounces-310020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298E0967327
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 21:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB46E2832CC
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 19:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F99717BB08;
	Sat, 31 Aug 2024 19:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="evNko2g2"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E89113CFBC
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 19:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725133363; cv=none; b=CS0O5M3UMvvALojIybicwJh22UAvQCH4JlaMF/1piXac0F55dtwHrJ6bzBulFf41MXyNAh5METszV0zeNkLcPGxbI9fWce1yswrB2N9oz/nkS2M8mYAFeOJfL9M3ddE6voALyIvPQtZ9SPGCh/SKpPnGbZnBvyHDfuePm4QuX4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725133363; c=relaxed/simple;
	bh=wLIe4IUlr3rXOUXYOCVMEg9+vli2/fTzveuqBdE9GHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gl1tE/sJHtOA2e5OuIYSfZstB7s01sCeEkAVdzr2ZW7QfoIml0NXortDGC8BNPmOCQ43Am3qPGRtPbcFwO9JxTvnNSOO/+WzWcLMw5c9B6Xt8T6+7b8CzwGSTTBJ1Sxfliyja5ck2CFKyNSC7UVp6G05BcTPdXLo+bUIT0vcgpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=evNko2g2; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5334879ba28so4104520e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 12:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725133359; x=1725738159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLIe4IUlr3rXOUXYOCVMEg9+vli2/fTzveuqBdE9GHM=;
        b=evNko2g2iluyBiyaibAI8EqvQYl6FxrhSJqrkq2DQbaI/uak4IZ6c/045UshEVsbGf
         Ea4/82IfO0k4892XxuKHWazNEBiFsefgUdqhoCW30mypKnvk6iXb3WFXrYc3JlCQ4i6p
         HxNfmPNdOvgygFQOACwqSFqhndrYsse2BTX4JmRMk6NOc4QgAAvV9P72YpsORouDU+/T
         4seATACXIDHP5O/2AtBgZ2/4xAUif6PxqYZdhdszAEd1f9tsUoMPOIRmw/+c6bdgpcMj
         Nt20y/EXmrlwlOLpsVjNBnWC4DlczfXj34a+1LbZ+j4x3Sj7YQk4dgBVhglZ/Cfu9dc4
         LUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725133359; x=1725738159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLIe4IUlr3rXOUXYOCVMEg9+vli2/fTzveuqBdE9GHM=;
        b=LehDGr72n6ILUbw1X9wCOnimzVhypfLy5fCwFREXBQahodiTSq8GQlgfEEEJVIuQMu
         ZFZA2mZcAnIYof1f/N16AE2WQG8YOkVH9+1MAK7RA8mAeWrzDV8mb1vBsTuoeNMWTbMC
         Mb3YhdKHQZCYzXvFfIIJ6OZb1p2Ljb8I1RLrWFXBdVnuAIIhHwykolcTgej8ag+7g79e
         XOB/KuLIpvAf9W9IPRKjkqUeMvjXo5Z0G31zzXINu8cuN1VfMztYRCY9XKRNWceODosM
         8hmruiquyGcm4Ya5n/BzYiSbl7d6W7krV2JQQXblx3sReQIpD4En6VCn+LMa3qiKoSO8
         33nw==
X-Gm-Message-State: AOJu0YzvWnL3UiqK2atlXWET9nA78GNG8oxsyiW0INrH1GVAYsgIt8li
	D4ENa0QAWK3aBRcqVoq3vqWtmNNTXPSnHC5X33nzxte3NgfHLWLVMA6ARdoUwUsn048cKSk2FbL
	3OWmRYkT8skpfrHKUH3igV2DTBjUHm7AEHv0KIdafZPDUCnXteZQ=
X-Google-Smtp-Source: AGHT+IGXaOAaM8ATTFJLTsPQZbvE8u2JeHXS1YqeKdSi+R09vxXwvH0uDqw692B7w/bHnB+Lqul6mKznyb5hXo7yP2c=
X-Received: by 2002:a05:6512:10d6:b0:52e:d0f8:2d30 with SMTP id
 2adb3069b0e04-53546bb8cdbmr4316450e87.59.1725133358269; Sat, 31 Aug 2024
 12:42:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819151705.37258-1-brgl@bgdev.pl>
In-Reply-To: <20240819151705.37258-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 31 Aug 2024 21:42:27 +0200
Message-ID: <CAMRc=MckgUfDFiO+4rsVsk3zQC9P7W7K3DfDfx7t+-0z3dKhSA@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: davinci: drop platform data support
To: Keerthy <j-keerthy@ti.com>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
	linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 5:17=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> There are no more any board files that use the platform data for
> gpio-davinci. We can remove the header defining it and port the code to
> no longer store any context in pdata.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Keerthy,

Do you think you could test it on keystone to avoid any breakage upstream?

Bart

