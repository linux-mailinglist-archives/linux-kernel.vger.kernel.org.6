Return-Path: <linux-kernel+bounces-532674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 600B4A450C7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 00:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D28617771A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AE3235374;
	Tue, 25 Feb 2025 23:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UErkwsfL"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C545A2222DE
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 23:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740524501; cv=none; b=q12oCTjqqkXx4uDteUGgODEcqAA/t9aKnnMOAzLEllfNrZWqXf54L3G7E6/AXDRsDHHZ0U3T0M4B6WP0a75iGibxo29twJj1zlk2UtR1f5PMZb9+DSzljGj6wBZY3V/UW3D2mgKSurR0hBD+385VrYZdHtleDjIPAgx67pR+o8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740524501; c=relaxed/simple;
	bh=mde08ePw0U7qTCok3XXW6MXXh6mFRApsatbSp7N27VA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iLgB9jeS0Vgqbj3FkB3SZ04R6LFMZyQjJA6y+6e0NE44NWz8obYmiPO0sXri0i3hi7Jaf9WJYLXZr5i5aEY+fsK+hsq9TLKKw8bHVgx82kWWqWWya9GMreZVqMnvF4nQQhybmrGmpLeA7gpCLdD6U5VLHLoaSsMRJlvx2j89CeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UErkwsfL; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc5888c192so11900161a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740524499; x=1741129299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mde08ePw0U7qTCok3XXW6MXXh6mFRApsatbSp7N27VA=;
        b=UErkwsfLWJtZQ/OBS3pnMRXGxuXO7eaRKOU1paJ93DxIwz5nBu4qaZuIGsAHJ1bwHX
         pt19UTTHdEBzBk/QtWSDKRGM8gUovuuUHlrg2XfvHNuGjJnVrBrwHhEIf5MD6UvCmKkg
         B7S8HGkfSQHoO2Vud5y5y/Cw3GYShrkmbwExhsfZsjEZVRQP3XLBvell0btQencjUYNA
         RwgSx7nd2tRSfvQS0xY48Lt1QLMco4Z0HNl3q4nqe2IcU0QZYD93n+EkcjvYCZ69bHgq
         qhvE9DH28ZuN6q2ylY9qi+vha7VoiUun4pUSUNNicKcyjAIAa5saUDPlxBUkbuPbn5TZ
         hgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740524499; x=1741129299;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mde08ePw0U7qTCok3XXW6MXXh6mFRApsatbSp7N27VA=;
        b=vnrl/x1nP083Wh7XdHlJvUX1Egddpz2lEnOpOmMieLVY+dUm7rnF8OdR5F3Q1KfYIX
         cttW2ukKlKqb1KNB4JIgbPddB/gEff1CZHp30Zzhc0ZazQpfq4NekpNhBHbWiWashXrv
         lKfCQTt/imMF730LsZmrFY2rc2bT4eQbrHeAgRCUMFM5BYrXpZRkfxlWDXWsnp0hhXi0
         bITUTNYJMGdK8g0dfIKuDohfcOyuaYNdxa4OEdXA6AbXNfdMZln/R/MW8PfFBT6BahAE
         LQd8w091YM5fZ6K9nm7AmRtTykNPE/Zv4e18/8KVvPSrUpxewLNAIygIsmFbYo4p3IQa
         VQ1A==
X-Forwarded-Encrypted: i=1; AJvYcCWdlyIjlOHixHpZQ31ZRM7pWJXXiuy6cTDSTYV4Wp+3ugX71r8JWz88jCXqF3IDxLBtV47dV9hul4oCtTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhBid9xyxYVKUboXfqauihO+XjRQ97NM+/2ulep281Trt0i5Og
	EKjV9v971aX1/Kjj1xho7z984wdx5ToMQAqGi9ZXYFBLSPGjMp0nRW2h/2qNb7ZahJgClRda8g=
	=
X-Google-Smtp-Source: AGHT+IHPhKxQsRjLLUmrOJuKKmq+fpePmjEEOBM1vx7AS8VefdM5jfSQyDCFPrR8FFoSvuoQhhkXY0nLEw==
X-Received: from pjbsd6.prod.google.com ([2002:a17:90b:5146:b0:2f2:ea3f:34c3])
 (user=wnliu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:da87:b0:2f6:539:3cd8
 with SMTP id 98e67ed59e1d1-2fe7e33c7afmr2054308a91.18.1740524499118; Tue, 25
 Feb 2025 15:01:39 -0800 (PST)
Date: Tue, 25 Feb 2025 23:01:36 +0000
In-Reply-To: <20250225181331.frmfumf4b5ctfbsm@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250225181331.frmfumf4b5ctfbsm@jpoimboe>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250225230137.620606-1-wnliu@google.com>
Subject: Re: [PATCH 0/8] unwind, arm64: add sframe unwinder for kernel
From: Weinan Liu <wnliu@google.com>
To: jpoimboe@kernel.org
Cc: indu.bhagat@oracle.com, irogers@google.com, joe.lawrence@redhat.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-toolchains@vger.kernel.org, live-patching@vger.kernel.org, 
	mark.rutland@arm.com, peterz@infradead.org, puranjay@kernel.org, 
	roman.gushchin@linux.dev, rostedt@goodmis.org, will@kernel.org, 
	wnliu@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 10:13=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.or=
g> wrote:
>
> On Tue, Feb 25, 2025 at 01:02:24AM +0000, Weinan Liu wrote:
> > On Mon, Feb 10, 2025 at 12:30=E2=80=AFAM Weinan Liu <wnliu@google.com> =
wrote:
> > > I already have a WIP patch to add sframe support to the kernel module=
.
> > > However, it is not yet working. I had trouble unwinding frames for th=
e
> > > kernel module using the current algorithm.
> > >
> > > Indu has likely identified the issue and will be addressing it from t=
he
> > > toolchain side.
> > >
> > > https://sourceware.org/bugzilla/show_bug.cgi?id=3D32666
> >
> >
> > I have a working in progress patch that adds sframe support for kernel
> > module.
> > https://github.com/heuza/linux/tree/sframe_unwinder.rfc
> >
> > According to the sframe table values I got during runtime testing, look=
s
> > like the offsets are not correct .
> >
> > When unwind symbols init_module(0xffff80007b155048) from the kernel
> > module(livepatch-sample.ko), the start_address of the FDE entries in th=
e
> > sframe table of the kernel modules appear incorrect.
> > For instance, the first FDE's start_addr is reported as -20564. Adding
> > this offset to the module's sframe section address (0xffff80007b15a040)
> > yields 0xffff80007b154fec, which is not within the livepatch-sample.ko
> > memory region(It should be larger than 0xffff80007b155000).
>
> I assume kpatch create-diff-object needs to copy over a subset of the
> .sframe section. =C2=A0Similar to what kpatch_regenerate_orc_sections() d=
oes.


You're right that we need to process the sframe section like what
kpatch_regenerate_orc_sections() does when building livepatch by kpatch.

However, livepatch-sample.ko is not generated by kpatch.=C2=A0It is built
directly from samples/livepatch/livepatch-sample.c by gcc during the kernel
build


