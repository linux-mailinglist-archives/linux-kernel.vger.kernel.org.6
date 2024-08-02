Return-Path: <linux-kernel+bounces-273089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B49B946474
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 22:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29BDD2828EE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D5E53389;
	Fri,  2 Aug 2024 20:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fkL5LQkg"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CFA745F2
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 20:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722631144; cv=none; b=cWOAnM/p0GQrN/JhPNDxBIiduwbUvBtylAcFpxl8xKKUQNjXKZ+j+4NMeTOUhxc5YREe0A3/FabnSidYD/ixvkLrJJNfG+ghRFD69BRdxKJAj4pug0+5+qVbGr9z4lOMx531emFMGaBSjG/tm1cwjW4HdlcY6RqV0y4saKjrRZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722631144; c=relaxed/simple;
	bh=eILvVM3I/xmxIQCck82oe/XPuH/GX1lEDyFaah36KdA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Hv8sq5es0EsGigG1oOKK9/AA0S2mdrZKbiLCOvMEvZXxFbJNORhG90uooUYlS/yzGkLWRBVdDuGvK7JF3FQxNiPwAcIsWpEv61eL+r3jOLazGKSGAItLZSy2R3igRyKIXfG1T0q3uMrGx0oNUQamdkQYxTkI9TKFuHmhtSVxi8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fkL5LQkg; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7a3c6dd559aso7511266a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 13:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722631143; x=1723235943; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Nz2WB521W0xZbrZcNZj1NNDTPa13V4b8CcMEmJXXSg=;
        b=fkL5LQkgV2SiN0N/POaSRSgzszI1bpj4CXfliXoGKdC0YFpSCC775YhK4GI9tucZwS
         I9QZLoMWn4nqULvX56UIqgZIwVtN0n4LJtvFaQrUqUGUTo5JMF5IJjfKx+s07Y08pnc+
         GugKzSbDeAV7sRCMX6ICd10UkSnYIxGAok4UypfMRq2P132cS74oc/bMIbMw+FlmISIh
         SMneovSRVoKOxvmmzLKn/An/GayDS6bFfytkePKEWwg0W85sYB+8jIvdwmpPZkWMyszk
         TbS8sBUMO0rzfX22dw86RO6ljtyoSoiHP4D36ydci4aW6xMcCmi85GaFJXcc6+ZTeAAQ
         r/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722631143; x=1723235943;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Nz2WB521W0xZbrZcNZj1NNDTPa13V4b8CcMEmJXXSg=;
        b=CjSikz0/3o6nE1LqrEXADzT67cwFRdvRFsSUIXWWvPTOqee6+V6yu5psDdvQi1WZB3
         GMNQcOJu0J79r4EU0PA7BDPzBoH+qYqNn/Jla0KUOuBFb8iMTCAUF9L73z3Ld2Mrw9en
         EaL1MBcd78or3vfT7VyODbiqvkrRe5g8KAEZHGJvlUE0BPyIWfzYCr6WXo1nC+vBc+q5
         7SoYtbZfZu3juUbzdnELbl5rUvv7bLibY46or3EAzKPckHKWagXz5YHSho5bcZKm+zJF
         cyUOjLC0NyjBahYUhDckXkIFaOcGdRe4v1ql463pyJtUKi/Q80AL6G1rU8GIGe6aoVk5
         RCJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvFAaLLIxHdPQOTvPqRLXwYN2+UMu92W7h9KVFsNDewHvuZMfoGWcayX28snY0JqfvQBTq788jJgzwyn/EJhWOXtDnlwctR06MHaNj
X-Gm-Message-State: AOJu0YydQLW+E4Fq7vMAS+rkc4ZbgErDhlvf0H4+tA4LWWwck0MPRWKq
	76jMlA3ykiEGrIa3J0jRyuN2yHZ9QbcqOYnNJywKcNwd4dXkccnZrDqaHLAXnjO2Tcx/AAppIxE
	nAA==
X-Google-Smtp-Source: AGHT+IG1qkqa2/kentjh9dKRqmYyp6/hxPFxa8qU1BMtG45x2AD8kIAWRaMCyvapGUvm0lDrX9ShO8T7lxs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:6904:0:b0:7a0:cd17:c701 with SMTP id
 41be03b00d2f7-7b74a9d0286mr8293a12.10.1722631142675; Fri, 02 Aug 2024
 13:39:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Aug 2024 13:38:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802203900.348808-1-seanjc@google.com>
Subject: [PATCH 0/3] KVM: x86/mmu: Misc shadow paging cleanups
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A handful of loosely related shadow paging cleanups I unearthed.  I believe
I wrote them when reviewing eager page splitting?

Sean Christopherson (3):
  KVM: x86/mmu: Decrease indentation in logic to sync new indirect
    shadow page
  KVM: x86/mmu: Drop pointless "return" wrapper label in FNAME(fetch)
  KVM: x86/mmu: Reword a misleading comment about checking
    gpte_changed()

 arch/x86/kvm/mmu/paging_tmpl.h | 61 +++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 30 deletions(-)


base-commit: 332d2c1d713e232e163386c35a3ba0c1b90df83f
-- 
2.46.0.rc2.264.g509ed76dc8-goog


