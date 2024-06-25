Return-Path: <linux-kernel+bounces-228464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 897C7916047
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302901F22A0E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6093146D76;
	Tue, 25 Jun 2024 07:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0rsJxb7U"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CEC146A86
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719301604; cv=none; b=U/77QfKngexfUmTzkK6eflKNZLXMq/OFPS3AIVuBNNjuIPRxgnYw0uxjOD87j5oCrwkyOryPaxzehfnWyA6rsl2OA5sso6kfaEYvdmy+dNR9WNdWu1rNMFx57AFfU1zfgZfoRNTo18q1GbWnqoDzOK728tctBZW1Q7b8H3QA+t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719301604; c=relaxed/simple;
	bh=KQ+bgIYCeKBgOUkKP2xyBAw/NLvGdx/I4d0rWEKXj+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIzC1zKCKI/emherwVL1ltdtXKnu13hDsZJik+5ViZS7M3uWk4c6LEZ14dkcUVHAA2kVUq5WZ0UmIho9utJHHIhCar+gnP2/BLLxBCXRxyotT69O8znVJfxyJe8QxgsubJYujBDpyrkRnsw8AbbGDCE7YSjMrNGqoqUMvI6lA5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0rsJxb7U; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eabd22d3f4so63460751fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 00:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719301601; x=1719906401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQ+bgIYCeKBgOUkKP2xyBAw/NLvGdx/I4d0rWEKXj+8=;
        b=0rsJxb7UBpR6EOihYrq/U4qGTIBHLt+gopun2WskxiK0+S8lyYi/u9wNVkkrB1n4mh
         fgzbLQbGRG2NPvEX+HBLLtjXuvxoOyNsdl4XBK0pfzQLo6BwOJ00evtQWi6XkNmKkgTe
         CkBOCEzxWqQvH7O8cQ0aqznUUOuCDKtir7o6z4uREQp8jPm7g1x8dNKh6361p4FYu4Op
         S0nJ6YiAU68j+fufB88cgX+P1lxohz2EDA5vrjc6zQLkFAtmIs9j2f2LLjBBv5ezF7IM
         2odWDGhIGZEdra399MEIZ8/MpCKFG3Q0T+VFv8/fg5FmrVVvkSNLLuTK7ng8metpYW9g
         TKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719301601; x=1719906401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQ+bgIYCeKBgOUkKP2xyBAw/NLvGdx/I4d0rWEKXj+8=;
        b=wts19EvGw+j0LPCcHSNAFejaAXG4NJlJ4F/9Fl6k3tSwBaO+UlguKNlwhkn/pgfmfa
         2dCeYh9eZG9JfqB5UU4UKrODSERnj9vK5/6+x73AwXzHnjg3MnuTxxS0zGiuNeBDuiQu
         R9v+MnQbnTdkL49wgpUl9PRikdhIzGTIbvigBIwUzhMdVT+S87vtlZlwayzMnCmyBFPR
         hjMXBnMNhOMkt2DumAUsoHfWS3rAl5rPdnn9Xt6HdGY4+nG1aoZCD379mnW3504PoGKC
         lzIewpPOr5TRLydMnBV6ir9bsIWNF2A0OHcaWGqkyLLow7W8OSOx27OTYUeS4uAZWLOz
         2mxg==
X-Forwarded-Encrypted: i=1; AJvYcCXKm/m+db3ddCMKnoakCSjgaloIaHSRQeNHOdg+t2TgfID5ZLo7YgwUgl+RGUuilaiDKECyRySpGSU2DyUOjd0lHc/uP8gl7VZIyfis
X-Gm-Message-State: AOJu0YzxqstXkStyD+avCxc/S2UV4nnQ9t1YuLITexjyTAmP1p42J3sK
	r8Z5reupd4SbN3OMe7eBLfzcSTTqbJWT/RAw1QmbKmf0hUOanupUDRLoRkk9pyai1EwnfchwPPD
	befXpAkiyLhkVJSEhJ+Qf1S16ZiUtHRQol0MMlA==
X-Google-Smtp-Source: AGHT+IG6PgHGYuAX1AUyV5EN7lc8tN5mHh/JuzzOgzPg5xDcTQ/uVLhTBQ3XbjpqG/bv4wQ2T+6h8Bru5fI5/SHFG0U=
X-Received: by 2002:a05:651c:154b:b0:2ec:61b5:2162 with SMTP id
 38308e7fff4ca-2ec61b521d6mr35790581fa.25.1719301600609; Tue, 25 Jun 2024
 00:46:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624194518.37458-1-brgl@bgdev.pl> <CAA8EJppMPeYrPH+ssDMnf6UwHRdKQetpY3PotGvR-cc2vE68AQ@mail.gmail.com>
 <CAMRc=MeYy8MgBVbwmrR1Rd9oQMz1tUb+uL4eFJWTL7EOsRXxjg@mail.gmail.com> <CAA8EJpqz7wPSyn0ybDWKwBKkp+rWVPbTgjbKuG6VHWm24MCusA@mail.gmail.com>
In-Reply-To: <CAA8EJpqz7wPSyn0ybDWKwBKkp+rWVPbTgjbKuG6VHWm24MCusA@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 25 Jun 2024 09:46:29 +0200
Message-ID: <CAMRc=McZ+hrXyNESmf4pFX9+uDnc4AKsuO9X8AJsVgCfQVLd9Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: don't disable power management for QCA6390
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 11:20=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> >
> > Neither of these has clocks that need to be driven by linux. The only
> > user of QCA6390 Bluetooth in mainline is RB5. Bindings didn't exist
> > before so no commitment was ever made.
>
> This might make some laptop users unhappy.

Like I said: without upstreamed DT bindings, we have never made any
commitment about the device properties. I doubt anyone will complain
though, I haven't seen any DT with QCA6390 with clock properties yet.
I wouldn't stress it for now.

Bart

