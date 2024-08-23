Return-Path: <linux-kernel+bounces-299784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2050595DA0E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 01:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2222812F1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 23:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA7E1CF2A1;
	Fri, 23 Aug 2024 23:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oajxsVtB"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28961CC889
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 23:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724457522; cv=none; b=hLDl7lNAWMwSm0I+iFXRtf+JXg1JJuuoj4hapJ5HD78N9sbbgUHTwYHjWS9x0OtZpLxOP2EtL7daSgKYS5z34XDuagDUID2dq24KKqJHsjyMuu7arMdpnHj603ezQAjWP0ZVpRI05Mb34sp8mFP7k17WkuUp2chxUCBwpXahil0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724457522; c=relaxed/simple;
	bh=EZnDiP+H4EwOKgX7qkLqjYtgAGsjgTHhpEH2SYUK4xw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BXfUqUjBD2iks648SR8vpwAJnHenMcboqqkuqoTdHlJhqvnO0dxo88TXalMkCAs2vpW+zDxO8OXo4zQrKNOnkl+S0FhbwSjP6E9qo/cyHUel0WM49B0hi4M/68vugWSEpVr7XKrxr7WUNCYSu++u4NYi3Cm0KJli252VOJ0IdyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oajxsVtB; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-201e7b422ffso19951295ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724457520; x=1725062320; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rR0a1BvyppOzWFu9WKacrQqpVmdl/25JJw93CQIjilE=;
        b=oajxsVtBhdj1US0x2DYYzAbsBJE7pEi7e5Tp8BzI5My1ncjd3rIbINYZEQrSeN3DRI
         TaAF3OvyomQOyI+nWb9FVOr+hwIuKCjvRRSAjdUd+6SXbIVxUw2DgPvjTpZi1jbncE4a
         06ztmhZNOXgOFPCc30tNXnuajZjuFfbvtj2Nh1WaX/h1aKbFHtBR8UsUQZ5JXBa5hdOo
         Fhm8oVIaDaAPBK6vXOFuRVl6kecXQx50JaNlc3+ygEgnb2CpIMEBmJKDeF1RKl8JVGBu
         8VJNWsCnd6yXP/AsU2kPy4qoGZXyHhN8KSWdkpxPEAwEgM0uiAsjBZopBQTWbPBqTM6N
         UciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724457520; x=1725062320;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rR0a1BvyppOzWFu9WKacrQqpVmdl/25JJw93CQIjilE=;
        b=g/rhHkBkim4phGuzCuaXlB4OtP2GqcYaDhr6StXN/uMAIGrwMekmWr468mnHTCE9cv
         pxa/1F+8AZ0p7zzWnXykJre5wOLpt4kMo/vLqdAdt92fTYy0vME0yRBT9NTwt4d/UX88
         /ytr1qnSzqMgjLGJmCurtwMoMCvx0o1suxJsM3Q14XUUy9AfEzBztosiQum+Gl5qIRdX
         eIeH9BTwKw689br9hfHEJZTw6ElQdNpQx/SCgpP5oKB4UsHJnBrhqU0N+LLEPctqxWTs
         /chM/KO9EkkOqSUMPvL9YXTIHkHhAgO3P3AE2MiDh7woWv1sMD4RpaSBjtn21+cAedFL
         SRyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWrA/4E0MjdQfmhbGPKmKbFe1UpalVY0eOrJEkL+h8K/qC2EYdinV8WUPyULIAwxdi/g0L/1uoPqN7DyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG+ShjALXLm8pikDJ6TnXOp4Ej1EyccpgHf8tNkRHqjfxTzuOF
	RvdqbMj3L8hCSBRB5RT8SVOIfMrR8zNhW3iwD6Z7mYHf0Y0J9OMzugNtYfk1kdLcQMswIS/TJsb
	nAg==
X-Google-Smtp-Source: AGHT+IG5VtW+JpePTOa8v1oWLzCJ3MY+DXJlX9JgMVSjvzgFJr+VY3CC4ZhaQ8GeVnaLr8IUKRsezzzkiFg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d50d:b0:203:616a:8673 with SMTP id
 d9443c01a7336-2039e4d5cdfmr3410755ad.5.1724457520203; Fri, 23 Aug 2024
 16:58:40 -0700 (PDT)
Date: Fri, 23 Aug 2024 16:48:09 -0700
In-Reply-To: <20240816130124.286226-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240816130124.286226-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <172443886668.4129032.11970184788806787426.b4-ty@google.com>
Subject: Re: [PATCH] KVM: VMX: hyper-v: Prevent impossible NULL pointer
 dereference in evmcs_load()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Mirsad Todorovac <mtodorovac69@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 16 Aug 2024 15:01:24 +0200, Vitaly Kuznetsov wrote:
> GCC 12.3.0 complains about a potential NULL pointer dereference in
> evmcs_load() as hv_get_vp_assist_page() can return NULL. In fact, this
> cannot happen because KVM verifies (hv_init_evmcs()) that every CPU has a
> valid VP assist page and aborts enabling the feature otherwise. CPU
> onlining path is also checked in vmx_hardware_enable().
> 
> To make the compiler happy and to future proof the code, add a KVM_BUG_ON()
> sentinel. It doesn't seem to be possible (and logical) to observe
> evmcs_load() happening without an active vCPU so it is presumed that
> kvm_get_running_vcpu() can't return NULL.
> 
> [...]

Applied to kvm-x86 vmx, thanks!

[1/1] KVM: VMX: hyper-v: Prevent impossible NULL pointer dereference in evmcs_load()
      https://github.com/kvm-x86/linux/commit/2ab637df5f68

--
https://github.com/kvm-x86/linux/tree/next

