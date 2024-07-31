Return-Path: <linux-kernel+bounces-268977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41825942BD5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85201F217E5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7BE53370;
	Wed, 31 Jul 2024 10:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2fXjVam"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E87B1AAE17;
	Wed, 31 Jul 2024 10:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722421152; cv=none; b=bL8X1lFEkgTT/KQ7F4jMsvHa34DAp/3WYSC9KKem8906iV/hkRTBoTdc+s/77E4PUwDx3OTf41XxeXeeahpXljRQY/WVt0gnBLWt+9rHMKbJEkLVu2iGZspsje5w/X8O58PmcoOXC6SpZdr7VY1F2FLDtFh9fnKFrfsL1ItgLqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722421152; c=relaxed/simple;
	bh=IrbDFwN5+nflC95mXxPaFgyCaQwIbaTJrNk5nd3i/4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lN7yzqsarRgRtulI3Rv640qGiJQ4e4LUYCSx8Nb+8XKoetpyaZCOHbPQ6FvMztMvduMPU9OAcpAJXh71hSazNeiUR4SeqXROV0l9I1sifqAN9lJBU15++J0hPtbS1Mws3/yQpCPBHzqRNJCqC+7kiu0d7ASe6+IHvIPeCGI0d0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2fXjVam; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d333d5890so5253220b3a.0;
        Wed, 31 Jul 2024 03:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722421148; x=1723025948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrbDFwN5+nflC95mXxPaFgyCaQwIbaTJrNk5nd3i/4A=;
        b=N2fXjVamP4ZWJnn/k5F5w3iVJO90oLr36OqzItQG8QWMwLXa7vu+BVPoLCZn23PHQQ
         f8AGDwCkxH899zgV9H5rSYV+och6BHpip7rc2xcStjsy1RHqOGNKTRhRlteEKg9Lwgpw
         qbaEcRI7LH2nc4QldpBb+tG4WRSz2gGz8IwHYBpocZ4hQnKVeAWDIzgl2o5Wcigv13fs
         nl+yRwiAzzmoGIIzFLxQG3rPbQbYtO2Fcs51Jrzi+fqTvT9Ky/R6dPJxnBiW/ySyxfmZ
         8DFUuaVdf7h4csfTjdKB7LJUbg1bfz7GkniQqCyVM4A+VTC9xlYByW+OdQhpG6tJi8ru
         FeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722421148; x=1723025948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrbDFwN5+nflC95mXxPaFgyCaQwIbaTJrNk5nd3i/4A=;
        b=vgt0vFcGM9c3gAV3Hz0p8oi4nya0PJucTmOx0RYBX/H0Dixf5lxmAk47jiD3SF5Dk3
         X/MlrkHk3sWDG5z6bL8SYp5NkyfdGm32wOauePuer0aCn975syoQQKa2NpGMepw47Iw1
         r17kd6c3Zm+22yMbibYyJPoaAbzcIXClvIOtMWybEqUCIA0RFWDpLLn6XA6exbWyQUKO
         EtuSLLEAl4exVCe6EJAQhBQtv0b1I8QULsTbQIODaZjbCGujRw+RdFp9mvFZ1lPq/LKy
         PddURpCPk7W2zoN0/v5Fy7b9S7KbB0/QZkcA9eur48DY09n70qYC2z+oivTEbxTvWokY
         gK2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCS+Qs95fP9N2sHtgjKx1qg2OJbkYcx6AVAVbedjB85QDWROexSLS1kC1yq8HcwEU7rHDQtdaPI5QQzmHclS12P1UJBLdHPcTAYJNxSGKVrTAZJWklKQjeLlXzx+33ccktiWA6C7h4zh007iA=
X-Gm-Message-State: AOJu0YyROnvxRmgG2LpGfyb+hQNevHoAwVNFcqVmImLrRtPcgOSGKOVq
	9T1RO1fhyUQ2NnkmOJkfUxKSknwGRFQa90Gf7u8SC7UgcicMrqPwTzJkvPTGBoScrDlABCAZGUQ
	qC4LDkP0jCtjC3pSaAWIQq4TchR0=
X-Google-Smtp-Source: AGHT+IG4dMsc3GyfK1BUmUePUR5oFxUraaKE4OKX6zeRK44YaRukpXqY63cewo2GbfZVh3dHGP4BnK7/f+Jfhn4bCSM=
X-Received: by 2002:a05:6a21:32a9:b0:1c0:f590:f77f with SMTP id
 adf61e73a8af0-1c4a0e03d56mr19597958637.0.1722421147718; Wed, 31 Jul 2024
 03:19:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731034112.6060-1-zehuixu@whu.edu.cn>
In-Reply-To: <20240731034112.6060-1-zehuixu@whu.edu.cn>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 31 Jul 2024 12:18:55 +0200
Message-ID: <CANiq72n48BvaSNvghkEMn796u4K3_1owZqD9Gjmyk7h3R9GT+A@mail.gmail.com>
Subject: Re: [PATCH v2] rust: Kbuild: Skip -fmin-function-alignment in bindgen flags
To: Zehui Xu <zehuixu@whu.edu.cn>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 5:41=E2=80=AFAM Zehui Xu <zehuixu@whu.edu.cn> wrote=
:
>
> In addition, since -falign-functions is not used when
> -fmin-function-alignment is available but skipped and libclang
> supports -falign-functions, this patch adds it back to the
> bindgen_extra_c_flags to ensure the intended function alignment
> is maintained.

Does it change the ABI or could change `bindgen`'s output in a way we care?

If we do need it, then I think passing `-falign-functions` makes
sense, since it is the only one that Clang supports and has the same
behavior as `-fmin-function-alignment` in GCC (i.e. applies it to all
functions).

If not, then it may be best to avoid unneeded complexity.

Thanks!

Cheers,
Miguel

