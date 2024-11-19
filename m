Return-Path: <linux-kernel+bounces-413846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0629E9D1F8B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 06:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05B5282742
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 05:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06D314A4E1;
	Tue, 19 Nov 2024 05:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xx/6RRML"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD95A13C8EA
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 05:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731993882; cv=none; b=s2/47rqMDzOoMvXhsn9D5VgRehLziG8oNGag0UFBdvzDEZCvoTe1GRXnAd2Wv0y4ElVsL4YL2kLr8YLxkGxaL5uSwrcaKuqOGImVXACWNc5uNR+VJn2zPSEYi3o/zTq/etjcO1AsHzFoh/HQGlUnu0NIcVNLO9c9C/PWTLbMxbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731993882; c=relaxed/simple;
	bh=huKZSq7AsqDQQi/yjOF2YFcbbERJ73kVRMzwwYGk+SY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=s1uH7g9ec5t0ccEnjShbPJEBKMWZnmLNt56F2GuST51cFconTlL78v59o1iiA9X3OowYNCfYX8SmlAwomg+AAZbZUl7xTUNaty9lLzke+kjzYtUgVOwEGyBD5hhm9M82zsp3i+RQw8eVM1Sf7Z+pY/cLKriL9BLBjsMKEVyIXBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xx/6RRML; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7f450f7f11dso2033253a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 21:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731993880; x=1732598680; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2h13vk03fzR/7URtCQjKox/jvwcPYdos8Wb7c+GTyVw=;
        b=Xx/6RRMLRzUXIM8UIF21yETiMMnODWeMb1ZQrh4BLoXHtFE1tBkwp59+486AkLGVDW
         Lt8+/1FxKnxS3yE9U1ShrXPUVf6NYhe3u5dla+OQ56iNHEVXuxwK8tA8cjJBXDtvrnHi
         oAjMgtC5uE7/DID8NO95wacUPUV1VCgDsUR9HnpwveKmtxuuoCTh8utX3gu/h5NZ7FLG
         uUBrCH0fdcVi0v58xHEOeBbTNQRg1NpH/2DfqmMRpsXvQ/1zdlspe7i85DnUNmg3rTdV
         TgN4+VvCV5quAggDi/WtNzPufwOCu6eByN31A7TUaMRU55fYDThMzQAN4XIOocAxvkAC
         YfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731993880; x=1732598680;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2h13vk03fzR/7URtCQjKox/jvwcPYdos8Wb7c+GTyVw=;
        b=fl4DipVqjSVASi7dmPIo/Kl834KwKBfoXq5bxDHBphhgyGhvXkocFYtFRBEyinVqbP
         Ax5dywKINzAquMZ7f/UAJo7qVNBOwqfuVQOX8ji5rrOKcpUMNl7ryk2mDPRd7ItqdB+U
         ttfnGo68DwhE7Ri/AGz4lyzYTiSZXwySWm9e2shNu41EjB3ipNujdDOoiVXdb+V3pymT
         Iwk+rEtNx0ZBr95SQMc4WFNTnS3By9kSDIgh7HgwUtYAu+kbCvRfe0/zzdUs7nUH6kdp
         WfuCkNSy9j759sccr68htddqCaSpKEgr+yyjz9RBbbpPwBRTi9CG5DToJLHUJmGAG1Gq
         Jpcw==
X-Gm-Message-State: AOJu0Yz3GSNQh6eML4eLL5nS5zeak7xl3INHcSXnt/DigD0/kTtU/q+C
	AQ8hxCP7pBuLHctJ/FfaV+qGg7W3KTbjWNx14K+jVWHGWJTD54oE
X-Google-Smtp-Source: AGHT+IEde9d4rDA+Tp39Lc3PVIF5ckgEifw40kqfy/b/7A4wCIr+IqOyrb1AEB6dtciUE2OBN8dZJQ==
X-Received: by 2002:a05:6a20:729b:b0:1db:ec2b:7322 with SMTP id adf61e73a8af0-1dc90c18aedmr26856732637.46.1731993879887;
        Mon, 18 Nov 2024 21:24:39 -0800 (PST)
Received: from [127.0.1.1] ([139.5.197.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771e13fesm7201834b3a.138.2024.11.18.21.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 21:24:39 -0800 (PST)
From: Shresth Prasad <shresthprasad7@gmail.com>
Date: Tue, 19 Nov 2024 10:54:22 +0530
Subject: [PATCH] x86/sev: Fix dereference NULL return value
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-fix-dereference-null-x86-sev-v1-1-82d59085e264@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAUhPGcC/x2MwQqDMBAFf0X27IIJIkl/pfRgzEtdkLQkVALBf
 3fpYQ4Dw3SqKIJKj6FTwSlVPlnFjANt+5rfYInqZCc7G2M8J2kcUZCUvIHz7zi4uYUrTp7DYqP
 zcME70sVXO2n//fN1XTdk+v/zbgAAAA==
X-Change-ID: 20241119-fix-dereference-null-x86-sev-4b62d89e8b98
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, Shresth Prasad <shresthprasad7@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731993875; l=1097;
 i=shresthprasad7@gmail.com; s=20241118; h=from:subject:message-id;
 bh=huKZSq7AsqDQQi/yjOF2YFcbbERJ73kVRMzwwYGk+SY=;
 b=07CJ7QxYxhLvHOOPDRpkVex5RYY7ojaN/prx0fvf+nnhxd3kvM22i2HqqrJVG2Q6k/JGXo9hw
 DJLpJ5SNQAKDDxUgZRC0fFRyUfDBfyS50R1WTMPpobdI7fZkcb+DVKX
X-Developer-Key: i=shresthprasad7@gmail.com; a=ed25519;
 pk=HRYCrybNfNIKx/XGWuHaebtR9EfV+fP52xNB7eY5XoU=

Skip to the next CPU if `pte` is assigned NULL by `lookup_address`

This issue was reported by Coverity scan:
https://scan7.scan.coverity.com/#/project-view/52279/11354?selectedIssue=1601527

Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
---
 arch/x86/coco/sev/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index c5b0148b8c0a191f5aa38af73a52c77d6bba3e2d..0436366243e19a72bf9521f2e96a3ceec9c1270c 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1079,6 +1079,8 @@ void snp_kexec_finish(void)
 		data = per_cpu(runtime_data, cpu);
 		ghcb = &data->ghcb_page;
 		pte = lookup_address((unsigned long)ghcb, &level);
+		if (!pte)
+			continue;
 		size = page_level_size(level);
 		set_pte_enc(pte, level, (void *)ghcb);
 		snp_set_memory_private((unsigned long)ghcb, (size / PAGE_SIZE));

---
base-commit: 28955f4fa2823e39f1ecfb3a37a364563527afbc
change-id: 20241119-fix-dereference-null-x86-sev-4b62d89e8b98

Best regards,
-- 
Shresth Prasad <shresthprasad7@gmail.com>


