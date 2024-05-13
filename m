Return-Path: <linux-kernel+bounces-178119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A357D8C4901
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 23:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ADA51F222AB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF89F84A30;
	Mon, 13 May 2024 21:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="vSR/QEKB"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC0283CD7;
	Mon, 13 May 2024 21:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715636862; cv=none; b=XfSQfE1yQEJ9XoaoWo0Dm5DrpmLiYFCsX9hp969qPBs3MJ+4Pf7Hi4vlKhiKP65AOSifKQcsVdyue0/9DZz/g1qRpvxci0lDFIbqNbTlA4rncEHgLDi18KTMN4YN8gGCiVHrcEUlqpICYuFdxjKwMfL+Yz2r07eJynX2J76PKmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715636862; c=relaxed/simple;
	bh=jDCQIjVqZVc5wUwm1ijALwsy3NpnKwstDOn1Vl7lrQM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVdmhUskE6OeLjBwMn4Em95AGUtUeBnzwvtj5sqeJgYz1bYwzMmQ+xCxnQKdbFczj+pE2HbyRrqjFQG3/DZ7UT8maw4SkfsnRAwW2tOG2tt+4bGYSkU+vf8cHO/KZ7+EJzrznhePj7ggKq+vKeVS0ddeGvf3w2HVCDiT4ebIAM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=vSR/QEKB; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 591CE12001C;
	Tue, 14 May 2024 00:47:29 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 591CE12001C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715636849;
	bh=ZM+lhNatKFUHF9a5/vTMQlspJzgvNe8FHwZNKI0g9q0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=vSR/QEKByL5EOOHvOy4bWeZ01VVdtBRk4ratwRSJMeGDlEA7q+1H4RIko65+sPvvw
	 8pgRVvW9Q5IM2cyfTMoM7glWw6OYHmYHXCzizc1xhHmrRhDMo/Ha+WJAEiu84k30js
	 HgWDmc6UaAC9mXZ/RPlq/gZ8xo+M2wUUBPwmZJd9eMfyMJ4IMYZ0+vEW73X2Mpz6dk
	 gWotq29uAjyKzT92Ha++7hStbvYbBoN0E5nCST/lCJZk8/Mr9FnlziwQKoMkUEzVTz
	 u7V6sXnHeMBol2wYHoVf3qwfp3cnW0QY4cjcO3wjUtbdafjckNvnA4XbPVia0wV49v
	 v6l6RDAvU8S+A==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 14 May 2024 00:47:29 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 14 May
 2024 00:47:28 +0300
Date: Tue, 14 May 2024 00:47:28 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Jerome Brunet <jbrunet@baylibre.com>
CC: <neil.armstrong@linaro.org>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <jian.hu@amlogic.com>,
	<kernel@sberdevices.ru>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/7] clk: meson: introduce 'INIT_ONCE' flag to
 eliminate init for enabled PLL
