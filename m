Return-Path: <linux-kernel+bounces-558843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90041A5EC00
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8DFB167136
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 06:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAF51FCCE4;
	Thu, 13 Mar 2025 06:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="HSeuhmkh"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605311FBEAF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 06:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741849105; cv=none; b=fnaxckjv0TR9zauJ2ic5ltXLVdnsG946jcbaRWG3ChZkHz4kpovYV/Y+TMUua5NEqoiVrXlf9/MKHEXaBHK5mtEsUEy0SRdwi5x5le0L/GD4zrAiL7pOMbuOCg94MeiKXecUsPHh9eLT9vHP1CcnuHBixojqFLoK5Jlu9xkBpA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741849105; c=relaxed/simple;
	bh=lyrf4f3kvKG7BFrUmhjOGbMpwkOJI6N2LuTWXvsNpQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ImGyYrUrBUssWwnpUVnFp5HWgJnUYW207CkRewgJp+phn1amPEfzZx2aMApG+zL2mwrVZ66PV59Npt9K7rp/GJ9Mka35eMxAznYQEcRQRuBZKSDbys5qwNy8GtzScThXpCddtt5Bh83AnSfi7jSmbVnEfIF9eJv+4OKeOy1nPzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=HSeuhmkh; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22349bb8605so12174285ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 23:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741849103; x=1742453903; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NkHO/0se169XNtMWH0w7f9TQn0BTGs8vu96SI051qqc=;
        b=HSeuhmkh8YG2gSna2gUTsx6LE2iae1IxogJcWkaAT39Bce+rcoUgPNvY3BxK30YRSD
         8jBDwAUlxOasFB/o0FwyUC7fTRApFDHGmAhGSQr+wNkhVeWoZxf/W4SMBeUqECebr0qe
         EIs6XrPcRNkMqQskoX9GCkJQYjjlMYSawgT4NPRA3FvjjD13dLHaqUV2ortWEocyM5Ol
         6iuSU1I45HxSDYyhunfspRhSjvbf1QrMJGwXZAl3U+HrK5VQW0i+ciilxNjmHfNmL0k4
         Ywl7p8TXOmRUjbm0/dAIpovrr4TGWjpy5irzHU50HhWjGM4X6CiKwpSyu4bUkhJz2Apo
         LNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741849103; x=1742453903;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NkHO/0se169XNtMWH0w7f9TQn0BTGs8vu96SI051qqc=;
        b=uTPRbpPLy1FDqjwhI2vd5eMOZ1G67s11bjDmCD2wIYRlwINhD/QRWLoh7QVAqw1mio
         krKmXS6OQZGoW1hiBSRP7lXOV3dmAnCL0m/XDb1Etzk+UQzrtksPi/yb/23hFkA75UIZ
         bH5otjRExmVvYSm+FP3BCbdBFFJ7SkPB/1vY+VuOPERIL1T93IYGlrgMkKeGpWUgpewu
         hFP98GAzttZl/71YDJj3kWiazBeSbgqQypFn1zZmNN7I3EvMsdjiQjgzuRe5pVeoDu6E
         mdw0Ez8PstubkdS403qfe2yNaDIMGn8/fgYxkQWXB7Pl/9e68yBpqW1Bgn8uCeq2Cl24
         0hfw==
X-Forwarded-Encrypted: i=1; AJvYcCXN71emAKz/GwV1e7GqKDK6tyHQDB+06Yctb02FbzYgdtfSg8K+UTcUrSURclaI/wyxeGLdM46wgE5ml5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgNn5Wdzkh4p8dRwy4A0jZM0LpuBe3jxu5/sZn5LxQg2iHn8xn
	xUTCZaFpSSsxUFiXoozg/wKiOwHlSW7pWslo5VgQhCo9AHTzD3m4cZ49SfMWCGw=
X-Gm-Gg: ASbGncs7jmapogUQgI9Vxd55ot614cyysdtNgE6Os6joSSNg4FmX+/k6l0CaQ65s2m2
	P7k3548fUhypS+4WENSWrrtR97mCddk6MpR5fc3+IjWTvRiDnQnfArn9pH1bd+cMzmS2WGQumT5
	M4W4+0TgYjUQW238s1/Ko+UWV0iSZ4tmb7hSHQMEkyZpAWSUiPVAlxvmfSW4onvGyFlUkx6vSP6
	a1ldMNQPl3tbIKlNAVSMSn9aJ/Rzi6DCOR72pmKyxGUhG38zeTH1zWWkPDxyxWThxKnZsEu3abg
	CS+7lUGft7w/FtBqr68Z1ixurwsbNu0FNlljkzG2QxY4q+FE
X-Google-Smtp-Source: AGHT+IF2RBsD42GnNZIX18nfjzpK1BpoSRv9b88G/rsSQnVVNmEUyx7yfAT1x7AejmJJpK2yhnpJRw==
X-Received: by 2002:a17:902:ec92:b0:223:569d:9a8b with SMTP id d9443c01a7336-22428898155mr323431125ad.18.1741849103632;
        Wed, 12 Mar 2025 23:58:23 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c68aa5ffsm6537725ad.82.2025.03.12.23.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 23:58:23 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 13 Mar 2025 15:57:47 +0900
Subject: [PATCH v4 6/7] KVM: arm64: PMU: Reload PMCNTENSET_EL0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-pmc-v4-6-2c976827118c@daynix.com>
References: <20250313-pmc-v4-0-2c976827118c@daynix.com>
In-Reply-To: <20250313-pmc-v4-0-2c976827118c@daynix.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Andrew Jones <andrew.jones@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

Disable counters that are no longer included in PMCNTENSET_EL0. It is
not necessary to enable counters included in PMCNTENSET_EL0 because
kvm_pmu_handle_pmcr() does so if appropriate.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 arch/arm64/kvm/pmu-emul.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 461c76a9cb6b..dfa7048a3e2a 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -835,6 +835,7 @@ void kvm_vcpu_reload_pmu(struct kvm_vcpu *vcpu)
 	__vcpu_sys_reg(vcpu, PMINTENSET_EL1) &= mask;
 	__vcpu_sys_reg(vcpu, PMCNTENSET_EL0) &= mask;
 
+	kvm_pmu_disable_counter_mask(vcpu, ~__vcpu_sys_reg(vcpu, PMCNTENSET_EL0));
 	kvm_pmu_handle_pmcr(vcpu, kvm_vcpu_read_pmcr(vcpu));
 }
 

-- 
2.48.1


