Return-Path: <linux-kernel+bounces-215462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB4E90930F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 21:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5BB22841D5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BA419AD4B;
	Fri, 14 Jun 2024 19:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="X348uQvb"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D42B136E09
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 19:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718394340; cv=none; b=YtfLfa2vpR2EfmdryhUBRcE/Mw7pqVGdbBTvP6H7IEbbzeZW+dn+OjcJlzvuCkERGHIFSrlNqpm8tBvJOoo4AXNSnU+y569ljOjmIf3IViImpYx+Hnfv9/0PqX9FAX4ldqVlLtxNOQHgIx9Bu5rbZGewuOf+/rKIwBFsXEyCbDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718394340; c=relaxed/simple;
	bh=lcPIWTBRq3lgo2fFASZIrZ7aLIdr056nhdXRrDyFrTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LguegYxsmvocPQ7WYyLSQYetMIbocVbQtWgU4USKy3GCygRLtBTUz7GxM/gwlUYasZsDQsfFZrH6R60E1cWfd1M+EK8DktHOTButCzI10N0kcvTVvTS9lzUJXLAnUiaOQKIFKx9mT32tUhisMgamHrf980rejINFhQyBqbXA5tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=X348uQvb; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=M44EAurJqz/z7z2TELpTrBFQPiqQfC8RY79k846tGag=; b=X348uQvbOfbP7W1zQU/5kwL64w
	1oznea95ngjiLZpMa/ZyJoY5+HfVpkzV+s38LCHZ8iEamSSI3r/ga5nHQvPaiowhGBNL9odA9rKwP
	4HwUDNBCsnDdsf/CaKbvHmdFyDMEWMNr5i0NDyjmciacWwK0dMaW5diuiHCbOONfdpVXkyGC0u7b7
	pZSGioBA41lzxOYmzzcxWsfE2ww/9n44Q5tMXLWM6XFRtryCIkgAr3bh81Pa1m/vcGvnChLLnOemc
	mLP/0WbdvRqX7wfxd5/kYCT2FoEJO5H/smQfQGzYTUNWjq53LTRr/XMDzJ1shH44tw7NcUkt/Sra9
	Gu9Fs2oQ==;
Received: from [179.118.191.115] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sICrc-003G9M-0d; Fri, 14 Jun 2024 21:45:32 +0200
Message-ID: <49cd9364-d0c9-4900-9b44-d317bde8c668@igalia.com>
Date: Fri, 14 Jun 2024 16:45:21 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/8] drm: Support per-plane async flip configuration
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, Melissa Wen <mwen@igalia.com>,
 alexander.deucher@amd.com, christian.koenig@amd.com,
 Simon Ser <contact@emersion.fr>, Pekka Paalanen <ppaalanen@gmail.com>,
 daniel@ffwll.ch, Daniel Stone <daniel@fooishbar.org>,
 =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?= <maraeo@gmail.com>,
 Dave Airlie <airlied@gmail.com>, ville.syrjala@linux.intel.com,
 Xaver Hugl <xaver.hugl@gmail.com>, Joshua Ashton <joshua@froggi.es>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Sam Ravnborg <sam@ravnborg.org>, Boris Brezillon <bbrezillon@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>
References: <20240614153535.351689-1-andrealmeid@igalia.com>
 <20240614153535.351689-3-andrealmeid@igalia.com>
 <ycgax5ulfcdho2ocrqhzwuvrtwjkwuzi4ghnutl72e5ye3wkxf@ajirwgg7ozwp>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <ycgax5ulfcdho2ocrqhzwuvrtwjkwuzi4ghnutl72e5ye3wkxf@ajirwgg7ozwp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 14/06/2024 14:32, Dmitry Baryshkov escreveu:> On Fri, Jun 14, 2024 at 
12:35:29PM GMT, André Almeida wrote:
 >> Drivers have different capabilities on what plane types they can or
 >> cannot perform async flips. Create a plane::async_flip field so each
 >> driver can choose which planes they allow doing async flips.
 >>
 >> Signed-off-by: André Almeida <andrealmeid@igalia.com>
 >> ---
 >>   drivers/gpu/drm/drm_atomic_uapi.c | 4 ++--
 >>   include/drm/drm_plane.h           | 5 +++++
 >>   2 files changed, 7 insertions(+), 2 deletions(-)
 >>
 >> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c 
b/drivers/gpu/drm/drm_atomic_uapi.c
 >> index 2e1d9391febe..ed1af3455477 100644
 >> --- a/drivers/gpu/drm/drm_atomic_uapi.c
 >> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
 >> @@ -1079,9 +1079,9 @@ int drm_atomic_set_property(struct 
drm_atomic_state *state,
 >>   			break;
 >>   		}
 >>
 >> -		if (async_flip && plane_state->plane->type != 
DRM_PLANE_TYPE_PRIMARY) {
 >> +		if (async_flip && !plane->async_flip) {
 >
 > So, after this patch async flips becomes disabled until the driver
 > enables that manually. Whether that's desired or not is a separate
 > topic, but this definitely should be explicitly mentioned in the commit
 > message.
 >

You are right, I think I should separate this in the last commit, so we 
don't have any regression commits. Thanks for the feedback

