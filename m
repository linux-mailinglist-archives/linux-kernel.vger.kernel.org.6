Return-Path: <linux-kernel+bounces-170460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 113198BD72D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 23:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DCC21F24A31
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 21:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A2A15EFD8;
	Mon,  6 May 2024 21:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="a4wN1GLZ"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E759E15EFBB
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 21:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715032437; cv=none; b=jey3NOu+a8X1TKF+CBYAC+RBjmOoqCuyFzng5J/AlOt4Z1RowaVlsKGqktX5sxbCN2pO8kHKAW4twWNlF6S/2EOXLGHEvVOuSsQb8jNkVqbbCvQnGfndYVKrlwSSXz/dN33lSRoSFsf3q4VW/K5eyzfj2HNubR8beuFDf9yzpF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715032437; c=relaxed/simple;
	bh=BTdB/bKcsgIg8SG05ME4z6NR7Hf/yomiKs5wTQl9JKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=shGQio3ks4F869Mt/D2jjHsPcJQkwFSuyF2Vd3HH9iB57uoABtMrnYSR6pgk9M1q/tJRzCBMeLDs0NuyfvyibkTHAhHuzGHbGe8a4tsjly3QgVFlCeo8E+G/h4CRl8O3nvm2dfFzzTfBrdhfpo69aTCf3UkoyBkh5ZTll2HBv84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=a4wN1GLZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1edfc57ac0cso11788195ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 14:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1715032435; x=1715637235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fIJKpP9PuqIwYQVQAXhh3lvsNULoqRv8W6dHtBpvXk=;
        b=a4wN1GLZ0WdgTkEGGM6PKlK2FUKcjNwi/vBatFP51Qn3pYlnPXmXgCPlV6g4k5xzmN
         px/8Vf55cYGszQDh+phlc+otnTBUPJwEWCuiF3v/+o18ly4eimxMc4mBXOo60R8iCAKl
         ZfHSMytwvKsFNfx+QuGh7u5swww+QfzIE0H4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715032435; x=1715637235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fIJKpP9PuqIwYQVQAXhh3lvsNULoqRv8W6dHtBpvXk=;
        b=k1XOibbiNvYZVAlH8jGPFzSGhaPGP2f0NESEKmKFbkQux4+UNHsh+nx+NSNcpigjC6
         CGOUSjCWejRVZ00umrTaxpTgYiD1pmvdhOI3fsby7mC/NG8eZXzIrxZw4/ftOMpJZSX5
         FH+mQDrgddOZ+NZN76HBdhPwEcLKSJMDBPadir0UHrVAUvxegQLn7UFMVzvNxnOBpCEt
         PgUtQlCLswB53UkSAZTQaGPaJcG8CGORjfGGziQ5uikWmTK2ckQImamUUxE0y52LDW2M
         yHV74kz8Ge1mupa60LFG/uX6jSDo6HnQ25SV1z0jp8iU22itko9KE9Ux5iOT86yPe12o
         DMQA==
X-Gm-Message-State: AOJu0YybLJUGX/06FuFYL5ifgb/zkjwQ41YSresXFxsYSGRbde8WRqf4
	Z7CMmW1SEAXwQzn9wgCKoBBLGjP2xPmiEGhvjD4HJ+RIXnQBuysyL7ryQuUi4Sd9pmeDDaZE0dG
	BiugIkASBniAsywD+nL3J1vjAbzMoJBoDNlIWY48t4KQzIPSYXs/ZqqHBk5mHJVgeWpMX3KJGaO
	loarL528Q4RqLS0r6aCaxpsUKXpAvVCPoQ5mXtx7o+FLrYLO/0P447
X-Google-Smtp-Source: AGHT+IFyWv+jxb29t05zzSKDmxjDVEWVQ7r5yIdjW5CDcL456PzBbnI/9joeCaGDokUA59UoiPatEg==
X-Received: by 2002:a17:902:ea0b:b0:1e4:31e9:83ba with SMTP id s11-20020a170902ea0b00b001e431e983bamr13602030plg.1.1715032434870;
        Mon, 06 May 2024 14:53:54 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902f54800b001ed6868e257sm5664008plf.123.2024.05.06.14.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 14:53:54 -0700 (PDT)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	richardcochran@gmail.com,
	linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	zackr@vmware.com,
	linux-graphics-maintainer@vmware.com,
	pv-drivers@vmware.com,
	timothym@vmware.com,
	akaher@vmware.com,
	dri-devel@lists.freedesktop.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	horms@kernel.org,
	kirill.shutemov@linux.intel.com,
	Alexey Makhalov <alexey.makhalov@broadcom.com>
Subject: [PATCH v9 7/8] x86/vmware: Undefine VMWARE_HYPERCALL
Date: Mon,  6 May 2024 14:53:04 -0700
Message-Id: <20240506215305.30756-8-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240506215305.30756-1-alexey.makhalov@broadcom.com>
References: <20240505182829.GBZjfPzeEijTsBUth5@fat_crate.local>
 <20240506215305.30756-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No more direct use of VMWARE_HYPERCALL macro should be allowed.

Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
---
 arch/x86/include/asm/vmware.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index 2ac87068184a..84a31f579a30 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -273,5 +273,6 @@ unsigned long vmware_hypercall_hb_in(unsigned long cmd, unsigned long in2,
 }
 #undef VMW_BP_REG
 #undef VMW_BP_CONSTRAINT
+#undef VMWARE_HYPERCALL
 
 #endif
-- 
2.39.0


