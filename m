Return-Path: <linux-kernel+bounces-305858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D319963552
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F9D2869CC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F7E1AD9F7;
	Wed, 28 Aug 2024 23:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eq9b9yIG"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D0B146A63
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 23:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887218; cv=none; b=PA8jhSx8hrloynvjD5U1S43ihe7y/GseKLGR9fTd/gGl2oqQM5uk5IFc7I6+5/el8MSmEV6bS8wUgvHWf1WidSTImt73IR3iBLJvcroyIMv8DGJDh6HmiWj+n0vS8akaKRanrm6HoczJrNe7iYhgSOsnwEcF5gfOLUT8kmyIwPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887218; c=relaxed/simple;
	bh=fQAGwFbf8GIrxgZqRluaQHGuGG6qqxdEs/csFaLDTJE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pz4oZ/clE0kf4Bnd61mgMj7Jzrw2rdmEAjDJtd7YtWRFMlFKTAdvifxPevna4CKyEk2GDFtmSc714He+4Wi9/dUq4lLLxX5bSJIEeuoyNZZOKjZhklAsLyOEkRQ92MMnHYDqNoaQURJhTEirRhkbMJ/WtqeCgwykmn5Xx6ozw84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eq9b9yIG; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-715c530f80eso101209b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 16:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724887216; x=1725492016; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cOsN1LiLTt5DLvJpt0F0roXY499wNB8yetU9fpz6NA=;
        b=eq9b9yIGYc7wKana36OfBZNz6bSVdockGHnfZLJyWOO0EfnldXmH14EtZXvk0okIJv
         nhIgVlILC5OJhQJgwCNXAOidL4+q6GETFOuVcX4auUW7D5DKEe8IZ1Om1NifVusEq5gD
         3sZoLDrxA90N8RUaFViI1BanaUZNUHfIb5m/NgwDK8ft/BxJBhclMYHIg5E3VG9/B/sD
         YFcfgyACa/lW4+YWp+k8X3ZcmPX1cAyXBMLWxYUgBP9Y6mPZNzbmVMpefZT/zOKdXD0R
         BSFVqlWCai6dH8RdVIDZKEshjojfwgWXKD1KmMGUQsJb0KeiSm8KKfaxdTiLBgFqC01e
         NITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724887216; x=1725492016;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2cOsN1LiLTt5DLvJpt0F0roXY499wNB8yetU9fpz6NA=;
        b=eeuQ9kMZ2QeXG4uWoApm9AUMPcKPoyGML7sVhCJNScEwF/QqOVeC6wBTyNgJUdnvK0
         XfTkyAAoY6pqGqgwUamKGGG//OTNHEqQwD0AVLshnZXVpWgv0slhIHwvzpTZ34ufsO9t
         zQ09Dc6SpxZJS/74by8WvwS/JY46ftPgFVXPsYrW68CxU+2Bz8CsAUtWpyTz3Yba7xNd
         jzwpW2MdvGy8DswjsXuVDsjGik5tz+TKIZkqjf7RFvsaPS6XlrysgT3uxNx6Zapelmbx
         6uOrvAi5Hka1TevMMI/UaQmFirWziz/FulIhnMZMcnVbuf4ApML1oqWM54zP05KRCvIX
         cCBA==
X-Forwarded-Encrypted: i=1; AJvYcCXThMk17JTp1JO6aB2hF4sH3Pv1srONdg6beTHDrnS83Xt4d+gFyFQ5bBzQa+wviErZjPzoGR6bbxKqdWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWfcSYya3LIa9rj+W1ZP56Nfeg+1rvO51+dIrCvpFBsNdf6jBc
	h2fxEr8CPBUBGaUMS8RBk0hTOExImVWaelY81KsbowgvxAbyNa1IHzBLEZ/s561O0+O6Uz1fvvs
	UFA==
X-Google-Smtp-Source: AGHT+IHoRF2b84LxADXVkG+d4knXGgkGC8/VQYGJAFjiaB4k0luYaz5Q4hDiZRNMRwVv7eE4L1+6pEmMVZ0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:3c71:b0:70d:fba:c52b with SMTP id
 d2e1a72fcca58-715dfc73fcamr2002b3a.3.1724887215947; Wed, 28 Aug 2024 16:20:15
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 28 Aug 2024 16:20:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240828232013.768446-1-seanjc@google.com>
Subject: [PATCH] KVM: x86: Ensure vcpu->mode is loaded from memory in kvm_vcpu_exit_request()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Wrap kvm_vcpu_exit_request()'s load of vcpu->mode with READ_ONCE() to
ensure the variable is re-loaded from memory, as there is no guarantee the
caller provides the necessary annotations to ensure KVM sees a fresh value,
e.g. the VM-Exit fastpath could theoretically reuse the pre-VM-Enter value.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 70219e406987..d38fdb5f90dd 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2124,8 +2124,9 @@ EXPORT_SYMBOL_GPL(kvm_emulate_monitor);
 static inline bool kvm_vcpu_exit_request(struct kvm_vcpu *vcpu)
 {
 	xfer_to_guest_mode_prepare();
-	return vcpu->mode == EXITING_GUEST_MODE || kvm_request_pending(vcpu) ||
-		xfer_to_guest_mode_work_pending();
+
+	return READ_ONCE(vcpu->mode) == EXITING_GUEST_MODE ||
+	       kvm_request_pending(vcpu) || xfer_to_guest_mode_work_pending();
 }
 
 /*

base-commit: 15e1c3d65975524c5c792fcd59f7d89f00402261
-- 
2.46.0.295.g3b9ea8a38a-goog


