Return-Path: <linux-kernel+bounces-377950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E66AB9AC8F7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1357E1C2100C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C1B1AAE18;
	Wed, 23 Oct 2024 11:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DxTgvMPk"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406A41AA797
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 11:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729683121; cv=none; b=dOnqRfqy3WyzIx1A/531SARHO9/fBDWKepzGzTeNatWFR7GfY4eoOUfcDkzPOmtSCpzFBLyXzWn/7GKyehf/VDRm3fS5e7vrGG/zv4LSZwt/f7bYCRkKS7j1wZxRskjUf5IcGUzfABPV9huEqh/srBbsaW/IBBLN+q8UF0URnk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729683121; c=relaxed/simple;
	bh=PifyftziAf8djQkPyvbqMUdH0ri6kdYCgtQLuMyRp+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lR4cqk6Stt4GlY7xOSuXcq8MeVEI8ngmpDlCX9xMTlcI2k2gAwd0K6p390VkouxlJYgIdmpjFaxQRkZytx+RWg7Gz9WtSHUVqXRYJosavFf+j5QRzLEkGOrFKikZE5berwyl8YXxQDYTxf8gF1wJzUS8zWg6TVa7Ck523YVcxyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DxTgvMPk; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20bb39d97d1so62297225ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 04:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729683119; x=1730287919; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PifyftziAf8djQkPyvbqMUdH0ri6kdYCgtQLuMyRp+U=;
        b=DxTgvMPkO2le6L21EZNRPJy4zKw4yfQiAtO8liPOzI3nvVEQVUsDfB6Jgju6fkZCzs
         jnEZDJ5//Kc3L5KPBqjXGlFSOKxIOdUtwSYxVrpLsh8uacEwORdP8MsxWUdkiBlMBjVd
         RKFyWcE7teRV2sAUqw0IJbXYJCNZ6E7zYcbDu5qCKCxctyPPbSS7GaEVqJ+1GjF4Sty5
         KUxV2O8z9fGxSyPmdZdLgAAOc1KRk9MLFvPKCZzVF1wlmARCmG8S42RjwYOkPQx+QkoC
         dui8VI3ucXwYplb3D5kqNsZppmn64RaheukurK58GcLID4DW0cTCjpG+Z3smd6qtw18m
         K9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729683119; x=1730287919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PifyftziAf8djQkPyvbqMUdH0ri6kdYCgtQLuMyRp+U=;
        b=pd5egMix8cylEPgKuk7/x1e9SczH3xV/XgMVUxfejKJVhPgDH6an485CCHydqEFFR2
         /AFhjitUUHwxOVQAJX+PNaLWmhHGbMrhuIA9iacDZ+taX91r0NsJ0mOmc22wB1QF4Q9P
         CrAnl0dM8jBrXF0Ur5W1LF1FxY5f1sJPP1LZduZ2/Xbf75f6WwNDPo3edSmTWA5pNYAW
         91ivlpcSqT+yFeMVCgTVijfZcZMionastndGYkcg8hOsvoX2d+G3MownrwJ/2dNQCW6C
         YQzCKsurq2d7y1eI0QqBoG7P3mz+c90oRSu/j23P8DoV3AtDmi/dTfLtwgJRPUulNitA
         9JMw==
X-Forwarded-Encrypted: i=1; AJvYcCVDrBaSJl0TnoCnbRIqzdwVMyUl7Q98c40B8+UtK999hx/jrhQPZnn28Mx3qQNJYSpfXaICVi+UaCINmvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPcEx7Kyb88N4PLh6olMCoOCc3LDw3cjSwMxfRB2ad28YkMwtC
	l/QQoWnC4bKspNOweyabD4NjFcXZZ7iBYhRQjJcvGqA8umJttZhoksKuikbiXs9Q3jpMaAqlfm1
	NBuQd+0D8oQ6qxDaVdVGuWn5RwJFWeMuSyLkb
X-Google-Smtp-Source: AGHT+IHP+7htcJ8BgPEpFBfWaxFnQpKq7JObNjsHz6Dygzj4nAQwcf6cdlKATTACXhbxMaOm10i6V6GwxULSmHcVeAY=
X-Received: by 2002:a17:90a:5d15:b0:2e2:8fb4:502d with SMTP id
 98e67ed59e1d1-2e76b5e65a6mr2138687a91.16.1729683119198; Wed, 23 Oct 2024
 04:31:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87a5eysmj1.fsf@mid.deneb.enyo.de> <20241023062417.3862170-1-dvyukov@google.com>
 <8471d7b1-576b-41a6-91fb-1c9baae8c540@redhat.com> <5a3d3bc8-60db-46d0-b689-9aeabcdb8eab@lucifer.local>
 <CACT4Y+ZE9Zco7KaQoT50aooXCHxhz2N_psTAFtT+ZrH14Si7aw@mail.gmail.com>
 <b1df934e-7012-4523-a513-d3d1536b7f72@suse.cz> <f000d21f-dd04-462a-9d34-d0e7f0f7dc2e@redhat.com>
 <b5792b5f-298b-499f-abc2-db773ceeed36@lucifer.local> <1768ef5d-7289-4d2b-ae02-f5d2a20d5320@redhat.com>
