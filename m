Return-Path: <linux-kernel+bounces-569328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE837A6A187
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79729189262B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40AD21420B;
	Thu, 20 Mar 2025 08:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EmorYNF5"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1454C20B7F9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742459828; cv=none; b=Ktn2NPXUiMWEyg12SD4OADGmxaMMQZfo+b+VOwREq5BCOBrLXgIvQ0XpT5oZirtBG0Q5OnSoxsmLhT047Crv3rh4b4sbHLbKrK94nmuV487MxOWC77yLiRq8zzIVUkrP6ihDa4xYga+Xd4bPDOrTWOQ66nvCZKlRpj58PlRBHZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742459828; c=relaxed/simple;
	bh=hmUcDbDQE5/qhB7rH9uJRIBaGhkE8xeNL8a0ANCqzoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PFTyMMbSd+yB0bNhDM3qUGQ4GAhqU8a2BQScAnAe3IjIuWvTCFzgaUioAD6cGkXv77j7N67BmdwI5NbtCylxtPUYuJ/FAOqdwXun9SdQt0FRrgpnRGth5CcJETP5j+bRtMC7vf5819Gh0445sF0HkEROadU+FZ7i0xfqEtGN4WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EmorYNF5; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-549b159c84cso630232e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742459823; x=1743064623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmUcDbDQE5/qhB7rH9uJRIBaGhkE8xeNL8a0ANCqzoQ=;
        b=EmorYNF5kFZKr2odU1VCRdH4nipyx93A0rxIrVH86+rRox5GKKCkUi0lMhwWXUejlh
         wqKzjZniLUhZzkQUE+hdvCnCga3X5TaQxIziEX4TceVybS3Wt+1u7LPNWRUSjH86sSTp
         5YHEhN+4bzAw2HSUhcct1D7MPoUCiGyM+cDXcHixaJVYmFCmYA8T3Mz5dCpq0q5Lg49H
         OOXHWYBkmPedzFhd+YNPLm5ihh3gwL1QFwDS+R+HzJUpHnlDtw2wjHYF+AITvnvLdd6g
         9kaTywEuinvvWKJA0DVII3pwn1dB4ukqcH+47JpGqnVNR8KoPvQUhrUkCa3S+pO+bSJx
         DiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742459823; x=1743064623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmUcDbDQE5/qhB7rH9uJRIBaGhkE8xeNL8a0ANCqzoQ=;
        b=HOLJTlc+Vfur1A/UqrgDzQpAiC9e8E/bGarmJRwPGXDAVVPGyLu1IQfA6IabrsVXD2
         PXpaw/n58qZfqkheqfsA7/h9XxczvY03laxuoSD5bEMRlq+jPW3zuhPTX3eLgYhZIJAZ
         xusbdIFoiDBmZ5/upmCwOVA30xQkjLbfExowdrrmDeF2MTc2BWEfS44juEMEWURLvDtK
         CAF5XzaT0pDP2aOq3eniFMU3ENRjHTQvuhkZDZVpze7trDa5xemA3akaawdrLxxKLsMU
         8u29Xr1rT1e04q2BZ7sBz5KOWImVE0O1T2EDTaObITcG4N+4xs5YNDeYeimTVMxm6cC6
         /LDw==
X-Forwarded-Encrypted: i=1; AJvYcCWJ/SBY/yAwdiTIjM1Itr351skpkKr1fujx9CRqFOa8yssUpr/nYBrakSwT7PzUjAjTIBfDlTvkT87V+gI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxczPA/bDFxo7zbm75jWbsqFHgXGcsvnNiZFCMraG34Xf5sfASD
	q7eE/HI9An5sdKtxG/Cv37/izGnkOiB/UN33yTJd6jYZx7ibmuUNcnAN18DaTyP1EPdgUvIi4kK
	sANbyleydWPbFRUDVaoI9/V/fmwdHwnrBjurgXg==
X-Gm-Gg: ASbGncts+qUOalw5c8CewbIqxh3uk1/zGZHTu/jJxxPsQ9wnyx4l8EVLwsbuf+0Fk27
	bBsYRfy1M8stZIy4Ezmeof2/yqUa/7BW9MH8+5uwspmc3BbDNoZ2MtmzA+xtZpSpw4+y+daaHeU
	DtCBnkW8TEo6CqkKFZ/aoo61n7n1ecYnws9g==
X-Google-Smtp-Source: AGHT+IGsqlhVahQRSkG7TbLmF/njFBK4TQEE/FxA+ei/ZkOhKqP25xKFQdLZXuNAuoQDmy6F4aIS+teAw64uIFaJ5P8=
X-Received: by 2002:a05:6512:3d8b:b0:542:213f:78fd with SMTP id
 2adb3069b0e04-54acb21ab86mr1803850e87.40.1742459823013; Thu, 20 Mar 2025
 01:37:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319092951.37667-1-jirislaby@kernel.org> <20250319092951.37667-31-jirislaby@kernel.org>
In-Reply-To: <20250319092951.37667-31-jirislaby@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 20 Mar 2025 09:37:12 +0100
X-Gm-Features: AQ5f1JrZtQ5rI7bFzzliGItNqbfzqd08CVSHd4xCDa6EbYGurwkXp17lVO1F46s
Message-ID: <CACRpkdYYyrD1qiSj3=F5yqxxoTTJn+rKovpotCk+UZq4TMCraQ@mail.gmail.com>
Subject: Re: [PATCH v2 30/57] irqdomain: pinctrl: Switch to irq_domain_create_*()
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: tglx@linutronix.de, maz@kernel.org, linux-kernel@vger.kernel.org, 
	Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Ludovic Desroches <ludovic.desroches@microchip.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Tony Lindgren <tony@atomide.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 10:32=E2=80=AFAM Jiri Slaby (SUSE) <jirislaby@kerne=
l.org> wrote:

> irq_domain_add_*() interfaces are going away as being obsolete now.
> Switch to the preferred irq_domain_create_*() ones. Those differ in the
> node parameter: They take more generic struct fwnode_handle instead of
> struct device_node. Therefore, of_fwnode_handle() is added around the
> original parameter.
>
> Note some of the users can likely use dev->fwnode directly instead of
> indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
> guaranteed to be set for all, so this has to be investigated on case to
> case basis (by people who can actually test with the HW).
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I assume there are dependencies in the series, if this is something
I should just apply to the pinctrl tree, tell me.

Yours,
Linus Walleij

