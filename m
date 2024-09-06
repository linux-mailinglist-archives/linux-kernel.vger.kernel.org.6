Return-Path: <linux-kernel+bounces-319080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1858C96F77F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBEFB285DF9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4201D2783;
	Fri,  6 Sep 2024 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fyTRKZDd"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AB51D1F57
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634470; cv=none; b=N4XL+NjJjw38rOEIvNO838PlIyFR1TYrjdKD7THKYmjaKJTp/Eq377Fiiat2nm/UANdS0zj7M3xfj5soeA2V8Pmcfksnpe/YDrnRwDPT0GQy2FwwFUm+xMCh8uGG6G/AOxbGfpXJECgbsBx+8LJKKi7jPOXDvVA8lirPFjqG3/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634470; c=relaxed/simple;
	bh=ClKhqxGbstKanb0/jRi/QInpRewdF+k/fJjdYaHj2XQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDCcnGQCcxIWvIN22LRNMOAssvqq4OeXUntRgH5wAEkuapvevUsUnT0NstAFm1QqDE3qqvUTiXIJNfDuGqBvG8n95GC5232HuYZrNMxPu2Aus6Ucdj4vhGiOCJW9gjcDSkOcwI071X1xOESYmVM1FmhuhP4SkbN/K8apQD6O7FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fyTRKZDd; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-846c5c2a8e9so508973241.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 07:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725634468; x=1726239268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsXB+HsGxSbnX/oa3Y2+uGuA8knOAtnaTuSxqQBTqAQ=;
        b=fyTRKZDdogcCghBgrr3L2QcVm2pjXXgMB/bFbo5J+e75W8IXYV4QQYssaNn78zCVe2
         wk5YDbQMQBfTgCHGDr9bVtJMobBYAyVrw0yOOzD7TzeVcylOspfYGxnYZPudGxraDKkG
         MWvorXgrGeY+OFGVsfHeyvNGQQyCwoKvL07m5SgJDlSG1z12bU/77Qq4Idyj1n0H/kj4
         hacGZ4R2R6PvnqGRDiJCq2/ozRFXeZoSD/SR3In+6deyYpln/B6YPqwF9fBG/84AOsDI
         aHwC5Voca+x6s/0pI5Q1y9DiJuvRH3X/cI78g7gGdnWOIkuyRy3rbXuUNlrtrL4qq6ga
         VV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725634468; x=1726239268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MsXB+HsGxSbnX/oa3Y2+uGuA8knOAtnaTuSxqQBTqAQ=;
        b=PPFj19VYlrLhXaHUnIpFjgd2W+7YMHiF5PiFQC5F6fFSKRGN3/5W8mMiI40D43PI3N
         m9wiBqx9mmkOwcq5KZDmQ0xujBh4CviqhUfjADu+EC1PeLVL92azGCsaNsuvJq+K3M4T
         rMSkqS9f5db4uTp12TNQAFzTJ+VCMeVdsdA97Wegz87qr6MEbdOEuVA86SsB/uIbgz7J
         TMWOdGU0v5R3ChfX3UelikGStBotXbkb/RHdTm1OWFWTopd8aGXlNhipth629Pkgy5Q/
         BOoPw28bZ4whjhk8Z14IP7JFD/kGuaDn+6EhSk+9G7sNe3d1dz1fj4H5nAAGLBTos0zz
         5xWg==
X-Forwarded-Encrypted: i=1; AJvYcCX0dk0E78uqMmtabZY1SUjhudSNv91iN+EHD8e8Xa2dN3fVSF5+jnl5F6Cn75LSiuo01LYScZqxIcyqzJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDNWSsARhwf5uYzg0q/3maz5ejvJV3r5/64Z+GwZmFH9uDpOdR
	fT0Jvak6rKzm4aCFy3ntlzE2mzLkSp7F5nYZnIu1lvPKZtNyCCtXEbFc2yoHfZbvhS+UBCm5Xlw
	Ypr1nuWgqNc4w+NK2ABELTQ4IGiJgm9zTgz3P
X-Google-Smtp-Source: AGHT+IE2ETqS8j5INGhOJuEC0LfB5JoY7mno+WUbnlfQDVox+nEHO2zDE8qlvEGgTlm1b5qEJlJi4b2dA1AvozrG+1Y=
X-Received: by 2002:a05:6122:318d:b0:4f6:c44b:2504 with SMTP id
 71dfb90a1353d-502143c9c06mr2840417e0c.10.1725634467954; Fri, 06 Sep 2024
 07:54:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906-macos-build-support-v2-0-06beff418848@samsung.com> <20240906-macos-build-support-v2-7-06beff418848@samsung.com>
In-Reply-To: <20240906-macos-build-support-v2-7-06beff418848@samsung.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 6 Sep 2024 10:54:16 -0400
Message-ID: <CAHC9VhQkstJ8Ox-T+FLU34s9U0gezRba6bMA-tUPs80u6sVh2g@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] selinux: move genheaders to security/selinux/
To: da.gomez@samsung.com
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Lucas De Marchi <lucas.demarchi@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	William Hubbs <w.d.hubbs@gmail.com>, Chris Brannon <chris@the-brannons.com>, 
	Kirk Reiser <kirk@reisers.ca>, Samuel Thibault <samuel.thibault@ens-lyon.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	speakup@linux-speakup.org, selinux@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-serial@vger.kernel.org, llvm@lists.linux.dev, 
	Finn Behrens <me@kloenk.dev>, "Daniel Gomez (Samsung)" <d+samsung@kruces.com>, gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 7:01=E2=80=AFAM Daniel Gomez via B4 Relay
<devnull+da.gomez.samsung.com@kernel.org> wrote:
>
> From: Masahiro Yamada <masahiroy@kernel.org>
>
> This tool is only used in security/selinux/Makefile.
>
> There is no reason to keep it under scripts/.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>  scripts/remove-stale-files                                    | 3 +++
>  scripts/selinux/Makefile                                      | 2 +-
>  scripts/selinux/genheaders/.gitignore                         | 2 --
>  scripts/selinux/genheaders/Makefile                           | 3 ---
>  security/selinux/.gitignore                                   | 1 +
>  security/selinux/Makefile                                     | 7 +++++-=
-
>  {scripts/selinux/genheaders =3D> security/selinux}/genheaders.c | 0
>  7 files changed, 10 insertions(+), 8 deletions(-)

Did you read my comments on your previous posting of this patch?  Here
is a lore link in case you missed it or it was swallowed by your
inbox:

https://lore.kernel.org/selinux/3447459d08dd7ebb58972129cddf1c44@paul-moore=
.com

Unless there is an serious need for this relocation, and I don't see
one explicitly documented either in this patchset or the previous, I
don't want to see this patch go upstream.

--=20
paul-moore.com

