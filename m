Return-Path: <linux-kernel+bounces-531684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 697F4A44387
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CC067AB65C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520E421ABC6;
	Tue, 25 Feb 2025 14:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GrZMSiuY"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C3221ABA2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740495128; cv=none; b=LVuWgbbPHqeYV625Xvh2FP1uVRVFjsfi+bTN8i60qDyuiNeqDC36Rf3C8YYwApB8omQvMqx+QCcdqbVzbnvm7F5ACJjQhLpRx8yfjBYtZ9lOfDYI0IBdPA8hHzOFqOQznzKQLHspM/UCJNvdrB6iujyS9hxuVDFJgZbAQA1ywlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740495128; c=relaxed/simple;
	bh=XL6Y8Ue4UX2AcVMROAhI+8cR7pMUyhVI3kHk7llgoXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q6MVqX1Dd1fmBeQN6r4sGOoYiOgNtwbimQcjMBNjzUXU2HnR/RuN5hY03DOEVjH0xjOvrwmScrV6qCZzjjYtdKXTWKDtZJ5ene/xp1oiPi8C1T2mXbK4OHNVdR1vcYLGEPcRopCsY6HvL5G5QFS0hq4bsJ9X2U4mBoH6Td8M5pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GrZMSiuY; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30795988ebeso59138641fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 06:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740495124; x=1741099924; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3tuPHequGzMuR1EjYE/aLgHiotFNF4oRKllhFvzBpe4=;
        b=GrZMSiuYdoMDt2hNjYsl0k2ExhPG2qVEIJHVFXdANo9b+EB49I/PizdLx8c+bvT4gE
         /Q6z8tC18JL71sLndAvEyAgjkF7q1zXzyfMIqA0SduVj2q2Hdyo2gKqxfmZ8B49sAnOq
         vFirW9tUZjIy2ELV0atWfKO/+pxAsSBWckoFNTYXSai1lVPRIuwumDjNsIntrz99ysAQ
         TxbjMDgCk/nSNXBO3j7eYWfJsRJv45p3MtoBEGaend5s1yDARZwqtThFud3hU0UWM7bN
         21vI2n3FtEDxGtwhyvCuuKZL23GzLmStHefbwwz0QH9uJhHNv2+gopWYt9kaS8/P54Oe
         Md9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740495124; x=1741099924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3tuPHequGzMuR1EjYE/aLgHiotFNF4oRKllhFvzBpe4=;
        b=ZDey1qu6sJzAMhIbvcMRbqQBWPubjihGuq3j5bPuOaunevd916naIPozGF2mRIdGdk
         aB1cWgiGLuMTMavPP75opOIBwvtWx1+Pty44pZjfhYP29zAQReabyVQSVTjpIu1hHAwa
         skTy7ejBwVz4c59ZY0DJLeI2i48y0Nyvx2wutDRaeiL8WVQiCfBb4PQOQEujlZScoRy3
         XeyiqPHVBXRgZAJteIEZK47VG0j5B7PXfaS6HtB4KDG0NcbQyxSK2wOuoAv6YtuXhUv+
         NTiWCHZtrWGGSQLBRAypisXDpVYyyarOQxTJsiZxB6ISn51ZP4na1Is4hQclMLvzvfxw
         LL/A==
X-Forwarded-Encrypted: i=1; AJvYcCWhSxBeFOXLDD4qrJTqoPqKyDCfj6gqzG++bt47ml7FdiC0AzNvZlCSus3eBZFFNCnoWxAAwunLN0bzdoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YztAlV5cSwR7FefkJ4lF/eIMJXW5qanIsN4lJMcsdlNR0LKqRkx
	m4kV+1doKkPu5XyFMk8wyApsd87KUmuaMmTE3kkcln6nGEf0Gxg9ef/vMnkRaew4e5gwW9WE6yB
	Yn1cETjSe4flujVVEJ/DXD2gzfwZQ8j4vZ3oA
X-Gm-Gg: ASbGncvF/mGyICPxzUPs11UdyqVtqvIxGQ+l5LDzR9GfDihXEHhNlS6CO792SXgLxex
	oyD+G/5bUpf47j16Vs2l3wFPUbMNfEmZS396/lFul5Q5dtKqp6f5SqTpGRsOn5oNdSkmDuzv7oj
	dyEMPX8JSM/Ymdr33Z07p1qxpZiuAQOaRZXrn3osyH
