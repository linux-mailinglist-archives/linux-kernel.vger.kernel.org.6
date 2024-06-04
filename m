Return-Path: <linux-kernel+bounces-201372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813218FBDA7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2C0C1C23F76
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AD114BFA2;
	Tue,  4 Jun 2024 21:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fckzWAuQ"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D8114BF91
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 21:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717534810; cv=none; b=U2K3VCDE4qWnA+xAWVNeiXj7B+QZMokzRnjHh4ZzcEe1cIuFgB3De/l8IEx0HxfTeLzdRkC0cZ17pVCQX98Vpzdm/cTsnzonrLVVBKBJiEgM+Hq/GD6GjiFARH1ukSBuMKmTm16A0/uouV2OG6rcVYcRzYdvdYVnTBiy5iM9SfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717534810; c=relaxed/simple;
	bh=hvtn9Rpj72ax2PdS3Q2rjLwwSeA6zCTzR5nXK72FyUA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W9ik4TSS2zKCNMJAK+1zmLKTnNaeWR+j84VpN98j1h9uKCvhFp50qmdUbdENPxyTSy+T9pFg2Kbf3Exd/RmwI03tAcD1E6/aLeOxz8NA04MEvsf5UNOjvpcolPld+iRpdSQHKGwnKPLRqr6FjMPRC+fKs50soRdsZp6YBG6BNkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fckzWAuQ; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e73359b900so16417051fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 14:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717534807; x=1718139607; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hvtn9Rpj72ax2PdS3Q2rjLwwSeA6zCTzR5nXK72FyUA=;
        b=fckzWAuQjbPzZrK6prfoRK4QrdBzLLr3qVo4MHCWBbUiaG+XyFZjRTB/OHXCJBSOjH
         +XaR6KOHGMP3GFk45ZX1sllKgun2JfBz0wHB9IKrMtvP8l5vl8JGhbuAkorFO6tYYvwC
         ANYLJHwB3/0Jh+JX9K11qkvG4maDgdAD+EbjEeTO20vB1lT+Kvigadan4bciluZGU4HY
         P3XsDOjarxj8LZpo95Azq7NU7yAYuG4Vx6KSA7ZtmEvo7+ZGcLFtiAsUczQ54hkGOkRy
         4in3oRZSVDTAHQm4dM19hOEhKTrYpphOzZCFW0AfSwqSMugeerbtECfuDFfmUQqu+b52
         5rlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717534807; x=1718139607;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hvtn9Rpj72ax2PdS3Q2rjLwwSeA6zCTzR5nXK72FyUA=;
        b=QHND2sPDHAVx5Ign/vg+4FzQBeCTRNwWqx9WUobNUBgGwWq32qV4UNUIbAcBHsZ/8c
         0XEZKO6HnlAc+Xmj9byi/CQyManGAMx4o3aH5PMwbCynspQHI46ZyU+s7ZjWvkQPgwT5
         LbzK10ZfCvVt+qAqlaiY/sbQ5sEQg9XfVo1U+lasZglzuKVVsRyjG8Y1V43sKgQ72qLu
         Y2DBMhHTWgnEsjCufi73Qg4ZuF9Z+4KHjv04TP6jd56VzmyIr7xkhtnx+FDmK/F2sD3i
         mvi17rDvqeV+8TbJJCNM1vRBOQG9Vd0stOV5BOC+v/jk1GpcLgKEV6Q1OUHTxv98XR2S
         v32g==
X-Forwarded-Encrypted: i=1; AJvYcCUMDci65wZTZZBgfX4jk74Vm3qVT5zYDbC5FCi76Q3IC+OhRnzstuvFlQBg8VTRp5iMuTkFIlQo3/PDhY2kkTIoVtperIkaNAvJXauz
X-Gm-Message-State: AOJu0YwlwxqaQPynzIjGquKfmchTqqiSTVTjcwUUmWOr97S1+LZMA1jV
	fNNdR4CetS+4+NhvMBq5RYSCuYN9EzT+qFFd4eOYF2nf+JeFUZY/pvUpaB+117U=
