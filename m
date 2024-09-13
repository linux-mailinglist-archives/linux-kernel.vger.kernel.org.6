Return-Path: <linux-kernel+bounces-328100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6F3977EDB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AC011F22501
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D986A1D88AF;
	Fri, 13 Sep 2024 11:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bBmqOddq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A941D6C7F
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 11:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726228236; cv=none; b=okG4KMvTpHaChPm9hAAIoZUIYVSkBEwNGqS+qe+CEuhyvCluc6b7h1yfDaO55fcxvJd12h0pcSsZ6IKmZHSptmTNRrjJQnNCs6sengWy8HM49ycdWjNWKeAHvjzd+mSsGmOCTW0F5OyTOI9t2smNo4iArW/9FpwJuvWqogsrkCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726228236; c=relaxed/simple;
	bh=6+CCqLiTlnbAOqwKpOu2V8VVZpz4SFARlyK/H9WWw1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=as0Plv4ozffT+9MAJ+mMMfkht0YjKGwCEqmi7bLohlGYGCVQx355tA4CiTLWBCJhfONbXherkFaAX5+1eauswGddZMQ6H4zFRaHsvm6hG/nXEBKALjdeRlSKnT9ARrZ+hSptU73ystcReFEpdcQn9j9SezLFJsPHPix5mNyRlZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bBmqOddq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726228233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DzsuH7HNLxmJ8c6STpWbL+svm6fJdpP+EHkpqLBMKjE=;
	b=bBmqOddqSzN3hHqM0k76XXdZrsa3sI/k/HRjskbPCNJYZlmW+84iIKt0eb5q+rjzuSySRb
	kl0UrCzyuzsxK+zdjOVJH8zyvWNzX4h34a/MhWIb4WafG7hlz3BegQWqhayGG0M17DVAj2
	RavSTBvmP6qyTAPoKESDrpM+cWgow6w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-XLYpf6wvM6GiBnbQUI-How-1; Fri, 13 Sep 2024 07:50:32 -0400
X-MC-Unique: XLYpf6wvM6GiBnbQUI-How-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-374c581ce35so1099889f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 04:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726228231; x=1726833031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DzsuH7HNLxmJ8c6STpWbL+svm6fJdpP+EHkpqLBMKjE=;
        b=eYyZ1q9sEwQtQVzk4IRxUAguf+RbHR1qtY5ebA/44NsrR3cHRP6CInd286xCRj7tzI
         t2SOrsM9lg+osh4gQJOrSnl+Iw58+sPcbh0Bk6NyJaleCQBAvrEzqldIIWpndge/ghKH
         2AI4XUU7BGU2X6++26f6+upAlbuoryQyuA5ADF/8yAXGHb2iq4kwxjtvBk7Tgl07Zn3E
         ZeybxWVvxMBUOzLGrYIKcNOLVkdleQG4A85huxYRXFRXilpsQjb5aU18+HwdNIvrK1b0
         AoKmZuwaBZ68uUHzyAGx8f8jOFcOtc7rcaWu8krvog4w36YaLxS4uYcoDIQs2fYLNYul
         tRPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmSyfGz99y3NciOAuflbBpDxKikQtJJOVmi8sMRb4h5e8T+FkVS2ni/yJx8mfOTnUEX7e5UxBYuvGzzYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB1vuBzuDrC8kRpsLe72AOc0L6+9N+aRDMWn4hSVJr7BMCLk7U
	VUOrOZlRHWL6ErnjvX7kVVIR+AVFtS+8hAluef1kJKSTJgGlj10Ya1U/yqzp0DKrxRfK6Nwwl6q
	JcydrDWFMsvk1/oWaL8jMZdj028m06Qgw2b6xWA+SG2s2OauUcEaQqrDvsT4SOQ==
X-Received: by 2002:adf:ec05:0:b0:374:c45a:8afb with SMTP id ffacd0b85a97d-378c2d0751cmr4180377f8f.19.1726228231273;
        Fri, 13 Sep 2024 04:50:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHJ1H8Rwnaa1DIdW+rQ4X4iS0OLgLw1U12qROIerX9bfZfLhkIcHw4REHfmZmfNMyqXWcA2A==
X-Received: by 2002:adf:ec05:0:b0:374:c45a:8afb with SMTP id ffacd0b85a97d-378c2d0751cmr4180360f8f.19.1726228230716;
        Fri, 13 Sep 2024 04:50:30 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b05df7esm22569645e9.20.2024.09.13.04.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 04:50:30 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Lukasz Majewski <lukma@denx.de>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Hartley Sweeten <hsweeten@visionengravers.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: move BK3 machine support to CREDITS
Date: Fri, 13 Sep 2024 13:50:12 +0200
Message-ID: <20240913115021.58405-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 3e0bae7f35c9 ("ARM: ep93xx: delete all boardfiles") removes
ts72xx.c, but misses to adjust the ARM/CIRRUS LOGIC BK3 MACHINE SUPPORT
section, which is referring to this file. Hence,
./scripts/get_maintainer.pl --self-test=patterns complains about a broken
reference.

As the corresponding file of this section is gone, remove the whole section
and note this previous contribution in the CREDITS instead.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
Arnd, please pick this quick administration fix on top of the commit
above. Thanks.

 CREDITS     | 4 ++++
 MAINTAINERS | 6 ------
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/CREDITS b/CREDITS
index d439f5a1bc00..b2f16d191f3c 100644
--- a/CREDITS
+++ b/CREDITS
@@ -2539,6 +2539,10 @@ S: PO BOX 220, HFX. CENTRAL
 S: Halifax, Nova Scotia
 S: Canada B3J 3C8
 
+N: Lukasz Majewski
+E: lukma@denx.de
+D: arm/Cirrus Logic BK3 machine support
+
 N: Kai Mäkisara
 E: Kai.Makisara@kolumbus.fi
 D: SCSI Tape Driver
diff --git a/MAINTAINERS b/MAINTAINERS
index deb3c0cd392a..7c9c88d447e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2257,12 +2257,6 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	drivers/net/ethernet/cavium/thunder/
 
-ARM/CIRRUS LOGIC BK3 MACHINE SUPPORT
-M:	Lukasz Majewski <lukma@denx.de>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-F:	arch/arm/mach-ep93xx/ts72xx.c
-
 ARM/CIRRUS LOGIC CLPS711X ARM ARCHITECTURE
 M:	Alexander Shiyan <shc_work@mail.ru>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.46.0