X-Google-Smtp-Source: AGHT+IEvl4Xp01m/kppPffjbL0eDt/euUOdlf9I44GRPPQliiNFucatiPdpuDRc0W2rY2o86qqMn3vYGjkVwcPXQoRk=
X-Received: by 2002:a2e:9207:0:b0:304:d8e7:7ea1 with SMTP id
 38308e7fff4ca-30a80c99384mr15641891fa.23.1740495124392; Tue, 25 Feb 2025
 06:52:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740403209.git.dvyukov@google.com> <4e93f7da6dfa450d488fafa3599306349e6e34e8.1740403209.git.dvyukov@google.com>
 <b18e6478-ef4b-42b3-8cc4-42467b3a0a7f@efficios.com> <CACT4Y+YxmkW6opFVJFOOFd=c73gz7yFvwBBCnjMndj-jffjBCw@mail.gmail.com>
 <b42dc8d7-2f2e-466f-bdca-0d532a0d5928@efficios.com>
In-Reply-To: <b42dc8d7-2f2e-466f-bdca-0d532a0d5928@efficios.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 25 Feb 2025 15:51:52 +0100
X-Gm-Features: AQ5f1JrdanOBkPkT1d4jyQL0fz7Spx-npcfmQUgm9CxzN_uowr3ptYoR1j91ol8
Message-ID: <CACT4Y+Y9RodZO7T2RSJGohwjAdgBktgySCvCZ9xaPdVJafYzJw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] rseq: Make rseq work with protection keys
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, boqun.feng@gmail.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	aruna.ramakrishna@oracle.com, elver@google.com, 
	"Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2025 at 15:28, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2025-02-25 09:07, Dmitry Vyukov wrote:
> > On Mon, 24 Feb 2025 at 20:18, Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> >>
> >> On 2025-02-24 08:20, Dmitry Vyukov wrote:
> >>> If an application registers rseq, and ever switches to another pkey
> >>> protection (such that the rseq becomes inaccessible), then any
> >>> context switch will cause failure in __rseq_handle_notify_resume()
> >>> attempting to read/write struct rseq and/or rseq_cs. Since context
> >>> switches are asynchronous and are outside of the application control
> >>> (not part of the restricted code scope), temporarily switch to
> >>> pkey value that allows access to the 0 (default) PKEY.
> >>
> >> This is a good start, but the plan Dave and I discussed went further
> >> than this. Those additions are needed:
> >>
> >> 1) Add validation at rseq registration that the struct rseq is indeed
> >>      pkey-0 memory (return failure if not).
> >
> > I don't think this is worth it for multiple reasons:
> >   - a program may first register it and then assign a key, which means
> > we also need to check in pkey_mprotect
> >   - pkey_mprotect may be applied to rseq of another thread, so ensuring
> > that will require complex code with non-trivial synchronization and
> > will add considerable overhead to pkey_mprotect call
> >   - a program may assign non-0 pkey but have it always accessible, such
> > programs will break by the new check
> >   - the misuse is already detected by rseq code, and UNIX errno-based
> > reporting is not very informative and does not add much value on top
> > of existing reporting
> >   - this is not different from registering rseq and then unmap'ing the
> > memory, checking that does not look like a good idea, and checking
> > only subset of misuses is inconsistent
> >
> > Based on my experience with rseq, what would be useful is reporting a
> > meaningful siginfo for access errors (address/unique code) and fixing
> > signal delivery. That would solve all of the above problems, and
> > provide useful info for the user (not just confusing EINVAL from
> > mprotect/munmap).
> >
> > But I would prefer to not mix these unrelated usability improvements
> > and bug fixes with this change. That's not related to this change.
>
> I agree with your arguments. If Dave is OK with it, I'd be fine with
> leaving out the pkey-0 validation on rseq registration, and eventually
> bring meaningful siginfo access errors as future improvements.
>
> So the new behavior would be that both rseq and rseq_cs are required
> to be pkey-0. If they are not and their pkey is not accessible in the
> current context, it would trigger a segmentation fault. Ideally we'd
> want to document this somewhere in the UAPI header.

Makes sense. I will wait for Dave comments/ack before sending v6. But
to save a round-trip, does this look reasonable?

