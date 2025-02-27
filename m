Return-Path: <linux-kernel+bounces-535342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C60A471A0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F0C1893EB8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBF81AC882;
	Thu, 27 Feb 2025 01:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6jE17UN"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9CE14A4E7
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740619766; cv=none; b=m3TeZhqB6zMA86gX9+0j/N/t4tkOBoeXENb2VCf1SaMM+VT9TnC0rXIwvtVS3GIHLDm1jmgy23raJTyIDDtTpPDmycBW4/ALdQrtc+nxU/eQX5rBZWuk9uCkqIqPBefRVN3BoPAQSuShIOesrU1j9ycGpXkPc3WANV0q1L+M73c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740619766; c=relaxed/simple;
	bh=6OZc/aAW5XiSbl2w5jpvIL78PN+ogva55MtrDURgpWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sbg9zyxNBHuhsJgr+LjXtLXpJGIrwNLqASvZxx9/cMU6qyEJi4TrkXRa23nDdnnLZRF+bBVR1MBVPKmZtrCwinunX5nzlwOIqGdqaH2/OSV9akwjjqoRYl3T4KakyVeX60EvVTVWZW3Z75UEUsEdbsDn2vUPjOQ3nhkHKDtfvDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6jE17UN; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-307c13298eeso5743151fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740619763; x=1741224563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40Sxh0G5wSOAPXK7Esu+L8SeXJF/YQNYx+bAuO4yL8o=;
        b=G6jE17UNLa2uPs31FjTBLs+ukgdPkQmIM5vArvU7Ykw9G92PzOlYjT4Mo/ewCGx6OG
         Oj8vfe3cFkdPoUchVbWh9v2AtuPwsYXApsA5isi7deRAxi4Ts1LnItXrkjlIocddTI5L
         iYXKiWQEcZ5/z8daGi984icpsJoSCKzF490/Yo7MbI3kKmxfChBeoPpiKdAGoQzoyhtL
         wJD3LOha4ReW/olxiMl05Dd+oXEeKpWvB4uejMxWUe4FK/ReLdWmCWmQxB7UlKec1uOy
         aIJXsKULsNx1Tc+44+Q01Zzbmo2AvDdqVsRs0FDT/dvVQYazWl4lycGD98+BSAXb1CQt
         tdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740619763; x=1741224563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=40Sxh0G5wSOAPXK7Esu+L8SeXJF/YQNYx+bAuO4yL8o=;
        b=BAJNLdo0lK4RSlQQfvJwC5+V2YjLriOG5ag4auyImptKBRNgaG/ugfENgH2owZQjvz
         XyNlo1tGoNqJQRRk1StMxtyem4TeAeh0bcv4cxd1q8T+7xPrOn545klNKkz1c2b7kKjm
         j21vHuPrqllcWEFrfzqj5HPe7oHaDdTK9guwbKNQQ2sUp2+h/rCCS8cTzVCYeR5Uui29
         y5cQkdjIEaCopgjX282rRLke0OJeH+2VPZ/UM3AHV+ncqMburnOQOX3HTRhL6hqrTgl4
         AtU1qy4PCoGeDPGgRCZDph3ZsdtmNrvpqTboVrnPppXOX73BS0enIw+BfNDVA2JHU3Rh
         lrPg==
X-Gm-Message-State: AOJu0Yy6+WCzhQ866iFRlodSppXV9c0IF+Lo5WR97TL9UgEfnJitN5Ro
	iLLinoN/kYeMpKpGhScOFcc7j+T8JOKqCi8b0xC7V5zdfcmio0v8yQWzgbVQ3BID9G4GIpHuSMm
	1XHfqAp6hDt0ta9IJZsHD2Eguz6rxwhA=
X-Gm-Gg: ASbGncvV/SXoTWK77BI3wYEp/WhQ3C+KyHeaU63wc5zzeu8VYh1xbKUUDf2xZmDAwEy
	fx6lGlmS32fdeps3OUoLfU82WL2j+bGeHrwKa8esnaSBGRrvaMIxB6oWecTGk9wbF0xNdmT5pUB
	hZqZHGqBZFP1uzrfer1YZhug==
X-Google-Smtp-Source: AGHT+IHzw89dlnQXPrjG/QvpesHlVULfEalCIl6PVj0y2t5ttlfsxTtjRwWDGRh6ik2dIgWSIZCgPSaElbSgSE3fO3Q=
X-Received: by 2002:a2e:3607:0:b0:30a:2a8a:e4d0 with SMTP id
 38308e7fff4ca-30b846bb4a2mr4670201fa.17.1740619762508; Wed, 26 Feb 2025
 17:29:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226180531.1242429-1-brgerst@gmail.com> <20250226202309.GB29387@noisy.programming.kicks-ass.net>
