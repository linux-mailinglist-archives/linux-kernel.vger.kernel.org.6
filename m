Return-Path: <linux-kernel+bounces-510238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A31EA31A27
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8B33A7D01
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2064923A6;
	Wed, 12 Feb 2025 00:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E5LRamT4"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07508A50
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 00:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739318892; cv=none; b=h9LZTsF4ZZ0erDU0qjmqoAx9qgL9qcvgyEPOJfxYhbRWYW/a2pFAZvdZPDOSRv5rWBoKEAWqPSxCaCTPXyY7x4WXNH9lIMpuAVjWn31vPPohPTeSRm8gq97Tt2G0i9pSCD4bA/CndwPrkg1JFC5ThL+GUIJE3bAYLgNR3rKAPE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739318892; c=relaxed/simple;
	bh=NUIu6ItD9FeDqWH8xkInRQt8g/4cfJZAGn3SPtdFzaw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ggiwWgjzqpNrXeGZMk4IPV3bOTGQKmonYapIkz9MxvCa77Fgic7Glp+rrHZPa0RZxXKBPY1AH5knPpav1eGM26K0YAMmDZnOU3AsB9fWvVJSp7ikmyFlH/dW/S+DJGWjutX6rNSPptj0MDmmMPCVvyFrT92vrNA2J40oNomF7gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E5LRamT4; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21f6cd48c56so63393865ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 16:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739318890; x=1739923690; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8liIzcHM1u3spUczGIylHihN/wKkhBUQv4w7iAOlX5M=;
        b=E5LRamT4zvWBRAhqe1eZEAaOxUYVTTdiJGkiZjxo6qFbdoG78BYre9UALr+7uh/DG7
         E0rCiz9jlXjenKwT3eC4/42dYHJwKkeIOaVf+0fkL15gN9zGWR6NccC3rwix6TVtd4Km
         bjItXnmwHJwxZgFvQxv2uTAIG9U420+pr+PZN1Y140/+3neXO8mFxqDk/4nwyqwh1P+b
         4W0+xym0w3tqSs/qxUo+MF5Yw/biPTxYeqV2AbMPZJG4IzHxm3w7Kaejr/1eJkz7ihqh
         2CrvPCFWi2KmuxiF+g2UvOeeu4zUDcK94kYBphzFAaEEDrwX+2yF7cQ8g3dy9FNtHr1E
         cYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739318890; x=1739923690;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8liIzcHM1u3spUczGIylHihN/wKkhBUQv4w7iAOlX5M=;
        b=CAr586nTdLc/dzJe4bz3gOWxEzw4dzWDDaPCWzQfkLblzuVFAaPwttf/Wv2ctn/ti+
         LJAm9kuuii2g0RQgK452iiN79V6h2K//vj5ImlF2mSlOxZ2T5dIkcwjquuHdxi/eVH5m
         Q7T+tzGNf3Lc3frRXauGMEm/hY7BXc3k7h/6CE3J1XQPk82R3iKshMm5F4780mwzScHD
         coB6KTXxwi9AGis9SB48La0yxVbam/Agy1jpp6zapjLqL+30bkXexg2xoOusi8SZo+fA
         AgM4gIDQ/RvVUhZ3MGpn4w/danZUknLusBLdQoWLLQ/wtWhWDFNO2MZ9jbcaXFdALEbs
         QdkA==
X-Forwarded-Encrypted: i=1; AJvYcCUYor+XWybJV5tvBB3lDrFz+CGYMSIjKSu4H+A4Cstcc/6hZNj845E8fiHsYdH+cANAh4tJQoYz1iDNnI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPFP1+GC/MrhY8pzgVYVoeym+tXBokEf/ncH2ncXm+nT9K8afT
	yqiVYIiisV1zY+O06Eug0VemK8KtL6HE5BQ3Gur6/84bsobat6PPtT5zpKmqDyj8Pxmq77aHGl1
	w/3kyH07X/BgzRVOxNw==
X-Google-Smtp-Source: AGHT+IFUbic7UcZHlZI20OaBNl3PcgI+xJhqOVHOTiFk5ZY7KlF8UkqOfMCvhh7294PPKjpCpkxmmjn4WfS7sXPU
X-Received: from pldw12.prod.google.com ([2002:a17:902:ca0c:b0:21f:4bcb:f256])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:cece:b0:220:bcc5:2845 with SMTP id d9443c01a7336-220bcc52b4fmr10063065ad.7.1739318890234;
 Tue, 11 Feb 2025 16:08:10 -0800 (PST)
Date: Wed, 12 Feb 2025 00:07:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250212000747.3403836-1-vannapurve@google.com>
Subject: [PATCH V4 0/4] x86/tdx: Route safe halt execution via tdx_safe_halt()
From: Vishal Annapurve <vannapurve@google.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, oupton@google.com, 
	pgonda@google.com, kirill@shutemov.name, dave.hansen@linux.intel.com, 
	linux-coco@lists.linux.dev, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, sathyanarayanan.kuppuswamy@linux.intel.com, 
	Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"

Direct HLT instruction execution causes #VEs for TDX VMs which is routed
to hypervisor via TDCALL. safe_halt() routines execute HLT in STI-shadow
so IRQs need to remain disabled until the TDCALL to ensure that pending
IRQs are correctly treated as wake events. So "sti;hlt" sequence needs to
be replaced with "TDCALL; raw_local_irq_enable()" for TDX VMs.

Changes introduced by the series include:
- Move *halt() variants outside CONFIG_PARAVIRT_XXL and under
  CONFIG_PARAVIRT [1].
- Route "sti; hlt" sequences via tdx_safe_halt() for reliability.
- Route "hlt" sequences via tdx_halt() to avoid unnecessary #VEs.
- Add explicit dependency on CONFIG_PARAVIRT for TDX VMs.
- Warn and fail emulation if HLT #VE emulation executes with interrupts
  enabled.
- Clean up TDX specific idle routine override.

Changes since v3:
1) Addressed comments from Sean.
2) Included [1] in the series to fix the scenarios where
CONFIG_PARAVIRT_XXL could be disabled.
v3: https://lore.kernel.org/all/20250206222714.1079059-1-vannapurve@google.com/

[1] https://lore.kernel.org/lkml/20210517235008.257241-1-sathyanarayanan.kuppuswamy@linux.intel.com/

Kirill A. Shutemov (1):
  x86/paravirt: Move halt paravirt calls under CONFIG_PARAVIRT

Vishal Annapurve (3):
  x86/tdx: Route safe halt execution via tdx_safe_halt()
  x86/tdx: Emit warning if IRQs are enabled during HLT #VE handling
  x86/tdx: Remove TDX specific idle routine

 arch/x86/Kconfig                      |  1 +
 arch/x86/coco/tdx/tdx.c               | 26 ++++++++++++++++-
 arch/x86/include/asm/irqflags.h       | 40 +++++++++++++++------------
 arch/x86/include/asm/paravirt.h       | 20 +++++++-------
 arch/x86/include/asm/paravirt_types.h |  3 +-
 arch/x86/include/asm/tdx.h            |  2 --
 arch/x86/kernel/paravirt.c            | 14 ++++++----
 arch/x86/kernel/process.c             |  3 --
 8 files changed, 67 insertions(+), 42 deletions(-)

-- 
2.48.1.502.g6dc24dfdaf-goog


