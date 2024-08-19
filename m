Return-Path: <linux-kernel+bounces-292711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20AD95734E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 20:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CB70282279
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAA74642D;
	Mon, 19 Aug 2024 18:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="XGzQeY/n"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B828187859
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 18:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724092322; cv=none; b=GwXZPLrRn8Lc5gsj5XHFyIxk+v/xLJvL3a975d6V6+iyjOhpYpX8gwYtzWEk4aekcr7Va86bhC5YBzE8psX06ndxoWOY3HqCrujxb7kJQorNVmb1Smi1SASK/l20QElgwOLjIJtEmtOXaGSIlryliPyfnMOFpXaB7Pqx3pFGfy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724092322; c=relaxed/simple;
	bh=nN+02BORUmu8AW+VDg5ihHazNdGoAb+E0EBL91hES1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdB1Lar3cjVxZd6Cs6EFT2jHPJtthgPl7lPnQexB5tkRinQtdYmLnpAxwQkzoOrcsTYun0psSAhFg6ulCSd+vfgxvUNqEhF8iiPVC9T5DwM0nk16L/S75VLslrmMCf+312S4dQXTKF6SRFQoPyDi6dJBoqbXXqJ/+QHQLj50oDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=XGzQeY/n; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1724092310;
	bh=nN+02BORUmu8AW+VDg5ihHazNdGoAb+E0EBL91hES1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XGzQeY/nLMZ3EX1gs6dxRr3gqfowOv7gwV6HAOwF1Kb0+NOFaxVXPM9Ty2asI8LmP
	 CJsFsNOGZZMkpXNHmOeOjU7OkE7u2yG6cQXOsS0vrUeAMyrfsaAL84Bn+W5UDsbsUy
	 lCIlUHLO4srw9DlwNEraLnNrFZplcVV0RCwk8G24=
Date: Mon, 19 Aug 2024 20:31:49 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, jinzh <jinzh@github.amd.com>, 
	Aric Cyr <Aric.Cyr@amd.com>, Alan Liu <HaoPing.Liu@amd.com>, Tony Cheng <Tony.Cheng@amd.com>, 
	Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] drm/edid: constify argument of drm_edid_is_valid()
Message-ID: <00438587-4e9c-411b-bc67-82cabf251c8a@t-8ch.de>
References: <20240818-amdgpu-drm_edid-v1-0-aea66c1f7cf4@weissschuh.net>
 <20240818-amdgpu-drm_edid-v1-3-aea66c1f7cf4@weissschuh.net>
 <877ccc7wji.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877ccc7wji.fsf@intel.com>

On 2024-08-19 11:21:21+0000, Jani Nikula wrote:
> On Sun, 18 Aug 2024, Thomas Weißschuh <linux@weissschuh.net> wrote:
> > drm_edid_is_valid() does not modify its argument, so mark it as const.
> 
> That's not true.

Indeed, thanks for noticing.
It turns out this patch is not necessary anyways and I dropped it for
the next revision.


Thomas

