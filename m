Return-Path: <linux-kernel+bounces-413386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70E49D1869
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 306F9B21F1A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAF51E102A;
	Mon, 18 Nov 2024 18:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mEh5cXJn"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452F41B6CEE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 18:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731955770; cv=none; b=BRKXdOWqjY1fmnUpbAhNeuTKlAhE5xKMOaI/V+kBLvI4DO0dt0Jtd9K92J0lqsSaIvNkCgwj3GgwXRAjLgpnUl2JgjQLojy3CJcgPvrqWv/HAZA3UjKR/S+OdJaW6SX4vO2QNpO9wYPYU9Db2/Jk2WPIPpxIGmgakyOnxgJSQ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731955770; c=relaxed/simple;
	bh=sHjOjIV34KsZGtZ/zjzMSiN1M/5KHIuOkaM3tZZMCPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaAYoLSHph06NjegNVBed1M54vzBd0GPozN1CQ4H85YY6cjuuMO5EMphxO+txYJxVOlaFhKgBhFQuFs+CVyvLnwtM1Jwd94mrftVPxmPymrwllP+b3c5l6HZLmpLqfcHKtNVDeZ62JUWkhYbxmlvgmyyxauztsdVJBpoYZPY2HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mEh5cXJn; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5473360003;
	Mon, 18 Nov 2024 18:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731955763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Md1XUrZaQM8/jX11ObZtCSxOQxVCCrmEMdjs84Baes4=;
	b=mEh5cXJnrg96erKoIGcKlzeyn8C0TWy83D5ONLqkm9aUJrtN10zIfBLpvGXxGJmkgzrBR/
	dnTiNZkxql2OMHArGUcv5qSZ9Rhtc+jZS324nd/y5cJHdVQE+0Easl9GWFJPV6FP9KEGOW
	1dGweJARRLwVPao13GcIDib2aCBSd5VceEX8H6pSU6sdCKn+Wku9xRpa7LGveS7DbnQWXW
	Kj4pv++b4v2h7zHc9qxT8mo0BY1PO4a6WtZXnuQVD8XRB49A7U0Qtmjvmp77ixixt0NMs2
	iBkgdhqCDZVR1eHh/iae9MQl0ZmjgFYZngxMX8gHdgGqkeJBoi2sHnyVMN+y9w==
Date: Mon, 18 Nov 2024 19:49:19 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, rdunlap@infradead.org,
	arthurgrillo@riseup.net, Jonathan Corbet <corbet@lwn.net>,
	pekka.paalanen@haloniitty.fi,
	Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com, seanpaul@google.com,
	marcheu@google.com, nicolejadeyee@google.com,
	Pekka Paalanen <pekka.paalanen@collabora.com>
Subject: Re: [PATCH v13 0/7] drm/vkms: Add support for YUV and DRM_FORMAT_R*
Message-ID: <ZzuML6-OZZjBrTfb@louis-chauvet-laptop>
Mail-Followup-To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, rdunlap@infradead.org,
	arthurgrillo@riseup.net, Jonathan Corbet <corbet@lwn.net>,
	pekka.paalanen@haloniitty.fi,
	Simona Vetter <simona.vetter@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com, seanpaul@google.com,
	marcheu@google.com, nicolejadeyee@google.com,
	Pekka Paalanen <pekka.paalanen@collabora.com>
References: <20241118-yuv-v13-0-ac0dd4129552@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118-yuv-v13-0-ac0dd4129552@bootlin.com>
X-GND-Sasl: louis.chauvet@bootlin.com

On 18/11/24 - 19:43, Louis Chauvet wrote:
> This series depends on [1].
> 
> This patchset is extracted from [1]. The goal is to introduce the YUV
> support, thanks to Arthur's work.
> 
> - PATCH 1: Add the support of YUV formats
> - PATCH 2: Add some drm properties to expose more YUV features
> - PATCH 3: Cleanup the todo
> - PATCH 4..6: Add some kunit tests
> - PATCH 7: Add the support of DRM_FORMAT_R1/2/4/8
> 
> [1]: https://lore.kernel.org/r/20241007-yuv-v12-0-01c1ada6fec8@bootlin.com
> 
> Changes since previous series:
>  - Fix build test as modules issue: https://lore.kernel.org/all/202410110407.EHvadSaF-lkp@intel.com/
>  - Export required symbols in DRM core to use them in kunit
>  - Update the kunit comments according to Maxime's feedback
>  - Link to original series: https://lore.kernel.org/r/20241007-yuv-v12-0-01c1ada6fec8@bootlin.com

Sorry for the mistake, it is not a v13, but a v1, I think I did something 
wrong with b4.

Do I need to resend a v1 or just continue the numbering with v14, v15...

Sorry,
Louis Chauvet

