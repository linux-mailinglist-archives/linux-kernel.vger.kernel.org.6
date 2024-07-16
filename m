Return-Path: <linux-kernel+bounces-253834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308BD93279E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC66283693
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7D119ADB1;
	Tue, 16 Jul 2024 13:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="dPTUN2in"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65771199EA8
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721137074; cv=none; b=F78VJeIgooDyqlE8Gs+nZi/eXOBET9pZdxqnm/95ijT/dwgboW8rfajoZcvTJks1kLsPyiQLlb6/HgwkApf6FsD1WkgDFcBkkh/rOvKljkr0Ie8Cr4fu2tBKU/1IT8k8hKbxLJ2yLxA1Wx8MkQ+FypRQEqGd5IRkaaeTrik8w/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721137074; c=relaxed/simple;
	bh=bHCqDkoD3Nfw+v/tmBe2MHQcIm42tiz5H4CisXJcl64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flYGsKlxYMw8dDLFzr6u1pU2zFrccY3NCHzJIZNupfhdFGKT1qW4EONg6rWLXeWs9XYbM5WYOczM96e8KAu3w7kw15UsNV7c94j+syPmjD/+gDhdrAHF3mxeMe/ztD9py7+0LY5x50glj9vDGMLh0Wut2uhM/oFmF1jFti8VUCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=dPTUN2in; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a77b60cafecso650230066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 06:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1721137071; x=1721741871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=01CGZeuJlS/iVbJO+uEwAdD1+WG7mqLJ/um4UuZ/sVI=;
        b=dPTUN2inNRGEeREUizkgFjLkgOVuGwBUPZaLRmKfwOs7fSbYVlyeJZsdv1ZzfLfs3R
         rmaQyrZPheuo3buo2B7GQxcSJXqzJgRUHrQvdeMM0mPEvS8Dyp2jE/xB6Hi8US6yFxMV
         ITiyNMKKGLZncRy7v/i23Axtr2GeFw/Ac/swTAirkma7VZVwFk/8+Pj7/0FCAaO320Kr
         MsBySNVs1vVvnr2qTVkXXeGIaGfhlGZUT3v8HqQ34UqdlyqL4/0yuuS77E6j4SN4yY/i
         V3bEpBNZ6XMKKFK8H045hr16InSUwI5Hh0YHKarPnAjECIbm2H++bKWfC10KACwuO/oE
         ZFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721137071; x=1721741871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01CGZeuJlS/iVbJO+uEwAdD1+WG7mqLJ/um4UuZ/sVI=;
        b=UrLMDomnSQJh7e/OgI12o2bxrSCZ1n7FRkz5jjHvlO0NaWtLPA1ZSj0yA8CY6cCoMR
         aSSZIk+NQKl+uNlCWm9FA/WMOWWnmP9k2aL5ujh75OpWBqk2LZuff8z8tAa2HaCgUKOu
         QAs+1Lceyuf9wOu3Fzr+aS7VdM1fMyLGbMsHlkmCSz4ZTnlwmg1q2Mi5VA1KfQzWyecB
         EAx3SdHZ8RNqF+d3gWMDfjS0lqeauHCUn9JNz1E0eiCQ/s7kO7YfF/TfBBjtye6Sv4yz
         QwF/lsW1lOaL4aRMJ0Uk12G9rSAQnKITNX6CWnpMSbuWuE4SZf156Pz02h8wqZAbkmvv
         tgSA==
X-Forwarded-Encrypted: i=1; AJvYcCXA38MJt9SyEUCnLBdUr42z/Z/jwD82GcWQGnjPsEGrAFkrt4GASl4XHuQp5e+Tu8t5r6w7aa7w5PcdRdIy0vsNckfFzLKf1pWxTapq
X-Gm-Message-State: AOJu0Yzzl0PAUk25RqnFzpSvEEFhYkDp4QVC3d/SKN6BKEs50z9c7HhU
	kAXCp1/avS9Tk24RfUAxlA+CNYfefluJXEwNNg9bHcC3LHI9JhGtXtyJwHTqtFQ=
X-Google-Smtp-Source: AGHT+IEEE4wIR/+qdr26oglrqdbNNCgxVgcYqpZavGvpIAmwKKRDSm/ei3CP4AVu06EkKXR2f1SbxA==
X-Received: by 2002:a17:906:f9d5:b0:a77:e71e:ff8d with SMTP id a640c23a62f3a-a79eaa5ec64mr118347266b.70.1721137040713;
        Tue, 16 Jul 2024 06:37:20 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7f1e42sm317447866b.101.2024.07.16.06.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 06:37:20 -0700 (PDT)
Date: Tue, 16 Jul 2024 15:37:16 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	andrew@lunn.ch, horms@kernel.org, hkallweit1@gmail.com,
	richardcochran@gmail.com, rdunlap@infradead.org,
	linux@armlinux.org.uk, bryan.whitehead@microchip.com,
	edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next V2 0/4] Add support to PHYLINK for
 LAN743x/PCI11x1x chips
Message-ID: <ZpZ3jOmJo_mr48K9@nanopsycho.orion>
References: <20240716113349.25527-1-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716113349.25527-1-Raju.Lakkaraju@microchip.com>

Tue, Jul 16, 2024 at 01:33:45PM CEST, Raju.Lakkaraju@microchip.com wrote:
>This is the follow-up patch series of
>https://lkml.iu.edu/hypermail/linux/kernel/2310.2/02078.html
>
>Divide the PHYLINK adaptation and SFP modifications into two separate patch
>series.
>
>The current patch series focuses on transitioning the LAN743x driver's PHY
>support from phylib to phylink.
>
>Tested on chip PCI11010 Rev-B with Bridgeport Evaluation board Rev-1
>
>Change List:
>============
>V1 ->V2:
>  - Fix the Russell King's comments i.e. remove the speed, duplex update in 
>    lan743x_phylink_mac_config( )
>  - pre-March 2020 legacy support has been removed
>
>V0 -> V1:
>  - Integrate with Synopsys DesignWare XPCS drivers
>  - Based on external review comments,
>  - Changes made to SGMII interface support only 1G/100M/10M bps speed
>  - Changes made to 2500Base-X interface support only 2.5Gbps speed
>  - Add check for not is_sgmii_en with is_sfp_support_en support
>  - Change the "pci11x1x_strap_get_status" function return type from void to
>    int
>  - Add ethtool phylink wol, eee, pause get/set functions

Net-next is closed. Please repost once it opens again.


>
>
>Raju Lakkaraju (4):
>  net: lan743x: Create separate PCS power reset function
>  net: lan743x: Create separate Link Speed Duplex state function
>  net: lan743x: Migrate phylib to phylink
>  net: lan743x: Add support to ethtool phylink get and set settings
>
> drivers/net/ethernet/microchip/Kconfig        |   5 +-
> .../net/ethernet/microchip/lan743x_ethtool.c  | 118 +---
> drivers/net/ethernet/microchip/lan743x_main.c | 657 +++++++++++-------
> drivers/net/ethernet/microchip/lan743x_main.h |   7 +
> 4 files changed, 460 insertions(+), 327 deletions(-)
>
>-- 
>2.34.1
>
>

