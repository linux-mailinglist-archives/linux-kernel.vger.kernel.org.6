Return-Path: <linux-kernel+bounces-239498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 685909260F0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998251C216A1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B336F179970;
	Wed,  3 Jul 2024 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="ZtnmC/Ab"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4338A178360
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720011246; cv=none; b=KMjN2wkQrG076PDlO1CTDYYKd0HsICVG3tzFI99WKDtlhKuj+7zz6xPah/orvGWfCn34ZONA/T00iNMqJyabBIXRkWJfe+sHVFAyZ7GC0RbAbyukyd/nip7AfXaiKka0326YyUtFfYZh3LI21Kcv2CQlczTQohmi3ilZGaRUxfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720011246; c=relaxed/simple;
	bh=icdGIhylB0lXVqhQ0Oq7EE1+CLenXFSI1YMAf1lrq+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=awB3DKzC0L1/1jHGw2C+OA9fktgqqPNp+H81WKLYd8aGpcICmep4McrFDioz72tmkh6/cxXeliy5IMtx7lPFwtu+++XYa5ETrXuwp5YqJU/z4ihD8cOJDIrW5MW+ps/Hf+/7FmAuBN42jrvYAakTYBzLtNTLpk9ideUMbr8P2Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=ZtnmC/Ab; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-367975543a8so186880f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 05:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1720011243; x=1720616043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yzx9VHlc/8h9m6p3SRKEm1Y4xLQisswwlqQ+JvkCTDE=;
        b=ZtnmC/AbZzQDFm3e+qe1qL7U9It+RJ0V9zshhUBc9BGDawvbKrGpVuWVLsVFo7WjjF
         is8/hqshXxPt/nHmfx5CBBLHdSWMyX+9krMVsPu+yL76Qwc3+pJa35SpZqWYWw093bdW
         2smyX5BENKzeuRB4hwUG3wGRil1yz6OzPxpasZRFH9k6JL+m5zERzv5+jISBsyBiny/x
         P1l69+zPmXeOfyaa+4qkaa47WEccm038Quq/lLNiIftiACAfCb5/wvdXe2kJiIIBuV3N
         JOXw258OKl2OQtAi3b5NriUN0f3lL8lrwNrCWn1G/2pAN8TZR4RCL3k27IhB1lMTgbwo
         StmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720011243; x=1720616043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yzx9VHlc/8h9m6p3SRKEm1Y4xLQisswwlqQ+JvkCTDE=;
        b=jRrESS488m97mCqx09BiCCsFu8yUFgPe1r8fw78YUt6mUXu3WDmnyhetX4YaGScPOX
         +D6yGA7vImb90jf/MfeCr8saKWvPSlfKoGQkjIJJPBs8MjxL7CSxA4sC4OLMjAOyktWn
         1CVGKqDHAU0XKm42RvYv35mPSccs/LOuEn8et9bXVnlqlXrKC/dNkQ37rlGESJAK1NIW
         ffk4eNmLw9BFWMPX2U1sv/9f6IiVi241DtePA99CB2Qq1DSjxdMnINWnknxYWoClgcU6
         6D7qMqTozgb/BLVvtTx+JRybo3eo80XhP1w/0a+0fjl9zvx8BuWNEOqUBMpAeq3sf1LY
         ucmA==
X-Forwarded-Encrypted: i=1; AJvYcCVUM37lsHCzh6UaQwinO88DimyAVnVtofR1UixjnyUrrRud6nFZCXPmMTjm/BQEvMeGxARhTl1LW0SAHXNwMKxKkoC7csU+xrM4oa/n
X-Gm-Message-State: AOJu0Yxz+W7pdMrRQbxsKTLCC98JJEVY1egCvh3+LHl5mZAqlfrj7E1Z
	j/iNWw/wtTUJdWARCC7rdtQmnvfKLQ2N7iE+0v+7mdbSgxkqa8QimbeyUXk0Jl0=
X-Google-Smtp-Source: AGHT+IHKkT/F7VYwbLXQnp0PsjNCbmpL2tzMJ16ri/aVmQvC719AC9zQFGR8qEFOdoj3yqk4lIc+HQ==
X-Received: by 2002:a5d:648f:0:b0:366:ee84:6a73 with SMTP id ffacd0b85a97d-36775696c16mr8572598f8f.10.1720011242537;
        Wed, 03 Jul 2024 05:54:02 -0700 (PDT)
Received: from localhost ([82.150.214.1])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3675a0d8daasm15703542f8f.30.2024.07.03.05.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 05:54:02 -0700 (PDT)
From: David Gstir <david@sigma-star.at>
To: sigma star Kernel Team <upstream+dcp@sigma-star.at>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>,
	Richard Weinberger <richard@nod.at>
Cc: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Gstir <david@sigma-star.at>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] KEYS: trusted: fix DCP blob payload length assignment
Date: Wed,  3 Jul 2024 14:53:52 +0200
Message-ID: <20240703125353.46115-1-david@sigma-star.at>
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

Signed-off-by: David Gstir <david@sigma-star.at>
Suggested-by: Richard Weinberger <richard@nod.at>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202405240610.fj53EK0q-lkp@intel.com/
Fixes: 2e8a0f40a39c ("KEYS: trusted: Introduce NXP DCP-backed trusted keys")
---
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


