Return-Path: <linux-kernel+bounces-391195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8D29B83B6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB3D5B21BFA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30951CBEA4;
	Thu, 31 Oct 2024 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2UKputQc"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFD61A2562
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 19:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730404418; cv=none; b=SIUXkHdrtQrh6h4G000wB0hRGHjWH+/vo0qtVBacGTzYldMxL7oEzatoXBglQUODY0SExAgi5jKtNkPElQrHyW/P6q2hx/H1jOPHlLmrNi0Abq/Dnp/W4llGl/TrcZW6SxDt8hPun9GAHdq1200Klau2EmrvfCzjsrtBmDs0EaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730404418; c=relaxed/simple;
	bh=FroSOV/uD5rdzEaLIMdl9JXIy+2JWa3hTbW339w1cW4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PrrTgXWezdl4wVIn28PM0z4//F/WlYk2MZox7UtsRfMrQkzs33+dZxvVP1Oyd0XRKJ9dMZMPEuEqO5I3Leuew/FSYl1abYfhvAFeyQD0hr58rJ2TylE3IcWaILEMKfRQ5LKsTCwrUVfFEQNK6MluXuTe2gJ7RZot9fuitklftVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2UKputQc; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7edbbc3a9f2so1070314a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730404415; x=1731009215; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HDryuS3JwdKmtkDt/QNqzIISsjjDc6tSvCEk4zlonUE=;
        b=2UKputQcUQhz6JuEz0yF/Skk6de22nc99lxi2D2vv04WoUE4nsqDahPvUqtoUGPuEU
         N9QEwUyGMIOFtgsgsTIe3zQG+yd25wOjRMtNB5BcFfwamIvJPBP0wkYxlZmg3qVFZ1gZ
         J2U3XNG3SwYE7sUWrNdFqlUyMGVxD0khKp3+6WwtfuU7h+tnh1AIpj+Pm4qubjr1nb0M
         laVcGwcIJ9eeZbtF+hnwelyzZI2OA6yj/Zr/YDc4DyhsmtPEss6HlhP84PpxWOyOth5x
         cW8CLfHRhcDjBLre6MZsnQkr3+OaRAUBL2qi62VdP4kGCPoA8nOotkLOMCNvznRyTa0A
         XGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730404415; x=1731009215;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HDryuS3JwdKmtkDt/QNqzIISsjjDc6tSvCEk4zlonUE=;
        b=hKAe7ndXpyx09BEAOFe5bmkuNc1iBB3xsEChUQW1poAk0LzEH9oXqa22EQl335gqmB
         5VH/URjS7KQHvgLMFqXVLtNJBju5uiRoxyAg3piiSqHqqauQ+wg+1knSFkNq7UbGcOpw
         3BJMax4jWw7K9xcZZvRNxQtqHCCgj7c5jAG5U/WgmjPN5FyzO3PIq0qawe8JcDEqJPEX
         cOs7eG+fMOBp9EWuE8LWK6wjRfKObObzgrimNIhhA2ZGf34okyBliIWfQ6VFyJmuzoBQ
         kW+kjzc4y5KzYXoY5+tPCCaAm2DWXmVCbuszwpHvF1vByxwFFmJyVP1zTmB4i7DonhEn
         f7fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH6xtKx1wal4UgWmEnPeqYBlubHUVzfctEyVxBNtRAJWlsIIe1h0s2eLxqr4cQ91IvuqV/jcuSwskwTyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2v4hQETwJ/3yvGLmUglFjgv7UnumrQn63z1cVbbPT25NuMGgs
	89FF4xvq+GNzZP3L+48ZiY1lGVK4Bc6ia+HkEuew5pZIt9XWWnF6MA1Ok1IjK17gGx576gIUigU
	m6g==
X-Google-Smtp-Source: AGHT+IEYQskIydQ17rOCvnDIIztIPwEtV42Xo/Yb7l4NrEHNVvMPUaIF0Ogt4/xaQ903hVU90IvPM22EQH4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a63:385c:0:b0:7ea:999a:7930 with SMTP id
 41be03b00d2f7-7edd7b6c7e8mr28419a12.1.1730404414918; Thu, 31 Oct 2024
 12:53:34 -0700 (PDT)
Date: Thu, 31 Oct 2024 12:51:29 -0700
In-Reply-To: <20240802200136.329973-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802200136.329973-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <173039527102.1510350.14562788857137656763.b4-ty@google.com>
Subject: Re: [PATCH 0/2] KVM: Protect vCPU's PID with a rwlock
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Steve Rutherford <srutherford@google.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 02 Aug 2024 13:01:34 -0700, Sean Christopherson wrote:
> Protect vcpu->pid with a rwlock instead of RCU, so that running a vCPU
> with a different task doesn't require a full RCU synchronization, which
> can introduce a non-trivial amount of jitter, especially on large systems.
> 
> I've had this mini-series sitting around for ~2 years, pretty much as-is.
> I could have sworn past me thought there was a flaw in using a rwlock, and
> so I never posted it, but for the life of me I can't think of any issues.
> 
> [...]

Applied to kvm-x86 generic, with a comment explaining the vcpu->mutex is the
true protector of vcpu->pid.

Oliver, I didn't add the requested lockdep notification, I really want to make
that a separate discussion:

https://lore.kernel.org/all/20241009150455.1057573-7-seanjc@google.com

[1/2] KVM: Return '0' directly when there's no task to yield to
      https://github.com/kvm-x86/linux/commit/6cf9ef23d942
[2/2] KVM: Protect vCPU's "last run PID" with rwlock, not RCU
      https://github.com/kvm-x86/linux/commit/3e7f43188ee2

--
https://github.com/kvm-x86/linux/tree/next

