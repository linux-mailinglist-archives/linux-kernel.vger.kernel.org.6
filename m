Return-Path: <linux-kernel+bounces-339639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EADD986845
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 23:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7FC1C215EE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 21:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF50E158527;
	Wed, 25 Sep 2024 21:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fB/1Gm+h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531C51CF93
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 21:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727299434; cv=none; b=ggvt7oi1T7adD2AidRdJEonolWDA4DdqPlV8CCCGL53eCUPTSbEM/SAINYYsDTB7H58rFPaqiHaP+ec6NUKhb/6CkgWz4SyBeB9OTYsVrAMTQCjDdo1eH2ikp6YYGfxZkdHN2PZ3ljBjBvEHT20yICFYu9Fa85Vn9/a8FOG7ByU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727299434; c=relaxed/simple;
	bh=GNcLS+t/yWECu/DorSX14DmIKwRsgwQvybW6GYxqxbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6CCEweyNISZqq/YxDQCQnwjoEciA1F7MfPhkKg0vTRPHR6grIitvg3rowbc8WsvgrRaERW1+NQRzZYJl+U0HFOr467oszrpQhkA57wGgbVxEAExmHaIu1bnxAHI4YG3gk0BD1abNqgsalDTsKGCBQ8h/QZOh/RrnPjynDTjhWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fB/1Gm+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D9BC4CEC7
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 21:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727299433;
	bh=GNcLS+t/yWECu/DorSX14DmIKwRsgwQvybW6GYxqxbw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fB/1Gm+hPI/PgfKYRMgAFcQae00ciP/RHimreFuXrzrm5RytLCo7eAxhrZgYLXBws
	 DR4GFDBCEeRv5DuoxSRN8f7nmz6gPYXESWwq4dgHMi+aBqx1Qr3Xh2sCwqGjURFsZd
	 Vy/GBbEnNpncAe8jMm1/HsydcaZ0fi8TCYZlBH/iqqqe6qML+GwoSwjZhwD+9OLcXF
	 VDpQbZgMHUK88/hDkkqJp9m+uoeOH9RrWBuYyS8ACxAiGtUsGxQWDn6OCssogzKCzP
	 REl++MR/qrPDeoKrsYRCpnxDOlQGI2IpsCwmeKsLbHU/hl/t52sedU7HzOEF5/UaO+
	 GxHTlUxBQlXAA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f77fe7ccc4so3485991fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:23:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+AX+nY80RcbEk2ieMvP21odeFBpvxHeZWzAlGYcObenX04K5IQnNW9hR9kNQ0+FRJP+6Le+bYjtClumM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyozfC1EYBmxTtjAw0GevljQBNeaGs5QlGF7GxLXler3KjMb3a6
	M4GYaNdLIQZXiAfYqWTByhv5SY1myduWX9zzQFOmx4PCdnt2npFZ0usY7f86XR+LY5W+1zu39T7
	7s3zBWvH2UG6gjMVwqUA3InzyK0Y=
X-Google-Smtp-Source: AGHT+IEOYOSDd4CeY1O+BXdvMf6CZHyHqVL/JJmRDRBuAwW0SJ9hhLOpBklA2YKNE6lQtcxMLvwkegA0JhRWHDaPiik=
X-Received: by 2002:a05:651c:220a:b0:2f4:f22c:53d5 with SMTP id
 38308e7fff4ca-2f915fc273cmr29054351fa.8.1727299431665; Wed, 25 Sep 2024
 14:23:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-55-ardb+git@google.com> <87ikuj30g8.fsf@linux.intel.com>
In-Reply-To: <87ikuj30g8.fsf@linux.intel.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 25 Sep 2024 23:23:39 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEQJraatFuA1CVwQz6Uos-0LbVVyCa=FgkHgEAQBCn=TQ@mail.gmail.com>
Message-ID: <CAMj1kXEQJraatFuA1CVwQz6Uos-0LbVVyCa=FgkHgEAQBCn=TQ@mail.gmail.com>
Subject: Re: [RFC PATCH 25/28] x86: Use PIE codegen for the core kernel
To: Andi Kleen <ak@linux.intel.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Uros Bizjak <ubizjak@gmail.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Sept 2024 at 23:09, Andi Kleen <ak@linux.intel.com> wrote:
>
> Ard Biesheuvel <ardb+git@google.com> writes:
> > This substantially reduces the number of relocations that need to be
> > processed when booting a relocatable KASLR kernel.
> >
> > Before (size in bytes of the reloc table):
> >
> >   797372 arch/x86/boot/compressed/vmlinux.relocs
> >
> > After:
> >
> >   400252 arch/x86/boot/compressed/vmlinux.relocs
>
> I don't know why anybody would care about the size of the relocation table?
>

Fair point.

> What matters is what it does to general performance.
>
> Traditionally even on x86-64 PIC/E has a cost and the kernel model
> was intended to avoid that.
>

Is the x86_64 kernel C model specified anywhere, to your knowledge?

> From my perspective this patch kit doesn't fix a real problem,
> it's all risk of performance regression with no gain.
>

It's all in the cover letter and the commit logs so I won't rehash it
here, but I understand that your priorities may be different from
mine.

I'll provide some numbers about the impact on code size. Are there any
other performance related aspects that you think might be impacted by
the use of position independent code generation?

