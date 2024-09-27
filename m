Return-Path: <linux-kernel+bounces-341626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C70CB9882A2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 12:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 036EC1C20887
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F214188CD5;
	Fri, 27 Sep 2024 10:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoqJtozH"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D85185956;
	Fri, 27 Sep 2024 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727433443; cv=none; b=dWCAsp0rLxrTBexJHHqnp1hS/BrHruAegoRNIBSIPm4Fy/o706CrROqpXUq2Kx6aP71PxkhFEUaE+MiE1gtKa2QW3i50fcvD18A0DejRNtZ3XSLBTZOBioFys+iCs12qicMuMk49PUIvpGmpv+7cksP5UQ/BNitk9DOkAtcccPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727433443; c=relaxed/simple;
	bh=hHoju3u/041HhlyK9FzkDceCp+u0ugdPviMfZb0y9V0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ojl/rT+c0QX8rmk1rvbexrg0RYKmOkyRStgbcary9iPHfGpo9HmtWHD3y9oOJGVp/zVFnD6iCrI2K5Ul1YL9P9JVFocqfd7SV5wg8Sjz53h+FD6n5gVp0cLu3L3SoCKlSUilxa66eCUvVLxDUmGwvVzY8w1ytrpZ9i6vK6SO2mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoqJtozH; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso285006066b.3;
        Fri, 27 Sep 2024 03:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727433440; x=1728038240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHoju3u/041HhlyK9FzkDceCp+u0ugdPviMfZb0y9V0=;
        b=FoqJtozHHcI8TDm63+7afV1A59QjPgWM4zSh5+TdMNgX4qZROVe37mr8Fx6EGCt9xo
         tpC6GFa2224m0IwwratUOg3AzzxEtbWDYy5nwwNqLBcO8RRrInQwhGetgdDh5H+4yqGS
         3js8ELoFg+c5pTswmbCcGvCsEZeSmjxJYQQOFmJ6s+3JqWzMvNlVeanaEaz5wkmp2R2l
         01eYoy8gmIxMnfRYf6k6yz1SR0SMLfT7y5q4+yxBPaFOrmKZsWSpUlUp8DLega/Czja3
         LafWHkmDi6zHdzGi1lxBUWhJ94EmdmR0go7fCBsniL9j4u4JPev0CcWJU6Hlf0rgsWxb
         5wNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727433440; x=1728038240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHoju3u/041HhlyK9FzkDceCp+u0ugdPviMfZb0y9V0=;
        b=respLPZPKJhOV5zZXmvkzZUvERPJQL2KXbHYqz27bxdlTh44PLu7iiQv4pq39ZYh9J
         MqbR0kZTyfFU50YBwNBIl4WT8VvNWbo3QuAZDqkwzv8KR+QujCOSbpLmNjYhXy8QkQ0B
         n8Z4F0cSKy9eBmfVE4Z5E5MZzPyXnqaqKWs8HoSJU6uBMSrFwJ6i9HwlQm1pqOkxjCvQ
         vUsQgKk5ZbdJ+YGkUdCOjhQUBEiUCmfPQ7I6n1sSzXZXA4detplalJQrBEEoZaGhlOyz
         ODDciGCUjqZrtJC0oP59HJqAO2u1SOBS4xvKjty2JDH92+oIrOhHpj4RNc0vx4cDhYPt
         gUcg==
X-Forwarded-Encrypted: i=1; AJvYcCVhYFGq9tDwDYbhfPI3c2Bkf8HLms6MrlBynbQUWqCpEK0+AJwMF444FVCKNxNkW9M9Rj2lVz8jp+4Ybis=@vger.kernel.org, AJvYcCWdQPocpfOWGq4lGtONqTMQtZjVbs05wjEj192IVqQHmm0UPldzvWPJGHNst7ExIuF4qw8gv28FWdzlFW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk30RkIZS9c2p05fZteJnlmPjVbBMBIXTcH6MHSqQwr/tgv/5z
	9pFIsSahptGUllFBwdZ6Z8CzjO/B1dkI7UtMf8CK//fK9zUMAn7756TV5qiXgf3AjUy3A5Ih9OD
	o84JKrtrpQCR183lh9wENr/eKlZQ=
X-Google-Smtp-Source: AGHT+IH78ZbE2U9C9t69k5TZ6X+Gi8DEQA9qne76aeeb9j3yf1y3FHSicvo5uPYPSIyCtIKCVHczjOJor/I4gd87RzU=
X-Received: by 2002:a17:907:9709:b0:a8a:7b8e:fe52 with SMTP id
 a640c23a62f3a-a93c4a98d9dmr283774766b.59.1727433440228; Fri, 27 Sep 2024
 03:37:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1727424031-19551-1-git-send-email-shengjiu.wang@nxp.com> <1727424031-19551-2-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1727424031-19551-2-git-send-email-shengjiu.wang@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Fri, 27 Sep 2024 13:38:15 +0300
Message-ID: <CAEnQRZC3SPUQg3B=0KtsWdNj40=rvjp9+e=1zAn7DhS+Z3wZ5Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] ASoC: fsl_micfil: fix regmap_write_bits usage
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, 
	perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 11:23=E2=80=AFAM Shengjiu Wang <shengjiu.wang@nxp.c=
om> wrote:
>
> The last parameter 1 means BIT(0), which should be the
> correct BIT(X).
>
> Fixes: 47a70e6fc9a8 ("ASoC: Add MICFIL SoC Digital Audio Interface driver=
.")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

