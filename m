Return-Path: <linux-kernel+bounces-283818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC9394F8FC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 23:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8E761C22086
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3931946D0;
	Mon, 12 Aug 2024 21:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PXun83QS"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F6B1581EB
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 21:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723498387; cv=none; b=gb4kgLjW871PAhknC32FEKpIoqJvaN7B6B0HkmJ4sl61f8JnzFqpK7zTaabkzGgEssTiEq4tqD56G5sOpx51dMMHVh689KR7pgM0+ai6JbYuYcQZx9CNwxFe2EgD4Ej2OJ7R758T0cLqNEom6+sniX5TxkeyYiGfxHuUj3/G4YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723498387; c=relaxed/simple;
	bh=/TMbE2xCGv7wrew5oV+RIsZ5h+1UWwIr8t4KwnXxWtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6H4cTm18ncOhCVrbfi70j+ThC9TTYucME1FlkCBdIS+0WEWVA9PpIyBARzb0dcaxfd0pHs+eIrYjrfAkmtViP//IWZclGFOKPQl7yNrOxgGTzWXRpQ3MiDguknkWvreQ7TxSFy/WZzloL1YYcj9umPQdsHZQHCW4AnnNkrf+i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PXun83QS; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e1144df83c3so70319276.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 14:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723498384; x=1724103184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pug73YoiHV6SY/TCHzy1XMU3Rd6pstZuJEJOvyRAEQc=;
        b=PXun83QSacqQSQkajWxBVDciizclS1iG/4LWOiWDb9WUkmpxX+ngd4ONjRO3M4vTpA
         dVwnchwriUMis28+jxYBrjRl8GVtTAzgng3AuD9k/5fvvGRXXAvvVfIavU1DNIz9DHhH
         6Iz4p8CE/Zd8QUgLnWX/bL7s5/WVxu7mAH3z5kgajhVYOlO6+5qWI6f93oWTVwFl7qnU
         Yvd2rGz9B3pn6lftzIu5Roi/gbeWEYLqiGQ8UiUJ+AZdGRdVoXFot7KAsPz68uaRcCj2
         YdcIxXqGKdn0yEOwv3fO/YkQnKyJmLokaJko5HEazhSQgZVUZdcmrvN0T0iL8CttW3M3
         VJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723498384; x=1724103184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pug73YoiHV6SY/TCHzy1XMU3Rd6pstZuJEJOvyRAEQc=;
        b=aniqmyB/W49A5QKcrhVWO41pFHuT9DMV69wcc8Dn8oZeG2zzQRX2ZGb+xe4B7dmLqH
         EG+8aTe9onhQY4VauTmzkhsdTZkzuGWo+snC8EjRhV6uJORJJU8xrVB5qcax+fYnZ8oc
         FwOsAviLRXZo8b0RJ2Sa5eaj6IsCeJDGdciRoJO4iGAAdea3XLTr2sRsPXgkddh1r7RH
         lYIhbeAR52WjZMlaZMOidwR3Z+x5VeD5rtzvMrGgVCSfJ3H52H49cpDU0DW6uHk/cOqt
         437bv6UFAavl9k4u7tDxkbNl0+bcwiuUwOlLWqSMfx+FdsVLkLd7wyIf7lbRkyURJ0Yu
         fC4w==
X-Forwarded-Encrypted: i=1; AJvYcCXT5WfsoGeYSSNMWcUko1WMTW9R51x5aqwxwbltwff7qZy0M5Zhhp/rgE+cNSPmH9E3jMauhBXsP/tRK0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9486X3h0Jcrgp7ExayR1CQZwbpE8OGC82Wlr9IWfQ5h4Yd+fw
	dDgSoPnIBCxNrDRuc/Q0Bp8ror/cMrXVFW3H0b/2xGh+lhfH0zqQAc9mVdFFvlxbaxBBXsuVLmp
	Lwsl6wlgKGrxBfua2Frt1X5mbpWQ0tm+FS0L4
