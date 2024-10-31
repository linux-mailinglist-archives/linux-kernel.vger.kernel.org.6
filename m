Return-Path: <linux-kernel+bounces-391204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7F69B83CA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17B01F22720
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B947A1CCEF0;
	Thu, 31 Oct 2024 19:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k3he1NXT"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516221C9B98
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 19:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730404511; cv=none; b=nRN2+Qd+fjL776J3Maq+H8hzLhnNR7TJ9FvMvCUTSphCti03Ge5f0q1HlFm6DaH9RJeqNoyjRVHRL+tNiHVIvhF/6pvxj6q72ojzJeP7WRnUs5CnwlT9Qc9XmHSrO6UYLmYxph6a7TnZhmW3TVwktQr5EFhojlCJ5eSAPQ7xSz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730404511; c=relaxed/simple;
	bh=tnRFYQsiNKJRRAJpeqTO7/ZYdjCKlIkedKEGMns0Rpw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=thW2cU4/XTCiVQggbT7CbmjZw0lyg181DDdViE/XNtm9BKAeGr20YjB+uVsZvtNsoYmGk1ubUg6HItFBSaZTIMdzayh/o+XtP8feocKKSEmieeSr4rmaH8BtCnWo0fDWDLu8KaaH88a+e2gl0uWIiOGUvjnj/tP1+uI/V9tAt+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k3he1NXT; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e30c7a7ca60so1848302276.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730404508; x=1731009308; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wyzFnHlxzBwqMD4Ozvjay5ZNMPU7sJsmztOxAT9avE4=;
        b=k3he1NXTEW/koC7lJ9+q6mpmgMjn59nL4LzpIIsX/ndjBv5mUxoGRk5+0NBFxIWmaF
         uITLSEklaV482eeROFCL8LLzwwikXfYI+NM+jQ6mmMBRYh5w0gOEmAVqpSrA9zi8wiee
         LiUyI57u6+mi6KplBtTap7AT3T4+hIsA3lAS8LKfCWAu2JNGouhWJ3sVsUXjK1zk/Qxp
         9TdegL2vyo+BnHpLNQoGjmPSc551IGpqX4WsGuGN62K+dwC0DWuiOdGYp88FCrwsBfCC
         3hSIAU20oJAKlIw62sqFrhR1DLxkdYCiRPYmMnNJC0A1wTSz26CStMuDPbw1fzck+ZMp
         SPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730404508; x=1731009308;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wyzFnHlxzBwqMD4Ozvjay5ZNMPU7sJsmztOxAT9avE4=;
        b=BEjDF3o6iI3vPkkRtPg3uiLpXOf/XF7vcl/EU0ZfS9IFLWAqu7aa4qrAEO+tDXJv2/
         F2qgvvYSV8ackXvmdJCqQMPlruomu33k+7vwb8oK4h9UKz3O3CMHrQ8Hjuj/HfJyIQoC
         MIReLxq8GEipivoA1CjwBWvXu2u0RFA8ZGu7LZl4nOmZ80KVi6Hf2hPTU7Ey+noj0r8P
         OWPx0pSW7iQN8vmd7kgIaOhWcsX1/PBK0VvYPeG6vy0DfWezhcaU6Ok5phARrPL9k3vt
         SAjQRBQCT/9zeTcG0hhzf3oA1O0o8baG6nuPKH5of7PuslE+nuKPCO0X1sZ9pVxKPP0i
         b0dA==
X-Forwarded-Encrypted: i=1; AJvYcCUzi2pKuGLLnG5EM66rI5g7ybuiK8Y61uDaaaZeTwZl1TNv5qqmoxqIr9sK0RAIqmVSMskjhoCr9jTAvek=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWhPWRNs3Jpd/VwvkwXKtfGXHiaoiR75wJdbSrXdgwrfjNkSEb
	BUa+5h5FuEbdu5EilTzZhAwQqKYxaFrrEToyZWFp0278+KLOviglnZoPf6k+X4XLfrnwViQqmg8
	vlQ==
X-Google-Smtp-Source: AGHT+IGs9TTObWInmuio3rurJ5t64zcQFKVLX6LflIOytK2a8hqQCUBCeAzAMfYBYfs+MNCxmHQ+TrGz7CQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:c78c:0:b0:e30:cdd0:fc0e with SMTP id
 3f1490d57ef6-e30cdd182bamr16577276.5.1730404508254; Thu, 31 Oct 2024 12:55:08
 -0700 (PDT)
Date: Thu, 31 Oct 2024 12:51:44 -0700
In-Reply-To: <20240828232013.768446-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240828232013.768446-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <173039505425.1508775.86255062373291663.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: Ensure vcpu->mode is loaded from memory in kvm_vcpu_exit_request()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, 28 Aug 2024 16:20:13 -0700, Sean Christopherson wrote:
> Wrap kvm_vcpu_exit_request()'s load of vcpu->mode with READ_ONCE() to
> ensure the variable is re-loaded from memory, as there is no guarantee the
> caller provides the necessary annotations to ensure KVM sees a fresh value,
> e.g. the VM-Exit fastpath could theoretically reuse the pre-VM-Enter value.

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Ensure vcpu->mode is loaded from memory in kvm_vcpu_exit_request()
      https://github.com/kvm-x86/linux/commit/ba50bb4a9fb5

--
https://github.com/kvm-x86/linux/tree/next

