Return-Path: <linux-kernel+bounces-307324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F041E964BD1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD1E628754C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E7A1B580A;
	Thu, 29 Aug 2024 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mP9EOgyB"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957801B4C2B;
	Thu, 29 Aug 2024 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724949548; cv=none; b=tc2mMEpVA8pgYD8Kb+YY0vRdiZvmXj9qk8bxnPREFzQlgXZK9CIrHYj0UCcjIHGyvbVqXBmX+uZ5sGK9VntX75BsM4BV4HeANVhenHmXNsVIPh8sCYrhQlO10NsDQkboRhssdxNT9STGBs/Qjt+14yqAXk+cY3+V4crD/59fo9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724949548; c=relaxed/simple;
	bh=p/MuDISQmgVrxGfczwyazNQDiiRp5BTIgmrM2HMq2Qw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vosb3L3xORwZKYeS1m9bgw/d35I+1NXkmX+0vMujy+EI2vCK52gP21Gb5ON/rcdKLeSjID9YLxNndB9C4hIrjnYQj3f6zHplr1jyH8KjymiMKtaAh2fF0SIOG72LtgSKdnZDOdQDpnk4YSrcyhOTnZQe+aGamTMvMgmtyZ0NJjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mP9EOgyB; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-534366c194fso877937e87.0;
        Thu, 29 Aug 2024 09:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724949545; x=1725554345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=am9JYfAtBTZRvIgguTGLzH/4z6K1mHGNhjXagP0jAwE=;
        b=mP9EOgyB1GmYl6n3NX2gEVsvDd2z5RCghRmS/6jWcghSy5d59BVr8ZdPpKCtcBrK77
         ZDNJ7kMnBZ+73ZWPvSkuGH0aoioV7Z1QK2OgL+NstD+9A4mNcK/WTaE4872ZohieICj8
         fumh1k8LpqDLbrbOh0awvkKqlR7OhUmiKKlJZBIqZ0SBQ/PWGi7M1w3Er2NconMqSrK5
         freEW591n81QLu64rn8hYFpKXkpDagzLz5TYwrZGB0bFjaiiCuPS3toUO8M8ET+44jKe
         QOSc4Krqkc78pR2lBe858kFbpbrXeCnTG+wAjYihyoHFu1jJpsnw6Bcph91YwsVI1jLv
         811Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724949545; x=1725554345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=am9JYfAtBTZRvIgguTGLzH/4z6K1mHGNhjXagP0jAwE=;
        b=smH1G8YExJ+8iGX8E0hCtzHTRf0lZfmZ8APp8rspaAf1cFSNNnyc1gNwkoeTQWciw1
         eS05mmfYfFMY6ljpAA110Z6ybdhPWLlGMkqvp+bKdMZafXGF9xWzBBetgRZaANpwnU22
         jYL6vDwHTNWiru/auV6oEDINlcj8IMSOE+poZ+zxP4oVEFay1+t7LtSISWun9u4bQSut
         oq4G2iDrsgBPYiEgssIX5nNOJn9zn3nd+lOvhNlTBQsJ9uz/KVLHvLpVZQK6VFkFysO0
         ziXBGiN9hgnX5Zo8fMRUN4VWH9fD42+tSQfpl9grhCTZkqv3RzCSUjS8BfYHgIJvMPES
         QFJA==
X-Forwarded-Encrypted: i=1; AJvYcCVdXhFm6IkYZqYa2J9QJwxEO1oNEUeJOTBF25kdRliFQ6gW3PCNtq7O72x0j4ug4fl7gQD2en8FlDIMAZLb@vger.kernel.org, AJvYcCXOUuuM1lwgsbu4mXUZSXjZC0FG+MqXk52im1U/S8NtQIb9/qPW2DVPlu8eatw4PG3kGBe4TCHaYOVr@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0dJm1q6nJtT55Kh3i4az8FG4umYsdUDB3dr+CseMsYwZLoL1u
	vqXgFOTHxhDVyb4T3I+T5f4zbKxs8OgqV86CUfm5pPIw38+48IAs6OasqCZPRJ1tRMoVIS3FtzG
	hbVYYlBU4ewvLOc0yQ0pCFiSXr0s=
X-Google-Smtp-Source: AGHT+IFE/5/KDpyzUQTV7CiVgFJUIUX+eqIGNLIUl29XTUsb2eZQus5h7BLWylCbBfkY/R+2DdT4ctWZGk97fzMi6sY=
X-Received: by 2002:a05:6512:1285:b0:533:4642:9e06 with SMTP id
 2adb3069b0e04-5353e574657mr2045541e87.34.1724949544342; Thu, 29 Aug 2024
 09:39:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829104436.3134551-1-lukma@denx.de>
In-Reply-To: <20240829104436.3134551-1-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 29 Aug 2024 13:38:52 -0300
Message-ID: <CAOMZO5CwfWX+xkPSyjafJo=LwMUNx4MfH3qNydbchk8YQ40XkQ@mail.gmail.com>
Subject: Re: [PATCH v2] dts: nxp: mxs: Add descriptions for imx287 based
 btt3-[012] devices
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Thu, Aug 29, 2024 at 7:44=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wro=
te:

>  dtb-$(CONFIG_ARCH_MXS) +=3D \
> +       imx28-btt3-0.dtb \
> +       imx28-btt3-1.dtb \
> +       imx28-btt3-2.dtb \
>         imx23-evk.dtb \

Please keep it in alphabetical order.

