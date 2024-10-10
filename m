Return-Path: <linux-kernel+bounces-359852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E07999180
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B8C1C20C39
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4638A1F890F;
	Thu, 10 Oct 2024 18:37:04 +0000 (UTC)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1931F890D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728585423; cv=none; b=CpGsfP+VWVzt1L5Rjh7Cj71qeAnW/9ttQ7elX8hNlC5OG52VO/WPmubRb7qhmffkGoNEH+CsHGAQlbh/DRfYJ+RjQDL/akzL1FC/nlD5S3W6p3EiEOiNnuXPOQ6LWdihpm1cK3uLVPwfLDfb0mJKfI2bNioxOkGDzieYX24sexk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728585423; c=relaxed/simple;
	bh=1fqgPsY4xWzmtSr0LtYpHqHzonJNSS+D/ciP54naeio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRS5egtdZa+65m921CsQrWLuFb9HE4M14NBDQLMuiwy8N+/d+Qxk4Jcfo7I2rvkY/zB38yJqrFO3DxTELEYAKuc3cmsh2iCsemG2h+r6qj6W0BOq+ZS/rRZIcz792OO0yLvH8FIr/uK/83Tb1cHgYn4CB1o/oAnqsMfXsct/XEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e2918664a3fso7267276.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728585421; x=1729190221;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0OLFoMEtzz26pr3EndyBRacQNRdwsW2cbVnhICaUYs=;
        b=t8J+vBUplAhGpPlve/mSkOLU/N70za0YvvYwfFsE25rG5YN3dzTtzD0J4166tAcrAY
         rcYSO1f9YKTgTewUbQJ7JxY81B+opL7yMO0jr81hpflAFmamjJzDX7oqk9temkAUQqOF
         rElLGr4YkbGHTQNgvHVgu1BCX+O8Mi7EjDhzCw6GqWXhiALoolTpABE/4zvKRbIc2Fc+
         M2KtcSF5vkT0R9wtEwrxIgbPjM2YQL7cA+QVo96+HabPcN/uvaVRf05DUo95lDxGB5dX
         o6iQrPNhK8rc4gRJbQtzZAnJAcQxeBZXL6GO1Q+oYbTIenimjRfTIi/DUm+3J0KIwigT
         cBAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6uyc2LvCznudwvY/gq22ZY+8tSMU7K287q3+LdIt0gcL7QJywJ4VgUhqTNuP79bPJY2YR3HDF4a3Jwrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqEl9fBxvosXCY/IllSU3JychF4SZ/W/D0ZBcgdgfqorofEurm
	PMY7c6CsPCTB6IO+8tFSRvzI5chcMYcnQ5q+89bFhCTjtYo7Rbcn
X-Google-Smtp-Source: AGHT+IEmt1A4b+pM8MIO6b40abxV+FkUT4OGZgyNAvBnDh8ItkKs9PNArGqB5W1CQTwfBgkR3t1vgA==
X-Received: by 2002:a05:6902:2b81:b0:e20:2900:db41 with SMTP id 3f1490d57ef6-e290b7ee01bmr3371605276.16.1728585421395;
        Thu, 10 Oct 2024 11:37:01 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e290e9284ddsm410559276.0.2024.10.10.11.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 11:37:00 -0700 (PDT)
Date: Thu, 10 Oct 2024 13:36:58 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org, sched-ext@meta.com
Subject: Re: [PATCH 5/6] sched_ext: Move scx_tasks_lock handling into
 scx_task_iter helpers
Message-ID: <20241010183658.GE28209@maniforge>
References: <20241009214411.681233-1-tj@kernel.org>
 <20241009214411.681233-6-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GOSBQZnasTizEKOg"
Content-Disposition: inline
In-Reply-To: <20241009214411.681233-6-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--GOSBQZnasTizEKOg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2024 at 11:41:01AM -1000, Tejun Heo wrote:
> Iterating with scx_task_iter involves scx_tasks_lock and optionally the rq
> lock of the task being iterated. Both locks can be released during iterat=
ion
> and the iteration can be continued after re-grabbing scx_tasks_lock.
> Currently, all lock handling is pushed to the caller which is a bit
> cumbersome and makes it difficult to add lock-aware behaviors. Make the
> scx_task_iter helpers handle scx_tasks_lock.
>=20
> - scx_task_iter_init/scx_taks_iter_exit() now grabs and releases
>   scx_task_lock, respectively. Renamed to
>   scx_task_iter_start/scx_task_iter_stop() to more clearly indicate that
>   there are non-trivial side-effects.
>=20
> - Add __ prefix to scx_task_iter_rq_unlock() to indicate that the function
>   is internal.
>=20
> - Add scx_task_iter_unlock/relock(). The former drops both rq lock (if he=
ld)
>   and scx_tasks_lock and the latter re-locks only scx_tasks_lock.
>=20
> This doesn't cause behavior changes and will be used to implement stall
> avoidance.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>

Thanks for the nice little cleanup.

Acked-by: David Vernet <void@manifault.com>

--GOSBQZnasTizEKOg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZwgeygAKCRBZ5LhpZcTz
ZH3NAP9xX/uhYvHjzVJcBrJCfWfuwY67J7o+AfaUPHMDz9LRmQD/f4LKCpabKgIb
zIPX5lAhzaUZKj/LXIjFNc5QFGN3BAk=
=4Emh
-----END PGP SIGNATURE-----

--GOSBQZnasTizEKOg--

