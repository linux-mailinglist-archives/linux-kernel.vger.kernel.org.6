Return-Path: <linux-kernel+bounces-248661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F5E92E052
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC1D1F228EF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 06:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331EC12E1CD;
	Thu, 11 Jul 2024 06:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i58wH30T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6CE12DDAF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 06:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720680716; cv=none; b=dElc5aM+LryQf7r5sGIJhkUx5qqa1ECtoN20IYjs7Z9/pj56jejvaJkCjgWU7cRzcSYkrzGMCtMXnDQ1ltVOy2xxF8WMHZ2Kc0pE6XviZEMPzInkSNtIu3yTleTh8ALF/PpbTLWFb9mCcx9F0pbI9dvN9z+wzZTNZh+3HBVd6FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720680716; c=relaxed/simple;
	bh=LCK9icEae3jKYmdEHdfJqroHgzlTNAWTkaaa0AbjU4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WITeM17ewlJ3gw1hLHy13EEiJ09AJW3Cv1H8USdUb721GRW+TjbDBUyPbrt3XYskK5cqIQpB7S6K0wuaGoB1/8Fx0Koq05bwsCRya+QU6YYc7aDH8UYO0ppt2//IOe49CD4IqsDRZzaXiU+SwPvp9O+dUJVf4C1kEakka2Hl+Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i58wH30T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720680714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OGHWmQ5BDSpnthAm3GCMpgKvKr351yaxBIw3YmVdyjY=;
	b=i58wH30Tl4Ii7DqZ1XrTdal22j+s69SwI/nMSNpIFtXHEbbPwAjGCjofBMyM9EkJW/NvA3
	jc0c0qkDvpMcWtVfecmzlEl4YGIQx1eVsgjkNiZZ5e+RT5IfXgGMSiqeoQiBFOAd7J89G9
	KpuRWMIyffzFKXq7kUQlp1vHcKVPozk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-NjAVCP0rMAuY7h-vm81Dag-1; Thu, 11 Jul 2024 02:51:52 -0400
X-MC-Unique: NjAVCP0rMAuY7h-vm81Dag-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a77c85826fdso59109466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 23:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720680711; x=1721285511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OGHWmQ5BDSpnthAm3GCMpgKvKr351yaxBIw3YmVdyjY=;
        b=HsJg44zTCScYJUXeLuD3fD6VDLT6OZyFxhJSqWrD9gV9VDn2ZZ+OaJCvZMvz8aO4nd
         KIxyPRj8fkv0VWbT2WgEcvS3nTa3sw7oxeop7EQ8n2hadNeTaiGhtvboSOOZjGXRDISW
         zc5S6dQyNfWvAh0/T51pNsYoe1T4KKgpZ9t/Cjjq9JfGOYVKynMuh9dVR3usaHA+kCi/
         Hcl6flOSQp8QeuBablNUt/xbbRhcnL9ZPlvtwgWKKvhpNvJp0LfxFf4sCGJLnA46bFcw
         4lF3Umd7zwnFaZds1ONtEgJjTVi0t/Y0SYY72WSM7NZeCq6EmbNxwhjUDvUwDmeSsdIb
         CBhg==
X-Forwarded-Encrypted: i=1; AJvYcCX7ZCQuKjfPniR7dtPf8IqlUJjc3NEUijVHLPwuK4SmUOEqKmDl0MguIOWV1l6RaGByv4mi/tufpMpQwapkRmIqI11fZaBLJ+UtTBTN
X-Gm-Message-State: AOJu0Yy//Ef3nz4ontlv5XwXkeNkyr2xtcupKA8+7CaRchG8lQxeA32/
	iX+mxMkIgcQ9sabLbsXVXMXjnkh2U5jsIA8DjuVWjul55AnLZ5QTWitroSra374yGSPfsDE4MLh
	ADZnocdRIrI6+BKfN4IukvQvl3tHsdFsWeM4YdIwhZvl+MMYtX8xFKZkISFWpxg==
X-Received: by 2002:a17:907:7f0e:b0:a72:4444:79bb with SMTP id a640c23a62f3a-a780b881cc4mr674810566b.59.1720680710879;
        Wed, 10 Jul 2024 23:51:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNGa3iTLDkJs9r42QlkOKMbEzsJfArWsJUH4Y9CnC2eN/9R9XztdP8hv+banbSj19eiMhoRA==
X-Received: by 2002:a17:907:7f0e:b0:a72:4444:79bb with SMTP id a640c23a62f3a-a780b881cc4mr674809466b.59.1720680710535;
        Wed, 10 Jul 2024 23:51:50 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a86f620sm226365966b.209.2024.07.10.23.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 23:51:50 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Lee Jones <lee@kernel.org>,
	Karel Balej <balejk@matfyz.cz>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: repair file entry in MARVELL 88PM886 PMIC DRIVER
Date: Thu, 11 Jul 2024 08:51:40 +0200
Message-ID: <20240711065140.140703-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit f53d3efa366b ("MAINTAINERS: Add myself for Marvell 88PM886 PMIC")
adds a file entry referring to drivers/regulators/88pm886-regulator.c,
but the directory is actually called drivers/regulator. Note that there is
no 's' at the end.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Repair the file entry in the MARVELL 88PM886 PMIC DRIVER section.

Fixes: f53d3efa366b ("MAINTAINERS: Add myself for Marvell 88PM886 PMIC")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3eab44bd1010..bb7b5ecbc0b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13495,7 +13495,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/mfd/marvell,88pm886-a1.yaml
 F:	drivers/input/misc/88pm886-onkey.c
 F:	drivers/mfd/88pm886.c
-F:	drivers/regulators/88pm886-regulator.c
+F:	drivers/regulator/88pm886-regulator.c
 F:	include/linux/mfd/88pm886.h
 
 MARVELL ARMADA 3700 PHY DRIVERS
-- 
2.45.2


