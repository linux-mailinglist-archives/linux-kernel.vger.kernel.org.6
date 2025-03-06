Return-Path: <linux-kernel+bounces-549477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CF1A55302
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73B9B1887F4F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EFA25A632;
	Thu,  6 Mar 2025 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rtJbS1ij"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B831FF7C4
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 17:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281970; cv=none; b=pLYOo+sP2BdcuG5mLz1mpGu7tbK1iKyVZfRR8x2HZGBKsgtuy3gZ4eXlLOAf8t/jQ/Yxa0Kqa/DUmyR/fZ6XU9NTxWA6fZgrruudf7J4lx1xFoZcW5/53ByFRpzTKcXNMHOqBbnxMx1H2rT5IzBy7jmYReRMN3ulKQa4gJkttug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281970; c=relaxed/simple;
	bh=xXfYB2PcBznFBcxQBHLNsgKgLFZe8o1fEUvFED2NRS8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ip+B1MUQa4qm2io2KZzeeJIHs+wprvI8P+NcdQtQxhYBOFanEZxcgjlSUW4vFj/nxlwE3HtB+2CXRFBLBQl/iRVhP8bD7BBKH3m/Z8e62JZ+Vs+cbSzHZ3GhVPxKgIMCZp2Op7ZlbMVBYF/JXIvlcW+QfEw3KFWlAYdx3mEEgn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rtJbS1ij; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-390eebcc331so641351f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 09:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741281964; x=1741886764; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9gBi13oH2YTOQlVLrmxAry8taY7YW2dmM3vhgwkXBio=;
        b=rtJbS1ij2BRG4Ibgu+2iinHQh/P5uVxm2H4/Q6WsrJwWK11b5Y4dOZCXOzLkoLC/NZ
         4JdJHmMphBEAFhMeVOtuv14bGEmjh+hxOMfnU9CLf37O9slx2xvjYTvjbi5atoVLDw30
         jFsJ+7Xdzf4nsMOYhmUnP3T4D0gotlwycUiQFOcA4nrjxxTc/2w+0wNcKJ4dSNa+3GXq
         wBhQy7w1zkNmcFZUnr7Cdh5Xi8WaFSUwFOFTC74R0mp7tXfyZ6JdjwbNO9TZK/bQSPns
         9Oci3vRTAOAs2XdJJuk5ijkA6u8UBICQtas51VCD63PB74WUXQBQtnLE1Eojr2X0D/lV
         Ewbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741281964; x=1741886764;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gBi13oH2YTOQlVLrmxAry8taY7YW2dmM3vhgwkXBio=;
        b=OOdaYz8aiiBQUK4WIN74AN3NfChOTChNjX4WFZkUEUeBAWwZxsDwZRw/bgkE9zyuwC
         os7d55LZ0kBWPCz6y3hu2AXtrcOUrGa5DXujsp5ntIlXL1+aXZWqaHjGvhXdrKq8EPuj
         Snxq+Y/M8qlIGWdGMYi1ucGxrktmisbJpaiqH57PvMShtMtHyEUKfG3HVXfvSYj4JftS
         y2X10rXZiKiNrg2iMW2ld/O/KVcRt5QcWCM6or5a8xA/FO9WJfVqVLqQ5erGuMubIW7J
         tzRs54Kp3ht1ly2Xphx688zZ+a6Z2giFiwCKIrNBDNoL9ekZ7yzSr/4WG+mpXhRyQVY6
         QoZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUATDjUkYomB7CehMyAUPFwSWiYAfaO8kdfCkb3hmR+Z3e3dqSRfPJsFCS4ZuJo9DKpjd8i0e9tMdnqLgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW6UQzFKoUTRpng4Da2kNFTjqPPl1RNNMSONOw/+5DojSg2VZw
	dcDtYLNAFxILDkOxbOzk09/NS0w+31QvAE+1mF008KxspTAgRlKFaHGzA7GnnsQ=
