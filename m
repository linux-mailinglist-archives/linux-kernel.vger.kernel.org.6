Return-Path: <linux-kernel+bounces-527775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2D0A40F4F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 15:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E08F7AB1AD
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 14:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC85E20ADFE;
	Sun, 23 Feb 2025 14:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdtlO2PH"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDEF20A5F5
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 14:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740321907; cv=none; b=O2nPeZ7vBM17ivW42GsAPdTWP2hfZFklymBcO1iB4hygbWb583jSIL87kpElIrJFbluWhcW/bFr/UzWibUAvaWXebCNqfYUSPL5UsJVeMK0K4sOkpEuwBOyJG/h/k2VgiJb0pXbhxUQ1rjPZ+M+E6B8zy1HgVTEP/o+foL166sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740321907; c=relaxed/simple;
	bh=KCvFSfbXuuk2NfmmXOxmKnzDjhQsuXaY2hM26uGzYkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1jhqv87drqpxP1XKZpjyHzO1ZzXaprC4ubhSUTjHdkFCX9CY9KHL25pOe2IK5TY6Tvq3JCM/1+JHJP3YEKV00QoRIpiWM+ATPTiGFPLu8240oHb0nO9eKSLkAneJNddUUJMQ2fecbG2dJgg8iJrzL4bN6wr0up2JaouOrNha68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdtlO2PH; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-548409cd2a8so1598467e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 06:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740321903; x=1740926703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZQ/pYcxKqmJJLaz6nWieJYY0uc2oAa28bc818bAdYc=;
        b=hdtlO2PHoV2JYFeEopZmKrTqxwetFv4yPa2jMdQMxSr1s2Ec3KZrd2gJFJqvyapB2K
         RbFp55zsgEW9tJX7pkfMoBH9WFNAU1zN7p6QE+mwt1GGylsnTcOWnfVN3+daY4Z8nwlI
         6eIHhEry/gwk20CCroNdiNVQSSoc/TlZjeeGiqwutGMUb7HWMRO+jhRdkiFpqrm9XE5E
         9S56ukvB4wIaymSyQlsyDLFy7dTec9CwSKlAR8mPzdyKGFovbmG00c8y2ew4drwRCNP8
         lkobbCz0shOUygOuqoxYAV5OPL5mwDqb5WMhSddowIOU/eiXKSAnCeu7yNuwjEzW8saR
         pBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740321903; x=1740926703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZQ/pYcxKqmJJLaz6nWieJYY0uc2oAa28bc818bAdYc=;
        b=kgBhO8+QOE6cIU1MqXZoMRdO7G8V6iJazzkzRPSJ87DxB5/V2XnKuEaQYJcz/lN9nB
         62ZGY5INg6ABgnVCWjuKSsJlhBz/g4dwaSF/iQlFdSZ7PL44t4Z0yC17D2fi19BDTeIo
         xdtqbhRN5JPd3ubcSsfL7ztD7C3XC6Er8sIqRxg/bZix+8yGW/ZMByF9q6e1cpajQq9K
         5LUZEz41JLNJ2wrXqFdpeHRiJpyYm3FN17+twefKe/n3dGXhydBWQa2u4cegnMCZGxBt
         6WivNdj6Wz3nUzI4WyfgkMzV3d/8JyujnoWILJSa8qKQvAXDUdqz4R1/lDHkuQFe7Amj
         1D1w==
X-Forwarded-Encrypted: i=1; AJvYcCWoDxNLbvhopHdwNjtxNS+7bFk9Ug+ws/obThKHeoB8fIquv4cpC6Trwl0E6pJXJCs8gGX8kqgSvelywSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWh5BV1ef6z4kBcLoXGVEB4IGWoLqpOjSesYJYPpNwHZHIIvco
	tiw8c8713tkQ3GfsqwnOCixNRabGxHv645WsEQPDja+Z5wk+eUN7j6Ec3Ty8b4UBvjqY9P7Sk5I
	0dDq0kkj+H7MeueuR9oN4IL7UOg==
