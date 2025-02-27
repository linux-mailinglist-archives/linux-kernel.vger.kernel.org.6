Return-Path: <linux-kernel+bounces-537061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC2CA487AB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731DD16DE4C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0C920B208;
	Thu, 27 Feb 2025 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YXmJVNti"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372971E8330
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740680279; cv=none; b=swNtfHvMDKSO0Su3i2GnJ99dKRH+H/yHrPWDkBbl4eodcmhOAIv2V2nA99+SGQ37qwmavCFKlbmr85stFBRazzpRiHQuGQhEMNOKSz7zLrGm84vgK+kdE/sGnHNSs1zwsiMgImFuDHJvp7bO9ualD3EpEKUfP8nw+1woiV2A7zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740680279; c=relaxed/simple;
	bh=iciPmQ+usvGo91G9AQ+z/XpPH37LLBswHMPsV19xk7Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CX376GPpjj/1QuWl7xxzaxWnYfse2+0GObkokS/GDvDGSkK6Mo0oSmP3yaLurmmEbBO7Fe5vi7cyTZerdwK0TXqKDP6/IvL3b/MkPuLMvt1PGHhlVS/GhdIoKGCddQJNDmpr95iksSIk1W3Qvh9z7UKBwLJCA4njC9ttc192ooA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YXmJVNti; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43ab456333aso11441225e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740680276; x=1741285076; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fv4f4paK6utMxGVLBPvw8fcn9CW6EObNKlJ/GybX54A=;
        b=YXmJVNtiNzoE1zqL6iVUeBuziYRCVdZ4gRpscR3kw5+6xaAp3fsBtHMB0mmHn4ntt3
         C52GbC227O42yG/vd/A3dHA4F2+yldyCszipDOYC1rTizjSCZiAGD4lyK0I+nKyML06F
         eB/QR0GxESQaKmPIGTagIstMiw3ndUOw+CPtJjzzzkouaoQF2PzJ21szme0hrOBPzuPK
         j0HSSVmUsdj1GPtU5+/aWI0brn+YTKufczd/qLf1cQY3rjYfPtIpqyXqPqsSSx9RpEzN
         OGqIvY+sy6OfxaE6c9Hv+rAGMOJPXcNe7XLZscodwplPHkmKFKUI9cD/pJqrIYDZQq74
         0UeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740680276; x=1741285076;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fv4f4paK6utMxGVLBPvw8fcn9CW6EObNKlJ/GybX54A=;
        b=utHyobm8IvrZgbEKHho5oSZ0TIRLf/NSFBaRB7zSzJjx0gihjHa8uI2En/f58d95E0
         VgBR/FOtr4r0xZNT4bHjdlV8S4/soKaVCxutV2UxnmSTyj5KAwMEpwVgT45V5w/GqLFw
         vCK7SvIVI2BdKu8szYbaPKeGDs/W8OD+lLgOAeFUWdKPf8tDgKQIivSQqURP2wfd6OZz
         mquD/pr2adzEiO203iLmSUXG4e5v/SUUgtDyWx1rVbEBAfZvtKzVVYn4EdO63jtg/vs9
         7z+eNmevkdMv/aoDg4BusVz24BwngV110Cm8BH5Z8DkL4MJ6jNE+02qWhzKwHR6cOWDH
         K24A==
X-Forwarded-Encrypted: i=1; AJvYcCVxOSaeySG2sD5BvHpB0msX1GcGhh77VAGjq0WxZkxr6IdVa9qZqlYR9BJfMPfWdxngEQ/+FidZM02qo1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxOj3Z6/P+6+6pQ4/hsfLisiuwFb/1FXcgu1vXr588IRtPs1M4
	jPhtop/CbQyyJoAbX+sdGo8mxvx+1ZzceFzmzGr0LI6jU/YDiOORLK8L9DVFaTBdVM+ZGk6HR8z
	hxY4QTS7y6MQqmSlSTO7/X4qBNw==
X-Google-Smtp-Source: AGHT+IGeSgG4Yj46KVsKJq4Od+bRmoB4CwRl78JJio8Udz/pRZxQUsr/HNXRQbwORqLTtPX98pEazY6JQMdxAAlRg0U=
X-Received: from wmsp32.prod.google.com ([2002:a05:600c:1da0:b0:439:89d1:bf88])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d8e:b0:439:b565:f457 with SMTP id 5b1f17b1804b1-43ba675c3afmr2084445e9.27.1740680276746;
 Thu, 27 Feb 2025 10:17:56 -0800 (PST)
Date: Thu, 27 Feb 2025 18:17:46 +0000
In-Reply-To: <20250227181750.3606372-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227181750.3606372-1-sebastianene@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227181750.3606372-2-sebastianene@google.com>
Subject: [PATCH v2 1/4] KVM: arm64: Use the static initializer for the vesion lock
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
2.48.1.711.g2feabab25a-goog


