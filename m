Return-Path: <linux-kernel+bounces-439763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E30469EB3B1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162B71882952
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8562C1B3F30;
	Tue, 10 Dec 2024 14:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p3wO6h5V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A421AA1E5
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841797; cv=none; b=inLszIdh1GYjWvfB9vFJMQjGVr7oQjir7e1/ueXGkCTulsVUgVVwOmfHcsqEgMYhFTfQ/dkcD++aC9Wwv3oVoXB4SnV5ccrlKGrG3Nqun/LjstmrAxm5d8nYFgz28/4VTCRkogC/7S85B/3UKt0ZPaq3PURqe3s8yBOvG/6/mSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841797; c=relaxed/simple;
	bh=0trgOj30h1yasTTGBPN5ycKbphYuSOjKMHbGdekQ3go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLPnxARUIJJdDNrnVewQryr1fPOjcBMxcoav3pxGm82cPZXev6ph8FvSHijdBb23Ti5hwmDG5woxJt3URroNFwGjrXffJtaY/FtLNls8mt3hPEuuHhODMAQH46QsGqG7SbzEeTp+jvG+/63S2/UfrvWn15XC4uVMR3L7eoYhnZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p3wO6h5V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49FEC4CEE1;
	Tue, 10 Dec 2024 14:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733841797;
	bh=0trgOj30h1yasTTGBPN5ycKbphYuSOjKMHbGdekQ3go=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p3wO6h5VLghsMj2EP9nb0xYybw/T6xatks4eADnNc4Ti+2U1NAPRpzOGpw7gJ1Fre
	 5+pRdA1/BoUzpJObEVXmul9fE03I4O2O7I+yTLjbOf7avEebUd+0IBiD2t0r1wN8jc
	 YYg2nSpTBYpgKqg2wZFhb+9Jz5R363TRjdlX9fUU=
Date: Tue, 10 Dec 2024 15:42:41 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: auxiliary bus: add device creation helper
Message-ID: <2024121051-untoasted-update-2d04@gregkh>
References: <20241210-aux-device-create-helper-v1-1-5887f4d89308@baylibre.com>
 <2024121048-latticed-etching-8961@gregkh>
 <1jseqvwqs6.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1jseqvwqs6.fsf@starbuckisacylon.baylibre.com>

On Tue, Dec 10, 2024 at 03:34:17PM +0100, Jerome Brunet wrote:
> On Tue 10 Dec 2024 at 15:05, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Tue, Dec 10, 2024 at 02:43:12PM +0100, Jerome Brunet wrote:
> >> Add an function helper to create a device on the auxiliary bus.
> >> This should avoid having the same code repeated in the different drivers
> >> registering auxiliary devices.
> >> 
> >> Suggested-by: Stephen Boyd <sboyd@kernel.org>
> >> Cc: Arnd Bergmann <arnd@arndb.de>
> >> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> >> ---
> >> The suggestion for this change was initially discussed here: [1]
> >> 
> >> I was not sure if the managed variant should return the auxiliary device or
> >> just the error. This initial version returns the auxiliary device, allowing
> >> it to be further (ab)used. Please let me know if you prefer to just return
> >> the error code instead.
> >> 
> >> Also the non managed variant of the helper is not exported but it could
> >> easily be, if necessary.
> >> 
> >> [1]: https://lore.kernel.org/linux-clk/df0a53ee859e450d84e81547099f5f36.sboyd@kernel.org
> >> ---
> >>  drivers/base/auxiliary.c      | 89 +++++++++++++++++++++++++++++++++++++++++++
> >>  include/linux/auxiliary_bus.h |  4 ++
> >>  2 files changed, 93 insertions(+)
> >
> > We can't add new functions like this without a real user of it.  Please
> > submit that at the same time.
> 
> Sure. There is some prep work ongoing in the user. It will get used once
> that's done. I'll resubmit once this is ready, assuming the rest is fine.
> 
> >
> > And are you ok with sharing the id range with multiple aux bus
> > implementations?
> >
> 
> In the initial discussion, a global id was thought to sufficient [2]
> It also helps to make things simpler on the user side, which is good I think.
> 
> Do you think we've overlooked something ?
> 
> [2]: https://lore.kernel.org/linux-clk/c9556de589e289cb1d278d41014791a6.sboyd@kernel.org

No, it is ok, you just don't document it as such, so it might look a bit
odd for many users.

thanks,

greg k-h

