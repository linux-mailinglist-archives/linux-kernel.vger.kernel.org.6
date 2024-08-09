Return-Path: <linux-kernel+bounces-280621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE1594CCEA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAAADB21480
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24BF18FDC5;
	Fri,  9 Aug 2024 09:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LBvqdEtT"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384CFBA41
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 09:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723194437; cv=none; b=VE9I//Ghn+opQbi5tSG7xDy99DfYBtZCxXpEAK0hfnW71IN8NNe8pjT+saM05b/Wx5C7ufzpMzCyb41p6NV+phHaoFbLNEPB/Vne8eJP19vTwuWHMafFwfDOInPTTz9gc/HybqQrDbKVh1t1qMyXRad3JFcog5vW9+q21WrJW0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723194437; c=relaxed/simple;
	bh=nEJVtcoMpn7xsXtIMc1Qo1u4UbOJ5jaOpWiwSsCd87A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oQ1Yuv1RgO6a95/+WYQ9OYQTO1ke6NglxzD7WOBocofmbzViIb08B94043RNp/IF/273ihYrrg6MIBGjH75Fgr6scOSb2OlHCEwwnzKsodXIG1lmmNQliA7tFGWMJj82L276jFPVb6Tm5fM2SzlscVApKrrMxjbVaSGW3wxawbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LBvqdEtT; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f149845d81so20885641fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 02:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723194434; x=1723799234; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RLxn0IwV+KEsqILm3vURB532jKLGPjcTtemkHlPJtu8=;
        b=LBvqdEtTo4nXtoreyggA1gTLJ9c76gbSc+Ug8M55Hqh15U9O8OxrqSOsTJMV0H3wGY
         UBu0MyUF+O0xk1P2Lx1RnRqbnwwlIFaNO0im+pu9a5/kEotmK6xgsLO+nEj7b4qgnB99
         GwWRRnUXN5BxS7smC8M8ILLIYvhZ+/b1wwpBiepb1QKe7wYgoknznII3OR1UTa2aBrbJ
         KbWwptTVx+PxhjvzQuW5yTOJ+BI17focuSQllKuWt9SyCw/d2SzS1VTUgMGQCFq9Fiwu
         arox+iLYzi9JSNQDP71trDQ//4agIpH/GPl0K/DUS6GtnnNLjXIXdnRbNgR0WoXAH/L6
         ZH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723194434; x=1723799234;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RLxn0IwV+KEsqILm3vURB532jKLGPjcTtemkHlPJtu8=;
        b=b8g7LDAFwW1bWHY2xlxa3QVu32ucjjykx+ajyQ9UkapBuyV/Pzh6orR3siJdDXf6cJ
         DFBFlzG8QWNeL8y09YQ2nLNNFccsD8YObCQSpA/qAdO6iY3DNmSLUkuH4UPIOlVL/OEm
         vEv2xmZCe6eUTL9gzfBVVREf4+daa6S/OeGQVOYcSyWSwaS7hdpzYHyIZnACtx/Ndvuh
         hIHpnWBcRiNcQeT+JKxMIukxU6x95eixQK5nFrcBDFdvUy6w0keVxUltOYNMUBQ9rWe/
         ePvSKXo038GQ/nZbW39HkUGSaIT4GgAZ0RoXpOXbt6atiEUaZb7YObQswtLdCZrBGsjp
         Y0Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVLCLYCnMhNcl9VQjgwZRnT+Ui0HJqO45PEdmcgAo6bP5eivOxxmIfGnEZmcQHqZRXGXfoDxssSg3rnW5X3GMflOURHctKLr8cjdb7o
X-Gm-Message-State: AOJu0YzY7ke7FxDAZHGhz9Epz279OrepiKw6/2hk16Px6U2+IgszyMAI
	UUud8sbIK5hWUNoTr0//5M3lqwmhGDN9PLwUiqGeR+/lxjwCe4RaJxfdRDTbSp0=
X-Google-Smtp-Source: AGHT+IHhnLFl3rT+x7KMYXiEdQNEfCuCtExoR2tPSUmgwgq125nOMspyp/xEWEFKq5hnf+UiwSSYHw==
X-Received: by 2002:a2e:4612:0:b0:2f1:929b:af03 with SMTP id 38308e7fff4ca-2f1a6ce6ec3mr6769431fa.30.1723194434144;
        Fri, 09 Aug 2024 02:07:14 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c7492cesm66204715e9.20.2024.08.09.02.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 02:07:13 -0700 (PDT)
