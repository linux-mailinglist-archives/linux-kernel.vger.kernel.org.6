Return-Path: <linux-kernel+bounces-274267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AADF9475E2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8EF1F211C4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E317146A8A;
	Mon,  5 Aug 2024 07:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Co5xIP2I"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721741411E6
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 07:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722842349; cv=none; b=DMtOfFIS9uVHbMsoEBfDHC+eAQsFe3eJofMdSIibxCurQxmX/bUE5ZHZr5jM7Tpw9ZxdNbbPWxx8x2KkVGSm8roSWlffXgcIzpPIeRCWP0an1nYjq+4UU2+8AU5w0OTK/C/q9F+oBI6JubC/XscqjBdr2BCSBnRTn+YJ92RmZls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722842349; c=relaxed/simple;
	bh=zMmJ8ktrTwMea5U1Z5IODTqLwP7cx3P90FTapfFnu3k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e9vmjcdAJqGV6Oh35FH1gkfyHKkj9lNj6J5mCPzUvTT51cM/6YWgEdCtfGvuJlYfRD+r7NZSdG/HqIyOhetBsC5EBFobGFy1jYP1cwcn/b+hSXiEC50620LJMiGi1gsSvHKl1sMu6Mz07RUPpHJuJRrzuH8UMQaz/oevD32kFlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=Co5xIP2I; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52f024f468bso13920052e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 00:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1722842345; x=1723447145; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PAghwbxvtMv/5Gvz6bz02cAryZmdXtnmD6oHucjjd/M=;
        b=Co5xIP2IVU+zlLEW6WPBFgrr5VCqvKqp258DDGuXCiMMwrU7qn94agtEbHKCJl1DIx
         LUQ+MaLytuPAHcdAeWJDamXCsIynSCKZV7toK1oSwikHqhdGlzP6TcszgJXDQXfStPI5
         ot0vP6koYGrEhDyqzARq3Q3oTQ7oRSByWueLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722842345; x=1723447145;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAghwbxvtMv/5Gvz6bz02cAryZmdXtnmD6oHucjjd/M=;
        b=mxsrMjKJllCkYRccN9ES8Rv3MPHLcKvBjZI1Q9f+9o3MJsFr8gB4apMO9cfcXWXKI/
         YDliBJZRME50Bk6I7onKaHtf/Y9OudusFqfLkqJFqqnni7WnFh33MMTRPltU8qRsfkY4
         +xA07Qp+mZq9kZpHuW0yHxzAKeAX9QMeKuUXniQOgDeDjF3G4d7ggmFe/NwbX03xs/Ht
         6Qlh4xmFr7XZXPIaT8p6EGK+vfMVxjZ07wuQlmVL4jIjtxSgpR9nEvyWoEL/w9emSHiA
         SsYsuaM5quCl/NSjPBh369w9v0unmX2S4gP/dGQngaDRL1tzEFTuk9c/YxzXNcQsWPj6
         nuDA==
X-Forwarded-Encrypted: i=1; AJvYcCUlTGpD2D0tMOieT7nr03WuL850YX92fNXqJZio4YtbTvcWIJpyvXveZ3int0SwSzcDPa/HS5H6nqELrlCgTznPrnpnl3MoYd12j7j1
X-Gm-Message-State: AOJu0Yx4KBbXUNa8gtaO8MGC2zwnUjS3ZdWn+vN/HEK2p/ECjP/vp+uQ
	JyhUFctUttoHG/t3ut11CNN9wPAcorIK0hMOcHZD0rYNfPmfvm1JNcH5HppKk0tbNSoKRo1TvA0
	BMqEW3g==
X-Google-Smtp-Source: AGHT+IH2CgefOlrrG0Jk+mCoABmYlnZOsVswhHpVvZ2fmzhgKRKJqoiT7ebB1aDkwsTCg1L+ZFGhcQ==
X-Received: by 2002:a05:6512:3344:b0:52e:9428:c6dd with SMTP id 2adb3069b0e04-530bb6c7ca7mr6401380e87.59.1722842345237;
        Mon, 05 Aug 2024 00:19:05 -0700 (PDT)
Received: from localhost ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba07585sm1022533e87.5.2024.08.05.00.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 00:19:04 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>,  linux-kernel@vger.kernel.org
Subject: Re: build failure caused by RUNTIME_CONST()
In-Reply-To: <CAHk-=wiXK4cc8ikqN15vfi2+wsYJYh08qH8qzCpy+08Gh9whLw@mail.gmail.com>
	(Linus Torvalds's message of "Fri, 2 Aug 2024 18:19:17 -0700")
References: <20240802114518.GA20924@redhat.com>
	<CAHk-=wguPQZKfWdNjF8OedfttMNkrW57Kb5Wjv0NmTzoEbUG7A@mail.gmail.com>
	<20240802221014.GA20135@redhat.com>
	<CAHk-=wiXK4cc8ikqN15vfi2+wsYJYh08qH8qzCpy+08Gh9whLw@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Mon, 05 Aug 2024 09:19:05 +0200
Message-ID: <87bk27fndi.fsf@prevas.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 2 Aug 2024 at 15:10, Oleg Nesterov <oleg@redhat.com> wrote:
>>
>>         $ ld -v
>>         GNU ld version 2.25-17.fc23
>
> Yeah, we document that we support building with ld-2.25.  And I went
> and looked into the binutils-gdb repo, and it looks like this whole
> automatic start/stop symbol thing was introduced in 2.29.
>

Well, the basics of it goes much further back. ld/NEWS says

Changes in version 2.6:

  * When an ELF section name is representable as a C identifier (this is not true
  of most ELF section names), the linker will automatically define symbols
  __start_SECNAME and __stop_SECNAME, where SECNAME is the section name, at the
  beginning and the end of the section.  This is used by glibc.

but then also goes on with

    Addendum: Current versions of the linker (at least for version 2.18 onwards
  and possibly much earlier as well) place two restrictions on this feature:  The
  symbols are only implemented for orphaned sections, not for explicitly placed
  sections and they are PROVIDEd rather than being defined.

and I think what was changed in 2.29 is that some of that was being
relaxed again with commit cbd0eecf261c ("Always define referenced
__start_SECNAME/__stop_SECNAME"), which is what you find running 'git
blame' on the current doc text. But yes, it does seem that the 2.29
semantics are what are needed to avoid explicitly defining the symbols
in the linker script.

Rasmus

