Return-Path: <linux-kernel+bounces-516316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D6AA36F96
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 17:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C26EC1891FC5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 16:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703271D89FA;
	Sat, 15 Feb 2025 16:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kezgjIa+"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4142142AA5
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739638627; cv=none; b=qZ9VA5x17Dd17IEXqSwlWiwj32eCYoYBB2qG/8ywK22lZ3gX3x2k8vIzVxuku0Qm480E3PUqETYIWPJrjhUkCdz2wSFJEU2dbuUaJ3UNu6/cElQlssAQexHWVtNU8te5551RjsJAAlrgog/BeknQbI9BfInGK3VqONLPSLLDrOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739638627; c=relaxed/simple;
	bh=l4t/wsUY3T7/jpMvBhwTbPunZ1IaT1yxNcw4SrC5OfQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=On6WO5+ddXXhaD6NVK192m6pPIv7rz3+YDtX7WpJjUjEo58ODRHo5Iu9fvxOFbJog8yu5yfq1YnApoP6dWDbkgdgksNBoKFVb2wMgEZFomlCiZL26ydFfax2Lf/1JSVMwXnLcQLdOGifcU6f/7BDlpRUHxie3YPR6Nre4DzEi28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kezgjIa+; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab7e1286126so530127666b.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 08:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739638625; x=1740243425; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0c4zZz2kpW8BEFDTwqY0/JTaruHiG2j7HEu4uhE1vkU=;
        b=kezgjIa+K8bWEkO8GQ5s1VO8N1TgUo8ioQPDBQW2lbMTZhONclS3wO2vTKv0D7aSp8
         DNiGVSc3036E02X6Lpgfd344widaVfwi2jJtZukcy58qxR05YnB5IOQ11OSc5fb0i7Tl
         PSl44eiiUWndU1fxx6iPtQMfQQbKWGIriR7aH2PCDeRSm4R7zZwGaoEGmGdni56CvJP4
         HegFIwUp2oSdNXOF1WLUV1hOBAivYJECFmuQfR/qlchsSoE2jOxKJrze4RDKdr4ty2Ba
         NcWL3JekpSZG56vdYeprxniIIqjel/jfKeoHFX0MCjyUbefE+qnkiUyNXaLilJdO15N8
         FGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739638625; x=1740243425;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0c4zZz2kpW8BEFDTwqY0/JTaruHiG2j7HEu4uhE1vkU=;
        b=SYDq6unf7WrfDLP6TczP08wgvJhvXbNky0iD0rt3Gnm47Z3aiejrFRZi0s7UCdMRSB
         H64G086bvJNL+nu7nyLeHTOt3kZ8uIgmNqYjSKpITUXGHrxv5rFR9dsAg+su6Rr78ORN
         BD80RyloKJ6buVbl7LsNh95V5AO6U+bgyFnH4Ui2fBUUdaqF+8QvvWh7RoM87pq37mpt
         wFjkLye+B9+eZZipKbS+ZjSQQ+VRDFL0HZWYanhgkpFhn6ThYMiqW0QKTLr4B2u0xter
         EC58rXWk/PNrC5LcRybDih+cw8hOKVZeqziseGiwV9ev1hQRraoiqlQ36LtZvyPEs3am
         adpA==
X-Forwarded-Encrypted: i=1; AJvYcCXi72cwN6YKsVVWwhGiE4XskoxKGXW9EOfk9RPjZtEUxe8EuRhEJuXNqiZmrB1X96Q4nrhFNT1lyScH1fc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9gVnyRXT44SRrgHZ407G5oP7wZMcS2TPQf3Bua1fp/kdV7oje
	eTyNQIUntkK1la8KwCqHzggv0Kxv9Aw0CzEyIkyoo6dx/uXBcuJE
X-Gm-Gg: ASbGncsO8rrGeIarSW3ODZkU5F3nbsUeIG9wX8eCu4M9zMEDKsBG3jCYttivOhKLZ0N
	OAAnHZnp2qf4ReO/y9gxBwM9vijzSfJsOgw3isDaPm8lFZ4lxOwgfOm0rS2u4JgPl4i5JvlEgF7
	SZtjcQju4MNXv/Tyqn1/XdkZjo4vg47K8duLjMY6DeazlUUHaH/ahmwkbz6e2yhfIKbR+5gNVeJ
	dmi5vbSe3/3nt9jW4PEAJ3Omrm6gVWiQ75KXQuWqcdNoKp/p+GT0NhFmEEid+UmTZGuybZiVoUu
	2fvglxXFSsYH4DbSBh8=
X-Google-Smtp-Source: AGHT+IGWpjIb5Vy6Nuo8jfBoCuvVBv63aWtTMF7Oe5Zscrbp2wx5S8DKF2J/IsI2QED1UHvXW9cXmg==
X-Received: by 2002:a17:906:6a03:b0:ab7:d946:99ef with SMTP id a640c23a62f3a-abb70cd50abmr343055266b.16.1739638624232;
        Sat, 15 Feb 2025 08:57:04 -0800 (PST)
Received: from localhost ([2a02:587:860a:7219:38f1:eba9:54d5:df1f])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-aba5a4f4cb4sm481480966b.118.2025.02.15.08.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 08:57:03 -0800 (PST)
Date: Sat, 15 Feb 2025 18:57:01 +0200
From: Lilitha Persefoni Gkini <lilithpgkini@gmail.com>
To: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] slub: Fix Off-By-One in the While condition in on_freelist()
Message-ID: <Z7DHXVNJ5aVBM2WA@Arch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The condition `nr <= slab->objects` in the `on_freelist()` serves as
bound while walking through the `freelist` linked list because we can't
have more free objects than the maximum amount of objects in the slab.
But the `=` can result in an extra unnecessary iteration.

The patch changes it to `nr < slab->objects` to ensure it iterates
at most `slab->objects` number of times.

Signed-off-by: Lilitha Persefoni Gkini <lilithpgkini@gmail.com>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 1f50129dcfb3..ad42450d4b0f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1435,7 +1435,7 @@ static int on_freelist(struct kmem_cache *s, struct slab *slab, void *search)
 	int max_objects;
 
 	fp = slab->freelist;
-	while (fp && nr <= slab->objects) {
+	while (fp && nr < slab->objects) {
 		if (fp == search)
 			return 1;
 		if (!check_valid_pointer(s, slab, fp)) {
-- 
2.48.1


