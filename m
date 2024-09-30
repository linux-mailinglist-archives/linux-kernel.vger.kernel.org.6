Return-Path: <linux-kernel+bounces-343645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8532989DA9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAC921C21B87
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5C8186E3F;
	Mon, 30 Sep 2024 09:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+4e/pEq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B8E15F3F9
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 09:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687226; cv=none; b=Ex2BLcvI+Wg5ssK3khUjqBPXQLz+ngS/zqEzW9Jz3jHqsfWDHBsR0z+c4Q/b0HlieU6VeWlKf/B28mCHmspcB60uCZi4m00wuIArXkat5tm6/aQRe5yfiaV5K+2fXrkmALBhgeHoe5E5y4JO5A1l74lM/M22XAldAaMKL+/IxVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687226; c=relaxed/simple;
	bh=DE13EWTiMILf5JKwU/GXueM8kuKIjVMYjFc9TjYGgkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g48e5fg3YagllLo8pw3LDtqIpThwewGGcvcYEFYoSUg1Kks0FWJyXgv7yjNTSo8kT39HoNUr7rzNg6UK1z4MHhKa+zpzp0dCYBh3mW1k5K6y0scPq1BUfvj3/qo6hn7+ylNW7w+4tZ/gUGI7CMiwamMYHqmRYFddd9I/AOlm6FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G+4e/pEq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727687222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4u01cAsPRXMfLMKHduDcaVv7r4IZcMZeUecRC7OIn6Q=;
	b=G+4e/pEqFU2TGSNTgWhy9k42g5S7eOfPtLV/ssFUxZXjWrYz/48wNs3pxY6WJzvJZT3lrI
	1zlrnv+juti8XrWTjJtFw6pbpiREuUcsx4qIpN38mntj0KH6nXZ3t3TaEIUunwdxOgD2pw
	hY7Tm3+QJ+fxhsV2iXNeC2OWG/zaHCM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-mCaNJgDNNtWcA5Hfsd5ufQ-1; Mon, 30 Sep 2024 05:07:00 -0400
X-MC-Unique: mCaNJgDNNtWcA5Hfsd5ufQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7a9bb56da15so547946185a.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 02:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727687220; x=1728292020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4u01cAsPRXMfLMKHduDcaVv7r4IZcMZeUecRC7OIn6Q=;
        b=lXoxrtIS2DlG2JJWcqxAT6eO3lKhV9/+mXImJF0e3RXhZOcdBtRs/0jrjD0i1K39vE
         NgLeI/rrBUMgL33JUpYGi65SmWfDQG+gihphugKPIUZPWQrSOpfeoZ4Ao+xjgZaxFLKn
         6vQTJAhrlUCcVqxfa8EKnuufz8T6heRh5Kr0kJVONk601QKLClanJ5r027vJXX9VOPrm
         ZSwCEDp+w2y4MmOHC3LeNDQyzTWSRtowVDnFpuK4OadE8NfdzWa41cMFU5aS1ebGueNi
         XMKVR23CweYcTsNr+jORrUOn0RZcgfMkTrbu171Ezi2IM7CJ2+DOc6lVBetucqrHQ7b7
         28zw==
X-Forwarded-Encrypted: i=1; AJvYcCUNbV9cUpNMXFBjla4fG9gLopY4dcd4wqYJzUMPh7irSd8WZnx3xyS2ALcb8avDIYRXM/J3iWbzySJYY54=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgKyrbPNcbUK4mMgefjUyGy2w4BRqQCYp4zZEB50deeE/Jb+cS
	yuxQw/hQTwGCq5QwaSoceapP6fkQjjfdUtcKkruANtrDHLzkwpsFoyIa8VL/gI97ML2F0ZE271C
	MWtZ7MpqlBo8Nzvyfm5iT3bEPR1WpYZ4eKsXd3RS+iq5sbtEWiqYqJVwIKOCeyg==
X-Received: by 2002:a05:620a:4411:b0:7a3:785a:dc1c with SMTP id af79cd13be357-7ae378c2881mr1647589885a.50.1727687220324;
        Mon, 30 Sep 2024 02:07:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY5T8VGvZ3aIE0DDn8rVPjKRXbu6y6uMYwxygTdlRa8sPUaFmTF1esGtF8Kbf2pgk46TSyvw==
X-Received: by 2002:a05:620a:4411:b0:7a3:785a:dc1c with SMTP id af79cd13be357-7ae378c2881mr1647588585a.50.1727687219962;
        Mon, 30 Sep 2024 02:06:59 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae377f0ea7sm394435285a.61.2024.09.30.02.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 02:06:59 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Jiqian Chen <Jiqian.Chen@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] xen: Fix config option reference in XEN_PRIVCMD definition
Date: Mon, 30 Sep 2024 11:06:50 +0200
Message-ID: <20240930090650.429813-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 2fae6bb7be32 ("xen/privcmd: Add new syscall to get gsi from dev")
adds a weak reverse dependency to the config XEN_PRIVCMD definition,
referring to CONFIG_XEN_PCIDEV_BACKEND. In Kconfig files, one refers to
config options without the CONFIG prefix, though. So in its current form,
this does not create the reverse dependency as intended, but is an
attribute with no effect.

Refer to the intended config option XEN_PCIDEV_BACKEND in the XEN_PRIVCMD
definition.

Fixes: 2fae6bb7be32 ("xen/privcmd: Add new syscall to get gsi from dev")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 drivers/xen/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index 62035fe16bb8..72ddee4c1544 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -261,7 +261,7 @@ config XEN_SCSI_BACKEND
 config XEN_PRIVCMD
 	tristate "Xen hypercall passthrough driver"
 	depends on XEN
-	imply CONFIG_XEN_PCIDEV_BACKEND
+	imply XEN_PCIDEV_BACKEND
 	default m
 	help
 	  The hypercall passthrough driver allows privileged user programs to
-- 
2.46.1


