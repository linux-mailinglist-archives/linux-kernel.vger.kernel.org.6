Return-Path: <linux-kernel+bounces-512180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7855A3352E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 03:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 429737A3191
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8DB14A0B5;
	Thu, 13 Feb 2025 02:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U1xCtbhy"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76BC145348
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 02:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739412600; cv=none; b=BgynFArFYikNKcXFk0O+RvWI758KSa3SYdQ8rtKMi5rHN3BUGeaPrlSqD4cQSBBfKCz1tij2y5NDL1WFFArsGkOYEzYwrpk4dfnLZiSvsqgYhn78fAUvN71Anp6GQ0bVXsjSidIEzeSfkxRg18etksKAdjhiggerwsk63cequ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739412600; c=relaxed/simple;
	bh=D/w0ZwtRtYcmWs37X8IYT8H9Nl48IrgHcsGVG2ENYnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6xgcZYh9qaIlJW+ElBf/iS8YdMFkroB37b+UlBUlmn5uI3Fkel5k6ylXM7asDQbuJbt1jRbFUTLLuKf4yW6g1OtOb9wwznT/Gi1nTcOKwuWUr7WdVSsPTfw7GIAwzyquhfeXZbUUqvcsCB/os3kzYofI+aq6qiOnQ92BXChJ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U1xCtbhy; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so1999a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 18:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739412597; x=1740017397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2a2v0j0te6NIFTJGusW3Izof1NhUdtIxSDnUtBZIkAI=;
        b=U1xCtbhyaRT6u77bt9bia7yuJCMWYWE9sCWFvPiN4y76loaDY2x5GPMConBeSGQb9x
         SMZl79mhmg33BMmXbwkHKhoVxDqoT69KpHplc78iMRjPk+C+YG22qqEUCNT2BzR72RNA
         1YmH+RpOWl2IwAJ/YHAH/rlGlDjWPqFAXeykEdewbzrdgisBos6wSSnnY9RJqlMyxDw8
         AEkg83LTdfuJ1ruDzVvf7ICRZ0/Z2BqMqU6wvKKR++k7L06eF8Z/PRebhGHi94IwMhPf
         AiSQQIxOy1iMbbqzrO29a4gcXdA8GX1AxEDxG8CTDm3FAyMwLmJn9oqu5/MuYSIl7CGZ
         jvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739412597; x=1740017397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2a2v0j0te6NIFTJGusW3Izof1NhUdtIxSDnUtBZIkAI=;
        b=Kh+ypGPoHxKI91Ipoq28FR/UJ8FOQj1C5dY3KzJh/QGWp8SPHGXi2DJTAUWxHHuTBz
         IFP8MXjJWZS8Osxk4ZAEPlatY5ScXJnXUEpFfrx870+YZdUeOVu5fXg9L0R5CgeD7Lk0
         R/BiROI3/cv0lYZP1yiIz99hKoAS+MVX4XYkCh2S8xuqbX3LWb+WRa//o46qDLmTyqZU
         oS1g60EuhBm4dS8gG8L91GGfDmYxtKa8axRgLKYQWVgPMU96lpsRBAy60NXlEdzMaqM3
         fl+awN3Nh5g4uUqAouaO9FpCgQ60cwu0FaATQqWQNdHjs4jUpCBXL47Vvp2nqqU9GI4m
         OzQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8i3JXok9mPgJN/DLsqQ6SFyxzDAtYxyPBotzeVQ/AZa3mePPKIrwGjE2golxaq1BQhu/TUVT2xh/FcMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwotBTjJB47UFSI5tRcZqbaVRsl6ks4Q7Aoq8BqZo0pFXUS3rGf
	ryR4O4Wp9HxyBDNXIvaa4NcPZELPcRVB3+FGmKH011iDrGIDSOVv4zC5MaR5PWdu1ZxH8dtQIa8
	UtOKvCF5PkoiPK/6fTRRlCMkHxCHnZ9lgYEaR
