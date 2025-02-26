Return-Path: <linux-kernel+bounces-532794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE4EA45245
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D431742E8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C91199FA4;
	Wed, 26 Feb 2025 01:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kLSkW6pu"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FF51990DB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 01:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740533860; cv=none; b=lK/j+PuqJcKrCVvwCC0wvUMYqKF7YcgdUTQ4VUusm/qBU+Di14/1M9cm5bdjDNgKWiLmq0dSUV+kS6DLdm1Dz3fgKWK8Dmngcg1+bQmc7z7G9G9huFwg3CLf8dOC4lPxHgH0LBzBvOINMelBrrK5ZzG6220IN21rThDtWQaBBIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740533860; c=relaxed/simple;
	bh=SZXVHGpnAZAjUR/CtLa8PUD2AYYL1dTCoQzVwHq4l6k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lEyGwkyikkWP7BZ9ULgyEwDCvOJ3xXVw0NI7QovYQfUOiLFX8eLN5my2XKQ/qE/vx6tlvo61RzLKzp9VoHhhF5JPDOda3SWpwlJ1xCOvPudcPi7qQJreQsl+7TRVayhA5nxPSHpSFvLn/lASLUHAo40rHWPLGNQz7wKMy4zp5WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kLSkW6pu; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc2b258e82so13425223a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740533858; x=1741138658; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ULZtC1FDd6NUJ3rI9g4pbuHdjytTUlPfqVdSRlPBgi0=;
        b=kLSkW6puJ0deJ0Y6F7Dm4/ygcE9253BQi0wbtG/OUUSPQ2ha+SFovO91g2HCke1GZ/
         PdrU6bC6V7si0Sq4nNLOD9Vwv1pGaJVzSp1lvVtv86JubadJups6h0Z7oOCR8+PTPQ8H
         yvE9hZrNi822PwoIyPelafcLd5m/CQJBebP19/krmfMJfp2rEHPK5r2y+mPYaT2vU9fi
         ngJ2pcpw9Ejglz1ajr8xHCyn7hB8r9i8z7r/NEaboHJQcULeaDo/PnKbMU3tspsQq1Is
         blf/FpAijK1uQ3i9F26dVb3Je15Uh042jlf/ko/z7DRWVrwl4/4LB6Kjs3iPnubAcemm
         jCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740533858; x=1741138658;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ULZtC1FDd6NUJ3rI9g4pbuHdjytTUlPfqVdSRlPBgi0=;
        b=Iy7NJf1xQYwv3ZYuKfwzSm5sGp75T/vh285iI+ANDJBoifAWH3l1DxMW4sp7K6oItl
         o9e9zMpIUMoZx3TBKD2taYhhMG5kK7azzuzPMndZ0ZzZ0yPI62G07KLK5STE0mQjJ6J2
         8pAyH0Zug8qDrfOgXrgL95TfM0aE3AxErdQ6nvdtddliGI4o+RZz74ZoJ8UrAvt3GMT2
         3ZP8DQmtZ1rlBUaB4587+HVL3I+Ek8QgleFm5zPqiVDORavfshg92bWEgaZLHNOMiNg7
         U88/qa6umUH7PeOxYOmcFU14kpFHP1c6+dqBk7HIP9PSm+UKyc7yRwrJxaGckBeFloDo
         8XMA==
X-Forwarded-Encrypted: i=1; AJvYcCXcYx3oWmlwWGVHh5VAre5xlxvIE0FUDZR5TsS6YZ67tZ3BxU062bwMACVi6vDZvFQvOwF3eC8xx1m1+jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvriAeYyG8O5K2tSE1/80g4F6sdWjd4HJIfkkJzxYU+hDgyYWw
	0BDVSPvPNNOo+Mfbz0qy+rNI0hAEId5F7jCSSE4DZSnZQER0PVs9QezAdjlKcr5Ahkg1lSetybk
	6Zw==
X-Google-Smtp-Source: AGHT+IHA8CF5QxCpD/x/wbknob1L7guzavFzGaqCBJ/GtwIioN65VvOsc9KVNLvbhXTXOB4aN7b1T5gcI8o=
X-Received: from pjbee8.prod.google.com ([2002:a17:90a:fc48:b0:2fa:1481:81f5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d48:b0:2ee:f550:3848
 with SMTP id 98e67ed59e1d1-2fe7e2e1088mr2350421a91.5.1740533858514; Tue, 25
 Feb 2025 17:37:38 -0800 (PST)
Date: Tue, 25 Feb 2025 17:37:37 -0800
In-Reply-To: <20250128015345.7929-1-szy0127@sjtu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250128015345.7929-1-szy0127@sjtu.edu.cn>
Message-ID: <Z75wYblH3_IFsoUW@google.com>
Subject: Re: [PATCH v7 0/3] KVM: SVM: Flush cache only on CPUs running SEV guest
From: Sean Christopherson <seanjc@google.com>
To: Zheyun Shen <szy0127@sjtu.edu.cn>
Cc: thomas.lendacky@amd.com, pbonzini@redhat.com, tglx@linutronix.de, 
	kevinloughlin@google.com, mingo@redhat.com, bp@alien8.de, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jan 28, 2025, Zheyun Shen wrote:
> Previous versions pointed out the problem of wbinvd_on_all_cpus() in SEV
> and tried to maintain a cpumask to solve it. This version includes
> further code cleanup.
> 
> Although dirty_mask is not maintained perfectly and may lead to wbinvd on 
> physical CPUs that are not running a SEV guest, it's still better than 
> wbinvd_on_all_cpus(). And vcpu migration is designed to be solved in 
> future work.

I have a variety of comments, but no need to send a new version.  I'm going to
post a combined version with the WBNOINVD series, hopefully tomorrow.

The only thing that needs your attention is the pre_sev_run() => sev_vcpu_load()
change between v3 and v4.

> ---
> v6 -> v7:
> - Fixed the writing oversight in sev_vcpu_load().
> 
> v5 -> v6:
> - Replaced sev_get_wbinvd_dirty_mask() with the helper function 
> to_kvm_sev_info().
> 
> v4 -> v5:
> - rebase to tip @ 15e2f65f2ecf .
> - Added a commit to remove unnecessary calls to wbinvd().
> - Changed some comments.
> 
> v3 -> v4:
> - Added a wbinvd helper and export it to SEV.
> - Changed the struct cpumask in kvm_sev_info into cpumask*, which should
> be dynamically allocated and freed.
> - Changed the time of recording the CPUs from pre_sev_run() to vcpu_load().
> - Removed code of clearing the mask.
> 
> v2 -> v3:
> - Replaced get_cpu() with parameter cpu in pre_sev_run().
> 
> v1 -> v2:
> - Added sev_do_wbinvd() to wrap two operations.
> - Used cpumask_test_and_clear_cpu() to avoid concurrent problems.
> ---
> 
> Zheyun Shen (3):
>   KVM: x86: Add a wbinvd helper
>   KVM: SVM: Remove wbinvd in sev_vm_destroy()
>   KVM: SVM: Flush cache only on CPUs running SEV guest
> 
>  arch/x86/kvm/svm/sev.c | 36 +++++++++++++++++++++++++++---------
>  arch/x86/kvm/svm/svm.c |  2 ++
>  arch/x86/kvm/svm/svm.h |  5 ++++-
>  arch/x86/kvm/x86.c     |  9 +++++++--
>  arch/x86/kvm/x86.h     |  1 +
>  5 files changed, 41 insertions(+), 12 deletions(-)
> 
> -- 
> 2.34.1
> 

