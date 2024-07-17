Return-Path: <linux-kernel+bounces-254664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0BD933603
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 06:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDC811F23537
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 04:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0369445;
	Wed, 17 Jul 2024 04:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GwM873BN"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D964AD2D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 04:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721190358; cv=none; b=KxozuVzOq6uyyF2yGI+JcfZcOGqeRLqeIlqyQZCPEIklJeeZS38G1dS61hmWJ+Q0PSiTGK/fGvMBpV9OF/2eX2OS1vu0KXRXrXK95mInYlFpwiZbSFJF1srpJLmLT2EZvFPt6E0hnQh6N/ZmpXaf6CeEDFhZQeq+vjuzq4xJq4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721190358; c=relaxed/simple;
	bh=sxr4UZk/YNRurmcVQmNgvUIHu3euE1i7zra/Zb2J1Ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tCKH4++qXcGz/Y9q85wpwcq/fpGTR6+EDzlYO3ol/yFER7VnLD7+8V1IQoFgBCx8mk9VGY+ME8unT/QDq9Piojr2u/5eE7A/GRH2INxaPcrKFCjSFOlspKrn1dJd7xta3ER+8vmKyKUM+2bUM4WpxYIWyBx3EJo3ns5fGxsIVPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GwM873BN; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-25e397c51b2so3297878fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 21:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721190356; x=1721795156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckcdu+nL5/2prVf55dHz90ZAAt933OlZUTny+cDg+yc=;
        b=GwM873BNwGce3pWI7onMTB5fEDf3CRJ7G04SzMD7QPE5AfNTRcttvWMz73HGD/nVuM
         knjREvXOFUoOa1DRbT90lMudX41wQQpyoyJ8FxHuftdhj3mx84pR5YAL9LvKzZvS7U5a
         tTGjVulSKGNqdxJXFy1RyMR8kOua7cZxZctB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721190356; x=1721795156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckcdu+nL5/2prVf55dHz90ZAAt933OlZUTny+cDg+yc=;
        b=bp6BOXohPeSpxtC//giQ40uRGBGYHyDmLl/SE8aNOWeKLhh9T7yGc2PKRI3Hf1gxjl
         lyQbQSgRlEOaXBeSNmCuWAT/Xbd1aD21gKTT0SFwbt8zM86u7Lhp5pdaVeW4tZWgNIxp
         u5NjB793I1SmTP5v0JMHCxl07waElssvc0OuMb8KfTsRnwNnUawfxH5/meHkQSleZkDS
         obsFDSCqHQ9oP2emc0P1zsRsdgU55zMM6ue8RpAkGAk+BdHFd3JwXtxRDDhNEbwty6Yx
         n7D8QgsiOrCdg7b6NBcQV/fWgjGTkPiNkewy7TxN8HlMFUYQOun7dqjuD2b12kcRqMUu
         5SQg==
X-Gm-Message-State: AOJu0YwpDrEes6+GoFs0WcIsOIcgKVccHfjPiZbzF+e/ExuJnn6kxefS
	DThApbDQmTJ66/frjEA0WGN8SRmF6IIkfZrMS6JF3+8rI+aPhPPE3Bk+E39bA25Vmj/QzYkZ8HI
	2dNOSIYUwLOi9mOieUHS9ylbfhmQkRwlwy6ed
X-Google-Smtp-Source: AGHT+IExImqpiMIOVhDtSbQ5NdK6ILtYf2QIdhgG4sC5Xzh7NZjktXiyJRHNrL0ehdlZ0zfogQcl/EixdSoURf2Ql84=
X-Received: by 2002:a05:6870:e0c9:b0:24f:d12a:5f1c with SMTP id
 586e51a60fabf-260d948e317mr393907fac.53.1721190356102; Tue, 16 Jul 2024
 21:25:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627211737.323214-1-aruna.ramakrishna@oracle.com>
