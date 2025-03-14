Return-Path: <linux-kernel+bounces-561214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E77A60EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57FA71B6133B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6691F03CD;
	Fri, 14 Mar 2025 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o4eRqpN2"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E38155C96
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948218; cv=none; b=mSK1Oi8l+AvI3mj1PLRYCSrZi7kZLnICE/aYK3z6WLIqT5RYrFCAj49HgWJU2Qh4ExbgmcejjuvDprFNUlvowpT6qbubuxcrLG5MdmjEJxjqcxiR5R92aKWusKsxtOLMhLXjnlj2Koel3GuYhVsx6Pw8zs5pButdK5uiH2mebdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948218; c=relaxed/simple;
	bh=zPIgBFSapNqBCcFoAq12Ai3B92XuRKLjXyEQXIA3a58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtDfAlh0ZJeQFTK/B9vXHCupAs6vralYmgf5PnWmGHvr1J3I8idhrcodYx/pqX+UfxWiPg2skpZOM6+PKzwj4e8GAZcx3huW3rQ1MRWIk3Fty4qrlx/EJHieFwxv5J8yOHmxc3iOIvqD4V/H6+npSHffJgBi90Kodx2CkJhHf/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o4eRqpN2; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 14 Mar 2025 11:29:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741948204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0UfVeEDY0MoHgV6nzLZ3BSMFI3hnBpyEIRUD+grXzCM=;
	b=o4eRqpN2hQ2wkENpB5K2IMaa+2Iylkz9eXD2wbfKkcc4Nl20AoWo62lZUbR17K90pj3Hc1
	2/Gl58hsPC9WJkWZpRJTgkbZHkQBCx8WoK4ug2rPWsmgdzOUBj/VTVIzrAPEEW0b8HzB/I
	7KQs5DcMD0gq9MLpJPfZhLP2/ZjNdbQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Richard Leitner <richard.leitner@linux.dev>
To: Lee Jones <lee@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 2/8] media: v4l2-flash: add support for flash/stobe
 duration
Message-ID: <dunceutcslebyflqj5vgo3hfxwyyar3puvp7dr5awpiemvb4za@birq5hmjkoot>
References: <20250314-ov9282-flash-strobe-v2-0-14d7a281342d@linux.dev>
 <20250314-ov9282-flash-strobe-v2-2-14d7a281342d@linux.dev>
 <20250314095146.GB3890718@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250314095146.GB3890718@google.com>
X-Migadu-Flow: FLOW_OUT

Hi Lee,
thanks for your quick feedback!

On Fri, Mar 14, 2025 at 09:51:46AM +0000, Lee Jones wrote:
> On Fri, 14 Mar 2025, Richard Leitner wrote:
> 
> > Add support for the new V4L2_CID_FLASH_DURATION control to the v4l2
> > led flash class.
> > 
> > Signed-off-by: Richard Leitner <richard.leitner@linux.dev>
> > ---
> >  drivers/leds/led-class-flash.c                 | 15 +++++++++++++++
> >  include/linux/led-class-flash.h                | 16 ++++++++++++++++
> 
> This should be a separate patch.
> 
> Then Mauro and I will have to come up with a merge-plan for the series.

Sure. Will create a separate patch for this in v3.

> 
> >  drivers/media/v4l2-core/v4l2-flash-led-class.c | 13 +++++++++++++
> >  3 files changed, 44 insertions(+)
> 
> -- 
> Lee Jones [李琼斯]

Thanks!
Richard

