Return-Path: <linux-kernel+bounces-441149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8009ECA60
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10571188C028
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E651B209660;
	Wed, 11 Dec 2024 10:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b="GxeJD/jp"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F28C1A840C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733913177; cv=none; b=uiXyUoOeDV4fM+vp/yd3Z9DFwRgq8egPFPadklkRmmK/014QphjU6QGvcQXbRnEalVyrYKGkmMUHD6hF5bZyjKLhbKJUHHGrGigJoFbiYlVYodAjRbzlDWjaFaQa32jyaRUarkxDnzLWG2H+GNwSvPevDYGOhRjuU88BtnLtExU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733913177; c=relaxed/simple;
	bh=/4lgquGLeg6Y4KgAZdiT6uaqnNN3JttgqH2+HKIMPHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aOf554hrRGcy52nzQfgVnolbIfklGAMBZlzVeG67aayt9yCSG1H4FbVA68BGTVzvMU1RNTdUBVxA5OgfG/my27W1Db8HveGCkqo4Qy/Ajd5imDZXlWCAUBBSSTOJ0BNvmjpnWCp24N36Tp0YGqsfpytbSXK+EFf989NFIbtB9a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de; spf=none smtp.mailfrom=bisdn.de; dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b=GxeJD/jp; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bisdn.de
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-467922cf8a2so100301cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 02:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bisdn-de.20230601.gappssmtp.com; s=20230601; t=1733913174; x=1734517974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4lgquGLeg6Y4KgAZdiT6uaqnNN3JttgqH2+HKIMPHA=;
        b=GxeJD/jpcx4lAbKs7Wxru64wBNFDKz2LGvQRbc3BsRmLSQBFjTa20svEw6bqFtqoKs
         xPjQwjtA2STnhs3FLcHk4Ftcn3Hk+M0HTmtG6HEHC623H2J2J1MlHPkyRa4dHFCVc+pl
         dCFjuMOfa4iM24WmdnKUgYW6MdUU5VoDChjAs4gFxevcWgvjOq5lW90pY4npu18TZjGM
         GRZDcoFWPDS6ZYAYwPNhgGuHkezErCG44bmgkOS8RhwZn08sRIlztCF6b6jFYHBJBneG
         JWTX2+Swe692fX7m2uvgtNxt7+Yz2fZbaMLxqQzJYRi5AKBETH+1gob4oUQB7HsyxQBh
         jclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733913174; x=1734517974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4lgquGLeg6Y4KgAZdiT6uaqnNN3JttgqH2+HKIMPHA=;
        b=jKw8uI5VEXtQg5OKz7+MahX8pnOavuvG8FuEF+OeKCZGp616JRHpvCTC+HtWDRI0wE
         0Y9bR8YwFFtaNgah8evd+cYz5xNW2DGf8i4XrIIDb43vpAgS4/S/+SmKvqj7W4Z9xzmt
         Age7jeVU/XimV6qhvuvQzuZ/Xffc9hWfBRlSBlJq8oaCWV5M7HcXcBZ/cN1uDbwx6VtO
         ftWZAS6YRaoJawvqfm3Uf3WHN/oWLmkzpCR8H3kpITE+JH8vIuqm2Qg0H5BiaTLpHLNv
         K2NHiHx5OOE6JiQaLWNkOTi6RA/w319/e6su61lGyOnVAiaTUg8hLDi/MylrPKbw0hEe
         PjEw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ8YUASsUYQ/qRYOhpJB6KlSUq3NHPAhpZOLv70lF9kFHrnwQOJwjFia72a+vOopiR3GPeHNHYBqyAAJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv7XBYuqRrRAjisudQR53eEcJK4v2+PKLuHuC2YdHGZG2coSgg
	rCMSAzIx0M8VPkt3uI1uNjWOM+0mHUVjL2DYquBzMCYJRn8QlIg1TICIE8Rtat3jXkNoEmm4FCW
	zU57leGDquSHts0KMORjwXaZX8zMmMTI2YKJynLBWOuAlRmui77f2TSXwr7NekN/HOJqxFEOo7H
	3SuiWJAeVYpSBd3RE+LJtOegd7lwB56w==
X-Gm-Gg: ASbGncv/MEprOdLBAR3xwlUyb8JAA8WVc3ELJQuY7gqlOcSWFCQNE7VYSBQzD493/zU
	MEzgaBQWw/WffgiDHQ2Xczcx5Ow028XE5