X-Gm-Gg: ASbGncs/R0upAY6FKqfRW2iZmmcWGvD8puphFd53/3Fy/4IwX74UsOQOHuRUItgyvIi
	+11MWile9ZU+CZe3MGQj6f/t/syrEVshBtFl8mjg359QyIofUjO5WsOojJqVxHRFPkZmrW928//
	fLlg+efAD46roDDC2v6WWsyQQN
X-Google-Smtp-Source: AGHT+IEGXYza8jPG+mtHgFh7992UjGTwtZVd3O5N+Wv7U028jj6PHsIgLk+pz8qLqg5Kbmp2XIFM5RlBBip4q7wXA0o=
X-Received: by 2002:aa7:c70f:0:b0:5dc:e07d:515b with SMTP id
 4fb4d7f45d1cf-5decb4962damr50168a12.2.1739412596550; Wed, 12 Feb 2025
 18:09:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
 <c46f5614-a82e-42fc-91eb-05e483a7df9c@citrix.com>
In-Reply-To: <c46f5614-a82e-42fc-91eb-05e483a7df9c@citrix.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 13 Feb 2025 03:09:20 +0100
X-Gm-Features: AWEUYZnvdHs8yyFW6XYSqu5PjiO1JQQc7EpzD0iG3tCB0flG_c2hqhEyvARDM2c
Message-ID: <CAG48ez0h0wUS6y+W1HTOwN14V95gKmmFZ_2TamAX+JKTmXT=DA@mail.gmail.com>
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: jmill@asu.edu, joao@overdrivepizza.com, kees@kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luto@kernel.org, samitolvanen@google.com, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 2:31=E2=80=AFAM Andrew Cooper <andrew.cooper3@citri=
x.com> wrote:
> >> Assuming this is an issue you all feel is worth addressing, I will
> >> continue working on providing a patch. I'm concerned though that the
> >> overhead from adding a wrmsr on both syscall entry and exit to
> >> overwrite and restore the KERNEL_GS_BASE MSR may be quite high, so
> >> any feedback in regards to the approach or suggestions of alternate
> >> approaches to patching are welcome :)
> >
> > Since the kernel, as far as I understand, uses FineIBT without
> > backwards control flow protection (in other words, I think we assume
> > that the kernel stack is trusted?),
>
> This is fun indeed.  Linux cannot use supervisor shadow stacks because
> the mess around NMI re-entrancy (and IST more generally) requires ROP
> gadgets in order to function safely.  Implementing this with shadow
> stacks active, while not impossible, is deemed to be prohibitively
> complicated.
>
> Linux's supervisor shadow stack support is waiting for FRED support,
> which fixes both the NMI re-entrancy problem, and other exceptions
> nesting within NMIs, as well as prohibiting the use of the SWAPGS
> instruction as FRED tries to make sure that the correct GS is always in
> context.
>
> But, FRED support is slated for PantherLake/DiamondRapids which haven't
> shipped yet, so are no use to the problem right now.
>
> > could we build a cheaper
> > check on that basis somehow? For example, maybe we could do something l=
ike:
> >
> > ```
> > endbr64
> > test rsp, rsp
> > js slowpath
> > swapgs
> > ```
>
> I presume it's been pointed out already, but there are 3 related
> entrypoints here.  SYSCALL64 which is discussed, SYSCALL32 and SYSENTER
> which are related.
>
> But, any other IDT entry is in a similar bucket.  If we're corrupting a
> function pointer or return address to redirect here, then the check of
> CS(%rsp) to control the conditional SWAPGS is an OoB read in the callers
> stack frame.
>
> For IDT entries, checking %rsp is reasonable, because userspace can't
> forge a kernel-like %rsp.  However, SYSCALL64 specifically leaves %rsp
> entirely attacker controlled (and even potentially non-canonical), so
> I'm wondering what you hand in mind for the slowpath to truly
> distinguish kernel context from user context?

Hm, yeah, that seems hard - maybe the best we could do is to make sure
that the inactive gsbase has the correct value for our CPU's kernel
gsbase? Kinda like a paranoid_entry, except more painful because we'd
first have to figure out a place to spill registers to before we can
start using stuff like rdmsr... Then a function pointer overwrite
might still turn into returning to userspace with a sysret with GPRs
full of kernel pointers, but at least we wouldn't run off of a bogus
gsbase anymore?

