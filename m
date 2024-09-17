Return-Path: <linux-kernel+bounces-331307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C90B97AB19
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6265C282E35
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 05:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227BB13DDB5;
	Tue, 17 Sep 2024 05:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LH/uGK1w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A76A137745;
	Tue, 17 Sep 2024 05:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726551374; cv=none; b=LTrVwCfwclneE+XL9GExsL1hTfXPrA0pNWY/XTDQXWa4cOY0YGgJqMawTzz9+xlIljIKStcoiE9ikkT2Z0AK3QvWvI3CpRoewq0vK0xA1o9pUBhXDAEeBj1mKBO4ymXjTT8s7kfX/3DjQG/BBkoENftCPyM0hP46Sav04cqmBZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726551374; c=relaxed/simple;
	bh=OPXVdrWekYS4HRt3jS1XMZNUS2M7lr5o0Nv4AyrbWTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpGOolBVCmM5jAOfPzAeOg5hVMW1ltRVcEhbtuK+PYrnB2CmAyBU6od6JkQqjNTL/3cWrVuLKrhUvxVKymnI1fh/5Xp/MMDxvkiSkRM3RakK6aRbaMW8wqUwf4KZbkTRtopJKU3hdLt8bdZPtFgqN2Mlm/D0v84dVtjAwcrPI/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LH/uGK1w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87478C4CEC6;
	Tue, 17 Sep 2024 05:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726551374;
	bh=OPXVdrWekYS4HRt3jS1XMZNUS2M7lr5o0Nv4AyrbWTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LH/uGK1wp4trpla9LCHuK7pFxzF0HqSw2Y7k/Kb10m/OSNj2DI/RkHKvKNfs/0hLb
	 uPSRuFHkjtkIkEEfqC9b9gj62MxHo0OS2t76Sun34NhPRnXaZsKtnAlURt17BEn6I9
	 SnHrZAMLCXTYaKsvR/RTdLCBboAP67drtMwBw9EM=
Date: Tue, 17 Sep 2024 07:36:10 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Selvarasu Ganesan <selvarasu.g@samsung.com>,
	"felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
	"dh10.jung@samsung.com" <dh10.jung@samsung.com>,
	"naushad@samsung.com" <naushad@samsung.com>,
	"akash.m5@samsung.com" <akash.m5@samsung.com>,
	"rc93.raju@samsung.com" <rc93.raju@samsung.com>,
	"taehyun.cho@samsung.com" <taehyun.cho@samsung.com>,
	"hongpooh.kim@samsung.com" <hongpooh.kim@samsung.com>,
	"eomji.oh@samsung.com" <eomji.oh@samsung.com>,
	"shijie.cai@samsung.com" <shijie.cai@samsung.com>,
	stable <stable@kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: core: Stop processing of pending events if
 controller is halted
Message-ID: <2024091716-snide-mashing-2c21@gregkh>
References: <CGME20240916224630epcas5p42b355e2884c665e19d3c9c3a5afd428e@epcas5p4.samsung.com>
 <20240916224543.187-1-selvarasu.g@samsung.com>
 <20240916230032.ugw23x7gijamrf5x@synopsys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916230032.ugw23x7gijamrf5x@synopsys.com>

On Mon, Sep 16, 2024 at 11:00:30PM +0000, Thinh Nguyen wrote:
> On Tue, Sep 17, 2024, Selvarasu Ganesan wrote:
> > This commit addresses an issue where events were being processed when
> > the controller was in a halted state. To fix this issue by stop
> > processing the events as the event count was considered stale or
> > invalid when the controller was halted.
> > 
> > Fixes: fc8bb91bc83e ("usb: dwc3: implement runtime PM")
> > Cc: stable <stable@kernel.org>
> 
> Checkpatch doesn't like that format. Fix the Cc stable tag to below:
> 
> Cc: stable@kernel.org

What?  Why?  That should be fine, exactly what is the warning that this
gives?  That should be fine, as it's what my scripts put into patches
that I create :)

thanks,

greg k-h

