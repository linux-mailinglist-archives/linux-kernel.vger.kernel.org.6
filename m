Return-Path: <linux-kernel+bounces-538630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F7BA49B29
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4DE3189771C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7169626D5AD;
	Fri, 28 Feb 2025 14:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J1MqU4Ty"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923D0276D02
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740751248; cv=none; b=mQgSs8z2TePFy2TupwSDtksMNEjJeqyXF86P17dnbcr7KIPP3RddFRv6P6P3Py/yMpVTdSFkxNk4RF3W8zX7o7/WtDKpJMSEipiXE1AYBsh1MDGAwEeAgzHJaF1hIAKGKNmZh8VHJY1Z86C8HhJfJbh7sFomhGHwLzro7vCLyi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740751248; c=relaxed/simple;
	bh=nLsYFA+9Uq+V/E+xYSh9uoNX7fENRkgSpLxOK3Ox7Hg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mb/8TIbakCVLXtM7JjdnF6GRT66La9OS2xPB6StZEbkafBPqhx68pQX8fQGJzllC3rgiJrpslQerCwarHVjtbRmSPl9XneM9uaKGm3sjzq342ZyCrj5oN+98rl49bEkDD+OKF7PJegxP+YE5Yfi72kslCmHoUB5LZ0imRnuJDZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J1MqU4Ty; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fea8e4a655so6270747a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 06:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740751247; x=1741356047; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DyKtF19JR26GWiT169e8Z3znTSlUX9yl7SG7SduZ39o=;
        b=J1MqU4TyxbDhntM51vCssY8ewuGrhEL7hdKW55QihLbZwOkkDbZDhg1KPRbsqvbrcl
         RJRsKU+/hD8uvmc5bslED4fDRY2Yl2NtaulFNVvmbDxOZSOV213yD4uGl5+Ar6M/Kdo1
         UR6pS01xzwTpvWumnzfBBFLXfYVPX2gu+cjcm9tiKhvbHQLE5y+b8Qm5glNUqzp8YGzR
         ZLOudi9lkCP0FXGZr309KfRsn20fWyN0Rs7/ZKGfhOsRneniOqc6Fm+hVuKT7q4T4BxL
         xahw+8ErKjtFwVgSSxM17j8Ks3Hq6qBSYkzd9+KZ/doDNGJqkEYTJaggW+PDpZ9IRTDl
         opyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751247; x=1741356047;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DyKtF19JR26GWiT169e8Z3znTSlUX9yl7SG7SduZ39o=;
        b=Nkzg0UQCY3DYdMSgC9PpAA2t0a37qjp7cVe0eqCGKpnsKhNoo/16k0H/IT/ieAGR0C
         1UXRpxHdvXRO8mEQVDh7lC5grWTjErxSv6OBEOSEyu1PxkivPxaOf223t0mCiD+1fn7m
         RvF2Ne5S4qvjgkpYiHOuP2MpuTgcQZESfw10yH7E6fT1aSzt0EAoi2Fcz3bUqp48TorB
         5bZSAEncpjHAlrfTX81v2XsFMSFUIXxvf5RzganTBffuD01Y1svtwVfHjHdCEkzr/A9b
         ovuuf/hu+97cyGgKwq/oQYkHk7QAUB1+jneohOAioOqprMjnmNdZ7XKGxjvv1E8vxY/J
         lhoQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+snHkvm0Xu5XNBKcvFVM2OAFDcnV8kH+7R+sOPO4XXks50IPTnK44VQOTRoq0G0O5YGlcGS3CJLyDKgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjiW4ZRtm3IkDVbJAPChGZmdsEW7vbwP7vmh/XOReiToiEgCPB
	xlaPMxWSPrgvOWENEJ3HooTCh1zdj8WM8SNyQw68xlPFquQwWN2rfMZCsNDDzAa5LDNnHOlIZn/
	+aw==
X-Google-Smtp-Source: AGHT+IEwF64TMkso0dQJEFb+wyg3aT7hGwiirxJOIpxtqZPpJrizTUlV9LHpZapcLsVpoJixPPP1NIe6hRk=
X-Received: from pfoi25.prod.google.com ([2002:aa7:87d9:0:b0:730:7648:7a74])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3287:b0:1ee:8520:f979
 with SMTP id adf61e73a8af0-1f2f4e4c806mr7311947637.36.1740751246899; Fri, 28
 Feb 2025 06:00:46 -0800 (PST)
Date: Fri, 28 Feb 2025 06:00:39 -0800
In-Reply-To: <Z8GWHkpSt+zPf+SQ@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250208105318.16861-1-yan.y.zhao@intel.com> <Z75y90KM_fE6H1cJ@google.com>
 <Z76FxYfZlhDG/J3s@yzhao56-desk.sh.intel.com> <Z79rx0H1aByewj5X@google.com>
 <Z7/8EOKH5Z1iShQB@yzhao56-desk.sh.intel.com> <Z8Dkmu_57EmWUdk5@google.com> <Z8GWHkpSt+zPf+SQ@yzhao56-desk.sh.intel.com>
Message-ID: <Z8HBh1WR3CqcJkJQ@google.com>
Subject: Re: [PATCH] KVM: selftests: Wait mprotect_ro_done before write to RO
 in mmu_stress_test
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: pbonzini@redhat.com, rick.p.edgecombe@intel.com, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 28, 2025, Yan Zhao wrote:
> On Thu, Feb 27, 2025 at 02:18:02PM -0800, Sean Christopherson wrote:
> > On Thu, Feb 27, 2025, Yan Zhao wrote:
> So, I think the right one is:
> -	} while (!READ_ONCE(mprotect_ro_done));
> +	} while (!READ_ONCE(mprotect_ro_done) || !READ_ONCE(all_vcpus_hit_ro_fault));

/double facepalm

You're 100% correct.  I did most of my testing with just the all_vcpus_hit_ro_fault
check, and then botched things when adding back mprotect_ro_done.

