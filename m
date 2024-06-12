Return-Path: <linux-kernel+bounces-211732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F83990562A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17C3F1C24992
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C5917DE1C;
	Wed, 12 Jun 2024 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LRd3yhTA"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A47E1DDF6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204451; cv=none; b=UEB3Adsg8KDZ7GPiWQqedjYXRHLV+rBPXX0FC/7TcoarUAT5hVMLgJTIzCvu92cCuNTJk69iuZIBjbN6OWXulZ9ZlDe/egS+YwbQ6y6nq0Qp/8oW+BT6E6TrTCpCxVDfy6jiEQ2/QB12/wfvyl67xPnn9I/o6ILnn+yas3iZIMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204451; c=relaxed/simple;
	bh=Tn8E0RJxVE72zdWYPLEmPNrIueTtsug4CMVf4uXYplM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMbOIWhkO+sjRUfAV4y3pIAyiOJLtt4NSEaDzHcnxKeiH2uWlImFMGjzoYG9jlQmilRDJG+TQ9Ognb5sgW64zwknUxNOVMyub25zujrxuhmRgc3pEBGCHjA17b4trbJq2g1WkTywTr2tB6+dejpKHMFDZsMy8GLJ7SepHj6LUcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=LRd3yhTA; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-35f0b9a1dd7so684939f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1718204448; x=1718809248; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vga4bYp9jxqSv9eCBMzwANuaNkrPnKBob/TvPmGImHU=;
        b=LRd3yhTAvWlO5g1OqGrjXf99GDXXQHdAeKDIu9jsNC21UjZyZY5RPg0/ju+cp5BE0c
         U/kylHsIVRXTTtueFVR8/e2PLuown7fdYl36THduqooJFe/OYBx3BVCf8r2/TTNn2EE2
         t7hucqY9ui+2UyGekTmqXHz5HJz1JT5oeykBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718204448; x=1718809248;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vga4bYp9jxqSv9eCBMzwANuaNkrPnKBob/TvPmGImHU=;
        b=r5CB1k/2q6WWZj5qfQZyhX5mNJp2GQVQNfmJtMqlhhnMu7uYa0o307G15ZyAIhPqPt
         M4dG0zLPzHBapDRvoQV4otTKRcWhYn9AqqY/M0rPi8Ja6g3E9Dal+fsSDcuG2xru7QMt
         ZDUFWvKtBI4Bk/33JME1WzJXP5MNAWxqdyKhssawfjdYQqPJHHiRVCFH288Mu7xUfRtP
         imb6Ji+xJmO1TY2/ndt6uRmvFdTKZKspwnPIp6my4g9Lf1pa8H35DBXjsZNxq+kkgxvH
         +VMM98aazk590D2bkCL/FuwOAIVs4cl1qvMBDBgOdN3QP44KCrZfyNSi1Hyi5uKApb7B
         C9kA==
X-Forwarded-Encrypted: i=1; AJvYcCVgDrfDnbhc0wNfqePjVkJC/CXZRt/2/fZVgtLyH3RJBBwKKdWjRHfSkEGKL89b1K4rOpkJBSJoA2VXPoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrDSxp7SZ7HQ/V2TxsZqVe17R/q/rHrSSf0qjJWTFhvgFsLLiF
	gIGea0SPCqCF52aIvJBIiBKXsmTqtjFK4ZGPYamO4yr2lTk1bYXs1xwBIxXeEGc=
X-Google-Smtp-Source: AGHT+IFSC1i2V0ypqWkq76qJSJvokwb8rd6Yp8fMrGyYSDy7uditWcjWH2yTATEfSucgGwiy+8PrEw==
X-Received: by 2002:a5d:59a1:0:b0:35f:2f97:e890 with SMTP id ffacd0b85a97d-35fd4b30419mr1419392f8f.0.1718204447552;
        Wed, 12 Jun 2024 08:00:47 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f25aa8fb6sm7982282f8f.92.2024.06.12.08.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 08:00:47 -0700 (PDT)
