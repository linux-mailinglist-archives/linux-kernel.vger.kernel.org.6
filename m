Return-Path: <linux-kernel+bounces-217695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F124490B311
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7117F1F20FD1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C6973441;
	Mon, 17 Jun 2024 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="AaGlxD7c"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E7D71B3A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718633072; cv=none; b=SeUrMbrWBJWIzdpypbLl/uIvUXglbPao4vTLSQStSDqjXY5ZKiQWrS+T7oEmFIfaMtgDxFGO68+bg0EAWVHBQWh8MZ/cX6DmBpgnBAlg3KmfeV//8wM0VEqtlBPa5bvW2Pi9FGUG3E+zeHMwGS+7zhwFRtXYfSZm4AZO5k+hSsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718633072; c=relaxed/simple;
	bh=wIbmS+5ZXl1zfzS0/V6d3ixGLviRxz726rKH6gdq4s0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLvnSUNjD6aIxPeWcBHsZqk+bqYYGFvReuPq1YXCywBNxfLADpIWz4+p7WsUIub1W42OzoU9fe/9wuyGQxpw7M+P7V1Vc3P8N0N/RvQ1q3g4yCmJO0lrDeNPVbLE+T9Ro8aoF9BMQNNrUTD3qfXNy5hZUAbd0XR85H8B28NPNjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=AaGlxD7c; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52bc0236f04so600348e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 07:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1718633069; x=1719237869; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkRa5H16FO2uFUjvCQaacs/JeuEyTdLmBVpml2zQQBU=;
        b=AaGlxD7cASHDAbef9PJwEVih9BBuDQGb2sbRj96wtcQDvwcaj/oQPoHNFchyK0infm
         wrrn79fiqTwNuQwNcNj5Ob0EemQtMODP/mhD/CL7gPs+K0vQ+1tXuCLmOKqx/zwdGXBC
         TK4gNciWFZqcOlBlHKH46BhT+062PKbqBOtKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718633069; x=1719237869;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZkRa5H16FO2uFUjvCQaacs/JeuEyTdLmBVpml2zQQBU=;
        b=Uu7AzxIOXgskp/oJTE7jZf1r6totT8+40rVGzjqIcJzO0AgDsZjJU8RbPwWsYSkVhW
         /xF+zwNks92RC+L0XVdiB1LkYmOPl1Dx5KioURUL+tznXZxzVffoSxnG517b9NcZUxCM
         VM/CyuEQgh8Qk1ul+2ew1XvOCxLxiWhRD6meIWJaYTvbqqP0P3YZoMegQ0DeFOoJJjct
         q48PFocL8O6XC+ZXxn3ZWXgG9hbc6khBV/lXTgG4WiNPUHMOdcSiyTnbTT7myKrLrGEL
         lTu3GTrooARAWG6WIkz7tAXthG59q4592QVznZHqBB/RslsjwnEf0nxJ3/no/lTZKzq2
         NILg==
X-Forwarded-Encrypted: i=1; AJvYcCXW+2lGB3X3GcPifGjxNkkNbXO9yZ2C1Yr+6RH157ogcJhOJddZupuggU6Zgx2YdddKnU/05fS9UDoGRsiLQ7AN37vNo5fUbO3EDehZ
X-Gm-Message-State: AOJu0YyLnqONNxCKKVynnYc3rP3QsQ8VfWzDsrQapvkTrmcvsMPHIMEO
	U08/xHNjflDF9qnjohAadDE4mbt3RhrnBAuYUowMRwBliz1bUnzdk/bc+ODZ1r/TWSZDl2KhqQL
	r
X-Google-Smtp-Source: AGHT+IEj0VoTUmvM6ZRPstNnvIp1hc3ZMVJzBzlBdGBU8wtbWGv2aF9hkwN1PTkvfVg/5SNeumrNMw==
X-Received: by 2002:a5d:5f52:0:b0:360:8490:74d with SMTP id ffacd0b85a97d-360849008a1mr6127742f8f.5.1718633048487;
        Mon, 17 Jun 2024 07:04:08 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750ad10esm11810049f8f.64.2024.06.17.07.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 07:04:08 -0700 (PDT)
Date: Mon, 17 Jun 2024 16:04:06 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>, Peng Fan <peng.fan@nxp.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/fbdev-dma: fix getting smem_start
Message-ID: <ZnBCVg_tblwJhOIH@phenom.ffwll.local>
Mail-Followup-To: Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>, Peng Fan <peng.fan@nxp.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240604080328.4024838-1-peng.fan@oss.nxp.com>
 <8f4a6d80-dd3e-422f-88af-d26f50c973ff@suse.de>
 <e307fdc0-553d-4946-9017-ed3a28e9cae2@suse.de>
 <87cyomsiqt.fsf@minerva.mail-host-address-is-not-set>
 <14a7c534-af3f-43b8-a24c-501a9af97936@suse.de>
 <Zmm4HSkia-x_oRWR@phenom.ffwll.local>
 <e1aa9785-6833-4bbb-bed7-2e01ee9634c6@suse.de>
 <209a99c3-6d44-4abc-a486-8e6d0a0c7370@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <209a99c3-6d44-4abc-a486-8e6d0a0c7370@suse.de>
X-Operating-System: Linux phenom 6.8.9-amd64 