In-Reply-To: <1768ef5d-7289-4d2b-ae02-f5d2a20d5320@redhat.com>
From: Marco Elver <elver@google.com>
Date: Wed, 23 Oct 2024 13:31:21 +0200
Message-ID: <CANpmjNM_q-+FH4S8UxRqnomfT7oneN5kcFf_Sxn6cStCCqoKeQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] implement lightweight guard pages
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Dmitry Vyukov <dvyukov@google.com>, fw@deneb.enyo.de, 
	James.Bottomley@hansenpartnership.com, Liam.Howlett@oracle.com, 
	akpm@linux-foundation.org, arnd@arndb.de, brauner@kernel.org, 
	chris@zankel.net, deller@gmx.de, hch@infradead.org, ink@jurassic.park.msu.ru, 
	jannh@google.com, jcmvbkbc@gmail.com, jeffxu@chromium.org, 
	jhubbard@nvidia.com, linux-alpha@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-mm@kvack.org, linux-parisc@vger.kernel.org, mattst88@gmail.com, 
	muchun.song@linux.dev, paulmck@kernel.org, richard.henderson@linaro.org, 
	shuah@kernel.org, sidhartha.kumar@oracle.com, surenb@google.com, 
	tsbogend@alpha.franken.de, willy@infradead.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Oct 2024 at 11:29, David Hildenbrand <david@redhat.com> wrote:
>
> On 23.10.24 11:18, Lorenzo Stoakes wrote:
> > On Wed, Oct 23, 2024 at 11:13:47AM +0200, David Hildenbrand wrote:
> >> On 23.10.24 11:06, Vlastimil Babka wrote:
> >>> On 10/23/24 10:56, Dmitry Vyukov wrote:
> >>>>>
> >>>>> Overall while I sympathise with this, it feels dangerous and a pretty major
> >>>>> change, because there'll be something somewhere that will break because it
> >>>>> expects faults to be swallowed that we no longer do swallow.
> >>>>>
> >>>>> So I'd say it'd be something we should defer, but of course it's a highly
> >>>>> user-facing change so how easy that would be I don't know.
> >>>>>
> >>>>> But I definitely don't think a 'introduce the ability to do cheap PROT_NONE
> >>>>> guards' series is the place to also fundmentally change how user access
> >>>>> page faults are handled within the kernel :)
> >>>>
> >>>> Will delivering signals on kernel access be a backwards compatible
> >>>> change? Or will we need a different API? MADV_GUARD_POISON_KERNEL?
> >>>> It's just somewhat painful to detect/update all userspace if we add
> >>>> this feature in future. Can we say signal delivery on kernel accesses
> >>>> is unspecified?
> >>>
> >>> Would adding signal delivery to guard PTEs only help enough the ASAN etc
> >>> usecase? Wouldn't it be instead possible to add some prctl to opt-in the
> >>> whole ASANized process to deliver all existing segfaults as signals instead
> >>> of -EFAULT ?
> >>
> >> Not sure if it is an "instead", you might have to deliver the signal in
> >> addition to letting the syscall fail (not that I would be an expert on
> >> signal delivery :D ).
> >>
> >> prctl sounds better, or some way to configure the behavior on VMA ranges;
> >> otherwise we would need yet another marker, which is not the end of the
> >> world but would make it slightly more confusing.
> >>
> >
> > Yeah prctl() sounds sensible, and since we are explicitly adding a marker
> > for guard pages here we can do this as a follow up too without breaking any
> > userland expectations, i.e. 'new feature to make guard pages signal' is not
> > going to contradict the default behaviour.
> >
> > So all makes sense to me, but I do think best as a follow up! :)
>
> Yeah, fully agreed. And my gut feeling is that it might not be that easy
> ... :)
>
> In the end, what we want is *some* notification that a guard PTE was
> accessed. Likely the notification must not necessarily completely
> synchronous (although it would be ideal) and it must not be a signal.
>
> Maybe having a different way to obtain that information from user space
> would work.

For bug detection tools (like GWP-ASan [1]) it's essential to have
useful stack traces. As such, having this signal be synchronous would
be more useful. I don't see how one could get a useful stack trace (or
other information like what's stashed away in ucontext like CPU
registers) if this were asynchronous.

[1] https://arxiv.org/pdf/2311.09394

