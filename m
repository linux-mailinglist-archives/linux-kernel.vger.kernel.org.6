Return-Path: <linux-kernel+bounces-313401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AA396A4FE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E824D1F26A4E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B554E18BC39;
	Tue,  3 Sep 2024 17:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZuwgsKp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202B81E492
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 17:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725383142; cv=none; b=EPizn1qnKNymsupq0tu6JUqtKA688q1MDNt9viuqckdM373j1eEG1o+fbFyAeomf9r7JRy8vfZz9gkzFGFcjhPepTcyAxENHB5AA8Dh4E/5HuE9mWyQhFr7S0WexHE7PvW16rNxpjGaLyYSfItHJe6IYKjieNOFhxxVKx5bZpeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725383142; c=relaxed/simple;
	bh=KDEMp+pzqqkgH9YNk/FQO0UlQZO0u4LjtiQ4Csd25gE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VmM4H/rXD4mi1G1twEFUX7Ead1b1hkxfZA00T3VHWnVg0q0VLUhQk9fIXKElXtT8noND1CuHLlnoOrmwHm4y7xXrrfslX2HXv+rj+Cl/V6Z5fAEiBqD97ir0zwo3zv1tMcHIU8siTW2AfBRPXLgGuH3eX8RcguANlvJbcRzFfYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZuwgsKp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A048BC4CEC8
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 17:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725383141;
	bh=KDEMp+pzqqkgH9YNk/FQO0UlQZO0u4LjtiQ4Csd25gE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QZuwgsKpnjB39latEAEszX9u3W1MZtB59J848U7j9NWUACnjRnDb6fv+GAwarNe+J
	 Z5pLiFaaufBkhKnXokjcIrHHEiow5dFjSSO/RMofqYtNHKieoiHpzAtk/YYgUY7kqn
	 B45y/jqzze8pkRLPfyENUx9QLTxEemBrbH7tYHzC5/FPiBc1f/UvR50KBmLzhqrIix
	 ETpZfOKJT+T7P3ASvnb0GGasiGcp6S4V78Th4QPGKHwWjdWMc1fYQj2vTmjlUsW8uT
	 5m+W8zMRUPkVo6jVzdeN2PQdEm2esfi+Kne9G4Y0ZEu8Wa7QWAnHRh5qkL3XKAlbrI
	 LcUhttytRKBdw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f4f505118fso64273491fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 10:05:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVf0nGSrgEZ4XT4o7lqvuJIhezeP8eL1By6NRuU06cf99QMk+9Hlb8dUTeP/3qHzNAEo7KsxEq52/dT1w0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcPECtzcUzZ6nvXMGORSQn/5sqPs40i+iOXkhEc5B0NJFMULke
	KU1WkEfNY+Txg5h+btA+OvRZ8E1MAZ5Dn6+JaBUHkfdIBXJ81tSzbkF2JfflfsttIqZ0mX/xdpL
	rFFuH8puhKsH4J36T9tm5WJiirrE=
X-Google-Smtp-Source: AGHT+IGZ5lQbHCzKN6XXvCQw+Y4PHBxvxxgEyUDbL3iSgHhKX8qsiaG0VzN46xsqAPEaQ05hU8wcRbkvwVycLSz0DFA=
X-Received: by 2002:a2e:b887:0:b0:2f4:fc1c:e5dc with SMTP id
 38308e7fff4ca-2f6265d771bmr94290551fa.33.1725383140316; Tue, 03 Sep 2024
 10:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240831101045.1381258-1-masahiroy@kernel.org>
 <CAK7LNATtOzj175_Y0qQz338FRG1GYCrsorA=jWG+Go1Wjn9rnw@mail.gmail.com>
 <8795e8da-981a-4876-99fe-8a4edb2185bf@linux.dev> <CAK7LNAQfpge7Hg8+yq3uyWD26D=kMcB3pKuoN+BGLfrOFFNgLA@mail.gmail.com>
 <e72b55f5-2e12-43b1-8f9e-ddd7c9db8246@kernel.org>
In-Reply-To: <e72b55f5-2e12-43b1-8f9e-ddd7c9db8246@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 4 Sep 2024 02:05:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNATFVFMTToJ-xWoKsj-LkqocHX-p86aEsHsB5mDHrsYgXQ@mail.gmail.com>
Message-ID: <CAK7LNATFVFMTToJ-xWoKsj-LkqocHX-p86aEsHsB5mDHrsYgXQ@mail.gmail.com>
Subject: Re: [PATCH] ARC: update the help message for CONFIG_ARC_BUILTIN_DTB_NAME
To: Vineet Gupta <vgupta@kernel.org>
Cc: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 9:39=E2=80=AFAM Vineet Gupta <vgupta@kernel.org> wro=
te:
>
>
>
> On 8/31/24 23:50, Masahiro Yamada wrote:
> > On Sun, Sep 1, 2024 at 8:02=E2=80=AFAM Vineet Gupta <vineet.gupta@linux=
.dev> wrote:
> >>
> >>
> >> On 8/31/24 03:13, Masahiro Yamada wrote:
> >>> On Sat, Aug 31, 2024 at 7:10=E2=80=AFPM Masahiro Yamada <masahiroy@ke=
rnel.org> wrote:
> >>>> Commit abe11ddea1d7 ("ARC: [plat-arcfpga]: Enabling DeviceTree for
> >>>> Angel4 board") changed the default built-in DTB from "skeleton" to
> >>>> "angel4".
> >>>>
> >>>> Commit fd1557923b2e ("ARC: [plat_arcfpga]->[plat_sim]") changed it
> >>>> from "angel4" to "nsim_70".
> >>> A typo.
> >>>
> >>>  ... to "nsim_700".
> >>>
> >>>
> >>>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> >> Acked-by: Vineet Gupta <vgupta@kernel.org>
> >
> > Will you pick it up, or shall I do it?
>
> I don't have anything major in my queue, so please take it.
>
> Thx,
> -Vineet


Applied to linux-kbuild. Thanks


--=20
Best Regards
Masahiro Yamada