On Thu, Jun 13, 2024 at 12:18:55PM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 13.06.24 um 12:14 schrieb Thomas Zimmermann:
> > Hi
> > 
> > Am 12.06.24 um 17:00 schrieb Daniel Vetter:
> > > On Wed, Jun 12, 2024 at 10:37:14AM +0200, Thomas Zimmermann wrote:
> > > > Hi Javier
> > > > 
> > > > Am 12.06.24 um 09:49 schrieb Javier Martinez Canillas:
> > > > > Thomas Zimmermann <tzimmermann@suse.de> writes:
> > > > > 
> > > > > Hello Thomas,
> > > > > 
> > > > > > Hi
> > > > > > 
> > > > > > Am 10.06.24 um 10:47 schrieb Thomas Zimmermann:
> > > > > > > Hi
> > > > > > > 
> > > > > > > Am 04.06.24 um 10:03 schrieb Peng Fan (OSS):
> > > > > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > > > > > 
> > > > > > > > If 'info->screen_buffer' locates in vmalloc
> > > > > > > > address space, virt_to_page
> > > > > > > > will not be able to get correct results. With CONFIG_DEBUG_VM and
> > > > > > > > CONFIG_DEBUG_VIRTUAL enabled on ARM64, there is dump below:
> > > > > > > Which graphics driver triggers this bug?
> > > > > > > 
> > > > > > > > [    3.536043] ------------[ cut here ]------------
> > > > > > > > [    3.540716] virt_to_phys used for non-linear address:
> > > > > > > > 000000007fc4f540 (0xffff800086001000)
> > > > > > > > [    3.552628] WARNING: CPU: 4 PID: 61 at
> > > > > > > > arch/arm64/mm/physaddr.c:12
> > > > > > > > __virt_to_phys+0x68/0x98
> > > > > > > > [    3.565455] Modules linked in:
> > > > > > > > [    3.568525] CPU: 4 PID: 61 Comm: kworker/u12:5 Not tainted
> > > > > > > > 6.6.23-06226-g4986cc3e1b75-dirty #250
> > > > > > > > [    3.577310] Hardware name: NXP i.MX95 19X19 board (DT)
> > > > > > > > [    3.582452] Workqueue: events_unbound deferred_probe_work_func
> > > > > > > > [    3.588291] pstate: 60400009 (nZCv daif +PAN
> > > > > > > > -UAO -TCO -DIT -SSBS
> > > > > > > > BTYPE=--)
> > > > > > > > [    3.595233] pc : __virt_to_phys+0x68/0x98
> > > > > > > > [    3.599246] lr : __virt_to_phys+0x68/0x98
> > > > > > > > [    3.603276] sp : ffff800083603990
> > > > > > > > [    3.677939] Call trace:
> > > > > > > > [    3.680393]  __virt_to_phys+0x68/0x98
> > > > > > > > [    3.684067] drm_fbdev_dma_helper_fb_probe+0x138/0x238
> > > > > > > > [    3.689214]
> > > > > > > > __drm_fb_helper_initial_config_and_unlock+0x2b0/0x4c0
> > > > > > > > [    3.695385]  drm_fb_helper_initial_config+0x4c/0x68
> > > > > > > > [    3.700264]  drm_fbdev_dma_client_hotplug+0x8c/0xe0
> > > > > > > > [    3.705161]  drm_client_register+0x60/0xb0
> > > > > > > > [    3.709269]  drm_fbdev_dma_setup+0x94/0x148
> > > > > > > > 
> > > > > > > > So add a check 'is_vmalloc_addr'.
> > > > > > > > 
> > > > > > > > Fixes: b79fe9abd58b ("drm/fbdev-dma: Implement fbdev emulation for
> > > > > > > > GEM DMA helpers")
> > > > > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > > > Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> > > > > > I'm taking back my r-b. The memory is expected to by be physically
> > > > > > contiguous and vmalloc() won't guarantee that.
> > > > > > 
> > > > > Agreed.
> > > > These smem_ fields are clearly designed for PCI BARs of
> > > > traditional graphics
> > > > cards. So can we even assume contiguous memory for DMA? That was my
> > > > assumption, but with IOMMUs it might not be the case. Fbdev-dma
> > > > only sets
> > > > smem_start to support a single old userspace driver. Maybe we
> > > > should further
> > > > restrict usage of this field by making it opt-in for each driver. Best
> > > > regards Thomas
> > > We could make it all conditional on CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM, and
> > > remove the FBINFO_HIDE_SMEM_START flag. The reason I've done the flag is
> > > that with the old fb_mmap code we had to always fill out smem_start to
> > > make mmap work. But now that the various drm fbdev helpers have all
> > > their
> > > own mmap implementation, we could make this a lot cleaner.
> > 
> > Enabling CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM would still crash the NXP
> > driver. I think I'll add a flag to drm_fbdev_dma_setup() to set
> > smem_start from within lima, which is the only driver that requires
> > it.I'd like to remove CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM and all that, but
> > I fear that it would break someone's setup. Best regards Thomas

Yeah we'd always need to make this conditional on the memory not being in
the vmalloc range, or things will blow up.

> I've been looking at
> 
> https://lore.kernel.org/dri-devel/20240318-dark-mongoose-of-camouflage-7ac6ed@houat/
> 
> and I'm now confused to find that lima doesn't even set up fbdev support.

The mali driver here was the out-of-tree proprietary mali driver as the
consumer of such buffers.

The "exporters" was just any random fbdev driver, and with the DRM option
to set the smem, also drm drivers could play in this role. It at least
seems to have helped a few people to move away from out-of-tree fbdev
drivers to upstream drm drivers (but still with the out-of-tree mali gpu
driver). Which means we've needed this for any display driver that
happens to have shipped together with one of these older mali gpus.

It's a bit a mess, and it might indeed have outlived it's usefulness.

Cheers, Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

