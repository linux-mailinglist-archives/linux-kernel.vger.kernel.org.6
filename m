Return-Path: <linux-kernel+bounces-230909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C0C9183AA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0E42B24D37
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51471849D1;
	Wed, 26 Jun 2024 14:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjpLzzPc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D1218411D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719410894; cv=none; b=nuA8LbE7+oa/+CenvNUnMuoumxCge7+ORyGf3R6n41ZIUj+t+ewGUURlPgMZC4F/FxZU9PXR9a63bqAZT1qt3bq3R4VXOxIwcdDmvaJRrJLfz6DAfObQGBqG6mdsrKzOLsJO8/7ZZ6o9wMgoOHKi9OM0og1sH7zo11yKdMJbkg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719410894; c=relaxed/simple;
	bh=b+jYDaoyUxMFh/qdWC8py4dZMe3nHVTyCOcKzwiM5zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddIf9C0EpXyWC65kEiMqDcq0qmMGtfpAX5d2HyMxHU2B6ye3Qd/tvuGFRe81ZtK9K9RoOinqxMYH4KljJ1Z/+HWHuvNRIpUhPwYy5y5J4J9onyWc2wSO4V65KQfJzM/oB1bUWFKRJ8dxZJR3Kz2nJIfMZaZiqio4q+hp5hhehLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjpLzzPc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39E0C116B1;
	Wed, 26 Jun 2024 14:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719410893;
	bh=b+jYDaoyUxMFh/qdWC8py4dZMe3nHVTyCOcKzwiM5zE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SjpLzzPcxejybWPIyzdt1epNmYo6f3DQFwL3z6EC2ZvHYxUY06/SsKyFa2nawyLAp
	 lPrsi58YHewjPtsii1bHg8lSDXkljI28P6Q7ndXssMyVdHX7Nv+L6Mi+dttZvS8Z15
	 zBLx7jbVyRkGpWzbuZZgFq7BC0nWlII9vE5GK/2d1WiBUHxxP+5RWh/uxerKsb0Gtb
	 pYE82HjmAH4rfpt+NolTJG5yUuXv6PPJs1pVAi0lDZFeU8wZ2GjSFasWzP2PoPQAuQ
	 nbqUEMa//lNxCmhzwdgRXOl8qegPTR4PVRz8pZnO+3w+bhfUgCpF6++GyfCcoqbBbI
	 1n/MAnPUKCfDw==
Date: Wed, 26 Jun 2024 21:54:07 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Andreas Schwab <schwab@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] riscv: uaccess: use input constraints for ptr of
 __put_user
Message-ID: <Znwdf2c1pYetrsHe@xhacker>
References: <20240625040500.1788-1-jszhang@kernel.org>
 <20240625040500.1788-3-jszhang@kernel.org>
 <acd2e53f-b5c1-49c5-86e2-bc09eb917163@app.fastmail.com>
 <ZnwKXWzRz9B5FbLM@xhacker>
 <ZnwObmA70Bfx9yCn@xhacker>
 <mvma5j7omh1.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <mvma5j7omh1.fsf@suse.de>

On Wed, Jun 26, 2024 at 03:35:54PM +0200, Andreas Schwab wrote:
> On Jun 26 2024, Jisheng Zhang wrote:
> 
> > no output constraints either. It just uses "r" input constraints to tell
> > gcc to read the store address into one proper GP reg.
> 
> Again, this is backwards.  Being an input operand means the asm is using
> this operand as an input to the instructions.  The compiler needs to
> arrange to put the value in the allocated operand location according to
> the constraint.

Hi Andreas,

Your information is clearly received. What confused me is:

why x86 and arm64 don't put the "addr" of __put_user into output
constraints? Especially the following comments, why this is "read"
from memory?

 * Tell gcc we read from memory instead of writing: this is because
 * we do not write to any memory gcc knows about, so there are no
 * aliasing issues.

can you please kindly help me understand the tricky points here?

thanks
> 
> -- 
> Andreas Schwab, SUSE Labs, schwab@suse.de
> GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
> "And now for something completely different."

