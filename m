Return-Path: <linux-kernel+bounces-537274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 224A3A489E3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C37C166C08
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815E8270EC8;
	Thu, 27 Feb 2025 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AA2v0n05"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6F626F443
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740688176; cv=none; b=IsW3VxLJe/k+b5EpZIJytKNCc1Rmu1N1QDGoOJZDZkgalzSV3uWHs8cApH0z8NSKcZecx5T/qwm4+e9kpkVVlRt2PbZ9XKfKu/QCZO+wuXnCMQrVj8kHXi+0P4g0dRRcbJCTOowdbWCipE9sWmH8atfWd1+Hr+WpIEuWKu0mvF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740688176; c=relaxed/simple;
	bh=nH1/oGByc+iBu96dw+Zy6qisDGml17fymMZEEgpMtAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6ek7Afhiufvvfx6G/u4DrU7mYbS1o7KhC/A04Dk8xQ76fT1acScIJ+CObR48cuHypWPKlkFgrMWydFqTyUDowUFTc4OY3a68WUfhESPjgI34ZCWb8ixoD6wecuDRAaOe5borUsXMA1g9z8dMq5RIDUbz0NuYWfakpW9n6Z/dFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AA2v0n05; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30b8f0c514cso3278691fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740688173; x=1741292973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nH1/oGByc+iBu96dw+Zy6qisDGml17fymMZEEgpMtAI=;
        b=AA2v0n05PeHAvyCfuf3MV4WZwBy2GbLdHR8MHmMMyaI5XhNgLRZhya0wfQk017Kei8
         iqjUtQDswK4+Qx3dcj6jHhiDhPF+vXh1Kl9AsAueRsIMDZszwn+tqW9rmwOfUobNx2NK
         rZPH510rt05N+PvBf87US70rf5QhhxO++keLSSCYftyFBa1wdg89x3pZRw2OzOsD7Rqi
         BI8lycR0yDV6uwYoND9foNkR3jzK0apWRYKyi7iKj9cMMaS7uK3+EOuP/Z6fa3jgqgto
         0jp2lAi59ANFqMy72LMY/15c6ZiSpNqX287NnT3CvV7xXTSGIhxP9hZ3xCZiiwIRjLSW
         YT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740688173; x=1741292973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nH1/oGByc+iBu96dw+Zy6qisDGml17fymMZEEgpMtAI=;
        b=GWsxGsAxr6N4X5kWSVyMnywMqvU9oCggXDBkj4tQGIamK6utBU7qcb/rQ+FJWxENQP
         //FCDB1Ud3SAo9e8GVjBPTme0n8b1IcCbh5P3xGb4ZKxZfJWh+1utZmU7yOPWNzmOaFl
         7Pnv/Pc1j6DgPqmRSZyz2sJQE5IFodRsakUiv7CPSholdPqvjGhLLkQUrtr2taHwlteI
         dsi40fR9rWPLbN/h2bGbfW3FxMFSLFIC0XJuReRp3pZbk+1teZbkVYBrY2nhBxcdeHOA
         LaVgNjTlX5dDfGEMCK6SkblRAo0bf2DPGfpKtM0toE8xiSaSaHfw+L6NSOEyi9NIECx/
         of4A==
X-Forwarded-Encrypted: i=1; AJvYcCXaDayk2eK+Vvlh1IFVrbgcF557pXUiDoCX4Rvov2JRxArhzfytzTjCY2ornfH/lMQW0Dy8oc72vC0v7s4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw79cpUFHyTKfw+CGIo1MWmI+ULu6JU77jxDN/8Mb4V0qVkiEMD
	vMY2/enbOsvkfKIrF+pEYuia+uyVSQGL5/+Wu5/zDmy0E7OMJ5Mzsq3FyYE3WEdZMAOGQv85CHt
	6yRfDpd2O/glFGgebXScaJx/3W+Nd1W65inAuww==
X-Gm-Gg: ASbGncsXAFjvGN0q3bO6vkAtNnO6Q0fk2BawouBDWRpXtRYDwzdEAQlfei7jS1erCiJ
	s8Ms8X68tXe7wKI/SJJoQAu6dGs+CwgaHIFxKigmOnC8RpYxJFPpXqh+l1tBVLLcB0Jj1E04uDD
	9QZWNcb28=
X-Google-Smtp-Source: AGHT+IFDXl+7ddDj6hm4Z0U7Ss9i6FJ4nUHpHqcxipo+ykFbrCbzbYOK6wzikZNbk8TESo7HQ5zQcH+JdEWcEjvJQp0=
X-Received: by 2002:a2e:bea1:0:b0:308:e9ae:b5b3 with SMTP id
 38308e7fff4ca-30b9320d236mr1534171fa.1.1740688173194; Thu, 27 Feb 2025
 12:29:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122120504.1279790-1-mastichi@gmail.com> <CACRpkdbtjS54+g-K1azE2hHeTsiyzA_gFa2NBX6QZZ3D_H5Ryg@mail.gmail.com>
 <CALieaedTCPNkMBZaaFWME9LHDE5OypcaOw0uDBK5fFFcNSO=wQ@mail.gmail.com>
 <CACRpkdbpWgZHUn4SouR3yL_xjhjnyC0ogb8bErDuECakyhPW_Q@mail.gmail.com> <CALieaeeVfDe8GBFO6O_=_Z5W+y7==WWbD8x-596EAw-qMXf9ZQ@mail.gmail.com>
In-Reply-To: <CALieaeeVfDe8GBFO6O_=_Z5W+y7==WWbD8x-596EAw-qMXf9ZQ@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 27 Feb 2025 21:29:22 +0100
X-Gm-Features: AQ5f1Jpb_F0yzUv3qOEZmy0xdQDEx6N_IXmhovhmcUS_IKLlnpmHPIztH6om750
Message-ID: <CACRpkdYoDroEqwtH4GVa5VZ0WeBs85hY8ostM68gR06XzQ0Ctg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mcp23s08: Get rid of spurious level interrupts
To: Dmitry Mastykin <mastichi@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"e.shatokhin@yadro.com" <e.shatokhin@yadro.com>, 
	"arturas.moskvinas@gmail.com" <arturas.moskvinas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 8:18=E2=80=AFPM Dmitry Mastykin <mastichi@gmail.com=
> wrote:

> Thank you, Linus. No, I have no users. It's only a prototype, using a
> touchscreen. I think it has to be redesigned using chipset interrupt
> controller's pin instead of the expander to speed-up, although I don't
> feel touch gets slower. I spoke about hypothetical users who may use
> the expander as an interrupt controller at rates comparable to
> mcp23s08_irq() execution time, and may get less interrupts per second.

Well I think the patch is completely reasonable so I'll just leave
it in for now. If it causes problems we can revert it.

Yours,
Linus Walleij

