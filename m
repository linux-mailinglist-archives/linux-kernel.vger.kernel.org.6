Return-Path: <linux-kernel+bounces-333294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE05297C67F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 11:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F04651C210E7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398EE1991C8;
	Thu, 19 Sep 2024 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uTzrUyD0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7595D186294
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726736549; cv=none; b=F+mS/NzlBPh0YMJqQ7OCLkqGaKe91uFNIfgCcHJuQVNL9D6dcTCPYy+6Wwv2pYo/aTdA5TgCrqCNGhwe+cz12kZNjK8bDyXKEUI6u3vHUtWXlIuOvLG4oAyxSGafLnF49gQ0PHZMD6UvTNU9MwHr9V66jcEifu5Y54hJiyoOU8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726736549; c=relaxed/simple;
	bh=f/isTUsW8X8R3KoT6iEY7Bm5jbFtMMQEk/dFReJwsgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMJydvcRGmbiP6rTiN9HJ4yP1idTCILtGQg6m1G0jfcgTot6TOvwRBOujMF3xxL2I9szmG1ztL///y5sGuMfxMFWRI2E0jomob4rV3mBMeo6x71+thHg4KtUUsyzUs0tPv40vqgr/yCqredD69Ztg3aG/8+SzVoij+RPr98ba+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uTzrUyD0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695CEC4CEC4;
	Thu, 19 Sep 2024 09:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726736549;
	bh=f/isTUsW8X8R3KoT6iEY7Bm5jbFtMMQEk/dFReJwsgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uTzrUyD0LWN0xPG2Fv4rhZHsnzSvQRxnEOyrZMpWwWx5F9qgj/eVploDnwhO2IH+s
	 PaO9ddnc5GPYXCdm4PLNFkXXYE3cfUcOZCHUGsgghWlj/T83jX6jdK2+E0jr/namCk
	 l1PftTTqfZx4gx79T444YHdkHzB1Vfup8auxv+tY=
Date: Thu, 19 Sep 2024 07:17:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Jan Kiszka <jan.kiszka@seimens.com>
Subject: Re: [PATCH] driver core: fix async device shutdown hang
Message-ID: <2024091938-pamphlet-chapped-56ed@gregkh>
References: <20240919043143.1194950-1-stuart.w.hayes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919043143.1194950-1-stuart.w.hayes@gmail.com>

On Wed, Sep 18, 2024 at 11:31:43PM -0500, Stuart Hayes wrote:
> Modify device_shutdown() so that supplier devices do not wait for
> consumer devices to be shut down first when the devlink is sync state
> only, since the consumer is not dependent on the supplier in this case.
> 
> Without this change, a circular dependency could hang the system.
> 
> Fixes: 8064952c6504 ("driver core: shut down devices asynchronously")
> 
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>

Nit, no blank line between Fixes: and signed-off-by is needed.

> ---
> The patch this fixes is in driver-core-next and linux-next.
> 
> Please let me know if this needs to be a V2 or if it needs anything
> else... it is the identical patch I sent in yesterday, except I added
> a "Fixes:" tag and the comments.  Thank you for the help!

In theory, yes, this is a v2 as something did change, but I can take
this as-is for now, thanks.

greg k-h

