Return-Path: <linux-kernel+bounces-566534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CDDA67949
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63F9A173CBE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39B220D4E3;
	Tue, 18 Mar 2025 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qs362Fmr"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7957C199384
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742315135; cv=none; b=p2606kmSKVzQKpOuZM+a8tRA7g4i32qWZjkZal0gKg4F80lXB02Z/BOCR0zR6Yexnrsa0nhab4WFrdVlI2JRePv2Ons4rE6/8IEf1xGzBoxGcBBPHyvvxREGAtyenqEWz24bysSLTdkjW2NcTuJQvX6tlb/SvCtOCdCptS6Ru/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742315135; c=relaxed/simple;
	bh=J1w3wfRE32zhiryslT+guZ7VzCeopgfRWQrYjFcSKwk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D+yaPSmYCgH26eApcaBJz8mQSqtg3fFQyk6lokqFK5PH1r1p3cNd39RBXMihFd3ABFY/EtkJi32AzVFUL46Uh8tHawhupj2buAfGRBQqWTyvYORccqseKNXRVJZQup39rRFSE4qxo6Gl4f4tqF2E2Sp413JrRqG2+r61fDdI+Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qs362Fmr; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43cec217977so24352135e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742315132; x=1742919932; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=82xqydvgKJEdTD6AS9zEoISi5ga6dIOMUMPwBL0TAWM=;
        b=Qs362Fmrxh3Y6otIfhglQn1VA6JhLyskwpBOrEH9C4LYlKA5FK4o11KdtjY6j8bCld
         do0Osc1vqHOTRsq4uWYEXxKUOzI5lx+Z/sger6/8ZtAwXEE5UHXEMOQ4VWOdARkL1Bov
         OYymnNipXNoHysYv/Fafi5yKTCuV0BYjrJlYhC6ZNW5BcaQ0UIJKeS6AbfVuP8+zh09f
         AQqbBYl0udDKgneeW1Tcp3exGiACNRoSp+3KEyQchn/8pK2oAd6wad9nzNdd4luIDUgb
         oJLrUdcyqQqJvMYDt95ZaKf61kITUUv/xS33kW7MlAVbpaV8xHa2haO9h6oVngKHbCq7
         TeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742315132; x=1742919932;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82xqydvgKJEdTD6AS9zEoISi5ga6dIOMUMPwBL0TAWM=;
        b=kWGoaj9eiputiO6nXM6dfURkVG0gwa903y8jwRi2YVLeidzNh6+rORMuKkPjnkqKts
         7v+uR/7NCawJdS7L4+00z2SCIpiqacuWe53lu6MvDbwMl9OVHxK/gsZsyu9pD7/mLYc0
         NDF98MFKW5HCAccK2llZc6fOK1H+5ObQBAWwrqim4qhf9LRmK6k/JHNH44BHnsEF4qQk
         KmNqB66qxJuslSdY9Ynaxm8FE0krOazBnEXZZcMvg1wNX75RaNlShLQ9qvLOLXMuIBI6
         2CEFs4rEZQr/ebvXHgePay6Nf8Moi/CvU1RkecmS5xE93MnP1HGJYfDhmfiUrZAM2gSi
         PH6w==
X-Forwarded-Encrypted: i=1; AJvYcCXtAUlzk9i0bNQ81g4DwputBMhegN4vgr+nb61s76BzXW2+5TFfPuOOF/4vuLD9boYcmRTpRiTNm89vTbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQpx9Ci6J7zjP9yzm9mKEdJUAUO0jKC0IdWvGh0XW4FxUc6wnI
	rYrvHQ3zqEYekMf3VJCbLJyMpwkE4Y6kbUQR81Jh3OfYtKpv5HMIT3I5F+iOa2wL0aH/HkziNsT
	eWh0OJknUoyJYOf23MOGpBpyADA==
X-Google-Smtp-Source: AGHT+IFqbXkqs2Mp4b7p4DEZXKXsbkJMcBqeeMGJEs4JUgbYXZRQtxNivjVbKfH+2JB9M7Bhly80ZxRnTmUFvY4cw9c=
X-Received: from wmco3.prod.google.com ([2002:a05:600c:a303:b0:43c:eb09:3784])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c02:b0:43c:e7a7:1e76 with SMTP id 5b1f17b1804b1-43d3b951acamr22481225e9.1.1742315131880;
 Tue, 18 Mar 2025 09:25:31 -0700 (PDT)
Date: Tue, 18 Mar 2025 16:25:08 +0000
In-Reply-To: <20250318162510.3280359-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250318162510.3280359-1-sebastianene@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250318162510.3280359-2-sebastianene@google.com>
Subject: [PATCH v3 1/3] KVM: arm64: Use the static initializer for the version lock
From: Sebastian Ene <sebastianene@google.com>
To: catalin.marinas@arm.com, joey.gouly@arm.com, maz@kernel.org, 
	oliver.upton@linux.dev, sebastianene@google.com, snehalreddy@google.com, 
	sudeep.holla@arm.com, suzuki.poulose@arm.com, vdonnefort@google.com, 
	will@kernel.org, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Replace the definition of the hypervisor version lock
with a static initializer.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
Acked-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index e433dfab882a..6df6131f1107 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -69,7 +69,7 @@ static struct kvm_ffa_buffers hyp_buffers;
 static struct kvm_ffa_buffers host_buffers;
 static u32 hyp_ffa_version;
 static bool has_version_negotiated;
-static hyp_spinlock_t version_lock;
+static DEFINE_HYP_SPINLOCK(version_lock);
 
 static void ffa_to_smccc_error(struct arm_smccc_res *res, u64 ffa_errno)
 {
@@ -911,6 +911,5 @@ int hyp_ffa_init(void *pages)
 		.lock	= __HYP_SPIN_LOCK_UNLOCKED,
 	};
 
-	version_lock = __HYP_SPIN_LOCK_UNLOCKED;
 	return 0;
 }
-- 
2.49.0.rc1.451.g8f38331e32-goog


