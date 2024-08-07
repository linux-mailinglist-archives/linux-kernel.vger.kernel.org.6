Return-Path: <linux-kernel+bounces-278168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B71794AD84
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D21E7B2E4A5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7471F84DE4;
	Wed,  7 Aug 2024 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TeuRPo18"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3228212C522
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723044829; cv=none; b=Rn1nKpl/gqcJsvo04lxKOltuhhkENkPrW6KI7BsyAfJRK5dNk/6dyQ1Nhw5ZO/cdrw+j8bmT6gABOdGPHF+qpK1p0y5JFbdbjsRFm4bK0RYkMm852MAzEGHleTu7vo+NzRi2ARrsQ6q/LCU2ymc5MmdBBCRxwZkH4T57+V+I7Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723044829; c=relaxed/simple;
	bh=GJJ6/4J63aPzip8F3qmZkagOt3HQBmrPhv3cmrweDFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=At6RVLpF6/C+79InoyeW6YIE0VH4FF3ckuYE1UEvoz1iaGj3m5Ff2qxiaSTjKTVapk+NuiwgMqkYA4+1JxTw8b46sYOn5VLRD1OVjBFX1wzsaxAwIiRh2ecKS9JDacf4nN8prfHUbZ+inwkfpohyKD55UiQe+EgDA7bmYjaBQQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TeuRPo18; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6bbbd25d216so5462946d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 08:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723044827; x=1723649627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJJ6/4J63aPzip8F3qmZkagOt3HQBmrPhv3cmrweDFo=;
        b=TeuRPo189UPeBJcfUFNEcChlYCN/U3x9Wp+dAlIMF2vbwR8JngjWPMCd+W7Ui9o16D
         brhjmBY3QqHIwc56WqnrsajMLAwhTj3FaRp4HaKZ5bbCcU5o0cUP5QBHRoXRV0zM+btU
         KMtC/H0SBlYn5y7nD5ejio1X5vezxuJYHamlz0UTQq9HZW8B7F4kAWpZGUu+JC1fgT30
         nlK6ilQTU1Us0W32pqXtdgEN1l+pgKf3O/1KXeAdPvQ7+wlPVYM0P5eKYYPila/QHZ2B
         nce9O30z0Bnh7UQgKRMFNAsW9Frgu4IYt2a/yZsh2KulBMYFWsX3o2oKEEQwR8iBi8dR
         NeVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723044827; x=1723649627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJJ6/4J63aPzip8F3qmZkagOt3HQBmrPhv3cmrweDFo=;
        b=HileJzBN7OG2rXbcj2KhbzpygmJmufpypg0/50eYA+1bBwrR1oYSvIIlURtHWCdeGv
         eS2yTw/gECowpfp5UnAP1pbYIqXEXE58Gb6jD7wp73z27sx1+BB4sXDfH0oLYybRvuU0
         QEbNt/CDnxNnG48/HGP3KXvPxsr/K68wgqZ3LGnyDyf5BgC3tbhGGHS8JSw0v9W1okSW
         ecLQf0BY4uNJ82isffZTnagiRsQGpExSJF/b/Qk/6lDsBmuZH/qq9ymms1SU+Nl3VCVZ
         YWOl14/rnjcnfCFfwM/8b0vM7vbwPV1MoNP10aJKrDTcY82CaB9L/zxTXSiL0aqumZ68
         sZ9g==
X-Forwarded-Encrypted: i=1; AJvYcCVtbPyQMlf3lJIOcLCRLWV3DixmIa5bmUEN9Bb3h5vZF135vtKJYm6jM/7k9Ex8cNP4IKPbey/7cFhdmC8Zr/tNLTCSOiRi6oaQufGO
X-Gm-Message-State: AOJu0YywS1tfFtwZyyLBcwymRC/dHuv3kwXr3JCnumqc7pwZ/McCSF6L
	J5Uvkki7xagdlqWrmkKkLiSzDoJhcAmXdL3zhIrdN6f/aOiZDwZ4P3D9lip38GitD6DGy92NgqB
	XWzPdVM98rXqiAAIiSo6waDtiZa7kQ/9Xmydt
X-Google-Smtp-Source: AGHT+IHvWa/Ytvp6xlpQo9w1vpfSyPNJKRWxay0t5bOW4D+l2HThaPS/mn8FuAJ+0xTb3yWOKivyVOA2NWpU5uN6aX8=
X-Received: by 2002:a0c:e6e3:0:b0:6b5:33c6:9caf with SMTP id
 6a1803df08f44-6bbbbdf4ae6mr44862646d6.16.1723044826883; Wed, 07 Aug 2024
 08:33:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802210836.2210140-1-song@kernel.org> <20240802210836.2210140-4-song@kernel.org>
 <20240806144426.00ed349f@gandalf.local.home> <B53E6C7F-7FC4-4B4B-9F06-8D7F37B8E0EB@fb.com>
 <20240806160049.617500de@gandalf.local.home> <20240806160149.48606a0b@gandalf.local.home>
 <6F6AC75C-89F9-45C3-98FF-07AD73C38078@fb.com> <20240807090146.88b38c2fbd1cd8db683be22c@kernel.org>
 <BEEE3F89-717B-44A4-8571-68DA69408DA4@fb.com> <20240807190809.cd316e7f813400a209aae72a@kernel.org>
In-Reply-To: <20240807190809.cd316e7f813400a209aae72a@kernel.org>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 7 Aug 2024 08:33:07 -0700
Message-ID: <CABCJKucdMS1hkWjHWty8JyACjZy2R9juusABcbsMYzNej=pB2Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tracing/kprobes: Use APIs that matches symbols
 without .XXX suffix
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Song Liu <songliubraving@meta.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Song Liu <song@kernel.org>, 
	"live-patching@vger.kernel.org" <live-patching@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	"morbo@google.com" <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Leizhen <thunder.leizhen@huawei.com>, 
	"kees@kernel.org" <kees@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Matthew Maurer <mmaurer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 7, 2024 at 3:08=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Wed, 7 Aug 2024 00:19:20 +0000
> Song Liu <songliubraving@meta.com> wrote:
>
> > Do you mean we do not want patch 3/3, but would like to keep 1/3 and pa=
rt
> > of 2/3 (remove the _without_suffix APIs)? If this is the case, we are
> > undoing the change by Sami in [1], and thus may break some tracing tool=
s.
>
> What tracing tools may be broke and why?

This was a few years ago when we were first adding LTO support, but
the unexpected suffixes in tracing output broke systrace in Android,
presumably because the tools expected to find specific function names
without suffixes. I'm not sure if systrace would still be a problem
today, but other tools might still make assumptions about the function
name format. At the time, we decided to filter out the suffixes in all
user space visible output to avoid these issues.

> For this suffix problem, I would like to add another patch to allow probi=
ng on
> suffixed symbols. (It seems suffixed symbols are not available at this po=
int)
>
> The problem is that the suffixed symbols maybe a "part" of the original f=
unction,
> thus user has to carefully use it.
>
> >
> > Sami, could you please share your thoughts on this?
>
> Sami, I would like to know what problem you have on kprobes.

The reports we received back then were about registering kprobes for
static functions, which obviously failed if the compiler added a
suffix to the function name. This was more of a problem with ThinLTO
and Clang CFI at the time because the compiler used to rename _all_
static functions, but one can obviously run into the same issue with
just LTO.

Sami

