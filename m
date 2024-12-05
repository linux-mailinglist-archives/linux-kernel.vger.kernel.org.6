Return-Path: <linux-kernel+bounces-433504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FA89E5956
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9EAF1886C8C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C2E21A447;
	Thu,  5 Dec 2024 15:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1tNH3Sc9"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318971773A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733411034; cv=none; b=mjcdrqelS8huDWr+ug44fEQD1pqzc+5dM6XRqQLD+DFRAtRw2xRuU88oOfJRLvfrmRVDAxN1G/vlxQJzSjI17x7UvowCRoPcbvO/0Tv3p4mSvwkxvAUmKQpqLCKtZAFoOLuD5udOTg0R80zbxkku0uCmyqoI1e9cWLzN8mCbgi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733411034; c=relaxed/simple;
	bh=3IDKrnH5MbBH4vAjR1u7hzwNW6aJWy2mvYFW+H7OIec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f8NrBXKoIrxkdBF1TDiWsuOl8mvS/tggOuKG8FzKYMEICZ2qzd1+C0sTuRWXE7ygtPD6qBufXDSyka68IzfhVLGes27pHVaemZL3NgvuybYxeUUhzxaLIQJl7FHSRegBXROcMhzx6bIvg9dw3RW9GXRG8yBPUAnh4ZxyTBW/ebY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1tNH3Sc9; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3bbb0f09dso20365a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 07:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733411031; x=1734015831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IDKrnH5MbBH4vAjR1u7hzwNW6aJWy2mvYFW+H7OIec=;
        b=1tNH3Sc9kfjmBCaL1di6lU/jzuRDd384X4Y9KjUrMsjx3F+qcYRhbY4CRQLIUBmpmB
         FdL0tRqPnpAlbyWUvZarvWd+qkPU27SkeFCgM+RJsL5BcOx3gTJB86mFWasvh1jscxSo
         702BPNy67Yq1iIuNiXp8Y+5NQYJU4emv2B0Q2t2wlkOtigyviiWWzCNEdfPZzLz62VMr
         7CJ4E2O1CnVbsqUMFgtxW/uXpOD/2pfZVZ6Pno5J6XYu9hIAuZISaiN9MQbxaVbsXfYf
         9DLgaR6ICLCS9rBwut/V/yF5PPQEmGgXrOzN7K1AgxFd4ioHY1KosjWyYfTQGfQJt1bW
         q+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733411031; x=1734015831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3IDKrnH5MbBH4vAjR1u7hzwNW6aJWy2mvYFW+H7OIec=;
        b=ZPChWRNXeJ5KWBFDLhdEJG49m8ieHMnjW+SXeZSDu5T/VEgXFNXmao/zzWRmi8iKnr
         Byr1sM/VMLvVLCGx3VSvMlhjFd+jsy3fGX7rAv8pxU6jf/zNJWS6fkkUU7vzOrlYexMc
         g/E1EvkYyRNto9/306yyxEEEYS1gh3SJF0E1b4mLz6ThDpWkhApVUkYf6kjJPffD33EB
         0ZjOpD7ytpuTeTxCDOyybcn9T3U79slwrOefbA82ptdwJYkwG05SdYCQCEhj/XaPVz6F
         s9G7BITDUHyEVQipUmRF31RuC8LcIpgxwSkJpQ0C9bRxWgo1m+p9/cchhbQLr8NDspyV
         p+ig==
X-Forwarded-Encrypted: i=1; AJvYcCXYACVh09HUjWwe7Z9FDFE5QB5ye2czfLTEGCHx7q5CqTraLTfgCZhkvy92rqQdWaJ5Cbg5LEqeXHapKbM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9JU69nXM7rphLXUqABc1l0MVSvva/EQeApodgfDSoLue6+Nng
	sE9gKeC4t33oD6gjFenv6qVvW/i8cTVt4HXRZKQ87TUW+obbLPX9fzSQvyV64nontxRd5dsGW3i
	Q9YeFl13dk4HZXsxvgx0d4FOcA+XvL4LCgYNK
X-Gm-Gg: ASbGncsyQ9k9a3cxnIOtjKz6E6d11KN+oqU6c0N4k9cpzGbKMj0KcapEnxg69wRMth2
	VSyTBD42N25rPo96JMrTfZ30wA/MPUbRp/sjGl595AHf2fbD++Lc9ggrn+8Dj
X-Google-Smtp-Source: AGHT+IFvB+h9OJ9KwvCKDR54RFjhsfK+1E0vPwAz90jPLLQ2M6EsBZnJS68jLDuTHtqQP9p6aazgNC+KeMy/i6JMHIA=
X-Received: by 2002:a05:6402:1d54:b0:5d0:bf27:ef8a with SMTP id
 4fb4d7f45d1cf-5d10cb8272bmr9017262a12.26.1733411031029; Thu, 05 Dec 2024
 07:03:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325172707.73966-1-peternewman@google.com>
 <20240325172707.73966-4-peternewman@google.com> <4a6b1645-c72c-41dd-a455-bdf0ec57d4c5@intel.com>
 <CALPaoCiH0CZgEL8UQZeTrRtV_b-Oc6JyvaG4+txuZzsHCv976Q@mail.gmail.com>
In-Reply-To: <CALPaoCiH0CZgEL8UQZeTrRtV_b-Oc6JyvaG4+txuZzsHCv976Q@mail.gmail.com>
From: Peter Newman <peternewman@google.com>
Date: Thu, 5 Dec 2024 16:03:40 +0100
Message-ID: <CALPaoChad6=xqz+BQQd=dB915xhj1gusmcrS9ya+T2GyhTQc5Q@mail.gmail.com>
Subject: Re: [PATCH v1 3/6] x86/resctrl: Disallow mongroup rename on MPAM
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, James Morse <james.morse@arm.com>, 
	Stephane Eranian <eranian@google.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Mike Rapoport <rppt@kernel.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Xin Li <xin3.li@intel.com>, 
	Babu Moger <babu.moger@amd.com>, Shaopeng Tan <tan.shaopeng@fujitsu.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Jens Axboe <axboe@kernel.dk>, 
	Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Tycho Andersen <tandersen@netflix.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Beau Belgrave <beaub@linux.microsoft.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Reinette,

On Sat, Apr 6, 2024 at 12:10=E2=80=AFAM Peter Newman <peternewman@google.co=
m> wrote:
>
> Hi Reinette,
>
> On Thu, Apr 4, 2024 at 4:11=E2=80=AFPM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
> >
> > Hi Peter,
> >
> > On 3/25/2024 10:27 AM, Peter Newman wrote:
> > > Moving a monitoring group to a different parent control assumes that =
the
> > > monitors will not be impacted. This is not the case on MPAM where the
> > > PMG is an extension of the PARTID.
> > >
> > > Detect this situation by requiring the change in CLOSID not to affect
> > > the result of resctrl_arch_rmid_idx_encode(), otherwise return
> > > -EOPNOTSUPP.
> > >
> >
> > Thanks for catching this. This seems out of place in this series. It so=
unds
> > more like an independent fix that should go in separately.
>
> I asserted in a comment in a patch later in the series that the
> mongroup parent pointer never changes on MPAM, then decided to follow
> up on whether it was actually true, so it's only here because this
> series depends on it. I'll post it again separately with the fix you
> requested below.

I'm preparing to finally re-post this patch, but another related
question came up...

It turns out the check added to mongroup rename in this patch is an
important property that the user needs in order to correctly interpret
the value returned by info/L3_MON/num_rmids.

I had told some Google users to attempt to move a monitoring group to
a new parent to determine whether the monitoring groups are
independent of their parent ctrl_mon groups. This approach proved
unwieldy when used on a system where the maximum number of allowed
groups has already been created. (In their problem case, a
newly-created process wanted to determine this property independently
of the older process which had originally mounted resctrl.)

Also, this information does not require an active rdtgroup pointer or
CLOSID/RMID. The following will also work:

 resctrl_arch_rmid_idx_encode(0, 0) !=3D resctrl_arch_rmid_idx_encode(1, 0)=
;

I propose adding a new info file returning the result of this
expression to be placed beside num_rmids. I would name it
"mon_id_includes_control_id", as it implies that the hardware
logically interprets the monitoring ID as concatenated with its parent
control ID. This tells the user whether num_rmids defines the number
of monitoring groups (and ctrl_mon groups) which can be created system
wide or whether it's one more than the number of monitoring groups
which can be created below every ctrl_mon group.

Without this information, I find it difficult to create test cases
with a maximal number of groups in a portable fashion.

Also, this would be a good opportunity to generalize "num_rmids" to
"num_mon_ids" and add a symlink between the two for backwards
compatibility.

Thoughts?

Thanks,
-Peter

