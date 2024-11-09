Return-Path: <linux-kernel+bounces-403029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3F49C2FC8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 23:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D761F2181D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 22:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDB71A0BC0;
	Sat,  9 Nov 2024 22:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdZqsOo2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B4C4437C;
	Sat,  9 Nov 2024 22:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731190886; cv=none; b=fkUBezxq12tqJoE8yEyFo5MGy9N7uJN/QxzTKS/S7z93z7C2KvnV6wcm8tfYSfDUEzSxmmbyXZYbQCc16Smehq3Xi3hIf8yvpcaU9CDlpBEWGe+t98xWj2mH8fo9Kvrok3WQm7b0ZkCccgW6x26ZXbFGskoUDnMC2oll8xlfh0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731190886; c=relaxed/simple;
	bh=8hQIsWT8w2YiPM+AgWA2e3JBzVVePZzXMN166L0C1yU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eb8MiTnVfIRYt4miGu2u2hW/JAjhuFpXSYYk0fH40BM4KIhedDhJvsw+NjK/w7vpntROPWt1NINGw46sb5prr4tz9A4E2rvetok+dVsmc5Apw//AlKct6NgtB3AEFfINCqSzl5StdKE9ZjnEFxl+wk0uXQNW8e0LQlT1PQ6KRkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdZqsOo2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9142DC4CED2;
	Sat,  9 Nov 2024 22:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731190885;
	bh=8hQIsWT8w2YiPM+AgWA2e3JBzVVePZzXMN166L0C1yU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RdZqsOo24pu/4mg2t6cyd+8tTXZUCcBukqFFdEJaIDBLWiYvImW4B/QcnNngxDn23
	 Tqx7bptZOwvdxuiP7+gc5otJt3rXseMxwdBCIi16wLlZj8nPLlYiUn4LK7IxSNJjde
	 sHtCc5cSpZ9IDejtcHWAXFZkLi63xECSNiSaFJMwBXmQnxi3vFJEn0xoA8pSXgmOoo
	 zNGha119JO43BDrlNX8+6xU3rrkN2OLo86oIhp2sa+OmIZ+8Wn/MYimXzBx87VGYcr
	 J1goIh1R55WOO0ycQqyUPL1EYXJIPK7h5fFfkJ1EmzD4kOH6I3MykQYe6CBFjS0dPk
	 9iKSYvxwnwxUg==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb498a92f6so26158321fa.1;
        Sat, 09 Nov 2024 14:21:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUOAYIIoWcd8KkJWk8j7JMMW5ti5+aFwaO3govNrDue1ROac0IGDfvmws2L87F7iywEt/FMu2sQGPL03EY=@vger.kernel.org, AJvYcCXXYd1Oda9mIUrLNpNTTLm/hDC6Wa4bpHkFtxNUUPGDjeplS1mUoH6z5ZhWHO/NsLz6D2kKPTgnyQZ4SVJr@vger.kernel.org
X-Gm-Message-State: AOJu0YzdFhLb8XXFNKVceQMvvLeK0VcqiNEuZZShoyiMOp0TmAGg8Iw+
	kiPWHsBSLg3NVYIsXszRy71yq+Xzvlq86Is7XQo76NMTNV12+JTtDbZsJkiLMA/iET7Hj9SJh0G
	qMvue7r1rkHaZOGexx41PZ+pHKzU=
X-Google-Smtp-Source: AGHT+IFz2JBDoKriPrqZwho8VhGAsHBy+K2ddEcnTEDzs8JVe9Rppe6vMdNd8ZqbZASsQgblUyXq3OGJh7z+q0AugKw=
X-Received: by 2002:a05:651c:1506:b0:2fb:7e65:cb27 with SMTP id
 38308e7fff4ca-2ff201e73a4mr37414341fa.6.1731190884239; Sat, 09 Nov 2024
 14:21:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031132630.24667-1-t.boehler@kunbus.com> <20241031132630.24667-3-t.boehler@kunbus.com>
In-Reply-To: <20241031132630.24667-3-t.boehler@kunbus.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 10 Nov 2024 07:20:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNATED9GeR_0DP_nrqahLOrz_4gwB0X9hm5gBVta4oyBrog@mail.gmail.com>
Message-ID: <CAK7LNATED9GeR_0DP_nrqahLOrz_4gwB0X9hm5gBVta4oyBrog@mail.gmail.com>
Subject: Re: [PATCH 2/3] package: debian: add missing Depends to linux-headers
To: =?UTF-8?Q?Thomas_B=C3=B6hler?= <t.boehler@kunbus.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Philipp Rosenberger <p.rosenberger@kunbus.com>, 
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please use "kbuild: deb-pkg:" as the commit subject.

On Thu, Oct 31, 2024 at 10:26=E2=80=AFPM Thomas B=C3=B6hler <t.boehler@kunb=
us.com> wrote:
>
> The linux-headers package is missing a dependency to libc. Lintian
> complains about this as well:
>
>     W: linux-headers-6.12.0-rc4-g7e04fcfc6195: undeclared-elf-prerequisit=
es (libc.so.6) [usr/src/linux-headers-6.12.0-rc4-g7e04fcfc6195/scripts/asn1=
_compiler]
>     W: linux-headers-6.12.0-rc4-g7e04fcfc6195: undeclared-elf-prerequisit=
es (libc.so.6) [usr/src/linux-headers-6.12.0-rc4-g7e04fcfc6195/scripts/basi=
c/fixdep]
>     W: linux-headers-6.12.0-rc4-g7e04fcfc6195: undeclared-elf-prerequisit=
es (libc.so.6) [usr/src/linux-headers-6.12.0-rc4-g7e04fcfc6195/scripts/kall=
syms]
>     W: linux-headers-6.12.0-rc4-g7e04fcfc6195: undeclared-elf-prerequisit=
es (libc.so.6) [usr/src/linux-headers-6.12.0-rc4-g7e04fcfc6195/scripts/mod/=
modpost]
>     W: linux-headers-6.12.0-rc4-g7e04fcfc6195: undeclared-elf-prerequisit=
es (libc.so.6) [usr/src/linux-headers-6.12.0-rc4-g7e04fcfc6195/scripts/sort=
table]


Could you add log messages based on linux-headers-6.12.0-rc6 instead?
Then, the line length will become shorter.

Also, please rebase this on the mainline.



> Fix this by introducing "dh_shlibdeps" into the build process. It
> calculates shared library dependencies for packages and creates a
> substvar entry for them, making them usable in "debian/control" by
> specifying "${shlibs:Depends}" in the "Depends" field.
>
> "dh_shlibdeps" detects the dependency on libc for the linux-headers
> package and by specifying the substvar for the linux-headers package in
> "debian/control" this dependency is correctly declared and lintian won't
> complain about it anymore.
>
> Signed-off-by: Thomas B=C3=B6hler <t.boehler@kunbus.com>









--
Best Regards
Masahiro Yamada

