Return-Path: <linux-kernel+bounces-274257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A249475BE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3207D280C4F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD42B148FE3;
	Mon,  5 Aug 2024 07:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xndt+Mo2"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA986A01E
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 07:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722841702; cv=none; b=WCwVtOQ5Dvt43EZWfUBMVLUllGAyCXJFYab6yn8/nUdkV33mC9OfAGGx7S90V+nesk6fLfDtAh8li80OWMk0iReGDkRz3sTu9gYrGg7S7niE7Djdr3xBE+VgDBUL51YYHqd1xs6s/jQHt3D4POn6FAceNX297BZAVP2fijpm2Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722841702; c=relaxed/simple;
	bh=JigMBQHuoeximj8/IC6wBuOolRs3qpg2BF5ooo+VtA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QhMQnookD6uz/wF4VNpgjWAOnvDWFmxfa/82Bci9eszmlxl7pp3AbTgy9aOS6DcR1DIeZ0UhM/8rgrSIM3hY2O61EEfXLJ9ex3sSySsocYuy+RmkjI4ZhZUjseP4NkDovS+91UwIbtxaobPvtZSuuPpIjSYMaC3+EVvA6/gd4yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xndt+Mo2; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52efd530a4eso15746554e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 00:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722841697; x=1723446497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JigMBQHuoeximj8/IC6wBuOolRs3qpg2BF5ooo+VtA8=;
        b=Xndt+Mo2IO3wLXqu4b0H+srkNDToP1MnC91oVb3owQBehT+A7EVFzd0raqnrVsCXdS
         NSkXlQmiuAUjnnC9vbDWsqoOPBajLIB+xSRVkMIP+C1QWpIpRhTRQ5DE28eSwt0uYGLN
         WzTGqlAsxQikyptqBe1XW/szG7VZVPCPOE6V3s9b1m5NwHrl2We9MmDRpi41/JpnQ2wB
         EBSrVZ+m6hhIzqPVcBWZMbGBieVjjeGz6y2IsJCc2uC9WdFnyNcu2cp/ReythONsVbfJ
         mJ/KdtCj9Kmu2uTit9lx4rZ2IF0W3a0i+zD5FfSYJHuuWrnqWQZpQYSaeoxgAdZhDwmS
         TwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722841697; x=1723446497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JigMBQHuoeximj8/IC6wBuOolRs3qpg2BF5ooo+VtA8=;
        b=bHkSVtC1RnzzKB/kCtu3heN+FeNOk58rDVtGixb9CZ6xW4xSjWlmPu9HJcD8s2TvnC
         tCAaHGfL4q5xcpjxslylbai3hoCrHH0lvIpsDqELJTXKx6wUht02LSTrqXru6uBmRDs2
         nKhxolX2m1u2FyUOalLQWCTyMI2oCFDKuBeb+XXxK066n57IXLu4c1czWH3Z2+BM1hCl
         wANXsf+hfErRqe4nzmAlQJ3gGkzLlr2froscc0XGgme6FGUMUxDDCHrXfgtNRnLUDqlb
         v2IkTiKDe0FWXPulF5BcLZL1Hr8BO+Dm0XAs6gajvXhjDFdP1G8mf5urvjZSiSpryP9L
         8SoA==
X-Forwarded-Encrypted: i=1; AJvYcCUZ6z0GNvI32s2aS9Ihh71q9/QXW58ztokSsGoLFKugeIphlE1fOjL5OXJv2MFEv6+Oe/DrozwKedBaii8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwObbnGy0R4pvsTqPKEAsNhm+RZTmoz42lELQ5c9PZ7XbKO8Jsp
	cKJDiHrWJ/aeXA1dCRPJIZ09wD8ksd4lLtx32XwNVoJTQug8ueRucIWMMIwa9emBR0eTYo9780N
	TTFaEl/DjXVFblflGEw0MlA5B8yXse28LhYwKnw==
X-Google-Smtp-Source: AGHT+IGUNyfaJFjWk8BA92L0/xnKRR9vaRbFLTfDsoMxhm3Cd+zd19C1NT5F6HTMpjAQeVAaHckjwkijte4PFsXLu2k=
X-Received: by 2002:a05:6512:a93:b0:52e:9cb1:d254 with SMTP id
 2adb3069b0e04-530bb39dc80mr6822512e87.46.1722841696980; Mon, 05 Aug 2024
 00:08:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704-pinctrl-const-regmap_config-v1-0-9d5570f0b9f3@gmail.com>
In-Reply-To: <20240704-pinctrl-const-regmap_config-v1-0-9d5570f0b9f3@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 5 Aug 2024 09:08:06 +0200
Message-ID: <CACRpkdZjTDzpXhe5v65yLiP3WwcOdP3uBwpm9C1SZ8BWUDhubA@mail.gmail.com>
Subject: Re: [PATCH 0/2] pinctrl: Constify read-only struct regmap_config
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 8:36=E2=80=AFPM Javier Carrasco
<javier.carrasco.cruz@gmail.com> wrote:

> This series adds the const modifier to the remaining regmap_config
> structs in the pinctrl subsystem that are effectively used as const
> (i.e., only read after their declaration), but kept ad writtable data.
>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Patches applied.

Yours,
Linus Walleij

