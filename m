Return-Path: <linux-kernel+bounces-274274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D589475F5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972DD1F21B5B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF90149DE2;
	Mon,  5 Aug 2024 07:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qVIMX+Fk"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1361494BC
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 07:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722842623; cv=none; b=DkM3vBPxBP2hTZhaVKFyn2lBhLUdNzX4GlyO6CmmQFdE9SYCq2IvYItiNz2qWZZKjPHKWZQ3pISZKuM3laTnsBrj88oWZRgWLDWOgYCPbZ8odRTHtrbR+lmtSCz8EnZJlWDtBlDS629PvaKfkgfzG5OLjLQB3hcI++Si/H7bQ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722842623; c=relaxed/simple;
	bh=umFpxCUn+au3HF2NxksXKJAeihuMffW9VkiyHlVMD4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GgRKXU6fsnp769C5nC8VPCUjh07/7hPqBI9M9yAIQwWNAcJ+iZm7hSB+bSOkyXkuMuGixqMZbDMgJIM0OkDYnONhXGxQcwk5MiluL3d1tJjtPC4E4CGWYlHoF95ken/lQ0+SB5xrRXOANMhjoyJVF0orZStTOZXDU4YHrdOZV20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qVIMX+Fk; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52fc4388a64so16083017e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 00:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722842620; x=1723447420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sodQ83Zi4tI79ZwD9QYiXR5Km+yKuCSvXk/CIGbleQQ=;
        b=qVIMX+FkpbZYvB6jCVBNdEUBQEIbK/X9wSg+XrJq5sTIAc+fqFP5jFEFTBYI5Lo5fl
         /9uuQvd2wIoOe8kFrOhBAjPTRoQdWk4a85H4hQ3fjVrxDPeEasEBWx/9D0N5n3qPu4Cy
         6U5JGsAmWru0Ia0D2X1xrgbB6Y99vdjX3poeLLMNoospA8IJbsE1UMfaxrt+4fET+hfK
         NMWvVPs13mJd9w6v7VX8vdWqJReErnYcgw3E6qJkuigZdMiY1h4lOFerCoQxD1hsb3Sn
         o9wVZsDRetagQcNrnhmq2ArTPXYvKUJiGQTZpqfkiHAATPZUp3x6gmdqnfJW/BXHCdJT
         vLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722842620; x=1723447420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sodQ83Zi4tI79ZwD9QYiXR5Km+yKuCSvXk/CIGbleQQ=;
        b=kJXJVoH4NWnzMMdj7zerFl5mxETsCg4lZwG3qk32+28ze5RCSXHni3hMXl+1cAZam4
         VOF6hL6rTUcAZh8VjRXZtdZ94SaYlps+ANKUz0xPD/La+pwIktwjr1gd3c6QqxyWrMee
         kdO/WOnjHj2FsEfkvh1rp7TwWGctCT4mh8msrSoFjIpfKJWYXikPSk07Kr8Da6Z+ox+h
         lfmHWRhW+9K+1MP720QFxOffuXqmZKJNz9B6S7X0UmvNds46DNK/SP1LMZpvgff7VsBm
         wAAvWf5+BV638ZGwPD6n6qQf88+5MA6xVn49/w1JIMX+1XhXYpsysfaDBj2oKwZaQ+Yy
         cxlw==
X-Forwarded-Encrypted: i=1; AJvYcCVrt7j7GOi5mVM/zKfLqws5ivjzfviXNoQG0YxBve91HcUj4VwK0Og7QTqDS2N+1dBADtiFamcZlIPGF4oZZXfPgWvx42b2dVy1E3BQ
X-Gm-Message-State: AOJu0Yw/612d48ZPDNGUrJwMEz1td1dqRstMcyNRmG/yZl0r91jfXzBI
	7sQVhi8kftvhuGj5D9Wu9to0oUwT7tcZOFg+cq9EVZrMlEMB1OUS8UBQo7NNmp5M28lRwUoODEI
	mtdCrjKEXqYJREGF7Tc/2cLNOy4DLUt6Rs1stpw==
X-Google-Smtp-Source: AGHT+IHMEDV/XB6PuAMs/y2jmCQDs4ViBP5jan/yA0s8errZ3yGWl59Dy3YOXALgdmE/wb9d85ASLLh4iw4wGNH8EhY=
X-Received: by 2002:a05:6512:ac6:b0:52f:159:2dc5 with SMTP id
 2adb3069b0e04-530bb39b813mr8199730e87.42.1722842619801; Mon, 05 Aug 2024
 00:23:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1720556038.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1720556038.git.christophe.jaillet@wanadoo.fr>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 5 Aug 2024 09:23:28 +0200
Message-ID: <CACRpkdbp4HhXNutMgA-tBbQSzzO0zq9Tia3WS_fXNtgJ6Xr8ag@mail.gmail.com>
Subject: Re: [PATCH 0/3] pinctrl: ti: ti-iodelay: Fix some error handling
 paths + 2 unrelated clean-ups
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: lokeshvutla@ti.com, nm@ti.com, robh@kernel.org, tony@atomide.com, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 10:37=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:

> The first patch is completly speculative. It is based on static analysis
> when a function is called in the remove() function, but not in the
> error handling path of the probe.
> When looking deeper at it, it seems that part of
> ti_iodelay_pinconf_init_dev() also needed to be fixed.
>
> /!\ This is completly speculative. So review with care /!\
>
>
> Patch 2 and 3 are just constification patches spoted while looking at
> the code.
>
> Christophe JAILLET (3):
>   pinctrl: ti: ti-iodelay: Fix some error handling paths
>   pinctrl: ti: ti-iodelay: Constify struct ti_iodelay_reg_data
>   pinctrl: ti: ti-iodelay: Constify struct regmap_config

Patches 1 & 2 applied, patch 3 was already contributed by
another developer.

Yours,
Linus Walleij

