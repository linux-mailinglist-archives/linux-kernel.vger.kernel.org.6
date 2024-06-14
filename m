Return-Path: <linux-kernel+bounces-214409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5F39083FD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B30F1C223F6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 06:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784F914883B;
	Fri, 14 Jun 2024 06:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GzXnHHU7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C7914882B;
	Fri, 14 Jun 2024 06:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347811; cv=none; b=IL2ykmQR8nXRuQnYBhC6qOXE9GBrLWMq23dycpofCba27yBtZE8n0Uzr3PksjiYwiXdPSg9MftkCJ6i7yIJQLEjGs380g2c1mV3GAGHwyYPJkm6tgAmAoora7ETBPBPlXpLJPfvwng99+WP6+BkG0nVmoiyZq4fzh8rJWSkq0NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347811; c=relaxed/simple;
	bh=jt9YTgTk6SZvNJvRMAeqZX4LPxGTdXb5HZRZ4VuwGRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kr5CXniFxgRk11g2OE+jFiXx/8a4LVytZnEASd8pbeojxy//ZkPhWSB83zTdFwwhBcJLNgXVDb4x8Jb1n+Wo86xBZLT5iIzrgOKMRRaxguEc5kpZfb6rCrvVruvf69PFlbt75SeeJZOCgmEQSOYyx77bX1UlEKhQNhcAeiDm2nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GzXnHHU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D805C2BD10;
	Fri, 14 Jun 2024 06:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718347811;
	bh=jt9YTgTk6SZvNJvRMAeqZX4LPxGTdXb5HZRZ4VuwGRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GzXnHHU7+MuXoJt0yt/sVJkev7OLM4Sogl9iiK1QoSRWdYYj62Q3bFIImEeJoBP24
	 pjt0m9cNY6tWDwyIs8gu5y+Vbdg4veRGgtLdk/setNt/L6T6P1ox3Gzp6rgq7NrN9P
	 CAZGYG6atDRhLOKzYiHjVY6hULqw2Yfh7lGAfpHA=
Date: Fri, 14 Jun 2024 08:50:08 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Umang Jain <umang.jain@ideasonboard.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.org>,
	detule <ogjoneski@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: vc04_services: vchiq_arm: Fix initialisation
 check
Message-ID: <2024061436-twister-survival-a05c@gregkh>
References: <20240613194150.2915202-1-kieran.bingham@ideasonboard.com>
 <20240613194150.2915202-2-kieran.bingham@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613194150.2915202-2-kieran.bingham@ideasonboard.com>

On Thu, Jun 13, 2024 at 08:41:46PM +0100, Kieran Bingham wrote:
> The vchiq_state used to be obtained through an accessor
> which would validate that the VCHIQ had been initialised
> correctly with the remote.
> 
> In commit 42a2f6664e18 ("staging: vc04_services: Move global g_state to
> vchiq_state") the global state was moved to the vchiq_mgnt structures
> stored as a vchiq instance specific context. This conversion removed the
> helpers and instead replaced users of this helper with the assumption
> that the state is always available and the remote connected.
> 
> Fix this broken assumption by re-introducing the logic that was lost
> during the conversion.
> 
> Fixes: 42a2f6664e18 ("staging: vc04_services: Move global g_state to vchiq_state")
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> ---
>  .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c  | 4 ++--
>  .../staging/vc04_services/interface/vchiq_arm/vchiq_core.h | 5 +++++
>  .../staging/vc04_services/interface/vchiq_arm/vchiq_dev.c  | 7 ++++++-
>  3 files changed, 13 insertions(+), 3 deletions(-)

You sent 2 different patches here, both with the same subject, which one
is correct?

Please send a v2 so that I know what to apply, I've dropped this one
from my queue now, thanks.

greg k-h

