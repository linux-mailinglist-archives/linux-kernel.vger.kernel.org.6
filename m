Return-Path: <linux-kernel+bounces-344388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC4898A8F3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09DD51C22F18
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB68192D78;
	Mon, 30 Sep 2024 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hIOuf6fh"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B58C192B61
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727711080; cv=none; b=TrXFVXprxqwsJtdROk2dE62tN3514+qRsZMLtG5oqRGODN1ExMNNRpQF3zm1HjVH6mo8mI/D+58mSh0xQwi/0iSFsiaTv6i34CLVf46In4751F0ldGlZnX6VE/uTxhzCKRt3MXHfjI5cn+wOnbE3D4g7ZPhg5trxYtQcVIChCz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727711080; c=relaxed/simple;
	bh=g7yH1N8qbD3KalRQbnNOzdFQJgQ9w431UHMEl6kjtdQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SDMDm9sdsMxb7rcDxtMPFv5MYWS/Uc20fYfkjlieghqVAWycsQig2WXtsIsY2tab2aRzTTZtpBA0nx2J9Ge6KGHbP/VD8w7W1p8iJ+A3WiluFPKjTSGIA9GCVBNSsJWVXH94RBLGWItjxtwYgK0BeFbMwV4ZvhUMR9kDFN5MLvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hIOuf6fh; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e25d62bfe12so6477246276.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 08:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727711077; x=1728315877; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=REdiOgzhoa31AsekrGqqdz4GlZ2Ybe9xNzEcAWoGwy4=;
        b=hIOuf6fhR/gVRijlOxteNdqDQeUV8oRtQk9gL7pcnYvSI6Lf1d6JSVKHojtTB8GJBq
         GJSe5GYpMCUXZTuX2wevrEd3rSZcjfSGVjb/BGmbDDe6BD+alVyX8OfhChkWO6/iob47
         FBGjR5IGfzgjA0vZMFGe9JIT+nkBTa/MGpJG1LgU86sGp/wP/VZpVlqjVYipsuyTObPm
         DMdPtPPygB6CMg2UJ0r0SFSWWaEQ2Wkm3eN2hwNL95NbrGt9hnNaVAdMCht9ncsbJyV8
         ZAoaS1MjJwDEC1LkWq1Hfbl3gvS9A2h/0EuZRdWDixUmPSv5ijBBUoBhfGk9wu3RNDWk
         jIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727711077; x=1728315877;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=REdiOgzhoa31AsekrGqqdz4GlZ2Ybe9xNzEcAWoGwy4=;
        b=vZiaGLwFZhUqx7wpc59mKZdFVW0s7AXZe+u3crE2064ye+hAPR+75ScMsaNIuyCcgE
         9TZqEiVx6wJWaFmzq6E8MIdKorjEHyBe5EQGNIyvXauTi/g3B5zO9/y7x4nem1/VNGiE
         1Mun2HKh9dJ3KGrHxri2CBNDdvqvtHNi6Eb+nEg2gJCAdGgu8sH3Rft53Bl9e8pXwj7K
         c3k8/yeEV4/OcXIFxrzWku07H64j7soHSperB4cX7yePQhkQjDbDoNAvjeKnPn6Wx5ey
         ftQ8xlk9Txpd/AqMiECO4nUZPDxam3FPmEJLsw7VJk13qk+f1S7Fny/cTIRMNVAUYltI
         qS1w==
X-Forwarded-Encrypted: i=1; AJvYcCXD5XUe17F9/4MFZLGWGpF60f32BuzR4zQYJs3LKkeaEq1+v+iG6+j4ufd3y41uq+1iQNBoDthwxFwFjZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEFomK+28Sf5mu6zaJQ9vAHzMnrRoEjRf74whNoZsCnJjZLNHk
	sG9D7Z8/gUO/e7kXpigGAFRjQckNCrfkcaLwtcpZY0SCRJ4Fj9knduiSahMN0YFm7Gy3OCmdGkw
	/Cw==
X-Google-Smtp-Source: AGHT+IGFPrNUrW8gEb8N/vRCKmA+Kcp0dg+Etw0Q19EAKUNDVTEIDJcfVqny8as85bq9oiVqRc8xz3iM7T8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:2e4d:0:b0:e16:4d66:982e with SMTP id
 3f1490d57ef6-e2604b436d5mr59334276.5.1727711076703; Mon, 30 Sep 2024 08:44:36
 -0700 (PDT)
Date: Mon, 30 Sep 2024 08:44:34 -0700
In-Reply-To: <942ec747-04f6-4fd6-abcd-eea60c3ba041@yandex-team.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240917112028.278005-1-den-plotnikov@yandex-team.ru>
 <Zu_Pl4QiBsA_yK1g@google.com> <0288f7f5-4ae8-4097-b00c-f1b747f80183@yandex-team.ru>
 <ZvFVFulBrzHqj2SE@google.com> <942ec747-04f6-4fd6-abcd-eea60c3ba041@yandex-team.ru>
Message-ID: <ZvrHYoAuu2AntQYb@google.com>
Subject: Re: [PATCH] kvm/debugfs: add file to get vcpu steal time statistics
From: Sean Christopherson <seanjc@google.com>
To: Denis Plotnikov <den-plotnikov@yandex-team.ru>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, yc-core@yandex-team.ru, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 30, 2024, Denis Plotnikov wrote:
> 
> 
> On 9/23/24 14:46, Sean Christopherson wrote:
> > On Mon, Sep 23, 2024, Denis Plotnikov wrote:
> > > On 9/22/24 11:04, Sean Christopherson wrote:
> > > > On Tue, Sep 17, 2024, Denis Plotnikov wrote:
> > > > > It's helpful to know whether some other host activity affects a virtual
> > > > > machine to estimate virtual machine quality of sevice.
> > > > > The fact of virtual machine affection from the host side can be obtained
> > > > > by reading "preemption_reported" counter via kvm entries of sysfs, but
> > > > > the exact vcpu waiting time isn't reported to the host.
> > > > > This patch adds this reporting.
> > > > > 
> > > > > Signed-off-by: Denis Plotnikov <den-plotnikov@yandex-team.ru>
> > > > > ---
> > > > >    arch/x86/include/asm/kvm_host.h |  1 +
> > > > >    arch/x86/kvm/debugfs.c          | 17 +++++++++++++++++
> > > > 
> > > > Using debugfs is undesirable, as it's (a) not ABI and (b) not guaranteed to be
> > > > present as KVM (correctly) ignores debugfs setup errors.
> > > > 
> > > > Using debugfs is also unnecessary.  The total steal time is available in guest
> > > > memory, and by definition that memory is shared with the host.  To query total
> > > > steal time from userspace, use MSR filtering to trap writes (and reflect writes
> > > > back into KVM) so that the GPA of the steal time structure is known, and then
> > > > simply read the actual steal time from guest memory as needed.
> > > Thanks for the reply!
> > > Just to clarify, by reading the actual steal time from guest memory do you
> > > mean by using some kind of new vcpu ioctl?
> > 
> > No, I mean by using the host userspace VMA to read the memory.
> 
> Oh, I think I got your idea. You mean
> using KVM_CAP_X86_MSR_FILTER which...
> 
> "In combination with KVM_CAP_X86_USER_SPACE_MSR, this allows user space to
> trap and emulate MSRs ..."
> 
> And then having guest's steal time struct valid address read the value from
> userspace VMM like qemu directly.

Yep, exactly!

