Return-Path: <linux-kernel+bounces-217919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4065790B627
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E78541F245AF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A4B14F10D;
	Mon, 17 Jun 2024 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITz8R4jh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A6714D2B9
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718641229; cv=none; b=QFsXYQc/Sn0Y+Yx/Yrb72E1hjwCO/nnuswUYvYtOthaLeg8HcKSl0FDww8/XefoqUiEj46tjhCxfnAhL4hL+XXeesdlCMGY9My+eL07NhCalslzu3Jxm2BcaSNdwovBP3vDlue4GY+lM8/XwhRImf8eWF5JW5uaKatwhlmm+Hxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718641229; c=relaxed/simple;
	bh=1YMKriBvPLE/aY5scq43G0zWcXPtBM3EQFqBpiwdFiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WscX7n2U0XF4ftXgs+JDg/8uxrG9apN0Uh4g6Jq7lk3pgQE32gldeo8Lbqdyl4tyXAovaOr8TkVjf2CG6aKO2vABPZhTIfIW/gY4W0ZxfLrGDUbXGjtMqLq24nxCmJw1q+M96D4VVntv1AJzLo5U7M0iFcBLeQq4pDMAkVRhzaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ITz8R4jh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718641227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IQRV2hrWRZz2oGiqD2uRSCHZ36VaQn0Ap0e/dg5aYkA=;
	b=ITz8R4jhxuUj/44sC6IR7AzAUGz6FbybDCr57UoUEmtxVrUEvcUPdWSUtJeuOXbcYfdNQ6
	ajICeAEbXA6r2+HBPGdiaUS08yShTPn92IaIBwLLR4Fkuiu2N5bK+bNnKWXI/EIEkILyvE
	PWWpdW+0ZqYWoVucNK6oZc2Yjft925U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-D-ajEIAbPw-dN6NfJbSfUw-1; Mon, 17 Jun 2024 12:20:26 -0400
X-MC-Unique: D-ajEIAbPw-dN6NfJbSfUw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-421e17ae038so33189485e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 09:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718641224; x=1719246024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQRV2hrWRZz2oGiqD2uRSCHZ36VaQn0Ap0e/dg5aYkA=;
        b=ljCrQqGieMVWdNTDLOihwOj2IR8LLAijxdpTgGszd/gA/VbFwnCQ14Az8kpVAook48
         9lj38sIeftXTBMKTZJJyLO2kFCDIwMpqM4h6d4xvQGxlgy+m5yDel0p/7zR18VZyzIfl
         ZmEY0bZeDt4B5MEvJJ1T3AHgMY4i6DDcIcwXk7G5mHAhSnMnt1TAPif8b2Ck+AqXnIjC
         8EG3rxkCJCoSUKDDg9EVIOVMqAoLEabnDHqGysEe0qhC2BCbC4Kd2XN7aXt0AOb2cLBf
         IljPk9MiE84eOoD4uSYf7FxL0NOtcPYK2vzSe1D5budEbb5+rGaXynQW2G15xVyZSxpl
         48bQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7x4m+c+AilWZO5mzYWvx0enP4YESUK3nHvC51oarUZkZ4cEIiI380JhiFT5Olqr5PbUKKXMzwOU5aaiM7GTRCMHrTMIbXX9dK0O/b
X-Gm-Message-State: AOJu0Yy5IREdC8uI/iaxb1TcQRKKHnE6wyjvDdW5y0Y+I2VbFlwEAym0
	XwxhaL4p7yVKls5U2pXl8pNSNReotQJODAZORUXH6vasghAhYd4piXmRsSiq6lIl2rHl5bkiiME
	l0qmBAsLcwbNI3iwPEKEUxnzG7UjL62OfvzOtjmj2oqdLobAG9gFKwLzf9xc67Xt3dcD4qQ==
X-Received: by 2002:a05:600c:4b23:b0:421:79a1:bd16 with SMTP id 5b1f17b1804b1-423048264f6mr100417105e9.16.1718641224472;
        Mon, 17 Jun 2024 09:20:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzccSMh+gGntzm0iGboVzC+6fVzzvRfTEWxR0IH3kumTR3OICOIsQlYAnDEfRgmcC5ufh2ZQ==
X-Received: by 2002:a05:600c:4b23:b0:421:79a1:bd16 with SMTP id 5b1f17b1804b1-423048264f6mr100416835e9.16.1718641224002;
        Mon, 17 Jun 2024 09:20:24 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17c:d4a1:48dc:2f16:ab1d:e55a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422d0be1424sm169109495e9.12.2024.06.17.09.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 09:20:23 -0700 (PDT)
Date: Mon, 17 Jun 2024 12:20:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Parav Pandit <parav@nvidia.com>,
	Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <20240617121929-mutt-send-email-mst@kernel.org>
References: <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
 <CACGkMEtKFZwPpzjNBv2j6Y5L=jYTrW4B8FnSLRMWb_AtqqSSDQ@mail.gmail.com>
 <PH0PR12MB5481BAABF5C43F9500D2852CDCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZnAETXPWG2BvyqSc@nanopsycho.orion>
 <PH0PR12MB5481F6F62D8E47FB6DFAD206DCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZnAgefA1ge11bbFp@nanopsycho.orion>
 <PH0PR12MB548116966222E720D831AA4CDCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZnAz8xchRroVOyCY@nanopsycho.orion>
 <20240617094314-mutt-send-email-mst@kernel.org>
 <20240617082002.3daaf9d4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617082002.3daaf9d4@kernel.org>

On Mon, Jun 17, 2024 at 08:20:02AM -0700, Jakub Kicinski wrote:
> On Mon, 17 Jun 2024 09:47:21 -0400 Michael S. Tsirkin wrote:
> > I don't know what this discussion is about, at this point.
> > For better or worse, vdpa gained interfaces for provisioning
> > new devices. Yes the solution space was wide but it's been there
> > for years so kind of too late to try and make people
> > move to another interface for that.
> > 
> > Having said that, vdpa interfaces are all built around
> > virtio spec. Let's try to stick to that.
> 
> But the virtio spec doesn't allow setting the MAC...
> I'm probably just lost in the conversation but there's hypervisor side
> and there is user/VM side, each of them already has an interface to set
> the MAC. The MAC doesn't matter, but I want to make sure my mental model
> matches reality in case we start duplicating too much..

An obvious part of provisioning is specifying the config space
of the device.

-- 
MST


