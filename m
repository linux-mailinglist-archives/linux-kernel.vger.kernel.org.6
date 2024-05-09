Return-Path: <linux-kernel+bounces-174614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCCA8C1196
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BCC31F21DD3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE42152783;
	Thu,  9 May 2024 14:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NDnw5hW4"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7772A1A2C3A
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 14:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715266769; cv=none; b=KaNqe6M0EreddKJvJi55LA5zjhu+iw3/h0AxDMYZsfeSEVzlg/4Mp/gLWMevS0F4c0zaOsTBw5DHkq8apG/J436p+vFFZow09KATXGhK5KYZQ1fK9hWLXsOSkYONH4UHQ8r/N1I48IgQWovIlB1H20GRSqi4Oju5ZLuD3eHEv30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715266769; c=relaxed/simple;
	bh=tCD+L+VvuerRjgMAiszpRPFFSvc4JDjxToq8q+1CXO0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WlKz6j/CjQzlmPzhU6Ree0katFU6AnPZMwk1J8wyExpyK4wbrTRck2jQVN5hDH1uvuHrS2x2tWG+Lv1kO6wRL6+BoHuTAWbie0w/RQhFHWhlE9svTisi5Ybf+0IP9iBvx8LGOayJwB3H3HaJf+Tp9ovUrbDpX9txJT2hA3I7hyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NDnw5hW4; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1ecb7e1e3fdso8022995ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 07:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715266768; x=1715871568; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SRILAk7h01/fT5BGJbVj7y6a6cEN0j9+rCMJHje+Tu8=;
        b=NDnw5hW4ZjeidZTMRcTQ4WP0RY4CDXHhREte/f104nTDyioOyiMRsKVJF8tGB5FvGZ
         ruDorRL/ARhp0NEAAxsRU2qYw9hY+amo3AK/z/XEfuh1MErFM2lcqaDa2JkXuh7j2/kh
         uxfUHdVw1uij3Ophz1l9g90qT+6WjF91KqoqIf3L9b6yQ2ODLg+FxFVaCR2nHaOZbQA0
         2VphIjf/65lrMCJrEjywirGeEycyi4MOFe0d7AhAF6pN5KQQQQ8xoGdJ4DbeKO86QPi4
         dFkNd3KwlJDjgcSBGTc2Qua7yNkNuHrFElhH1J1JNUxdeqy3IHukIr9Ja4V4PLdV6T6f
         b7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715266768; x=1715871568;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SRILAk7h01/fT5BGJbVj7y6a6cEN0j9+rCMJHje+Tu8=;
        b=vrMfwwB/E0MVnjECHEpjMZc8tjnoWZt97g34xO9jgnJkFYkBW//vZWZTvwOWAGfeOB
         86w6kBrkVrlikgfJVcEUX6fRgTuu+DLdl3y+TrfFTr2m/YGf9l+JZnwgKxN2/OVwlRwP
         DfvjkHHuARwC8FcfcTRPM1LFCzTPtYm8me7u+pfbFvASHsgncL4IAaJwvG9au+1ShOMi
         3tcJ1zXu2X26kvd7FdV4wWP78//QsfEPgZT/mq4z9DRZnwy6wsFLTfy3OUGHop6xi7wD
         0IHOCpSyQyu8WhizJpvV806WSIZ2yG0Rk3B8TorsGvUFkXTsb+3+dQkFwx4UQMSRVjYM
         emUg==
X-Forwarded-Encrypted: i=1; AJvYcCUKdaDrDcYweNSRsFmAsFwF8GSiDGzIpVnju+XnlVl9T4VvAR7dGzWvjP2QYUZjmPaIxPKk3twMMRc5iyXyjtiprREYNS15H10MZe70
X-Gm-Message-State: AOJu0YxtzyQKRPYHUAJ0aQDdEDkfhB0x38I/8qUj9QO8ravl5XfmbtT7
	WZvTdHKhCUZFAPceeWyt0p6bH+cRijRtSYIXuAGTC+5ppRaoQffspQFi4/sgQDyTMMeDYx7AHRl
	0Zg==
