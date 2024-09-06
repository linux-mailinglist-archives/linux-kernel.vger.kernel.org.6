Return-Path: <linux-kernel+bounces-319337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C0896FB4D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA90286EC6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC34814A4D6;
	Fri,  6 Sep 2024 18:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aBFDmmXD"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDB013B7A1
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 18:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725647864; cv=none; b=brWJNyPgc3WmetjY8sEjAXv1OUO7dUvnhnNFi8+ZOsP5zTPb30wc419Pmt2TthSI57apKQtSX/cBX+8SSVF1ulZSTtIsyiA5rO+0heS1LEe8yW+/rSGTGdUZLoLyvbSdN1cHZ9ojGD5DOrqVOQQZdetXRA1zsVUJKTR/4ei9Rcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725647864; c=relaxed/simple;
	bh=Sb099loroznid82TL6UsRgewEF5E6va4NMgy9gU+6FA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ujkd3VZFjyjo0RVFrRVetxAY8qbcqtMGQdbZiy52dBkIB945tJaKHwqVLYIOeWbrp1UrDS+VtB6oLSUdrseRbRfTWy3M6a/lEs2vn2D7V0/pQaYz1NwLkutOTvgCNIBLpGvuuGJXSHwkdi+wjM2TlPRcz3GdDp1R15DxQaTQyoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aBFDmmXD; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e1d4368ad91so266064276.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 11:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725647861; x=1726252661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0Sop3gGbpp7a02AwhDEi9yeUAD7zkHPXJcezmo9CH4=;
        b=aBFDmmXDgrQWRc10Ynfmo5YJHQZcHQSO4mZLRsqy2uVajMUglHnqskDoEBcQ2eGEY3
         5l2BSeOgg31thm/79MERR4NeZX3iy8w/nEDwCDjSWzPmSovYL3juOGdINmFd0Kv3hied
         3JGAj4yOK2HqTlQFOyWgczxjxa701690EzjKAiGDfrDGVm3veZt2Lc2G8Utb/zOqNe0H
         ljEzPhrZmYXN0cUF0+Pn6Nbd0bQ08hEr32PaUyxDg06VVW1s0QxXCBZlsuj6JN4AgIVK
         uyfuu/Uxw0Wwr/QXAil3wrKJKUkW5eTgOgHeD19IpvAt10jhwxrjYWPSGVXDYOnzCSQP
         fkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725647861; x=1726252661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0Sop3gGbpp7a02AwhDEi9yeUAD7zkHPXJcezmo9CH4=;
        b=ey9L0g6Zcxw9HIt1HKk/w5tA5/I3t/ku204FC3OHgjxUVSbjg1rK1BeS5TbYMkzI7z
         q6D41zviVJEPn4renoqryqHbpeyWZDu7E6vprG+dQoMYfAgs3uoXQyVqBesOqJigzGg5
         yAFpMkLUAZXNuwNahbZpu2f5xHv4nFZ/UuU6fYbS50N9sOHIIeo6snD9ep2Qcl0Px6Gd
         cObA5rgzVMwLhFirHEuimczEHBRW0vuMc4ZeJz30wuqcQ58Zarq/bPqSJXClzChib8rW
         igfcdPUDbvtDakc/5oqaNn4L1Eo5iH7D2rE9zsWFupwtCqAG+Lv+GVIZGaoUn2phQ7jm
         aXrw==
X-Forwarded-Encrypted: i=1; AJvYcCXpyHmjmPk92jhgRoPq4O6Lw7GfBJbHi6Fh9wKImnbPHSlffif1B31gqxqgb3rFsVnryVUzqvLq98yU7U4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhaqNqNPDsaFhsdn1oBRhcvwzx/PhV1g0zOkezLFETago2c2gP
	3E7WuSCAuijSB5Cc3JhkzixYaYnbrn41qL0LaOkgB9me1a7mNv6HFYnigHDa1P4uLiMZ903aBqt
	XyzaREyvBbo9C5ed1sIRb2SSpMWHc8Z4lPnS+x0VYv/j4tqo=
X-Google-Smtp-Source: AGHT+IHjKcURSSTe8+mNfV7/rYJRSAMCbEJs8d/CYDWZBuHCRS3PlIcMmTQ+exX7EfBuG4GWLrr6QA4wI3Ns8dtM1Ao=
X-Received: by 2002:a05:690c:386:b0:64b:b7e:3313 with SMTP id
 00721157ae682-6db442e2f43mr37012147b3.13.1725647861559; Fri, 06 Sep 2024
 11:37:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906172934.1317830-1-masahiroy@kernel.org> <20240906172934.1317830-2-masahiroy@kernel.org>
In-Reply-To: <20240906172934.1317830-2-masahiroy@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 6 Sep 2024 14:37:31 -0400
Message-ID: <CAHC9VhQ+2miDE0Z99ymYAk76_C0O0aAH07swwhSPWn1uCH9hBA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selinux: move genheaders to security/selinux/
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	selinux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Daniel Gomez <da.gomez@samsung.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 1:29=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> This tool is only used in security/selinux/Makefile.
>
> Move it to security/selinux/ so that 'make clean' can clean it up.
>
> Please note 'make clean' does not clean scripts/ because tools under
> scripts/ are often used for external module builds. Obviously, genheaders
> is not the case here.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> Changes in v2:
>   - Add more reason to move genheaders to security/selinux/
>
>  scripts/remove-stale-files                                 | 3 +++
>  scripts/selinux/Makefile                                   | 2 +-
>  scripts/selinux/genheaders/.gitignore                      | 2 --
>  scripts/selinux/genheaders/Makefile                        | 3 ---
>  security/selinux/.gitignore                                | 1 +
>  security/selinux/Makefile                                  | 7 +++++--
>  .../selinux/genheaders =3D> security/selinux}/genheaders.c   | 0
>  7 files changed, 10 insertions(+), 8 deletions(-)
>  delete mode 100644 scripts/selinux/genheaders/.gitignore
>  delete mode 100644 scripts/selinux/genheaders/Makefile
>  rename {scripts/selinux/genheaders =3D> security/selinux}/genheaders.c (=
100%)

Better, thank you.  See my comments on patch 1/2 for when you can
expect this to be merged into the SELinux tree.

--=20
paul-moore.com

