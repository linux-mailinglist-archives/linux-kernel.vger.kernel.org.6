Return-Path: <linux-kernel+bounces-212751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0BA9065AE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE3BC1F26086
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 07:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FA913CFAE;
	Thu, 13 Jun 2024 07:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T7P+Rs1K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984D013CF98
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 07:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265074; cv=none; b=duzvORyVSAnOiyqlImcXMFZVLJDipztzX6BxZyVGMpHMNM/p1V77NaYG2cESiLe16AbVuen3MdgzoZXb1Yi4gExPkmCY8zht2ATwpTavBARj+J1ox5czRUVqbJnjgUhZj3w9b9bk8gw6MjRxRsyrsug5aYvih7by0RlVpE9ZJYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265074; c=relaxed/simple;
	bh=GFIcxWXQwNCRH03Z9cLHboBcOBzSFyWQjvAxn613bA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yo3ehanYXS+eGPXCQSQAIlJgpX5HIy0xcve4SORG2Gl661VKp4RlreRBz5DNqZ57albLdjDXAiM5rsNmj25H9P0GDP/Tgb8LwqOnU12MdWZwErDoUIBQbrJ24bW7m/kIjcMDdJuKF9nhUY9YlyavyAf/4p5VPYMxnQMDgNzYDaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T7P+Rs1K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718265071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A/n+AhuyhqSsJr+vWl3tvLtoPgeLWQoTZ3U+G+ztgvo=;
	b=T7P+Rs1K1vU1a/lYvosgPiCWEyYZmf4DRCmPNdMkNDTB8Xkw8HEMG065l8Q4eDb+A0l2as
	yxkm34VkNYPWoXHGAlP1Wm/+gPLv+wXNdeXypK4fp3Sz78SClcMPN+SJeFyRu8qkcf426b
	hQizOAZSHjHfJjdcV2bkePPrnoPJOM8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-zaVp5NDsMtufMGTBEo73BA-1; Thu, 13 Jun 2024 03:51:04 -0400
X-MC-Unique: zaVp5NDsMtufMGTBEo73BA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-35f1fcd3bbcso373170f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 00:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718265064; x=1718869864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/n+AhuyhqSsJr+vWl3tvLtoPgeLWQoTZ3U+G+ztgvo=;
        b=UmkLLDWONmkjIkb8vg/YGXUiSMEmA3vGQssqDN3i5nIV4Iml2kg4n7sl4kcCOaAU5w
         2rz1cv3yOrGcRJMtYHmsTgwWGVxWvqZF0vYHKPRD+d0Rz0oXN82R6+ry/ltM9ocSYuOc
         UTjIfOlkOlzMBw16KKavUaSNyT2hpeDw24txB6Q/Tqzm13hLPog1SIqCRwrUEpmiYKXi
         +IIKx7RUGUoAI1ch2aPvAgD150rCoCx5jDMu9fe+6FcVUQVy8hXvqjUcUnXaI4nE7fg5
         vixzJgqlr8Xg70yBGVT4C078jKeT0wJbFe3XnvpewEMFXSdITMyheyO+dYDG5McpDTYx
         xo6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWjutBJfp2OJBLYyzqGa1ClPL9HCtyL5QcZZDgY/EwPpXBgMUiUbdF7njl2p4Fk65/12O4AKk3FTMvstF0ZG4c4QpO+OoUy3zvpgoYs
X-Gm-Message-State: AOJu0YwmSgxdPebJN9kTFMixMK+7lEIXvta7lErOAnvFF5QZvAKfWEfz
	ggzJqOUYoRPywt+4yUw5KksWTcYoebMC1W2OHcU1Ba/5VbSMWkQFT2HlIjr8OfmOjl2WdfzXvPy
	VBTopPxUG5tykuznyQzdh5nxMc+1CnwawLgNLJ+TzgpG45mX7jicD/jVxz01phg==
X-Received: by 2002:a05:6000:d:b0:360:75b3:2cd9 with SMTP id ffacd0b85a97d-36075b32d48mr830152f8f.65.1718265063721;
        Thu, 13 Jun 2024 00:51:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGecT5yUVKpC78rMOjYPpZNfe8ITqSuJs063PFj3s8mFpH0gfLFXFffpfByk9P/e9suAjpbJA==
X-Received: by 2002:a05:6000:d:b0:360:75b3:2cd9 with SMTP id ffacd0b85a97d-36075b32d48mr830121f8f.65.1718265063171;
        Thu, 13 Jun 2024 00:51:03 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:94c5:b48b:41a4:81c0:f1c8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075093d58sm894451f8f.4.2024.06.13.00.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 00:51:02 -0700 (PDT)
Date: Thu, 13 Jun 2024 03:50:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, Cindy Lu <lulu@redhat.com>,
	dtatulea@nvidia.com, jasowang@redhat.com,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <20240613034647-mutt-send-email-mst@kernel.org>
References: <20240611053239.516996-1-lulu@redhat.com>
 <20240611185810.14b63d7d@kernel.org>
 <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
 <20240612031356-mutt-send-email-mst@kernel.org>
 <ZmlMuGGY2po6LLCY@nanopsycho.orion>
 <20240613024756-mutt-send-email-mst@kernel.org>
 <Zmqd45TnVVZYPwp8@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zmqd45TnVVZYPwp8@nanopsycho.orion>

On Thu, Jun 13, 2024 at 09:21:07AM +0200, Jiri Pirko wrote:
> Thu, Jun 13, 2024 at 08:49:25AM CEST, mst@redhat.com wrote:
> >On Wed, Jun 12, 2024 at 09:22:32AM +0200, Jiri Pirko wrote:
> >> Wed, Jun 12, 2024 at 09:15:44AM CEST, mst@redhat.com wrote:
> >> >On Wed, Jun 12, 2024 at 08:29:53AM +0200, Jiri Pirko wrote:
> >> >> Wed, Jun 12, 2024 at 03:58:10AM CEST, kuba@kernel.org wrote:
> >> >> >On Tue, 11 Jun 2024 13:32:32 +0800 Cindy Lu wrote:
> >> >> >> Add new UAPI to support the mac address from vdpa tool
> >> >> >> Function vdpa_nl_cmd_dev_config_set_doit() will get the
> >> >> >> MAC address from the vdpa tool and then set it to the device.
> >> >> >> 
> >> >> >> The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
> >> >> >
> >> >> >Why don't you use devlink?
> >> >> 
> >> >> Fair question. Why does vdpa-specific uapi even exist? To have
> >> >> driver-specific uapi Does not make any sense to me :/
> >> >
> >> >I am not sure which uapi do you refer to? The one this patch proposes or
> >> >the existing one?
> >> 
> >> Sure, I'm sure pointing out, that devlink should have been the answer
> >> instead of vdpa netlink introduction. That ship is sailed,
> >
> >> now we have
> >> unfortunate api duplication which leads to questions like Jakub's one.
> >> That's all :/
> >
> >
> >
> >Yea there's no point to argue now, there were arguments this and that
> >way.  I don't think we currently have a lot
> >of duplication, do we?
> 
> True. I think it would be good to establish guidelines for api
> extensions in this area.
> 
> >
> >-- 
> >MST
> >


Guidelines are good, are there existing examples of such guidelines in
Linux to follow though? Specifically after reviewing this some more, I
think what Cindy is trying to do is actually provisioning as opposed to
programming.

-- 
MST


