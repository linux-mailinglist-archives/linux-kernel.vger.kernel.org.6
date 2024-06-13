Return-Path: <linux-kernel+bounces-213386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C30A9907478
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0D191C23043
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93645144D21;
	Thu, 13 Jun 2024 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HUMiz+ZV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEFB139CFE;
	Thu, 13 Jun 2024 13:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287143; cv=none; b=FV644LJh0meeZqtH2I2vMljVfihvzYEc+0vaKDerp3BEn/bw/3H+GvyXCdvTztVfqmjD85NmQFPziIwNbYYsv4qHjyPkXVYgdPTy9lbsUquWcHluqpWuD4ACuRKCW7m0i6bzAfL4B5bcX7uP4+MnRjynfegULJqjAxHoMv4hHbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287143; c=relaxed/simple;
	bh=cvzl7oxeW0ZrGo1HjKtsJxQN2aBSgKyqdnK9ah3NI1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmkibTcPLsDCk2WtwMbxXUpCdcQeOXgAE2BLxBfUDtIWK/WsnrWzP65u4Ak9IwvvZfAgx8ynz+lk70h0m0e90wCJ4DTZGm9BaIpcfB5anUCx5NrJBLx7O244CjXKwMrHvwnAnD9crsaXps2cIwXvu51ai2m6Y51m7Iwc5iy+wJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HUMiz+ZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B6EC2BBFC;
	Thu, 13 Jun 2024 13:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718287143;
	bh=cvzl7oxeW0ZrGo1HjKtsJxQN2aBSgKyqdnK9ah3NI1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HUMiz+ZVjwDgIXB6hCXRizbGhUrbxEEjSOc6SwM6+MDWq02Kb5OcuwvN3eR9lGACi
	 OmaXsoZItLjgcU0MiYk1XOGIfLnc/Cw8oXqCwgy3TUx+m4Yc8HMAevlqLy9mrsD2J5
	 S5OkyP/VcwN55ABbeRRXKY+GvBd2DImAkX8KFJoA=
Date: Thu, 13 Jun 2024 15:59:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@suse.de>, Jakub Kicinski <kuba@kernel.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: CVE-2024-26831: net/handshake: Fix handshake_req_destroy_test1
Message-ID: <2024061357-fencing-pyromania-70a2@gregkh>
References: <2024041704-CVE-2024-26831-2e6e@gregkh>
 <97629d4e-1f3d-441c-b92a-2e8b74b9846a@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97629d4e-1f3d-441c-b92a-2e8b74b9846a@oracle.com>

On Tue, Jun 11, 2024 at 10:21:47AM +0200, Vegard Nossum wrote:
> 
> On 17/04/2024 11:44, Greg Kroah-Hartman wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > net/handshake: Fix handshake_req_destroy_test1
> > 
> > Recently, handshake_req_destroy_test1 started failing:
> 
> [...]
> 
> > Affected files
> > ==============
> > 
> > The file(s) affected by this issue are:
> > 	net/handshake/handshake-test.c
> 
> Hi,
> 
> This patch
> (https://git.kernel.org/torvalds/c/4e1d71cabb19ec2586827adfc60d68689c68c194)
> fixes a kunit test; we therefore believe this is not a vulnerability.

Many systems build kunit tests into the kernels they ship to customers
(hint, a few hundred million phones have them enabled...)  So if your
system does build this one, then it is an issue for you.

If you don't build it, wonderful, not a problem!  But we can't just not
assign a CVE just because someone might not build this file, again, we
do not know use cases, which is why we have to assign CVEs for all files
that could be built as part of a kernel image (but not for the userspace
test stuff.)

thanks,

greg k-h

