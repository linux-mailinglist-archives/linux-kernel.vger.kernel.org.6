Return-Path: <linux-kernel+bounces-510294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 276C3A31AD3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC936168470
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDB218651;
	Wed, 12 Feb 2025 00:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QPJCiV0x"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6140AFBF6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 00:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739321449; cv=none; b=ck2V7VMTAIEATc8TqDLiG6NjX+o81WqjhFzMpyeVsh7aGusHjG+mYHaNadmc8mBn6ZKivTRMyWropRzkcx7wlucTAoCjuZHgdxEqo8cke0u34WgE39gfYUkrpWOzDsX5fKMvgjwbrCDmnV4fw+xma8Fzp+i4ucmYFbpn8ZmspuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739321449; c=relaxed/simple;
	bh=n7CqHuFFZQ8afu+pSBOd4jMSThSswJ5fMlHS0DKB38U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oaDXv9WnZpFH+Pry/K8HqVTDsBI0FhwQkVPGVbTqDZeo3AyyQKVFn0Ig5+qOHUXLl0Lk3gU4ismzPizCdWnQVoLeeOwI17U3LYG9YsBJ3qVhBiTUUJ3+ds0AB2aT6nAU3niAEUTtJhP2bAqtGrM+yb9sS0dzBozO3RMYy0Yol9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QPJCiV0x; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21a7cbe3b56so88955405ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 16:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739321448; x=1739926248; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Q04QbfQicFM4y75hWxHLLd0YYIdGidwmS0pxxw3Lsc=;
        b=QPJCiV0xDPapSJ7g+OxDZCRRULlwPgYWajOlCi0Ds5Ipk+ro6e8MstysvHU5i2PkjG
         Nj7jN/xKSgfXLej7ui5StmoMqLsp6/kv0CpQNMyZLoTVANkUL099iCenOpuaJdcSfg2t
         ntZ1ce92zuTxO2NKeylabcrg40CxMN35TtKlUS8gP/sbbW9uvIkoZfLuIHFyMbPGyqnb
         Rvk4Y1OXeSb0XKYCioHQWFw4VOYpcKwrkmTRO5xw/b1oupHg5DPvPMi0vBKo5i6am+a9
         I1xbURVbycMud7ONdA+P6OJANyZ5sXFwkzUMTcR920W0Mfly95uiskNr4uk1QUHdQqrc
         igXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739321448; x=1739926248;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Q04QbfQicFM4y75hWxHLLd0YYIdGidwmS0pxxw3Lsc=;
        b=XR7nY5yyu1aWNvN8Y9T2ToMeWBkVzV8melkw1qFpF8fPwmWxYKY3kIaHSoQMNkKK8D
         vVA7koFTtxYiS68jskrZpmTHB9zrC1dgqZwhCoQ9ipfbKX8Ve+Hdq22M05EvUjg/f3H7
         KZg4bdvSuSZCpGF8RV02iE8OvbqsYFCapoY0EsmTOhuNVE9DU9XVw7+sIPvY0yYgXOqZ
         inuHmE4Nr92lOLcbeK9QdXltWLM2M/TUx4t69dcr/9uswDoz1ReVt6rFXVr4q4LbglmE
         QBxFwFiskpGjrSe0tN3ROLwuge2E2P1eEhQ5C1r7FApxu1Vb0J+WxWrH2ZB5K2XIkzlL
         8x7w==
X-Forwarded-Encrypted: i=1; AJvYcCXdvX6cwu70HXId/8cH9fX2haR7nBhZ+2Cc+kLDAZRtfIwT2P5ZSRsiUu8hsdTkfFwX0zZhFHls91Pqfw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0frk1EM7XOxXD2dGH7KHNl4jBF3ML8lQ3HtCkDXUDInVyXZ4P
	y9SpI/uOpbbLbnplf1djqSSgjj4vg46HfDuMa49QyboU4AdkVrnqy95EMhc2xfc8fhK1xNe1kT4
	3fA==
X-Google-Smtp-Source: AGHT+IHIfpcFcenWfDWwwbzufWY+DREdE282nCSmNYgV1FntJ/Yo5mvEkgosXQd56+1kM3WiXT9iDdhEUCE=
X-Received: from pler19.prod.google.com ([2002:a17:902:e3d3:b0:21f:179:601a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:11cc:b0:216:2bd7:1c27
 with SMTP id d9443c01a7336-220bdfee64emr12985535ad.33.1739321447751; Tue, 11
 Feb 2025 16:50:47 -0800 (PST)
Date: Tue, 11 Feb 2025 16:50:46 -0800
In-Reply-To: <20250211025828.3072076-17-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250211025828.3072076-1-binbin.wu@linux.intel.com> <20250211025828.3072076-17-binbin.wu@linux.intel.com>
Message-ID: <Z6vwZtnxIX292KLH@google.com>
Subject: Re: [PATCH v2 16/17] KVM: TDX: Handle EXCEPTION_NMI and EXTERNAL_INTERRUPT
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, rick.p.edgecombe@intel.com, 
	kai.huang@intel.com, adrian.hunter@intel.com, reinette.chatre@intel.com, 
	xiaoyao.li@intel.com, tony.lindgren@intel.com, isaku.yamahata@intel.com, 
	yan.y.zhao@intel.com, chao.gao@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Feb 11, 2025, Binbin Wu wrote:
> +	kvm_pr_unimpl("unexpected exception 0x%x(exit_reason 0x%x qual 0x%lx)\n",
> +		intr_info, vmx_get_exit_reason(vcpu).full, vmx_get_exit_qual(vcpu));

This should be vcpu_unimpl().  But I vote to omit it entirely.  Ratelimited
printks are notoriously unhelpful, and KVM is already providing a useful exit
to userspace.

