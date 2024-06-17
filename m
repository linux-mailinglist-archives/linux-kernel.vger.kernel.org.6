Return-Path: <linux-kernel+bounces-217912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990E690B630
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE508B29642
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC2C1798F;
	Mon, 17 Jun 2024 16:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O2wX9y99"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5241C6AB8;
	Mon, 17 Jun 2024 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718640952; cv=none; b=sOo9ooR7AtGjaDITy/AWod+8lLgOw595YGZe0ZsMioJpCylbN4xqm1nfFKnv/SJjC+F3ScRaSmy11e40SnfvNNRUUTvXhlLyDu9w9a6o6BrPUACJSIKd1Bar+IdpjwtPDPwHBgdS5ZLIUyEPyxAMCpUotyonTOKsuQHBvPikmjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718640952; c=relaxed/simple;
	bh=uSltlKr2Soq95YyTnOqHhyvBlkZIATS6n5wTEPNS8Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjGt509xo7HEXNOkRCumt0rx8EVAJ4zrvtqu6EfyZaiT/9RhiFP/o7yDbX/9PIz3tDpemhYX6DUIAan+5laD0BKiLaBbxyT+PwM3vkv0LfXM5EG8fye0Zk5t1c0igSCgbatgQsunsPJUlCqyi2x1UqzXcF86mMxaMuuulQ31q+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O2wX9y99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55775C2BD10;
	Mon, 17 Jun 2024 16:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718640951;
	bh=uSltlKr2Soq95YyTnOqHhyvBlkZIATS6n5wTEPNS8Uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O2wX9y99EU6Xg1plWXmRWrqTioo+GRZmtytOcPVDKfJRg9clcKStGhylRIftGkGxk
	 weMkY8BHup9jSUZm77B8maB73VC1CwWzT/VsWcgPcyK336NHZvJWkq228V7cBEdzWh
	 gLnwNrtA0F9lQu7x8InliQrlqOEdQ0QiN4lCuTE4=
Date: Mon, 17 Jun 2024 18:15:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	Yanfei Xu <yanfei.xu@windriver.com>,
	Pavel Skripkin <paskripkin@gmail.com>,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2021-47472: net: mdiobus: Fix memory leak in
 __mdiobus_register
Message-ID: <2024061747-modulator-boat-b37c@gregkh>
References: <2024052228-CVE-2021-47472-bd55@gregkh>
 <ZmBXJWZyOhI5614_@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmBXJWZyOhI5614_@tiehlicka>

On Wed, Jun 05, 2024 at 02:16:37PM +0200, Michal Hocko wrote:
> Fix for this CVE ab609f25d198 ("net: mdiobus: Fix memory leak in
> __mdiobus_register") has been later reverted by 10eff1f5788b ("Revert
> "net: mdiobus: Fix memory leak in __mdiobus_register"") which itself is
> not recognized as a CVE fix.
> 
> Reading through the revert I am quite confused TBH. It claims there
> is some problem but also that this is not the right fix. That would
> suggest that there is a CVE but it should be addressed by a different
> fix. Can anybody clarify please?

The correct fix was done in commit ca6e11c337da ("phy: mdio: fix memory
leak") which already has CVE-2021-47416 assigned to it.

I'll go revert this CVE now, as it's not correct because it was reverted
upstream.

thanks for the review!

greg k-h

