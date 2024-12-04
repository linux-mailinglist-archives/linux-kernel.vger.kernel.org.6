Return-Path: <linux-kernel+bounces-431059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 586189E3881
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34FC71618BD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F91A1E3772;
	Wed,  4 Dec 2024 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="O94JQNJ8"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591841B87E8
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310705; cv=none; b=B7MrmrqC1uKduF4xE59GZl8VG9hhjWxTrP/p/X1lf+qNtdhdoX499R7r8scEyF07GCy9aCD3zgMEjub9KIQYyz2ems6TGOuVXO3Luvp0wlMzvCdfgXHTUutjl58OwnWEItRAFQ5zDFdI+xVzw2+oHtKQZ9y5KrcWF6cMRxXs+a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310705; c=relaxed/simple;
	bh=h03waY8RoZaiaLEfywQIp90InoLIau7FQLnsulSQ8Lk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OaaJF7TiAvjMur/SAA4OR49h6X7o/gd91cGIVVNnI98WeNb9F+HO9WDgOXqMDpYpVZJa7RMRVf7lKemwnNJcwWeDlQ6Z+iq8394a6KF9dlXcSa7aWJYMFJIcK0NZ/rNQuSvBMoiXZZtijYoXNEV2+y6Hg1qFQ1qpI8yR+4mHnKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=O94JQNJ8; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-215909152c5so32875325ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 03:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733310704; x=1733915504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+2TKl5mjR1/DeVU9OKWZNhWFB9aKSgXlEoedfavFGk=;
        b=O94JQNJ8Uw1mfC+KlsD7IYjwqBLvRWhwnzMYwR0C8UqNP1BtHdazGA+L1pkQBoF0ab
         fX3uK5jkur86WQYeMwSoN+fiYg8IdLLePjOuXhRv3Fx9zn5Hz/g/tM2RquFUHnkYWKFP
         VnB3b1iu9iAR+ikpb+ANMhkWtmleuPl6yoZ+GzOPMnwkVppbN/lDLXqOCWqHCtSYkqSA
         sXXkgPYWCsE0ETSFJYTQEVLucdkMUCbhd/awqDo2k28ix8BO2r7t1KJPO0ZnIaLByV/t
         97DJyomB4v2TihWQl+hqM0AQDfVS1VhNN+t4XjQBRODsRBm3tyiHxGpUblesf5WecGP8
         +1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733310704; x=1733915504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S+2TKl5mjR1/DeVU9OKWZNhWFB9aKSgXlEoedfavFGk=;
        b=VTPnN5Xn3z4jK21KkEGJJgASzyzKTMX5p9NzSwHiXcQ/afoxLqLoNrhRXlf1TbJ2UJ
         7JXz/oglPhOf1wk1JW6qfI77getDvINKwWGXJaKx5iUOJKvI5UUHAcpmiTlFNZ+z09Vc
         1HVBQF3cIB/KeZn6jEeT8Dv16zDdS8yqXP/o46kpPNY/5KIQhNoMELThkX/dBxUQtHGe
         VpGYIQx7Ca8KBbrfDjWnN7VTK9m7EpQk/0UVm3DRGbUd7NrwzPgmw401+yJqmmfCOKqz
         5+/oYLNXVre0XkWXmEOz4M70UIVDXYkJL+PB9VXC1EfnoSR/FQM7AZgLrjxDh7DY88Gf
         oz3A==
X-Forwarded-Encrypted: i=1; AJvYcCWuzYeaxUSiBwle1jpsrIKk30wmmauPxrGcZAkBHFh5gUrlYuIEVlju4g6tOokSiCUb67gKg1iIlpn0ZBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd9g0G+5775WHZto12TkLjyOXiomRKgbwdvhdlrH8Tzsoe8vDQ
	XXL5lpeuxDADfa0Zcc/RAAZhvBngrqWCtEUkgKG/PiBKeaYcLDeIVB65HqJcIMDvDUKSY69grVX
	q
X-Gm-Gg: ASbGncvuu4X34lsF3c4aR+Nfvulu0+wMZ8SLPyAjTn4T1G3Fxmx8SrA1a0qlj+DgsSY
	0hqB5prRImM1ILeP5Y/lOsh3DuFcnNT15S2tkZJQ0EVpixeCi/WrnLrUBGPRHyt0NHSx6EM/6zN
	ZT5xDaFUTaLG9Nlk/DmirK0xu4jJcDG6rDOv1Bjvq+0ABdxnadHK1EqqKWg7IMLXRoKy20mT9ad
	HCnK3u1L4AANifSFISDcE2/qIbJeRodTcOhCbEN/Cm5MmNs2xgTM7iNtQ8sgeX08YeNSIvfDMpL
	fFWQy2l/Xdsm9QQ=
X-Google-Smtp-Source: AGHT+IGw0dejDQHZRzw7N1ju/UdXqXmsmAXf2JNNoAGHvDVcgOtViNVAc4qWa1MErCGtacjUW7kRdQ==
X-Received: by 2002:a17:902:f543:b0:20c:a44b:3221 with SMTP id d9443c01a7336-215bd1cb76emr76174235ad.15.1733310703813;
        Wed, 04 Dec 2024 03:11:43 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21527515731sm107447495ad.192.2024.12.04.03.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 03:11:42 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	peterx@redhat.com,
	akpm@linux-foundation.org
Cc: mgorman@suse.de,
	catalin.marinas@arm.com,
	will@kernel.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	x86@kernel.org,
	lorenzo.stoakes@oracle.com,
	zokeefe@google.com,
	rientjes@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 11/11] x86: select ARCH_SUPPORTS_PT_RECLAIM if X86_64
Date: Wed,  4 Dec 2024 19:09:51 +0800
Message-Id: <841c1f35478d5354872d307888979c9e20de9c09.1733305182.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1733305182.git.zhengqi.arch@bytedance.com>
References: <cover.1733305182.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now, x86 has fully supported the CONFIG_PT_RECLAIM feature, and
reclaiming PTE pages is profitable only on 64-bit systems, so select
ARCH_SUPPORTS_PT_RECLAIM if X86_64.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: x86@kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 65f8478fe7a96..77f001c6a5679 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -324,6 +324,7 @@ config X86
 	select FUNCTION_ALIGNMENT_4B
 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
 	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
+	select ARCH_SUPPORTS_PT_RECLAIM		if X86_64
 
 config INSTRUCTION_DECODER
 	def_bool y
-- 
2.20.1


