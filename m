Return-Path: <linux-kernel+bounces-171592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC84B8BE624
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05701C22159
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950C01607A7;
	Tue,  7 May 2024 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ILhQRlYz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FC915FA80
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715092607; cv=none; b=T8a767x6B/458rZhcoMmmouisSdiZQuPk+cCPY85rY0nf9Z4EpsI5CBf0TkRhOY2fAm0HvUHdEI66mzM3JV8MWqAi8V3NnicHWiQYUwYzl3ITCwIBv63mMtdJFZsUheD7LgRCYCEMmhT8QsQrNdUM51yizK0rC0I3qTTv2MO1Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715092607; c=relaxed/simple;
	bh=1nLbM1ptcwD7xsCexw9/9id1x6y7D7jbqpEOYd4k+OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ooZvYVmExKc6ouiOj/+eTdPiLhBvjpP+DW5Utik5aALY4WLuqlkt8v1pKTf+fYTrnHtOoDosqsI9jzuJyRvblxAZLFqhAzzMvmlz2JFvFrsmnUBd2Z6dVhwLidUSjSvMGs5NV5EYfGnYkfui5rgpKvyljOqo+Y0f3gkswlJ9Qrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ILhQRlYz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715092605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q7HVnwjvSt8iPkONjlCrJffpYCEpxZC33LnAmwF0ZIs=;
	b=ILhQRlYzqrXvAdzE8hk7MHI1+vw+f2LtDANipBY7cSzv3F4N4p48u9VlBdV79HTZ2k9Zjo
	xuFut/3i+htCWtMkIPMmeB3a1ZiH8ftEYx7jPvxhhZJ1rID/LsWKXqRP5NtnJK0YLqYt7a
	KS57PyVIjaP4n2O0vjU08d4jQUWkvAg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-TJHaL40tN1u07flWbrRGSg-1; Tue, 07 May 2024 10:36:43 -0400
X-MC-Unique: TJHaL40tN1u07flWbrRGSg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-572afd6e96fso1332521a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 07:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715092602; x=1715697402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7HVnwjvSt8iPkONjlCrJffpYCEpxZC33LnAmwF0ZIs=;
        b=u6wQ+K/bMj48CBag5NjmetlNN7POT1/Bja/v7miszbIzPUWlLfvNpqD0cr+y1q6zfP
         gUjAD3IGum2sBt4xujI47YKHvsH3UzdlpKNrQeuTFn9hkkQOjNWEWlWDUrk6uGXzhK2t
         eZq3R84H1z2k5Fl+yQInq5WDKi1xuex4bBHIDC0REdFlcJtm5v+sxFs7qaM6HjSyepcX
         dIwMUkG+ZsvobdjDDyj2bTbSOfu4Zd3Se/c3HoIoFzTGiZ7wAtqkQ0/9BrupHsNzvaQR
         0JA6qWJ6/PNh+R3kAVKaqr1zSAzoHk8/niiycC+RMRuNOqfuEFku/VnutR99rIozhXM/
         kKlA==
X-Forwarded-Encrypted: i=1; AJvYcCWtGU9A0zW0J7SOxkn3nqZbeX09GDpl83rf7+yWiXHHB3dXp6fwQu1B1SrqmCyj8zz78t++QwF/oq4byjqlFU8gewgoftOnf949RasG
X-Gm-Message-State: AOJu0YzafONmZ8gwYmYXcCwTZ2ohcNIQNilJThdyuXoRoVJ/HEx/duir
	UKPxSOU6TFaLqHWUV/LdXnjJnhHHRidA0rR0+S9ilQchPxzN6DQg3Hdf0J+jY/zOK7qFrkEqRVd
	rxoi5KLQAPxI4ypVwjQmED1l5eCE7qQ/Sz+sC/fOqtiXX3Hcq/QP9k4ZNJcVKpQ==
X-Received: by 2002:a50:cd5d:0:b0:56c:1696:58a8 with SMTP id d29-20020a50cd5d000000b0056c169658a8mr12098640edj.0.1715092602084;
        Tue, 07 May 2024 07:36:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY7d0zX5iF23LmZa2kdYMHYLArbIB3lGdBmgCb7Vbc8ZFRfJsz9dwxj/ZSVy7TQT4rRhoceQ==
X-Received: by 2002:a50:cd5d:0:b0:56c:1696:58a8 with SMTP id d29-20020a50cd5d000000b0056c169658a8mr12098622edj.0.1715092601795;
        Tue, 07 May 2024 07:36:41 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id u1-20020aa7d541000000b00572eebbfc61sm3485364edr.35.2024.05.07.07.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 07:36:41 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: repair file entry in BROADCOM BCM2835 CAMERA DRIVERS
Date: Tue,  7 May 2024 16:36:37 +0200
Message-ID: <20240507143637.179101-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 392cd78d495f ("media: bcm2835-unicam: Add support for CCP2/CSI2
camera interface") adds the new file entry drivers/media/platform/bcm2835/.
The commit however adds the driver in drivers/media/platform/broadcom/.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Repair this file entry in the BROADCOM BCM2835 CAMERA DRIVERS section.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fe4506f9fe8..fe6d37745106 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4176,7 +4176,7 @@ M:	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
-F:	drivers/media/platform/bcm2835/
+F:	drivers/media/platform/broadcom/
 
 BROADCOM BCM47XX MIPS ARCHITECTURE
 M:	Hauke Mehrtens <hauke@hauke-m.de>
-- 
2.44.0


