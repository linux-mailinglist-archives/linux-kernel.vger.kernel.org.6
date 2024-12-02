Return-Path: <linux-kernel+bounces-427242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690B59DFE86
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D7B16329A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24881FC0EC;
	Mon,  2 Dec 2024 10:13:51 +0000 (UTC)
Received: from mail.steuer-voss.de (mail.steuer-voss.de [85.183.69.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314681FA15A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 10:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.183.69.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733134431; cv=none; b=SWqDlax/4q9/ewC7QU9gCJQmGjENSCHAgEeJisLEuu6chMRb5cFQ8lWP4jKeD9owdl11rcCG0rVIt2AjhjlwoAS6gAOrWhyWZ3A13ag0l67+BRuPZ9zETCerWDGqp1xSu0TOAweEtDScfW9anGKvCpPBWCYO3KPhD3/V09rPIrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733134431; c=relaxed/simple;
	bh=Q2GSUGo7kIT0Qg+1I9fG7GvNmL0znzqSIy1UB/dR3ns=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=YF74nG0uQmlcrvrun9umDPZ7lo7cAD9mGUBTrQyqxYOGxrxkY34MYi26C7TcqNnFvc8BTN77RFrTF6T7wIDsNCoBuETtEE0gGvhyjFOT53qCHDs5H1ffsteZonGUwcISY/3Q8oTluWZwWe1SuzwfBP771q6i2HgNo107HSwce9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vosn.de; spf=pass smtp.mailfrom=vosn.de; arc=none smtp.client-ip=85.183.69.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vosn.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vosn.de
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: from mail.steuer-voss.de (localhost [127.0.0.1])
	by mail.steuer-voss.de (Postfix) with ESMTP id 030D614D;
	Mon,  2 Dec 2024 11:13:36 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 02 Dec 2024 11:13:36 +0100
From: Nikolaus Voss <nv@vosn.de>
To: Liu Ying <victor.liu@oss.nxp.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>, Liu Ying
 <victor.liu@nxp.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, Fabio
 Estevam <festevam@denx.de>, Marek Vasut <marex@denx.de>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, nikolaus.voss@haag-streit.com,
 miquel.raynal@bootlin.com
Subject: Re: [PATCH] drm: bridge: fsl-ldb: fixup mode on freq mismatch
In-Reply-To: <1f0a307a-666f-4647-9f73-e9bddd6c7eff@oss.nxp.com>
References: <20241126172610.AD8B51622C@mail.steuer-voss.de>
 <1f0a307a-666f-4647-9f73-e9bddd6c7eff@oss.nxp.com>
User-Agent: Roundcube Webmail/1.5.0
Message-ID: <000b34cdd1591c82265ce1f9848828d1@vosn.de>
X-Sender: nv@vosn.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi Liu,

On 02.12.2024 07:32, Liu Ying wrote:
> On 11/27/2024, Nikolaus Voss wrote:
>> LDB clock has to be a fixed multiple of the pixel clock.
>> As LDB and pixel clock are derived from different clock sources
>> (at least on imx8mp), this constraint cannot be satisfied for
>> any pixel clock, which leads to flickering and incomplete
>> lines on the attached display.
>> 
>> To overcome this, check this condition in mode_fixup() and
>> adapt the pixel clock accordingly.
>> 
>> Cc: <stable@vger.kernel.org>
> 
> It looks like stable is not effectively Cc'ed.
> Need a Fixes tag?

I will include
Fixes: 463db5c2ed4a ("drm: bridge: ldb: Implement simple Freescale 
i.MX8MP LDB bridge")
in v2.

> 
>> 
>> Signed-off-by: Nikolaus Voss <nv@vosn.de>
>> ---
>>  drivers/gpu/drm/bridge/fsl-ldb.c | 40 
>> ++++++++++++++++++++++++++++----
>>  1 file changed, 36 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c 
>> b/drivers/gpu/drm/bridge/fsl-ldb.c
>> index 0e4bac7dd04ff..e341341b8c600 100644
>> --- a/drivers/gpu/drm/bridge/fsl-ldb.c
>> +++ b/drivers/gpu/drm/bridge/fsl-ldb.c
>> @@ -104,12 +104,14 @@ static inline struct fsl_ldb *to_fsl_ldb(struct 
>> drm_bridge *bridge)
>>  	return container_of(bridge, struct fsl_ldb, bridge);
>>  }
>> 
>> +static unsigned int fsl_ldb_link_freq_factor(const struct fsl_ldb 
>> *fsl_ldb)
>> +{
>> +	return fsl_ldb_is_dual(fsl_ldb) ? 3500 : 7000;
>> +}
>> +
>>  static unsigned long fsl_ldb_link_frequency(struct fsl_ldb *fsl_ldb, 
>> int clock)
>>  {
>> -	if (fsl_ldb_is_dual(fsl_ldb))
>> -		return clock * 3500;
>> -	else
>> -		return clock * 7000;
>> +	return clock * fsl_ldb_link_freq_factor(fsl_ldb);
>>  }
>> 
>>  static int fsl_ldb_attach(struct drm_bridge *bridge,
>> @@ -121,6 +123,35 @@ static int fsl_ldb_attach(struct drm_bridge 
>> *bridge,
>>  				 bridge, flags);
>>  }
>> 
>> +static bool fsl_ldb_mode_fixup(struct drm_bridge *bridge,
>> +				const struct drm_display_mode *mode,
>> +				struct drm_display_mode *adjusted_mode)
>> +{
>> +	const struct fsl_ldb *fsl_ldb = to_fsl_ldb(bridge);
> 
> Why const?
> If no const, then ...
> 
>> +	unsigned long requested_link_freq =
>> +		mode->clock * fsl_ldb_link_freq_factor(fsl_ldb);
> 
> ... this could be
>         unsigned long requested_link_freq =
> 
>                                 fsl_ldb_link_frequency(fsl_ldb, 
> mode->clock);

I used fsl_ldb_link_freq_factor(fsl_ldb) to point out the symmetry to 
recalculate
pclk = freq / fsl_ldb_link_freq_factor(fsl_ldb) below:

>> +	unsigned long freq = clk_round_rate(fsl_ldb->clk, 
>> requested_link_freq);
>> +
>> +	if (freq != requested_link_freq) {
>> +		/*
>> +		 * this will lead to flicker and incomplete lines on
>> +		 * the attached display, adjust the CRTC clock
>> +		 * accordingly.
>> +		 */
>> +		int pclk = freq / fsl_ldb_link_freq_factor(fsl_ldb);
> 
> I doubt that pixel clock tree cannot find appropriate division ratios
> for some pixel clock rates, especially for dual-link LVDS on i.MX8MP
> and i.MX93 platforms, because PLL clock rate should be 7x faster than
> pixel clock rate and 2x faster than "ldb" clock rate so that the 3.5
> folder between "ldb" clock and pixel clock can be met. That means the
> PLL clock rate needs to be explicitly set first for this case.
> 
> Can you assign the PLL clock rate in DT to satisfy the "ldb" and pixel
> clock rates like the below commit does, if you use a LVDS panel?
> 
> 4fbb73416b10 ("arm64: dts: imx8mp-phyboard-pollux: Set Video PLL1
> frequency to 506.8 MHz")

I probably could. The point of my patch is you don't have to know in
advance which LVDS panel is connected, and you don't have to calculate
the base PLL clock by hand and store it in the device tree.

In my test system, I have three different LVDS panels with EDID EEPROM,
none of which worked with the stock driver, but all work with this 
patch.
With slightly adapted pixel clocks though.

The driver already warns if LDB and PCLK don't match, because this is a
hardware constraint and violating this will lead to no image or image
distortion. With the patch the driver tries to fix that.

I don't know if it works for all or at least most panels, but for my 
panels
it does. And if the clocks match, by chance or by refconfiguring the PLL 
base
clock, the patch does nothing.

> 
>> +
>> +		if (adjusted_mode->clock != pclk) {
>> +			dev_warn(fsl_ldb->dev, "Adjusted pixel clk to match LDB clk (%d 
>> kHz -> %d kHz)!\n",
>> +				 adjusted_mode->clock, pclk);
>> +
>> +			adjusted_mode->clock = pclk;
>> +			adjusted_mode->crtc_clock = pclk;
>> +		}
>> +	}
>> +
>> +	return true;
>> +}
>> +
>>  static void fsl_ldb_atomic_enable(struct drm_bridge *bridge,
>>  				  struct drm_bridge_state *old_bridge_state)
>>  {
>> @@ -280,6 +311,7 @@ fsl_ldb_mode_valid(struct drm_bridge *bridge,
>> 
>>  static const struct drm_bridge_funcs funcs = {
>>  	.attach = fsl_ldb_attach,
>> +	.mode_fixup = fsl_ldb_mode_fixup,
>>  	.atomic_enable = fsl_ldb_atomic_enable,
>>  	.atomic_disable = fsl_ldb_atomic_disable,
>>  	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
> --
> Regards,
> Liu Ying

-- 
Nikolaus Voss

