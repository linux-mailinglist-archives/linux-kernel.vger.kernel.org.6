Return-Path: <linux-kernel+bounces-225160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FD6912CEA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051911F24614
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEF51791EB;
	Fri, 21 Jun 2024 18:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JD1fpuHM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E20D1607A4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718993091; cv=none; b=Lc3KxN3Ah5HxCkTxgNnwtOVcrwstJ08u6DkhKxfP2WWz5fgUcvzx892j5rQ4BStpfOVM6A8Wk5dK3pqOxGtNSPPDcjVkob9kDMbjVxAY0R9zZfku+VDNOzyvswvgdush/G11Hhl2gnC0H5lFvSEZussHOFaVuKmTle2lLfHTSfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718993091; c=relaxed/simple;
	bh=zcg7PMw2+sFn9Qhk21DKHJTKPGv7tCKSJiQaWBwhaWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPYbFVkxU2VXH+CzYjx3iB7c3bIQggDArLnHkrmw1TLIRSnIQVIBXuCn/tTBP51Hki9g+0bAdYQSqHDPz2jf4H/eKkyknNG3Q6MmDq0ZQ4DctmVeVrswaWd6hkn7HcwrnlqcTt47NOg0E3U3VdFMz6BaH/sGvtZfsvD6C2Dw76Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JD1fpuHM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718993088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V8nqRTAoVGOXxJJfyF4qzkCCRC+CK1bQkjWb0hfNjRc=;
	b=JD1fpuHMDZVhxsH63iBIWdCzao/hms3/ETjnGCkCKxOEe4ijBSFt83rb8jHsXZWo/Xrn/Q
	YUjbO5gYw3ssnyN404NCKZwj2u/93RCLCA0k2STsCpU2xYkSJrmNlT081w+UyC52+aI4OC
	buP1a0twQMWp4ksYsosUGFIVsELtrt0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-fVtvwKrNO7GmA8KSW9tmGw-1; Fri, 21 Jun 2024 14:04:47 -0400
X-MC-Unique: fVtvwKrNO7GmA8KSW9tmGw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-43fb02db6d2so26273181cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 11:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718993086; x=1719597886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8nqRTAoVGOXxJJfyF4qzkCCRC+CK1bQkjWb0hfNjRc=;
        b=eeVtdULMDrt7nIBmxhuN7Mimn9HXTqkyzxPye/tQgh2vERKgHWMI66i/rwk/ej8L3D
         MTMGekDJ5QzmMg9BuaYToszSp88hgZe5x4ZVlut5NN3QLbrfGz6lxYGfYfNSp5IrVmYZ
         ZMyFx50HsJg6AHAGJch4QuAnmFshntyN9wjUhLiOSLTdlxCw2hSr4Nl2LDMrgXpKxSCU
         tu4GuMu6eKf4ayfUXs7jP6Vv15tMFvrsXjKKbsrgO0m58WkDogpz97yh0rOOkzcuqjtk
         87sELFtEyK47LI5SuCPowaRgdKwFJ2UJgtiCxpao89wji73PUxXLUm3RSj5/v8kns7+J
         chSA==
X-Forwarded-Encrypted: i=1; AJvYcCXMBAQ5DZqAv/lRfSxgYE29FU/QcNuRQOaav8hg4F0PuF9L959ynTUULQn4AJQLTwm7fYdRmszXladgz4ri0tfIvdR67uf40U4oDfmP
X-Gm-Message-State: AOJu0YwHoGfup7nJGYR+Rd98lP+Uo5pPsBAr47isPaL1Lwgf9bckQDqw
	88AFL+z6LFJGmL1iq0MqXsf7oBbo817O1RFDlbiHiXG240IkW4vhixjaUugr99B9QKZA1TAr6eX
	KLpyYvrguvSoQQ+5Z/O3YDK/N2frlvTLCgWYSLpN/cxEXAWObLE9WI9OZUGrTEQ==
X-Received: by 2002:a05:622a:1342:b0:43e:3d8b:b6b9 with SMTP id d75a77b69052e-444a7a4635fmr92854881cf.44.1718993086469;
        Fri, 21 Jun 2024 11:04:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJYcrTfuWlubeaxHUWAGUC9XfxejCL0fcoKM+mxJ0zr+uD9bnM2UGYpm8YYp2RVsBQQrd1GA==
X-Received: by 2002:a05:622a:1342:b0:43e:3d8b:b6b9 with SMTP id d75a77b69052e-444a7a4635fmr92854511cf.44.1718993085894;
        Fri, 21 Jun 2024 11:04:45 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::13])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c2c5ea11sm13380121cf.81.2024.06.21.11.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 11:04:45 -0700 (PDT)
