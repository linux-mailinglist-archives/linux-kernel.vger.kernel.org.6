Return-Path: <linux-kernel+bounces-368319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 284649A0E38
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6C151F237ED
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7E920E010;
	Wed, 16 Oct 2024 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UPHqVg1D"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE37415C13E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729092676; cv=none; b=a9ZQMax8Q58i1ELfC1ls/GlhyZT+4QX6Gy4L88oyZfovzgrOO2hPUfU+s++82OjJ5kiR2bB1IEgUvG2PJRaGSoZbkwuFcZk6Q0qk//m+62k0g5zc0NKeQ1Ie3VblU9/H0Q/ON8+o8eUOEgNxLSaZAwYXz4vKMgNKthQfc+d9IO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729092676; c=relaxed/simple;
	bh=AOxl2wh5CifbeV75OtFSnWg0hVwy8Qulf/lxjcWEdE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CU1+RATKefickVp94VRFR3T2OrPLovWd1lvCzW0OMubLwwLYrmj2U1KVGWG2aNm3BKMzP1bMZgj1Q4qdpJX3pTJLnAlANg78clXuIlPUA8lLPePT4E65fdI2O9U9m2/iBiAwww5llVv3azNldnvIL/xry5aTg/aY8GkT7w5vSX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UPHqVg1D; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-45fb0ebb1d0so321801cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729092674; x=1729697474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNH8n7vAXNpqv161ekyIO/QtlJw3I0M1vcXsx9q3jBs=;
        b=UPHqVg1Dg4HseRGTELeNuilObArfTQoEmXEEoL6XWq5cKGkCAH1TUplec8Gx4IexmY
         5yLTUcMtlZVjNqy8paLPlyWqnuDdkYcSxZWFm+9zY6vdv95XFsSG7g1b3invxUwV2Z9W
         I4aMihbqT2nvFWm5/9SaCVjqRSepGqqVTBwSbK36dYqPvl4jx2X6rW/vJ24B6LaSontn
         bvzkGYtJ1OK9IorqFGoyUR5PBOdu6EVyFxP3tCfxh31GFwALmyQHz06JNqUsNW/lYx56
         RxfunDblqZ1Ov4SPHM+CbWVbTP8DemyZ9BEoFWj4qL6JHgIFrdPSMi7oWsWsZOKgZaxm
         DsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729092674; x=1729697474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNH8n7vAXNpqv161ekyIO/QtlJw3I0M1vcXsx9q3jBs=;
        b=IwZh5ua+9VEn70U63NznPgARgL088+RUKGE1XrDnVBUcK5cVXlEtVw+JH0F3ibPvIp
         V60xT6KvTWgM0ZmdFkav+0cxRyLWFiwZzOFsO2ENeIBHJRREgf9987BmOL8LeAHvEjld
         ENeU+63/QaMYDXLGTxa72zan7oKb+5xqCeDD4JdjDeN5ZkMhZvk88QtnhLtgxXAcQAAn
         uIBjfqowEC+/+rN4VTlzx0GjC8dIBQJsb45yelOJaLRLgCwCL4fLfO3HeGcIR3dbu0OR
         1uBe6twFTUcf8599rQc7N+Ns8YPzkCQu1b6upycVNCYuyucpKAYFtmTJBwptffw8KEN5
         3nIg==
X-Forwarded-Encrypted: i=1; AJvYcCWtt/U1uI+PweLpvaz37+3HOUUFNvKhNIBWDhe8JPo3e8mq3jljBSIuSh8JmCggBzqpfwxd5GFx8WW9ylU=@vger.kernel.org
X-Gm-Message-State: AOJu0YztaicqHP4CxI/U6OP3qKvL9KpOgGy5Xylrd1aH0v6jxh5Z7RbY
	3rELh/Ud0PUbKuKUPnx3Dpu0BeDaIhzr6hBL+7S3dIWuiQy22k2SVUX2jlwqBxKv4VUmdnWkOmU
	DzZALoptxBYCc/P+pyxfiwv1bUoMqTSkBBXu/
