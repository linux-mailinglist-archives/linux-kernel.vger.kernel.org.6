Return-Path: <linux-kernel+bounces-409523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 495A19C8DF5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06CB0286E0A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A2114E2D6;
	Thu, 14 Nov 2024 15:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xmxKhmBg"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB393B784
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598067; cv=none; b=G1QK7pxczAqpZBkcvfd4BB5YCGEnFHfNCX7ofSpghtljRUOC419+2jQHP/7evVmy2OVes6FsPDI1qQj9tyluVcAW8FjGpoBqfV+13wNY1T/k6MvaZlN5UbMR+7Snx+F0tjse75QoWkKcQQ5Vi9qAx06dgaajopjNj6xYn8IE/h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598067; c=relaxed/simple;
	bh=+sEmkHc/gqLQvISFoccR4dMFAmG47Net4ZXwSAJbm4Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p+IuVdBWr87vmNx2uhlQFpENG66WFpIfNbD1C6X7rWKAlYqa7ix0FsOn7o9FqVCqeqEs8ugo+wMrw9fh7Lgx5bq0Njt4nWPJ1kszDul1qgfF2DNFIPlqeytgRgt1RlMuOfwvY20YnKJS1VTTF2wuhANXKglNoVBdy3XZn7jA4k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xmxKhmBg; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e30cf121024so1024220276.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731598065; x=1732202865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r9Xf/8xQttXv6s1otjnUDSrcU0au/N/ujN3TYRfLjxk=;
        b=xmxKhmBgJ2W2AlqyLUPMOLWjJOH50GSs0N6RUjG/liOgs7dhmcY42OgZJuI/4F2lRL
         oOlVdZZ0uYvnDjuDyjNd+tUcxzjYhxauLsDOW5otbdaqBnRHA7T/1n44Un/htj3jpi7E
         eyeFEGzZL9dl0itAqFWYGjCz/hXN2jOpFZd5cD858CD3UfQtm4FlkqAnHC0KP+DBYp1q
         IRlT/kGGbKA3XBDeyTdStmtCjqzACtkVrG0fnIDOY9Ndj1TRb0GaPiR/7MMKxBhS4D2v
         GUOIe8XNzz/SWDlBOpZypP2qqtua8KsvTZEG42j1Xs1zxn0s5CJtf2r3ms8bKdQ7gHQL
         T0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598065; x=1732202865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r9Xf/8xQttXv6s1otjnUDSrcU0au/N/ujN3TYRfLjxk=;
        b=uc57QppVo4JGk6ilpcAFgUE8anOKfjMuSFz7/sUvQxHU6/XYCGZRTkyQaTeVOI6VKF
         zSaeAN8pyK5gCHcj5QcXo3ROu4H2/RHQLEpVvWXXtA2cQUxmQkW51I+gTnr/lZWQh4xl
         XW69kllqT6isLqOUXUfTJKBpQni/716cDbXU4//rQiPy1QALoIufnfbzJIhX71GbGwBf
         6zImV7YRX9zJAAinlts78Qek/CcSmiSe/iGBfSpH7RSCZFrq4VKAbzijNGHNwfZFeyVS
         TamGLfV+1rJnKtMTytYeedDJeSUM3y/cyQnfA7dlR4KQyevhuiMtC0xJGdCLb7xrdcqS
         PH/g==
X-Forwarded-Encrypted: i=1; AJvYcCXKpJnVbO1lXDk27C66CZRb5k4LQuLrLlge9cEto43p2+5jgi8CqPcPAFo1utXd5HwV/tWRhmMNEsJz42A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRtq2PdZPssBhBmktxsKoDoXqTQOEu2WLTdN5/NizYWsxYPhdg
	5ibIiIsRnoWAEg5dsi8dKrV9mKWMf0aCrTRrJqfwtiKFdzS2JawGXvEaGk5vi0BA7vNtMXIeGaL
	/+g==
X-Google-Smtp-Source: AGHT+IEJo8nhGMfASjDL+OnfXK4TsEyvl3lVzMG2j+jkJrNX/kWWBy5xmaToI/BTiIj+gtovk3WW0O25DXA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:c4c3:0:b0:e38:c43:3002 with SMTP id
 3f1490d57ef6-e380c4331a5mr80697276.10.1731598064751; Thu, 14 Nov 2024
 07:27:44 -0800 (PST)
Date: Thu, 14 Nov 2024 07:27:43 -0800
In-Reply-To: <ZzMaCzDNJAOCMFl6@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241101191447.1807602-1-seanjc@google.com> <20241101191447.1807602-6-seanjc@google.com>
 <ZzMaCzDNJAOCMFl6@intel.com>
Message-ID: <ZzYW7zVd47ctDfM8@google.com>
Subject: Re: [PATCH 5/5] KVM: nVMX: Honor event priority when emulating PI
 delivery during VM-Enter
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Nov 12, 2024, Chao Gao wrote:
> On Fri, Nov 01, 2024 at 12:14:47PM -0700, Sean Christopherson wrote:
> >Move the handling of a nested posted interrupt notification that is
> >unblocked by nested VM-Enter (unblocks L1 IRQs when ack-on-exit is enabled
> >by L1) from VM-Enter emulation to vmx_check_nested_events().  To avoid a
> >pointless forced immediate exit, i.e. to not regress IRQ delivery latency
> >when a nested posted interrupt is pending at VM-Enter, block processing of
> >the notification IRQ if and only if KVM must block _all_ events.  Unlike
> >injected events, KVM doesn't need to actually enter L2 before updating the
> >vIRR and vmcs02.GUEST_INTR_STATUS, as the resulting L2 IRQ will be blocked
> >by hardware itself, until VM-Enter to L2 completes.
> >
> >Note, very strictly speaking, moving the IRQ from L2's PIR to IRR before
> >entering L2 is still technically wrong.  But, practically speaking, only a
> >userspace that is deliberately checking KVM_STATE_NESTED_RUN_PENDING
> >against PIR and IRR can even notice; L2 will see architecturally correct
> >behavior, as KVM ensure the VM-Enter is finished before doing anything
> >that would effectively preempt the PIR=>IRR movement.
> 
> In my understanding, L1 can notice some priority issue in some cases. e.g.,
> L1 enables NMI window VM-exit and enters L2 with a nested posted interrupt
> notification. Assuming L2 doesn't block NMIs, then NMI window VM-exit should
> happen immediately after nested VM-enter even before the nested posted
> interrupt processing.
>
> Another case is the nested VM-enter may inject some events (i.e.,
> vmcs12->vm_entry_intr_info_field has a valid event). Event injection has
> higher priority over external interrupt VM-exit. The event injection may
> encounter EPT_VIOLATION which needs to be reflected to L1. In this case,
> L1 is supposed to observe the EPT VIOLATION before the nested posted interrupt
> processing.

Hmm, right, L1 could also observe the PIR=>IRR movement.  How about this?

  Note, very strictly speaking, moving the IRQ from L2's PIR to IRR before
  entering L2 is still technically wrong.  But, practically speaking, only
  an L1 hypervisor or an L0 userspace that is deliberately checking event
  priority against PIR=>IRR processing can even notice; L2 will see
  architecturally correct behavior, as KVM ensures the VM-Enter is finished
  before doing anything that would effectively preempt the PIR=>IRR movement.

