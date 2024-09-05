Return-Path: <linux-kernel+bounces-316950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9676B96D774
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFE8C2849A7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83C9199E9F;
	Thu,  5 Sep 2024 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l2jMAYtW"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F21D19415D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 11:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725536811; cv=none; b=mRrBn8zejuYmPmgZuzX5EeZnxvcx0rBUw795hjk+HJ6bUkxD50IYTkg1E9IC1uJmYnN2VuvACnLFLwVb2rSTMvltJqineXKOdJE/9om0gZBFfkY7Oxd0NGo0++inDx+Wrz2gZJpzhwB3+DlohXKvzdIkXC1wq7f4QwQP2Ae4w0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725536811; c=relaxed/simple;
	bh=BM+w7SmS+M15Gzb2t7Xs/YrBp02BDmfc8gIF88Qzt5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UM6uZRmV9zgnHCF42Y5uePcHeJKdl3cySsqCOo5T2WDhDMqK5idhcDGUu1625fo3oyloevsdIj08B2tMxMFyKzDgoqhBywDHXQzyjQN27nfBsCgSf+pEO6oYGbcsCWuYKyv/tOTWuCEFv2+yQt35wM6UhffuH1I4BgysBYJEcvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l2jMAYtW; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f4f8742138so7755531fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 04:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725536808; x=1726141608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BM+w7SmS+M15Gzb2t7Xs/YrBp02BDmfc8gIF88Qzt5g=;
        b=l2jMAYtWRxIU2e6Wr+E3jt2NqmTzjGHXBYcGG2j93KfScnUG+uLeMNwSqEOSS4fIxX
         oQuQMg6lrnp6Z+mKTInH2E8Ap/Q5RTFRfRN/phWFDBvGHNP3hGtUUBKobdpqnQNfdSA3
         /4Ct3KEi6fSrvZtoB0TIyLgzu1XSY+T4c24Djt8MXbeIRRV2WhSRD/LY6LJoaIlV231x
         MIoOC3Zqs8RrM7KEAa22FWGFHcWhZihDNl5oxSTVirBDfR8CaaYixwqMLgLPM+9z8ZXo
         CwvLuAGd97Bq1Rb9cY0WiMls3/rZYa6jysXh+9ncOgSwOaRtbMXrspJXCykQRJbCn+qb
         yBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725536808; x=1726141608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BM+w7SmS+M15Gzb2t7Xs/YrBp02BDmfc8gIF88Qzt5g=;
        b=JUUfc4xgircCuK4mB/JAwu5zPee87FLu6AJ1NdNfTCyYNkM0A8yukd6pY93EozQB7L
         reNiOA1/hLbydQYuxb5BuZ5EIx+ZtmG8F2mJJVScpASlhyqXnjKTfE+kON/UT0JTeDLm
         01CSAOS97FyWwuD0/q4LXAlbg9NmaI8tsfHFq7ojxsebSxGySi87gVWKmsygL8adoU8I
         KutX+JG3XpHCGm9PCc16tHRYshdCXxL2UeWcL04M2pKa2KfBEq2JljYsGezv+X8ovXuu
         rbvkD737ufhHXVXKVUatqMOQhcjPk84rWreJu3DJRFIbGJWyPGNOLuPYrbcZPDa/O/Az
         dtDg==
X-Forwarded-Encrypted: i=1; AJvYcCWBz+mPFBX1ogYeB6uPbfTKSWzSwItBHdxIQlt6ezQ0NVixG3A64XYRvudboXzvZGFshkPoSaAsvkZlQWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvQx+W1t8yL+OIsEQIZqWuZ8XgFtJWZ0wbWmgdMeHQuU46Nwzc
	pAy0OoiwWVejKpT8qwJua4t/TgdaeLOYlMujAqxbJsOuWtDwiYpV+mwH+gZFTdMfMeT3Q824nTN
	56Tmod26U1szNuwFq31FD8K/Y4MRyDjGD9jRgww==
X-Google-Smtp-Source: AGHT+IHCsGQBYwg2ohwx5OLsJ3HR5XOoonPUOUhGDfgKfGVyaOU9Jfn9m+n8OOre+5olcGMI+3GJhnGkwebhcYZHI3g=
X-Received: by 2002:a2e:b8c6:0:b0:2f3:e2f0:2b74 with SMTP id
 38308e7fff4ca-2f64d54ff96mr53248961fa.36.1725536806884; Thu, 05 Sep 2024
 04:46:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902-th1520-pinctrl-v1-0-639bf83ef50a@tenstorrent.com>
In-Reply-To: <20240902-th1520-pinctrl-v1-0-639bf83ef50a@tenstorrent.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 5 Sep 2024 13:46:35 +0200
Message-ID: <CACRpkdbNwpiaXKgkZfq6cw5LuW7RGxCuQvF4n3F0YCcUqKSf0A@mail.gmail.com>
Subject: Re: [PATCH 0/8] pinctrl: Add T-Head TH1520 SoC pin controllers
To: Drew Fustini <dfustini@tenstorrent.com>
Cc: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 6:08=E2=80=AFAM Drew Fustini <dfustini@tenstorrent.c=
om> wrote:

> This adds a pin control driver created by Emil for the T-Head TH1520
> RISC-V SoC used on the Lichee Pi 4A and BeagleV Ahead boards and
> updates the device trees to make use of it.
>
> Emil's series from January used separate compatibles for each pin
> controller instance. Rob did not think this was appropriate because the
> programming model is the same for each instance.
>
> This series takes a different approach. There is now only a single
> compatible for all pin controller instances. The pinctrl driver checks
> the unit address to identity which pin controller instance is being
> probed.

I don't know if that is a good way to do it, the unit name could change
for some reason and then the driver will not work, it seems fragile.

Can't we just add a custom property such as:
thead,pin-group-number =3D <2>;
to the device node?

Yours,
Linus Walleij

