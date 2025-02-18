Return-Path: <linux-kernel+bounces-519754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DB0A3A16E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EB557A1DB9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C642E262811;
	Tue, 18 Feb 2025 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q8ACC4WL"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D6426D5C4
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893079; cv=none; b=Y+1jhLvn7wocA1gEV37ZLbzy8Bbu1lQnJRKcloVv4bLynFAIXaNY197Y5s5a8Dqk8WvUNKcDuix4K59MsBOk83fR1uZWeBtFTBW8bDLuUq9+5/SYMqKMsglM1j7qbIQ+E4gm+qvb4fBnmkaWiPxEpN8oJTiKXNmB/T9pMt+Tn+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893079; c=relaxed/simple;
	bh=MbSqi8fGRLE2MWdWOmZyoaqxD9LSStJyCENzg9i29vY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pkKSSuz38bhXgO2f6jtbAZ8hZiVkW4qjg+MgjjE78jo463HdLlSUB+oRezq0Y+321UlUh87omvkzGFsQtUsNw58znRAwUVm666Hen5kOVjH6MNSdFtPrELSQBHDK9pBMrU4WRyOReXYmZ24KDMVefkxhsJcicD6fwCVjqhP21Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q8ACC4WL; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3061513d353so59849101fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 07:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739893074; x=1740497874; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BCiUaH6MN7itgwvIo5MApL4e69X6Hv5T8NgmLTpDmys=;
        b=q8ACC4WLi+oD8fUyJOAT7Mky4ZEwa/Rlp8ajoKM2grFCWKOd0YgiIo1yXMCR17g1ar
         kBds+1rCM6qhPOhTVdRtZ5QygGCaPE+nb3y5R/KBOuOF1kkhLDBwfzcnUMQIpVXo7UAD
         l+6OThq0JxhtqwlGjDJma3PdpNjaERO0fur0YPeIfemuSQscwi4rzn7EHs6uKKYBVh3G
         gksA+0Mapq6UA35sZcZYX/pmDrAylD/LOqyNoHM0C8xgXo4XPqXuUK4DFuGYAq9fv4MI
         YVbepk6jexzaS7b3t38hBJktdt6HsixEKEiBFU+fKZbei/xHAY5ghrjza6SJo80hYB8Q
         Mhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739893074; x=1740497874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BCiUaH6MN7itgwvIo5MApL4e69X6Hv5T8NgmLTpDmys=;
        b=b4QXR2nMx2ji0b5XsWsoT3vhaOwLzg6kzxbiic2jw+GjbToaGUXQMA1mdbE4M2/wOt
         pJgPaWHEUanZsbcYXqkr04KJBMdVRid96414SUzyCZ1ez1abyrtYCzkcP8n2N/SXwlD4
         Gft7r343CnGv4eqw5tvWL14EMgQDZFfLZQHSCOGcanhUnLNp2L+vJngwDRhtbnM+Nk7Z
         +CuvYSA9gNaFB3ZAARlsfDjgdyXZhBq9AAZ0zVXGbACRFkMIBz7/bzaiRMlthKIGEAvy
         OboSu5FJCr910ukB3fht6p0601Ekkvp6th+5NUuRR7GD4N9s6p3i6yuFoVg/+/KBExyb
         imsA==
X-Forwarded-Encrypted: i=1; AJvYcCVWqs4kZVEpdp+xybWmuAnFBXc7koxquZNZIokK+Zfc9MhjBOL1+accRz7sevOpi9taE3asq8MYScrQToU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxerwBm5knpE4+msctcGmbgAP9DPYTBG68UHYKDbkjty0ZSErqG
	ZFNnsSG+bW+vVlan4RbSSXl/BIHqu3AdPtrsIOR1mYOgVFrKIG3c2391TfuL9NsH7Y2mdAc476k
	NCgPsd4Y3LCC8BQhf87l6HSgMGp5iKuYvgbwmPDv4yyA2Hsy7KtAp
X-Gm-Gg: ASbGncupGKN73pZi2RR9xI8HrsMg7fWymo3PbpJR2q7oARMuCVzfgnaWwkQ2mH0LDZS
	hcXJ7f91y6+T6Q/lySkPDM2Jgs+cWnL5FG0t3R28FTLlElT8gQyMpH6tu6NwfxEKl2yaQM9FNsz
	/hhzBcEPpxy/I+u1GLwKqbcx6kAw==
X-Google-Smtp-Source: AGHT+IGYdC1sCrerPFGvCgTM7OenUn5vas2aD6yb9SWQP6KbFxMb49tyEKQ9Z//zQUg/LTm/gOO04WXUIMhNnFbo31U=
X-Received: by 2002:a2e:a163:0:b0:308:fa1d:d833 with SMTP id
 38308e7fff4ca-30927b283damr39861531fa.37.1739893074018; Tue, 18 Feb 2025
 07:37:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739790300.git.dvyukov@google.com> <0d0e0a0a7136d49af9a8d6a849e1aa4bf086c472.1739790300.git.dvyukov@google.com>
 <f68741e0-0cc8-4faa-8144-e1786b9591f1@efficios.com> <CACT4Y+Ym7=9mLS8b=Rq6cyHMgyboMqh15nqkRfgru-qFVTx_0A@mail.gmail.com>
 <cf7af2a8-c004-481b-ad2e-6aa991aacb67@efficios.com> <CACT4Y+Z3PCBWDdR5PifXoMBSYJ-cdUmzLRdgbjTUG+A2S8Qq1g@mail.gmail.com>
 <2bcfeb11-74a1-497b-b271-06dfb51eace3@efficios.com>