X-Google-Smtp-Source: AGHT+IHK988GVPbIdB5zCuGdw7y1k+VuVsH8cph3YTDGdrjAWgKSTPaD2BUAym95OZHpCCMbUFtpNFD6Nok=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2844:b0:1ec:e716:60d3 with SMTP id
 d9443c01a7336-1eefa239c99mr73705ad.2.1715266767690; Thu, 09 May 2024 07:59:27
 -0700 (PDT)
Date: Thu, 9 May 2024 07:59:26 -0700
In-Reply-To: <202405091030597804KUqLDPPj2FpTIBrZZ5Eo@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZjuhDH_i9QWL4vyz@google.com> <202405091030597804KUqLDPPj2FpTIBrZZ5Eo@zte.com.cn>
Message-ID: <Zjzkzu3gVUQt8gJG@google.com>
Subject: Re: [PATCH] KVM: introduce vm's max_halt_poll_ns to debugfs
From: Sean Christopherson <seanjc@google.com>
To: cheng.lin130@zte.com.cn
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jiang.yong5@zte.com.cn, wang.liang82@zte.com.cn, jiang.xuexin@zte.com.cn
Content-Type: text/plain; charset="us-ascii"

On Thu, May 09, 2024, cheng.lin130@zte.com.cn wrote:
> > From: seanjc <seanjc@google.com>
> > > From: Cheng Lin <cheng.lin130@zte.com.cn>
> > >
> > > Introduce vm's max_halt_poll_ns and override_halt_poll_ns to
> > > debugfs. Provide a way to check and modify them.
> > Why?
> If a vm's max_halt_poll_ns has been set using KVM_CAP_HALT_POLL,
> the module parameter kvm.halt_poll.ns will no longer indicate the maximum
> halt pooling interval for that vm. After introducing these two attributes into
> debugfs, it can be used to check whether the individual configuration of the
> vm is enabled and the working value.

But why is max_halt_poll_ns special enough to warrant debugfs entries?  There is
a _lot_ of state in KVM that is configurable per-VM, it simply isn't feasible to
dump everything into debugfs.

I do think it would be reasonable to capture the max allowed polling time in
the existing tracepoint though, e.g.

diff --git a/include/trace/events/kvm.h b/include/trace/events/kvm.h
index 74e40d5d4af4..7e66e9b2e497 100644
--- a/include/trace/events/kvm.h
+++ b/include/trace/events/kvm.h
@@ -41,24 +41,26 @@ TRACE_EVENT(kvm_userspace_exit,
 );
 
 TRACE_EVENT(kvm_vcpu_wakeup,
-           TP_PROTO(__u64 ns, bool waited, bool valid),
-           TP_ARGS(ns, waited, valid),
+           TP_PROTO(__u64 ns, __u32 max_ns, bool waited, bool valid),
+           TP_ARGS(ns, max_ns, waited, valid),
 
        TP_STRUCT__entry(
                __field(        __u64,          ns              )
+               __field(        __u32,          max_ns          )
                __field(        bool,           waited          )
                __field(        bool,           valid           )
        ),
 
        TP_fast_assign(
                __entry->ns             = ns;
+               __entry->max_ns         = max_ns;
                __entry->waited         = waited;
                __entry->valid          = valid;
        ),
 
-       TP_printk("%s time %lld ns, polling %s",
+       TP_printk("%s time %llu ns (max poll %u ns), polling %s",
                  __entry->waited ? "wait" : "poll",
-                 __entry->ns,
+                 __entry->ns, __entry->max_ns,
                  __entry->valid ? "valid" : "invalid")
 );
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2e388972d856..f093138f3cd7 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3846,7 +3846,8 @@ void kvm_vcpu_halt(struct kvm_vcpu *vcpu)
                }
        }
 
-       trace_kvm_vcpu_wakeup(halt_ns, waited, vcpu_valid_wakeup(vcpu));
+       trace_kvm_vcpu_wakeup(halt_ns, max_halt_poll_ns, waited,
+                             vcpu_valid_wakeup(vcpu));
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_halt);

