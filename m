Return-Path: <linux-kernel+bounces-548565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F6EA5467E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D543A18960DB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9220320A5C3;
	Thu,  6 Mar 2025 09:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MS4mF0BF"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E611EA7CD
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253890; cv=none; b=XiEdDZbTy5BsLgu7mCn4kEKsGFywK08tEL7EB/YSUVO4JFXv8yRK4IZq7yzoKlBzndjiezzMmAJ15Y9sNIBddsET4rycOaA1oXPJtCqXKOktGTtQgrfHHQlRkWfOr5v2P1SPLHB8rCk49iU7pX7NAM2tIH0JlYh7rqyfE/MJnlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253890; c=relaxed/simple;
	bh=Loi3UwD9wul/TYuYnnEga+mzMyGuK3ZmfDUqf1r6Hxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYlCepIyH05/tLIdhriQ2UJTCPg02w/Jr5xHDK6xKf4+5v0uuu23WoqL3IW59LKR++ay2v7IxJtK9EvQSCirGi1qlIat1DBtjmkWOM5ReyQ5wxPubtI9cx1k0EbDltifFEZ1NDutO8TDnq9oxfn04XZTsK6N+jrXRgb6UmNzsUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MS4mF0BF; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30b9b1979b9so4612671fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 01:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741253886; x=1741858686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Loi3UwD9wul/TYuYnnEga+mzMyGuK3ZmfDUqf1r6Hxg=;
        b=MS4mF0BFf8vXQtSgdzmhtIlAA/jiXeVbxp/i4HAFZQ4/yBKXJ2LZJGX7TPKTcKvYFh
         waL/mOtYL23hQf0w2iOFj4ZJMTGaGbYdCXIk6IAX2QeKcDdbLPsVfu0OPhMgrNkLus0f
         iMRMXPUju+0co+QO7ADjfOAr0LFe90vCUCXMEIoGkPu0Vc75qz0QhhIrEYdQ+vQqk/r8
         uTIWpsVEX7vghpLw2Y7OZGmbvROTcX41Nn+CqNp4d/XAjQ0VDE0rLBTkJa7QDxRagHV1
         lzhcfgIfjv+lpomYDWOXLE4sELlQC3vK7CSECHzFkgeh6XVgNpuVMxTmeQu4WDhmTDXM
         DVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741253886; x=1741858686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Loi3UwD9wul/TYuYnnEga+mzMyGuK3ZmfDUqf1r6Hxg=;
        b=cL9Kp96o4ON8kjVU8pG+xqmDuTEGKEhXobWZMch3BFp3AAmC5BWr/tkhORgSYsMmC9
         qLxFL9J9UdfE2LMNjHoCIbBS55KwDYHgSy0l18GLaoI4pK52Y38Kz4XoBZq868aH14i6
         IWo1C7+NrgEdDOMfpEoPzT8LQFe0MIFWUlfkzxHdEjtFJWVAv4cwoaunapQDr+mc6QpO
         Y7t7XxXhvaRlM1f0pqO96ub0KGNotV5gKxp0bah1AUNnA+UV6NIYc/xIM2Y2chhPvCOF
         BHWInTJ/elHqk0tK0ISpwJwkOiqgaOEb0y8oNcmxTMNRx4fG19kk4rt8NweMn0ZoZvx7
         +Aqw==
X-Forwarded-Encrypted: i=1; AJvYcCX+Sj7cPWB4+wUPCkdkCmAbgS1HQOq1J9EDxYQ02vvRYyFZmMr0ko1OO1bdedIIZAIhuXWTLcymwtoJxVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVVWQshDBE5yyrR/K0S/D3JxBRrfyMrEzilllvrRNE6sKYQF03
	SGKjzhOErkgmOV3yvSi4bAxAP4KtfTx+f+9t7hJes0w5yUa3aVUzpE78b0Vtwt3qwrej7uSeukE
	BFYKUdtSTkov1Nfh5/JZaEyUnAC8=
