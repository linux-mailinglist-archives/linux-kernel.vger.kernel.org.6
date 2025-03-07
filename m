Return-Path: <linux-kernel+bounces-552008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D794A573F6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787EF16939C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1626021A456;
	Fri,  7 Mar 2025 21:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PeTyds/Y"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BB11A239A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 21:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741384062; cv=none; b=d1GISs46sZWzQOnpQKObjQa8kVFVvB/+yL5PGyA/qVtJn76yfi7dytwSk2ShXgdZaGhA79avYsOplLv7hSpdJbD2wqMDd+CupWZoKkcIa2ZMTfXV0kl6Csuy6wZPa1F9PwgXVbyn8OoskJScU5f1rMljHAwrfsFBgrdrgnaI6KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741384062; c=relaxed/simple;
	bh=5SlHf/j+MxulukGiEuxyngzhk509+mhRku8ndimaR/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dr3ouqmJPC4Pd9uPPgcszGfUxHxH/4C/ljHbnbf8+6ZOsuLZaEK2vV8Dv/okVSIvdWGqTDSV1w5+yTt8JR4coDmRTdDs82AhEa/GjOE+KfJY7oWWlK/kxMJ+mDnzvF/mMX+efx0v7bx2gLTgTYVzBVKb/EPodT5j7kLs35LIFso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PeTyds/Y; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e573136107bso2022218276.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 13:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741384059; x=1741988859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMZSxFoi6f7PWqlB1UKx8jVewEGITwIyJyqUhCV0Las=;
        b=PeTyds/YRZaOKyWEvKKluUqD02sp5Ucg1ZypKlCC4qzl2W0I1eERLLb5NORq/zONsW
         9VMHs2Jm7l9UDaBEy3XNzQ8oxheOux3LDPcYasi+pZGrB8rzh2A4rEbEjkIa5kKJhFHc
         x3nCuszI3YEgK/Fmb/h+cHmeJk/jicUPH4Ph2Qqor0iz3HIQCX0qDLYB0/LEXarEWiGu
         fgXFzXbsxIqGtmRpGq9frH3JvvWqLODoy+xHeGPSZpa5POGIdNorNyYeo3D3qX0dLfeh
         qk6sJoVol0THmL4CMgLt48ayLVmQPrINNl/sHSQqAUmUEMxJOBsqTn4185khl+0FOETw
         r4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741384059; x=1741988859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMZSxFoi6f7PWqlB1UKx8jVewEGITwIyJyqUhCV0Las=;
        b=JtbmAq9gDh68jOay8s50egr+5UuUjHgTA4+f9xXtWHuJIdl8nKaaWsX15RmYMY6z/w
         fP9aA4+/RFwu/9CQVY7JvR530a5YMcBfB1w4wPYgnFFLywa6QGhr9NFKb39Ir1theRf/
         t5guKtXQpfm8gIX9tTgCQvSMlv3aLxf2qdKiXzyFPA+aidUmdR1QrbwsOLvkbFRhIDhQ
         b7y+ZiUf8B6jHN5yLHOR6icI7ByuiW/th5g7SNV9wBmBUEtVjf5VNZIXaHo6GROWbiJ6
         FmFJpS3MWHxAWoOa2gr01B67gJyMJtN9CKUZqphtHqZ69Wg/UQy488ljpFSgstHY+kvp
         PGCg==
X-Forwarded-Encrypted: i=1; AJvYcCVo5zn9MxtqFptbNsFI1wf+1r9vszPEBXpsP4Tu9ersJWzJL7kswisRevH178V8VnZnDlpOxcpoOQDdLZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy1rqTBRw9nJ66QShnJoePsTtM4xONV/rA3mMImEFH55sqCua6
	eWY0hkYpWOSO19+QOe8VGOz5/Uhs6C6jkfeXlLdKeETdTU0SaVcD0+jsuUhwO0WHocBxgTTwter
	vSb73Xr6cb0/lBGPKYx6VO0CKjdvgY40qgfYa