X-Google-Smtp-Source: AGHT+IE4ssE6QMrH4sTZK9NYcTlGv+R/lgImZyD+f8sZECYEQ4HgAjCYi6Iw0wNpgfp9u2elAVoyr/9zpSS/d8PeOJQ=
X-Received: by 2002:a05:622a:5a86:b0:467:742e:f07e with SMTP id
 d75a77b69052e-467892def4emr16884741cf.7.1733913174320; Wed, 11 Dec 2024
 02:32:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210140654.108998-1-jonas.gorski@bisdn.de>
 <20241210143438.sw4bytcsk46cwqlf@skbuf> <CAJpXRYTGbrM1rK8WVkLERf5B_zdt20Zf+MB67O5M0BT0iJ+piw@mail.gmail.com>
 <20241210145524.nnj43m23qe5sbski@skbuf> <CAJpXRYS3Wbug0CADi_fnaLXdZng1LSicXRTxci3mwQjZmejsdQ@mail.gmail.com>
 <Z1lQblzlqCZ-3lHM@shredder>
In-Reply-To: <Z1lQblzlqCZ-3lHM@shredder>
From: Jonas Gorski <jonas.gorski@bisdn.de>
Date: Wed, 11 Dec 2024 11:32:38 +0100
Message-ID: <CAJpXRYRsJB1JC+6F8TA-0pYPpqTja5xqmDZzSM06PSudxVVZ6A@mail.gmail.com>
Subject: Re: [PATCH RFC] net: bridge: handle ports in locked mode for ll learning
To: Ido Schimmel <idosch@nvidia.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Roopa Prabhu <roopa@nvidia.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Hans Schultz <schultz.hans@gmail.com>, 
	"Hans J. Schultz" <netdev@kapio-technology.com>, bridge@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Mi., 11. Dez. 2024 um 09:42 Uhr schrieb Ido Schimmel <idosch@nvidia.com>=
:
>
> On Tue, Dec 10, 2024 at 04:28:54PM +0100, Jonas Gorski wrote:
> > Thanks for the pointer. Reading the discussion, it seems this was
> > before the explicit BR_PORT_MAB option and locked learning support, so
> > there was some ambiguity around whether learning on locked ports is
> > desired or not, and this was needed(?) for the out-of-tree(?) MAB
> > implementation.
>
> There is a use case for learning on a locked port even without MAB. If
> user space is granting access via dynamic FDB entires, then you need
> learning enabled to refresh these entries.

AFAICT this would still work with my patch, as long learning is
enabled for the port. The difference would be that new dynamic entries
won't be created anymore from link local learning, so userspace would
now have to add them themselves. But any existing dynamic entries will
be refreshed via the normal input paths.

Though I see that this would break offloading these, since USER
dynamic entries are ignored in br_switchdev_fdb_notify() since
927cdea5d209 ("net: bridge: switchdev: don't notify FDB entries with
"master dynamic""). Side note, br_switchdev_fdb_replay() seems to
still pass them on. Do I miss something or shouldn't replay also need
to ignore/skip them?

> > But now that we do have an explicit flag for MAB, maybe this should be
> > revisited? Especially since with BR_PORT_MAB enabled, entries are
> > supposed to be learned as locked. But link local learned entries are
> > still learned unlocked. So no_linklocal_learn still needs to be
> > enabled for +locked, +learning, +mab.
>
> I mentioned this in the man page and added "no_linklocal_learn" to
> iproute2, but looks like it is not enough. You can try reposting the
> original patch (skip learning from link-local frames on a locked port)
> with a Fixes tag and see how it goes. I think it is unfortunate to
> change the behavior when there is already a dedicated knob for what you
> want to achieve, but I suspect the change will not introduce regressions
> so maybe people will find it acceptable.

Absolutely not your fault; my reference was the original cover letters
for BR_PORT_LOCKED and BR_PORT_MAB and reading br_input.c where the
flags are handled (not even looking at if_link.h's doc comments). And
there the constraint/side effect isn't mentioned anywhere, so I
assumed it was unintentional. And I never looked at any man pages,
just used bridge link help to find out what the arguments are to
(un)set those port flags. So I looked everywhere except where this
constraint is pointed out.

Anyway, I understand your concern about already having a knob to avoid
the issue, my concern here is that the knob isn't quite obvious, and
that you do need an additional knob to have a "secure" default. So
IMHO it's easy to miss as an inexperienced user. Though at least in
the !MAB case, disabling learning on the port is also enough to avoid
that (and keeps learning via link local enabled for unlocked ports).

At least in the case of having enabled BR_PORT_MAB, I would consider
it a bug that the entries learned via link local traffic aren't marked
as BR_FDB_LOCKED. If you agree, I can send in a reduced patch for
that, so that the entries are initially locked regardless the source
of learning.

Best Regards,
Jonas

--=20
BISDN GmbH
K=C3=B6rnerstra=C3=9Fe 7-10
10785 Berlin
Germany


Phone:=20
+49-30-6108-1-6100


Managing Directors:=C2=A0
Dr.-Ing. Hagen Woesner, Andreas=20
K=C3=B6psel


Commercial register:=C2=A0
Amtsgericht Berlin-Charlottenburg HRB 141569=20
B
VAT ID No:=C2=A0DE283257294