In-Reply-To: <2bcfeb11-74a1-497b-b271-06dfb51eace3@efficios.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 18 Feb 2025 16:37:41 +0100
X-Gm-Features: AWEUYZlgClxBoiDLp3jFDNZiqxLE3BW6TInhVljPffHqzNQfeYQXfkYtFhPma9A
Message-ID: <CACT4Y+bu3WtdMLEOj0qFC_MK4G20Joq52Cr8W86Xx4xK3MsB9A@mail.gmail.com>
Subject: Re: [PATCH 3/4] rseq: Make rseq work with protection keys
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, boqun.feng@gmail.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	aruna.ramakrishna@oracle.com, elver@google.com, 
	"Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Feb 2025 at 16:27, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2025-02-18 10:10, Dmitry Vyukov wrote:
> > On Tue, 18 Feb 2025 at 15:57, Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> >>
> >> On 2025-02-18 02:55, Dmitry Vyukov wrote:
> >>> On Mon, 17 Feb 2025 at 21:21, Mathieu Desnoyers
> >> [...]
> >>>>
> >>>>     we still let this function read the rseq_cs.
> >>>>> +      * It's unclear what benefits the resticted code gets by doing this
> >>>>
> >>>> restricted
> >>>>
> >>>>> +      * (it probably already hijacked control flow at this point), and
> >>>>> +      * presumably any sane sandbox should prohibit restricted code
> >>>>> +      * from accessing struct rseq, and this is still better than
> >>>>> +      * terminating the app unconditionally (it always has a choice
> >>>>> +      * of not using rseq and pkeys together).
> >>>>
> >>>> Note that because userspace can complete an rseq critical section
> >>>> without clearing the rseq_cs pointer, this could happen simply because
> >>>> the kernel is preempting the task after it has:
> >>>>
> >>>> 1) completed an rseq critical section, without clearing rseq_cs,
> >>>> 2) changed pkey.
> >>>>
> >>>> So allowing this is important, and I would remove the comment about
> >>>> hijacked control flow and such. This can happen with normal use of the
> >>>> ABI.
> >>>
> >>> Thanks for the review!
> >>>
> >>> I've addressed all comments in the series in v2.
> >>>
> >>> I've reworded this paragraph to simplify sentences, but I still kept
> >>> the note aboud malicious rseq_cs.
> >>>
> >>> If we would not be circumventing normal protection, then, yes, these
> >>> cases would be the same. But since we are circumventing protection
> >>> that otherwise exists, I think it's important to think about
> >>> potentially malicious cases. In this context inaccessible rseq_cs
> >>> values that resulted from normal execution are very different from
> >>> malicious onces. Normal ones will point to a fixed set of real
> >>> well-formed rseq_cs objects, while malicious ones may point to
> >>> god-knows-where in an attempt of an attacker to do things we can't
> >>> even imagine right now (e.g. rseq_cs overlapping with protected crypto
> >>> keys).
> >>>
> >>> It's as if a particular instance of copy_to_user would allow
> >>> user-space to write arbitrary kernel memory, and memory of other
> >>> processes circumventing all normal protections. In that context we
> >>> would need to be very careful regarding what we actually allow.
> >>
> >> I'm considering that we should clear the rseq_cs pointer whenever
> >> userspace issues pkey_mprotect.
> >>
> >> This would ensure that no legitimate scenario can trigger a load
> >> from a rseq_cs area which has the wrong pkey, and therefore we
> >> could accept read/write from/to a struct rseq which has the wrong
> >> pkey, but kill the process if trying to read/write from a
> >> struct rseq_cs with the wrong key. This would prevent userspace
> >> from making the kernel read/write from/to memory with the wrong
> >> pkey through a pointer it controls (rseq_cs pointer).
> >>
> >> Thoughts ?
> >
> > I am not following.
> >
> > There are pkey_mprotect calls, then independently installs on rseq_cs
> > pointers that happen concurrently and after pkey_mprotect, and
> > independent set of pkey_set calls that happens concurrently and after
> > the previous 2.
> > I don't see how doing something at the pkey_mprotect call for the
> > single thread avoids any scenarios.
>
> Hrm. Sorry, I mixed up pkey_set() vs pkey_mprotect(). What I had in mind
> was actually pkey_set(). And that would need to clear rseq_cs for all
> threads belonging to the process, which may not be straightforward
> because those could legitimately be inside a rseq critical section.
>
> OK, let's try another approach: rather than kill the process if
> read/write of the rseq_cs area with the wrong key fails, could we simply
> clear the rseq_cs pointer in that case ? Technically there would be no
> legitimate use of this except for the case where it is meant to be lazily
> cleared.

This may work, but 2 concerns with this:
1. We don't know if the failure happened due to pkeys or not (at least
not easily), and I am afraid of touching the logic for other failures.
If the rseq_cs was a bogus pointer, or protected with normal mprotect,
what does it mean? Are we masking a programming bug? Are we
circumventing some other protections that were supposed to lead to the
process termination?
2. This will complicate __rseq_handle_notify_resume() logic as it
would need to handle failures when accessing rseq and rseq_cs
differently (+plus there is signature check). The more complex the
logic, the higher chances of adding a bug now or in future.


> Thanks,
>
> Mathieu
>
> > Moreover, pkey 0 is preinstalled for all pages, but access to it can
> > be revoked in future.
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com