X-Gm-Gg: ASbGncs0fNBsBkAFx9i1VCljqOKLm+PEnBSsSpOEOKUnZgP6unoxM6IkylvaoTNJDjk
	k8FIC8DpnmKEh/Kb5hJL2en0d7fo6G94LEcThFOz7hEuOOnFqnkjtm3QQe2FE5jujGrhy7uXOiJ
	R7fx54MMHWbfVvAtDSUvbv00LFtLmnU7dzkTBXUkkswMTTIh/no4TV2YTWBre4EismQsVp+4g1Z
	ycOGH/b/DN0zOp/CVAiWUGr/UC5eYUE3gQgP+W9JmMd1gxOwDeD45fPlmr7u4zVThbWUsImkMga
	H+RRSNBgLpq2ha77ubQ3jFZyZ/vqzGzhC5B9hfNHBr0=
X-Google-Smtp-Source: AGHT+IHDAt6NYWgVgdYHY+auIYwz15KHwMO0sECwAzb9Y48d4oIdn6zdb/5QFSFzH4BHnl8HwsC49Q==
X-Received: by 2002:a5d:5985:0:b0:391:865:5a93 with SMTP id ffacd0b85a97d-3913211b64fmr247337f8f.22.1741281964164;
        Thu, 06 Mar 2025 09:26:04 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:29d4:36d9:5043:acd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912c0e4065sm2703591f8f.62.2025.03.06.09.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 09:26:03 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: <linux@martijnvandeventer.nl>
Cc: "'Neil Armstrong'" <neil.armstrong@linaro.org>,  "'Michael Turquette'"
 <mturquette@baylibre.com>,  "'Stephen Boyd'" <sboyd@kernel.org>,  "'Kevin
 Hilman'" <khilman@baylibre.com>,  "'Martin Blumenstingl'"
 <martin.blumenstingl@googlemail.com>,
  <linux-amlogic@lists.infradead.org>,  <linux-clk@vger.kernel.org>,
  <linux-arm-kernel@lists.infradead.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: meson: g12a: Fix kernel warnings when no display
 attached