X-Gm-Gg: ASbGncvSYPaWmB9xQgvKjD3XNZgC5Gj5Gr7budTyerDzufs7EuTfJUs2M7qWb88jfwO
	e9wQ7hIqJE8IIUFMEJxQ02BoyCLzNtDjldqVivqd5RbSizfQ3bmZ/35DQ4LHnlWm1IbE63QXG/D
	GEckw9wcj7NTy7xdRpSPhkdJFrNw==
X-Google-Smtp-Source: AGHT+IFHfIv1hNZDSCUtJoCCrfeROAEWITfwuPaTygD6v+USXVCzhggrUQsaRgkT5iZ4LtieB/8z0OITNVM/FOEZRso=
X-Received: by 2002:a05:651c:221a:b0:30b:ca48:1089 with SMTP id
 38308e7fff4ca-30bd7a1eef4mr24634541fa.2.1741253885860; Thu, 06 Mar 2025
 01:38:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228123825.2729925-1-ubizjak@gmail.com> <20f1af22-71dc-4d62-9615-03030012222e@intel.com>
 <CAFULd4bpHGE83qc37sbh=rpGj+SFqQrsNDLzL_-NQpo6pQH3jw@mail.gmail.com>
 <c4aca08a-95c1-48ee-b4da-55a69b74101c@intel.com> <CAFULd4YVOEtT+bsp9H7ijaoJn2e2108tWhiFarRv=QxoUMZaiw@mail.gmail.com>
 <20250301123802.GCZ8L_qsv7-WwUwqt5@fat_crate.local> <CAFULd4b=4rHcVAVSg_3yMb8=3ReiSriw_rM4vJL9_HvheXE92w@mail.gmail.com>
 <Z8isNxBxC9pcG4KL@gmail.com> <CAFULd4bDSh7fzm8xmMzn0YzF0pr=mLvzb9dVYhCajyXx=XBrtA@mail.gmail.com>
 <Z8iyWHyYt6bfo_mO@gmail.com>
In-Reply-To: <Z8iyWHyYt6bfo_mO@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 6 Mar 2025 10:38:02 +0100
X-Gm-Features: AQ5f1JrAfp2LnOqOVKZ1eMqaK0lBfVJclgvLblR7BhPtwVHGH0UKPgJD-ViZABM
Message-ID: <CAFULd4a1t8LVMqFKNcjanKUimaxpPSQttKTQHROHrAvxGcyPEA@mail.gmail.com>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
To: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 9:21=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wrote=
:
>
>
> * Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > I simply run the lmbench command, where the benchmark was obtained as
> > .rpm for Fedora 41 [1], assuming that the benchmark itself sets the
> > benchmarked system to the correct state and does enough repetitions
> > to obtain a meaningful result [2].
>
> These assumptions are not valid in a lot of cases - see my other email
> with an example.

Thanks for the post, it was very thorough and informative, an
interesting read indeed.

OTOH, the proposed approach requires a deep specialist knowledge,
which IMO is unreasonable to expect from the prospective patch
submitter. I totally agree with Dave's request for some performance
numbers [partial quote from his post earlier in the thread]:

"I'm seriously not picky: will-it-scale, lmbench, dbench, kernel
compiles. *ANYTHING*. *ANY* hardware. Run it on your laptop."

that would indicate if the patch holds its promise. However, "Run it
on your laptop" already implies the ability to compile, install and
run a distribution kernel, not exactly a trivial task, compared to
e.g. running a patched kernel under QEMU. Some kind of easy-to-run
benchmark scripts, or documented easy-to-follow steps, would be of
immense help to the patch submitter to assess the performance aspects
of the patch. As said elsewhere, code size is a nice metric, but it is
not exactly appropriate for an -O2 compiled kernel.

As probably everybody reading LKML noticed, there is quite some CI
infrastructure available that tests the posted patches. That
infrastructure is set and maintained by experts that *can* precisely
measure performance impact of the patch. My proposal would be to ease
the requirements for the patches to something that Dave requested in
order to allow patches to be integrated and further tested by the CI
infrastructure.

Disclaimer: Please read the above as a feedback from the wannabe
contributor, not as a critique of the established development process.

Thanks,
Uros.

