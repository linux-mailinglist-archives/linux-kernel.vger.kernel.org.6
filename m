Return-Path: <linux-kernel+bounces-380532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA1E9AF165
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8721C226F0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFD9218325;
	Thu, 24 Oct 2024 19:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="l9GvX8I4"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B3021C17E
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 19:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796903; cv=none; b=q6lrdjxO1jc9zVvYPfOwiMIkjo58s74TQjUH0tDhSttmGSZTtfGnQ+FveI4TnCqpMCc7sy/G0sr4Xrm+r52riiIa2fgOV7B2wCghba7pkQq9AVOjwsuiaj9P7bvFKfpidl8ziDR6k98mBqiJOFWQS8Gs9n+FJIYnB4wTS4DUzf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796903; c=relaxed/simple;
	bh=2vQqaLW3s/wefG1S2wq/GlDsJ/NkxzheZR3B7dHfJgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCt6G93KwTc33aUqUnja1lghDN2GZ4Jg58XPDGpoOB/HftudHlleywOq36Sw3WROcKVrYm3YzZYFoZF378lLkmn3dXQXlRGb/IwDlDOdRXRPmfIqM545haVNd1bKYr99yhKijrLxbLSH3eIVzN0KWrvxU2VdhuXOMPucBTkpwQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=l9GvX8I4; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f6e1f756so1548547e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 12:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729796899; x=1730401699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKpEi5li6rt5ZcMYAD/urkLJsxf0PLa99rSz49JWisQ=;
        b=l9GvX8I46LWqJNZag/ZOSMbaqazahSR4iAriL4VXiOu6a+Pd3Q37/MzXjnZrOOkXiu
         fILe4lcmyM9AH3WNcCo3eY0r0rW6tDzGdRhaAjZkapmXgrbDd4U/bN/9+N+x/igocSVp
         KWSjSHVKauXEwTRitupsyTUj5cpV/mlP53f1fE0W8yFQ40q7VJyyB2+8UByvqja1biQp
         RSr68MNOtQ8tNvlHmMvV5P2f/FFwVblftf6qdiQmRtUMaGfMmbsXH8J51j7uUGU3XzM8
         mmdte9VsHfLjl9J+fnZQxt7GV29Ah/7hSL7bkXlmGW3i5qGivB/tGC4Dzgk5UKiiTOCY
         iXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796899; x=1730401699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DKpEi5li6rt5ZcMYAD/urkLJsxf0PLa99rSz49JWisQ=;
        b=lLWu2SS25RRM1nBGSRMhw4GupqSl1H7iEFmlIaTwLkNfRfAzzwSxmgrJHti2V2GnIm
         knuGKM5me/0d3X7P8qemn6xdZMktlW2GHRSi1unoqPm4YH1JnhtEy/87whzcpt9HwF8c
         RLV/f13yJb35TinmyYGYqIGdS1Fis7sEmNzk8voGb5XqqEoPnDZhU3Pw/+M/KvJwTpmP
         GPdeoVUXZJ1Kz6IHipXwpEnC2/UhVeS8ZOXWEyXnOJ2BV9WbSTEoypGz9DFRlfh3p/5p
         ppNV3M5nHBJoB02oi+TyaCHxBdgUzRMVHsn3gVUAUOhyRGGp02pxAX7CLqv5Mck5q/mv
         iTnA==
X-Gm-Message-State: AOJu0YzGi/RJw21a6FXzMdXQGLjUecdNi6d80cdtH5gso0+OEA5IF4iX
	NgLojl9+qeEBqQ6QtyECroBrfKG+RRnExC6TQDShjrxiYdy+JQr2GhpDsDQGiGnF2vLNuTQ4p4M
	vgJCNmmd8/TDsKmLXrMtAYuKRL9d3vzBg+uxPpA==
X-Google-Smtp-Source: AGHT+IEGZH4osDEgnc4fhPmGV45hCQZDkRBKZX+4NfMX/NcBk4BmS7x9d0gFfYNm04rf0SP1d+GLom88soimTcGujSs=
X-Received: by 2002:a05:6512:3d86:b0:539:f93d:eb3d with SMTP id
 2adb3069b0e04-53b23e8eb10mr2203366e87.46.1729796898939; Thu, 24 Oct 2024
 12:08:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014122849.118766-1-brgl@bgdev.pl>
In-Reply-To: <20241014122849.118766-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 24 Oct 2024 21:08:07 +0200
Message-ID: <CAMRc=McgeDwKH_We-i9oUWV9krtY6CtU7KePSkPAGYB4aSkzGg@mail.gmail.com>
Subject: Re: [PATCH] driver core: constify devlink class
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Saravana Kannan <saravanak@google.com>
Cc: linux-kernel@vger.kernel.org, 
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

Gentle ping.

Bart

