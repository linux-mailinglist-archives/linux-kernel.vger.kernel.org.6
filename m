Return-Path: <linux-kernel+bounces-557295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A80A5D6BB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 07:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DF3A18822B4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C211E9900;
	Wed, 12 Mar 2025 06:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qGtqUYxn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DC01E8847
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 06:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741762708; cv=none; b=ZWZ9PPNiKIomWpbdssoScgelu3lXZ0Y/5JPEUAun7hFAqMBB6GVCbOUhzQzzc0WJ8+2o4JXrzRpzj1Aol4sROb6fADLqIkqHOfvPSv/5JKvwrUNAH1iMA/tNRAj97sVpG/EmCTUA4OIm6DlcsN5gWmwCB3flJXVAwZC09tJNxjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741762708; c=relaxed/simple;
	bh=bodGugImFc3dt0PzMb7CQ0h95ZfzjMOgS6MLw9xG15Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbF3coOKU4+VEttsTrGZND9ie/Vs+ymL/q1B68IbuB2hFdoc7nWB43OhixA+HWTWmvMzHHu8zBpSjY7Flv6CR0lBU0P9LayLobs7le0flYoGKRrZWJtpc8kMlU2svbCgUO5aKviH2OTOTMqqc8zbXF2vab9aEcswpcTjwfWnFMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qGtqUYxn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA60C4CEE3;
	Wed, 12 Mar 2025 06:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741762708;
	bh=bodGugImFc3dt0PzMb7CQ0h95ZfzjMOgS6MLw9xG15Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qGtqUYxnvo3Lpu4TGMGb0qxw00QWKDutRFDwdhjwUGOWh+aST/nSoIsRYN3UZk5Zx
	 PgttiuSIn9GANQPYTHsLpvxu67dVLpgO3wp1aaAH4z3neSjOyN45jWAdkRD6mumExL
	 xMOIa1CEIcuhGnqwElkRF5Zi5C/ISxtPOsY5yR68=
Date: Wed, 12 Mar 2025 07:57:12 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] sysfs: finalize the constification of 'struct
 bin_attribute'
Message-ID: <2025031232-livable-onion-00c0@gregkh>
References: <20250219-sysfs-const-bin_attr-final-v1-0-02828d86af3c@weissschuh.net>
 <997b8f61-80f6-40e7-bc1f-3ee6294a06d5@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <997b8f61-80f6-40e7-bc1f-3ee6294a06d5@t-8ch.de>

On Tue, Mar 11, 2025 at 09:13:39PM +0100, Thomas Weißschuh wrote:
> Hi Greg,
> 
> On 2025-02-19 22:34:49+0100, Thomas Weißschuh wrote:
> > All users have been migrated to the new const types.
> > Change the types of the normal fields, switch all users over and then
> > get rid of the transition machinery.
> > 
> > This depends on the following patches which are not mainline yet:
> > 
> > https://lore.kernel.org/r/20250114-sysfs-const-bin_attr-cxl-v1-1-5afa23fe2a52@weissschuh.net
> > https://lore.kernel.org/r/20250125-sysfs-const-bin_attr-dmi-v2-0-ece1895936f4@weissschuh.net
> > https://lore.kernel.org/r/20241216-sysfs-const-bin_attr-drm-v1-0-210f2b36b9bf@weissschuh.net
> > https://lore.kernel.org/r/20241215-sysfs-const-bin_attr-fsi-v1-1-b717f76a0146@weissschuh.net
> > https://lore.kernel.org/r/20241216-sysfs-const-bin_attr-habanalabs-v1-1-b35463197efb@weissschuh.net
> > https://lore.kernel.org/r/20241222-sysfs-const-bin_attr-input-v1-1-1229dbe5ae71@weissschuh.net
> > https://lore.kernel.org/r/20241215-sysfs-const-bin_attr-mokvar-v1-1-d5a3d1fff8d1@weissschuh.net
> > https://lore.kernel.org/r/20241215-sysfs-const-bin_attr-pcmcia-v1-1-ebb82e47d834@weissschuh.net
> > https://lore.kernel.org/r/20241216-sysfs-const-bin_attr-powerpc-v1-0-bbed8906f476@weissschuh.net
> > https://lore.kernel.org/r/20250114-sysfs-const-bin_attr-qemu_fw_cfg-v1-1-76f525a3ee72@weissschuh.net
> > https://lore.kernel.org/r/20241216-sysfs-const-bin_attr-rapidio-v1-1-0f47f4719683@weissschuh.net
> > https://lore.kernel.org/r/20241122-sysfs-const-bin_attr-rci2-v1-1-3db1ec9aa203@weissschuh.net
> 
> All those prerequisites have been in your driver-core tree for some time.
> Do you want to merge the finalization series also for 6.15?
> If so, should I resend it for your convenience?

Please do, I thought I had caught up with this, if I've missed anything,
please resend.

thanks,

greg k-h