Date: Wed, 12 Jun 2024 17:00:45 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Peng Fan <peng.fan@nxp.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/fbdev-dma: fix getting smem_start
Message-ID: <Zmm4HSkia-x_oRWR@phenom.ffwll.local>
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14a7c534-af3f-43b8-a24c-501a9af97936@suse.de>
X-Operating-System: Linux phenom 6.8.9-amd64 

On Wed, Jun 12, 2024 at 10:37:14AM +0200, Thomas Zimmermann wrote:
> Hi Javier
> 
> Am 12.06.24 um 09:49 schrieb Javier Martinez Canillas:
> > Thomas Zimmermann <tzimmermann@suse.de> writes:
> > 
> > Hello Thomas,
> > 
> > > Hi
> > > 
> > > Am 10.06.24 um 10:47 schrieb Thomas Zimmermann:
> > > > Hi
> > > > 
> > > > Am 04.06.24 um 10:03 schrieb Peng Fan (OSS):
> > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > > 
> > > > > If 'info->screen_buffer' locates in vmalloc address space, virt_to_page
> > > > > will not be able to get correct results. With CONFIG_DEBUG_VM and
> > > > > CONFIG_DEBUG_VIRTUAL enabled on ARM64, there is dump below:
> > > > Which graphics driver triggers this bug?
> > > > 
> > > > > [    3.536043] ------------[ cut here ]------------
> > > > > [    3.540716] virt_to_phys used for non-linear address:
> > > > > 000000007fc4f540 (0xffff800086001000)
> > > > > [    3.552628] WARNING: CPU: 4 PID: 61 at arch/arm64/mm/physaddr.c:12
> > > > > __virt_to_phys+0x68/0x98
> > > > > [    3.565455] Modules linked in:
> > > > > [    3.568525] CPU: 4 PID: 61 Comm: kworker/u12:5 Not tainted
> > > > > 6.6.23-06226-g4986cc3e1b75-dirty #250
> > > > > [    3.577310] Hardware name: NXP i.MX95 19X19 board (DT)
> > > > > [    3.582452] Workqueue: events_unbound deferred_probe_work_func
> > > > > [    3.588291] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS
> > > > > BTYPE=--)
> > > > > [    3.595233] pc : __virt_to_phys+0x68/0x98
> > > > > [    3.599246] lr : __virt_to_phys+0x68/0x98
> > > > > [    3.603276] sp : ffff800083603990
> > > > > [    3.677939] Call trace:
> > > > > [    3.680393]  __virt_to_phys+0x68/0x98
> > > > > [    3.684067]  drm_fbdev_dma_helper_fb_probe+0x138/0x238
> > > > > [    3.689214] __drm_fb_helper_initial_config_and_unlock+0x2b0/0x4c0
> > > > > [    3.695385]  drm_fb_helper_initial_config+0x4c/0x68
> > > > > [    3.700264]  drm_fbdev_dma_client_hotplug+0x8c/0xe0
> > > > > [    3.705161]  drm_client_register+0x60/0xb0
> > > > > [    3.709269]  drm_fbdev_dma_setup+0x94/0x148
> > > > > 
> > > > > So add a check 'is_vmalloc_addr'.
> > > > > 
> > > > > Fixes: b79fe9abd58b ("drm/fbdev-dma: Implement fbdev emulation for
> > > > > GEM DMA helpers")
> > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> > > I'm taking back my r-b. The memory is expected to by be physically
> > > contiguous and vmalloc() won't guarantee that.
> > > 
> > Agreed.
> 
> These smem_ fields are clearly designed for PCI BARs of traditional graphics
> cards. So can we even assume contiguous memory for DMA? That was my
> assumption, but with IOMMUs it might not be the case. Fbdev-dma only sets
> smem_start to support a single old userspace driver. Maybe we should further
> restrict usage of this field by making it opt-in for each driver. Best
> regards Thomas

We could make it all conditional on CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM, and
remove the FBINFO_HIDE_SMEM_START flag. The reason I've done the flag is
that with the old fb_mmap code we had to always fill out smem_start to
make mmap work. But now that the various drm fbdev helpers have all their
own mmap implementation, we could make this a lot cleaner.

If I haven't missed anything, that is.
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