--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -58,6 +58,10 @@ struct rseq_cs {
  * contained within a single cache-line.
  *
  * A single struct rseq per thread is allowed.
+ *
+ * If struct rseq or struct rseq_cs is used with Memory Protection Keys,
+ * then the assigned pkey should either be accessible whenever these structs
+ * are registered/installed, or they should be protected with pkey 0.
  */
 struct rseq {



> >> 2) The pkey-0 requirement is only for struct rseq, which we can check
> >>      for at rseq registration, and happens to be the fast path. For struct
> >>      rseq_cs, this is not the same tradeoff: we cannot easily check its
> >>      associated pkey because the rseq_cs pointer is updated by userspace
> >>      when entering a critical section. But the good news is that reading
> >>      the content of struct rseq_cs is *not* a fast-path: it's only done
> >>      when preempting/delivering a signal over a thread which has a
> >>      non-NULL rseq_cs pointer.
> >
> > rseq_cs is usually accessed on a hot path since rseq_cs pointer is not
> > cleared on critical section exit (at least that's what we do).
>
> Fair point.
>
> >
> >>      Therefore reading the struct rseq_cs content should be done with
> >>      write_permissive_pkey_val(), giving access to all pkeys.
> >
> > You just asked me to redo the code to simplify it, won't this
> > complicate it back again? ;)
>
> I'm fine with the pkey-0 approach for both rseq and rseq_cs if Dave is
> also OK with it.

It should work for my current use case, at least how I currently see
it. Ways people use pkeys are pretty unique, so it's hard to
extrapolate. But there is one more possibility: when a program
switches PKEYs, it may also clear stale rseq_cs pointer from rseq.
This way rseq_cs may have non-0 keys assigned, but they are always
accessible while installed.



> Thanks,
>
> Mathieu
>
> >
> >
> >> Thanks,
> >>
> >> Mathieu
> >>
> >>>
> >>> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> >>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >>> Cc: Peter Zijlstra <peterz@infradead.org>
> >>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> >>> Cc: Boqun Feng <boqun.feng@gmail.com>
> >>> Cc: Thomas Gleixner <tglx@linutronix.de>
> >>> Cc: Ingo Molnar <mingo@redhat.com>
> >>> Cc: Borislav Petkov <bp@alien8.de>
> >>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> >>> Cc: "H. Peter Anvin" <hpa@zytor.com>
> >>> Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
> >>> Cc: x86@kernel.org
> >>> Cc: linux-kernel@vger.kernel.org
> >>> Fixes: d7822b1e24f2 ("rseq: Introduce restartable sequences system call")
> >>>
> >>> ---
> >>> Changes in v4:
> >>>    - Added Fixes tag
> >>>
> >>> Changes in v3:
> >>>    - simplify control flow to always enable access to 0 pkey
> >>>
> >>> Changes in v2:
> >>>    - fixed typos and reworded the comment
> >>> ---
> >>>    kernel/rseq.c | 11 +++++++++++
> >>>    1 file changed, 11 insertions(+)
> >>>
> >>> diff --git a/kernel/rseq.c b/kernel/rseq.c
> >>> index 2cb16091ec0ae..9d9c976d3b78c 100644
> >>> --- a/kernel/rseq.c
> >>> +++ b/kernel/rseq.c
> >>> @@ -10,6 +10,7 @@
> >>>
> >>>    #include <linux/sched.h>
> >>>    #include <linux/uaccess.h>
> >>> +#include <linux/pkeys.h>
> >>>    #include <linux/syscalls.h>
> >>>    #include <linux/rseq.h>
> >>>    #include <linux/types.h>
> >>> @@ -402,11 +403,19 @@ static int rseq_ip_fixup(struct pt_regs *regs)
> >>>    void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
> >>>    {
> >>>        struct task_struct *t = current;
> >>> +     pkey_reg_t saved_pkey;
> >>>        int ret, sig;
> >>>
> >>>        if (unlikely(t->flags & PF_EXITING))
> >>>                return;
> >>>
> >>> +     /*
> >>> +      * Enable access to the default (0) pkey in case the thread has
> >>> +      * currently disabled access to it and struct rseq/rseq_cs has
> >>> +      * 0 pkey assigned (the only supported value for now).
> >>> +      */
> >>> +     saved_pkey = enable_zero_pkey_val();
> >>> +
> >>>        /*
> >>>         * regs is NULL if and only if the caller is in a syscall path.  Skip
> >>>         * fixup and leave rseq_cs as is so that rseq_sycall() will detect and
> >>> @@ -419,9 +428,11 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
> >>>        }
> >>>        if (unlikely(rseq_update_cpu_node_id(t)))
> >>>                goto error;
> >>> +     write_pkey_val(saved_pkey);
> >>>        return;
> >>>
> >>>    error:
> >>> +     write_pkey_val(saved_pkey);
> >>>        sig = ksig ? ksig->sig : 0;
> >>>        force_sigsegv(sig);
> >>>    }

