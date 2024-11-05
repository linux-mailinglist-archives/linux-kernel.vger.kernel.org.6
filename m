Return-Path: <linux-kernel+bounces-396671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABC09BD05F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C1001C20BAB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F181DD0C1;
	Tue,  5 Nov 2024 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TwCc8adw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26C11DA60D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730820509; cv=none; b=L6OzJElC7HVFgxXhIvED58ZRdEmUxmJhngdGM/vr0MYhsCPCkaWyEC8T34MolDhlUH71mufyAlSyImW9NKC4K8n6qvVb812e1dp5z0F9huI0hw8Q7srUHGvGTZqttJ0Lt95xEPggWBJ2DUAO9sb/riKWaMZZ07XzMuWA8EU0L8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730820509; c=relaxed/simple;
	bh=koya1W1nzWIe32bX6FCUiIbJTuzU7rznDrUGuDE82EU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fBCW2qRq+ct1RO90R5RkkMFtGVl7AXeebJ2Y/FPPjrjp5d0XtIGWZZ/6HBEN7LNM4OzfW0IkxuWNHWJg4L1t10cvhDSWo8pSBzwEOKUB8eNBCHZkeP1M+PftC78W4EditHnMTTHWUVpt1lRdZVrn9DZmDFLeIxfoDDTVKvr3Gus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TwCc8adw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730820506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/BHZqjA869XTgUt4zd08lmfD1No0TmEngRpCXfkSKAM=;
	b=TwCc8adw52HQV+6dVJtYGC2OYG2tkt6R7typXbLHCTptEkmyTlvQhxf5/IjmBAEDRmN23P
	hWjAVNvvMVzS6emM4NUyHdGpHTqOZJPEjJbLqrBkMnqklRCrrqS9NMNjwxRuVBj80JYQqZ
	qLPjFAT5FY78kqMW+EtXw1PFCBMI2nk=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-t4bwRULPN96ifw4a4olSKA-1; Tue, 05 Nov 2024 10:28:25 -0500
X-MC-Unique: t4bwRULPN96ifw4a4olSKA-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3e5fef7b292so4114822b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 07:28:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730820504; x=1731425304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/BHZqjA869XTgUt4zd08lmfD1No0TmEngRpCXfkSKAM=;
        b=WhxR9/kzDOJAoIacKAtkXhyDKdL8v8EuBfuU/m+fFtFGqVZtsAj8z6/0SjHG5X/QhL
         TXkYEN2jWVXQmshTm7QVeFKTX60H12zJ+aJ13VwC9WKNg4Ggb1BDjwu8U1FnXuyXi8ko
         Hbus5sca0ADbJ/jvmRILO7rmRZnPwi8ayvcwLY/yV8pR60N5fRB09NI1Bi+PTNNjXjiW
         GQN5fUwxbSUs7GgYPPbY6roCrSyuj5mcYAhFLO9RVAcJZWyzg6O7do3xakHpz61Sk7wn
         p9j6d9C11cafrz+kQbS/lH+APqgi7eG3evXUkyVn3yVK2BBQc8ry/pQ/iSkRVyomUWEW
         7uhA==
X-Forwarded-Encrypted: i=1; AJvYcCUsmorJK61XQmCKv5DeEJ0MaG/QebXaKc9muKsPWxOmyz3zHDH08vu+3EEvUW85VV0UWeJZof6/GVx0sv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTT1LkKOrfjMhmpX/O1oy5PBF4jj/mhuDcxJcl4Xq/ES5qxh9a
	HDGQ0pm6nE+bi4b0tZt2CqKTYv9hsTukvdxib2SNQ5blwKj5A6o6pk+2LDfNb68BoCeJgHmGOQI
	8eDHaunBO7enVWHIaHdbxq+yyjdIqOk28KyvHcqC6FkGs3mSIhW8nBspbEYi7tA==
X-Received: by 2002:a05:6808:1a13:b0:3e5:fd5a:d3cc with SMTP id 5614622812f47-3e758c1e383mr15987669b6e.16.1730820504490;
        Tue, 05 Nov 2024 07:28:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEM4h5d/5NTRGyzrdFGDivSjfzdTU4SI3JAKtmPsDLW3+Bpn/Y3lRnzvPnwJvRB/5b3fWrucw==
X-Received: by 2002:a05:6808:1a13:b0:3e5:fd5a:d3cc with SMTP id 5614622812f47-3e758c1e383mr15987633b6e.16.1730820504068;
        Tue, 05 Nov 2024 07:28:24 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e661259698sm2528540b6e.50.2024.11.05.07.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 07:28:23 -0800 (PST)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust file entry in INTEL TPMI DRIVER
Date: Tue,  5 Nov 2024 16:28:13 +0100
Message-ID: <20241105152813.60823-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit df7f9acd8646 ("platform/x86: intel: Add 'intel' prefix to the
modules automatically") renames tpmi.c to vsec_tpmi.c in
drivers/platform/x86/intel/, but misses to adjust the INTEL TPMI DRIVER
section, which is referring to this file.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Adjust the file entry to this file renaming.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7fba9faf48c9..31b2252122ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11851,7 +11851,7 @@ M:	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/debugfs-tpmi
-F:	drivers/platform/x86/intel/tpmi.c
+F:	drivers/platform/x86/intel/vsec_tpmi.c
 F:	include/linux/intel_tpmi.h
 
 INTEL UNCORE FREQUENCY CONTROL
-- 
2.47.0


