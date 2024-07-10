Return-Path: <linux-kernel+bounces-247831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 442F292D52E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614CB1C20F78
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48C11946BD;
	Wed, 10 Jul 2024 15:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BpkxVglJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98091EB2A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 15:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720626112; cv=none; b=vFESWookMOZC9tFOyAVKUCh0kEcposOFTeSTpZ+Nuu8sveQOnSxr0u4Yz236Utgo/r5aecMic/1WdNv/3FRCYd5P6HNbxbRBV8GwOvZvzEsTrsheq6z7O0hc3htPKOLDxetNixtv1WqDlwfALA9SS10tB47SF+9Y6LTw5YYNO7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720626112; c=relaxed/simple;
	bh=kjSkQRtJBB57kXqddkxjG3h6NHhl8b8AwIuhcgW6jvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJNAaKz1tVn+Kdr/CmgbBm1uaFfYACh1R1fdvt7rhPqkojdeH1iwT1O38Dz4Cp/75PgqZROCM0Wzdf3gzofYcMB8GQat5bdWrelTYtFQ6CorfGZ71cXAQ2KjQ2gi0Q+xYUeX7uyTiavjoNjObgW3U3jT4j0zxxGg74EJUEi5Sy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BpkxVglJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720626109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RFy0Pt4ubesULzO+oQaiRFBM5Ze1aZnn+Qz6jyyaJAc=;
	b=BpkxVglJmEDOvITQxlBN7RUpPcLsMAoBt+3XF7gbU8thCFy2sZZl9GuwNuEHK+MD3ZYYOb
	N6lopLSx1m5fk1Q5NagU66uX4RC7wBkHSPQl/8rJ+egdC6ia8i2//Na7lQuYeHLkr1Tt3H
	h9UV6egzvXXWHXf5z7qZ6IavgjlSGss=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-dIh-x8UiP_iCt5h6YmjwEQ-1; Wed, 10 Jul 2024 11:41:48 -0400
X-MC-Unique: dIh-x8UiP_iCt5h6YmjwEQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b5dacdc192so17472076d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720626108; x=1721230908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFy0Pt4ubesULzO+oQaiRFBM5Ze1aZnn+Qz6jyyaJAc=;
        b=HjU4slmg/PBv4PA0zV41AUINkBu9l98Xoo+aZDwLiOQz8OK1d+s/qNNRHXQTAeMYId
         xELGV93SaFXWmgszLM2U8xiGWfiZ0C3gYY/dxShvGATn7ryO+KdlLYjuK3Ug8oGzH98u
         uvI7EZ0bLbcES/QFr02rgG/g6EtPo1dganDM0noIfuhb5kalmWZaNKQPSIrTQXi/UshN
         gBT08/DEJlKh2xhwqyDBpuhv3/pxT/uFPbOodsyKxABeQvcClP7iT5crZ5Wkvh0T0ZNi
         eGh4S3FkeCI5xxEKdd+iUov0Y6Wrj9bQyI1ytYjeawhC11LBENaDS7i9obJhrhgszBWB
         FqYA==
X-Forwarded-Encrypted: i=1; AJvYcCWCWQqqv4Oq1NC/zGIAmYWgMRI3xgQMjVpujSHwrIqhvSXSQ1JEH0UbyoxR4ye0KfVdDSTbs3A2gip5snFFJVPTDq6BxnpG1NRO8Tyq
X-Gm-Message-State: AOJu0YwctNWBXscULekesOm6CFw9urCCZopvF/W7BBuTM6ex1qyNsrvJ
	AqnZBUwPJHffEb8E/i+iVXdlxvomNX69kzDiNDEGqetgSNDn71H3pGDkr4UnfhTpWQGX3txXS4I
	JAyc5TzLcZcSGbna6wnAD7DSt8Sdlmqq3AEAfGRP69XwoFEQOLLmDbCVQnEqRUQ==
X-Received: by 2002:ad4:5e8b:0:b0:6b5:d95c:692d with SMTP id 6a1803df08f44-6b74af531a6mr711936d6.13.1720626107772;
        Wed, 10 Jul 2024 08:41:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFm/74UP4TLT1vGs8DLjUNFGeFxt2DXzfyoISdrNcO4smbnFu4jefOYDtfhRDnu4G/xSbFhqw==
