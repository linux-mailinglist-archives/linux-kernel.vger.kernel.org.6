Return-Path: <linux-kernel+bounces-414104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2F59D2318
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03AF5283438
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78E419D06E;
	Tue, 19 Nov 2024 10:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="NB5vTJCj"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7B6198A35
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732011037; cv=pass; b=QYB2RORKwfDCFcuYxhDy/pdx5Hb2f7z7T3BQQQFndOb5+RtfOe2zNsBbh3ol+AKFWmsXebVKmL9XIqYkJVf6eJ6Z9cCHa1h37q225iKexkwIx3EC+7Ruu+LDli0vMBr9ziLUPL1ue8yriWsYSZRQsQ3wd4zqaE1tkmWmGCbWnjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732011037; c=relaxed/simple;
	bh=i0HOapN3rTcgw4EcFbcQRZrtw0MRyS0bQk/ols/mr7Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RqBW/7eJmjl5Gih0NHlvIp/REuq6hDoXyFrMmjdJ/TYj4jAdJ8kyXvxo10YAv4gCuNsmXYKu2tiBBHPuyfX9dP27RKDl5keEkYxXdItZvkbNPw4/BvSZO05b/yOb5Ue71mkbR4E9RqmKKvHrZIDUV9LG5Xk3p94h6pR/FIY5qr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=NB5vTJCj; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732011022; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QgPah7K7zl9Ui+n9l4278FXGNH/QF3ZF4pW4d90gxh1p5OsYYTIzM9eCgpdweH70zXRxGIC2lqWObcvkLpAvIsT6MioIY28rWR6p5CxmOzq56ajXlbIA90MLntkUY0T/M9stUHe/wHOk8M/gmopXjznav6U8nG4XBmtrcWy2XIU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732011022; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=k+g8j3F1tme4NsTxUII9r7aUoMjsICad4Xf/8UTilxg=; 
	b=NaaN0M9K4boonOB0pNZ1nDCIi99WnKkRlxlSwwPaBcTv3xR7Ubw/zdA+nolRspTnFpEt/mIUqAPoIYkx0MxTTMQLZVwVqkK9VCzunGRBU1I716EdCn3e5XatmH8GY5yb+7Msvf1NJJsAAEXbpf5CFszbznsJAtNau/Iw/H7HY5c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732011022;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=k+g8j3F1tme4NsTxUII9r7aUoMjsICad4Xf/8UTilxg=;
	b=NB5vTJCjNICX6Zr6b+KJwtUDlxov3AJDecviu21IuVOGxyf/Sj0CE64/THkPorjW
	IOmN4nUGZuz7m1BIDpgbtbgaeJYhb+2w6ka9sTpS2K+GpaMJE43SGUB5TVOMgLmtcOS
	nDQ14sU4m3PaZMh4NiHp8WaikVJnAbh2pIG9OaD0=
Received: by mx.zohomail.com with SMTPS id 1732011019170470.81764662086744;
	Tue, 19 Nov 2024 02:10:19 -0800 (PST)
Message-ID: <b3ac96de-8782-409b-8652-3415fa4c9f38@collabora.com>
Date: Tue, 19 Nov 2024 13:10:15 +0300
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

Applied to misc-next

-- 
Best regards,
Dmitry


