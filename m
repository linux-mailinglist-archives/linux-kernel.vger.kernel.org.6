Return-Path: <linux-kernel+bounces-369787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EB89A22A7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A9B31C210F1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 12:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1107C1DD87D;
	Thu, 17 Oct 2024 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MT38eNw/"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3D71DA61E
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 12:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729169086; cv=none; b=KaI3ZQPUpNgkxi04yHgEp4FWw+aCmTaKkF1ntTmbe84jDA2+KhV5Fatt4oI0rxCX0TFIs+J0DpRQqUm5I+RWE82+xfnneYyMx7uiDo9lAE8OwHDAaATqLK/VpUxKFF598KWvOkRBvKTg54+avL9feppv5kulUuUD0/ueWhJPOSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729169086; c=relaxed/simple;
	bh=xod92abkKPjsuq2xCVMjFOc7B3vn3PWges1C+7+ZYEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kBrjcwtatVzMq3vO+trawarVi6L6JBJT0Rlur8RCpzja/dgs+Mpa6B0HwIfDPkWRkj8E7w1De6A3JbIfW58wkTEVeJyYqcEwy+kcvNVZKaCvQUwcDyWul0sRwzfCprIassX4eyMtUzJeR11v3wLuhCfK4ZhhZOr7NLKr4gmCsc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MT38eNw/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729169081;
	bh=xod92abkKPjsuq2xCVMjFOc7B3vn3PWges1C+7+ZYEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MT38eNw/HsuRcTAnrwWxXJImzpQGmpdUEiSzcjpgCgWjrps5+rzZ3zSSr3oXSZfSo
	 tOpk6sf3U+6/G3qv81iw5lwcxULnV+1a4oi9kluJJCE1Ocbk9oV3gMfEYMqD+OeSNi
	 SJWTg4sizGCCSuaKzLk7LpTy9qd+oAyxMGro/QOmWVgVbcMofRkmC4RVbVVejkG/a8
	 UBErYLUSP2aAP/3nbv9uRMZzaR9J/wCVysjF7A1VLAToOONyXVPHgKGbt21ej2I5Vm
	 3j0gcYAVsErfcJmJ3pzCgXNwyUIoQBokyuT4PbFKOmj6WeIVv4c7PIe1Dr4C8hwNBX
	 Y1IkjPBOslVuw==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 01C6F17E35F5;
	Thu, 17 Oct 2024 14:44:40 +0200 (CEST)
Date: Thu, 17 Oct 2024 14:44:38 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Philipp Zabel
 <p.zabel@pengutronix.de>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] drm/panfrost: Replace DRM driver allocation method
 with newer one
Message-ID: <20241017144438.257aaa76@collabora.com>
In-Reply-To: <20241014233758.994861-1-adrian.larumbe@collabora.com>
References: <20241014233758.994861-1-adrian.larumbe@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Oct 2024 00:31:36 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Drop the deprecated DRM driver allocation method in favour of
> devm_drm_dev_alloc(). Overall just make it the same as in Panthor.
> Also discard now superfluous generic and platform device pointers inside
> the main panfrost device structure.
>=20
> Some ancient checkpatch issues unearthed as a result of these changes
> were also fixed, like lines too long or double assignment in one line.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

Acked-by: Boris Brezillon <boris.brezillon@collabora.com>

I didn't do a thorough review of the diff, but I'm assuming it's
correct if the driver compiles.

BTW, I don't see it done in this series, but it might be good to also
turn devm_ calls into drmm_ ones, and dev_<loglevel> into
drm_<loglevel>.

