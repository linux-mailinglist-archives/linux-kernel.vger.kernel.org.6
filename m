Return-Path: <linux-kernel+bounces-438373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E089EA050
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594E7166611
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A718C199239;
	Mon,  9 Dec 2024 20:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBTnZpNj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B23B23315A;
	Mon,  9 Dec 2024 20:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733776483; cv=none; b=lXBHfk0OzTNYmus7S2LuzjeBgH6h99ySJ4LXTAnDU6yF4f5xsEaOKFXpniww+0Hjj+1q3ZhTd0pUK35hyAhqWl7ufnFurZg1UyBVJyeszF1xYGGObpTt5AdjxwSKGfU6SSMZE+u0NIFD9Jro4WC6LOH2cN5c6SbXKnLfqUlcLs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733776483; c=relaxed/simple;
	bh=vg3OW7LlvJI+EJwR8QEZAFGpy7N7yeB5CDdrC49jd4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GplsxnoLGY0PQo32p1JFzgcw350N2kRiS19t2m3tgmU0lG3TV9JGs2jheDlFKzD4i4ZDc8+cQDyyxJNh33u6+hriKfd7M20dnpxHV6tlmzKTWQ2Nr7VRZ2bT3aY7jk5wmsktS15MvDZkK63RUF3pkpKqUMNr7IIz/aFQJCIpLqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBTnZpNj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC3DC4AF09;
	Mon,  9 Dec 2024 20:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733776482;
	bh=vg3OW7LlvJI+EJwR8QEZAFGpy7N7yeB5CDdrC49jd4s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bBTnZpNj3reHKSQVUZM0jCyzDrxNYTlH2ExJzvmH174go7P5VIJtF/0keOyQl/Qt6
	 h7cZuQFVWQoeDtnEkBXSEUcr/Lq/z33x+q8ObultTbDGi8r5sBOsEbqyePneNMKAnA
	 VnaIN/zTkeK4Bse+u7DCc+Dj8dPjaepYuaN6gWvB8rAiRG/TMD3rOAk27ngW5hkS1e
	 JjWK+vWTPV9LkQC/Lq6GqZNQfe8rBnWgP3W65WfNXOnVnqrtc7nAHKbV3pU26zbFnj
	 gF7kA38BxqZqsQBLVD6f1s1vV9rcW6gyERQFzsr8jikNbkBmTvm927sHA4mtsoa8tj
	 wNLN66sZVtf0w==
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e3824e1adcdso3732554276.3;
        Mon, 09 Dec 2024 12:34:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUGDSXMu2qJizDxXTrgf3IYI9nI1lRmRVL//sZXKh7ZRevXIRS6+X8fgNqPAkD74YoICW9KPRXesThR@vger.kernel.org, AJvYcCUMrHgEi67fimCO7ki/67BdjYRqqOTCQpUXmZnxoagvfnd56s55UgRmCiJ38eQiPlWfnaGEpHqRo4FwY09w@vger.kernel.org
X-Gm-Message-State: AOJu0YzPIcJGP6Ni5HXZHyUSTnP2ccmUhffRkjVyM0PWibFefT/g76TX
	VDacVho56pnZF5jGHvP4zRp4Xu7YMTnXr2GUUhplhX1zFzAcr7swppnhwX36Hizr+o37/fZ9KRa
	AFyd/T0PY2FwgBmJ2qaJQYoiitw==
X-Google-Smtp-Source: AGHT+IH3LU7VMAdjJaS1oCzHI4d5+0sJbiJgeQEMnINW6oszmiplUBNy7wWd6OF++lcME18z8sneqAa7UeYAq+z2VVs=
X-Received: by 2002:a05:6902:3483:b0:e39:c4a5:221e with SMTP id
 3f1490d57ef6-e3a59b3251cmr1476962276.31.1733776481684; Mon, 09 Dec 2024
 12:34:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206-of_core_fix-v1-0-dc28ed56bec3@quicinc.com> <20241206-of_core_fix-v1-5-dc28ed56bec3@quicinc.com>
In-Reply-To: <20241206-of_core_fix-v1-5-dc28ed56bec3@quicinc.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 9 Dec 2024 14:34:30 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL+CRmCQMzcF4-A-PRBrCsfK8nduJtOO=RrsDtCUUR7og@mail.gmail.com>
Message-ID: <CAL_JsqL+CRmCQMzcF4-A-PRBrCsfK8nduJtOO=RrsDtCUUR7og@mail.gmail.com>
Subject: Re: [PATCH 05/10] of: Fix available buffer size calculating error in
 API of_device_uevent_modalias()
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Saravana Kannan <saravanak@google.com>, Leif Lindholm <leif.lindholm@linaro.org>, 
	Stephen Boyd <stephen.boyd@linaro.org>, Maxime Ripard <mripard@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Grant Likely <grant.likely@secretlab.ca>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zijun Hu <quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 6:53=E2=80=AFPM Zijun Hu <zijun_hu@icloud.com> wrote=
:
>
> From: Zijun Hu <quic_zijuhu@quicinc.com>
>
> of_device_uevent_modalias() saves MODALIAS value from offset
> (@env->buflen - 1), so the available buffer size should be
> (sizeof(@env->buf) - @env->buflen + 1), but it uses the wrong
> size (sizeof(@env->buf) - @env->buflen).
>
> Fix by using right size (sizeof(@env->buf) - @env->buflen + 1).

Just writing what the diff says already is not that useful. The key
part you need to know is why we back up by 1 character to begin with.

>
> Fixes: dd27dcda37f0 ("of/device: merge of_device_uevent")
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/of/device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index edf3be1972658f6dc165f577da53b10c7eebc116..ee29c07c83b9e6abd9b1c7747=
dd341026bc79eb0 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -266,10 +266,10 @@ int of_device_uevent_modalias(const struct device *=
dev, struct kobj_uevent_env *
>                 return -ENOMEM;
>
>         sl =3D of_modalias(dev->of_node, &env->buf[env->buflen-1],

This could use a comment why we back up by 1. Better to put it in a
variable than add/subtract 1 everywhere:

/* After add_uevent_event(), buflen is at character after the nul char
which needs to be overwritten */
buflen =3D env->buflen - 1;

And then use 'buflen' throughout.

> -                        sizeof(env->buf) - env->buflen);
> +                        sizeof(env->buf) - env->buflen + 1);
>         if (sl < 0)
>                 return sl;
> -       if (sl >=3D (sizeof(env->buf) - env->buflen))
> +       if (sl >=3D (sizeof(env->buf) - env->buflen + 1))
>                 return -ENOMEM;

There's another potential problem. If we return before here, we end up
with "OF_MODALIAS=3D\0" or "OF_MODALIAS=3Dsome-non-nul-terminated-str".
Maybe that doesn't matter? I haven't looked at the caller.

I think a better solution to all this would be making add_uevent_var
work to construct the full value. We could add "%pOFm" format that
calls of_mod_alias(). Then this function becomes just:

return add_uevent_var(env, "MODALIAS=3D%pOFm");

And of_device_modalias() can be:

sl =3D snprintf(str, len, "%pOFm\n", dev->of_node);
if (sl >=3D len)
  return -ENOMEM;
return sl;

Rob

