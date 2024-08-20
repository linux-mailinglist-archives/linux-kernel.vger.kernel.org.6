Return-Path: <linux-kernel+bounces-293704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF55958350
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889291C20F9A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D93218C32E;
	Tue, 20 Aug 2024 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="VcGOLeqj"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A103518C03D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724147769; cv=none; b=I6OJ3tz17lYmQWOU6goXneHIVotaSTl9YnTC1OFEZy6g0Jp3BtMXX0q1cQQhT6Z8v3PX8exAPJxHBe8V8UHVBYdgroyfFdNCWHrKL1gCQ8bQHOpXTegLGe1ZfFKsnc4SBIi1MHbtKU3XUCGFF1v0OM1o/oK9dCLagEj+7MKEibc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724147769; c=relaxed/simple;
	bh=gNL4Dc3BiNLMCXF5wQLxOo/XKPg/+gZAT6T2uBED9kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RLhFu/ys7WskVcjlQfnfgX+RJkWxPyCBXEYtpcbzAmCJHeIeSro/GH8jxPB6Nx8sdxv9CTkRdLJT8XzoO8K2J75RO3e2tVXr75NrANFRcINvwvgfn9NRRg53O8RDo9qpgbypn1eqKLkJwxyqoQx5cbNS1tbl1tJ+ls5OAprPRDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=VcGOLeqj; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9DaJJPiwUvlSFnUUActMVJXI0QVdEXy6fadv1aQUXnU=; b=VcGOLeqj9QdamuwLskHPEMNbax
	l8hdih50g5UqDwP3fu97/B9G8nfu4okpEYhmSsKDOdvBfSl0qQ7OcwuK29YN9QUmDmZkdfnFJYqYz
	h7aB8KQurLiAIEnI8QBOyID4x3v4b8gW5JgYCtmwFPQTXQOPE3LCfTpnMnv/fcObE8vSVwuCi4C3i
	Q64D2VYtg8oHUIT9jWx0uGJWQyRW+ULmoCpaC/t5ZcdVgvecr8KZj4E+TM6YvV2j2u21My8d9EWbO
	m9e5c71dFjp/qRlLXsJK4iGai4oQvJHfZjwLvr0HvW3zFMMWXQ5wfMeuC/D92a37HLe6LBYi5nuYU
	ar8yAQcg==;
Received: from i53875aca.versanet.de ([83.135.90.202] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sgLat-0006zG-AM; Tue, 20 Aug 2024 11:56:03 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: kernel@collabora.com, Christopher Healy <healych@amazon.com>,
 Mary Guillemard <mary.guillemard@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org,
 Mary Guillemard <mary.guillemard@collabora.com>
Subject: Re: [PATCH v3] drm/panthor: Add DEV_QUERY_TIMESTAMP_INFO dev query
Date: Tue, 20 Aug 2024 11:56:25 +0200
Message-ID: <4687763.CvnuH1ECHv@diego>
In-Reply-To: <20240819112508.67988-2-mary.guillemard@collabora.com>
References: <20240819112508.67988-2-mary.guillemard@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Montag, 19. August 2024, 13:25:08 CEST schrieb Mary Guillemard:
> Expose timestamp information supported by the GPU with a new device
> query.
> 
> Mali uses an external timer as GPU system time. On ARM, this is wired to
> the generic arch timer so we wire cntfrq_el0 as device frequency.
> 
> This new uAPI will be used in Mesa to implement timestamp queries and
> VK_KHR_calibrated_timestamps.
> 
> Since this extends the uAPI and because userland needs a way to advertise
> those features conditionally, this also bumps the driver minor version.
> 
> v2:
> - Rewrote to use GPU timestamp register
> - Added timestamp_offset to drm_panthor_timestamp_info
> - Add missing include for arch_timer_get_cntfrq
> - Rework commit message
> 
> v3:
> - Add panthor_gpu_read_64bit_counter
> - Change panthor_gpu_read_timestamp to use
>   panthor_gpu_read_64bit_counter
> 
> Signed-off-by: Mary Guillemard <mary.guillemard@collabora.com>

On a rk3588-tiger with matching MESA build and 
"RUSTICL_ENABLE=panfrost clpeak"

Tested-by: Heiko Stuebner <heiko@sntech.de>