X-Received: by 2002:ad4:5e8b:0:b0:6b5:d95c:692d with SMTP id 6a1803df08f44-6b74af531a6mr711666d6.13.1720626107436;
        Wed, 10 Jul 2024 08:41:47 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61b9c47d4sm18003426d6.23.2024.07.10.08.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 08:41:47 -0700 (PDT)
Date: Wed, 10 Jul 2024 10:41:44 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, 
	kishon@kernel.org, sjakhade@cadence.com, rogerq@kernel.org, 
	thomas.richard@bootlin.com, theo.lebrun@bootlin.com, make24@iscas.ac.cn, 
	linux-phy@lists.infradead.org, mranostay@ti.com
Subject: Re: [BUG] k3-j784s4-evm/phy-cadence-torrent: Shared reset using
 exclusive API
Message-ID: <qgqpibrr6hcicpofi64fxenenq7xdffnddbapefjgzsw6q7j2s@cl3gkkytj2w4>
References: <yhtb4clns57t7qo5yxil3oofisdlzfubyiwrvjo2ufw2ngv67m@g6p7ktxfgfv3>
 <46e635e6-b6bf-404c-87a2-57fe25b4855a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46e635e6-b6bf-404c-87a2-57fe25b4855a@ti.com>

On Wed, Jul 10, 2024 at 10:29:46AM GMT, Siddharth Vadapalli wrote:

<snip>

> 
> No, the resets are correct. Both PCIe1 and USB0 use the same instances
> of SERDES which is SERDES0. I had posted the series for PCIe at:
> https://lore.kernel.org/r/20240529082259.1619695-1-s-vadapalli@ti.com/
> with all 4 Lanes of SERDES0 given to PCIe1. Similarly, Ravi had posted
> the series for USB at:
> https://lore.kernel.org/r/20240507095545.8210-1-r-gunasekaran@ti.com/
> with lane 3 of SERDES0 given to USB0.
> 
> Since both of the series got merged on the same day (14 Jun 2024):
> PCIe series:
> https://lore.kernel.org/r/171826022277.240984.16790260886500529482.b4-ty@ti.com/
> USB series:
> https://lore.kernel.org/r/171826022274.240984.5150753966671933401.b4-ty@ti.com/
> the dependency was unknown when the individual series were posted as
> neither of them was a part of linux-next/ti-k3-dts-next when the other
> one was posted.
> 
> > 
> > Total aside, I think we should put the above dts snippet into one &serdes0 reference
> > for readability sake. I'd post the patch but I'm hoping to get the above answered
> > first in order to clean that up before shuffling things around for readability sake.
> 
> Yes, I agree that both sub-nodes should go into the same referenced
> serdes0 node in k3-j784s4-evm.dts. The reason it didn't happen that way
> to begin with is due to the fact that both series got merged on the same
> day as I pointed out above.
> 
> The fix in this case will be to assign lanes 0 and 1 of SERDES0 to PCIe1
> and lane 3 to USB0 with lane 2 left unused since PCIe doesn't have the
> concept of a x3 link. In such a configuration, the device-tree nodes
> will look like:

Thanks alot for the quick explanation and suggestion!

> 
> &serdes0 {
> 	status = "okay";
> 
> 	serdes0_pcie1_link: phy@0 {
> 		reg = <0>;
> 		cdns,num-lanes = <2>;
> 		#phy-cells = <0>;
> 		cdns,phy-type = <PHY_TYPE_PCIE>;
> 		resets = <&serdes_wiz0 1>, <&serdes_wiz0 2>;
> 	};
> 
> 	serdes0_usb_link: phy@3 {
> 		reg = <3>;
> 		cdns,num-lanes = <1>;
> 		#phy-cells = <0>;
> 		cdns,phy-type = <PHY_TYPE_USB3>;
> 		resets = <&serdes_wiz0 4>;
> 	};
> };
> 
> Thank you for pointing out this issue. Please let me know if you plan to
> post the patch with the above fix or you want me to post the patch for it.
> 

I've posted a series (with you CC'ed, just realized I CC'ed Matt instead
of Ravi -- whoops): https://lore.kernel.org/all/20240710-k3-j784s4-evm-serdes0-cleanup-v1-0-03850fe33922@redhat.com/

I'll be on PTO the next few days, so if any changes are required there
do feel free to do them on my behalf if I don't respin by end of today
US-time, otherwise I'll make the changes when I return next week.

Thanks again,
Andrew!


