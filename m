Return-Path: <linux-kernel+bounces-294218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC35958AC3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D443B1C21A4E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FF21917FB;
	Tue, 20 Aug 2024 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DQ5NuEF0"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD30318E37F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166684; cv=none; b=FTIg+WLueetFZ2ugnTCpiJTytXhtu74SQcUscPsntEUrOegpSN6vXnSfWUhPohRQJqQfFtHn8fTGynwKTYdChMwUE63A+WLmQFasEfDRKwXvIzzSUqgLFb/7L5H+ed+V/GQx/1s5b/Sr0G948eVfdsGGLAipoVLzC7sw+kVBuZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166684; c=relaxed/simple;
	bh=M98b0uho/6L9HJYyuZo8mAFH2lRRpS/KAZXa09S69zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MR3nxPd4AaHfOqRfmT7gnQtnSSpeZAIKOYt6vQwbFYY30qNyVsqRZ3RdwZoSoThtfjsM6T7YXL/uxU5Yk+U3Qz5FGgePWJSRjaLbUuc5+wcGZevKoOnQDH2So2HwymumblXy881ca9OoZEcscQd71hovqP5dkqAWcq6S7qbOg6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DQ5NuEF0; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4518d9fa2f4so199261cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724166682; x=1724771482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M98b0uho/6L9HJYyuZo8mAFH2lRRpS/KAZXa09S69zo=;
        b=DQ5NuEF07xkx0RtPCO8Q9h0cIe5x55eYVyU5HynuZZ8vTXbbzsDDR5BL7TVLHC+RQH
         40QbLiMUB5iNXLBxOmnbt1YNhT1Qc/+Wd72BFvoSHh72MBVxFRBCy1X5ZR7LN3s/e2i1
         RLk2UEk/Y1+cRbaV60UTpjHtn/b+acPSjZVjdf8C4MA44ae4ionKrgv94RtlgfsulD79
         1pxrliE0dj7FaPTyfYTrloGiKr3xycutfu5zXanxgoabB9N09HjFS1K0swWdxC7MylzD
         wim6ZbQKxYzxeG7o7m0ygS6LNJ9aHnjtK4GUnNLqTlq7CDl2MtqkZKLViakY2W8dsH/2
         nyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724166682; x=1724771482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M98b0uho/6L9HJYyuZo8mAFH2lRRpS/KAZXa09S69zo=;
        b=Zpk5B1lHFLg7oRx6A2T8djDnVNmTTu4lgmDVbzkIRZqKSL3XVcJ4k9alocp0jZX7GC
         cwtN5zxb71XeBUePSSmQ5pOWFCWXlL4t5g/F/BIY90l/Vvc6IsI8J+DXXXeINprDKR7p
         5moN3XF4I5DvurH6prg3kM4d2zuqbRKc6sYE7asL1wXw9UcKehW3mw7mCzZDXCyB1PaW
         jgUBHvb92/Wi7DUmB0aiLQ8JZ5kUWuiQS0RbxVoRdE/9WqcMAFW5gvMTrK11LeYjYD+1
         IgJlm0NwjcpG83gGyLR5lBiMv0esfM3XpZaErk7I4PqvZXpLDnEHUHI5A2PAZRzt9D1J
         TyCw==
X-Forwarded-Encrypted: i=1; AJvYcCUUpGbbOe59OHclOEqoI5SwIx/jxM/WXiQbrf7W4qdsc0NbBVQnqQRBGkY98xoPRq1rPtz6oXE42ZE+UVESVQWZDDcX3+kuJUz4DzRG
X-Gm-Message-State: AOJu0YzzmAwk99E/islsN8X0DWx2Gd0IoZHBuj98IF7UKcqqFw6kwbnS
	LHHD03nijpvQTBqhmxfIOhwFX9BUM8Gt4uVm8nAtPEvhM7EJD8cjdhMEKo4GWHc01AEVtBEy8pW
	xCFO8pO7vBqpRqo450fGueUWpb6MLuCeQ676k
X-Google-Smtp-Source: AGHT+IGxHrWvwxkET5G9KFHE2OTgjBHj0rFGE1objVdIM7lhI5d9VSUlLjMmyoZSbxU87Ybr//Q4mqrhQSjJsbsz524=
X-Received: by 2002:a05:622a:245:b0:447:e728:d9b with SMTP id
 d75a77b69052e-454e6ac44b5mr1928511cf.26.1724166681458; Tue, 20 Aug 2024
 08:11:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819171152.12f05e0ae5c9472004d1b00a@kernel.org>
 <20240819112902.11451fe8@gandalf.local.home> <20240820005649.dd019cfa70a8955d91cf85a0@kernel.org>
 <20240819120244.5657eb2f@gandalf.local.home> <20240820100330.9ee6f3d51f22bb9bab7c4b83@kernel.org>
 <ZsR0Z6DxSHOI-wNj@J2N7QTR9R3>
In-Reply-To: <ZsR0Z6DxSHOI-wNj@J2N7QTR9R3>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 20 Aug 2024 08:10:42 -0700
Message-ID: <CABCJKueKhDVarco4mgNeR0hkAhxDtxBjdpu=QaYVi+TGoiqd2g@mail.gmail.com>
Subject: Re: [BUG] tracing: dynamic ftrace selftest detected failures
To: Mark Rutland <mark.rutland@arm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	clang-built-linux <llvm@lists.linux.dev>, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 3:48=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Tue, Aug 20, 2024 at 10:03:30AM +0900, Masami Hiramatsu wrote:
> > On Mon, 19 Aug 2024 12:02:44 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > > On Tue, 20 Aug 2024 00:56:49 +0900
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > > >
> > > > >
> > > > > We may need to add "noinline" or something to make sure those fun=
ctions
> > > > > don't get inlined for LTO.
> > > >
> > > > Yeah, we need such option at least for function call test.
> > >
> > > Could you add the noinline, and if it fixes the issue send a patch?
> >
> > I found the target function already has "noinline". I tried to add noin=
line
> > to the testing function (callsite), but it also did not work.
> > I think "noinline" is for the compiler, but LTO is done by the linker.
>
> If LTO is breaking noinline, then that has much larger implications for
> noinstr code and similar, and means that LTO is unsound...

The noinline attribute is preserved in LLVM IR, so it should continue
to work with LTO. Which function are we talking about here? Are you
sure the function was inlined instead of being dropped completely?
Does marking the function __used help?

Sami

