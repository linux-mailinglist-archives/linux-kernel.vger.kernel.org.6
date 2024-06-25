Return-Path: <linux-kernel+bounces-229012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786969169B5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3488F289761
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31E217B513;
	Tue, 25 Jun 2024 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UJtbz/HE"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581DC16C848
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323770; cv=none; b=Ub1IskWLF0rJ1b8/MGTcJTWSrw4CsKnNTRR0F9kb4AImJsr5hdkzMJZXIINgmX0Zwwemi/NtnL50wrkMbIK0nAhamVV2CVN0dhVdkfEeUZa8rR6Ikv8hGmtUL0PY/MNP9DUUQS97QzmE1t4+Uj5CztWTp/p2vdU8jqlpmnyIbuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323770; c=relaxed/simple;
	bh=N/GcuY4Cw8pw/Sd4Waa1G9Xsbo2qSz5pa7LKIs8nARU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nbyt0GKFWEx07CxLky9hzoOxDfC44qSVr1wI/0Sqdp/CS+S0Pb3DFXud4cdI7oPUeBzdE4NsbcxWk/2khS1Mf8aeazYjFnWTs1UPq4VK3xvKDjgX92wBO9IhwX3BdFVfK7fkE1hO98zVPJ9vHvd5HhLQ8nEL+ijSTjIwvycJTDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UJtbz/HE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719323767;
	bh=N/GcuY4Cw8pw/Sd4Waa1G9Xsbo2qSz5pa7LKIs8nARU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UJtbz/HEdA3B5CDzeUTSkagFj7Zlvori9d5RW/voFWgy1TKTnpQW2iNARo+9GTN1R
	 byK6am13gsZ1gJpJcIle6jkCHRTUpKwJ8kjzFHXpYgm2jPN354bGkdkAcZYRlfkP4E
	 kPOndyBgTP8/mmiqHD90wQIPhtbFScAOiXcwSiQqG/E7gW9AT1E8xvQTlavG1KYOsp
	 lBJKnoAcgiNh7mYC7JGhL0EnFPNLVDzYxfpK7pBibcX8QXObnKd9bsySV5MNsDaCfe
	 9DsiK51liYMhv79vaS4YSgBGJKzTVP91IrJG1fzeAbKFui5XJf3goz9xrCFJwk8LVJ
	 LNCLCybZjlLKw==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0D759378000A;
	Tue, 25 Jun 2024 13:56:05 +0000 (UTC)
Date: Tue, 25 Jun 2024 09:55:56 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, kernel@collabora.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Don't log intentional skip of device link
 creation as error
Message-ID: <7b995947-4540-4b17-872e-e107adca4598@notapiano>
References: <20240624-fwdevlink-probed-no-err-v1-1-d1213cd354e2@collabora.com>
 <CAGETcx-sAu-wMDKT9zCeCzLzZ=ZdvK+CSoX34YxMLd5z0YeVZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx-sAu-wMDKT9zCeCzLzZ=ZdvK+CSoX34YxMLd5z0YeVZQ@mail.gmail.com>

On Mon, Jun 24, 2024 at 04:53:30PM -0700, Saravana Kannan wrote:
> On Mon, Jun 24, 2024 at 8:21 AM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
> >
> > Commit ac66c5bbb437 ("driver core: Allow only unprobed consumers for
> > SYNC_STATE_ONLY device links") introduced an early return in
> > device_link_add() to prevent useless links from being created. However
> > the calling function fw_devlink_create_devlink() unconditionally prints
> > an error if device_link_add() didn't create a link, even in this case
> > where it is intentionally skipping the link creation.
> >
> > Add a check to detect if the link wasn't created intentionally and in
> > that case don't log an error.
> 
> Your point is somewhat valid, and I might Ack this. But this really
> shouldn't be happening a lot. Can you give more context on how you are
> hitting this?

Of course. I'm seeing this on the mt8195-cherry-tomato-r2 platform.

The following error is printed during boot:

  mediatek-drm-dp 1c500000.edp-tx: Failed to create device link (0x180) with backlight-lcd0

It doesn't happen with the upstream defconfig, but with the following config
change it does:

  -CONFIG_PWM_MTK_DISP=m
  +CONFIG_PWM_MTK_DISP=y

That probably changes the order in which the MTK DP and the backlight drivers
probe, resulting in the error.

One peculiarity that comes to mind is that the DP driver calls
devm_of_dp_aux_populate_bus() to run a callback once the panel has finished
probing. I'm not sure if this could have something to do with the error.

Full log at https://lava.collabora.dev/scheduler/job/14573149

Thanks,
Nícolas

