Return-Path: <linux-kernel+bounces-424255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EA79DB222
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 05:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0905E2825FF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 04:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992421369BB;
	Thu, 28 Nov 2024 04:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="phPysrYO"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DA545025
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 04:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732767823; cv=none; b=CE6ivyzlIm8tYTV+JwFP9MLU1rUBTrDKUhNMW4/bzJTzDiK2PlKiOhjUIRrDiZkWt/njBkPZYHY+aC3gqKz03CWXZzKhTRuI4Xrc8C+rGHFSWKrsMoXkhPIDNQnBCNZEeqJwpazuyeCjQ+9BVJk7YtWXSryJ1zyRmqchniBcvm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732767823; c=relaxed/simple;
	bh=PgOWS/E7EcTwB8mTg2RNcbJE4M6bdSNOHGsQfzFdbUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DO/MFqs5LYvfAi6PSGQMlLkFf4p34pD6R/QHM2ROQ5zLrxYFjfrhAvCdqseBjZlBo123k0g0vCch15v3mD+7SS8+vYAn8Tpx++KO+APNwQYFnUK7c1o5o1CPQGLXiLqAH5g0wsGcjoOEhSJYSjxzHtPzT/oQT4ApHbpyBrH+PQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=phPysrYO; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53de8ecb39bso396613e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 20:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732767818; x=1733372618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwU4UfhEvUu7/rEO/V2HznxTcRFjE28nqO/Rz50iJSc=;
        b=phPysrYOqcR5cHLV1Rw7QTWbyEAMBq+bkEJbNTxNQN+cjGlzhxIPgpjHuBTusMISuQ
         I6FieepYtRcFG8JpIfk1g01TvQZFlhtaHyYzvGXMT8fJY/PQ17LVk77E3oT2rOXV9zRn
         uzyleDXx4zYk4EtGFjd2EHno1PKJ/0IRjDSRw03slk9fuzbJf5AI5VV90CoInwTHp6cJ
         VEh2lNEeUAOT8Sg2agIBqgrZaiKGG23c8QDKZoxAp/q/Bn2SX9+m+u1OCpbc8WoXEGw4
         7wUr2hE4WHy3eu57zaOT3By3oQjj5ZHXNQLaN3affiRq75ZP1eLEy3OlhnG1rzf6Ae3m
         7f2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732767818; x=1733372618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iwU4UfhEvUu7/rEO/V2HznxTcRFjE28nqO/Rz50iJSc=;
        b=Cfficpog3PiXa94WE4cegl8vF4NNFo0i9461InoEs80yiYCGqk1UqBgr5n5WnjvTcK
         iuRiEoqQG4B1jXVd/+TEd/rwRT3QOl56X5OWhvpBgHdBvHJOujPOUnqcq/SKn2ZZY6fN
         wQ/p/Kh1+5O76EvvriwuLdsjw+mfQQAd+JGltQv+8RUkHjMcJHNWodn0d2TzRmYLw5rw
         4+eNltaGKD2UT5lm0tSzfSswB/mkWfPxHOjufNQ6aVliw6i16K2QuR/49CzAEm5kt0nU
         4vd4RsWyc4mwksf4nazxyxt+MC4K/XvIhg9on93PYz5qsLv7HjOtMEjer/v14908qcso
         EZgA==
X-Forwarded-Encrypted: i=1; AJvYcCV9Uz4Ouuxxz/Xdt88DQTUVfwJRwWWpOeIiX4u2QM4gqZocwfx8nvJAocD8gK2DTqqAbP9DdHZfItCdthk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw36Z94rR9PHSQKII2EIQSKjO7eo9CdKzDHAnM6GZlbCEHX9z7q
	FhFBoyWEnqyaVm/cFSlgQWukoDWckFotydj9gb91BGJThoZvDOtAtjrJBK/yDqWbZq6cfe18WsN
	juY7r2eYlXxwnqKQXRfoVRWUVUKYGUhwr0kO1uCeyfbhMCi94Ow==
X-Gm-Gg: ASbGncvVsiMo/22BUMO1MXMCH6CTJUM40iugtQuA8bbqrjr0rPzs3wNmiYGbOzatY1n
	9fTYE1H5LOC+A244NhLNNZeKBJsx2sQ==
X-Google-Smtp-Source: AGHT+IE9uLP2Ds+DrLupN3ByY3+amrXZ6c6HxCVF11zv6uF+HfmtXx6YEhHRblmWC0yK1hYCSqvhNdRaPJk/F6UakoU=
X-Received: by 2002:ac2:5684:0:b0:539:fcb7:8d53 with SMTP id
 2adb3069b0e04-53df01048e1mr3210771e87.46.1732767818233; Wed, 27 Nov 2024
 20:23:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115230509.1793191-1-saravanak@google.com>
In-Reply-To: <20241115230509.1793191-1-saravanak@google.com>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 27 Nov 2024 20:23:01 -0800
Message-ID: <CAGETcx8B+MZm_ZOFkK=KUvV_9q+48Zvkw8C-oenvvAKX+0+e6Q@mail.gmail.com>
Subject: Re: [PATCH v1] spmi: Set fwnode for spmi devices
To: Stephen Boyd <sboyd@kernel.org>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 3:05=E2=80=AFPM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> This allows fw_devlink to do proper dependency tracking for SPMI
> devices. So, better deferred probe handling, async probing, async
> suspend/resume, etc.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Stephen,

Gentle nudge. Plan to take this in for 6.13?

-Saravana

> ---
>  drivers/spmi/spmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
> index fb0101da1485..3cf8d9bd4566 100644
> --- a/drivers/spmi/spmi.c
> +++ b/drivers/spmi/spmi.c
> @@ -517,7 +517,7 @@ static void of_spmi_register_devices(struct spmi_cont=
roller *ctrl)
>                 if (!sdev)
>                         continue;
>
> -               sdev->dev.of_node =3D node;
> +               device_set_node(&sdev->dev, of_fwnode_handle(node));
>                 sdev->usid =3D (u8)reg[0];
>
>                 err =3D spmi_device_add(sdev);
> --
> 2.47.0.338.g60cca15819-goog
>

