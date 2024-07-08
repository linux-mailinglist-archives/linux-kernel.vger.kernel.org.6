Return-Path: <linux-kernel+bounces-244942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B496A92AC01
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33D8CB20F07
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F130C150989;
	Mon,  8 Jul 2024 22:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5NqQoUY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3C53CF63;
	Mon,  8 Jul 2024 22:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720477458; cv=none; b=KPeeQzdvMserxC+uIBCMN+xHpyB6YmovjbFQhJKJedG8S/4XnHbKD6N4RoMpzG7TvduL1ChgbWBKZsfsELrS96Cls8bOrgBynZ7xY7Nn9/CE4n3+3bCFXNcuiCaTntyOtx/H0qTh7dBIk06+X2lo8dl2sdgCTgPAPXrJe/V5CBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720477458; c=relaxed/simple;
	bh=8XuionVt0DvPvOIWWAhGLBrijPvhU3Xsyq/SGIrQtXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rfziz5DUcqmhZw8d8N1515ZB4FREy9LkTGoI7JpcAHBVKND+VS2LciYRzBaj3DZptY9DePEVYWDDfqKkFSSHW7PEKPzLioDzWHouF+QwfNLpSz5SHR2dSFkqY5pLtlli+9rXBmrfjeEVVpVvTt6JdZ4tfVKJ4Ety8wy4fHNWjOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5NqQoUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1B2C116B1;
	Mon,  8 Jul 2024 22:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720477457;
	bh=8XuionVt0DvPvOIWWAhGLBrijPvhU3Xsyq/SGIrQtXM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O5NqQoUY3m7btM3+K+Pcf1lnOHHTDZ38SUH5wlVrCpc3JRx25wRH2gg3dMUfV6ckv
	 TsU6b3cbRPQ7H1XQFwIESlqFdiUVeq737yr57OplRs4Odo66DuN3oayogrp08vym26
	 3tuxOnvwruJxfhaqvpvrgB9Xr1a3/peSs8M4W3JvA4GudHxVBYAQ2Jc1qUtLjO03qM
	 0Dn9yr2Itu9d+BwwXjy8R/vn8ZR63paayVnE/I2dQp7VzkbXe3tuE32lL+DhgY7GZ9
	 fXHgsd7NaM8bgOzurYmWxk23IcAeMbQtCSqL4qWarKVjiVWt/dNmxogioY+qeeiOau
	 QA0StGSL0FH4w==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52e99060b0dso4899473e87.1;
        Mon, 08 Jul 2024 15:24:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWqvPd0AjFHhRvvivgEEcW3xJynV/KxkBCFvfNaaFlRBvSS6bIfLD4f3FITfk8PtT+4aS2C/MgEtx4+GxlkMnZjhUT0+11XnOcwVkKt7xIhNsrUlYzBpAADqoCj2EhLD+uvIMybj1gtzA==
X-Gm-Message-State: AOJu0Yy3qELPJ9AAM2h5AA1DoGQyZFdF9wY8Gx9bmE8bKfU+IXttTUcm
	ai68tcNGX/NHOlVuYqMjx7YngCBNc9WPWeGcLfcxrEMre+b4Tu0QbGcr/8VwtaJhKVcCWVznu/r
	pWwjPG32lioRyeUmZPYPXH50Iig==
X-Google-Smtp-Source: AGHT+IGA+gx1CJRO7PuMBtYHXR9AAopPxjZSU2r+9k2ZKjbtcBW2HNrWoESjU/w2884KLIByMyMmowg0ZLjwDFCyv4E=
X-Received: by 2002:a05:6512:15a4:b0:52e:9fda:f18a with SMTP id
 2adb3069b0e04-52eb99d4bf0mr357761e87.44.1720477456167; Mon, 08 Jul 2024
 15:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708-of-match-node-v1-1-90aaa7c2d21d@bootlin.com>
In-Reply-To: <20240708-of-match-node-v1-1-90aaa7c2d21d@bootlin.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 8 Jul 2024 16:24:03 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLBmpEQVgZ1UciAdxdiSj6Ly4bpYtYPvazr9m=vRj7qEQ@mail.gmail.com>
Message-ID: <CAL_JsqLBmpEQVgZ1UciAdxdiSj6Ly4bpYtYPvazr9m=vRj7qEQ@mail.gmail.com>
Subject: Re: [PATCH] of: replace of_match_node() macro by a function when !CONFIG_OF
To: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	=?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 2:55=E2=80=AFAM Th=C3=A9o Lebrun <theo.lebrun@bootli=
n.com> wrote:
>
> In the !CONFIG_OF case, replace the of_match_node() macro implementation
> by a static function. This ensures drivers calling of_match_node() can
> be COMPILE_TESTed.
>
> include/linux/of.h declares of_match_node() like this:
>
>         #ifdef CONFIG_OF
>         extern const struct of_device_id *of_match_node(
>                 const struct of_device_id *matches, const struct device_n=
ode *node);
>         #else
>         #define of_match_node(_matches, _node)  NULL
>         #endif
>
> When used inside an expression, those two implementations behave truly
> differently. The macro implementation has (at least) two pitfalls:
>
>  - Arguments are removed by the preprocessor meaning they do not appear
>    to the compiler. This can give "defined but not used" warnings.

It also means the arguments don't have to be defined at all which is
the reasoning the commit adding the macro gave:

    I have chosen to use a macro instead of a function to
    be able to avoid defining the first parameter.
    In fact, this "struct of_device_id *" first parameter
    is usualy not defined as well on non-dt builds.

We could change our mind here, but I suspect applying this would
result in some build failures.

>  - The returned value type is (void *)
>    versus (const struct of_device_id *).
>    It works okay if the value is stored in a variable, thanks to C's
>    implicit void pointer casting rules. It causes build errors if used
>    like `of_match_data(...)->data`.

Really, the only places of_match_node() should be used are ones
without a struct device. Otherwise, of_device_get_match_data() or
device_get_match_data() should be used instead.

Rob

