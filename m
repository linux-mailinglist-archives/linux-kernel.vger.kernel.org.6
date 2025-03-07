Return-Path: <linux-kernel+bounces-551000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AD4A566CD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF4E175824
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA40211276;
	Fri,  7 Mar 2025 11:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4WFT5J5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D377E149C50
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 11:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347198; cv=none; b=SY2zXSbri9Es0wUlPGwje0UBmVekiSAQmLMcXUhUhOvhf5H/m9qSdRL8crWP79pRiDM907c+1dNWpJnvdTFgqqV8vjpUuRh58h5g/6Z+ia/vg/7biElyALk6v/FeBVJIpt7pFwCJcj3EjSihQYNN2xONgzL6jtJHyg1/GaYVzj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347198; c=relaxed/simple;
	bh=c8A6LHLgGxAhxtqcvWKDrLXsGsgBqKXg68SJwCV73Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxGC5xfL9sp7zjUnSMD+esR6z4fy4ulu5IQ6BSMspGiM0CmBwBiFVxq9+hVRxPGDQL7curi/PQ/CXTw1zCELSVrt7bjWzn9nmKkpsYEWslMZlmNj8WLmws3XGEAsf0OxcqXnzeD9r2Fr/pAzg+gvo6gEbWh68hMQo6zB/ZTCFO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4WFT5J5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E79FC4CED1;
	Fri,  7 Mar 2025 11:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741347198;
	bh=c8A6LHLgGxAhxtqcvWKDrLXsGsgBqKXg68SJwCV73Ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t4WFT5J5ObAqiTnnNCVZ0JB9LPfMncQaE5duQici9omqXpE6Q8KbzfQO+NjucNn6A
	 off6jAx+UZrorM1DAy1QkuYslRyv2cHYEZ5ZlRutrnM5K6laqqNG1dzC6IE08Ed+qT
	 zImxb9UNxmC2IGxeVrq7AJu7mImqbQhgAXA2tCv29WIjDreDduw5aIOBOof/yFmfv4
	 fKrcGPhhpUrPTjrLdyE4FMe5anNVpxqr+SwoybO6B8dBITdMB8oZgOEAmg++8DHtoe
	 ScvveoqmGTrHArXWybEEnfiYXzm+G5M2/9ZC51hWd4qfGHoYQMo+J5vTowoi2A91L3
	 OwqqCTKwnetBg==
Date: Fri, 7 Mar 2025 12:33:12 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, lucas.demarchi@intel.com,
	linux-kernel@vger.kernel.org, willy@infradead.org, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, yi1.lai@intel.com
Subject: Re: [PATCH 04/19] perf: Simplify perf_event_alloc() error path
Message-ID: <Z8rZeAjWSpjsrPCn@gmail.com>
References: <20241104133909.669111662@infradead.org>
 <20241104135517.967889521@infradead.org>
 <Z8lVchtSX/w/atEU@ly-workstation>
 <Z8lp0z-7nlUr7LyD@gmail.com>
 <Z8pk9BNcEd5kpJFw@ly-workstation>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8pk9BNcEd5kpJFw@ly-workstation>


* Lai, Yi <yi1.lai@linux.intel.com> wrote:

> On Thu, Mar 06, 2025 at 10:24:35AM +0100, Ingo Molnar wrote:
> > 
> > * Lai, Yi <yi1.lai@linux.intel.com> wrote:
> > 
> > > Hi Peter Zijlstra ,
> > > 
> > > Greetings!
> > > 
> > > I used Syzkaller and found that in linux-next (tag: next-20250303), there are two issues and the first bad commit for both issues is
> > > 
> > > "
> > > 02be310c2d24 perf/core: Simplify the perf_event_alloc() error path
> > > "
> > 
> > We've had a number of fixes in this area, could you please check 
> > whether you can reproduce this crash with the latest perf tree:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
> > 
> Tested the tip tree perf/core branch - HEAD 7a310c644cf571fbdb1d447a1dc39cf048634589:
> 
> Above two issues cannot be reproduced.

Thank you!

	Ingo

