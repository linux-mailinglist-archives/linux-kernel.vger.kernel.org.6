Return-Path: <linux-kernel+bounces-331619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDF697AF10
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9EDC1F22411
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3F316A37C;
	Tue, 17 Sep 2024 10:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mk1yY+Ur"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4B616130C
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 10:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726569608; cv=none; b=IzUcJctaISK0bITbiHmBkjT32Ik+NjAyoxWHCtowS0BMJM7Xl+3G6Bl+a+UZVHc3c7apk3WRAEahbsFOWJODeK6QBljlxB2xmbRxOZg+ZY3OLAy3/DpKMlZk24elbYyqgix9z/YPGbkv0N+UP3KUOyz0f+h9BUdAyjXi0Hgre4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726569608; c=relaxed/simple;
	bh=0LMBN520YvnGOafFgvhLjT6qIlZcWSGFYJKW35052PE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AV0OszifFi6UrYfn0GmEBPPxSE8JakDe0qKzF27ZgwITZJym+YpHI4el3UO88bd3Tppgffs0xdDYKq3c3pH2MKAyNpMUzBtDMkeF7O/1qDGYVwrmuYmO5W7nuWZbL7T8VQeQgJAK4U76ef0LZ95czY7kZAcRTp5YX2TRfnY44DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mk1yY+Ur; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726569606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K8NsOdWTBNIM1qx9lP6F4iSdy29rXjvavRpAqXtZKsU=;
	b=Mk1yY+UrlVMhFFAVFGel8B1+I4njXxSkc3i3O1vQX+cfbxerh6nPNIVGGiCZrhJKQ3jJ1s
	zjskjNMFf2ZB431jpt5C/IVywPcmLQWZNU+naozx/2wjtUvrQD/wgPy/aXxvZl4gXjFN3n
	qw94YLx6ce9/Lv8BxNkVcj00oZD24+Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-XO8L68teN_aj50LlCdQ-nA-1; Tue, 17 Sep 2024 06:40:04 -0400
X-MC-Unique: XO8L68teN_aj50LlCdQ-nA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374bb2f100fso1950144f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 03:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726569603; x=1727174403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K8NsOdWTBNIM1qx9lP6F4iSdy29rXjvavRpAqXtZKsU=;
        b=TZW0Hdn6PgcZruQ0qgbBjb4iJ/N/1WfWOFLx86M7ZtFv7XYLVlUtc8MIWPpU0u50GW
         JDRJRWR2J1FMG0/tvGm4h9TEb8aBHEm10W5ct+CIH/IFKE2pjj/ncOskvbS3FJgI5AXQ
         DEXOYcOjoEtqV0UZyOKRgOFLaGnSbti93664jWrMw18F3O+xAwr9xv388puTpGfWnSvx
         r4kTLKfDemHJBHgKKs5WBR6VqX87ROhnFieJ51Ye1gLQMunR6t4QBrngTTniRxVPLf0K
         I7WoSUechrgx+LkTImh9E32/u3rMB7/tsv1JygzoPLS5t0mRB1r9Q2fsp8OS70eaXxi5
         uoVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV22mJFAMxDrOsN2NChL9COBc5o6Zr+XCdXOIFaht9iU76PivQvOfkL6itKfRvC3ywQ4yivnk4Rhisk8aE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpxc3lGsJVSIA04XMVOnhqBXS0DP+gDBMZ1PajLsX3bJeMsLEe
	VnKK3x9rjZhUs3J1LIMuHYDexk6xYaGXFmyB21OBZXOrRmqFfpMQo9q9WJLAxE/sNPfUxG5pmg3
	LASSGApG/vvvwAVVtPPg//OCTw/a3jQ9MQTmkVNAQsWi9Kt//Y7x+TkWc19MO0A==
X-Received: by 2002:a5d:6892:0:b0:368:785f:b78e with SMTP id ffacd0b85a97d-378c2cfc259mr10196602f8f.13.1726569603381;
        Tue, 17 Sep 2024 03:40:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa4UI97Csxn3j4pYvJYFP/Fr/uiCCt79JPc4rAJ1fBKy2utflgkB7c4Go4SgMPtMwX0FZF9A==
X-Received: by 2002:a5d:6892:0:b0:368:785f:b78e with SMTP id ffacd0b85a97d-378c2cfc259mr10196573f8f.13.1726569602833;
        Tue, 17 Sep 2024 03:40:02 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780007dsm9183869f8f.82.2024.09.17.03.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 03:40:02 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Andy Shevchenko <andy@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust file entry in INTEL MID PLATFORM
Date: Tue, 17 Sep 2024 12:39:55 +0200
Message-ID: <20240917103955.102921-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 5f1cda51107f ("platform/x86: intel_scu_wdt: Move intel_scu_wdt.h to
x86 subfolder") moves intel-mid_wdt.h in ./include/linux/platform_data into
the x86 subdirectory, but misses to adjust the INTEL MID PLATFORM section,
which is referring to this file.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Adjust the file entry to this header file movement.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4c4116045664..9a4fa88edcd3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11646,7 +11646,7 @@ F:	drivers/platform/x86/intel_scu_*
 F:	drivers/staging/media/atomisp/
 F:	drivers/watchdog/intel-mid_wdt.c
 F:	include/linux/mfd/intel_soc_pmic_mrfld.h
-F:	include/linux/platform_data/intel-mid_wdt.h
+F:	include/linux/platform_data/x86/intel-mid_wdt.h
 F:	include/linux/platform_data/x86/intel_scu_ipc.h
 
 INTEL P-Unit IPC DRIVER
-- 
2.46.0


