Return-Path: <linux-kernel+bounces-444410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DD19F0653
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9D4168754
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 08:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9A51A8F7D;
	Fri, 13 Dec 2024 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnZZzUxu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA94B19993E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734078389; cv=none; b=JxXS1R3+V+xgdFYjBv7Q05zemUicdPVvHWCFy5oXH/SAiWo0Q0cVv1miiGt6VpidjUMvuv76YX8qQjBUwRuvrSvIhzh3UYMUeaaiaZvlkgbnh9+dYQHCm9aLCmv0xLONwWgxvLQZR/twck5TQLnRdOUrNMvJN5yJiLx6mdBW0f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734078389; c=relaxed/simple;
	bh=MyzCSzas+3pO50YUo43cy2noIiPHM/lKqgN7GeflZ2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8xQ52FXKu2KfAc1iabkqFbTXFfRz2J70FREj8+ZpPHoXaJhdv5lyIDCBsx4I/dxK/2QW/v17u8oX+Jij8S6E7iMwww+9EKdwkvVGUZdC9mJVsCvVx7K4qcNz0KFdPVp5oCbzYazyXpNfYl82jSIwpXjdA7IKPoL64c+mWZxg6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnZZzUxu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B27CC4CEDE;
	Fri, 13 Dec 2024 08:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734078387;
	bh=MyzCSzas+3pO50YUo43cy2noIiPHM/lKqgN7GeflZ2s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rnZZzUxuv+UHTqe9KOqxZvL6fddGxECYoWMLqpgSWJyHCHp4782ROqddM+D0s74W2
	 EHgIdwD7vAcp3kRy1ylav4Iu1jyrojiZ4pOKquGsvW/go3W2Y/Ov1jpBzA1HzGUR0r
	 u+hUuSNdsdyGfvkintTKdGpF18e3XquyhGHnd9Axw4TCQ7dGGpDOBzcLTGzzA3HhsG
	 +Rt5/pbGSylX5oO9ADzt7lcp07eOX5YNpjdE3V/PMOfamyH/mkrl059DtA0BoCoLIQ
	 2lMgL+/JaNDBffQZuCTq3h7bXaXk+TqlKKVO/6hr3KQvQB31B6MeclCmA/vr5rvr1v
	 oWmOoRIfzXlyA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30037784fceso13545871fa.2;
        Fri, 13 Dec 2024 00:26:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVm+jCpRJ1Dp4pq0Ub4806hWgCIqW3Imf2eYGryUhlqxDjsAHD6Lkr29UOVM+1C0sFpJLww46HIsg==@vger.kernel.org, AJvYcCXv7P6rxFprRe3rHmqYptMfDWaj+tKQTONr/nWDOVGPiVViwTsgaynSkcN1wyUsUaMbIZBlXXlVzXjLzKGw@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc3P2PkWezub5TQEfH8+3vdcF77kPXWHhv51BB/dG67R22kWZ7
	jg1yD/K1duJCKFvx+nQ8L+Ns5N4lxOGiEYtTsp86OQNrPBcN6VENxRhEbxoR6Ri5zrqPgDUTSBx
	N0nY76iRTYjztpD7dfuOh4tRbciA=
X-Google-Smtp-Source: AGHT+IHG/Qv2mrDmNDi2VehnKTnQ0OLfyW82xHerP4WoDxxA/je3nQ860VTOmHbJoMzPYM98V+mDWqXrXQxppXFbsEo=
X-Received: by 2002:a2e:a983:0:b0:300:1d45:871f with SMTP id
 38308e7fff4ca-302545669d2mr4741761fa.5.1734078385776; Fri, 13 Dec 2024
 00:26:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212082426.4110-2-shijie@os.amperecomputing.com>
 <20241213053049.7592-1-shijie@os.amperecomputing.com> <CAMj1kXF=1Hr9G4ZjnEVzJ1snn0V4L-=+bMU4bn=m0UbYLyBqGA@mail.gmail.com>
 <be0d7423-ca33-416d-a410-3ff303493261@amperemail.onmicrosoft.com>
In-Reply-To: <be0d7423-ca33-416d-a410-3ff303493261@amperemail.onmicrosoft.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 13 Dec 2024 09:26:14 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHXeiPiksuOabp-NXu0ORmmP1Jd1wZPmgAi09jsjaDAsQ@mail.gmail.com>
Message-ID: <CAMj1kXHXeiPiksuOabp-NXu0ORmmP1Jd1wZPmgAi09jsjaDAsQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2 fix] arm64: refactor the rodata=xxx
To: Shijie Huang <shijie@amperemail.onmicrosoft.com>
Cc: Huang Shijie <shijie@os.amperecomputing.com>, catalin.marinas@arm.com, will@kernel.org, 
	anshuman.khandual@arm.com, corbet@lwn.net, patches@amperecomputing.com, 
	cl@linux.com, akpm@linux-foundation.org, thuth@redhat.com, 
	rostedt@goodmis.org, xiongwei.song@windriver.com, inux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Dec 2024 at 09:23, Shijie Huang
<shijie@amperemail.onmicrosoft.com> wrote:
>
> Hi Ard,
>
> On 2024/12/13 15:30, Ard Biesheuvel wrote:
> > Hello Huang Shije,
> >
> > On Fri, 13 Dec 2024 at 06:32, Huang Shijie
> > <shijie@os.amperecomputing.com> wrote:
> >> As per admin guide documentation, "rodata=on" should be the default on
> >> platforms. Documentation/admin-guide/kernel-parameters.txt describes
> >> these options as
> >>
> >>     rodata=         [KNL,EARLY]
> >>             on      Mark read-only kernel memory as read-only (default).
> >>             off     Leave read-only kernel memory writable for debugging.
> >>             full    Mark read-only kernel memory and aliases as read-only
> >>                     [arm64]
> >>
> >> But on arm64 platform, "rodata=full" is the default instead. This patch
> >> implements the following changes.
> >>
> >>   - Make "rodata=on" behaviour same as the original "rodata=full"
> >>   - Make "rodata=noalias" (new) behaviour same as the original "rodata=on"
> >>   - Drop the original "rodata=full"
> >>   - Add comment for arch_parse_debug_rodata()
> >>   - Update kernel-parameters.txt as required
> >>
> >> After this patch, the "rodata=on" will be the default on arm64 platform
> >> as well.
> >>
> >> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> >> ---
> >> Add more descriptions for "noalias":
> >>    It is not a security feature yet.
> > Why did you add that?
> The following is the current status of "rodata=noalias" by checking the
> kernel page table in my machine:
>
>     1) the kernel code keeps read-only in both the "vmalloc area" and
> the "linear area".
>
>     2) But there is a read-only memory range which is read-only in
> "vmalloc area", but its linear alias is read-write in the "linear area".
>
>
> Maybe the "security" is not a proper word.
>

There is nothing wrong with the word 'security' as long as you are
clear about the fact that rodata=noalias decreases it.

>
> >
> > How do you envisage 'noalias' becoming a security feature? The point
>
> for the case 2) above, if its linear alias is also mapped as read-only,
>
> can we think it is safe as the original "rodata=full"?
>

No, it is not. Why would we bother with rodata=full (which is costly
in terms of TLB pressure) if rodata=noalias is equally safe?

