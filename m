Return-Path: <linux-kernel+bounces-411495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0989CFAFF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 00:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F5E283D23
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 23:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9798D1991DD;
	Fri, 15 Nov 2024 23:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJPy0YTn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F316B1C68F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 23:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731712695; cv=none; b=LA88EYIJ9R/lqc7Uxbhes/uHdq/L1KncXOO1j6AcQ6lfXiompICKSbDwl4R0FLz0+t9UQm5ZEj44Iu2KHTeK6E2AeAe6hU6VIpTiqJf+pnep7uFpAIsrBlS1WqZZHeoD0UmNeR/RzRynu+JarsQ9yQkfLnJpnPXBP9r70/KzjE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731712695; c=relaxed/simple;
	bh=5MixmVN05tkUbsRLYDQycMIxwl04aJUBXwOIDS7Hkvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=guAZHn3f2lnuq162aC5PzIkchVtVuQSTGrKlnje4nGBtZVMRrorvajcM15cxUTpFFgLyiLwpEgu5RtE2P0JQLdcciJTSdi5wW1JHnTDFJOnNXRhkhq+EP754y1Q7UcBrQNa2mYuzwxhiO0gUl559I3gPP9rZQfJ8xNJxkLYKcz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJPy0YTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81537C4CED5
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 23:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731712694;
	bh=5MixmVN05tkUbsRLYDQycMIxwl04aJUBXwOIDS7Hkvo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nJPy0YTntOpAV7LF7MINrHuZzEqMR9BhwpO/Rgo1I7NCbFnjziNXOH5uyTNm0pb1g
	 rS9WqWX5R3lepTfp86w+gZFaqB2BKd1srv8NNxv2G4qWcLcg8fXP37Ksw4ufcNIXBB
	 eKg2DLz3Q5baej7JD1y6qDnfIZESIFIma3eaC5tfW6c1fvdTghx/cZxzfJU3V/Vd0H
	 1fQDKcio9KvZyo5LE5u7s2iYaqmBP1Mfnc+5EKYrpA/Hun49WXh895LYnaHwKb/yGX
	 SfN/Z5BZ7Sz6ysuHUV91Gi+l78ohhUf0OnwpbmehqtX6oIBMG1scw0Dref+E5QPk7l
	 4FG8VyjeVCi2Q==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53a007743e7so1399178e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:18:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUfWZLJPvAk+9wCOYFtVO5bdOYR5Cne1zOh6UAOY/IaKot/Ky7l1Oc3yVSspZ3pxx1PCmcbQAhgzlnImo0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1uf+zWBdrsW+eUvUmMU3qtMOXtj3iTJtQz9NEWHZHPM4kFrIC
	UAftGfNhEazl1lhX5kxLvZWm8UuHK/eMzoCBo+10UJFFgOoPJl9Izb2Hpre4pneqCbSZcOERebt
	7pM15ZTLJBdG2DhGZEwEYj31EvWQ=
X-Google-Smtp-Source: AGHT+IEmxOxuOg6SGpo6ITOSY18Jd6fffhcAcawDdLeTtHlhzAJdNHwe4XRb4YUNRTinp6CmmLe0C0/23yMc687akDI=
X-Received: by 2002:a05:6512:1288:b0:53d:a9da:904f with SMTP id
 2adb3069b0e04-53dab295f05mr2020318e87.1.1731712693164; Fri, 15 Nov 2024
 15:18:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112210500.2266762-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20241112210500.2266762-1-linux@rasmusvillemoes.dk>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 16 Nov 2024 08:17:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQdxx6yHGc9-+=aQxeOkBs-qGxf_1namqWp-gUwQ-uo-w@mail.gmail.com>
Message-ID: <CAK7LNAQdxx6yHGc9-+=aQxeOkBs-qGxf_1namqWp-gUwQ-uo-w@mail.gmail.com>
Subject: Re: [PATCH v2] setlocalversion: work around "git describe" performance
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org, 
	Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch was not sent to linux-kbuild ML
(and it can be one reason when a patch falls into a crack),
but I guess I am expected to review and pick it.



