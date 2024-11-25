Return-Path: <linux-kernel+bounces-421030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085ED9D85FB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5EEAB39D3F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31EC1A7060;
	Mon, 25 Nov 2024 13:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlcPsmsw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5063414F9D9
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 13:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732539857; cv=none; b=uklqGhyya1DepSZ6l1k9lrNTt8zwkEVhJRQdzdSkjkuYtYdbXIkX3UaCBLi2VM/qgZ2GotckVllAylaxg7BVl7bxU/CBCwWPQKyVgRUnG8DNSpm9MaLiANSRELda2Zd756gA0RZZS3VFYcQRJHz7JaP0Hij9tYFWBcsXsEkdccc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732539857; c=relaxed/simple;
	bh=r7HHe0SIRB/Xhhuek+OVQ0KZeGyRWxN7kMyA6beaWWg=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=msVLMpB2TJOeHpz0q3HLRTgeg96zNqpSxTJGxn5DWzzS1TWR2JG2bZeRvPMlWVTdgw59pjz6u+twuqRoiKRHwo+0J72BNxHbzFFg6Cuh4ZdQRQ3doSLFfNDQp+lABypq02kthu3w2cgcSaq/t5Q6wVdMSkWlroirY11niaCPEDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlcPsmsw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868D6C4CECE;
	Mon, 25 Nov 2024 13:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732539856;
	bh=r7HHe0SIRB/Xhhuek+OVQ0KZeGyRWxN7kMyA6beaWWg=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=SlcPsmswDWw1qUPky6PGkkOP4b2wa0bm4kONi0Jn/5VHClT7MdVQIlp82tbtoAlAk
	 XMwmLYaCB1CpkKCUEaBCkT7zLP4BuTBdDo6HgzugoQQXJVzj4K6LLQbknKVX/69E0L
	 7EbuaLl2NKQ5KDfCAjNwIC15K1sVB1chuXPqUMwG242zNz9mLJKJ68Klk5HiR2VDms
	 mk5iMuIgz7gD3zvfAdAeNWCPmrF67KuHh4mdy0RuN0LOW7A6sSV0W6tnYmM07bpstZ
	 qOlwraK5aKm1jL8jR822jS+GKjsx0dMIZrmzNU1T5B1dwxNZgncyZvRRD9qCDH9R6u
	 OPMw4ZChAm2Pg==
Message-ID: <fd7766b66026ffbab54db6f134940efc@kernel.org>
Date: Mon, 25 Nov 2024 13:04:14 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Subject: Re: [PATCH v5 3/5] drm/vkms: Switch to managed for crtc
In-Reply-To: <20241122-google-vkms-managed-v5-3-1ab60403e960@bootlin.com>
References: <20241122-google-vkms-managed-v5-3-1ab60403e960@bootlin.com>
Cc: arthurgrillo@riseup.net, dri-devel@lists.freedesktop.org, jeremie.dautheribes@bootlin.com, linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com, nicolejadeyee@google.com, seanpaul@google.com, thomas.petazzoni@bootlin.com, "David
 Airlie" <airlied@gmail.com>, "Haneen Mohammed" <hamohammed.sa@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 =?utf-8?b?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>, "Melissa Wen" <melissa.srw@gmail.com>, "Rodrigo
 Siqueira" <rodrigosiqueiramelo@gmail.com>, "Simona Vetter" <simona.vetter@ffwll.ch>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Fri, 22 Nov 2024 17:27:58 +0100, Louis Chauvet wrote:
> The current VKMS driver uses managed function to create crtc, but
> don't use it to properly clean the crtc workqueue. It is not an
> issue yet, but in order to support multiple devices easily,
> convert this code to use drm and device managed helpers.
> 
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

