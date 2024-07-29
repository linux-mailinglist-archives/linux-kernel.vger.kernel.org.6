Return-Path: <linux-kernel+bounces-266471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC09940059
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 23:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 313761F2268B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F0A18D4C2;
	Mon, 29 Jul 2024 21:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gAWpxwPL"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D3D186E29
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 21:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722288329; cv=none; b=qN1GUawlP6SOAMPzVE3zsK+2m5klOEilE+AB6zq+mm3u3xJNKveI/3xZCRYj6dgvN+emAXhxbl5VsBhcXiZvQ8fK+YuvZi3RNfYOzH1i5HndOnNwrAj3jK6G3HMlaOvh+UvLIdRA6/8lrOLRL7DCD1G/ij77RllXUwNAM2ZUI7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722288329; c=relaxed/simple;
	bh=PHr4CwpUdy3Tx/wo8yT5yaYZ71Az7104ZtTn8CtxvIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sI42Z8Qs6P6Za7JEMGUhF4nzw1IgIvTVobVu9yLnpws08OZM6bkfjrAVGGQy6wL84RckK820hzbX5KHtVOCPls/95xiHI06ABGZtMrsof5g+Pjo+6Le8yCmnp5hvwk5mClveuZKRevZ4jk2h8Jy5n1kRz9f7+Rd4s+GGwroui/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gAWpxwPL; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722288326;
	bh=PHr4CwpUdy3Tx/wo8yT5yaYZ71Az7104ZtTn8CtxvIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gAWpxwPLVdewi1ZrykT0+TDddGvDEQXJsUHYcnrR007c3vYS1yeMsL2xNi3q4MzQX
	 FaaHiykBljkkmMd6aJTDWsxTVO7IDgQWP/fwpz45TM4ClVA3gXQwZXkqn5UYHIhD3r
	 TZZr3g3dW2C+bXdd3fxLyCG+XLyeIdeEgOXgC7iTh4N9ut39KsnUcBtsNNcJelXY0j
	 /802W3U9SqiSbVZvCcF+1U0jQOT9KH7dOWspmC9CzPoccPD5hw1bYSEvFsT2P1PYUC
	 OH7ffGk6xj3sxuiWz6c6fkNDJynhlLRxWmmmh2942kufKGkZ1DaJRTpbDQrbLxW9ym
	 csFqxCrkabH1A==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C9A4E3780B50;
	Mon, 29 Jul 2024 21:25:24 +0000 (UTC)
Date: Mon, 29 Jul 2024 17:25:22 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, kernel@collabora.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Don't log intentional skip of device link
 creation as error
Message-ID: <575b02aa-6496-492b-b37d-d0612165eda3@notapiano>
References: <20240624-fwdevlink-probed-no-err-v1-1-d1213cd354e2@collabora.com>
 <CAGETcx-sAu-wMDKT9zCeCzLzZ=ZdvK+CSoX34YxMLd5z0YeVZQ@mail.gmail.com>
 <7b995947-4540-4b17-872e-e107adca4598@notapiano>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b995947-4540-4b17-872e-e107adca4598@notapiano>

On Tue, Jun 25, 2024 at 09:56:07AM -0400, Nícolas F. R. A. Prado wrote:
> On Mon, Jun 24, 2024 at 04:53:30PM -0700, Saravana Kannan wrote:
> > On Mon, Jun 24, 2024 at 8:21 AM Nícolas F. R. A. Prado
> > <nfraprado@collabora.com> wrote:
> > >
> > > Commit ac66c5bbb437 ("driver core: Allow only unprobed consumers for
> > > SYNC_STATE_ONLY device links") introduced an early return in
> > > device_link_add() to prevent useless links from being created. However
> > > the calling function fw_devlink_create_devlink() unconditionally prints
> > > an error if device_link_add() didn't create a link, even in this case
> > > where it is intentionally skipping the link creation.
> > >
> > > Add a check to detect if the link wasn't created intentionally and in
> > > that case don't log an error.
> > 
> > Your point is somewhat valid, and I might Ack this. But this really
> > shouldn't be happening a lot. Can you give more context on how you are
> > hitting this?
> 
> Of course. I'm seeing this on the mt8195-cherry-tomato-r2 platform.
> 
> The following error is printed during boot:
> 
>   mediatek-drm-dp 1c500000.edp-tx: Failed to create device link (0x180) with backlight-lcd0
> 
> It doesn't happen with the upstream defconfig, but with the following config
> change it does:
> 
>   -CONFIG_PWM_MTK_DISP=m
>   +CONFIG_PWM_MTK_DISP=y
> 
> That probably changes the order in which the MTK DP and the backlight drivers
> probe, resulting in the error.
> 
> One peculiarity that comes to mind is that the DP driver calls
> devm_of_dp_aux_populate_bus() to run a callback once the panel has finished
> probing. I'm not sure if this could have something to do with the error.
> 
> Full log at https://lava.collabora.dev/scheduler/job/14573149

Hi Saravana,

With the given context for where this issue is happening, what do you think
about this patch?

Thanks,
Nícolas

