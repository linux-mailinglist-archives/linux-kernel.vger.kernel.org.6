Return-Path: <linux-kernel+bounces-412045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E2E9D02E3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 11:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874A7286790
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 10:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3588714900E;
	Sun, 17 Nov 2024 10:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="g+oUauBf"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C255126BE1
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 10:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731838377; cv=pass; b=Z6DSI7r/YEXcZRsB004qp8S+xzMRErhEJicF+Lxz5IG374+Kw+O/eWcwmuqegtrTASHDT/4qc/KbqrQmeMa3/BMR5aEjyNqKOU/N1o/aaysiFfSRC+3Z4Y7gEv9m/5qrxEmZ/AZeNjAdDdDVk6aThMsh3/v0YMHUDK00r9eDG7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731838377; c=relaxed/simple;
	bh=8rzFto3M+CsMfTL5bkLU52j5jCaXTYsiWHoZHEJIQTw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tDUoH4wimJNeAoI10jbWwzLE9zRaiXTNov9sJfsmxboTnIeCMYc9+Y1D8u84X+iaJ0uXPbyxAd58mqUfvnW6fCFAEqZyOITsRG6uoSDQdgfvILIcafkbRSqrU1Pqu98127qSOmJbIviCfoHcv6LgMpt/qboOBnrwpmlAcvZBZSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=g+oUauBf; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1731838362; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZyczvdXt27uh8PUxu6O8q1jXGx4ZLmNBfCAnmwpv4WUs5QX3I5CL4pkvnXM92pGZUWl7jyhaNMCvp7kHrxMgSyLbFYrUZp9H0uFtklUkiSPOgt6OsoD/Jugdgjsxu/f8UpBUd7eaOWRJHc0iERsbbQA4LHJBr+0PB50I4TsXyj4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1731838362; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NyxhRCsognRghJgqS/SCBGOjSPC/p2cFFkjhxwiJBwo=; 
	b=dDepkeOcFxx58tpeHhyY8wzyuuGFmWgZP4f40aFcxZSDeGJvSjrO/fPRbnGaLHwAeRDaOqxguXQ0EPXa6+n9q7RqUw+D/2CM+UXw+mYbYzWTJ6DGNLq6AWUuB6wKuhmd/7zMN8bu0i5u+ywzXKv8DZ327mcjCptPOt67lsEjUsM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731838362;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=NyxhRCsognRghJgqS/SCBGOjSPC/p2cFFkjhxwiJBwo=;
	b=g+oUauBfMxozbA15jbrurUOtFlfc9Q/FkLvfb2Nj8apqpjRnJz93RcKqzabAmZM6
	+hU31mb8FH1DTOgk6rkdmffbBm+ZPgflRUlRaDyRfkUK74UYhD2HAsmYGrK1DxHX9cX
	gQVM/ZoWcMqyPBqBh2yxiHecIOmiDqqfN/aXz/sA=
Received: by mx.zohomail.com with SMTPS id 173183836006315.941452786053674;
	Sun, 17 Nov 2024 02:12:40 -0800 (PST)
Message-ID: <f8f28746-bc6e-4c0f-a130-271e8535ae8f@collabora.com>
Date: Sun, 17 Nov 2024 13:12:35 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm/virtio: Use drm_gem_plane_helper_prepare_fb()
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Rob Clark <robdclark@gmail.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Kim Dongwon <dongwon.kim@intel.com>,
 Kasireddy Vivek <vivek.kasireddy@intel.com>
Cc: dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
References: <20241020230803.247419-1-dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20241020230803.247419-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/21/24 02:08, Dmitry Osipenko wrote:
> From: Dongwon Kim <dongwon.kim@intel.com>
> 
> Use drm_gem_plane_helper_prepare_fb() helper for explicit framebuffer
> synchronization. We need to wait for explicit fences in a case of
> Venus and native contexts when guest user space uses explicit fencing.
> 
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> [dmitry.osipenko@collabora.com>: Edit commit message]
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_plane.c | 4 ++++
>  1 file changed, 4 insertions(+)

I'll apply this patchset tomorrow if nobody has more comments to add.

-- 
Best regards,
Dmitry