Message-ID: <d9e2f63519f3fcbf4fe334975691d573e20c53c8.camel@linaro.org>
Subject: Re: [PATCH v6 01/20] clk: bump stdout clock usage for earlycon
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Peng Fan <peng.fan@nxp.com>, Michael Turquette
 <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>, Peter Griffin
 <peter.griffin@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi
 <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, Sam
 Protsenko <semen.protsenko@linaro.org>, Tudor Ambarus
 <tudor.ambarus@linaro.org>, Abel Vesa <abelvesa@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>,  Fabio Estevam <festevam@gmail.com>
Cc: Will McVicker <willmcvicker@google.com>, "kernel-team@android.com"
 <kernel-team@android.com>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org"
 <linux-samsung-soc@vger.kernel.org>, "imx@lists.linux.dev"
 <imx@lists.linux.dev>
Date: Fri, 09 Aug 2024 10:07:12 +0100
In-Reply-To: <d4580b33c195dcf1c3a0054b29555383d2e1606b.camel@linaro.org>
References: 
	<20240808-gs101-non-essential-clocks-2-v6-0-e91c537acedc@linaro.org>
	 <20240808-gs101-non-essential-clocks-2-v6-1-e91c537acedc@linaro.org>
	 <PAXPR04MB8459F99475C289A827987AF588BA2@PAXPR04MB8459.eurprd04.prod.outlook.com>
	 <d4580b33c195dcf1c3a0054b29555383d2e1606b.camel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-08-09 at 10:02 +0100, Andr=C3=A9 Draszik wrote:
> Hi Peng,
>=20
> On Fri, 2024-08-09 at 07:16 +0000, Peng Fan wrote:
> > > +static int __init of_clk_drop_stdout_clocks(void) {
> > > +	for (size_t i =3D 0; i < of_clk_stdout_clks.n_clks; ++i) {
> > > +		clk_disable_unprepare(of_clk_stdout_clks.clks[i]);
> > > +		clk_put(of_clk_stdout_clks.clks[i]);
> > > +	}
> > > +
> > > +	kfree(of_clk_stdout_clks.clks);
> > > +
> > > +	/*
> > > +	 * Do not try to acquire stdout clocks after late initcalls, e.g.
> > > +	 * during further module loading, as we then wouldn't have a
> > > way to
> > > +	 * drop the references (and associated allocations) ever again.
> > > +	 */
> > > +	of_clk_stdout_clks.bump_refs =3D false;
> > > +
> > > +	return 0;
> > > +}
> > > +late_initcall_sync(of_clk_drop_stdout_clocks);
> >=20
> > If the uart driver is built as module, this might break earlycon.
> > Before uart driver loaded, clk disabled per my understanding.
>=20
> You're right.
>=20
> With this in mind, I'm not sure then if a generic solution is possible...
>=20
> I guess it has to be duplicated into the platforms after all and platform=
s
> can enable this if they opt to disallow uart as module?
>=20
> Any other suggestions?
>=20
> > > +
> > > =C2=A0/**
> > > =C2=A0 * struct of_clk_provider - Clock provider registration structu=
re
> > > =C2=A0 * @link: Entry in global list of clock providers @@ -5031,6 +5=
156,8
> > > @@ int of_clk_add_provider(struct device_node *np,
> > >=20
> > > =C2=A0	fwnode_dev_initialized(&np->fwnode, true);
> > >=20
> > > +	of_clk_bump_stdout_clocks();
> > > +
> > > =C2=A0	return ret;
> > > =C2=A0}
> > > =C2=A0EXPORT_SYMBOL_GPL(of_clk_add_provider);
> > > @@ -5073,6 +5200,8 @@ int of_clk_add_hw_provider(struct
> > > device_node *np,
> > >=20
> > > =C2=A0	fwnode_dev_initialized(&np->fwnode, true);
> > >=20
> > > +	of_clk_bump_stdout_clocks();
> >=20
> > If clock driver is built as module,=C2=A0 the will make the
> > clocks will be always enabled, if my understanding is correct.
>=20
> until late_initcall_sync(), at which point it'll be disabled before the u=
art
> driver has probed, yes :-(

Sorry, ignore that. If clock driver is built as module, the code to bump
the clocks is disabled by the time this code runs (due to setting the flag
as part of late_initcall_sync(of_clk_drop_stdout_clocks)), in other words
it will not bump the clocks at all in that case and behaviour is as before.

Did I miss something?

Cheers,
Andre'


