Return-Path: <linux-kernel+bounces-320674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C42E7970E0A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811C028135D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 06:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E251AD3F4;
	Mon,  9 Sep 2024 06:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ejm9gFHB"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685AE4C8D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 06:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725864103; cv=none; b=Wey8fZypy1aOIIJEoLmAv0nkwE5QNUgxqAIpj2vXduI7n5+sokQ5NqQmfY7yZQD0xcswIh8e5Ak7Fedz8wSkT/UKXwpOCZkUCuvdUtfmmpk720NSL64NQRtBtZDP7zmHM6kMRl5eRe8hCWUjRze7+XtrxT70pb3/qyOZFA223Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725864103; c=relaxed/simple;
	bh=gFwWutEoMn52xVaaNChbaM2kIj1TRf3M1IDFfIHJ+kM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dKKphjARqItvwQGXoXBpT/qdMI9gMQtSPHpIn97syZipFXKpSinszh7AONzCJznRLlpbQLMI7pv3jy07ivomfFwnb89W1uFOvUyIiP0CaLYVqsnsfZya8K9Yv+ttn9opqmKj6jOtsRw9InR12f9V0ZOs5oN3ChW1WN49KWX+FTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ejm9gFHB; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f75129b3a3so35761801fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 23:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725864099; x=1726468899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFwWutEoMn52xVaaNChbaM2kIj1TRf3M1IDFfIHJ+kM=;
        b=ejm9gFHBlB4n0R4/aQxd04ztrJBkWEiOSQyXoEzlMMxnjimjO4oRLjYJyyDvmaWsjx
         8jTREf1Mc4fVPNatUuLYazz5uDxsd+hzXZYFZ7efsjCx1uoBMQiH4oiJ/Jxru8IFaVKp
         V5nn496czRLkyF5DTGI1RpB4322U0JyCPiJW86nXB23wQ/Li/aF+QpDMhxLJw1WpYOOu
         RQz82kqcLWbJ3HKTEHsSZggBCmFzBDpcXfWjmrBStVZfV1aNMBmL6B8jXzINhvtx97Bh
         OzCYcZe9v06UEmkpQ/MChGiMUW+YAcCHGr8SrG9c+c+sTNsgCCproLpQxfQGZlx4ans8
         3eYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725864099; x=1726468899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFwWutEoMn52xVaaNChbaM2kIj1TRf3M1IDFfIHJ+kM=;
        b=QhTGlGeF7l0HaVDkP35qZmsBsBLikU4kDXHiSEhE7ocqbF+j+v3llVIRRduRO/aC5d
         MQhbIX1GJVmgE3dfOoMXS7lwPykVV79a+i1e8wP7aVL7qov/iywMGpjhhYsB+Vwloz+y
         +Z8nRf5vSqNFomWSSXlGntW34E3nAObQYBY4QDUhtJ1nqGUYciN9QsSiYmdIgX5q9qyK
         0uDeef2Pn596wOD6fmCRq4H/yaFNL296b6mY9BD7OsAAWyjjqIB0H78h4o+/k3Gy+nG0
         tyVdo8QbXlZohXaIfeiJ4Q8k6bPy75QHg5R+RY1Spyb/IlUiErOi977/qU7Lqr+UlGNj
         1E4w==
X-Forwarded-Encrypted: i=1; AJvYcCVtBs2dH+PO+xP8QDv5TO2SRYikVf3glo44jMJyBPOrw9Drmku2DZr7Xw/eOdqRHVvVhORE1lwqiqPYsGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP/xKhTG6ZHhCwyvIhdLVdTWDWI4r5N2CPnBA4Kxy4/ekvxbQs
	AsNIa0/1RPYryNM0fxkv0YSXC4FnadTAkBnUbC4lL2yDdMqI32gVuHeJ7dLiAPBWZhiN6485A1K
	EapqWbP4ayzsouFbY96FSxCeCnHKHQR6voIXN2Q==
X-Google-Smtp-Source: AGHT+IE8ksXdclQfbBIHEdbZ5UrRT4fGD9jPz2IvJmQUAOXzM2ZmMquUIzTiHIzZZ8GahzqMtT72RkXTS/ePPAEEnU4=
X-Received: by 2002:a2e:b8cb:0:b0:2f7:64b9:ffa4 with SMTP id
 38308e7fff4ca-2f764ba01fdmr23131841fa.9.1725864098538; Sun, 08 Sep 2024
 23:41:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805-clk-new-helper-v2-0-e5fdd1e1d729@linaro.org>
 <20240805-clk-new-helper-v2-1-e5fdd1e1d729@linaro.org> <220024b46504658718c21c5f0c221007.sboyd@kernel.org>
In-Reply-To: <220024b46504658718c21c5f0c221007.sboyd@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 9 Sep 2024 08:41:27 +0200
Message-ID: <CAMRc=Meei90ZjFn-jZkyv4=SpijMevxhiF7G1Q7Q7dUUYiRbKw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] clk: provide devm_clk_get_optional_enabled_with_rate()
To: Stephen Boyd <sboyd@kernel.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Michael Turquette <mturquette@baylibre.com>, Russell King <linux@armlinux.org.uk>, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 11:42=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> wro=
te:
>
> Quoting Bartosz Golaszewski (2024-08-05 01:57:31)
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > There are clock users in the kernel that can't use
> > devm_clk_get_optional_enabled() as they need to set rate after getting
> > the clock and before enabling it. Provide a managed helper that wraps
> > these operations in the correct order.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
>
> Applied to clk-next

Thanks, I will add some users in the next cycle. Unless Luiz really
wants to play with cross-tree merges again. :)

Bart

