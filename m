Return-Path: <linux-kernel+bounces-343274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A17CE989900
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 03:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54A821F21AEB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 01:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F255263D5;
	Mon, 30 Sep 2024 01:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJvM3ifZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5736D15C3;
	Mon, 30 Sep 2024 01:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727660698; cv=none; b=ZoFQF3N88gxe1QVz+6bKeXuJJILhd1LyRS5Og4XeabF2ilSefeTzORvs8NHRDaUjjiI9Og03XDD1poB9P8UEelAz9oHKWNs2HQtt9S/H37M7wTnZfYDSUK1xze2KN8ZfGjZJswdCDaVkNjQIusEpBffjRvdaIXH5aEOyVz0KOjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727660698; c=relaxed/simple;
	bh=+ywpN1hDCN9fASlkN+6O9aIiu5Jb04ujXzcqkNzfXQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4lg4ivGLW6FCM11SavEZAbI0Q36I8WoL0zUykVv5bWLOcAEsy+zlFdQ4u9xbIReDOGY5A63eqNDTcVEykz+OgdYSsbjVKnYUI8jFt7BgL2sTTMpalEXLlHZN/wdaVGvTq+wFCXcmjaCVUoELVI4hIWYtwknTNldR4kBEtyvlmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJvM3ifZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E7BC4CEC5;
	Mon, 30 Sep 2024 01:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727660696;
	bh=+ywpN1hDCN9fASlkN+6O9aIiu5Jb04ujXzcqkNzfXQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AJvM3ifZvu8grGOPE3vToZa70kman3X3CFEA9tUl3xLAJXGvT6tmoRAUgJNfnISoW
	 RAEM8Ml7IwLQ+7A7a5c0OMl+rRbZ7xePfqmnQ5+XTrk2w/xc2qU5Ky5EyoGVgiGjGn
	 QN85zLrzDSJTqqnfV3yR4agplLQbvw3Bb87erA43PJsaSJVVFKquC8y6TBAwIU16Iz
	 0lPoYqQ6ISCzPyU40SF+XpqAGmODIs0IA3uWUORyTrFnBh7KakzoBuckjGI0kFFAzV
	 /2ygWUXfcD9Di23b6zHDKd/817C8S95VsYOiTmyoQ85fwO00xlCszKWMS1mo1b9ZCx
	 CruDd3erULKYw==
Date: Mon, 30 Sep 2024 01:44:52 +0000
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
Message-ID: <ZvoClJ8lqwH0Bdbj@google.com>
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
> This is v4 of a fix to prevent both coreboot and sysfb drivers to register
> a platform device to setup a system framebuffer. It has been converted to
> a series since contains changes for both drivers, to prevent build issues
> on architectures that don't define a global struct screen_info.
> 
> Patch #1 adds a sysfb_handles_screen_info() helper that can be used by
> drivers to check whether sysfb can use the data set in screen_info or not.
> 
> [...]

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-firmware-next

[1/2] firmware: sysfb: Add a sysfb_handles_screen_info() helper function
      commit: 6074e905023d09f64f2c896f475820a5623deb2c
[2/2] firmware: coreboot: Don't register a pdev if screen_info data is present
      commit: 67f488dff17e535ac3a8a52b47ff1363d8134983

Thanks!

