Return-Path: <linux-kernel+bounces-182204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5C48C880D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 16:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82445286D18
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 14:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340865F860;
	Fri, 17 May 2024 14:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q1pMpO4D"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA5B5820C
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715956014; cv=none; b=ckt0ssVyWJV5WZec8QO20auO7P1S7hbc+gd9cyzygHTaxrprfrURF/juJ0meZFJfugGddQE1hZa/HdCh0pZPZRxQtqJlykpaHRm77YknIrkEWxQynDQP7NIL9LaZGqH4p5pt0aLRLWvpz422HntkXc+SOlSeV/UEpP9rJcIeeo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715956014; c=relaxed/simple;
	bh=Dl1P6YnQp8wm8iRfIfHtmRjWQ9ByiknL44FRIVpTL+4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VuXq9TAWQgGcq7X3uPLfTEUcf3RoOfvxOlxqQl2oDbA1B8HciTGjgV7rNuKsPPYmYxDVU0L6XHhWPVCBKrKDpgM7K0eF06mU6CQycc5qn1AV+7+l0+WsezGthFMNd4SP2uVfBRvsoAtVoQ55I+gAtZfv/DORPoutLozVH2dQo5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q1pMpO4D; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be621bd84so147649257b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 07:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715956012; x=1716560812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jT4nqw0S4zpXFTc9WY81aiwMnvRN0tQtnQdC3noi5G0=;
        b=q1pMpO4DlHuDnjTQ+ojw3lK68JPCjnycduBv49WwYC76d/I/fZ0QozrVrqxacusE3O
         4zRsCc8d881N3EYp9kCvE5xARPXesFxPEV5aKTlcHfw3y85dsD0zpQhhgWdQLKFZqglX
         UvUTIyjsEpYF84gcFEDOHV6s98qadrfMJlm4uCF4Lz2HiO9tgb2rhnTTNrIWyX6cRdc0
         M+vAQEWFH3tixVh/o+8zDlAsLStIEE0+sZDNGjL1GAVvEsuFG865tenPFy8c4ahMTzuX
         SBa0azYwo9Xljj10TS08KHTEUDl++0vedR1yx3u6VjAt1gvHnMjK7/MC71llrvDokJQO
         3pAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715956012; x=1716560812;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jT4nqw0S4zpXFTc9WY81aiwMnvRN0tQtnQdC3noi5G0=;
        b=Ri87GdVvPPff11YY/owIEBM046900nqm5hCmVe8UJu0Qrkq9KCgdoNiEWp6kaEBsU1
         99TNMQ9Ont1+tM4eLouAIRh5bAZAucSysuzCHr+mm8tWN8TXOGLoCe1bUXK/yyq9xqjH
         E7hVqb8e+NWSUWFZXLma9AF88uFDzqOfdNHdj7FMlb5G2aYErTnU1/LbW8PvBGqwXGem
         6ZIoBqC3NODnXTyyhjAiGWJ7yphJWQwdaRReF4cH6hbB4aJEn2llFiifQU+Lc7nuC5n0
         9ecJ4xvgmutYg5r7TQX6watZ0di3Wnwz3uZnxvFmaQXUO9mi5zzlK+uxu1WKGM5ftMPF
         dmPA==
X-Forwarded-Encrypted: i=1; AJvYcCWFXKhVnKOZvIP5fkFd7wDQudxPLs/ZwZUu61LJ41pHZWORu+3Ukr2DlYm4N7MdmHGi3BtAWidDaax3S1iOhwT/lexMwKLUTwRduLCr
X-Gm-Message-State: AOJu0YyADOqReY8S0/O09wwK5MTWcuTXdVFk5onVK+3ahoxhNLNoyT7d
	2EJmXrIrp2dy4zHybk5adtIWRrXbse7MBxWc1BCCKhBCJiyA6IPjdKtko+OMCw0couqtIGYtZW/
	Nkw==
X-Google-Smtp-Source: AGHT+IEguYb768Ll9OxJG+xCvTeZMRyELAi07YJ2srYLgxpNkOH97TLsQqMexK5jbFU7Ajlqzvrc5B0cD3A=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:3804:b0:61b:1d66:61c4 with SMTP id
 00721157ae682-622b016d66cmr44336497b3.10.1715956012119; Fri, 17 May 2024
 07:26:52 -0700 (PDT)
Date: Fri, 17 May 2024 14:26:50 +0000
In-Reply-To: <87r0e0ke8w.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240219074733.122080-1-weijiang.yang@intel.com>
 <20240219074733.122080-25-weijiang.yang@intel.com> <ZjLNEPwXwPFJ5HJ3@google.com>
 <39b95ac6-f163-4461-93f3-eaa653ab1355@intel.com> <ZkYauRJBhaw9P1A_@google.com>
 <87r0e0ke8w.ffs@tglx>
Message-ID: <ZkdpKiSyOwB3NwRD@google.com>
Subject: Re: [PATCH v10 24/27] KVM: x86: Enable CET virtualization for VMX and
 advertise to userspace
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Weijiang Yang <weijiang.yang@intel.com>, rick.p.edgecombe@intel.com, 
	pbonzini@redhat.com, dave.hansen@intel.com, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org, 
	chao.gao@intel.com, mlevitsk@redhat.com, john.allen@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024, Thomas Gleixner wrote:
> On Thu, May 16 2024 at 07:39, Sean Christopherson wrote:
> > On Thu, May 16, 2024, Weijiang Yang wrote:
> >> We synced the issue internally, and got conclusion that KVM should hon=
or host
> >> IBT config.  In this case IBT bit in boot_cpu_data should be honored.=
=C2=A0 With
> >> this policy, it can avoid CPUID confusion to guest side due to host ib=
t=3Doff
> >> config.
> >
> > What was the reasoning?  CPUID confusion is a weak justification, e.g. =
it's not
> > like the guest has visibility into the host kernel, and raw CPUID will =
still show
> > IBT support in the host.
> >
> > On the other hand, I can definitely see folks wanting to expose IBT to =
guests
> > when running non-complaint host kernels, especially when live migration=
 is in
> > play, i.e. when hiding IBT from the guest will actively cause problems.
>=20
> I have to disagree here violently.
>=20
> If the exposure of a CPUID bit to a guest requires host side support,
> e.g. in xstate handling, then exposing it to a guest is simply not
> possible.

Ya, I don't disagree, I just didn't realize that CET_USER would be cleared =
in the
supported xfeatures mask.