Message-ID: <20240513214728.g4isbfisifxalqxy@CAB-WSD-L081021>
References: <20240510090933.19464-1-ddrokosov@salutedevices.com>
 <20240510090933.19464-2-ddrokosov@salutedevices.com>
 <1jfrulzxms.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1jfrulzxms.fsf@starbuckisacylon.baylibre.com>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185198 [May 13 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/13 16:04:00 #25186646
X-KSMG-AntiVirus-Status: Clean, skipped

On Mon, May 13, 2024 at 02:44:06PM +0200, Jerome Brunet wrote:
> 
> On Fri 10 May 2024 at 12:08, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
> 
> > When dealing with certain PLLs, it is necessary to avoid modifying them
> > if they have already been initialized by lower levels. For instance, in
> > the A1 SoC Family, the sys_pll is enabled as the parent for the cpuclk,
> > and it cannot be disabled during the initialization sequence. Therefore,
> > initialization phase must be skipped.
> >
> > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > ---
> >  drivers/clk/meson/clk-pll.c | 37 +++++++++++++++++++++----------------
> >  drivers/clk/meson/clk-pll.h |  1 +
> >  2 files changed, 22 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
> > index 78d17b2415af..47b22a6be2e4 100644
> > --- a/drivers/clk/meson/clk-pll.c
> > +++ b/drivers/clk/meson/clk-pll.c
> > @@ -289,11 +289,32 @@ static int meson_clk_pll_wait_lock(struct clk_hw *hw)
> >  	return -ETIMEDOUT;
> >  }
> >  
> > +static int meson_clk_pll_is_enabled(struct clk_hw *hw)
> > +{
> > +	struct clk_regmap *clk = to_clk_regmap(hw);
> > +	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
> > +
> > +	if (MESON_PARM_APPLICABLE(&pll->rst) &&
> > +	    meson_parm_read(clk->map, &pll->rst))
> > +		return 0;
> > +
> > +	if (!meson_parm_read(clk->map, &pll->en) ||
> > +	    !meson_parm_read(clk->map, &pll->l))
> > +		return 0;
> > +
> > +	return 1;
> > +}
> > +
> >  static int meson_clk_pll_init(struct clk_hw *hw)
> >  {
> >  	struct clk_regmap *clk = to_clk_regmap(hw);
> >  	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
> >  
> > +	/* Do not init already enabled PLL which marked with 'init_once'
> > */
> 
> That is decribing the code, which we can read. So not really helpful
> Saying why you do it, like "Keep the clock running from the bootloader
> stage and avoid glitching it ..." gives more context about what you are
> trying to do.
> 

Yes, I agree with you.

"Instead of describing the action, provide the reasoning behind it."

I will incorporate your feedback in the upcoming version.

> > +	if ((pll->flags & CLK_MESON_PLL_INIT_ONCE) &&
> 
> I don't like INIT_ONCE. It gives the false impression that
> 
> * The PLL is going to be initialized once in Linux if it has the flag
> * Is initialised multiple times otherwise 

But that's how things happen. For previous clocks on other platforms, we
assumed that the PLL could be initialized multiple times: once from the
bootloader and once from Linux. We didn't have the ability to disable
initialization from the Linux side before, so it meant that multiple
initializations were potentially possible by default.

> 
> I agree that currently that carefully reading the code clears that up
> but it is misleading
> 
> CLK_MESON_PLL_EN_NOINIT ?
> 

I have been considering this name and its derivatives, such as:

    CLK_MESON_PLL_SKIP_ENABLED
    CLK_MESON_PLL_NOINIT_ENABLED
    CLK_MESON_PLL_INIT_DISABLED_ONLY

However, I find all of these names to be quite long and bulky. It
reminded me of the WARN_ONCE() function, which ensures that a warning
message is only printed once. In my opinion, the name "INIT_ONCE"
accurately reflects the situation.  Nevertheless, if it is your
requirement for me to change the flag name, I am more than willing to do
so, it's not a problem.

> > +	    meson_clk_pll_is_enabled(hw))
> > +		return 0;
> > +
> >  	if (pll->init_count) {
> >  		if (MESON_PARM_APPLICABLE(&pll->rst))
> >  			meson_parm_write(clk->map, &pll->rst, 1);
> > @@ -308,22 +329,6 @@ static int meson_clk_pll_init(struct clk_hw *hw)
> >  	return 0;
> >  }
> >  
> > -static int meson_clk_pll_is_enabled(struct clk_hw *hw)
> > -{
> > -	struct clk_regmap *clk = to_clk_regmap(hw);
> > -	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
> > -
> > -	if (MESON_PARM_APPLICABLE(&pll->rst) &&
> > -	    meson_parm_read(clk->map, &pll->rst))
> > -		return 0;
> > -
> > -	if (!meson_parm_read(clk->map, &pll->en) ||
> > -	    !meson_parm_read(clk->map, &pll->l))
> > -		return 0;
> > -
> > -	return 1;
> > -}
> > -
> >  static int meson_clk_pcie_pll_enable(struct clk_hw *hw)
> >  {
> >  	int retries = 10;
> > diff --git a/drivers/clk/meson/clk-pll.h b/drivers/clk/meson/clk-pll.h
> > index a2228c0fdce5..23195ea4eae1 100644
> > --- a/drivers/clk/meson/clk-pll.h
> > +++ b/drivers/clk/meson/clk-pll.h
> > @@ -28,6 +28,7 @@ struct pll_mult_range {
> >  	}
> >  
> >  #define CLK_MESON_PLL_ROUND_CLOSEST	BIT(0)
> > +#define CLK_MESON_PLL_INIT_ONCE		BIT(1)
> >  
> >  struct meson_clk_pll_data {
> >  	struct parm en;
> 
> 
> -- 
> Jerome

-- 
Thank you,
Dmitry

