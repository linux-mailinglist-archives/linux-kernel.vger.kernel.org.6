Return-Path: <linux-kernel+bounces-538465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54012A49909
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 274033AD0B6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A51D26A1B8;
	Fri, 28 Feb 2025 12:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="h2jIfF7I"
Received: from mail.crpt.ru (mail1.crpt.ru [91.236.205.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228F71C5496
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 12:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.236.205.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740745183; cv=none; b=Hk6lx4qgplQ5bmH0hcNHNfH7e2MHVE4sBniXOYQsSIxUTy8mDhrHVkf6EQJl2pf7zgmnyQDTb4qyUHuE21HB2O3iO5PG8Twu9IT9nGJg7ruf1NyduQECGdKVldJjVfRx9x0XidF+1hxDcnVweFlN+s8uf6R/uT57DLVaB8HTu7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740745183; c=relaxed/simple;
	bh=9uLmCYpelPlrRNrb++dOCUoprBN2LM7mbagKkVVasV0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=A6cM1Yjta26GGkqyXrMXeZo3BBoA90BUuyjCkrdwqyMiyuopKZj5aCb3SWtu6wqPZRddWdJv/I8zmqgzWv4K8ywjIib1a1+DiXoVXhb5zSCq0v2JZoAMpGoTRvzphiBsPukzGXOhk4WGTRrDDv5DD/cy0OrOhHlqgSQjaUo1BEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=h2jIfF7I; arc=none smtp.client-ip=91.236.205.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
Received: from mail.crpt.ru ([192.168.60.3])
	by mail.crpt.ru  with ESMTP id 51SCIjYT028061-51SCIjYV028061
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=OK);
	Fri, 28 Feb 2025 15:18:45 +0300
Received: from EX1.crpt.local (192.168.60.3) by ex1.crpt.local (192.168.60.3)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 28 Feb
 2025 15:18:45 +0300
Received: from EX1.crpt.local ([192.168.60.3]) by EX1.crpt.local
 ([192.168.60.3]) with mapi id 15.01.2507.044; Fri, 28 Feb 2025 15:18:45 +0300
From: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
CC: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Thierry Reding
	<treding@nvidia.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: [PATCH] drm/gem: fix overflow in calculating DMA GEM size
Thread-Topic: [PATCH] drm/gem: fix overflow in calculating DMA GEM size
Thread-Index: AQHbidrpG4n1T48VGUSXUbob/OuFoQ==
Date: Fri, 28 Feb 2025 12:18:44 +0000
Message-ID: <20250228121834.122728-1-a.vatoropin@crpt.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: EX1.crpt.local, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 2/17/2025 9:52:00 AM
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 192.168.60.3
X-FE-Policy-ID: 2:4:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=crpt.ru; s=crpt.ru; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:content-type:mime-version;
 bh=w137Rzd7URkPuLrekq8fzju9U+OfooOPZ7PckW6E1AY=;
 b=h2jIfF7IUvSg7qQMoumlae3QRuAPHQfg1pMLmZWb21MMnQyBouxd9Q4qKciR3fOTY84sXs9YYA4t
	/7W4cuddFn6fm9XcrwTmae5QySe6W38cHOjLxLEjOG+lFjO7tvGDjPpmZY/X1Mm2Gx4jXsVwfbjO
	uNZ2H+KpR9OEBj8mzDnEVSEv79mzHZ40B7Tf9fKQz+vaX61o6M26lnBVOgKV/ldBgpalrATwaCIl
	lKCWqGzpW12zXFZ2rQZ1cbZJea62ghBh9UfjGPIMYfh6UaK7LOLwqT4+BqDfzKlA0ddYMGVlQaxm
	6vFeHObnkhYO9hx+Y05FC+eDabDOwou4ycohyg==

From: Andrey Vatoropin <a.vatoropin@crpt.ru>

The IOCTL handler drm_mode_create_dumb receives different parameters from
the user, specifically "height", "width" and others. Sanity checks are=20
performed on these parameters. However, these parameters are sent to the=20
->dumb_create() callback, and during the processing of the "pitch"=20
parameter, its value may change. The extent of this change depends on the
driver that exists at the lower level. The thing is that the value of=20
"height" is controlled by user as an ioctl parameter and it is not
directly associated with the "pitch" value so the initial sanity checks
can be insufficient.

For example, if at the moment of calling the=20
drm_gem_dma_dumb_create_internal() via ->dumb_create() callback the values
are as follows: height equals 2 ^ 27, pitch equals 2^6 then the following
statement:=20
	"args->pitch * args->height"
will evaluate to=20
	"2 ^ 6 * 2 ^ 27"
and an overflow occurs.

Since a value of type 'u64' is used to store the eventual size, it is
necessary to perform the 64-bit arithmetic to avoid overflow during the
multiplication.

The same thing was done in commit 0f8f8a643000=20
("drm/i915/gem: Detect overflow in calculating dumb buffer size")

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 6d1782919dc9 ("drm/cma: Introduce drm_gem_cma_dumb_create_internal()=
")
Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>=20
---
 drivers/gpu/drm/drm_gem_dma_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_dma_helper.c b/drivers/gpu/drm/drm_gem=
_dma_helper.c
index 870b90b78bc4..a8862f6f702a 100644
--- a/drivers/gpu/drm/drm_gem_dma_helper.c
+++ b/drivers/gpu/drm/drm_gem_dma_helper.c
@@ -272,8 +272,8 @@ int drm_gem_dma_dumb_create_internal(struct drm_file *f=
ile_priv,
 	if (args->pitch < min_pitch)
 		args->pitch =3D min_pitch;
=20
-	if (args->size < args->pitch * args->height)
-		args->size =3D args->pitch * args->height;
+	if (args->size < mul_u32_u32(args->pitch, args->height))
+		args->size =3D mul_u32_u32(args->pitch, args->height);
=20
 	dma_obj =3D drm_gem_dma_create_with_handle(file_priv, drm, args->size,
 						 &args->handle);
--=20
2.43.0

