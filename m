Return-Path: <linux-kernel+bounces-420579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFBB9D7CD6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33450281C96
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7C118A6C1;
	Mon, 25 Nov 2024 08:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPXbVsMS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852D31891AB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732522925; cv=none; b=rKFNKuHkcSLYGJTLhiiAO+r/T4uS5eX7ET+2GPMdq+qPI6t5/WIpgcP4cZNE9J2RO1Tisps0bYL/AFlIf4NdegekwFG6agkLVaxLeE1fpXDpRy0sFCPnx/BtunVST5h9KxzezCgtuRT6qU4etFSYBJMX2nelKO9znMMAmAo6JJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732522925; c=relaxed/simple;
	bh=xROjWPEhO8+wkfJVqdO4Z/wOTCC1ASqUQ4sOHICwTIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VaQQvcFT6CnL1CQ+ZsvFzHplEBuusU/DD0sOGyp/9zzzgwKSIpHdSjq2FnEZ7GhOP3gqxzdkLK/0SgbsEYNkgXxjODE1qD5Ze208unVqzHVLHnb8ctEanEJfnWt59/ouL/WvzlOePY/bDxa651ueeu2XbbCYtbxyQRVn3OpF+CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPXbVsMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BD5C4CED1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732522925;
	bh=xROjWPEhO8+wkfJVqdO4Z/wOTCC1ASqUQ4sOHICwTIM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vPXbVsMSgjg6yItDcx3gMsSTTxoVmXkc3IQRIoWnDkioaWRihfzBqdkyX1qCoHGpR
	 hau6ISDi0Un+OK3JCqXX0RNwKXK5SfdiWiMS3VcRa2HbrwmzYgUZe9U4rVUgViQ2z3
	 eQumzoBWtKglY9sl9x2vo07sX6siYmX2GratoO4FuDDh8ra7bc5CVkYw7+rrD7asiZ
	 hsCkM37WttIr2Y8lhgAtiEimCrdnlEdbMKXhQfHtsh0kcGgCJgmStLY+IaLMZARIFp
	 VceieibakAYunYJ/+bcLxaF/UaslpNPdAK4cQ9PoM+a55E3+Rpaw8IK5HriNSFFkfH
	 LZAUrnTK7xEUg==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53de50a3885so537596e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 00:22:05 -0800 (PST)
X-Gm-Message-State: AOJu0YyXiMDeIGDesSZ8kSvrQ74ITpQQXE3ZO+a+T7Ghn74USx2thhEI
	LU9yrHRH2l/vZAvLhOPnJ2YFUx88UZbqoxq4dtBUQhd3p3fM/zF/lQix/4yXvQ6vBDe9X2KH7TS
	qTuUQzJhhbYPYCziNpoSQF63OSQY=
X-Google-Smtp-Source: AGHT+IG707/fdlHfFmqYMxh/2ER+J1Pc/fc+RV0pBKBj/TXSJmLTnJZZVDG9t7lA4XqdCRDPoJkMEKRacdW6ZShbAnA=
X-Received: by 2002:a05:6512:3195:b0:53d:dda2:e8fc with SMTP id
 2adb3069b0e04-53ddda2e95bmr1898915e87.21.1732522923506; Mon, 25 Nov 2024
 00:22:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125072308.421686-1-lizhijian@fujitsu.com>
In-Reply-To: <20241125072308.421686-1-lizhijian@fujitsu.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 25 Nov 2024 17:21:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNASAfvb4Z59QF8cBgFJPLhi-dfOGYwB_J5+1GGanYTe-Aw@mail.gmail.com>
Message-ID: <CAK7LNASAfvb4Z59QF8cBgFJPLhi-dfOGYwB_J5+1GGanYTe-Aw@mail.gmail.com>
Subject: Re: [PATCH] gitignore: Don't ignore 'tags' directory
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	Kris Van Hees <kris.van.hees@oracle.com>, rostedt@goodmis.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 4:23=E2=80=AFPM Li Zhijian <lizhijian@fujitsu.com> =
wrote:
>
> LKP reported warnings [1] regarding files being ignored:
>    tools/testing/selftests/arm64/tags/.gitignore: warning: ignored by one=
 of the .gitignore files
>    tools/testing/selftests/arm64/tags/Makefile: warning: ignored by one o=
f the .gitignore files
>    tools/testing/selftests/arm64/tags/tags_test.c: warning: ignored by on=
e of the .gitignore files
>
> These warnings were generated by ./scripts/misc-check. Although these fil=
es
> are tracked by Git and the warnings are false positives, adjusting the
> .gitignore entries will prevent these warnings and ensure a smoother scri=
pt
> execution.

You do not need to mention a special tool because you can see them
when building the kernel with W=3D1.

You can say "Building the kernel with W=3D1 shows ..."



>
> [1] https://lore.kernel.org/linux-kselftest/202411251308.Vjm5MzVC-lkp@int=
el.com/
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  .gitignore | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/.gitignore b/.gitignore
> index 56972adb5031..e63dbba823cd 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -130,6 +130,9 @@ series
>  tags
>  TAGS

Unfortunately, GIT does not support "only match to regular files",
but you can make the intention clearer:


# ctags files
tags
!tags/
TAGS



You can add "!tags/" right below "tags".
Then, your comment is unnecessary.


--=20
Best Regards
Masahiro Yamada

