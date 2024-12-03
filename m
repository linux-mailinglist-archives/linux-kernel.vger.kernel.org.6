Return-Path: <linux-kernel+bounces-428890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DB59E14AE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE711282867
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 07:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B20C199247;
	Tue,  3 Dec 2024 07:55:07 +0000 (UTC)
Received: from mail.steuer-voss.de (mail.steuer-voss.de [85.183.69.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8881BF37
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 07:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.183.69.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733212507; cv=none; b=AD9ecVTOYPpipkfnPomnutbudAQkEQPU7sReCOlClYpKj+ZeKyF4Sw6RLp3iwf4abH5zjfpAnOqQTKdo8L9R8ggXEjo3hoRE2E47rr+EsvVOFIujFAq6X26BrIOK00NnKABiqFAMOd2ZW3M1kZljYHw+9UlFjzAFIa4zWiSVMtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733212507; c=relaxed/simple;
	bh=7eRxcv3yXSJnVIkuc7bvZ5tQQ11d9ZfLKFjF8Vg/IH8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=RsMJ2dzaHqVbtI+jgrad0yFbFwusJuD9CiLTKWD3W3oz1eCPWTh4W/AwJJ+SPE7xmY1puABwbZ6GniyNTqT1k/7NBhXGiZ2WgBfI43xWAvYGsFX2aYNRWPt78OCnIdCXD/c6gMQL7fxrQsNgPXSgf8Uf2mrMFqxt/wagIbU2gyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vosn.de; spf=pass smtp.mailfrom=vosn.de; arc=none smtp.client-ip=85.183.69.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vosn.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vosn.de
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: from mail.steuer-voss.de (localhost [127.0.0.1])
	by mail.steuer-voss.de (Postfix) with ESMTP id 2727C338;
	Tue,  3 Dec 2024 08:54:58 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 03 Dec 2024 08:54:58 +0100
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
In-Reply-To: <2c950130-84b4-4a81-84a2-b5e08af43616@oss.nxp.com>
References: <20241126172610.AD8B51622C@mail.steuer-voss.de>
 <1f0a307a-666f-4647-9f73-e9bddd6c7eff@oss.nxp.com>
 <000b34cdd1591c82265ce1f9848828d1@vosn.de>
 <2c950130-84b4-4a81-84a2-b5e08af43616@oss.nxp.com>
User-Agent: Roundcube Webmail/1.5.0
Message-ID: <204150e1b99053f97a1a3e042d5e7cf9@vosn.de>
X-Sender: nv@vosn.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 03.12.2024 03:22, Liu Ying wrote:
> On 12/02/2024, Nikolaus Voss wrote:
>> [You don't often get email from nv@vosn.de. Learn why this is 
>> important at https://aka.ms/LearnAboutSenderIdentification ]
>> 
>> Hi Liu,
> 
> Hi,
> 
>> 
>> On 02.12.2024 07:32, Liu Ying wrote:
>>> On 11/27/2024, Nikolaus Voss wrote:
>>>> LDB clock has to be a fixed multiple of the pixel clock.
>>>> As LDB and pixel clock are derived from different clock sources
>>>> (at least on imx8mp), this constraint cannot be satisfied for
>>>> any pixel clock, which leads to flickering and incomplete
>>>> lines on the attached display.
>>>> 
>>>> To overcome this, check this condition in mode_fixup() and
>>>> adapt the pixel clock accordingly.
>>>> 
>>>> Cc: <stable@vger.kernel.org>
>>> 
>>> It looks like stable is not effectively Cc'ed.
>>> Need a Fixes tag?
>> 
>> I will include
>> Fixes: 463db5c2ed4a ("drm: bridge: ldb: Implement simple Freescale
>> i.MX8MP LDB bridge")
>> in v2.
>> 
>>> 
>>>> 
>>>> Signed-off-by: Nikolaus Voss <nv@vosn.de>
>>>> ---
>>>>  drivers/gpu/drm/bridge/fsl-ldb.c | 40
>>>> ++++++++++++++++++++++++++++----
>>>>  1 file changed, 36 insertions(+), 4 deletions(-)
>>>> 
>>>> diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c
>>>> b/drivers/gpu/drm/bridge/fsl-ldb.c
>>>> index 0e4bac7dd04ff..e341341b8c600 100644
>>>> --- a/drivers/gpu/drm/bridge/fsl-ldb.c
>>>> +++ b/drivers/gpu/drm/bridge/fsl-ldb.c
>>>> @@ -104,12 +104,14 @@ static inline struct fsl_ldb 
>>>> *to_fsl_ldb(struct
>>>> drm_bridge *bridge)
>>>>      return container_of(bridge, struct fsl_ldb, bridge);
>>>>  }
>>>> 
>>>> +static unsigned int fsl_ldb_link_freq_factor(const struct fsl_ldb
>>>> *fsl_ldb)
>>>> +{
>>>> +    return fsl_ldb_is_dual(fsl_ldb) ? 3500 : 7000;
>>>> +}
>>>> +
>>>>  static unsigned long fsl_ldb_link_frequency(struct fsl_ldb 
>>>> *fsl_ldb,
>>>> int clock)
>>>>  {
>>>> -    if (fsl_ldb_is_dual(fsl_ldb))
>>>> -            return clock * 3500;
>>>> -    else
>>>> -            return clock * 7000;
>>>> +    return clock * fsl_ldb_link_freq_factor(fsl_ldb);
>>>>  }
>>>> 
>>>>  static int fsl_ldb_attach(struct drm_bridge *bridge,
>>>> @@ -121,6 +123,35 @@ static int fsl_ldb_attach(struct drm_bridge
>>>> *bridge,
>>>>                               bridge, flags);
>>>>  }
>>>> 
>>>> +static bool fsl_ldb_mode_fixup(struct drm_bridge *bridge,
>>>> +                            const struct drm_display_mode *mode,
>>>> +                            struct drm_display_mode *adjusted_mode)
>>>> +{
>>>> +    const struct fsl_ldb *fsl_ldb = to_fsl_ldb(bridge);
>>> 
>>> Why const?
>>> If no const, then ...
>>> 
>>>> +    unsigned long requested_link_freq =
>>>> +            mode->clock * fsl_ldb_link_freq_factor(fsl_ldb);
>>> 
>>> ... this could be
>>>         unsigned long requested_link_freq =
>>> 
>>>                                 fsl_ldb_link_frequency(fsl_ldb,
>>> mode->clock);
>> 
>> I used fsl_ldb_link_freq_factor(fsl_ldb) to point out the symmetry to
>> recalculate
>> pclk = freq / fsl_ldb_link_freq_factor(fsl_ldb) below:
> 
> I would prefer to avoid this open coding of using
> fsl_ldb_link_freq_factor() than achieve some sort of symmetry.
> 
>> 
>>>> +    unsigned long freq = clk_round_rate(fsl_ldb->clk,
>>>> requested_link_freq);
>>>> +
>>>> +    if (freq != requested_link_freq) {
>>>> +            /*
>>>> +             * this will lead to flicker and incomplete lines on
>>>> +             * the attached display, adjust the CRTC clock
>>>> +             * accordingly.
>>>> +             */
>>>> +            int pclk = freq / fsl_ldb_link_freq_factor(fsl_ldb);
>>> 
>>> I doubt that pixel clock tree cannot find appropriate division ratios
>>> for some pixel clock rates, especially for dual-link LVDS on i.MX8MP
>>> and i.MX93 platforms, because PLL clock rate should be 7x faster than
>>> pixel clock rate and 2x faster than "ldb" clock rate so that the 3.5
>>> folder between "ldb" clock and pixel clock can be met. That means the
>>> PLL clock rate needs to be explicitly set first for this case.
>>> 
>>> Can you assign the PLL clock rate in DT to satisfy the "ldb" and 
>>> pixel
>>> clock rates like the below commit does, if you use a LVDS panel?
>>> 
>>> 4fbb73416b10 ("arm64: dts: imx8mp-phyboard-pollux: Set Video PLL1
>>> frequency to 506.8 MHz")
>> 
>> I probably could. The point of my patch is you don't have to know in
>> advance which LVDS panel is connected, and you don't have to calculate
>> the base PLL clock by hand and store it in the device tree.
>> 
>> In my test system, I have three different LVDS panels with EDID 
>> EEPROM,
>> none of which worked with the stock driver, but all work with this
>> patch.
>> With slightly adapted pixel clocks though.
> 
> If each of the three LVDS panels has only one display mode, you may
> assign the PLL clock rates in DT overlays for the panels.

Yes, but I would have to calculate the PLL clock by hand with knowledge
of the internal signal flow (at least the clock ratio ;-)).

> 
>> 
>> The driver already warns if LDB and PCLK don't match, because this is 
>> a
>> hardware constraint and violating this will lead to no image or image
>> distortion. With the patch the driver tries to fix that.
>> 
>> I don't know if it works for all or at least most panels, but for my
> 
> This patch is supposed to work for all panels and LVDS display bridges,
> but I don't think it does due to the problematic pixel clock rates I
> mentioned before.

To my understanding, the current driver works for nearly no panel, 
unless
you explicitly code the correct PLL freq into the device tree. The basic
problem is, that the driver does not _enforce_ the correct clock ratio
although the hardware strictly _requires_ it.

There are two options in enforcing the correct ratio: forcing the ldb 
clock
to the right rate, down to the clock source; this is Miquel's approach.
Or getting the nearest possible ldb clock with the current PLL freq and
modify the pixel clock accordingly, that's my approach.

Of course, never modifying the required pixel clock and still setting 
the
correct clock ratio is the golden solution. But in most cases, this is 
not
necessary as panels usually accept deviations from the ideal pixel clock
without any problems. What doesn't work is pixel and ldb clock not 
having
the correct ratio. And this is what the patch is about.

> 
>> panels
>> it does. And if the clocks match, by chance or by refconfiguring the 
>> PLL
>> base
>> clock, the patch does nothing.
>> 
>>> 
>>>> +
>>>> +            if (adjusted_mode->clock != pclk) {
>>>> +                    dev_warn(fsl_ldb->dev, "Adjusted pixel clk to 
>>>> match LDB clk (%d
>>>> kHz -> %d kHz)!\n",
>>>> +                             adjusted_mode->clock, pclk);
>>>> +
>>>> +                    adjusted_mode->clock = pclk;
>>>> +                    adjusted_mode->crtc_clock = pclk;
>>>> +            }
>>>> +    }
>>>> +
>>>> +    return true;
>>>> +}
>>>> +
>>>>  static void fsl_ldb_atomic_enable(struct drm_bridge *bridge,
>>>>                                struct drm_bridge_state 
>>>> *old_bridge_state)
>>>>  {
>>>> @@ -280,6 +311,7 @@ fsl_ldb_mode_valid(struct drm_bridge *bridge,
>>>> 
>>>>  static const struct drm_bridge_funcs funcs = {
>>>>      .attach = fsl_ldb_attach,
>>>> +    .mode_fixup = fsl_ldb_mode_fixup,
>>>>      .atomic_enable = fsl_ldb_atomic_enable,
>>>>      .atomic_disable = fsl_ldb_atomic_disable,
>>>>      .atomic_duplicate_state = 
>>>> drm_atomic_helper_bridge_duplicate_state,

-- 
Nikolaus Voss