In-Reply-To: <004801db8eb7$99808e20$cc81aa60$@martijnvandeventer.nl>
	(linux@martijnvandeventer.nl's message of "Thu, 6 Mar 2025 17:48:33
	+0100")
References: <20250213221702.606-1-linux@martijnvandeventer.nl>
	<1jpljkzyf0.fsf@starbuckisacylon.baylibre.com>
	<003301db888e$8ea84e90$abf8ebb0$@martijnvandeventer.nl>
	<1jplj3g21q.fsf@starbuckisacylon.baylibre.com>
	<004801db8eb7$99808e20$cc81aa60$@martijnvandeventer.nl>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 06 Mar 2025 18:26:03 +0100
Message-ID: <1j4j065avo.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu 06 Mar 2025 at 17:48, <linux@martijnvandeventer.nl> wrote:

> Hi Jerome,
>
>> >
>> > Thank you for reviewing, and apologies for my late response due to a
>> holiday.
>> >
>> >> On Thu 13 Feb 2025 at 23:17, Martijn van Deventer
>> >> <linux@martijnvandeventer.nl> wrote:
>> >>
>> >> > When booting SM1 or G12A boards without a dislay attached to HDMI,
>> >> > the kernel shows the following warning:
>> >> >
>> >> > [CRTC:46:meson_crtc] vblank wait timed out
>> >> > WARNING: CPU: 2 PID: 265 at
>> drivers/gpu/drm/drm_atomic_helper.c:1682
>> >> drm_atomic_helper_wait_for_vblanks.part.0+0x240/0x264
>> >> > CPU: 2 UID: 0 PID: 265 Comm: setfont Tainted: G         C
>> >> > Tainted: [C]=CRAP
>> >> > pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> >> > pc : drm_atomic_helper_wait_for_vblanks.part.0+0x240/0x264
>> >> > lr : drm_atomic_helper_wait_for_vblanks.part.0+0x240/0x264
>> >> > Call trace:
>> >> >  drm_atomic_helper_wait_for_vblanks.part.0+0x240/0x264
>> >> >  drm_atomic_helper_commit_tail_rpm+0x84/0xa0
>> >> >  commit_tail+0xa4/0x18c
>> >> >  drm_atomic_helper_commit+0x164/0x178
>> >> >  drm_atomic_commit+0xb4/0xec
>> >> >  drm_client_modeset_commit_atomic+0x210/0x270
>> >> >  drm_client_modeset_commit_locked+0x5c/0x188
>> >> >  drm_fb_helper_pan_display+0xb8/0x1d4
>> >> >  fb_pan_display+0x7c/0x120
>> >> >  bit_update_start+0x20/0x48
>> >> >  fbcon_switch+0x418/0x54c
>> >> >  el0t_64_sync+0x194/0x198
>> >> >
>> >> > This happens when the kernel disables the unused clocks.
>> >> > Sometimes this causes the boot to hang.
>> >> >
>> >> > By (re)adding the flag CLK_IGNORE_UNUSED to the VCLK2 clocks, these
>> >> > clocks will not be disabled.
>> >> >
>> >> > This partially reverts commit b70cb1a21a54 ("clk: meson: g12a:
>> >> > make VCLK2 and ENCL clock path configurable by CCF").
>> >>
>> >> It looks like DRM needs those clock enabled regardless of connection
>> >> status on HDMI. Even with this change applied, you would get the same
>> >> problem again if the bootloader does not take of turning the clock on,
>> >> which is not a given.
>> >>
>> >> CLK_IGNORE_UNUSED gives not guarantee a clock will be enabled or stay
>> >> enabled at any point.
>> >>
>> >> A proper fix to this issue should be done in DRM, IMO.
>> >
>> > I know and I totally agree. Unfortunately, I don't have access to any 
>> > vendor
>> > documentation, nor do I have any real knowledge about the DRM/HDMI
>> > subsystem to fix that.
>>
>> You have identified which clocks are not properly claimed, by what they
>> are not claimed and even when. 50% of the job is done. Thanks for this.
>
> You're welcome, no problem.
>
>> >
>> > And I guess if it were as easy as adding a clock to the DT and calling
>> > clk_prepare_enable on it in the probe function, Neil would have done
>> that
>> > already.
>> >
>> > So, all I can do, for now, is revert to the previous situation when it 
>> > did
>> work
>> > for (probably) most boards.
>>
>> Maybe so, but it does not make this change appropriate. The problem
>> is the DRM driver which does not enable what it needs to properly
>> operate. This should be fixed.
>
> I understand. So I guess that is the end of the line for this patch.
> Because this patch will not be accepted and if someone else finds the 
> time and has the knowledge to fix this the proper way, it will be a 
> completely different patch.
>
> Although I, of course, agree with you that it should be fixed properly, 
> I find it a bit difficult to accept that if we accidentally break something,
> while trying to make things better, we are not allowed to revert it 
> because it was already somewhat broken. Resulting in a more broken
> situation than before...

Once again, you are encouraged to fix things up ... where fixes are needed.

DRM is hardly immutable. If you don't feel like you can do it on your own,
you can still engage with the other contributors who may know this
better and help you.

>
> On the other hand, I also understand that if you, as a maintainer, allow 
> that, chances are it will never see a proper fix. :-)
>
> Cheers!
>
>> >
>> >> >
>> >> > Fixes: b70cb1a21a54 ("clk: meson: g12a: make VCLK2 and ENCL clock
>> path
>> >> configurable by CCF").
>> >> > Signed-off-by: Martijn van Deventer <linux@martijnvandeventer.nl>
>> >> > ---
>> >> >  drivers/clk/meson/g12a.c | 12 ++++++------
>> >> >  1 file changed, 6 insertions(+), 6 deletions(-)
>> >> >
>> >> > diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
>> >> > index cfffd434e998..1651898658f5 100644
>> >> > --- a/drivers/clk/meson/g12a.c
>> >> > +++ b/drivers/clk/meson/g12a.c
>> >> > @@ -3234,7 +3234,7 @@ static struct clk_regmap g12a_vclk2_div = {

-- 
Jerome