X-Google-Smtp-Source: AGHT+IGudMHXsmYGzzbu6wtwlVBO8hVujna9DcXSZGz9gZBzYtahTCs4wrRVyVY5zJ1Yb7n2KSm2tObymWH0InDaTYM=
X-Received: by 2002:a05:622a:468d:b0:460:47af:e3c8 with SMTP id
 d75a77b69052e-4608db3511bmr5992071cf.4.1729092673380; Wed, 16 Oct 2024
 08:31:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <52ee32c0c92afc4d3263cea1f8a1cdc809728aff.1729088288.git.linux@leemhuis.info>
In-Reply-To: <52ee32c0c92afc4d3263cea1f8a1cdc809728aff.1729088288.git.linux@leemhuis.info>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 16 Oct 2024 08:30:34 -0700
Message-ID: <CABCJKuf_s54EhYO1-j20VgHGC8AJ44cug6773XZ673eukUsLxA@mail.gmail.com>
Subject: Re: [PATCH v2] module: sign with sha512 instead of sha1 by default
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thorsten,

On Wed, Oct 16, 2024 at 7:18=E2=80=AFAM Thorsten Leemhuis <linux@leemhuis.i=
nfo> wrote:
>
> Switch away from using sha1 for module signing by default and use the
> more modern sha512 instead, which is what among others Arch, Fedora,
> RHEL, and Ubuntu are currently using for their kernels.
>
> Sha1 has not been considered secure against well-funded opponents since
> 2005[1]; since 2011 the NIST and other organizations furthermore
> recommended its replacement[2]. This is why OpenSSL on RHEL9, Fedora
> Linux 41+[3], and likely some other current and future distributions
> reject the creation of sha1 signatures, which leads to a build error of
> allmodconfig configurations:
>
>   80A20474797F0000:error:03000098:digital envelope routines:do_sigver_ini=
t:invalid digest:crypto/evp/m_sigver.c:342:
>   make[4]: *** [.../certs/Makefile:53: certs/signing_key.pem] Error 1
>   make[4]: *** Deleting file 'certs/signing_key.pem'
>   make[4]: *** Waiting for unfinished jobs....
>   make[3]: *** [.../scripts/Makefile.build:478: certs] Error 2
>   make[2]: *** [.../Makefile:1936: .] Error 2
>   make[1]: *** [.../Makefile:224: __sub-make] Error 2
>   make[1]: Leaving directory '...'
>   make: *** [Makefile:224: __sub-make] Error 2
>
> This change makes allmodconfig work again and sets a default that is
> more appropriate for current and future users, too.
>
> Link: https://www.schneier.com/blog/archives/2005/02/cryptanalysis_o.html=
 [1]
> Link: https://csrc.nist.gov/projects/hash-functions [2]
> Link: https://fedoraproject.org/wiki/Changes/OpenSSLDistrustsha1SigVer [3=
]
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>
> v2:
> * use 'default MODULE_SIG_SHA512' in the "Hash algorithm to sign
>   modules" choice instead of resorting the entries there.
> * rewrite patch description
> * drop RFC tag
>
> v1: https://lore.kernel.org/all/42aa307d7ffae1851b4a8787f5c276dd0b3beece.=
1728543368.git.linux@leemhuis.info/
> ---
>  kernel/module/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
> index 7c6588148d42d3..0c746a150e34e2 100644
> --- a/kernel/module/Kconfig
> +++ b/kernel/module/Kconfig
> @@ -231,6 +231,7 @@ comment "Do not forget to sign required modules with =
scripts/sign-file"
>  choice
>         prompt "Hash algorithm to sign modules"
>         depends on MODULE_SIG || IMA_APPRAISE_MODSIG
> +       default MODULE_SIG_SHA512
>         help
>           This determines which sort of hashing algorithm will be used du=
ring
>           signature generation.  This algorithm _must_ be built into the =
kernel

This looks good to me. Thank you for the patch!

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami

