Return-Path: <linux-kernel+bounces-535371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F375DA471C8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B42B3A1EDF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ED373477;
	Thu, 27 Feb 2025 01:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0q7l5VE"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD661171A7
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740621140; cv=none; b=J4WV1XFIm5uxW6RzdAzm69UPxrBydM0rOP6LNiXw6D7KepnFjkA8C5Y/NfYK5FRcFB735gRaAQGY8OKVTQIj8qu2z5QCaKVu1rwVpgi9/rTeIxTOdp4CkeNoQ6SnQMHNpDdrr6VQ+BMKJAEf4EMPOLrUmnhHuAGziLtjw/PKkTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740621140; c=relaxed/simple;
	bh=hw0EClt+KjkHr0wYgycl8DBygEnJ+tS0JF3ygXoPC0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ACrczfWw/Ab+sWlPRtnoHVxIEk5XI9REfnq3/PObcFMfnajrEgzit8LFRnpGPPblNLbTF7ZUjOhlK7wMNUqq99DQuDKbQ5Kt7BfApNjCJ/IyknH/mhQx3dypci8DeLUTTDGOwVQU4FrDBdJGigKymS8hWo1SVSadtQJA8sCnRII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0q7l5VE; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-548409cd2a8so382773e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740621137; x=1741225937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vs6sgyWXbWBHmwIbHfXNzUCb7NF+eaNhgtfcPW0/cz4=;
        b=N0q7l5VE7+Vq4nb6j24HT2TstbHLioqooIyp79KjTwWFm1RKcq+tEhzHUPJhoVQmQ3
         T3pyyq3lwX4BLGfD4TlinZ6bxqAQTbRUGKxQxwx36+xJSlVcI4Kw4lNayvmNbiAVdQJV
         iwh8a7QFbdcsPZDuqBdrjdUHseKr+gtK18W1O3TZV7K2qMnaITTN7yejTOGpae/t+acO
         x2IOTJ38wjepGyWtnlvw2/gU+hP7C5YxUn7GMJoAV3mv7hdUR8JhlEqwv+4Tmg58EvVT
         XCShvBEj0j8aXb/AUZNfZa0sPGAinWq3usVY3xpPnm8XeFRDcN9TxfHA6Hia60px54LM
         amJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740621137; x=1741225937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vs6sgyWXbWBHmwIbHfXNzUCb7NF+eaNhgtfcPW0/cz4=;
        b=b6KYplPIfaAY/3UuQlKxonVf7RUG3DFsuDRaLtn9rCbhWyJo7X06+0ooXtr2GCbwu6
         PtixgfFVxWgkZnGHEMsC8oKzaq4zaGh3AM6g6xJTL3tXoUq4FYSVtErungjd50vxENYs
         KFLz+Tav4mscTxfzUwZahPsFWobfM5p90VKd9LS+cZIpXbt2Y7BytkiZtCb9rL1+CyJj
         AOkAZ+T3jRUk4OOR8E88qo4EIlMs4MvVmEE53xQwoSDonfvD6mr2DB0NiRiOW14aoeW2
         ThuM1/su4qTWzOhy0K3tEcXZ1mdhJ1RtDubrQVikiP6oFXAM5yMJJiDDYvdWqogIxsgB
         Td/A==
X-Gm-Message-State: AOJu0YwajqmRkrr8VSBDVwzu+4OL50O4jVQbCQHvP/c1lkgNu1Tq+sB3
	GHDlnnzb3TIvUVKxWCg4eCx1R/X+RDCG5CwLqSaVyuhcySneId85D5AaoQOwawQLgwgPr/HbPi2
	c1FmDoJjTvwlFeHddytBvgQoYX7dN/u8=
X-Gm-Gg: ASbGncuNmK0XDeyNYd2ukMsR+mET5EU6/Bvn7sQHCrgyl9G9DG06iL/eqSf0uZWE1M3
	7h3TLC1kCKlxSJs8LJGuskdddokL61QgauzwRbhIV5YJObYTKg2aSPn8obr69pEqlXjOJcmSGkC
	I9i0a+/UFIkRKPhfcv6rjgsQ==
X-Google-Smtp-Source: AGHT+IEd+hG/yPItb+W9brTEJT1Zr6lOlZJb38THk8NC1KWwlxmq1Nb1AjPu0k2fDm4dUgHW9SpO6G5z2ZG4okSXgww=
X-Received: by 2002:a05:6512:a93:b0:546:2f7a:38b9 with SMTP id
 2adb3069b0e04-548510ce891mr6380082e87.3.1740621136299; Wed, 26 Feb 2025
 17:52:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226180531.1242429-1-brgerst@gmail.com> <20250226202309.GB29387@noisy.programming.kicks-ass.net>
 <CAMzpN2hbbMdB8bf9deRefvFoQ_iRjB1o9edkgFSZvcjRzsVgdQ@mail.gmail.com>
In-Reply-To: <CAMzpN2hbbMdB8bf9deRefvFoQ_iRjB1o9edkgFSZvcjRzsVgdQ@mail.gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Wed, 26 Feb 2025 20:52:04 -0500
X-Gm-Features: AQ5f1JoINaySo6SdP4qDmT_eSbRGDY2F_6MVrnDUziqXk2_xWtp4NypMyheB2uw
Message-ID: <CAMzpN2hEeBR0tn+sNON4uXTiqy1CfoLHGjQuwEWcRMuQJPb4eg@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] Add a percpu subsection for cache hot data
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>, Uros Bizjak <ubizjak@gmail.com>, 
	Linus Torvalds <torvalds@linuxfoundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 8:29=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wro=
te:
>
> On Wed, Feb 26, 2025 at 3:23=E2=80=AFPM Peter Zijlstra <peterz@infradead.=
org> wrote:
> >
> > On Wed, Feb 26, 2025 at 01:05:19PM -0500, Brian Gerst wrote:
> > > Add a new percpu subsection for data that is frequently accessed and
> > > exclusive to each processor.  This replaces the pcpu_hot struct on x8=
6,
> > > and is available to all architectures and the core kernel.
> > >
> > > ffffffff842fa000 D __per_cpu_hot_start
> > > ffffffff842fa000 D hardirq_stack_ptr
> > > ffffffff842fa008 D __ref_stack_chk_guard
> > > ffffffff842fa008 D __stack_chk_guard
> > > ffffffff842fa010 D const_cpu_current_top_of_stack
> > > ffffffff842fa010 D cpu_current_top_of_stack
> > > ffffffff842fa018 D const_current_task
> > > ffffffff842fa018 D current_task
> > > ffffffff842fa020 D __x86_call_depth
> > > ffffffff842fa028 D this_cpu_off
> > > ffffffff842fa030 D __preempt_count
> > > ffffffff842fa034 D cpu_number
> > > ffffffff842fa038 D __softirq_pending
> > > ffffffff842fa03a D hardirq_stack_inuse
> > > ffffffff842fa040 D __per_cpu_hot_end
> >
> > The above is useful, but not quite as useful as looking at:
> >
> > $ pahole -C pcpu_hot defconfig-build/vmlinux.o
> > struct pcpu_hot {
> >         union {
> >                 struct {
> >                         struct task_struct * current_task; /*     0    =
 8 */
> >                         int        preempt_count;        /*     8     4=
 */
> >                         int        cpu_number;           /*    12     4=
 */
> >                         u64        call_depth;           /*    16     8=
 */
> >                         long unsigned int top_of_stack;  /*    24     8=
 */
> >                         void *     hardirq_stack_ptr;    /*    32     8=
 */
> >                         u16        softirq_pending;      /*    40     2=
 */
> >                         bool       hardirq_stack_inuse;  /*    42     1=
 */
> >                 };                                       /*     0    48=
 */
> >                 u8                 pad[64];              /*     0    64=
 */
> >         };                                               /*     0    64=
 */
> >
> >         /* size: 64, cachelines: 1, members: 1 */
> > };
> >
> > A slightly more useful variant of your listing would be:
> >
> > $ readelf -Ws defconfig-build/vmlinux | sort -k 2 | awk 'BEGIN {p=3D0} =
/__per_cpu_hot_start/ {p=3D1} { if (p) print $2 " " $3 " " $8 } /__per_cpu_=
hot_end/ {p=3D0}'
> > ffffffff834f5000 0 __per_cpu_hot_start
> > ffffffff834f5000 8 hardirq_stack_ptr
> > ffffffff834f5008 0 __ref_stack_chk_guard
> > ffffffff834f5008 8 __stack_chk_guard
> > ffffffff834f5010 0 const_cpu_current_top_of_stack
> > ffffffff834f5010 8 cpu_current_top_of_stack
> > ffffffff834f5018 0 const_current_task
> > ffffffff834f5018 8 current_task
> > ffffffff834f5020 8 __x86_call_depth
> > ffffffff834f5028 8 this_cpu_off
> > ffffffff834f5030 4 __preempt_count
> > ffffffff834f5034 4 cpu_number
> > ffffffff834f5038 2 __softirq_pending
> > ffffffff834f503a 1 hardirq_stack_inuse
> > ffffffff834f5040 0 __per_cpu_hot_end
> >
> > as it also gets the size for each symbol. Allowing us to compute the
> > hole as 0x40-0x3b, or 5 bytes.
>
> If all the variables in this section are scalar or pointer types,
> SORT_BY_ALIGNMENT() should result in no padding between them.  I can
> add a __per_cpu_hot_pad symbol  to show the actual end of the data
> (not aligned to the next cacheline like __per_cpu_hot_end).

Is this better? (from System.map)

ffffffff834f5000 D __per_cpu_hot_start
ffffffff834f5000 D hardirq_stack_ptr
ffffffff834f5008 D __ref_stack_chk_guard
ffffffff834f5008 D __stack_chk_guard
ffffffff834f5010 D const_cpu_current_top_of_stack
ffffffff834f5010 D cpu_current_top_of_stack
ffffffff834f5018 D const_current_task
ffffffff834f5018 D current_task
ffffffff834f5020 D __x86_call_depth
ffffffff834f5028 D this_cpu_off
ffffffff834f5030 D __preempt_count
ffffffff834f5034 D cpu_number
ffffffff834f5038 D __softirq_pending
ffffffff834f503a D hardirq_stack_inuse
ffffffff834f503b D __per_cpu_hot_pad
ffffffff834f5040 D __per_cpu_hot_end


Brian Gerst

