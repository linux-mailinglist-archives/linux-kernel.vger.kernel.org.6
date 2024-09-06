Return-Path: <linux-kernel+bounces-318635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E5F96F114
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC5B281666
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507EF1C9DDB;
	Fri,  6 Sep 2024 10:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knpOi3WS"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA0017ADEE;
	Fri,  6 Sep 2024 10:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725617468; cv=none; b=LcwAkVEMbK783ySomizBU6fZ5tZdw9USDb75/t+sSznJibHZAcQqtX8YkeEt4vlfqocSq7VDtlD5nMSBNuFBy0W12F64nZO80pvQege38y3EoTpAHd0tP0rUrrSZJrqR1WnhUg8s8dfoDU8uAryctbaCaFirHc/+G7ZPGlvDLNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725617468; c=relaxed/simple;
	bh=Wrsol6aKw9uVdTSdlWkD5Y05e14U7sz6vsblZrfii2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5LPWT78XnQ96Vjb8MtuICWGFCWTWKzdBkUq13A5OyS+FCLz3pBk44Q4xxe/GO/MZuoPRJk9PAhRzt0SZ4mhcn7AMOFRjJWs0g47AYXxr2M9XqH8gaO3QMj31hH2JOrYkjRzxBWlgW00NnbEBTKBl76IDIk58Y4UAM1P2eZyQY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knpOi3WS; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e1ce8a675f7so2161843276.3;
        Fri, 06 Sep 2024 03:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725617466; x=1726222266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wrsol6aKw9uVdTSdlWkD5Y05e14U7sz6vsblZrfii2s=;
        b=knpOi3WSEd8QzroeHTpoJ3JIJC8O5jS5Bf/r1lLL/22lGEmN1Qt0vfudIx7zIM1O39
         /sHUOBSUV+jq5ACAuK4p5OBr0+xDiWxbDcfzps8VNjXF5aoEXDUrkj/6MVlSbIbqmCOx
         gdAZFu4mQfvnDmrx8pb2c2PhlX+2cooBtE9KY6wawU/x9spnisfVDQgNmekCmXrPJVg1
         sH+dHjXtGG2vmmF0IAQ7NxXtZm8RM0WudKZ4CMM7BKCMDk/cEv/W39TGKFkm5sG0/e0f
         dKm7M/nm/tzqEe7gyQ7hzoDM0cWRhinxjYzlveZsvao2e2lTLUqKP36INWzFzd4V8VGd
         Ws8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725617466; x=1726222266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wrsol6aKw9uVdTSdlWkD5Y05e14U7sz6vsblZrfii2s=;
        b=M4c0La69cOztW7YfX2nFo6a+Qth2zQY8IzVsnTX3vqRGAnffELtpM7t+1bjf5cmchK
         3cJUEnQunq0K6lU32NQGLbrGUsmMaFcPUBmncNEk9M0vESQg1PJVvtyPyfslMiRoWNZX
         HWDzneaYVqRyfIzZzNIrf/kgGipYCUO2w00GIzraKtn8M49dqWPAZYUhOz4W8S+Gcyp3
         cY150qa+/fdJqSN2wdvZh2HnZh7W6jeLvzjFhIaVE/vklM0ibPzqy/oVXj1RrtfmZa0Z
         jSt3IFxo9RM5LCsE2XaY5pivAlWzs0ktcSPDcb6dKNYkgQ2cnqcSm+0PDqJPQj7sbYP8
         ZBWA==
X-Forwarded-Encrypted: i=1; AJvYcCX1s0aoY4Bun7CnLHTQRWZwHl6bTThThFA/8WsKshjKWypDAJROiBa2NyahX6pnhfVfXF2EEhP5UbLh@vger.kernel.org, AJvYcCXNFxWVj1iv6NZuJuFZsCsFd0zkunmPtK4VOLH3hNc5PPO2vWOg5xp0Dat0PVwDYCzgvVHOMJyef30oog9k@vger.kernel.org
X-Gm-Message-State: AOJu0YwAel4pZtCdZQBBJ+XygzCfWEA2uqlsHgNxvvPTM9bgyNcfb8zx
	3wmq0xHgdwLTHkdOTUGSTgy1gJ8Q9dWRTnHUisMvbxPt4SM7BGU4zu4eR0g/ZCpiR8qG0s7R7vu
	Q2L7Dc1A1+iYUhLFI70uEpPixFx8=
X-Google-Smtp-Source: AGHT+IGWcWAX0/60a3kLYTOxWZ/RBDMXvA9Bhh0EDGWHKhS2U26NaLeBKk/71kFQtwBOx2YojF+fr2635MJZT3i5ArA=
X-Received: by 2002:a05:6902:2290:b0:e13:d0af:b1f9 with SMTP id
 3f1490d57ef6-e1d349e6433mr2440672276.44.1725617466380; Fri, 06 Sep 2024
 03:11:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830085441.3589713-1-lukma@denx.de> <20240905143645.7946fb0e@wsk>
 <CAOMZO5D3y1_-_TX_a7zuYPxdRKGHGN7JFwWMNe_dtS6i0Rx2jw@mail.gmail.com> <20240906100248.39156474@wsk>
In-Reply-To: <20240906100248.39156474@wsk>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 6 Sep 2024 07:10:52 -0300
Message-ID: <CAOMZO5B5DQGdW9mnVPzHcwXU824WFrxEpCBff56Co23RrYadKA@mail.gmail.com>
Subject: Re: [PATCH v3] dts: nxp: mxs: Add descriptions for imx287 based
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

On Fri, Sep 6, 2024 at 5:02=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wrot=
e:

> As most of those bindings are "legacy" (and already upstreamed) now - it
> could take some time...

I am not saying that all the mxs dt-schema warnings must be solved to
get these new i.MX28 boards upstreamed.

I am saying that all new boards must have an entry in fsl.yaml.

See this commit for an example:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
Documentation/devicetree/bindings/arm/fsl.yaml?h=3Dnext-20240906&id=3D7dfb4=
97191f0d87c3b3ccfd3039df4c03d6769f6

or this one for the i.MX28 boards:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
Documentation/devicetree/bindings/arm/fsl.yaml?h=3Dnext-20240906&id=3D8ddbc=
7b9ef9862c34117ec552f00a054101ffc36

