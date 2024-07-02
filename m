Return-Path: <linux-kernel+bounces-238502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9B4924B56
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9652B1F258AA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B12F17A593;
	Tue,  2 Jul 2024 22:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="udoeiUia"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E037717A581
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 22:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957722; cv=none; b=ZAI7vZ80A6voPWN2j01tAdf8nOx5q/3oxGH90HiLzjqVq7uzA9yzSIpP0tXdrGZqGDvZ5KAeLoyukfSUneOZSYwn1Pmvmf+CIT7J62fJj+rXr9+VU7bf28hoSNHv/EFqOvmgqXAaOGEvlhwuqSBLQbhjmgZEgH5wHaLTMtmWmew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957722; c=relaxed/simple;
	bh=OGbXN1DliwtyV9y3GU4G+q5MRgG57dh5AMBb96zLdB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIXLQDMaK17X4VKL9FHS7RO3e+2lO18ih8E3eMeu3M5WhJCNlNfw9hUiq3+C9cCnejBJWuGF5ycTUiuy1ej36Z3kKIBRPJTnAHL/ROZsQh5uK/Jb7tLxqFt5fFRbzzMRI4TLoalUShg063l+xxNGn17ZNX15pXyDn2gv37nNT6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=udoeiUia; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+oxTSSdZwv+UuaWkkLuhqR4w8qk02qD4cr483Kkf16w=; b=udoeiUias1syre/FNjNSV2LlOi
	heheL/iANLz0Za42q9f2KhqGNygo/K8s08JOpW7ExTbEGg1Tx87+RytELdg0s03fVrlq48InWKabC
	ofU02ALaGSbeKJ/ZuWBTX6xnGwRU1BMJi0fIbgWkTMYxMptN5MqfXos9KvjKeENIWligzvIC/4rrh
	Jghrr4RGeIDKvycKMO9wUaCS4dVV/pg2pnvarMog9hg202kJvZEXceRc8RXJRpQiRcZTFQNLfHmM1
	qtxqou8o+j1HG0RiBJFsCauDsY28Tpdl5yY9r1ABkkTarBxDiDTgBvhHQZ7aBMuxS21v+UHLOwjM5
	HNKHgruQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOlZS-000000086Vo-48mn;
	Tue, 02 Jul 2024 22:01:54 +0000
Date: Tue, 2 Jul 2024 15:01:54 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com, ville.syrjala@linux.intel.com,
	jbaron@akamai.com, gregkh@linuxfoundation.org, ukaszb@chromium.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, linux@rasmusvillemoes.dk,
	joe@perches.com
Subject: Re: [PATCH v9 00/53] fix CONFIG_DRM_USE_DYNAMIC_DEBUG=y
Message-ID: <ZoR40nWmpEV2Ly_6@bombadil.infradead.org>
References: <20240702215804.2201271-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702215804.2201271-1-jim.cromie@gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Jul 02, 2024 at 03:56:50PM -0600, Jim Cromie wrote:
> This fixes dynamic-debug support for DRM.debug, added via classmaps.
> commit bb2ff6c27bc9 (drm: Disable dynamic debug as broken)
> 
> CONFIG_DRM_USE_DYNAMIC_DEBUG=y was marked broken because drm.debug=val
> was applied when drm.ko was modprobed; too early for the yet-to-load
> drivers, which thus missed the enablement.  My testing with
> /etc/modprobe.d/ entries and modprobes with dyndbg=$querycmd options
> obscured this omission.
> 
> The fix is to replace invocations of DECLARE_DYNDBG_CLASSMAP with
> DYNDBG_CLASSMAP_DEFINE for core, and DYNDBG_CLASSMAP_USE for drivers.
> The distinction allows dyndbg to also handle the users properly.
> 
> DRM is the only current classmaps user, and is not really using it,
> so if you think DRM could benefit from zero-off-cost debugs based on
> static-keys, please test.
> 
> HISTORY
> 
> 9/4/22  - ee879be38bc8..ace7c4bbb240 commited - classmaps-v1 dyndbg parts
> 9/11/22 - 0406faf25fb1..16deeb8e18ca commited - classmaps-v1 drm parts
> 
> https://lore.kernel.org/lkml/Y3XUrOGAV4I7bB3M@kroah.com/
> greg k-h says:
> This should go through the drm tree now.  The rest probably should also
> go that way and not through my tree as well.

Can't this just be defined as a coccinelle smpl patch? Must easier
to read than 53 patches?

  Luis


