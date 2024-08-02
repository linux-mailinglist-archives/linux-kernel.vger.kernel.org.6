Return-Path: <linux-kernel+bounces-273114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6284E9464AB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 22:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21DC3281609
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814B77173C;
	Fri,  2 Aug 2024 20:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dG87xNtM"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF3A1ABEA7
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 20:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722631893; cv=none; b=WYQFYyXSvSqcHMemhGgHzcrti+cYm+jm+xIWcmmnfX/55jTkW+EuMreD8gkSPKdKRUnsMkrmb1eiy5ggvgZYtiaIRlm9gA8uFSGjFi91I8AHF8/ewaWOcSuhy7MvFOnLTUlgijO0PGDmVIjLOYwuKO/Uh2MP5CTxV2oWmKTpPnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722631893; c=relaxed/simple;
	bh=FueBNgDDCfYI2k+0y4y+ZR1Vsa5mvu9gB1exHHHan94=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m5ZBIVpKmaTP3MKE3BfXi2ULkJl3xRVjMyGg9nZGSwzrzhxtxRGMphkOUa/kjF/v8i4WVqIZsz0e35c4BoNwCLySLBNo+h07V1NMsR+NQFdi09GbAoG0IqBluXt0GcyVJGrzFv7fa9I2PKONxZtUs3jvKZw6AMES93jyI4wcgHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dG87xNtM; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-70e9ea89b42so7816550b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 13:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722631892; x=1723236692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tXkYm8GWgU7Uugm4gxQOf+EOoFr0lG6UD/VJhjiOPnM=;
        b=dG87xNtM3VLx+c+QMuryFY30aJ15tBOPtpwpo4+bhEVpRyCtFI1Jv1f0bzykPJgg/I
         NIPJN320Ukuzi9yfoo9cihjcJRcQmFRax0ffjpd0PTfRmz08j0xo1l7F3bWExgqL6NrI
         l28oPFyBQKv8CeYtx1yyJn1wxwc8ow8LwVmmRiDGT/lL7iY4VwuhwOpY2HRSsLIIpJrY
         OkrMb6rKV7xqVed8I9BzWwzsELuG/R0Yxk8fAzdRLrwRzjFzqAZJ9FBCj0D6EtrqX98E
         bn82vqF9DFHewXlIWHPceyCzIUu1r0/Pzyo+qcmlsUuT8aII1R/nHX3kmVTWXT7q2R21
         H9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722631892; x=1723236692;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tXkYm8GWgU7Uugm4gxQOf+EOoFr0lG6UD/VJhjiOPnM=;
        b=WZKEE/K2/B2a8tf5r2P8C26exCy+6sGdZu+b2BSuhiskvWUegPEkIgqrFLsesfqked
         DFRlF0+VeT4j8+V1jSIJzpqLZ3wr7tyhBkLxu9mr0EKEZOAqfWOUnrlOuG2LVldfUItI
         GeJ+vfIy4FiKNRjz4QINdflLUqYTv0xlXGnEZSSs//vvjbUWTrKh1egzijfQPTd1w7pr
         H0DwuJjh0XRhJic4Oerj7FwhN2bDuFxh0T+qZ2Aw44/U4DX7sAJx2AkjlN0BhqIF1rAK
         Rmf+dJ28G61RcIBgl1kSdhdb4e/aBIrKTAhahMRcQ/LJYK4jE5ZBCD8YPoufwENlBfXp
         v9bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrK2vyvex2ipRxBzzFrbHDRRr5JNrnbojpQs9sMJPBxv/VtxvWTEoG06idT7cobJFy1UXTCq+wX+xT5NVIDYELDCzBOXsnIRzrkXkq
X-Gm-Message-State: AOJu0YwVo5x1HmuAJvel0DlekONYM7qvSMOS+sA52tt2Cy0kru+ZKhsi
	COdWE9P20D9OFvEpbRA33p+t0V7xTlauBP5At1bpwjA/vL69J0cxV0ZXRR9Gtg4kiYozFECmnVq
	NWA==
X-Google-Smtp-Source: AGHT+IE1tZi1nsiH0SIgqwEaG7Vb1R0ZlJXHcVhuB6HgEl7rj1NR5a6/czPeOlKS3H+iSO3nwk8SFUENvrM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:6f01:b0:70d:fba:c51c with SMTP id
 d2e1a72fcca58-7106d071bd2mr16631b3a.3.1722631891698; Fri, 02 Aug 2024
 13:51:31 -0700 (PDT)
Date: Fri, 2 Aug 2024 13:51:30 -0700
In-Reply-To: <CABayD+dHLXwQK3YdwVi6raf+CF3XOaAiAG+tfDYPiZFzqeVXpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802200136.329973-1-seanjc@google.com> <20240802200136.329973-3-seanjc@google.com>
 <CABayD+dHLXwQK3YdwVi6raf+CF3XOaAiAG+tfDYPiZFzqeVXpQ@mail.gmail.com>
Message-ID: <Zq1G0n-b8_C6DFp7@google.com>
Subject: Re: [PATCH 2/2] KVM: Protect vCPU's "last run PID" with rwlock, not RCU
From: Sean Christopherson <seanjc@google.com>
To: Steve Rutherford <srutherford@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 02, 2024, Steve Rutherford wrote:
> On Fri, Aug 2, 2024 at 1:01=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> > @@ -4178,9 +4181,9 @@ static int vcpu_get_pid(void *data, u64 *val)
> >  {
> >         struct kvm_vcpu *vcpu =3D data;
> >
> > -       rcu_read_lock();
> > -       *val =3D pid_nr(rcu_dereference(vcpu->pid));
> > -       rcu_read_unlock();
> > +       read_lock(&vcpu->pid_lock);
> > +       *val =3D pid_nr(vcpu->pid);
> > +       read_unlock(&vcpu->pid_lock);
> >         return 0;
> >  }
> >
> > @@ -4466,7 +4469,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
> >                 r =3D -EINVAL;
> >                 if (arg)
> >                         goto out;
> > -               oldpid =3D rcu_access_pointer(vcpu->pid);
> > +               oldpid =3D vcpu->pid;
>=20
> Overall this patch looks correct, but this spot took me a moment, and
> I want to confirm. This skips the reader lock since writing only
> happens just below, under the vcpu lock, and we've already taken that
> lock?

Yep, exactly.

