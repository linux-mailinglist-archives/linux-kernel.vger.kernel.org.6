Return-Path: <linux-kernel+bounces-210339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B26A90428B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 19:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE8971C244D5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB55E4F88C;
	Tue, 11 Jun 2024 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COZUtSea"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1987B47F5D;
	Tue, 11 Jun 2024 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718127548; cv=none; b=jQ16gGwuR4JKNrEVkwyo0FjrCA63WIZkvndskgAh47oHamx96vZiNaNlBthuQ7Sndh3W9itY7rBAz+5JMXA3wkFUIC+goy4GA4iIfWnUCUR/rVXHzjlYhqn7HR4L31ptJCAL/bcXX1QEeXAbn4YwmjIGV4m+ZS+Am1Pflm3kL0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718127548; c=relaxed/simple;
	bh=dv90Kmj1AVO87EkjlwVP3gspBUKICM5NEKJytZOA3yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWjxMBEx7iSIdUnm8vrLD+n8AkSyo6fbjghTGbY2KJbM45zSsoAK72GXAz7HgIPoGj/LO6+Uxzmjo5kU3naWc9psXzA2ptA89aKPGT/0t8AI87wgmGyj2HtC9kxH60Ms+4bs9U2UG0Ry5MzimXfoWK8ewv7pnuURq5xhGO8I5Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COZUtSea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20693C32789;
	Tue, 11 Jun 2024 17:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718127547;
	bh=dv90Kmj1AVO87EkjlwVP3gspBUKICM5NEKJytZOA3yA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=COZUtSeaBdFgnbkJqZWkD9V/v019qRMyp/hW7Wl+BgzHi8jw8YpzflhBCjjKTjvt/
	 fKlOp5YWkoSgFzw3fTm4pRsIlqRivvEDPQ44vmk0V2m4avjd6rkGKla7Y13jWMVdj3
	 Ko+Y04q3xxZhZLEFPds9pAFFTMM6Q5Kj3HTrnH69gUxl7ZcQ3oDAF+Syfn6LTI4LGX
	 KTkXSQCp4AWC8FKonvzXcg29WG4KsygpuMNF+KnMr54VPOG1TQNf7ki9gUF7lMs7XA
	 YYlm3TozC7v86iBX1U9BZu1FX5ky42eXI6+JFZoDVfhp41MXYyJ2169UccGrtyWuuW
	 LNEEeKOw3fxMg==
Date: Tue, 11 Jun 2024 23:09:03 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@gmail.com>,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	LKML <linux-kernel@vger.kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Sriramakrishnan <srk@ti.com>
Subject: Re: [PATCH] dmaengine: ti: k3-udma-glue: Fix
 of_k3_udma_glue_parse_chn_by_id()
Message-ID: <ZmiLt_S8_CSxY9qv@matsya>
References: <8b2e4b7f-50ae-4017-adf2-2e990cd45a25@gmail.com>
 <b3c8457b-f652-4f1d-a02f-e5a7325b18bb@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3c8457b-f652-4f1d-a02f-e5a7325b18bb@web.de>

On 21-05-24, 20:22, Markus Elfring wrote:
> …
> > > without having incremented its reference at any point. Fix it.
> >
> > Acked-by: Peter Ujfalusi@gmail.com
> 
> Please improve the data representation for this tag.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.9#n468

Please STOP wasting time of everyone. Go write some code which solves
something!

-- 
~Vinod