X-Google-Smtp-Source: AGHT+IGNXY3i+FkcN4+0E6sb8vV5qlhvrzKI0eFOmCcYWLdRzRhWMrQ9qyPJs+PKngvyd4yPLeMdJA==
X-Received: by 2002:a2e:9187:0:b0:2ea:853f:18e4 with SMTP id 38308e7fff4ca-2eac7a11f96mr1893901fa.13.1717534806839;
        Tue, 04 Jun 2024 14:00:06 -0700 (PDT)
Received: from ?IPv6:2804:5078:851:4000:58f2:fc97:371f:2? ([2804:5078:851:4000:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c354e744a0sm7435493a12.30.2024.06.04.14.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 14:00:06 -0700 (PDT)
Message-ID: <d98580bc15fd358a1bdfdbc95b94ca02f97324bc.camel@suse.com>
Subject: Re: [PATCH v3] selftests: livepatch: Test atomic replace against
 multiple modules
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, Shuah Khan
 <shuah@kernel.org>,  live-patching@vger.kernel.org,
 linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Tue, 04 Jun 2024 17:59:48 -0300
In-Reply-To: <Zl9YoIAy+1bEnHCB@redhat.com>
References: <20240603-lp-atomic-replace-v3-1-9f3b8ace5c9f@suse.com>
	 <Zl9YoIAy+1bEnHCB@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-04 at 14:10 -0400, Joe Lawrence wrote:
> On Mon, Jun 03, 2024 at 02:26:19PM -0300, Marcos Paulo de Souza
> wrote:
> > Adapt the current test-livepatch.sh script to account the number of
> > applied livepatches and ensure that an atomic replace livepatch
> > disables
> > all previously applied livepatches.
> >=20
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > ---
> > Changes since v2:
> > * Used variables to stop the name of other livepatches applied to
> > test
> > =C2=A0 the atomic replace. (Joe)
> >=20
> > Changes since v1:
> > * Added checks in the existing test-livepatch.sh instead of
> > creating a
> > =C2=A0 new test file. (Joe)
> > * Fixed issues reported by ShellCheck (Joe)
> > ---
> > Changes in v3:
> > - EDITME: describe what is new in this series revision.
> > - EDITME: use bulletpoints and terse descriptions.
> > - Link to v2:
> > https://lore.kernel.org/r/20240525-lp-atomic-replace-v2-1-142199bb65a1@=
suse.com
> > ---
> > =C2=A0.../testing/selftests/livepatch/test-livepatch.sh=C2=A0 | 138
> > +++++++++++++--------
> > =C2=A01 file changed, 89 insertions(+), 49 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/livepatch/test-livepatch.sh
> > b/tools/testing/selftests/livepatch/test-livepatch.sh
> > index e3455a6b1158..ca770b8c62fc 100755
> > --- a/tools/testing/selftests/livepatch/test-livepatch.sh
> > +++ b/tools/testing/selftests/livepatch/test-livepatch.sh
> > =C2=A0
> > [ ... snip ... ]
> > =C2=A0
> > =C2=A0# - load a livepatch that modifies the output from /proc/cmdline
> > and
> > =C2=A0#=C2=A0=C2=A0 verify correct behavior
> > -# - load an atomic replace livepatch and verify that only the
> > second is active
> > -# - remove the first livepatch and verify that the atomic replace
> > livepatch
> > -#=C2=A0=C2=A0 is still active
> > +# - load two addtional livepatches and check the number of
> > livepatch modules
>=20
> nit: s/addtional/additional as Miroslav spotted in v2
>=20
> Otherwise LGTM,
>=20
> Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

Thanks Joe! I forgot to address Miroslav's comment... Petr, would you
fix it locally?

Thanks!

>=20
> --
> Joe
>=20


