Return-Path: <linux-kernel+bounces-535254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D26E8A4709D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D502916E622
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD534EB38;
	Thu, 27 Feb 2025 01:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EYZ06Edg"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9392270047
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740618076; cv=none; b=Xac80PaqW96L1FtgSJjj8HdmjUtttVsJUBX6UzvTQzHFlVpCiSi7vrN1O9uFVaU0xU4F4S7GZMZcvbcMVNhNvNM1NvGkDnlUnQ9nNfkfDOz9x3skTblBJX4LW1PpJnS0we74Khec8u6FhtxHgwVl5wRIoR4zCRk+XtP0N3wjWM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740618076; c=relaxed/simple;
	bh=MJkxaDKjp4xLw2qAO/PVE8kYrbfA1Tvd5U0UZQv8DxU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=H+mnVSEyWaL9/gTJJ/GNunT1W8/SJ7RMNA9mNoWmKEKhUIzpXowkVy4faQGkmWoliEsglrmiugTk89dR1JoSObWVEArBgH5k6jMy0yCh51C4c36/Ev5IaD25SF7WfbCZMKuMdgyeS4+jTMwAEUYqWcnhNpWtKtttCsoNG+JNGL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EYZ06Edg; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc45101191so929793a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740618074; x=1741222874; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FGSvZnsTup4FbvQYUEbSwqPM6j8STYAb7LEU04cNgQ=;
        b=EYZ06EdgXIZASadq/PZA19WE3+T01lDv1qivriUD4MBsZ4l9DvPWnNXc/3L/UHttt0
         oVMygi4imIdNjDIzJaId9+InIj86Xw5fS1tmUlhCTNmk/a052WYxLRWnUk61h89EiKnD
         i2fGlXk8XBSaQCHRayqrnBd3Qta+KxaprpU8T0r2a/ISaKOhBcJUodjba8RmCKm59LPj
         ajxvjo7I3WTCoxIGmZSWBNnxXHRKo+t+FafqnCIBXfYbxadFKazxxmHZb92jyhQzPwsS
         gSL4efRxBUcxNxccm5Xlx5rDH0rf1Dm2L7g9Obq8IhRF5zfxInNPSuG7wkULJotm8wD+
         p5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740618074; x=1741222874;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7FGSvZnsTup4FbvQYUEbSwqPM6j8STYAb7LEU04cNgQ=;
        b=lfiKITyMl38qxlimCHh6P0UQSXLIqoVXBJtiSmZF5PXJntLZ0mYLsO2AKbUho/DSx4
         KZmH8dRL6ll9+dPGb+IXmo6nlPyQwj7hwS94QI3BHHfILJa3OPSwoEETsFvlh+Ciy7YU
         N1yXMKaS/uqGz2IzY70lNoZZQF4ZwIHgYo7ODPrQ4uW1YEhfQNY2GOuz+3E3ip4EWbCQ
         auG/LLV0wyfnwrq3zl7qwrUgf+Bw7teAnDk8Jgdrupy6+EWiKsfgSjmCrHzJC5NVzRSp
         /YSOtaWIM0QAnM/V9XtUKgU8QmPnF/3ci9nVwyua5d1ARzgowKclovNj01Mh3hHUXdUx
         +twQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj0LZw59vu5NZSvBfe2uxGkPOpNhBp5Fu5KZmYLI3fyxSR8iYIDC4PhNv1llK1fiaCUr3vsq6JfR7EMGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVLgU8XoomEr3dpAMONuuQOu4nuCdTZgwO0IyyxIfAZFyfSTEz
	+PlovoZ1Rs5snDsSg+hu7DqEW8MN0Umvc5uMBZ70oAay8QPNQbXKp/VR24QOAgxtpK69jDpLzwU
	2Cg==
X-Google-Smtp-Source: AGHT+IEpwphmkDcWYyRaf/JaCL+77vUw2LSwzN385jLypriLNDJlK7izhiOdGrcQMdreqPyQe3yEl56oAEc=
X-Received: from pjbpa16.prod.google.com ([2002:a17:90b:2650:b0:2fa:1b0c:4150])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4fcf:b0:2f8:34df:5652
 with SMTP id 98e67ed59e1d1-2fce78beb41mr33084170a91.21.1740618074186; Wed, 26
 Feb 2025 17:01:14 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 17:01:09 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227010111.3222742-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: x86: Advertise support for WRMSRNS
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Xin Li <xin@zytor.com>
Content-Type: text/plain; charset="UTF-8"

Advertise support for WRMSRNS, which should be trivial, but is mildly
annoying due to a token pasting collision between the instruction macro
and KVM's CPUID feature bit shenanigans.

Sean Christopherson (2):
  x86/msr: Rename the WRMSRNS opcode macro to ASM_WRMSRNS (for KVM)
  KVM: x86: Advertise support for WRMSRNS

 arch/x86/include/asm/msr.h | 4 ++--
 arch/x86/kvm/cpuid.c       | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)


base-commit: fed48e2967f402f561d80075a20c5c9e16866e53
-- 
2.48.1.711.g2feabab25a-goog


