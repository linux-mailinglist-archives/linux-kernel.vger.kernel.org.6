Return-Path: <linux-kernel+bounces-512081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E0CA333D2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1CB0166FC9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94374A08;
	Thu, 13 Feb 2025 00:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AEItY9ox"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B570EC4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 00:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739405334; cv=none; b=HBCvi0TCXXn0qkIIc8ABjIStHt9NO2k/vTrXo5SMrmN+2qWFgjugodrGf3QQP9ypAWmOf0jCXbTllyMlp9Gm2k9VsETKHECaQcQwP8wZ9FMNqhUbKHAX5y7O5V6hRTvEsggESmHr8xR5bmrTiZjeNDmG6ZZ4XzlPebfewo2hpIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739405334; c=relaxed/simple;
	bh=AqW9HL556ZI4lEeWCrLkz/cIG/PgLNaIjzYEZQLp6FY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ezMxK0bv9Xe1GZqaA5SNpqswDJGG/6WM+iezBwVuRSEXz1X0vq0UqnURxYuueM2UfRcuezJ3FK58FXJeI8QzblvJy15wdD1xALwmx6nj41/k5p4A/XMbOZ6T5uGjPH9JhMAGQxWImLDLoLXzrI8Z5gmrXH/iNN5RsL9P4S8FLXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AEItY9ox; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6efe4e3d698so3105327b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739405331; x=1740010131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ckylkc1mRMPJAxaTTlddOkQMiHbF9c9F2xl9Y8jmnfA=;
        b=AEItY9oxqM3Rj7/h5yARi+yFe/DW/xjwm4BmjfcXy9+zPbL/lj2Yrqpiz8zSuHlrre
         5mt9FSBwsI46P/VCEkBONtXgzHqb95kyLafNYggCUZMnbgA8tM5c/Qzu6mx4Y/vrI8JK
         RtYb13PKplhTMwMhnOjcBvDPWUgGatXBXOAqrqpBoISeCJTKv+B7KiqDy+VigysD0txS
         wF8vzZHQinfRN0kme7xE+Utf7FMREsIAmWctZ17WDeyR1BeXi9an/vdM1T29IW5BV1uF
         MSKjwpCQzD3fm/0SuTCXJiZJlBNc74M4tJZxpe8NzYONjwlp53csCfIM6cQ0Hys6yly4
         Vd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739405331; x=1740010131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ckylkc1mRMPJAxaTTlddOkQMiHbF9c9F2xl9Y8jmnfA=;
        b=YtmwT/AMAhF904Qrqa2OqQ/1k5MwWCEVsagIrzYmj6uJztJLuwhmbJXSMtwwzrlo0w
         feSlYpKG/K8oAN1QODIKXKz3Fu0ZXIF/zMbTRxUZi7chWr97jINHfDYAl1HregEcGJUn
         OO6TUnQBVtenQhMjlr45lf2RwOAgyT6GpQFWbEpAiu+AjyyO/PI5O0/NQ2p+hnYB/lPj
         r5FpWQKufQTXE6r8bGAqaU7aHeFp1QHAhWvF+2RaW/tuhD4Si7VouKzy5QvmtKlPRr6j
         HGtJh0g77jgDpiMvEGGmVhH/UyouNaNaUFdYD0+qcz0WijJ+caPpnsrC6pkMh4UkR47K
         UGmw==
X-Forwarded-Encrypted: i=1; AJvYcCXPdhY6a20O0jIvL+MF+YKA5KMpU6utMx7lXKZmaf1d6oo280/YRcVQWYHnEX1Zj2giMs3E7pgmmFK2xFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YymB9eknlhrbp5YFWlHbCkOH9OGsZva5I1xbmL2PmMFLTt4UUjS
	pL2uUB3egX+PaSD3WVr0oMDhspnNTCjDrYXwEa5JOJKmxjieRwj+F8ouUL/N8puOK5yFmqTzMzw
	XZ/ylb5DAYHGY6QlbbTYaC+by7oFgB4CeChF7
X-Gm-Gg: ASbGncuM6974Zx794J1r0NuIPfP42bHagnsg5UA9D9z6u3wQb3F5MX3r24+t1epN2eN
	iZEG8B26MxxozzJIMdA28+SaEPDhmD+qONABNDA/0TNnD8FJRs87ISDj8BnmLVA1EDmTXyLfKm9
	QaTX4+2pHhf4uVscA2uLyF3w5x7Q==
X-Google-Smtp-Source: AGHT+IESrPreFpgp6e19fu3YrWUdZmPloykIK3Btk02O6+02tP8XN3roPsVyPNUUmsn2kvRJNtuJ9JsHcnUTNqnGwEo=
X-Received: by 2002:a05:690c:3687:b0:6f9:aecf:ab34 with SMTP id
 00721157ae682-6fb1f2d5ad0mr57353587b3.38.1739405331362; Wed, 12 Feb 2025
 16:08:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67689c62.050a0220.2f3838.000d.GAE@google.com> <20250212221217.161222-1-jthoughton@google.com>
 <Z60lxSqV1r257yW8@google.com>
In-Reply-To: <Z60lxSqV1r257yW8@google.com>
From: James Houghton <jthoughton@google.com>
Date: Wed, 12 Feb 2025 16:08:15 -0800
X-Gm-Features: AWEUYZlI2bRB94Zjwo44LypQugi03x5L8sjFcH2ILC3VhqEUbvLU2tkjbi5Gl-I
Message-ID: <CADrL8HXZed987KOehV7-OroPqm8tQZ0WH0MCpfDzaSs-g_2-ag@mail.gmail.com>
Subject: Re: [syzbot] [kvm?] WARNING in vmx_handle_exit (2)
To: Sean Christopherson <seanjc@google.com>
Cc: syzbot+ac0bc3a70282b4d586cc@syzkaller.appspotmail.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, pbonzini@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 2:50=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, Feb 12, 2025, James Houghton wrote:
> > Here's what I think is going on (with the C repro anyway):
> >
> > 1. KVM_RUN a nested VM, and eventually we end up with
> >    nested_run_pending=3D1.
> > 2. Exit KVM_RUN with EINTR (or any reason really, but I see EINTR in
> >    repro attempts).
> > 3. KVM_SET_REGS to set rflags to 0x1ac585, which has X86_EFLAGS_VM,
> >    flipping it and setting vmx->emulation_required =3D true.
> > 3. KVM_RUN again. vmx->emulation_required will stop KVM from clearing
> >    nested_run_pending, and then we hit the
> >    KVM_BUG_ON(nested_run_pending) in __vmx_handle_exit().
> >
> > So I guess the KVM_BUG_ON() is a little bit too conservative, but this
> > is nonsensical VMM behavior. So I'm not really sure what the best
> > solution is. Sean, any thoughts?
>
> Heh, deja vu.  This is essentially the same thing that was fixed by commi=
t
> fc4fad79fc3d ("KVM: VMX: Reject KVM_RUN if emulation is required with pen=
ding
> exception"), just with a different WARN.
>
> This should fix it.  Checking nested_run_pending in handle_invalid_guest_=
state()
> is overkill, but it can't possibly do any harm, and the weirdness can be =
addressed
> with a comment.

Thanks Sean! This works, feel free to add:

Tested-by: James Houghton <jthoughton@google.com>

I understand this fix as "KVM cannot emulate a nested vm-enter, so if
emulation is required and we have a pending vm-enter, exit to
userspace." (This doesn't seem overkill to me... perhaps this
explanation is wrong.)

