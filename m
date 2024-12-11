Return-Path: <linux-kernel+bounces-441434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B079ECE4E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906E22840C0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DE923A1AE;
	Wed, 11 Dec 2024 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lESLlR6L"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1828E23A19D
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733926185; cv=none; b=MkAAkjMiWCcr6jZvbNxjxybHvTPWcEPK/fI4gLZ1dd8srWxxHtAXLdC6U9yYH/bps/5cajUdKi/qDo6EUaQesqLOtomiF/WKusXi8/c8jidNy8s6MpipxRV6fWfFKubUF3I6Yg4s1IHMUhajYhV9OEZsjxz6KAlqgqm2reeecyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733926185; c=relaxed/simple;
	bh=yGF/cctnrxaftIwc3nmoT+49gK30u6v6P+AQjfZtHW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P7wL54ZCOkAsXZD7OfADOlNIIsF6T71puPmUS/YcS9csDWROMf3ZasNJi9v2rlrP/bCVhh3ocnbuQU0HKVcJXApi898At1FK0wlorVv3VLocqdBCJh2AXpA57RLaRf9OLL5avHlQ8EE6lsj3+FUf0Qmg3eBMMb4CVMc4Rot/xec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lESLlR6L; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7fdc6e04411so1573870a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 06:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733926183; x=1734530983; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yGF/cctnrxaftIwc3nmoT+49gK30u6v6P+AQjfZtHW8=;
        b=lESLlR6Lfp9O6QX+wHpf1LMwwz3N/Sw0juG/0Rm16EYttmhcxIZQm2tXG0YGRjB1ov
         FmqKvUJfmi9yODOTBFdeV1AxuXVYJcXqyvCuje5Ajt3Hiz4fsnv6RIn40vzhN6QeM4xy
         MK/u8ZF3b0WDbdI1KFtU4qH2UbR5d4ZHgRAbaRQrdeuWebfBde2SCOBUJ20QiVhm/DAO
         NIYdUJMob/0UP9zI+wEYQaLKZO9GKFKt8whid6zpEEjJMTmBYbVmWk/qIz3YosS+zMhd
         Z2lXHIgMWaLmAw19Eww4B0a2mAldFxz3mAznybd5iSkhf5sr75uL3BrG+lYdxPTJOQcP
         31Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733926183; x=1734530983;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yGF/cctnrxaftIwc3nmoT+49gK30u6v6P+AQjfZtHW8=;
        b=TsjBi5SD/YKtHvQvaP2HoUvxm4F/tQbHpYCK0KlrBwnj9Mls5WI493L+pHOKxnAxpB
         TslZSmXTF/v+4lQAakcrZps5vMVz66OYxOYHi/kmrbmmCOo9iRIqDvqVokZWBeBC3LR4
         N3Ko4IC6svX/s9xMiphVj0hk5fPPLWFPR8wZ+ZxTGUXScJnwklxWOE8ixbyfKp3nPnzE
         adPRhs3sED7jzxa5EqLmEBUjKSewtxWScfpbo+co5fKyuYkAuP62BilYbe/CbamxGrnO
         ulCDYMzSxUJwlHKIUE7P7EXlkaVJ3VN9YJrm1tF+l6SUnmUrMRVM42qM3bxuivXw532t
         peZw==
X-Forwarded-Encrypted: i=1; AJvYcCX/7U6LkzHE7DHzewkLDSPXwGOSV/KwsrqojrICibLo3iRL/49kJKpmWcrO0Vz8rwoyoy2db2svI98sbVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1xut6m3tcKbm90KxLa51Zz/QcnhxrIlQ21fPaVFTJAWMxq4XA
	pTvLoI4hpWOPHOvVLvJdpmLficCITfyoz4YASNBcyNR2+qBMuvv3aqO2kFKwrl5YbvQkpfrdzDl
	PVwOQQI7H+q+/mdUC2RWadRLwYm32nPwtl6kW
X-Gm-Gg: ASbGncvLPW2UplHSI7Q5aodv1He0C8GXJ8ex5KHSDVaIojzFwnXQPvi5+fSLnRZE32h
	0o2WnClaEIhRIMPubl8CZidIcPskG+oDhC1HaIvwSLN+26m3BpOSpDqtGCTewyX8X
X-Google-Smtp-Source: AGHT+IHqS1OA57lW5N9YWoHW0GGY0qd5ee2DbHypK0H+lRuShOCs4xM28yOMM64UdafTscYxQpAedve0D9ZOGO/euDE=
X-Received: by 2002:a17:902:f60e:b0:216:2bd7:1c49 with SMTP id
 d9443c01a7336-21778535677mr56186705ad.29.1733926181789; Wed, 11 Dec 2024
 06:09:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108113455.2924361-1-elver@google.com> <CANpmjNPuXxa3=SDZ_0uQ+ez2Tis96C2B-nE4NJSvCs4LBjjQgA@mail.gmail.com>
 <20241115082737.5f23e491@gandalf.local.home> <CANpmjNM_94fmQ025diHd9_vKtRxtDbSYaOpfBbshNQYEPQmHZw@mail.gmail.com>
In-Reply-To: <CANpmjNM_94fmQ025diHd9_vKtRxtDbSYaOpfBbshNQYEPQmHZw@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Wed, 11 Dec 2024 15:09:05 +0100
Message-ID: <CANpmjNMmUTuim5PYgQ-=Fk_bjz5tbxm+xbenzsnjXWmqu_04MA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] tracing: Add task_prctl_unknown tracepoint
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Nov 2024 at 16:06, Marco Elver <elver@google.com> wrote:
>
> On Fri, 15 Nov 2024 at 14:27, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Fri, 15 Nov 2024 13:00:00 +0100
> > Marco Elver <elver@google.com> wrote:
> >
> > > Steven, unless there are any further objections, would you be able to
> > > take this through the tracing tree?
> > >
> > > Many thanks!
> >
> > This isn't my file. Trace events usually belong to the subsystems that
> > use them. As this adds an event to kernel/sys.c which doesn't really have
> > an owner, then I would ask Andrew Morton to take it.
>
> Got it.
>
> Andrew, can you pick this up?

Gentle ping - many thanks,
-- Marco

