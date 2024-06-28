Return-Path: <linux-kernel+bounces-233205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F171A91B44C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 02:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F1CD284207
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 00:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5166AB6;
	Fri, 28 Jun 2024 00:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q2U10q8o"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBD04C7B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 00:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719536163; cv=none; b=HfFMJzBR/a/p2laddSWD+8vAo79ALv7470mVLjWWOq9Cpet0v4PTOIMuUe4Gn8AWDuwdZucycAOdFd4cwcEWwvOSRKUhl5iWFVzju+oHYRFDnmat62o5T6TvgK3lB3OQcgSalbsnmzp+eGxD6WWzIUT7Boa8QuTRDizRk88nfls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719536163; c=relaxed/simple;
	bh=cbbm+ckRrExZY4dZWB9fQIjA93CBRPOBuyvhmoh3Sjs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UvF789OA9IRk+PhKiWIO6I2vP3GX2BPj7If8SNQ124499Hi0ZLwTjhdO+71KN+EfgvSw07vWN2j50NUIgdhmcjQUEbeSZ383XlYRpDXMbVmRmSQqFwKZI/3sGGrsQFV9HAmC08+ynrGicOu4/IX6fQWrxfyCI6Mgn2oPZ/Ao2m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q2U10q8o; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e035140c2ffso86738276.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 17:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719536161; x=1720140961; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/oAzeV2dVc4YsKP2OxbQn62HUeGZJTHnx9/Fe198ZRg=;
        b=q2U10q8oC3QSK8Djgz78f0jHCEqRr9+vsnAD3R6ByBIfIxRZea9tIv05ZkLnurLnyg
         XGFeBpxqqrA6MRpZdPj8ON6MnXfjUwj/3DXZSQl07DO8JYvjNcXL213LUpJgaEZlhtvl
         Cw7lhG4hFXgI+v765NtsAgOlVKr250qO2o8kEpD4iAlA3HQVwP28by0PErgq0JZgcrcP
         TE1cjHZtpnRhx1sTCG3xzR5Mo6Ms8mVat2Yd+Aj2jcJyoaHNPxgaA0wTaHlETlzGTmDi
         vVXZOhGh3+jodXrlrIGlHyVMpRM3UJirztlKkw7cOdQ2bc/b6Z96VgM/niKcOYrqh+oG
         e0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719536161; x=1720140961;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/oAzeV2dVc4YsKP2OxbQn62HUeGZJTHnx9/Fe198ZRg=;
        b=Zj4g4YoEWevO1JyRi/shereJzRCygb51lQ+UJfDdZmBQ4hFDlrZaGVWRByRcoJSVyN
         LPFR/5nsGiOptInE60s0N1zWadzk5PHPrgfrqwd2QBhqPxNMrU+1Mw+qgI7nSUzfOsv8
         0VfDnYK8ouq7e/R+K5M0Na7i6/xcC7kw8UwqBf+WCsGMmldntwB6O/+R5pWaKtomlh5U
         0wbKSQKE3dO50w5aQuADWXAhM7roOuayEDzunCSoYcbzvoegNgT06QKTk5YOsJm9I1mO
         NfehXsGKWneAz1hdq17wMggyZx7LbATDMGWFiUZRD4eUEK6uGC7cTeDYFWwJc5/lRMf2
         EHEg==
X-Forwarded-Encrypted: i=1; AJvYcCUT3mYuCDhktok0yJ9OIXS3OcSisPZT9BmbIwAS0LbYguONxB0R5v2Ek3jXcWsGqZSo6kZoq7bEtbmKYaXB3OOR7TESZdN+attj212+
X-Gm-Message-State: AOJu0Yy0HmT5SXNuz8g2MQytPc72Z0GoBBlcq4k1peV3+2TGY7iWirp7
	vk/t0C/KnMmA+zW8ywsjQ4PQOhOYcAZhrcj2rhH8tcDokoj00HnsPmcl7VQKC+GDjLAqzTQBwT1
	WXg==
X-Google-Smtp-Source: AGHT+IF1jK/zCFugTHqUrwCCUkh+kMerlYt4Sy/sFFJ6qVgb1wC4DxX/+h0yPsBwi/0qCVmgPbR+Fpl1h+c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:c07:b0:dff:ad2:3c13 with SMTP id
 3f1490d57ef6-e0303fd0fa3mr282828276.9.1719536160946; Thu, 27 Jun 2024
 17:56:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 27 Jun 2024 17:55:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240628005558.3835480-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: selftests: Fix PMU counters test flakiness
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"

v2 of Maxim's patch to fix the flakiness with the PMU counters test do to
a single CLFLUSH not guaranteeing an LLC miss.

v2:
 - Add a prep patch to tweak the macros in preparation for moving CLFUSH{,OPT}
   into the loop.
 - Keep the MFENCE (because paranoia doesn't hurt in this case).

v1: https://lore.kernel.org/all/20240621204305.1730677-1-mlevitsk@redhat.com

Maxim Levitsky (1):
  KVM: selftests: Increase robustness of LLC cache misses in PMU
    counters test

Sean Christopherson (1):
  KVM: selftests: Rework macros in PMU counters test to prep for
    multi-insn loop

 .../selftests/kvm/x86_64/pmu_counters_test.c  | 44 ++++++++++++-------
 1 file changed, 29 insertions(+), 15 deletions(-)


base-commit: c81b138d5075c6f5ba3419ac1d2a2e7047719c14
-- 
2.45.2.803.g4e1b14247a-goog


