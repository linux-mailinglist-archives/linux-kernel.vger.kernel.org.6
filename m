Return-Path: <linux-kernel+bounces-512147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F38E9A334CA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 057FA3A6ECD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D7F13BC0E;
	Thu, 13 Feb 2025 01:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qj0U3Qt7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BE21A29A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 01:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739410645; cv=none; b=iDFuuyuRPWaIX9zQv9MVrJDwBNUoVPRM5nflWriI6PV/488WylROaHbIGymGjuyyl+j1+LV+qqA08ar2XydTC6ljL9vwQkmD1XmH453nDYZ+Hvq4n0j7W0aaVhQE8hknHiJxhvblYTi9WX7/MYgfQ2WlVFOS8h7lGUrG8+1O84g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739410645; c=relaxed/simple;
	bh=Bwco/AiV4Yy1TNgc5bJ5E/3Oey93Ubf5/8Oxw/CLoBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LvoyXhApX8V5qDqRQWfkRgD7vqbt6gLLilwYBGPi5SVaDv0qtzCeVTp3GYdMnNodlVqltR+zceb00Pichqu4VyfD84dTU1cZku6XanbHlQTivvwKgfVKum1M76yHimQ+kmB0s4my5b924OwWUNnkOaSfkQ3fabZA/rE3sspE4JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qj0U3Qt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB62C4CEF2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 01:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739410644;
	bh=Bwco/AiV4Yy1TNgc5bJ5E/3Oey93Ubf5/8Oxw/CLoBM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Qj0U3Qt7TIdVBOIy2dARS9ATQxF9Lt2ceJFE+CiqnX/6MxRmiEjHjfAv41ecG09f4
	 HmL6tejPvYjwFKBw14YKQ4A9h+TSqtnGjHXKQt9SlQXBN4PB2bbZl6gOZmqxoU0FGH
	 Eb1JnvLif0zA7c1zJd+4xvaavE8QYV2+gqFwDUTKBFQYOKEFsAjIfJFwbm9KCYW005
	 ObTuN/BSsoFpGOfGvsSeqqA+jRcMU6vqXAOBc28ImOhIqXaQDfk0uHqWiMBsN6Oiu/
	 lyagSsQ0HW3KvVMUCR/5vV5auktAiHWo30s7gVZe9zB7HUlNNAHDi6eqFyDPzBN+z3
	 DDE9JfxpHBrhw==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5de4c7720bcso440425a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:37:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXAy/yxDnc4lq3uNjSFT1F7Rrb8Cutoh709aKxCnIatso4E4mF6ItD/6ci8fDIFynmHSs7zh4gxj1SKnK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAE8ST9Rt29yJSxtv0sdWVpdmpemv9e8GSZoJtqs6kUD2v8/7k
	aFvb6FUezgKjiF5sIM5tr1Ub7b2MZ3jgI9pxDmtngYcqYw6yLqV+jkO0PGhDu5Zqg5Nou3ZbnO/
	7b12GNQb80Llb0LHWl8/+r4euU3kh8sWLeNjK
X-Google-Smtp-Source: AGHT+IHrRmZGNKj6SKbc2vsBo+CfEBVwP7ahr/Z3P1cvWdrrj5ObptFzksenA6TmrSxkztwvaFdsYDnv7IBKY19nFwg=
X-Received: by 2002:a05:6402:2713:b0:5dc:1395:1d12 with SMTP id
 4fb4d7f45d1cf-5deade00f14mr4307707a12.31.1739410642935; Wed, 12 Feb 2025
 17:37:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212220433.3624297-1-jolsa@kernel.org>
In-Reply-To: <20250212220433.3624297-1-jolsa@kernel.org>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 12 Feb 2025 17:37:11 -0800
X-Gmail-Original-Message-ID: <CALCETrVFdAFVinbpPK+q7pSQHo3=JgGxZSPZVz-y7oaG=xP3fA@mail.gmail.com>
X-Gm-Features: AWEUYZkwGWDXc2KRfD9SGVb_wg85JPI9qm1E9VBHeitfeSbVcxq25huc3E64bh8
Message-ID: <CALCETrVFdAFVinbpPK+q7pSQHo3=JgGxZSPZVz-y7oaG=xP3fA@mail.gmail.com>
Subject: Re: [PATCHv3 perf/core] uprobes: Harden uretprobe syscall trampoline check
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kees Cook <kees@kernel.org>, Eyal Birger <eyal.birger@gmail.com>, 
	stable@vger.kernel.org, Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org, 
	bpf@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>, Deepak Gupta <debug@rivosinc.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 2:04=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Jann reported [1] possible issue when trampoline_check_ip returns
> address near the bottom of the address space that is allowed to
> call into the syscall if uretprobes are not set up.
>
> Though the mmap minimum address restrictions will typically prevent
> creating mappings there, let's make sure uretprobe syscall checks
> for that.

It would be a layering violation, but we could perhaps do better here:

> -       if (regs->ip !=3D trampoline_check_ip())
> +       /* Make sure the ip matches the only allowed sys_uretprobe caller=
. */
> +       if (unlikely(regs->ip !=3D trampoline_check_ip(tramp)))
>                 goto sigill;

Instead of SIGILL, perhaps this should do the seccomp action?  So the
logic in seccomp would be (sketchily, with some real mode1 mess):

if (is_a_real_uretprobe())
    skip seccomp;

where is_a_real_uretprobe() is only true if the nr and arch match
uretprobe *and* the address is right.

--Andy

