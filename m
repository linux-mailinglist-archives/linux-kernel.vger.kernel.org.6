Return-Path: <linux-kernel+bounces-273107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E2C94649D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 22:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14AE1282FD5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DC252F6F;
	Fri,  2 Aug 2024 20:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dsqp/mpO"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A8D1ABEA7
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 20:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722631807; cv=none; b=BOm2HH+/qe1a6NUdVDu+VfyNaEpkbamNiJgzQVaQcbVASynZpdXtJMIM15uePfvIoQ/GG6x6RNuHGmYKo4XJq26lnC8CyE6oEiVPkspfuSmHK1A3FD99Ax3lpchFS0lF0iYIti9ArPxxl61Uyfbud+yR6PhdeN1F/6YVuyvClkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722631807; c=relaxed/simple;
	bh=wI0b9a+N4EQDdg4biJqQ6e5U/D64/KuAZb9/5FYnPo4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=X3ZBOdw51U2ewVoyqxDTv+jyasRYcyuEXrQ9UdOADdqbWzo+gqIx5oslD2Vo0TbomkMJZzWSzpJ6NhyHyqAGOoC7PG21ECkfg0V0uUNV4FdAFZXLpygeaycNy3yDRSsxeuBD1t5/PKgIPN3ko4mRFSNNkixsbIwrOO9S6jovo/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dsqp/mpO; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1fd5fe96cfeso85429905ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 13:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722631806; x=1723236606; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=07pVGfXuSY/XWJzm5rhlT1DEo094h1RSFSYePA0UJWg=;
        b=Dsqp/mpOI45Fug2OC0XgIcCAqxaZwfEy6kpHiMQ8S1VRBauaTyB0ByuzEjn+8E/9lo
         AWcqYvIUln1p/I50cyfZmYiQrNkzaKMOszkAdNlusVvYf4YvKeRJ0/ohb9kgGaqFVOj4
         XboMQlpGP8KcvPyvGTVHWbI8CnlvwF//1Nmir9YVYwk3N28bILl89/RLBtQmuXbKz2vK
         WJxIqprWTM6ag3cMFuIB4scFLea+4GRm+Uv4KBeZ4ROhHICYhY3vK/2xNTjXWGVux0vP
         NJvfTkT4m7Ig0ZIIPRkzaINBPNQ3RptdaFgjquXtFipRly8NEFFodqvMwlGDpgWwbRoL
         EPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722631806; x=1723236606;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=07pVGfXuSY/XWJzm5rhlT1DEo094h1RSFSYePA0UJWg=;
        b=oUAGCdjmv92cjFIqmyJsPeI2CeOVXH+pQRhCFn2CG4aFE4Hac1VLyOGKhxgd3CyhWL
         UhMcpl4ME02LV8wCP3MghCKWgQhIsSY/Vhf2aQKsG1SJ5FcLSYfJQJ+UPg5bkF8hNr5I
         1LMf4vjhktk4k5GkxlGw1EMCF8cdebTsQK0c3RCPtuUzmftZVBd6VgsIQ87a14XGVlp0
         lu8jMJxA1f7oyV1E54cWp1V54kCibG7SXXZK/aFu/zgV+liU9OoJOasaxkfxJwwMQ7hf
         Fz/2vmrGsH5Nm1E8EY8EyFcfcbsLqYvNXSIBlJjNDl2dEd4LYnFTjeuRUbpcyl7+GhKG
         UfWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrFNKonf5hgvhDAiZg+53CQmq6y7fSD/cMtvBX1Vn4PlZpdv/845MjOWwI6gtFrmPWdgbYtkHCc0CDyQ+FlZfVctxf2N/drzftxNl4
X-Gm-Message-State: AOJu0YyZt3dPHCoBRWtyhwbnGz+HlcAycZ+qcZvBI8ACclpF6HojpooZ
	4qZ97vB4D36Smk+ZI8g+UOjSOmpoSJ3SANpnD6jAGfTKF2ETC4QZPwksF5XeAG8kqWfAiDw20ui
	/Iw==
X-Google-Smtp-Source: AGHT+IFC5LWLOxwPHvNZWQM436sHNoS4DNX4VcqimA3Hh+i2UkaudAnnMxN3O12dI0UDnUW1eAQ80Xh9W78=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2446:b0:1fb:3474:94fc with SMTP id
 d9443c01a7336-1ff57296e21mr3021555ad.6.1722631805645; Fri, 02 Aug 2024
 13:50:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Aug 2024 13:49:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802205003.353672-1-seanjc@google.com>
Subject: [PATCH 0/6] KVM: kvm_set_memory_region() cleanups
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Cleanups related to kvm_set_memory_region(), salvaged from similar patches
that were flying around when we were sorting out KVM_SET_USER_MEMORY_REGION2.

I'm honestly 50/50 on whether this is all worthwhile, but in the end, I
decided I like having kvm_set_internal_memslot().  I think.

Sean Christopherson (6):
  KVM: Open code kvm_set_memory_region() into its sole caller (ioctl()
    API)
  KVM: Assert slots_lock is held in  __kvm_set_memory_region()
  KVM: Add a dedicated API for setting KVM-internal memslots
  KVM: x86: Drop double-underscores from __kvm_set_memory_region()
  KVM: Disallow all flags for KVM-internal memslots
  KVM: Move flags check for user memory regions to the ioctl() specific
    API

 arch/x86/kvm/x86.c       |  4 +-
 include/linux/kvm_host.h |  8 ++--
 virt/kvm/kvm_main.c      | 87 +++++++++++++++++-----------------------
 3 files changed, 41 insertions(+), 58 deletions(-)


base-commit: 332d2c1d713e232e163386c35a3ba0c1b90df83f
-- 
2.46.0.rc2.264.g509ed76dc8-goog


