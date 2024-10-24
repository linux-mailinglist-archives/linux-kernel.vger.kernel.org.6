Return-Path: <linux-kernel+bounces-380575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 316889AF2CC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 632311C212AD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA9C16B38B;
	Thu, 24 Oct 2024 19:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEGpx0NG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4058A1CF96
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 19:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729799139; cv=none; b=HWv4eF+xgwTbYI2onAOeS46cflRHatnaGGDgzAL2RZamXDRIb+Fb09aEaqzY3NlgZAOrE5i0nhuXQ2LooHrjcuf9sfeV/8l/OKaPMQQN4lObZrEgrmJQ0f4+jgqWYbYi6wxCVWYAKcyGTbt9nI4yM22g+UPM7wPqhlm0QDWVXEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729799139; c=relaxed/simple;
	bh=nax2bmYdCqC390JyNSLH6iDg9Xq/UOQux9zrwQgcQto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UvwCtys4QL1noddPqiqhaS6L8b3l6LLHnAnMRecg4nMBb8OLQZBq7egb0pyhrS75NH0W8rXrPJUA+iwkrBdl5kektqpLNsi9hjb+RZSfux1+SgM/5sqHEy/7xhcJKODZD0B3Ev7W06z6OSb3BTic/su7bI2z+FcuWQPzzsxIz/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEGpx0NG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0F5C4CEE4
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 19:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729799138;
	bh=nax2bmYdCqC390JyNSLH6iDg9Xq/UOQux9zrwQgcQto=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZEGpx0NGuc+ecHzpHAH33DwIj7wTr7QkCqSFyidkqoXprhRVKTblbqYUwrvD/vXUC
	 ym61djW8HWSXn9b9fwb8HpDAhaxx63EG8iZ6AY5i9ffsqM9tFA4URW/HmVLV9nMHmi
	 pziuCVlvn3KBn7GPQblW7apBHCOYw4CLlipDphuiZAMXP7LL0CqKAEm+17cgeAZI+e
	 rlk1zGRzdGIwCZQ3VMwKNSb9sd6XAymqPdRLwWdep7tjgV9HxHKsE8xPJ9e3AFPgPY
	 I3IQ7ffmV6NUuVNO4s5Fqw6KK2ORfiGusu2DtmB8E7nX0NBMGaoIznTx9Z7/D3YoGp
	 +3TRNXZGOM7iA==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-28896d9d9deso705297fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 12:45:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWF0k/mOzgccej99Ig3WIVmf4A434Brm6+CDk/b7LZMS5QM1PoACAor4BGGqz5/Fi6rBCfRwKrEghmQSyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvhOLOLUlaWr4QjtEo4qiM/q2hAPXgOclGfrciZPjTzZ+szHxf
	oCjV1yyo5+klQ0lPJL7UMF2yrOKdrTKfTQAdqagN18GSgTST+lJ+CyYGeKZXn4PhpwOWLLmkJf4
	kyy8SZuqLsMoDYzClGOeLbTbFBmw=
X-Google-Smtp-Source: AGHT+IE3iEa55FqbDr360xcuOS33bozyeSi8r2RyzTb8LQSvqfO+mCBZ651HsWrtwaxlDNsoRS+fPPiwf91kZuXSbWE=
X-Received: by 2002:a05:6870:d8c7:b0:277:e512:f27a with SMTP id
 586e51a60fabf-28ccb4b4ae9mr7952858fac.16.1729799137976; Thu, 24 Oct 2024
 12:45:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014122849.118766-1-brgl@bgdev.pl>
In-Reply-To: <20241014122849.118766-1-brgl@bgdev.pl>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 24 Oct 2024 21:45:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gAzZTa_TuQiFr1D7hKHw0eYF28s3ZBOv2ZFZTTC-Md8Q@mail.gmail.com>
Message-ID: <CAJZ5v0gAzZTa_TuQiFr1D7hKHw0eYF28s3ZBOv2ZFZTTC-Md8Q@mail.gmail.com>
Subject: Re: [PATCH] driver core: constify devlink class
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 2:28=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The devlink class object is never modified and can be made constant.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index a84a7b952cfd..0e618d675792 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -553,7 +553,7 @@ void device_link_wait_removal(void)
>  }
>  EXPORT_SYMBOL_GPL(device_link_wait_removal);
>
> -static struct class devlink_class =3D {
> +static const struct class devlink_class =3D {
>         .name =3D "devlink",
>         .dev_groups =3D devlink_groups,
>         .dev_release =3D devlink_dev_release,
> --
> 2.43.0
>