X-Gm-Gg: ASbGnctwcFTZ0TaNQrOLaLGB+ePOgGILY00V3WvilIsNjIZPd+z8Xjr0tru7bahlAXL
	kIf4FG+9ChdDNPyYgAwkU/fsSQz/cZZFGyDIAITCxY2k41YnGnd1UauPjdyiQ49/amxl/w36CUB
	ycbfecvmVPouK6KPOQnf/tIk0jjA==
X-Google-Smtp-Source: AGHT+IEcSv7KnFplQDoJAzSnv6OCFFu3SqXY9ZAVwkGHVMz9+vJYZBnkjrWTKmrQW0KqO3a/jWFEzcl+IcxOBSAP5Fo=
X-Received: by 2002:a05:690c:74c6:b0:6f9:8605:ec98 with SMTP id
 00721157ae682-6febf3afe8dmr69020767b3.28.1741384059104; Fri, 07 Mar 2025
 13:47:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303200212.3294679-1-dualli@chromium.org> <20250303200212.3294679-2-dualli@chromium.org>
In-Reply-To: <20250303200212.3294679-2-dualli@chromium.org>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 7 Mar 2025 16:47:28 -0500
X-Gm-Features: AQ5f1Jrw6DpflBp7nmSaYvneP_J8K-vWp_dYABd5t8DUNhQRxL3G83QnXuzfnEI
Message-ID: <CAHC9VhRiZS2Dh+0-GqHE+um7T05p4_=EXG7tOtC5pciWMteDDw@mail.gmail.com>
Subject: Re: [PATCH v16 1/3] lsm, selinux: Add setup_report permission to binder
To: Li Li <dualli@chromium.org>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	donald.hunter@gmail.com, gregkh@linuxfoundation.org, arve@android.com, 
	tkjos@android.com, maco@android.com, joel@joelfernandes.org, 
	brauner@kernel.org, cmllamas@google.com, surenb@google.com, 
	omosnace@redhat.com, shuah@kernel.org, arnd@arndb.de, masahiroy@kernel.org, 
	bagasdotme@gmail.com, horms@kernel.org, tweek@google.com, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, selinux@vger.kernel.org, hridya@google.com, 
	smoreland@google.com, ynaffit@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 3:02=E2=80=AFPM Li Li <dualli@chromium.org> wrote:
>
> From: Thi=C3=A9baud Weksteen <tweek@google.com>
>
> Introduce a new permission "setup_report" to the "binder" class.
> This persmission controls the ability to set up the binder generic
> netlink driver to report certain binder transactions.
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> Signed-off-by: Li Li <dualli@google.com>
> ---
>  include/linux/lsm_hook_defs.h       |  1 +
>  include/linux/security.h            |  6 ++++++
>  security/security.c                 | 13 +++++++++++++
>  security/selinux/hooks.c            |  7 +++++++
>  security/selinux/include/classmap.h |  3 ++-
>  5 files changed, 29 insertions(+), 1 deletion(-)

...

> diff --git a/security/security.c b/security/security.c
> index 8aa839232c73..382e3bbab215 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1043,6 +1043,19 @@ int security_binder_transfer_file(const struct cre=
d *from,
>         return call_int_hook(binder_transfer_file, from, to, file);
>  }
>
> +/**
> + * security_binder_setup_report() - Check if process allowed to set up b=
inder reports.

Please keep the line length in the LSM and SELinux code to 80
characters or less.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 0d958f38ff9f..2fafa8feafdf 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2092,6 +2092,12 @@ static int selinux_binder_transfer_file(const stru=
ct cred *from,
>                             &ad);
>  }
>
> +static int selinux_binder_setup_report(const struct cred *to)
> +{
> +       return avc_has_perm(current_sid(), cred_sid(to), SECCLASS_BINDER,
> +                           BINDER__SETUP_REPORT, NULL);
> +}

There should also be an associated patch{set} against the
selinux-testsuite to add tests for the binder/setup_report permission
introduced here.  My apologies if you've already posted one, but I'm
looking now and I don't see anything either on the lists or on GH.

* https://github.com/SELinuxProject/selinux-testsuite

--=20
paul-moore.com

