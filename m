Return-Path: <linux-kernel+bounces-412044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 590AF9D02E0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 11:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB396B245B0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 10:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4483148FF9;
	Sun, 17 Nov 2024 10:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="EKn4T1pr"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5AA126BE1
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 10:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731838364; cv=pass; b=g92VMVwI+er8ZszQcjK8uZ/zsC9Z0L2gFRsWcSecrJSOkbKk91YPKnkezJ6wcR2EBj9YFxnQ6dG3Q6ao800CXwy49/VTh1tHt9pMR0aeMSbuuLQRyipBrJlyz4vvj/oR+6VC7abxDGwkZpv/vnwsyXVq3v6zcC202PRdBGVgMcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731838364; c=relaxed/simple;
	bh=COC4AXIAMGgL2V1tvx/F3zUoMKR7um242+AN379LMLc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WBbqATtBKJXDiLNW/jnIBlkp6vUTBRYpDuBtQ5KczkcsCY/SJjPZp5XbgsH/Us0Adw70CIpMab8xsi4z7OsvX0Vpz/A0CozMYjfag0dllVTKGejizX6E91OG7CVyLgMmsXdOOd2tym0AC51QfZuNQHTx9mnRh2ftcEHoGkoNuEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=EKn4T1pr; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1731838348; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=X+zxJWmi5XcrAt9Syuy3AbW1nqUGiBsBdZOM2AefM5OoRGb90xRjgf3MqaLcreL5Sv4JD+E8rJNLvEhRz0qt5CgDj/6QAZNSXU/8IHWUphYyXqYTSbdACOwZNXGFmRj5iAlIFqCTfxUzY94/G1ygrXB8KZhxDW0PmskmblIJTjQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1731838348; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=p+Q9j1H2TcIZ5wUIQFlxPINvU3LciyJ6lugOfHoKu/Q=; 
	b=VZsukdiRSgiIPmC740aaHvCF0u4OJ6br5gt46T/Nw338zFRwfU5rTdM4L2b3TU84tOe6529+2RQGZ7evw2cZulCVx1nLeTmQNhRbrx8KP3g4+t4Vw3ga9OECmsdEN1f0unRQqEPVvJu1cq9lM2TiCdCU5g+voxVuo6JFxcgrt6Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731838348;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=p+Q9j1H2TcIZ5wUIQFlxPINvU3LciyJ6lugOfHoKu/Q=;
	b=EKn4T1pr9Livl1Wj4NWHfxPnG0DGETilUbjxWoWC5Wd9DsKItRBGoLIaRwjBZXD3
	iqQj6kBelbL4Z6KhIl4eEQZdOtyDQBdvdxr8xwNY72SAGdk+3JgD1Ulhoz/uZ44TQY4
	dPShlVtIwVGKkkS5rP9fLPXgpoktkVLLr0uIHSIQ=
Received: by mx.zohomail.com with SMTPS id 1731838347023660.0767784708986;
	Sun, 17 Nov 2024 02:12:27 -0800 (PST)
Message-ID: <cb58f26a-f153-4715-8b70-ee1ae99c9cad@collabora.com>
Date: Sun, 17 Nov 2024 13:12:23 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/virtio: Don't create a context with default param
 if context_init is supported
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Rob Clark <robdclark@gmail.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
References: <20241020224725.179937-1-dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20241020224725.179937-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/21/24 01:47, Dmitry Osipenko wrote:
> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> 
> Xorg context creation fails for native contexts that use
> VIRTGPU_CONTEXT_INIT because context is already initialized implicitly
> when dumb buffer is created. Fix it by not creating default vrend context
> if context_init is supported.
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_gem.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

I'll apply this patch tomorrow if nobody has more comments to add.

-- 
Best regards,
Dmitry