In-Reply-To: <20240627211737.323214-1-aruna.ramakrishna@oracle.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 16 Jul 2024 21:25:44 -0700
Message-ID: <CABi2SkVFpDK_Dugz68Vu4dZ+Jk5bhiEYDuPbNnGu8W9Nbw1m4g@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] x86/pkeys: update PKRU to enable pkey 0 before
To: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, dave.hansen@linux.intel.com, 
	tglx@linutronix.de, mingo@kernel.org, keith.lucas@oracle.com, 
	rick.p.edgecombe@intel.com, linux-mm@kvack.org, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Jeff Xu <jeffxu@google.com>, 
	Kees Cook <keescook@chromium.org>, =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, 
	Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Aruna,

I added Rick who commented on the previous version of patch. I added
Kees/Jorge/Stephan/Yann,  they expressed interest in similar
functionality before. It would be best to keep them in future versions
of this patch.

I also add linux-mm for more reviews/feedback on signal handling path.

On Thu, Jun 27, 2024 at 2:17=E2=80=AFPM Aruna Ramakrishna
<aruna.ramakrishna@oracle.com> wrote:
>
> v6 updates:
> - Rebased patchset to v6.10.0-rc5
> - Changed sig_prepare_pkru() back to enabling all pkeys, based on
> discussion with Jeff Xu
Thanks for taking the suggestion.

>
> As Jeff mentioned, I'm unsure if we need to retain the changes to the
> 32-bit functions. Maintainers - please advise.
>
It is possible to  reduce the size of change.
Not touching the ia32 or x32 code path also means less test in
multiple architectures and less risk of regression.
I will add comments in the specific  patch to clarify what I meant,
please give it a try to see if it makes sense.

-Jeff





-Jeff



> v5 updates:
> - No major changes, mostly a resend of v4 - except for updating the
>   commit description for patch 5/5
>
> v4 updates (based on review feedback from Thomas Gleixner):
> - Simplified update_pkru_in_sigframe()
> - Changed sigpkru to enable minimally required keys (init_pkru and
>   current
>   pkru)
> - Modified pkey_sighandler_tests.c to use kselfttest framework
> - Fixed commit descriptions
> - Fixed sigreturn use case (pointed out by Jeff Xu)
> - Added a new sigreturn test case
>
> v3 updates (based on review feedback from Ingo Molnar and Dave Hansen):
> - Split the original patch into 3:
>         - function interface changes
>         - helper functions
>         - functional change to write pkru on sigframe
> - Enabled all pkeys before XSAVE - i.e. wrpkru(0), rather than assuming
> that the alt sig stack is always protected by pkey 0.
> - Added a few test cases in pkey_sighandler_tests.c.
>
> I had some trouble adding these tests to
> tools/testing/selftests/mm/protection_keys.c, so they're in a separate
> file.
>
> Aruna Ramakrishna (4):
>   x86/pkeys: Add PKRU as a parameter in signal handling functions
>   x86/pkeys: Add helper functions to update PKRU on the sigframe
>   x86/pkeys: Update PKRU to enable all pkeys before XSAVE
>   x86/pkeys: Restore altstack before sigcontext
>
> Keith Lucas (1):
>   selftests/mm: Add new testcases for pkeys
>
>  arch/x86/include/asm/fpu/signal.h             |   2 +-
>  arch/x86/include/asm/sighandling.h            |  10 +-
>  arch/x86/kernel/fpu/signal.c                  |  27 +-
>  arch/x86/kernel/fpu/xstate.c                  |  13 +
>  arch/x86/kernel/fpu/xstate.h                  |   2 +
>  arch/x86/kernel/signal.c                      |  45 +-
>  arch/x86/kernel/signal_32.c                   |  12 +-
>  arch/x86/kernel/signal_64.c                   |  14 +-
>  tools/testing/selftests/mm/Makefile           |   2 +
>  tools/testing/selftests/mm/pkey-helpers.h     |  11 +-
>  .../selftests/mm/pkey_sighandler_tests.c      | 479 ++++++++++++++++++
>  tools/testing/selftests/mm/protection_keys.c  |  10 -
>  12 files changed, 583 insertions(+), 44 deletions(-)
>  create mode 100644 tools/testing/selftests/mm/pkey_sighandler_tests.c
>
>
> base-commit: f2661062f16b2de5d7b6a5c42a9a5c96326b8454
> prerequisite-patch-id: fc7cbe9ff3c554d556e2792f9ffaf29e6ad6ee21
> --
> 2.39.3
>