In-Reply-To: <20250226202309.GB29387@noisy.programming.kicks-ass.net>
From: Brian Gerst <brgerst@gmail.com>
Date: Wed, 26 Feb 2025 20:29:10 -0500
X-Gm-Features: AQ5f1JoRNRd2ZcmXnA3-acuUix_Aj3WOVwN_Vg-7y4PVh-ib5sQcL5fosH9PteM
Message-ID: <CAMzpN2hbbMdB8bf9deRefvFoQ_iRjB1o9edkgFSZvcjRzsVgdQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] Add a percpu subsection for cache hot data
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>, Uros Bizjak <ubizjak@gmail.com>, 
	Linus Torvalds <torvalds@linuxfoundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 3:23=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Feb 26, 2025 at 01:05:19PM -0500, Brian Gerst wrote:
> > Add a new percpu subsection for data that is frequently accessed and
> > exclusive to each processor.  This replaces the pcpu_hot struct on x86,
> > and is available to all architectures and the core kernel.
> >
> > ffffffff842fa000 D __per_cpu_hot_start
> > ffffffff842fa000 D hardirq_stack_ptr
> > ffffffff842fa008 D __ref_stack_chk_guard
> > ffffffff842fa008 D __stack_chk_guard
> > ffffffff842fa010 D const_cpu_current_top_of_stack
> > ffffffff842fa010 D cpu_current_top_of_stack
> > ffffffff842fa018 D const_current_task
> > ffffffff842fa018 D current_task
> > ffffffff842fa020 D __x86_call_depth
> > ffffffff842fa028 D this_cpu_off
> > ffffffff842fa030 D __preempt_count
> > ffffffff842fa034 D cpu_number
> > ffffffff842fa038 D __softirq_pending
> > ffffffff842fa03a D hardirq_stack_inuse
> > ffffffff842fa040 D __per_cpu_hot_end
>
> The above is useful, but not quite as useful as looking at:
>
> $ pahole -C pcpu_hot defconfig-build/vmlinux.o
> struct pcpu_hot {
>         union {
>                 struct {
>                         struct task_struct * current_task; /*     0     8=
 */
>                         int        preempt_count;        /*     8     4 *=
/
>                         int        cpu_number;           /*    12     4 *=
/
>                         u64        call_depth;           /*    16     8 *=
/
>                         long unsigned int top_of_stack;  /*    24     8 *=
/
>                         void *     hardirq_stack_ptr;    /*    32     8 *=
/
>                         u16        softirq_pending;      /*    40     2 *=
/
>                         bool       hardirq_stack_inuse;  /*    42     1 *=
/
>                 };                                       /*     0    48 *=
/
>                 u8                 pad[64];              /*     0    64 *=
/
>         };                                               /*     0    64 *=
/
>
>         /* size: 64, cachelines: 1, members: 1 */
> };
>
> A slightly more useful variant of your listing would be:
>
> $ readelf -Ws defconfig-build/vmlinux | sort -k 2 | awk 'BEGIN {p=3D0} /_=
_per_cpu_hot_start/ {p=3D1} { if (p) print $2 " " $3 " " $8 } /__per_cpu_ho=
t_end/ {p=3D0}'
> ffffffff834f5000 0 __per_cpu_hot_start
> ffffffff834f5000 8 hardirq_stack_ptr
> ffffffff834f5008 0 __ref_stack_chk_guard
> ffffffff834f5008 8 __stack_chk_guard
> ffffffff834f5010 0 const_cpu_current_top_of_stack
> ffffffff834f5010 8 cpu_current_top_of_stack
> ffffffff834f5018 0 const_current_task
> ffffffff834f5018 8 current_task
> ffffffff834f5020 8 __x86_call_depth
> ffffffff834f5028 8 this_cpu_off
> ffffffff834f5030 4 __preempt_count
> ffffffff834f5034 4 cpu_number
> ffffffff834f5038 2 __softirq_pending
> ffffffff834f503a 1 hardirq_stack_inuse
> ffffffff834f5040 0 __per_cpu_hot_end
>
> as it also gets the size for each symbol. Allowing us to compute the
> hole as 0x40-0x3b, or 5 bytes.

If all the variables in this section are scalar or pointer types,
SORT_BY_ALIGNMENT() should result in no padding between them.  I can
add a __per_cpu_hot_pad symbol  to show the actual end of the data
(not aligned to the next cacheline like __per_cpu_hot_end).


Brian Gerst