X-Gm-Gg: ASbGncstg2kV7v5JD0A94sc1rHfS+8A0WOF/c+S0Hhigx27Psvd5UG2eO0w0ttHR3xu
	MXcXf+UmL5sC9d5a4l4GtraqXRpWlspA2tQXOGxzrB3epIrr8EMEobxlUuS0pfKv7YyZm4UvWPZ
	DglYB2MK0TexGDNASQvFyOMg==
X-Google-Smtp-Source: AGHT+IGymWnqqkvYgc1vIgfMax9UD+YvhxjLTidAEBOwUAy4VOIHXaHyFIPpyJHqez6mDi3wQAJAEL9nSBfrFPyWMVg=
X-Received: by 2002:a05:6512:4019:b0:545:ea9:1a1f with SMTP id
 2adb3069b0e04-54838ef8a08mr3123306e87.25.1740321903150; Sun, 23 Feb 2025
 06:45:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222190623.262689-1-brgerst@gmail.com> <Z7rsOVaxhfCJdn2P@gmail.com>
 <CAMj1kXE51FSYQ6prL7M5vfy1KjJGiBAre3CH3G-L3CQj9YSq9A@mail.gmail.com>
In-Reply-To: <CAMj1kXE51FSYQ6prL7M5vfy1KjJGiBAre3CH3G-L3CQj9YSq9A@mail.gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Sun, 23 Feb 2025 09:44:51 -0500
X-Gm-Features: AWEUYZmrWmxvEXO1Q4u70dIJaXCUd-mdV0K5iP2qX_xCeAwHJDiaGVlTEp3H1IQ
Message-ID: <CAMzpN2geum53f3nRn0MNBtA3trU5-350XhDeDLs+kx_GC7fKGg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/11] Add a percpu subsection for hot data
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Uros Bizjak <ubizjak@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 5:20=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Sun, 23 Feb 2025 at 10:37, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Brian Gerst <brgerst@gmail.com> wrote:
> >
> > > Add a new percpu subsection for data that is frequently accessed and
> > > exclusive to each processor.  This is intended to replace the pcpu_ho=
t
> > > struct on X86, and is available to all architectures.
> > >
> > > The one caveat with this approach is that it depends on the linker to
> > > effeciently pack data that is smaller than machine word size.  The
> > > binutils linker does this properly:
> > >
> > > ffffffff842f6000 D __per_cpu_hot_start
> > > ffffffff842f6000 D softirq_pending
> > > ffffffff842f6002 D hardirq_stack_inuse
> > > ffffffff842f6008 D hardirq_stack_ptr
> > > ffffffff842f6010 D __ref_stack_chk_guard
> > > ffffffff842f6010 D __stack_chk_guard
> > > ffffffff842f6018 D const_cpu_current_top_of_stack
> > > ffffffff842f6018 D cpu_current_top_of_stack
> > > ffffffff842f6020 D const_current_task
> > > ffffffff842f6020 D current_task
> > > ffffffff842f6028 D __preempt_count
> > > ffffffff842f602c D cpu_number
> > > ffffffff842f6030 D this_cpu_off
> > > ffffffff842f6038 D __x86_call_depth
> > > ffffffff842f6040 D __per_cpu_hot_end
> > >
> > > The LLVM linker doesn't do as well with packing smaller data objects,
> > > causing it to spill over into a second cacheline.
> >
> > ... now it's linker-ordered. But on the other hand that can be an
> > advantage too: the linker will try to (or at least has a chance to)
> > order the fields optimally for cache density, while the hand-packing
> > always has the potential to bitrot without much of an outside,
> > actionable indicator for the bitrot.
> >
>
> The linker will need some help here - by default, it just emits these
> variables in the order they appear in the input.
>
> If we emit each such variable 'foo' into .data..hot.foo, and define
> the contents of the section as
>
> *(SORT_BY_ALIGNMENT(.data..hot.*))
>
> we should get optimal packing as long as the alignment of these
> variables does not exceed their size.

Thanks for the tip on SORT_BY_ALIGNMENT().  That got the LLVM linker
to pack the data correctly.


Brian Gerst

