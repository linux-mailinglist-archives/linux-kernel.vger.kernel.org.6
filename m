Return-Path: <linux-kernel+bounces-333181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9590397C500
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9E41F21C4B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 07:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAA4194C6B;
	Thu, 19 Sep 2024 07:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nS/18fNU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA732194AE6;
	Thu, 19 Sep 2024 07:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726731651; cv=none; b=rjyWnXpi2okYeB3lU5mVprWMuXD7yCCbDyl0jG+2MhZ2SfXyPE3xN1uy5iHZHKpXWrMMcXGfgjeEdWraXPLWd8/1T8FILhWV72HV3lnmmHTjUuqQFKUDr1TvsVCNgxZ1IN6kt504MR1n8xBiMRVS618niaQHbhya92PaJzORW3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726731651; c=relaxed/simple;
	bh=gQRmcFYRoZm4qHxTTfbTBJ7+y1B2sC1lIyz//eggaQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adihu1kTgkqWpqZuZAV0j78Fuyfw6N8vnKPnhu+9HpYb5uO+NgahqQUly9FhylXos8Je9N0m4XHPADZsYSWmo3X3dmvxpVMYlmJ6jKz9tUYhjNV53EjXlmCsF0kKNS9beDhlqNCW0wekUX93bMCxXmAG/bU1+oI1ZfAIadrzMWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nS/18fNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5344DC4CEC4;
	Thu, 19 Sep 2024 07:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726731651;
	bh=gQRmcFYRoZm4qHxTTfbTBJ7+y1B2sC1lIyz//eggaQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nS/18fNUL1PdRlVmyNDtvYHS6AhOhe/5hxZcv94zW9lArDJrF3hccwdRBbRkmbSMR
	 6A/znhPYqZguTWq1T/6AV3NZvXH9DjltxK2Fd76kh5VJNHbEOMqW36YjK6xevXx/uq
	 KSRbfk88WMjgBj6ESfCMB0Z5ObyrVXqrbyHgf85UGyyRARxi8WZkRlUZ4g1yk6hYBi
	 UctfmLg4Fa8Ta0HJf18F0uJ5XfEOizbSNVCDIIovKagdAoASh5gYpXKKBBT4sylrGD
	 GAvHs1NXe0BhAcDDONy8ZOWejRyKyL6yCQJojIjFaG679RwGObnjzdVrzI0TnDR+AD
	 b0ngA2VutG0mA==
Date: Thu, 19 Sep 2024 07:40:47 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
	dri-devel@lists.freedesktop.org, Borislav Petkov <bp@alien8.de>,
	Julius Werner <jwerner@chromium.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	chrome-platform@lists.linux.dev, intel-gfx@lists.freedesktop.org,
	Hugues Bruant <hugues.bruant@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Helge Deller <deller@gmx.de>, Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v4 0/2] firmware: Avoid coreboot and sysfb to register a
 pdev for same framebuffer
Message-ID: <ZuvVf5XRMqjD8G9T@google.com>
References: <20240916110040.1688511-1-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916110040.1688511-1-javierm@redhat.com>

On Mon, Sep 16, 2024 at 01:00:24PM +0200, Javier Martinez Canillas wrote:
> The patches have only been compiled tested because I don't have access to
> a coreboot machine. Please let me know if you plan to merge both patches
> through the chrome-platforms tree or if you prefer to get merged through
> the drm-misc tree.
> 
> [...]
> Javier Martinez Canillas (2):
>   firmware: sysfb: Add a sysfb_handles_screen_info() helper function
>   firmware: coreboot: Don't register a pdev if screen_info data is
>     present

I'll queue both patches through the chrome-platform tree for v6.13 if there is
no objections.

