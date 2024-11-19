Return-Path: <linux-kernel+bounces-414103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7209D2312
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14F89B22CD6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E031C2DC8;
	Tue, 19 Nov 2024 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="OkP1ImM9"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8295E1C1F07
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732010987; cv=pass; b=lvOWcpE764ZUqpWNx7OofZAxoB7eLeVoU8+9DWg9HkFo1fTmJbWgy/sO8YpleG900nVXryFlu7ecbr1O6X+BU+PpFs6OWftIL3vEa0yPnUvwjiuWim7rkJj3wYtTtUkuI5qx67pmtKu9Mze3EQ4kYu3tavMWIQgPdQRr4z0OvCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732010987; c=relaxed/simple;
	bh=9QksSgcUmyeQxxmt6p3IDH6bZxplk5QL+pClopM0Shc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BvitV0Uh0BGAKZltfI/76MR93y3hszxNhssG4xXbPzWVTzUkUMeFeGdHbHH0Hqmx2KPFR8NlzNwddNcSRav321yRE7qjQuf+jRGc4S9EZZcvUO9tHwf9JvmdpP2sgJ3ED8jkk2xq1+xROQ1WwVkDHRSlchwL9TwJxbptdpBo2Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=OkP1ImM9; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732010967; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OWJm+P8PpGSWkuVnY+dKdmOJr9QNXvLPig7omSmwHOAf2Zo28rBFbqGJSIg3VM2ZGGfOXtK3+r48G3u+vfXOMqmfgaCVEkPbu1HVoSkm2KQGM9+gL/rsxszwOW5YzZYIru4gDxXAfjDIV8GyComVqCRaogwapY1QdoFEQWqKdoQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732010967; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=6vObRq2E+RGALjKawt1r5dY6l6TVau1KQSOylOW2doo=; 
	b=WrCu9YOEuavHSUfdbGsj5jNaSqtEuCcmEa5ivP4DwTtt368Cy8oLRTyHrQbmlHzoVcRxDiduXGQhzEpv5XCTVMqOZ0Bt8h4L967OA6948OIddrgrnGSAztt5EvYNXvTpq2T3d2BToYd9mjwvtDwAx8ZrfZIVHuSS4GJJj7YHtpA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732010967;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=6vObRq2E+RGALjKawt1r5dY6l6TVau1KQSOylOW2doo=;
	b=OkP1ImM9vxIcIwxt+xg/n12ilQgxh2T795cbyPYaFS7F/WLvsiaDtfOA6K2Z8/v8
	ndFChntS9sFVWWvqVzFXHE5sIonmejkkKV2i+8ZHCYVjXdKCOoxvAzfCzA+njwRL7dS
	bw16/xBSgWeS//rdFVqP+83TvWFCXQhCESnCS1dY=
Received: by mx.zohomail.com with SMTPS id 1732010965656991.9554222257977;
	Tue, 19 Nov 2024 02:09:25 -0800 (PST)
Message-ID: <0c842e7b-5a49-404d-9647-311bfc37f003@collabora.com>
Date: Tue, 19 Nov 2024 13:09:21 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND] drm/virtio: use generic dumb_map_offset
 implementation
To: Peter Shkenev <mustela@erminea.space>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20241107141133.13624-1-mustela@erminea.space>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20241107141133.13624-1-mustela@erminea.space>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 11/7/24 17:10, Peter Shkenev wrote:
> Currently, virtio uses its own dumb_map_offset implementation,
> virtio_gpu_mode_dumb_mmap. It works similarly to generic implementation,
> drm_gem_dumb_map_offset, and using the generic implementation is
> preferable (and making drivers to do so is a task stated on the DRM
> subsystem's TODO list).
> 
> Thus, make driver use the generic implementation. This includes
> VIRTGPU_MAP ioctl so it cannot be used to circumvent rules imposed by
> drm_gem_dumb_map_offset (imported objects cannot be mapped).
> 
> Signed-off-by: Peter Shkenev <mustela@erminea.space>
> ---
> Changes in v2:
>   - Remove excessive include of drm_gem.h from virtgpu_ioctl.h
>   - Remove obsoleted virtio_gpu_mode_dumb_mmap prototype from
>     virtgpu_drv.h
> 

Applied to misc-next, thanks!

-- 
Best regards,
Dmitry


