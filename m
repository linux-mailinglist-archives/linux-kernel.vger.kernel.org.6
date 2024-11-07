Return-Path: <linux-kernel+bounces-400208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0D79C0A57
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D77F21F2330D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017ED213ED1;
	Thu,  7 Nov 2024 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tcervsqd"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207FA212D07
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 15:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730994455; cv=none; b=RtBnRN3Rm5TTxwHep20dHaF4d+okyg+zfrxTIsPiJjR7kEAAAT6v7CMfNWjT7Qqf1QEw4nHz0zNnJ/pGS6A+MBsXVgwJGRzuEfO3fPjk7WuqS6G4JOvySjUTALR8oO2v9SuxeNqdOp2zRndBymeMFY6X25moa/7tM0y93vU10ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730994455; c=relaxed/simple;
	bh=q7aUlAO5/MOpZSfzW9v1JQwkZZ72douVaDPqh7khpB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mFZNCt+2T4kbA49VyJXLgIFvir80RIkGuLokkYyo94SpFbEMxDsSUds0k1ezkLsmtTo49pmV+0+T6w9GYn5oSZoHDthNUvTeMSWhGOGUjn7GaEhTts3n58CBLPGycfeoBl+4gBUCb3b/2OICFlC9jtsyEImIRQxSbqISOzGbdl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tcervsqd; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e3fca72a41so910246a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 07:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730994453; x=1731599253; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bj3vIwGn1S4kVdNYQ6mNujveZuFRmeI++CpgKvIkmVg=;
        b=TcervsqdleEspdvmxOaxBRqJoan6xcaDI0vhHb5FRcuSZy1430Zyi6uIUbCCif/6Lf
         aS0zTzYwA7WFORLEFHplVLjA5u0+2NNgf5+bfQ7bcDDA0GrgjoEFoHGh4zSQgifU7KsS
         eN6ZfaJlMzWEQUGhpJ4bResGBObaOax/U810CUnQgXn8qP1ts+KJvjLeq7yAyBIt1yqI
         iCDoLVRQfptB5em2uIqf46hd5wJS8XMbNKlH6uuQU/aNn1R5ofoNViFDN8iWXLGxVI9t
         KDrdeicEPJ3ndGeFwzOfRcuWuZpvKar1R3eSd9yWYWXoZTy5FnSWdwyP9KnGNGtWN35D
         cuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730994453; x=1731599253;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bj3vIwGn1S4kVdNYQ6mNujveZuFRmeI++CpgKvIkmVg=;
        b=j4apUlyizKPPHL+K2Fyb2xExFzmbI8tflGpmAtLfNYyEIAO+laG3uEZjCOlbze6c1I
         +WthFbtoQNI3viVQQsX+kqRGi6EBWWUYymG89UVT4b/7f3QAlT3Tk6o48ECPTn1Q4ZB0
         edNV4qY5WaPrTkbgX1Hbua3wd4QZepd8sL1jlqT+DmW++7WNJN9ixG2Gya3EkIO0+RBO
         YRE5BDQszPQx+I57bsVgQIVY7XWGgRM42lxb9xoayE2DXCg5tO8fW8kGlPW7m+tH4rxX
         LAS6jxX1cNPI387NGTvFdmeFBEcoL9cEAweW+1i/bF4bX7jb1QJzJ3lNusGmzj65T/oH
         BhQw==
X-Forwarded-Encrypted: i=1; AJvYcCWF+R5dO4aQb70Ej2KEAKbTk2dkHSxpl3ufLckXh/EtuoDEbRQQoDPNzmjOnyhCn1M4trF/VR7bU9YeCYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0IGcWJoSsyzy3yjL/mQh9dE5wpOB6KukJR43O3HhBR2W+cU3S
	7y37PcNUix4sYZR+pAj3+yzFJNOKOxZg0xFcAT2xkPIi72OdZAo4UMIXxAUwHfZzyRkdxcaN2ob
	Yp3HCqIx/2I4/WqM7PEyvb88asL+MGhvB8bjZ
X-Google-Smtp-Source: AGHT+IEV29w84+mA5Ghb6DvHqpfh07MhHtO765NcSIgHHok0eidtFkdF8cvUmAonUflKYsr5KtQ6Wv9RdfNBqnD42JI=
X-Received: by 2002:a17:90b:2249:b0:2e2:e743:7501 with SMTP id
 98e67ed59e1d1-2e9afbd3778mr526668a91.8.1730994453173; Thu, 07 Nov 2024
 07:47:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107122648.2504368-1-elver@google.com> <20241107103410.44721a3d@gandalf.local.home>
In-Reply-To: <20241107103410.44721a3d@gandalf.local.home>
From: Marco Elver <elver@google.com>
Date: Thu, 7 Nov 2024 16:46:57 +0100
Message-ID: <CANpmjNPiFxkZ6HPXYR0Xz0i=0p-ksEH4tC19fsj1fAwP1XkAjw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tracing: Add task_prctl_unknown tracepoint
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <keescook@chromium.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Nov 2024 at 16:34, Steven Rostedt <rostedt@goodmis.org> wrote:
...
> > +     TP_PROTO(struct task_struct *task, int option, unsigned long arg2, unsigned long arg3,
> > +              unsigned long arg4, unsigned long arg5),
> > +
> > +     TP_ARGS(task, option, arg2, arg3, arg4, arg5),
> > +
> > +     TP_STRUCT__entry(
> > +             __string(       comm,           task->comm      )
>
> The question is, do we really need comm? From your example, it's redundant:
>
>   test-484     [000] .....   631.748104: task_prctl_unknown: comm=test option=1234 arg2=101 arg3=102 arg4=103 arg5=104
>   ^^^^                                                            ^^^^

Ack, let's remove it. I will also remove the "task" argument.

