Return-Path: <linux-kernel+bounces-395521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 034C99BBF11
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA382828A3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396CB1F7577;
	Mon,  4 Nov 2024 20:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Cex94fSH"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CC81F709D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 20:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730753607; cv=none; b=APLvK5sOiy8AEanpMG3b4i0XtSddsOgRtVttPTdC3JjiVyuPOa9Z/RaajpLl5V9YOMMLsYuxFZpwdEizDyZbSAJ82MXfyJ7GUfn+DGKAz6AGCS5LMSBFYwYuLeBopg3BZGbx+Vn0fnSWfnDQMm8Hp3WLijTcblwJ7G29YxQ1L6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730753607; c=relaxed/simple;
	bh=GctGlx/ZW9M23AexhGHCmKdR0fPkJz1XCHRtRABF/0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ck13Bv61mkil/qzxnvN1VH1ieMCftN/COqCF7cKILFZERpysaU4LbrLEcQfJIepLVBQKnn3hIfogCwhZNueL7QhJV4l2QlaLPSfnQG30ygl9FLzW0/NkN4xo7VHOboeFj/NW6qJ6D18aUZyMqeUsZn1vwINkihch0KLqSe8gYWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Cex94fSH; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lKRMqSRXhZhQYwWjC1ENLPJFMwrROYi/BPiNAXWtjBg=; b=Cex94fSHmswdP5+z/xU0dsFgb1
	NB4yHtqdKIXC9Rz6SCbdUDkCp8tezJMrDoZhb1MJfyp1ZLFNXSatLUYACSDfdJO1yZY/zIuwUfYUc
	XzZfY03sus86hu+INRn07YuoBr1HYtpmo026qfq8LHTdJKyXMhKQHTja84IzRrKchCeaoSYwqjx1S
	xhEDDrkt/ewa5hN/5eG+xJqsynrs3Kj4HvdF09NQ9qJiTOXRfI2A1oZM85zFYLTRQWIcbcpA35BtS
	8L2xvnF1gp31cZ1nrT6LIf1g4mxj88COZlHmdhlFYCPY4Igve6eB9aA4bT7AiJ2iEasxB+n5xGqwH
	s8Tt+ikg==;
Received: from [177.172.124.78] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t844C-001pbo-TO; Mon, 04 Nov 2024 21:52:53 +0100
Message-ID: <00a99b3e-3fad-42fb-8dc8-4f45d158c4c1@igalia.com>
Date: Mon, 4 Nov 2024 17:52:43 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v9 1/2] drm/atomic: Let drivers decide which planes
 to async flip
To: Christopher Snowhill <chris@kode54.net>
Cc: kernel-dev@igalia.com, Simon Ser <contact@emersion.fr>,
 Thomas Zimmermann <tzimmermann@suse.de>, joshua@froggi.es,
 ville.syrjala@linux.intel.com, Daniel Stone <daniel@fooishbar.org>,
 Xaver Hugl <xaver.hugl@gmail.com>, Harry Wentland <harry.wentland@amd.com>,
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Leo Li <sunpeng.li@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Xinhui Pan
 <Xinhui.Pan@amd.com>, dmitry.baryshkov@linaro.org
References: <20241101-tonyk-async_flip-v9-0-681814efbfbe@igalia.com>
 <20241101-tonyk-async_flip-v9-1-681814efbfbe@igalia.com>
 <D5CC3U00B7CG.IGKCIES8PC2J@kode54.net>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <D5CC3U00B7CG.IGKCIES8PC2J@kode54.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Christopher,

Em 03/11/2024 03:36, Christopher Snowhill escreveu:
> On Fri Nov 1, 2024 at 11:23 AM PDT, André Almeida wrote:
>> Currently, DRM atomic uAPI allows only primary planes to be flipped
>> asynchronously. However, each driver might be able to perform async
>> flips in other different plane types. To enable drivers to set their own
>> restrictions on which type of plane they can or cannot flip, use the
>> existing atomic_async_check() from struct drm_plane_helper_funcs to
>> enhance this flexibility, thus allowing different plane types to be able
>> to do async flips as well.
>>
>> In order to prevent regressions and such, we keep the current policy: we
>> skip the driver check for the primary plane, because it is always
>> allowed to do async flips on it.
>>
>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> 
> Should I do a R-b too? 

If you can review the code, it's always really appreciated.

> The changes looked sound enough for me to feel
> like testing it as well. Tested Borderlands Game of the Year Enhanced on
> my RX 7700 XT at maximum settings at 1080p165, and the tearing support in
> labwc allowed it to reach over 700fps. No problems from the hardware
> cursor.

Thanks for testing and reporting!

> 
> Tested-by: Christopher Snowhill <chris@kode54.net>
> 

