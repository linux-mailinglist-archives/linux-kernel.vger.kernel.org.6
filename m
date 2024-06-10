Return-Path: <linux-kernel+bounces-208560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC5F9026D1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A632815E3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1DC147C89;
	Mon, 10 Jun 2024 16:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WC4i6hb1"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ACB143C45
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037275; cv=none; b=VL2l/iUz73drBLq3em3pdT8rZgB5BB8m8eHMZaVRgANjUwWMjs9mGxwX0/jfQSkp30vJPbr2ipCYy10VeAPxVgv8JGBPdqqy+/9U8hTfz0rYALpkcm8DW2ckR6l5SHb4O3uRgTcgtWd1vif2ArPAUjNn4XMPCj7HKcnLK4sTbjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037275; c=relaxed/simple;
	bh=yllP6g2dm2MsE2mnC1k07LPpw9VCtTWLM/HdffmDV2I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NBE86jtJ0zMES69MMvjDJ4iyga+MO8EBAqyp3PYgxl4TfYrwPifPxwrPAsMIzgkbdZ89KnDproDFdpGdnv1fPm87Lh/zdLHrY5wQv733lw+4h+48aNMqJtHfWT+jgZFFrlGMHvS9fs5SmPFuYMx2IyTw09OZobzk2HetwALGkbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WC4i6hb1; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfb0c3864e7so3175074276.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 09:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718037273; x=1718642073; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZSb9+rs2usNZeKaqhewTAKIWQtnKpWPlA0PtSeTiJQ=;
        b=WC4i6hb1UOexv2yMtF70U7Mr+7bVg3/h5iGO+NyFEHpJt1dQ52ujTP2PHrzH5KnDC3
         VWN/py+nwntPscfcIP6xnnycbmJPaLVZtnw8PxgZaaMoRzbhuSOrWNkpQ76fO9ks/j+2
         vZJATnZLe7ukiOC815CPtAl0xsxUVpmMCUP4w9lgvezGpSdeFfY8yXrugZwf+2MIeRak
         qrPq0x8cVH3IW8MIf43zcSibGDGwygALEu/ZduaS2Xk3hGkeVmmNe50GMzQoJHwHOGKv
         fC1c89n++y6/xupaHYUpx+Ju9PMrmMd4gWzpkRZigLizSh6MPTm8W8sPGPYwEp7rvyAR
         ODoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718037273; x=1718642073;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jZSb9+rs2usNZeKaqhewTAKIWQtnKpWPlA0PtSeTiJQ=;
        b=JwyVaMQBxu0OqBHXZwam5PK27v/T91dPPr6pj58jY0A0v8uqmr50b+l87QBqK7E5RU
         329yj0YgXA+Pv+G3FygteWU10g4RRi+UVIe85R/9qElaHnQqsBZBvQF2R2ZL+IFy6v4c
         mfpYtX0afEaoz1tqL5v1iwWPj1zwHkILPKib8KWpPIQUzYjsAmIuyG/TFzTmxtSw1QXb
         vLfzjGCSVSQOro0Vc/gE2vPL+WuuLd8CYxgnRE90YKBP7/Lyt/SR03IHg/s6JKP0xr4z
         39DKcldxMQHhC1E1ZN8Ta8KoBCLNii7O1KB0lLkJToH/PtEAGk/Y7MqqapO0PeVPVuq3
         t+zg==
X-Forwarded-Encrypted: i=1; AJvYcCU+rYYsTllFlHPmjoO46moh4gqw/Dl1MCgjDAu1gEKIbzrE6kL2PE0VpvR9PYFBkCgHUgIprWrfDNdUJ+y//bdShOLc6uaRcm75HifS
X-Gm-Message-State: AOJu0Yzvsfp/XkIO2sK9wRI2lVgKPjtvqsXJS6XDyyJaqvNYrfh33K3A
	sINS93d+rYt0eBVwQbnHlF4+Ju0i7jG+5lfdfm8zLHnMMakQLJa2ppLhz5meLHDFKQSj4lM83xv
	5KQ==
X-Google-Smtp-Source: AGHT+IHHh2RNmvVunFf6h0xc9IRdVIUXMt65AfZopDDW5pG8LuS4lbSICFSmAFOGHkb/0UN6udVF9yYpz8g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:10c3:b0:dfb:335:427f with SMTP id
 3f1490d57ef6-dfb0335481emr683064276.4.1718037272968; Mon, 10 Jun 2024
 09:34:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 10 Jun 2024 09:34:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240610163427.3359426-1-seanjc@google.com>
Subject: [PATCH] MAINTAINERS: Drop Wanpeng Li as a Reviewer for KVM Paravirt support
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Drop Wanpeng as a KVM PARAVIRT reviewer as his @tencent.com email is
bouncing, and according to lore[*], the last activity from his @gmail.com
address was almost two years ago.

[*] https://lore.kernel.org/all/CANRm+Cwj29M9HU3=JRUOaKDR+iDKgr0eNMWQi0iLkR5THON-bg@mail.gmail.com

Cc: Wanpeng Li <kernellwp@gmail.com>
Cc: Like Xu <like.xu.linux@gmail.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aacccb376c28..2c48b67449f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12382,7 +12382,6 @@ F:	drivers/video/backlight/ktz8866.c
 
 KVM PARAVIRT (KVM/paravirt)
 M:	Paolo Bonzini <pbonzini@redhat.com>
-R:	Wanpeng Li <wanpengli@tencent.com>
 R:	Vitaly Kuznetsov <vkuznets@redhat.com>
 L:	kvm@vger.kernel.org
 S:	Supported

base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
-- 
2.45.2.505.gda0bf45e8d-goog


