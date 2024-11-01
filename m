Return-Path: <linux-kernel+bounces-392768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7F59B97E7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260BE1C229AB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9111CEE83;
	Fri,  1 Nov 2024 18:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZGnJWDVm"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03311AB523
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730487036; cv=none; b=VMgM7IXbOgYwVTeLBpeBDVjaRyDgjiON8+EqEU2fithXlCw1+xHZ+Febp83W9txAF37I2QGf9ISjhFMdacrDqrBNAcDeq5xtVNPBIh/tZpF0S1vQ6Yrnv8pLbf4R/3U+kiqL77zgRyvKa4ueaWfCIugBDseqBmELH+1RdqeLMh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730487036; c=relaxed/simple;
	bh=JghzadJb1RzeYmUv5G9/I9KYuZLOl2NXdDiCkQzqMjM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZRBfm+JzwyY0/WQwmdrxDWTni8m2lzA7AruGvC2jxFq6T3iZBi8Gos/qSoMWvKkYmUFVUXxK6bzha5mvhlhO4uoxg9MM28EaEO+NweD9jE/vBQNFGsegd9XImuK4cqDKpOKv1bfMFbErln+knGr9k0zdxTWqVc947JTPboKqAME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZGnJWDVm; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e330f65bcd9so1074640276.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 11:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730487034; x=1731091834; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0yD6fxz/OxtK4CZyxTQ3jXuBHxwejODYX78SCol3Io=;
        b=ZGnJWDVmTLgZDe4dtg9DPJ/6dcM4kZKum+TbvesJQkPwQuMXlckVnJWtnumQL5W8pA
         KmQxRl1aZ7H1+mDEpuBpxvCNqbT8GC6+VrxHT6AKoe2uDaENdxv27bYZGbomynoW/+jQ
         qHzBVa37ztF4293JsqRUzohQX6bQBYGu5LtFCixDKk1NMYHHhdZ+PbLkSWTYeSZk1PVR
         oKFaEXy03SqPn7BzZpGOIkCz1rIkF07ZC416ni5m0bz0C2NcsjeMcjaHuWoUxTaclpvY
         8soET/jrIc8gSuCLLiGBCukbGcHDj6gfVaa5GItz2yw9q7hdr2pdsGJ96wn0n9sazjlE
         Q3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730487034; x=1731091834;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F0yD6fxz/OxtK4CZyxTQ3jXuBHxwejODYX78SCol3Io=;
        b=pjTCVAnHtUnRaIjXNIP3C2eLFl/E8KvRUqZon+ZLa6hE4KvfXYaNxK1fymtCe1qZU8
         39dw1JxKU38InE0l1HG6SAceKEiQazezVhNMPCjWfS/rcuZFIphcaprLyEuwVBOz5zwL
         yPkaNmPqA86zsN1NV0MfsQiZld3zUgVHjyVzfeBC2M5c5Up4Memm5U3lcOV+bkNbwN60
         +67uowdACqP00pB8LOWEUAWy6Y2AxK8E6q5SCbFgCYYlSdayjLYEqDysbJC4Wxmo5OyR
         FadrShqBjH/2kTzTNWCWMVVt1ftT2VWv8HN+EmT2cdU2u2oA89UMrDoSRiP+AqFtWNcg
         HmiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmPlxo3RtXZ6C6gF1n2jG+4YFgwArP48VXcxgQ4FdN7lNszFAYXtAqOczAM/hK86BUBoc4hK/XfleM0es=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkyS+2ziYyn7ApW/A1d68N9xPSniz6wbnWOYkCuZNs04yG4qE8
	1ZXV7ZsOICKsLML0ECE5sUeDQGZ7EM8ja6QU6zBKcML6RfjBFlJqL2CJd5c789rOLnOiA9AWPX/
	ccg==
X-Google-Smtp-Source: AGHT+IHXZoWalcZy57W6wrfik1Rn3U8tlbZnbkCaEjoA8ZWubLTNsOhruGbtr6L94QWgRRFAxLRauROAibY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:8289:0:b0:e2b:cca2:69e1 with SMTP id
 3f1490d57ef6-e30e8d6b7edmr15277276.3.1730487033850; Fri, 01 Nov 2024 11:50:33
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  1 Nov 2024 11:50:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101185031.1799556-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: VMX: Mark Intel PT virtualization as BROKEN
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"

Hide Intel PT virtualization behind BROKEN, as it has multiple fatal
flaws, several which put the host at risk, and several of which are far
too invasive to backport to stable trees.

I included one of the easier fixes from Adrian to help show just how
broken PT virtualization is, e.g. to illustrate the apparent lack of usage.

Adrian Hunter (1):
  KVM: VMX: Allow toggling bits in MSR_IA32_RTIT_CTL when enable bit is
    cleared

Sean Christopherson (1):
  KVM: VMX: Bury Intel PT virtualization (guest/host mode) behind
    CONFIG_BROKEN

 arch/x86/kvm/vmx/vmx.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)


base-commit: e466901b947d529f7b091a3b00b19d2bdee206ee
-- 
2.47.0.163.g1226f6d8fa-goog


