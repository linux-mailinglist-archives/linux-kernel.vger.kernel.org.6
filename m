Return-Path: <linux-kernel+bounces-410555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D54F9CDD32
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 12:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEC2BB284F4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174E219004D;
	Fri, 15 Nov 2024 11:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqDukPty"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765B9154C00
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 11:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731668560; cv=none; b=r+hjNINYeL20vzTSw9i5gHIpiLC3Ag7BnbBFQC6WIrPaik/w7fopfxS03fdx3s/jTnQ2iA/fOaD2wL2TK3zwUT5WiB861cxcups/bFaaE6QhhEsbfTS7NCy2P8ZAXWAXE1z2B5Rb3gO7RnRGNrHE9WGMS0O6O/AyKnl1E3PsrWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731668560; c=relaxed/simple;
	bh=hIoj3osNEHirSNbOBqBimm9X+4AIOxhpNWxXDoZcmxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYrWu1gpbBGGmdFJTU3RF4dpB4yh+IsS5gqljZXTt3xN9G3wGa08reWF27kPS0cB0wQYtICSt+0kJVOWbVzB3hr/iyBF+ifHEzRtqdj3e7Pird8DPdp1Xosr2K2tzLLN0RJZtxQlYbyJiLUwWEJ1+4ZrdvdQqn/FMCziUIgDV3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqDukPty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2D7C4CECF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 11:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731668560;
	bh=hIoj3osNEHirSNbOBqBimm9X+4AIOxhpNWxXDoZcmxg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TqDukPty7IFx3XzAHGZTuv/o9c2G/vL2P62bjw1e0OtFuzV3UVUPWki3PR3TqxS41
	 gAlTNoXzmTrMy9HeRXfOrX8U6nMLcFWnVkxXkf83JP4qIYQjV4bcFTpZXekZ3TmfcG
	 J2AIlB5H2324ZzPCsoZ74ZQnLRQJCzSMYmr49Qo0+Q+jk7RGn24JgRp1iEEBtXMmws
	 2jDr4cmtoFOzhfd9+K3k6RzEOdvqP6Ex6pKm2SPrZxZurzXa5DRo3fxITU5jGtuMcw
	 YpeFPdIqa8wrEn3u7G5NC35IUpEJDL0BlH8xqe9Acvo/GoK74cmvq5G+9dYSJcOwaH
	 dfDppBxYxVBCA==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb5014e2daso16845601fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 03:02:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXRkYv248QLHeuSP4l385/nKnlw12CrPxpk9qnPZoSZWpmLGZB4bm9SLc4OOe2CMQ0dfl5my9SBzUpz3uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHeExsQwLPOVkfqB1ask0+aM/C/gwYSYr14QylzIVKe9YVcOSm
	cg9y4IoJl/JTrgNQ8SUvnaSCnYi4VVpv7zxNJOcPxC/vrwzkHUPDWV1O57hboOaLn7sqGzmcSl7
	IkLrJ1nKY2egK+3lE+VZmx3hhamk=
X-Google-Smtp-Source: AGHT+IHQNcdviMa6V+KDraXUHzktLvXHWUwAmijeZ8akuDLCagJe5z0Nh+rzP4N+f3y1N+5byIslnbLULRMANA9h4TI=
X-Received: by 2002:a05:651c:12cb:b0:2fa:dbf1:5b2d with SMTP id
 38308e7fff4ca-2ff60711ecdmr12933681fa.39.1731668558501; Fri, 15 Nov 2024
 03:02:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115003505.9492-2-ragavendra.bn@gmail.com> <Zzcp75p3KTFRfW5O@gmail.com>
In-Reply-To: <Zzcp75p3KTFRfW5O@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 15 Nov 2024 12:02:27 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHK4NxgWCieaQY7tT6BquSBv6Db10K8-V_8qFeZKv=BZA@mail.gmail.com>
Message-ID: <CAMj1kXHK4NxgWCieaQY7tT6BquSBv6Db10K8-V_8qFeZKv=BZA@mail.gmail.com>
Subject: Re: [PATCH] arch:x86:coco:sev: Initialize ctxt variable
To: Ingo Molnar <mingo@kernel.org>
Cc: Ragavendra <ragavendra.bn@gmail.com>, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	thomas.lendacky@amd.com, ashish.kalra@amd.com, tzimmermann@suse.de, 
	bhelgaas@google.com, x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Nov 2024 at 12:01, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ragavendra <ragavendra.bn@gmail.com> wrote:
>
> > Updating the ctxt value to NULL in the svsm_perform_ghcb_protocol as
> > it was not initialized.
> >
> > Fixes: 2e1b3cc9d7f7 (grafted) Merge tag 'arm-fixes-6.12-2' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
>
> This 'Fixes' tag looks bogus.
>

So does the patch itself - 'struct es_em_ctxt ctxt' is not a pointer.

