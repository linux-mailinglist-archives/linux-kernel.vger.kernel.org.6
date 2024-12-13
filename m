Return-Path: <linux-kernel+bounces-444308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8374A9F047E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 07:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6E49188B15B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 06:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9854D18C03F;
	Fri, 13 Dec 2024 06:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NKV9VJRC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8DA18B460
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734069630; cv=none; b=cJiOPXr4knMtMpd3N+Goe+ENLsAkyHIWLCmgZvsSIFtunwFIxbo7HtHJ8D9D7WpWEQyQlRDdzsoffiFOe0o4xzh5WYLg7Lg9FCQ+XbS8zmZG4WW8n2sZdMT0b8HR7/sD0Pf9A5L3V2xoLIJxrPRBqhrVue9CBdzzr1kDlAaiuZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734069630; c=relaxed/simple;
	bh=0feM0v9/HSqQnZrLaLJb8piuDlCnb2V34BAOP+y2+DI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j6tpRXan2bsShe3358ag6XJcn4BSjYIrd2BKIaNdTiybXqYcEp/Bko3E8ljl3bZq5VlFRFlsdYPO+D4ixXGChl8Uvs48lAgL+x6/795Y4vYb4zl5W1T1EzUYOizge9v9jho2QNaGoYeaBbb/ev8Yk37UmtIyXeYqc1RPUzIL6cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NKV9VJRC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734069626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TWteF4vrF1/pE81Ren4Vt30zPczJ6J6JzqVwaxLGNdQ=;
	b=NKV9VJRCo3XP32IS7sKlNbfRvVDb4dL0PgnmBaUDNINu/g3nH/W4nBGMXSKBYxu4u8d/M1
	kFZ+trkkXFw+49yoF8WouOm5+IKE/xKVoyuXiJwPc0OTbjr/A49zzqYRQ9sJryAZ6+7sCz
	fOd4Gvbf7GDOU2E4ZL7djcZUAoDZ3zc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-QMsm36jyMFKkfNDSa7UWRg-1; Fri, 13 Dec 2024 01:00:24 -0500
X-MC-Unique: QMsm36jyMFKkfNDSa7UWRg-1
X-Mimecast-MFC-AGG-ID: QMsm36jyMFKkfNDSa7UWRg
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5d3eae7a9b8so124380a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 22:00:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734069623; x=1734674423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TWteF4vrF1/pE81Ren4Vt30zPczJ6J6JzqVwaxLGNdQ=;
        b=sryWrHZlUIMzFSqH8eZNhtYHwohPOEc/Szo0frN6DIlJ5XcWehsQgAbdzvfrGWWHpq
         NAPXZ5sDKDnMsL3VdWhHjipYh3pLxMtlPB/p/N8qz8LCwJop8y9zlodW5H+8Fz2KwONn
         KAaSDSSSZ6InMjpnnDZtv18Y1Gh3U3IZDEz8v6SATVSXpvW4ud4ds9nWogiNwXrn3fgW
         zC53uWBHtBIZnhvEaNrWeGlAUZZCf4fNWyCeC7kW9JEKckEK0/6wanEfv5SfIDBfToLz
         OJBm88ob7d68sk+C63n8LXEiJa6V3hKDKZqggcH2FiyqJCg5jQ2GoMz3nxEE/yiSPszN
         M1Gw==
X-Forwarded-Encrypted: i=1; AJvYcCXZe/2Vb+2dN4jx0mf+O76zT99+S6XgikZHfClEr0IpFiVr766irUYteIEjlbWWWX7qpP201iyvR9TqQPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF0qC7DwJcJFqn5R+YS2BuMsFMJoYoK3CI9x2Av9HPiGm6xD47
	s0gTFbFbHeUO596tkAY4oNXhUZK9N8CAPkACJYlnmZoEgFxyqg98L2woW4VczzF7KbrfH2cmqzk
	7PE7u7k+0Y5T8BxC7VAzrSHl8a2WiabEQdjHqy27ZR7ehCvCfnFfvRFvTISgTsw==
X-Gm-Gg: ASbGncsjP5PTzMitVy98jfl8n24exeSjZDhtMykvzzpflmrdQy6IgLWQlmCZ6BkxFb6
	ZhnaAwG5HNwXe3oQtRU+emGiXKjz06yZCwriNiT/1FG5MiSUB5KtulVFOhJv5ylqIadcWSKZfNr
	0p8kdjiDyr7VkBQgorwJwrIRDqchVElYX8UKvNNIdaolBWJDeYL1/BCvte90DU6KBH8iMjkqnKL
	pKDRpUvp5hzmRmVLSulLn9weX1KLFfMaTshp5jtYKYDoBSrHf+YTya0sdCIXmNLgyrH9VMVBPi4
	4X5k185KvkXCf081bRoFmVQGjoVv
X-Received: by 2002:a17:907:1ca3:b0:aab:7588:f411 with SMTP id a640c23a62f3a-aab779c8bcamr130015266b.25.1734069622965;
        Thu, 12 Dec 2024 22:00:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXwxJQVizGE5WgbyQd8OUq9Hy5FwjaQj5sQqA5agUSpWu1Zpe7/5Tw755l4EDxVsme0PEmFQ==
X-Received: by 2002:a17:907:1ca3:b0:aab:7588:f411 with SMTP id a640c23a62f3a-aab779c8bcamr130012766b.25.1734069622555;
        Thu, 12 Dec 2024 22:00:22 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa689a0a6fcsm648156266b.30.2024.12.12.22.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 22:00:21 -0800 (PST)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Alain Volmat <alain.volmat@foss.st.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-media@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: repair file entry in MEDIA DRIVERS FOR STM32 - CSI
Date: Fri, 13 Dec 2024 07:00:11 +0100
Message-ID: <20241213060011.67797-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit dcb0f4c16be5 ("media: stm32: csi: addition of the STM32 CSI driver")
adds a new driver at drivers/media/platform/st/stm32/stm32-csi.c, but
creates a new MAINTAINERS section MEDIA DRIVERS FOR STM32 - CSI with a file
entry pointing to drivers/media/platform/stm32/stm32-csi.c. Note that the
file entry is missing the ‘st’ directory in its path.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference. Repair this file entry in MEDIA DRIVERS FOR STM32 - CSI.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bff3d35f80b5..230b7a4ee95f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14551,7 +14551,7 @@ L:	linux-media@vger.kernel.org
 S:	Supported
 T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/st,stm32mp25-csi.yaml
-F:	drivers/media/platform/stm32/stm32-csi.c
+F:	drivers/media/platform/st/stm32/stm32-csi.c
 
 MEDIA DRIVERS FOR STM32 - DCMI / DCMIPP
 M:	Hugues Fruchet <hugues.fruchet@foss.st.com>
-- 
2.47.1


