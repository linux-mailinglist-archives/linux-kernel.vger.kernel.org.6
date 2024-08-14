Return-Path: <linux-kernel+bounces-287137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A8F952368
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 22:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2782842D2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 20:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052AB1C3F38;
	Wed, 14 Aug 2024 20:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="vb9h4FkH"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A66A1BD518
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 20:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723667754; cv=none; b=GOFzqSW39xTBsY7sEd6Hv5eHz9K6hJFnjGUm3rg/5dGt069lWWYzvnDDtvBXus/4tfsZ7cVlqHSWTlAP2ThYq4Om/ZHsHmYbwOvQgva5QYmi8sM3ImbDSGzeHvFtgbeaD/QteLT+TtQf6TzsmJU1CVD40fnKHoJYrjUWv2jnIGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723667754; c=relaxed/simple;
	bh=vyQRxwkJf0MAq/MlW0mB6+rbFN7SgB5FajLqKOI2P2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qpr71xmQJidygPbO1t4AVlrCkAkh7lS1NWD3uEhhZHsjMRt9x7hPO1Dif01SLkNZlazVTY+i9q1r6tiT3wIQkPQwOQE1LfhGVhL1pulJBwlD9HpXhbHBPBRwPU9R6mTt9M7RGakSpZuXutE3RAz8qitI7/Paf6ZEo/7X3zkoO2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=vb9h4FkH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso1653105e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 13:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723667749; x=1724272549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3cFcZEIVuPavedliISoI49B9W8OPctNZK0n0TA3KAd0=;
        b=vb9h4FkHlq7yEzLmYEA+FJ3FtlMOMIIIKZJWoc8cKyd7XNnqb4a5lLdyAP7/ZUsN68
         LBhZjuzozwsEBs8yer6PDhAX0hIFOwzwrniRUnE5jHjxu4BTCiVT/NJMvJwop82Lf4v6
         ei3YyXfnFMVSsAMwNHOxZBR2igoM9YgyM03m+evWcseuYp9x1U+AHkwEjPvH6Olf0Ol3
         uRyCY97N4kn+1S04JU0heKqJO7skdlG2NzNk7jOzUZDcew9DezEMe1pzC4Z9XbJEA6tr
         7DrO45Mtx0mVks0ogn8q/pTrygxUM4Fz4VWaejKRsQ6oNpAwiwjFgdRBoLWQSZXXkDpr
         gFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723667749; x=1724272549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3cFcZEIVuPavedliISoI49B9W8OPctNZK0n0TA3KAd0=;
        b=req4gqP42/e7gJyI1D/Mo3i47CGEhsE67pGJjui2uJoxkZOjzXCqwGps/GamTP+LCt
         8DDWzF5KWnErKSm37KgRv5D3xTgiTG3a9DT03Zm1oDhNLFQ15QwCoTf7ylTv3oI9XcLI
         exMj1Ht6dQVSxq+kjIBATn54HZIQaJQCLSVS/NCu/xk3x2Gy4yGVRoEK9WFQbbQCiagg
         mhqxEQ1tjezMfn7JUW94cdUD+tAjMjj2HY9BG+AJsRlbbfhs05rNxYDWfmVE5beCIGOV
         PWToEVODLTO3XzpYjtscC+CeuPZ1VKORW2ofGQtY5xqBHn/+zsqmWlDM6tszxcAZAvIm
         HDiA==
X-Forwarded-Encrypted: i=1; AJvYcCUK/syOafYMipY0SJormAYxH8Pz6m/CTg78+5w1NtwH8RcyyAa4tDDph0UINiy2Qdz2NWOWMS2449+NNKeuy/AqfuXY0iTSxqh4Tdnw
X-Gm-Message-State: AOJu0Yy4AqBhUuIWPsfTXXrxor2osFXqCwW5QE0OO5tzH0IXF0d2jx92
	XflxtB17PUHUDTEZFKcBk4XeXlBEmMlBBFdQgdr8ccVliKGWsxMMPLqnCO8Em0E=
X-Google-Smtp-Source: AGHT+IEEWrQtFBVZ+ADB5sdXwWJD2j+AkCqcfwjPIPVSPOk2CBrZiAa3W7eqwV42rvTAiwQ+URqMvA==
X-Received: by 2002:a5d:5c85:0:b0:371:79f0:2cfb with SMTP id ffacd0b85a97d-37179f02f8cmr2356641f8f.46.1723667749223;
        Wed, 14 Aug 2024 13:35:49 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-163.dynamic.mnet-online.de. [62.216.208.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c36bcaasm13750559f8f.7.2024.08.14.13.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 13:35:48 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] KVM: x86: Optimize local variable in start_sw_tscdeadline()
Date: Wed, 14 Aug 2024 22:33:46 +0200
Message-ID: <20240814203345.2234-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the data type of the local variable this_tsc_khz to u32 because
virtual_tsc_khz is also declared as u32.

Since do_div() casts the divisor to u32 anyway, changing the data type
of this_tsc_khz to u32 also removes the following Coccinelle/coccicheck
warning reported by do_div.cocci:

  WARNING: do_div() does a 64-by-32 division, please consider using div64_ul instead

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 arch/x86/kvm/lapic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index a7172ba59ad2..40ff955c1859 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1946,7 +1946,7 @@ static void start_sw_tscdeadline(struct kvm_lapic *apic)
 	u64 ns = 0;
 	ktime_t expire;
 	struct kvm_vcpu *vcpu = apic->vcpu;
-	unsigned long this_tsc_khz = vcpu->arch.virtual_tsc_khz;
+	u32 this_tsc_khz = vcpu->arch.virtual_tsc_khz;
 	unsigned long flags;
 	ktime_t now;
 
-- 
2.45.2


