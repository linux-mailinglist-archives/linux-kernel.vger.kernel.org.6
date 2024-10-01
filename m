Return-Path: <linux-kernel+bounces-346566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 831DC98C5F8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17A461F23BDB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BCB1CCB41;
	Tue,  1 Oct 2024 19:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RL1krRq/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088F81CC152
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 19:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727810552; cv=none; b=N0kZ0nPySfSjjlpS/ww2E9TrrTz9PdXASQ4pV8IbKV8UAOZAB6T4CwjXD/o0i8qVJgEeZe4X0uRLN8HtR5udg0yVlxyoDXtyucYlamHhtfkR0uQjpK18/dKDA0IHHBQbXk2kix8dNnHmeCGvJiq2fytTZVt6n+FVMii4RpPFShQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727810552; c=relaxed/simple;
	bh=ygO/N17hku03zHkLD9a3YOJfQxxMRBZZVT5wtQHGzc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yj4QBj+byHfNmGtUdgc9Z6VE1pxZoUxH1Q/OeVin9aIgMgvzUYTu3XC0KK0k9yISEdova0Rc36oq5fVGGGDp59VLGnlazMePzvLYwihygzA/ppOHo/pp99NK76TfFrW0smlfCkPj/03GVtzcg3+WRt3YimLKGaE16/1C5V7RG+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RL1krRq/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727810550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XlRPm4OUSoltEzTDQbJSpZiwElY5sIlU1Xg9/yWTEWY=;
	b=RL1krRq/LDJPumYqZS3GvnPl9pcZ/XJwsWIKLKLGlWNmkkgy08OvQ97s9qksqbffSzSq1C
	fozCj6mWlNvNcJVrKAbbxZ8/eMeHYy/S8B+HBrZyuIB3tL+6nUWykGGs2kTcXOE5p8n7Fa
	Gpl7Wa1X0Rd9ktei7N4dJvSaJcngb/Q=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-6Cqk-rMBNh6R7HnaRE-vEw-1; Tue, 01 Oct 2024 15:22:28 -0400
X-MC-Unique: 6Cqk-rMBNh6R7HnaRE-vEw-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-718e82769aeso9911195b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 12:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727810547; x=1728415347;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XlRPm4OUSoltEzTDQbJSpZiwElY5sIlU1Xg9/yWTEWY=;
        b=R0Is5hHpQTZq4I6UMeuDG1fizWgez7uLkIKboLCZJvScjbtuyDxts848bLCIbm5U9F
         tE7tQKaL+Ifksxzbjiim0qubQbBEPG7hqydYaTbQgqEju5rO/PxpYI0IlV4DFTOvpg+K
         kNjY48lAP4a6cEblBICtmZH9iL5/dgkYcs2a22eJhjpMHCAXeBMzo6+qPGBoZNMa1CUO
         4PsckeRegsox2B7xX1bAwiusbRtV9wGsnT6+gxD3OqgyPIdWxAerjyw2luxWChqNeYbR
         huIvtL+Tly9tyEssBTHw50laYy3mZZ6aHjFu3o58jgLNU603LLPBfJmdtI+VMmNNn9bN
         d7ww==
X-Forwarded-Encrypted: i=1; AJvYcCXR3PKd5vVcHXpkVClDtGbX3P6iDVYGfR1p28cLfIWM7J8YmQBs545pU2tyLdQx4QoHuiwNA7EvggrytQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5S/LuXJHqx45KtuKX11liehPZM8x5tCVQjqsKO6bkgLIMjDhG
	gz79HHZnCikMPoCjjziVEAiGAEhx3SRRHWrsxf2fUpkl0RgQqmlQK3aJcC6Oh5wtnasum/WtcAm
	+GeAah1QBYt4sw/t51j9q1okZQGbUFaGqLf7y2oqs7EqZQTgufM/cX7750ey0j8TcU/OCDw==
X-Received: by 2002:a05:6a00:2ea2:b0:710:4d3a:2d92 with SMTP id d2e1a72fcca58-71dc5c48a91mr1128743b3a.4.1727810547515;
        Tue, 01 Oct 2024 12:22:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsZd1BREA/2fKG0znEmZMrSj8OvZ1kqc1zxUu7AL1wc6B/TClo2jbel2dc5gxbp0pqggAuJQ==
X-Received: by 2002:a05:6a00:2ea2:b0:710:4d3a:2d92 with SMTP id d2e1a72fcca58-71dc5c48a91mr1128717b3a.4.1727810547164;
        Tue, 01 Oct 2024 12:22:27 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26498b26sm8401971b3a.9.2024.10.01.12.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 12:22:26 -0700 (PDT)
Date: Tue, 1 Oct 2024 14:22:23 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Rob Herring <robh@kernel.org>, 
	"Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
	Abhishek Chauhan <quic_abchauha@quicinc.com>, Serge Semin <fancer.lancer@gmail.com>, 
	devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFT] of: property: fw_devlink: Add support for the
 "phy-handle" binding