X-Google-Smtp-Source: AGHT+IEsje0zs7EMogDkhwH6fki59oFH24RIwktUP9hy42N5YeAuKlni18F6AvcgGsRLVc9ohWRXpP024BwJS8QOaQ0=
X-Received: by 2002:a05:6902:1244:b0:e0b:f4e9:160a with SMTP id
 3f1490d57ef6-e113ce66f38mr2324256276.6.1723498384477; Mon, 12 Aug 2024
 14:33:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhQpX-nnBd_aKTg7BxaMqTUZ8juHUsQaQbA=hggePMtxcw@mail.gmail.com>
 <CACYkzJ7rdm6MotCHcM8qLdOFEXrieLqY1voq8EpeRbWA0DFqaQ@mail.gmail.com>
 <CAHC9VhQ1JOJD6Eqvcn98UanH5e+s6wJ4qwWEdym4_ycm+vfxmQ@mail.gmail.com>
 <873b04da-7a1e-47b9-9cfd-81db5d76644d@roeck-us.net> <CAHC9VhTd0MKVXsZ7J_b_Mmr2vP+RMJtxzfsgpH1rZ_hoHY1D3A@mail.gmail.com>
 <779dfb7f-d690-432e-8461-b26935974ac6@roeck-us.net> <0673d2b2-ad78-46f4-93b2-73ea3acd70f7@roeck-us.net>
 <CACYkzJ63DRLtDy6DAsGhz8_mM1pUSaC-DjbCtTBtEMP0c-=yRg@mail.gmail.com>
 <d9fc949a-6945-4c41-83de-c3717d536c15@roeck-us.net> <CAHC9VhRGt-b8PmtR-hZwOWB1zfmuhfftoppjacqrjq60tm0mag@mail.gmail.com>
 <8061553f-6bfc-4ee6-a8f1-e3741cf5ae6c@roeck-us.net> <CAHC9VhSKzxknTgKQu6ODoyxhc3skcjh_h11wSQrEvWb_vP5Ziw@mail.gmail.com>
 <CACYkzJ6NuGQchRaj-QD_XzQWNT8c3zb0ZEBXWjzjAckQdNDCWw@mail.gmail.com>
 <CAHC9VhQjCHBii=CwMMnbs0hiiN-Dy49S+3gpDvaXp-YQyEHTGw@mail.gmail.com> <CACYkzJ7vC7OJWdgm6LbOL82eO=27cn7Gh8i6-HOp_A94-SU-gA@mail.gmail.com>
In-Reply-To: <CACYkzJ7vC7OJWdgm6LbOL82eO=27cn7Gh8i6-HOp_A94-SU-gA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 12 Aug 2024 17:32:53 -0400
Message-ID: <CAHC9VhQPHsqnNd2S_jDbWC3LcmXDG1EoaU_Cat8RoxJv3U=_Tg@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
To: KP Singh <kpsingh@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bp@alien8.de, sfr@canb.auug.org.au, 
	peterz@infradead.org, ink@jurassic.park.msu.ru, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 5:14=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
> On Mon, Aug 12, 2024 at 9:33=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Mon, Aug 12, 2024 at 1:12=E2=80=AFPM KP Singh <kpsingh@kernel.org> w=
rote:
> > >
> > > JFYI, I synced with Guenter and all arch seem to pass and alpha does
> > > not work due to a reason that I am unable to debug. I will try doing
> > > more debugging but I will need more alpha help here (Added the
> > > maintainers to this thread).
> >
> > Thanks for the update; I was hoping that we might have a resolution
> > for the Alpha failure by now but it doesn't look like we're that
> > lucky.  Hopefully the Alpha devs will be able to help resolve this
> > without too much trouble.
> >
> > Unfortunately, this does mean that I'm going to drop the static call
> > patches from the lsm/dev branch so that we can continue merging other
> > things.  Of course this doesn't mean the static call patches can't
> > come back in later during this dev cycle once everything is solved if
> > there is still time, and worst case there is always the next dev
> > cycle.
> >
>
> Do we really want to drop them for alpha? I would rather disable
> CONFIG_SECURITY for alpha and if people really care for alpha we can
> enable it. Alpha folks, what do you think?

Seriously?  I realize Alpha is an older, lesser used arch, but it is
still a supported arch and we are not going to cause a regression for
the sake of a new feature.  As I mentioned earlier, once the problem
is resolved we can bring the patchset back into lsm/dev; if it gets
resolved soon enough we can even do it during this dev cycle.

--=20
paul-moore.com

