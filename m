Return-Path: <linux-kernel+bounces-559227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAE6A5F114
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DEC43BA3B7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05082661A3;
	Thu, 13 Mar 2025 10:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PfEt84p1"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEBA16BE17
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862469; cv=none; b=gfJdfaZCxenX3NYaxB0u44wEcNDTJHgK8m4UOh7cabZBKaDDgOufNKIV4ZfBb37f93sJyGOCIlk6Y5KdfK1dgS05Dy49AUop9JcO645/ispot7kEDbn8AmENpPq6LShZLPp8S3RA/wrlv0ukH2QJ8+mvma/W9HAIAPobSLpeArk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862469; c=relaxed/simple;
	bh=B4PeGgHerya/ypCQctpvLUdzWEYx1SfxUJjgPQeWpVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rzC3zw9FaQdvMqn7RB8M6r5UQci4MXd+QtK+qGNfD4Zufk+7HGuNzYmKVZyouZri4/33IV5HV9m4LLXkThTT1vC4Eq7e7AJsb/rq7oYR1CLYyalbjD0Nko7V9ZSh0KLRXmE+z5dgBXCXmrrIdNv1vhoHatIf0Og4B2ESfIImszs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PfEt84p1; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-390f5f48eafso417896f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 03:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741862466; x=1742467266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WG3mrCWjA/jdn3B8Lxgjj/yj35ADNCa7bCKVTgPxU0U=;
        b=PfEt84p1jV4VPZmqsKvgV9PgAkTNX05R//av5yHs7en0SU0PC7yb14/XJ6d2JCdE51
         IKNqNL2OPVB+oD7Zui2GVpdFRthvTRSgcFMMES1VUXxFVbXETDtChExN3tC3mOnlI7rl
         znVFzy+Q+xlEV6a1L9MgprX49YcPS2xxIpKnFfOiNNcvlJVE/4SYpvvRF/gXs7Mhcm4H
         a4We+/I0cuU06oBQWBpxVc14JKTvHw3GAhZSBtrp9+ZjAbZOgg0cWH9HT2TbPhGtpSS9
         OgihY3KFsMtRQMDaQ0T2u1PJxWJUiBkNBAFQqvcbhYeEvfPB6uiFBtaA6QCON0mo25V9
         173g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741862466; x=1742467266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WG3mrCWjA/jdn3B8Lxgjj/yj35ADNCa7bCKVTgPxU0U=;
        b=YljZIQVIycf4EiqZO3SEf/yrvmF911oSgJljZghLt+uvOr9p4OfOHjblr8CSz8B/HG
         qbzweRyzKazSasSFKA44mpsM51O4yhZOTDexHpjB1IgSl3VUi4w6hERsAE7V7ZCIyDCL
         oxWwJejif+XMPKQEfFwIOFDWg2zamSwSXdFE0LqwU2766aSOwP1DX+JrtY9EMMj/xZKw
         9YuI8v/CanPX8JpODrmdXoz1wiOS9GKNi25/nhRtJEqRmOZT3ix00s+zGnI8eYivQD1h
         w+do45y3yeATWCjZFE1pOyfHVsNsvzasydAa7Ir8ywos4XOoP76jZobUOugzv6CxBNOL
         ERlg==
X-Forwarded-Encrypted: i=1; AJvYcCU5OCeX1UaLHj8KuzcNz68PStCAPfF2VprYvBjXzI75l60tT33vpomKWRDVhbdCAzKIUytKwYWIIVps6Kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvkSP0fPfKyh4oQfIFxuV3OY/oWTeL29SGfxUScVmIX9qsnOCb
	4YCH4wv1xz+QfXcDPwf0HsySVwKdo9X3az15DSG58XPatMKaLfM1g2+C5Dz4SKHZ1SeC0Ub4uYa
	+y464QxhlmSQ/pwMfVBic+57m2IAh0FRDCc3YcQq3bv37KS8hgOwZYSs=
X-Gm-Gg: ASbGncs5oJyBui8F5zjqREVUIQuOed8BzgBaJIrK5ucdWFktkUSt2lTCz8Xu+g3fT6t
	3hmq/a6l0FhZrdtaky264emQfoDE+jAOuz+H/RTTQrQIc+WISDTMJgntqfHKfuKGHOMzxqiyikN
	p2UDlRqFGdX9lmpsF1gnfJrP9XxQ==
X-Google-Smtp-Source: AGHT+IGp49aBKepNuEzvpjEvmTqHX3EMV9vuhJzotSDGPDAqAgNEYI+FJ2y17HXElqJzyuEjBM3VMBZBmPnVmlrUQco=
X-Received: by 2002:a05:6000:156e:b0:391:3d97:bd33 with SMTP id
 ffacd0b85a97d-3913d97be31mr17037810f8f.13.1741862465823; Thu, 13 Mar 2025
 03:41:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313102604.1491732-1-masahiroy@kernel.org>
In-Reply-To: <20250313102604.1491732-1-masahiroy@kernel.org>
From: Ard Biesheuvel <ardb@google.com>
Date: Thu, 13 Mar 2025 11:40:54 +0100
X-Gm-Features: AQ5f1JrkVfGGQqKaJpeLOnmf-DmZZ5mdNP2AwlW5dbvBeYHSD4cZ2fyycQE6lzA
Message-ID: <CAGnOC3Y9OYZKB+7aQsDcq5pN4jJYkL8QRwXgH3jpLQkVwD-kTQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: do not generate .tmp_vmlinux*.map when CONFIG_VMLINUX_MAP=y
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb+git@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 11:26=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> Commit 5cc124720461 ("kbuild: add CONFIG_VMLINUX_MAP expert option")
> mentioned that "the .map file can be rather large (several MB), and
> that's a waste of space when one isn't interested in these things."
>
> If that is the case, generating map files for the intermediate
> tmp_vmlinux* files is also a waste of space. It is unlikely that
> anyone would be interested in the .tmp_vmlinux.map* files.
>
> This commit stops passing the -Map=3D option when linking the .tmp_vmlinu=
x*
> intermediates.
>
> I also hard-coded the file name 'vmlinux.map' instead of ${output}.map
> because a later commit will introduce vmlinux.unstripped but I want to
> keep the name of the map file.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>
>  scripts/link-vmlinux.sh | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index e55026128e05..7cbbfa3efbca 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -98,8 +98,8 @@ vmlinux_link()
>                 ldflags=3D"${ldflags} ${wl}--strip-debug"
>         fi
>
> -       if is_enabled CONFIG_VMLINUX_MAP; then
> -               ldflags=3D"${ldflags} ${wl}-Map=3D${output}.map"
> +       if [ -n "${generate_map}" ];  then
> +               ldflags=3D"${ldflags} ${wl}-Map=3Dvmlinux.map"
>         fi
>
>         ${ld} ${ldflags} -o ${output}                                   \
> @@ -211,6 +211,7 @@ fi
>  btf_vmlinux_bin_o=3D
>  kallsymso=3D
>  strip_debug=3D
> +generate_map=3D
>
>  if is_enabled CONFIG_KALLSYMS; then
>         true > .tmp_vmlinux0.syms
> @@ -279,6 +280,10 @@ fi
>
>  strip_debug=3D
>
> +if is_enabled CONFIG_VMLINUX_MAP; then
> +       generate_map=3D1
> +fi
> +
>  vmlinux_link "${VMLINUX}"
>
>  # fill in BTF IDs
> --
> 2.43.0
>

