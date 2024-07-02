Return-Path: <linux-kernel+bounces-237639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAE6923BE5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A16928193E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79ABB159205;
	Tue,  2 Jul 2024 10:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFviL+1h"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6E5145B0D;
	Tue,  2 Jul 2024 10:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719917777; cv=none; b=BaZncbxETylW29KW5TGVymO/+QocyEMU006EXz90dkeYeKPH60GJ7TnhRLobQpZtZIKBU5gW7PjseYMbsx+Omef+qhEgU0xgHpQMkwc4Yxci/N4TX+r2Ytf1Eser6yd5rn+NOZYu0Ux6f+9LqeEI0FKYSjqiyoodvdY+ELcxn1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719917777; c=relaxed/simple;
	bh=+zG/PNeN5dOPIlWsfsGJREHjS56Cp/F1XPGI72hFguU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B5l+S3CCIQMib+2P/6RkQziZ/easGEblE7CtGrK/UPT7Ia9UdYSvvSeVY6rcq6gVXoQXc5uHMJeu258Ofo/uyGKyPuvjDLQ72Wq4srTmNVQ6Z8IieonLXvuF7kmyvwr5CCDgbwZnir2WiMvmws7FwIEfyH8Z6xq3eAYf9LL19Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFviL+1h; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ee699b0552so1947661fa.0;
        Tue, 02 Jul 2024 03:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719917774; x=1720522574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zG/PNeN5dOPIlWsfsGJREHjS56Cp/F1XPGI72hFguU=;
        b=hFviL+1h9U7ZbHi7OpproHMov6clY6Zu3wsr9ggzdl1vS2XdX+VzceqPKaMwB3soOf
         6ybH9T/VReOHRyH67qgZEdmbQMM9nbQmIycqM/Bg5nfCLQC16y+VjcriOl+n2/Ot1Z2h
         2Kj8ha0T9AfNByCPFare18J+EBxYvlr4lxqFeU/IAT6n1aJjeMZSSHWRcQOVgv+PCkcG
         41/0UC1eglCVqnrlT3BsWLrS+dz8Xl9x5a39O67e3LO59jJZujsxmHcf76SjPGKcdEl7
         jkl90h56TUBmeioLkGjelQ8amUwnOceLA4cUNPtEeKutOZ+U/9/D4YQyWpo8UxjyTQqV
         L81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719917774; x=1720522574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zG/PNeN5dOPIlWsfsGJREHjS56Cp/F1XPGI72hFguU=;
        b=vGapxoLwmu8671e3lFV25Lik0tV20/BNGEe4t4KS0fFa3wQDS6aybYBUZIJUwMNPj4
         r6OBt7vWv0pmv5WWSOE3Pak0lcUtPINIgQW+ZEdwk7LkhW5zEJRuN+Hic8A6GrtUpKqT
         F+A7mxrxxW4O4yXb1DZmxruB1FE/Rjq4lL6mOjtVL6XXEI0/8ElRbDizf+LgxjRAIM+t
         uYuVeBhrZ5kLlcBOJc06Ey3rTqPIJAc3aNR2YfhEtPvVVBVufOID3sdI0c0IYSiltcm8
         ZxcpOe7kdSyMrm4KC0XNllovuh6MYF6LnAxAL5mG0PA9aLYZfNdBPoiRQ9iwJzTR91R+
         ICIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9OcTGIveMMXIY4V7mPE9dJDKdO+6G70IfnL767LOBQVYTi1QEpjBEypoVhRb+G8SS03ojh2Scg9bA8W7LpbK106Mzn4snp1c848bDsNm5d7nbc4BsHJR4hDI6+6B4obTKgaD+ksOLiA==
X-Gm-Message-State: AOJu0YwNCFuVgGFm4AD5D7agTrqk1tj8ljSHG5SOCEOslWAVfNYBhxhW
	iqlGKZ7HFuYWbojKKUv4NimzCQBRckBjBYDWcq2eHmXaJ6lVWBX5bbyC4ixvNiFy8Jy1PourpL/
	BQVMLyY+r4gY2ZDEQauOJ9kMqkRk=
X-Google-Smtp-Source: AGHT+IFGKnu3LmXfbShEa73SwxFF4gyNqwctQrEMh2t1spWWecMRMfRQcnyixZeqbze4/hjOou+RQQKGd4uYEnYJjWw=
X-Received: by 2002:a2e:92d0:0:b0:2ec:6196:55e4 with SMTP id
 38308e7fff4ca-2ee5e357597mr49483081fa.2.1719917774297; Tue, 02 Jul 2024
 03:56:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701-imx8qm-dts-usb-v4-0-03cdbc8c44b6@nxp.com>
 <20240701-imx8qm-dts-usb-v4-2-03cdbc8c44b6@nxp.com> <ZoN90rHfpK7niqEr@dragon>
 <ZoOAjSUp29DBhY+/@lizhi-Precision-Tower-5810> <ZoObnDqMd2EL4W6F@dragon>
In-Reply-To: <ZoObnDqMd2EL4W6F@dragon>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 2 Jul 2024 07:56:03 -0300
Message-ID: <CAOMZO5BigqCqfou7NAzeVZ0Fp+AJQV20BYexROnaCJwU+etF2A@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] arm64: dts: imx8qm: add lvds subsystem
To: Shawn Guo <shawnguo2@yeah.net>
Cc: Frank Li <Frank.li@nxp.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Dong Aisheng <aisheng.dong@nxp.com>, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

On Tue, Jul 2, 2024 at 3:18=E2=80=AFAM Shawn Guo <shawnguo2@yeah.net> wrote=
:

> I do not see "fsl,imx8qm-irqsteer" in the patch.

I sent a patch for it yesterday:

https://lore.kernel.org/linux-devicetree/1c1e3224-1b3d-438c-bce4-5614329246=
2c@kernel.org/

