Return-Path: <linux-kernel+bounces-510202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF940A319A7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67DA63A6A60
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE7B268FE5;
	Tue, 11 Feb 2025 23:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zz6YBY7A"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EF827291B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 23:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739317583; cv=none; b=t2vmcrxxg3E6Gm5+1QjlUi9Jfb+Hn2VSriB8msAw/RV+/1rYX2l4fEAeGWzlSmH2cuhIbeLb9uStQpIMvCggX31XeMmrrOkSqawkfeq+dQdmOZsVthlxOC3CRzxNefOs5xMnp9rCt8OsEB1Y1KaxK2QRgN+2eYiYkIqm0TaBfws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739317583; c=relaxed/simple;
	bh=kHUwfpy1smNGdaw85fEjR6sH/+WmLJ/W665jWONW8wY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=glrQohTLu8ir2IPFcpwhRb52YATKYk6+V4S/qJ6A89dtm9PnZF00swedNtHYSUBrd285lozSzcffoUNkZCP77ffrfwlPy6cchpOepSz3AiA35IgZt64xKP1HmTLv457btsc8c/PdewYKwJI3TnumdAA5JdWTZrzUbAXLHFauC3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zz6YBY7A; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fbfa786a1aso223295a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 15:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739317582; x=1739922382; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E9Xzg9fBMPuduClNg7a4EXeruDnPSNgXZs+2LgOO7Ss=;
        b=Zz6YBY7A6WnbWLYp0yVYBsiwrdxRAByeHUIvN/Hedfv3PcDtwoX952ZnykkqSZEXxr
         KR1sW3919j1vN+VE5d1oRkF8fsIoz88hAZQNUN1QXtQSZ0vcSdEK+RSbc2Rnj6hIa4dD
         oHp9rYSB+xVP9jD+KSzdVngz9/2Tf7Rox9NqsZc44A2JRyISBsfcjpU0BwJ5HKUxF/RW
         /IeM65FzUS+wU9iNxn+BIxfTI+GWXC/bY8K8UpJIXgr492djf/jhn97efiNDkdDE48E4
         oQD2Px8R5XAaPO5oD87T4ap8AfsMCOdyhm7/RxIGnKboF8RU4Dgj7T8r3dDIMAiQi8Zu
         petw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739317582; x=1739922382;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E9Xzg9fBMPuduClNg7a4EXeruDnPSNgXZs+2LgOO7Ss=;
        b=ghIOyE6eNfrJ3jTCK07W9e7ZynK+J9/7iuFJcJhWrpcvWbGRdmfYlslkj5K8FXnMba
         jNRDKA3J+sUMF4vyErkuINl2iWnRLLDcfOFAKB2r1DrUrvot3CLrLzKidoZHJGe2RGdo
         eZ7dRtpPaEPhztoVHG0JrzfzfON8cP3h/UaqAve/LYYIR1+dHK1yiMv/mugkysEh2CmK
         WSa4iPcNb10z4YVblobMxTyboNsyEiOx4dEyN9cq3l4q985XozE21j8EteYdrnBeAjN/
         sX5cGPCmoqerJ14ZDwhPLOObKmE9NFty7LkL2WV/331LY38GG1GW3FXEr8m3ZsZbgAM2
         BTqg==
X-Forwarded-Encrypted: i=1; AJvYcCXD8ewBsbJKHVsbiyfLUOFNzQJWDfxKxcSQCrTJ9lHmo+eFKhqEujGeFV59xvllB8YczCc0FWcq9tx9r8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN2iVxc/UEoYV6CItwLiYX+jpoR+JELlI8vaC56K1cDEESsJf9
	c9Lp48zCpCiap+BE6ZENYuAbJHOk6Iuzazme1UOlMWlbEn+EA6lksoaZDvnYhq31CVll21Sxz39
	p1g==
X-Google-Smtp-Source: AGHT+IFvQzX7lWGLAMj8TJxXLpAAUI5EKLtWu6l9t6xkKWmGql2QeNCpb4soSUkQDdQZD4EObhZCf0S98Tc=
X-Received: from pgho13.prod.google.com ([2002:a63:fb0d:0:b0:ad5:433a:36b1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3987:b0:1ea:db1d:99b
 with SMTP id adf61e73a8af0-1ee5c732540mr2128000637.3.1739317581787; Tue, 11
 Feb 2025 15:46:21 -0800 (PST)
Date: Tue, 11 Feb 2025 15:46:20 -0800
In-Reply-To: <Z6sNVHulm4Lovz2T@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250211025442.3071607-1-binbin.wu@linux.intel.com>
 <20250211025442.3071607-4-binbin.wu@linux.intel.com> <Z6sNVHulm4Lovz2T@intel.com>
Message-ID: <Z6vhTGHKIC_hK5z4@google.com>
Subject: Re: [PATCH v2 3/8] KVM: TDX: Add a place holder for handler of TDX
 hypercalls (TDG.VP.VMCALL)
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Binbin Wu <binbin.wu@linux.intel.com>, pbonzini@redhat.com, kvm@vger.kernel.org, 
	rick.p.edgecombe@intel.com, kai.huang@intel.com, adrian.hunter@intel.com, 
	reinette.chatre@intel.com, xiaoyao.li@intel.com, tony.lindgren@intel.com, 
	isaku.yamahata@intel.com, yan.y.zhao@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Feb 11, 2025, Chao Gao wrote:
> >@@ -810,6 +829,7 @@ static bool tdx_guest_state_is_invalid(struct kvm_vcpu *vcpu)
> > static __always_inline u32 tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
> > {
> > 	struct vcpu_tdx *tdx = to_tdx(vcpu);
> >+	u32 exit_reason;
> > 
> > 	switch (tdx->vp_enter_ret & TDX_SEAMCALL_STATUS_MASK) {
> > 	case TDX_SUCCESS:
> >@@ -822,7 +842,21 @@ static __always_inline u32 tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
> > 		return -1u;
> > 	}
> > 
> >-	return tdx->vp_enter_ret;
> >+	exit_reason = tdx->vp_enter_ret;
> >+
> >+	switch (exit_reason) {
> >+	case EXIT_REASON_TDCALL:
> >+		if (tdvmcall_exit_type(vcpu))
> >+			return EXIT_REASON_VMCALL;
> >+
> >+		if (tdvmcall_leaf(vcpu) < 0x10000)
> 
> Can you add a comment for the hard-coded 0x10000?

Or better yet, a #define of some kind (with a comment ;-) ).