On Wed, Nov 13, 2024 at 6:04=E2=80=AFAM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> Contrary to expectations, passing a single candidate tag to "git
> describe" is slower than not passing any --match options.
>
>   $ time git describe --debug
>   ...
>   traversed 10619 commits
>   ...
>   v6.12-rc5-63-g0fc810ae3ae1
>
>   real    0m0.169s
>
>   $ time git describe --match=3Dv6.12-rc5 --debug
>   ...
>   traversed 1310024 commits
>   v6.12-rc5-63-g0fc810ae3ae1
>
>   real    0m1.281s
>
> In fact, the --debug output shows that git traverses all or most of
> history. For some repositories and/or git versions, those 1.3s are
> actually 10-15 seconds.
>
> This has been acknowledged as a performance bug in git [1], and a fix
> is on its way [2]. However, no solution is yet in git.git, and even
> when one lands, it will take quite a while before it finds its way to
> a release and for $random_kernel_developer to pick that up.
>
> So rewrite the logic to use plumbing commands. For each of the
> candidate values of $tag, we ask: (1) is $tag even an annotated
> tag? (2) Is it eligible to describe HEAD, i.e. an ancestor of
> HEAD? (3) If so, how many commits are in $tag..HEAD?
>
> I have tested that this produces the same output as the current script
> for ~700 random commits between v6.9..v6.10. For those 700 commits,
> and in my git repo, the 'make -s kernelrelease' command is on average
> ~4 times faster with this patch applied (geometric mean of ratios).
>
> For the commit mentioned in Josh's original report [3], the
> time-consuming part of setlocalversion goes from
>
> $ time git describe --match=3Dv6.12-rc5 c1e939a21eb1
> v6.12-rc5-44-gc1e939a21eb1
>
> real    0m1.210s
>
> to
>
> $ time git rev-list --count --left-right v6.12-rc5..c1e939a21eb1
> 0       44
>
> real    0m0.037s
>
> [1] https://lore.kernel.org/git/20241101113910.GA2301440@coredump.intra.p=
eff.net/
> [2] https://lore.kernel.org/git/20241106192236.GC880133@coredump.intra.pe=
ff.net/
> [3] https://lore.kernel.org/lkml/309549cafdcfe50c4fceac3263220cc3d8b109b2=
.1730337435.git.jpoimboe@kernel.org/
>
> Reported-by: Josh Poimboeuf <jpoimboe@kernel.org>


Maybe, the comprehensive tag list looks like this?

Reported-by: Sean Christopherson <seanjc@google.com>
Closes: https://lore.kernel.org/lkml/ZPtlxmdIJXOe0sEy@google.com/
Reported-by: Josh Poimboeuf <jpoimboe@kernel.org>
Closes: https://lore.kernel.org/lkml/309549cafdcfe50c4fceac3263220cc3d8b109=
b2.1730337435.git.jpoimboe@kernel.org/




> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>
> v2: Drop odd here-doc, use "set -- $()" instead. Update commit log to
> mention the git.git patches in flight.
>
>  scripts/setlocalversion | 53 ++++++++++++++++++++++++++++-------------
>  1 file changed, 37 insertions(+), 16 deletions(-)
>
> diff --git a/scripts/setlocalversion b/scripts/setlocalversion
> index 38b96c6797f4..1e3b01ec096c 100755
> --- a/scripts/setlocalversion
> +++ b/scripts/setlocalversion
> @@ -30,6 +30,26 @@ if test $# -gt 0 -o ! -d "$srctree"; then
>         usage
>  fi
>
> +try_tag() {
> +       tag=3D"$1"
> +
> +       # Is $tag an annotated tag?
> +       [ "$(git cat-file -t "$tag" 2> /dev/null)" =3D "tag" ] || return =
1

The double-quotes for tag are unneeded.

"tag"  --> tag

This function returns either 1 or 0, but how is it used?




> +       [ "$1" =3D 0 ] || return 1
> +
> +       # $2 is the number of commits in the range $tag..HEAD, possibly 0=
.
> +       count=3D"$2"
> +
> +       return 0


Same here. The return value seems unnecessary.



--
Best Regards

Masahiro Yamada