Message-ID: <rqn4kaogp2oukghm3hz7sbbvayj6aiflgbtoyk6mhxg4jss7ig@iv24my4iheij>
References: <20240930-phy-handle-fw-devlink-v1-1-4ea46acfcc12@redhat.com>
 <CAGETcx-z+Evd95QzhPePOf3=fZ7QUpWC2spA=q_ASyAfVHJD1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx-z+Evd95QzhPePOf3=fZ7QUpWC2spA=q_ASyAfVHJD1A@mail.gmail.com>

On Mon, Sep 30, 2024 at 05:12:42PM GMT, Saravana Kannan wrote:
> On Mon, Sep 30, 2024 at 2:28 PM Andrew Halaney <ahalaney@redhat.com> wrote:
> >
> > Add support for parsing the phy-handle binding so that fw_devlink can
> > enforce the dependency. This prevents MACs (that use this binding to
> > claim they're using the corresponding phy) from probing prior to the
> > phy, unless the phy is a child of the MAC (which results in a
> > dependency cycle) or similar.
> >
> > For some motivation, imagine a device topology like so:
> >
> >     &ethernet0 {
> >             phy-mode = "sgmii";
> >             phy-handle = <&sgmii_phy0>;
> >
> >             mdio {
> >                     compatible = "snps,dwmac-mdio";
> >                     sgmii_phy0: phy@8 {
> >                             compatible = "ethernet-phy-id0141.0dd4";
> >                             reg = <0x8>;
> >                             device_type = "ethernet-phy";
> >                     };
> >
> >                     sgmii_phy1: phy@a {
> >                             compatible = "ethernet-phy-id0141.0dd4";
> >                             reg = <0xa>;
> >                             device_type = "ethernet-phy";
> >                     };
> >             };
> >     };
> >
> >     &ethernet1 {
> >             phy-mode = "sgmii";
> >             phy-handle = <&sgmii_phy1>;
> >     };
> >
> > Here ethernet1 depends on sgmii_phy1 to function properly. In the below
> > link an issue is reported where ethernet1 is probed and used prior to
> > sgmii_phy1, resulting in a failure to get things working for ethernet1.
> > With this change in place ethernet1 doesn't probe until sgmii_phy1 is
> > ready, resulting in ethernet1 functioning properly.
> >
> > ethernet0 consumes sgmii_phy0, but this dependency isn't enforced
> > via the device_links backing fw_devlink since ethernet0 is the parent of
> > sgmii_phy0. Here's a log showing that in action:
> >
> >     [    7.000432] qcom-ethqos 23040000.ethernet: Fixed dependency cycle(s) with /soc@0/ethernet@23040000/mdio/phy@8
> >
> > With this change in place ethernet1's dependency is properly described,
> > and it doesn't probe prior to sgmii_phy1 being available.
> >
> > Link: https://lore.kernel.org/netdev/7723d4l2kqgrez3yfauvp2ueu6awbizkrq4otqpsqpytzp45q2@rju2nxmqu4ew/
> > Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> > ---
> > I've marked this as an RFT because when looking through old mailing
> > list discusssions and kernel tech talks on this subject, I was unable
> > to really understand why in the past phy-handle had been left out. There
> > were some loose references to circular dependencies (which seem more or
> > less handled by fw_devlink to me), and the fact that a lot of behavior
> > happens in ndo_open() (but I couldn't quite grok the concern there).
> >
> > I'd appreciate more testing by others and some feedback from those who
> > know this a bit better to indicate whether fw_devlink is ready to handle
> > this or not.
> >
> > At least in my narrow point of view, it's working well for me.
> 
> I do want this to land and I'm fairly certain it'll break something.
> But it's been so long that I don't remember what it was. I think it
> has to do with the generic phy driver not working well with fw_devlink
> because it doesn't go through the device driver model.

Let me see if I can hack something up on this board (which has a decent
dependency tree for testing this stuff) to use the generic phy driver
instead of the marvell one that it needs and see how that goes. It won't
*actually* work from a phy perspective, but it will at least test out
the driver core bits here I think.

> 
> But like you said, it's been a while and fw_devlink has improved since
> then (I think). So please go ahead and give this a shot. If you can
> help fix any issues this highlights, I'd really appreciate it and I'd
> be happy to guide you through what I think needs to happen. But I
> don't think I have the time to fix it myself.

Sure, I tend to agree. Let me check the generic phy driver path for any
issues and if that test seems to go okay I too am of the opinion that
without any solid reasoning against this we enable it and battle through
(revert and fix after the fact if necessary) any newly identified issues
that prevent phy-handle and fw_devlink have with each other.

> 
> Overly optimistic:
> Acked-by: Saravana Kannan <saravanak@google.com>
> 
> -Saravana
> 


