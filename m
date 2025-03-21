Return-Path: <linux-kernel+bounces-571091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4DBA6B900
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1B4D173A84
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356D021C9F2;
	Fri, 21 Mar 2025 10:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IwMMzdsk"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2C71EA7E3
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742553864; cv=none; b=RmEAeqqHtrynnjb87TbguHOGX0O64CmhFfeQ7lMod3si1qJzLJzUInGiAqSF8ObfRPQnLY+VPP4uOQDBBWA4lZ87OpUdO82iAxfJ6ZIiyH7zE0tXj/eFFcTfcgqwAxwLudyA3wVe3uk/WcG5ehWYb6ft7dEZOuU/W+sFM6rOpD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742553864; c=relaxed/simple;
	bh=SCjwz9IhNUs13zrxYy4dhDI/gNy5VGZmAA7bVjTjQqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IbKt61n5B10phPiNvQ+YrGSw+3JnfQzkbt1U6lfbgPku2+MmAs+jNemL13q9cJCF3iobGIlKQolSfMg2ZHOVxiEHP3yKthHIJ3ZlixCZttGUA/DwKxZMrTNbwQqRmHPW4DY6FUggxV+mhsvqoHQTk+65WVp8pAG4UAHzEONMz3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IwMMzdsk; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5439a6179a7so1884373e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 03:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742553861; x=1743158661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMFQ6ixjFyQ1E4NstCe9/IuCPeD7EZepvZAYFGPOnbE=;
        b=IwMMzdska1joh2w14YzAi7dXYywdfWPUpgVmERH1bWtIKp+29whHGTsrGEgFxEOwS9
         SXRJNIfdulzb0m44VTDNf/r2sAapXRoBh80nRjLJOMAVx9mr2RZNTf9kgysBp/38XkPE
         78ceeA+5+SASJHpLZ+cqUct/Y9rbAnpvnWUMCBxylldq1gWbdACgG5R+k90UXM6M94OH
         BA14xqsPmirQr5SiT8EeKuLyJNw6ewWCLPB/SBjrOCyDwSboS9LJx+nVi3Huny5brRke
         R4cLhYJsSaA9nu/pjWF6kFRdXnUmVFl7TnkBjzbtiQC67xErTAvscv8t7l+lp1MFN6kC
         U7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742553861; x=1743158661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nMFQ6ixjFyQ1E4NstCe9/IuCPeD7EZepvZAYFGPOnbE=;
        b=S1psaA3ZKDuAfWeBe0gsnSMl14ifXIAcven78/TfWEMIOeVEChLN/Xtcc9kb/6o5ey
         T32aAH96oWjRgzKih/4L9ZIaPw//hd6DCPHF+rVlwNN0BjDH+16O/HFpufo/mgZoKlPR
         9hUGevfjHiD6DmtXvbqoAwOwO1qSAJQa8Bxgx07jI4Yc8GTMvu7QaZQdq8xusq1+/+eR
         9GwTZOT/J7VeONQlKIFz3Siei7Pr3jIvXnTr8yP+F7Hq7O4WrGyKtQvHoVoKjDvzsga9
         H4NMTM6Svygk7d3dlFAj6gMhm88+/TjuLZXVEGMYJ5qXuUqg8lbhlaF8bpULGJLUqnpc
         lOvg==
X-Forwarded-Encrypted: i=1; AJvYcCWF6cMNNITNLe2VQ9ZZwIaKOVFq4sWfBW1g/zCDvEbvjLF/fGfMxiCJFscs2I7BXyJ0lM5oKQBQnsznihY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvJ4KtLRvCweb5E5BMQ0fn2r0r/RNipSAr4IAScCa0mlNpb7lQ
	tqYeVFkom+lZ7Uv0S6zWL8lLVFK9origsGK5sPxsdqNH2SGLXKZMEx+voOwX1D9AvbqsaS/SshH
	qbSdmi06hG3AdTHUV2FEFoB6T13clKufJkoz9FQ==
X-Gm-Gg: ASbGncsNnqGP89NlIj6ac4BfRO+DJgOVA+94nbS4crOv9OXPGJbCiChuLbB+LFhZsXJ
	OSmdnzNKwSwtguwVIi3tWPunYOS3kQBZx9MyDk0t97687qM/P58SDiwGXHsal8jFN2HuY5lXOym
	kFbehn4TueRzSvMkUCN4D37Jtz8V9yV7xkdoHSbEV6YxwZHBZ8pJABDPKG+4u4pnxOqKZqiw==
X-Google-Smtp-Source: AGHT+IExWP4rEZzEIQLvGfgn1PTsgmb75s5NHEvjlqVUG7ZMsU4G9wMoNJQZ7haUyid3P3yrJgHTnRHlG9abuUhqmzM=
X-Received: by 2002:a05:6512:220b:b0:54a:cc10:595e with SMTP id
 2adb3069b0e04-54acfa79a96mr2319677e87.2.1742553860747; Fri, 21 Mar 2025
 03:44:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315194002.13778-1-marco.crivellari@suse.com>
 <20250315194002.13778-2-marco.crivellari@suse.com> <Z9qlW81QikxeVzQa@alpha.franken.de>
 <Z9rYAT9i3Ko92uUo@p200300d06f3e987545685175b554ae65.dip0.t-ipconnect.de>
 <Z9rjZf0ZT7iejVlA@alpha.franken.de> <CAAofZF7XPm+tzPpwAPu0oDZem+EOVY18oAbVwAXzkGmtstnBQg@mail.gmail.com>
 <Z90zebpJE4Y9SbkK@alpha.franken.de>
In-Reply-To: <Z90zebpJE4Y9SbkK@alpha.franken.de>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 21 Mar 2025 11:44:10 +0100
X-Gm-Features: AQ5f1JpOKBazK8g4BWMOjvBQWA4qXGIWYXKI1lSJvQLrZC8sT_FrUCOZyJuIkFw
Message-ID: <CAAofZF50P0+c6QbNxzEunwbDGUZEZpKM8wa2dBYXAVFFYGq-hA@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] MIPS: Fix idle VS timer enqueue
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Huacai Chen <chenhuacai@kernel.org>, "Maciej W . Rozycki" <macro@orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 10:38=E2=80=AFAM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
> do we really need that for a symbol local to that file ?

Not really, I can use the label directly.

On Fri, Mar 21, 2025 at 10:38=E2=80=AFAM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> > +       /* Check idle interrupt region size. */
> > +       .ifne   __r4k_wait_exit - __r4k_wait - 36
>
> I have to say, that I prefer my .if statement, since this clearly spells =
out
> the comparision in the expression. Is there a reason for your version ?

Sure, let's keep your version.
Can we use the "error" message above? (""Idle interrupt region size
mismatch: expected 36 bytes."").
Or at least something similar, I think it is easier to understand the
reason for the error. What do you think?

Thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product




marco.crivellari@suse.com

