Return-Path: <linux-kernel+bounces-339444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB81986528
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5A71C24A17
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8DC8175F;
	Wed, 25 Sep 2024 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D3itmCFt"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B3956458
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727282812; cv=none; b=KO1PzZFTBReQq9fvd5YkIp4ZsCf2lYqfysRmHXwlknFRsU45K/CKg0FYHA6nKe/MuY3/KWtOG34xrYV4haOFZhpuP4dDuq3adkamVicZx7ovBCP6zM8I5Yoyc/eQK+QWwrAAHVjwxw7QRDdrg1jaAmJS1+SSMP4hilrdF3IcAGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727282812; c=relaxed/simple;
	bh=/t+YSp2gvbsBW9hsAIIEsn2fOHY2XQVupxHXFI22op4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KX5P51S2VzWxTbq20d+ctU97lHid/wPIiT8giLllpwB1ENSuRZzcrhXaNWEPp5l3/vhuhjlmcjmU/yNxINlJZ8X9NcuiY2Ph9mfvWYlO0xZz52LhFLi6+CYEpvXOnuHO0ARAuW+WLfDAoprtBR00Cfhc2YhhlkEBps/cCwJfRls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D3itmCFt; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c245c62362so8510109a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727282809; x=1727887609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nj8+qG2S/Bk0hHBrSluJoVQqRkgSfLVqxLrwhmmQqfQ=;
        b=D3itmCFt0NbiDtjnANA1y8nJAsY3HwcM8uu5IfRxr9woHg+xqYHV3NfbRKd0COdOV0
         UIjxT7WYJEkv5IHiQS/ueRLFOkDqIZ2NbWdj7XHNPsDCIMXwBPsMMB2i17/eVuLkYdLe
         dUG/ZGBJUK1tdVCYiejavYMV3RpwPSrxb5ZBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727282809; x=1727887609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nj8+qG2S/Bk0hHBrSluJoVQqRkgSfLVqxLrwhmmQqfQ=;
        b=W0EShkIaQ9zAX7aj6Nb3sKnwr3yrYbEu8/YiFEoB2tipfPu1KEWYTbCxNMHNjUvZDA
         cBNmaNwj7JM1S+Aep9a7zGy4pt7XCSdWwPnmkTrQgCZMQ351e8dYhHxlOlLxv+yMcQaK
         hkVNgUDOeYCnNuBroPnIMTetQ6hIivLnzcGYLXg3lhSihqFeT+oi4qpsnkyLvQfVO8vM
         IyuZIrE0xWbhFAUo9CkETr8aDFI07HRYLNTiZEtWvusoHPhriigH+RBxmSP6RPEnTBou
         7ezokuZ+UHVnm8gMRJtnxWRmjj+2E8z0CjS14aOXEcQyj1YbCF1s5IWBnjUQKf2k6JF4
         9R1A==
X-Gm-Message-State: AOJu0YxO+8lNEhTpHFJE49k5oEyVpD+/jYRdzjF2/uFssqFgvkPOT9bp
	G4Vd0E4f0FTBArI8MorNASnd1Em8L2xrsB28QWBs8dsGmO8bSnE8qs2VcFaT/NQpXgurc3PJNn9
	CTOj0sA==
X-Google-Smtp-Source: AGHT+IFuJIOMSAMbFwtw9bgt3zJhHd2NLPTzmboMH9VPVERbT6Sl3k3PZEiliLKkcaDBqssFYmffPA==
X-Received: by 2002:a17:907:e682:b0:a86:b762:52ec with SMTP id a640c23a62f3a-a93a05ebf35mr273622166b.51.1727282808682;
        Wed, 25 Sep 2024 09:46:48 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9393134a97sm229810566b.207.2024.09.25.09.46.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 09:46:48 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb8dac900so68410955e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:46:48 -0700 (PDT)
X-Received: by 2002:a17:906:f5a9:b0:a86:9d39:a2a with SMTP id
 a640c23a62f3a-a93a0330c37mr309689066b.8.1727282382886; Wed, 25 Sep 2024
 09:39:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com> <20240925150059.3955569-44-ardb+git@google.com>
In-Reply-To: <20240925150059.3955569-44-ardb+git@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 25 Sep 2024 09:39:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiLYCoGSnqqPq+7fHWgmyf5DpO4SLDJ4kF=EGZVVZOX4A@mail.gmail.com>
Message-ID: <CAHk-=wiLYCoGSnqqPq+7fHWgmyf5DpO4SLDJ4kF=EGZVVZOX4A@mail.gmail.com>
Subject: Re: [RFC PATCH 14/28] x86/rethook: Use RIP-relative reference for
 return address
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Uros Bizjak <ubizjak@gmail.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Sept 2024 at 08:16, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> Instead of pushing an immediate absolute address, which is incompatible
> with PIE codegen or linking, use a LEA instruction to take the address
> into a register.

I don't think you can do this - it corrupts %rdi.

Yes, the code uses  %rdi later, but that's inside the SAVE_REGS_STRING
/ RESTORE_REGS_STRING area.

And we do have special calling conventions that aren't the regular
ones, so %rdi might actually be used elsewhere. For example,
__get_user_X and __put_user_X all have magical calling conventions:
they don't actually use %rdi, but part of the calling convention is
that the unused registers aren't modified.

Of course, I'm not actually sure you can probe those and trigger this
issue, but it all makes me think it's broken.

And it's entirely possible that I'm wrong for some reason, but this
just _looks_ very very wrong to me.

I think you can do this with a "pushq mem" instead, and put the
relocation into the memory location.

                 Linus

