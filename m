Return-Path: <linux-kernel+bounces-255115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C3C933C45
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47C432820A4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0CD17F4FD;
	Wed, 17 Jul 2024 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="oKWqSJZ1"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9398617E919
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721215769; cv=none; b=Maszvo94OSKrwPOJahzutm5M0X/v7lq0Ka1BiHlV7F+sNsV8iVmX8Bzqp7PCsIFgi23LoBk0KSgm5QEZlJNQPAPBvn8g6GzypVNp5s4BS/YMFTZAziRjUO8J8lMsk6/VQ+2O+qVv1F4Yi6Ah3GMZGT4lw+nIxt1SAOSszTaF6DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721215769; c=relaxed/simple;
	bh=DVb7x2gl14AvOaSEC+osM8d1bK0rFnQnBJXEeVyVkDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gtouyO4+J8zi1d1XB+K12HdkkC95zW/hdA24+I2ABVlHUw9zH/HRLM89SHHwRHpVct7PGCknWR14rwkZupNOsqnpU6BEhFDfbu1Nboa5YBy5nzgV4uTuFAcaoeUcZvOq9tBXJeqWUjc2W8QAf1W0lDjzyecOGdqo9jLX6artJW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=oKWqSJZ1; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-367990aaef3so3890222f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 04:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1721215765; x=1721820565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iY1y6wYGSjtZMnVjTLV+b3g/W0zFm2cTH9KXMU2ByiU=;
        b=oKWqSJZ1hyFwOKJwrUCvDHKo+CQ8b5gibp9SpP4aScELKyB6eOysfA2maV5pwP2goH
         3a3DGA6JhYEvaBoFHIfLUKFmcHP2YXD9xgjGyhFjqbBg8x8lJ3NUuPyUPBSZ4zO4xqg3
         HzIIczSFNAOd/Zg6/A+A9t4MB3bjChNvcrSLanFAdDhcgCvXfZnzxaIP7RIhzEi6QpdS
         iDeX8Iw89RqYmeYL6ru3WZGCPYoLFQC4GXVLacXnVYZ3vHqnp4XawVWntny19aWHmmC+
         GG7n2ZHVhBrNJOK9vSdDbs7O3hB7EhxNAPVmwyz5LlTSiA89sfDupCftVFwhvVljjU7p
         8ntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721215765; x=1721820565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iY1y6wYGSjtZMnVjTLV+b3g/W0zFm2cTH9KXMU2ByiU=;
        b=InPInXyIfYQc6mzkYCLSdLmBljRmXKe4h4BJC+fdN1eaeQeNRltdzOZ0m7P/JfFVS+
         lg3ePbEfqJi2zRgz+VEUxyHyGkGT4QFdDqXrt5Jj70D1DNQO1gfYUx33TJwgVKLaz55A
         zElIGutSn7477sC2OuE95Mr5Ez8XHPDwGkfOfsenmKc5EIP065QjVmp6pRZDDLZGOh/3
         1gcZHy+SP5ezEXYd0qv4zPxMcUTAiqf5LrOsca56JZR9/yRL+esKUI3W+aZDc9L8p/I+
         RRW5SdrofxdDZZVZyiQQiDbse9lMlXAz42unNgJykevx3cRCVMVRJTXpvwbCp2Sin5G/
         2RhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu+9Bd3c+ZPlm8Wgn0CjTKQZ8wj0D8cPPj5u3FQ78pNu0DAftnGMCGAQDPHIyBrJpbK/Yo1WnYDG9RXdnZJJ+yaIj9wyeTNJr0XE6Q
X-Gm-Message-State: AOJu0Yxs7lZH7zErikScjOc9RaXGIAYbMEpUGi7mFPl/3Jv8o2DnLFML
	71J3yNEnqjH/qi1SpRoscxQrK4vdbdQvOucBx+mPlBYMYQo5Vp3QaNFAvV6Rh0JzAvA9p+ikU2P
	m
X-Google-Smtp-Source: AGHT+IFMWzVldVdBWF4pRxiboBHuzPXsITPpLZRME2GrWdHdWtJKHxsw917G8ATW2rXO4ut+o2+y6w==
X-Received: by 2002:a05:6000:71d:b0:368:255e:ab13 with SMTP id ffacd0b85a97d-36831722ed8mr1384259f8f.50.1721215764667;
        Wed, 17 Jul 2024 04:29:24 -0700 (PDT)
Received: from localhost ([82.150.214.1])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3680db0492asm11375872f8f.103.2024.07.17.04.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 04:29:24 -0700 (PDT)
From: David Gstir <david@sigma-star.at>
To: sigma star Kernel Team <upstream+dcp@sigma-star.at>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Richard Weinberger <richard@nod.at>,
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Cc: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Gstir <david@sigma-star.at>,
	stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/2] KEYS: trusted: fix DCP blob payload length assignment
Date: Wed, 17 Jul 2024 13:28:44 +0200
Message-ID: <20240717112845.92088-1-david@sigma-star.at>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DCP trusted key type uses the wrong helper function to store
the blob's payload length which can lead to the wrong byte order
being used in case this would ever run on big endian architectures.

Fix by using correct helper function.

Cc: stable@vger.kernel.org # v6.10+
Fixes: 2e8a0f40a39c ("KEYS: trusted: Introduce NXP DCP-backed trusted keys")
Suggested-by: Richard Weinberger <richard@nod.at>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202405240610.fj53EK0q-lkp@intel.com/
Signed-off-by: David Gstir <david@sigma-star.at>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v1 -> v2: fix ordering of commit tags, add s-o-b from Jarkko Sakkinen

 security/keys/trusted-keys/trusted_dcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/trusted-keys/trusted_dcp.c b/security/keys/trusted-keys/trusted_dcp.c
index b5f81a05be36..b0947f072a98 100644
--- a/security/keys/trusted-keys/trusted_dcp.c
+++ b/security/keys/trusted-keys/trusted_dcp.c
@@ -222,7 +222,7 @@ static int trusted_dcp_seal(struct trusted_key_payload *p, char *datablob)
 		return ret;
 	}
 
-	b->payload_len = get_unaligned_le32(&p->key_len);
+	put_unaligned_le32(p->key_len, &b->payload_len);
 	p->blob_len = blen;
 	return 0;
 }
-- 
2.35.3