Date: Fri, 21 Jun 2024 13:04:43 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Vinod Koul <vkoul@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH net-next 1/8] net: phy: add support for overclocked SGMII
Message-ID: <osdpdpp44qkfx3varu4iulec3d3azwj7y7rccma7yopui3d7da@2km3uhan7umg>
References: <20240619184550.34524-1-brgl@bgdev.pl>
 <20240619184550.34524-2-brgl@bgdev.pl>
 <bedd74cb-ee1e-4f8d-86ee-021e5964f6e5@lunn.ch>
 <CAMRc=MeCcrvid=+KG-6Pe5_-u21PBJDdNCChVrib8zT+FUfPJw@mail.gmail.com>
 <160b9abd-3972-449d-906d-71d12b2a0aeb@lunn.ch>
 <ZnNIib8GEpvAOlGd@shell.armlinux.org.uk>
 <4ts2ab5vwf7gnwqd557z62ozjdbl3kf7d64qfc6rjhuokav3th@brhzlsrpggk6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ts2ab5vwf7gnwqd557z62ozjdbl3kf7d64qfc6rjhuokav3th@brhzlsrpggk6>

On Thu, Jun 20, 2024 at 02:42:41PM GMT, Andrew Halaney wrote:
> On Wed, Jun 19, 2024 at 10:07:21PM GMT, Russell King (Oracle) wrote:
> > On Wed, Jun 19, 2024 at 09:51:12PM +0200, Andrew Lunn wrote:
> > > phylib supports out of band signalling, which is enough to make this
> > > work, so long as two peers will actually establish a link because they
> > > are sufficiently tolerant of what the other end is doing. Sometimes
> > > they need a hint. Russell King has been working on this mess, and i'm
> > > sure he will be along soon.
> > 
> > ... and I'm rolling my eyes, wondering whether I will get time to
> > finish the code that I started any time soon. I'll note that the more
> > hacky code we end up merging, the harder it will become to solve this
> > problem (and we already have several differing behaviours merged with
> > 2500base-X already.)
> > 
> > > What i expect will happen is you keep calling this 2500BaseX, without
> > > in band signalling. You can look back in the netdev mailling list for
> > > more details and those that have been here before you. It is always
> > > good to search the history, otherwise you are just going to repeat it.
> > 
> > That's where things start getting sticky, because at the moment,
> > phylink expects 2500base-X to be like 1000base-X, and be a media
> > interface mode rather than a MAC-to-PHY interface mode. This is partly
> > what my patches will address if I can get around to finishing them -
> > but at this point I really do not know when that will be.
> > 
> > I still have the high priority work problem that I'm actively involved
> > with. I may have three weeks holiday at the start of July (and I really
> > need it right now!) Then, there's possibly quite a lot of down time in
> > August because I'm having early cataract ops which will substantially
> > change my eye sight. There's two possible outcomes from that. The best
> > case is that in just over two weeks after the first op, I'll be able to
> > read the screen without glasses. The worst case is that I have to wait
> > a further two to three weeks to see my optometrist (assuming he has
> > availability), and then wait for replacement lenses to be made up,
> > fitted and the new glasses sent.
> > 
> > So, I'm only finding the occasional time to be able to look at
> > mainline stuff, and I don't see that changing very much until maybe
> > September.
> > 
> > At this point, I think we may as well give up and let people do
> > whatever they want to do with 2500base-X (which is basically what we're
> > already doing), and when they have compatibility problems... well...
> > really not much we can do about that, and it will be way too late to
> > try and sort the mess out.
> 
> I hope your holiday and operation go well Russell.
> 
> Pardon my ignorance, but I know of quite a few things you have in flight
> and because of that I'm not entirely sure what specific patches you're
> referring to above. Have those hit the list? I know you're cleaning
> up stmmac's phylink/pcs usage, but I'm thinking that this is outside of
> that series. Thanks in advance for helping me understand all that's in
> progress around this mess of a topic!

Nevermind my question, I was talking a little about this today with respect to a
Renesas board as well (can't escape it it seems) and in going through
our convos I found: https://lore.kernel.org/netdev/ZlNi11AsdDpKM6AM@shell.armlinux.org.uk/

    """
    I do have some work-in-progress patches that attempt to sort this out
    in phylink and identify incompatible situations.

    See http://git.armlinux.org.uk/cgit/linux-arm.git/log/?h=net-queue

    commits (I think)...

    net: phylink: clean up phylink_resolve()

    to:

    net: phylink: switch to MLO_AN_PHY when PCS uses outband

    and since I'm converting stmmac's hacky PCS that bypasses phylink to
    a real phylink_pcs, the ethqos code as it stands presents a blocker
    because of this issue. So, I'm intending to post a series in the next
    few days (after the bank holiday) and will definitely need to be
    tested on ethqos hardware.
    """

Thanks,
Andrew


