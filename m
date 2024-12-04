Return-Path: <linux-kernel+bounces-430532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF119E3235
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 04:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA9641637C5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 03:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7EC155398;
	Wed,  4 Dec 2024 03:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EkV+aSN3"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85774126C10
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 03:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733283788; cv=none; b=dXm3e3gBtM3rTQTjR4sDN1d4ECfcv79c7QsLXruCbtixtRYIf46RUYXQr4z0N8ZVYGyPZWBupmmI2n/fLGu3PqCXImMPFJtGfGB8tUCmVFo4AJVgDNFiOiN85TNjum22zLAmj1zejQhQ8NIBNxmh5E+RMOr7PpoXPB/cqbHUB8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733283788; c=relaxed/simple;
	bh=TqdK+FM+jY2ufpzLe1eyEt9QWjmf0sAuVYXuq8Q/p0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=om2Pa/CCLdLYBC4YyFyT7Y0G8tXCvpMO8KCN8FlGrC4t1LSFYbgaqVWfHhaUtNNCVeBP2e7G+rJA+uW2ROmVk3Pqo9h/05z+/mlksOCkr12MFhCJyPGgwL7P3cCe4EJn29GTHtvEWQPitpmr1LFrZgTiylhtb89jX0DAj8hjCsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EkV+aSN3; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e396cc8c9a1so443438276.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 19:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733283785; x=1733888585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoORBSqdOkBi+IqSVmSUU1mXcBQYj6OIptczyNoNm5w=;
        b=EkV+aSN3/SyVJQ7uLDo5Ryf/7qeR3O9qX8jHV66wQb1uSwdat4H40bsPFJEr6oSW4q
         fg/RPwkMajZPfQrfGU37YFALjp5bkKHwjsC2/xjQ7J+u2nWpqe4b3pLVDWIiH4NOpTbg
         hIZeJGzHyqKKquNujgFVcEqAtQEpUc6rUD47lRtm/ykRdu88buBf4keA+fWzKwqiQVY+
         nq0uDV5+vUKbaiijRSNYBIfUS+caLGyAMVs0Vab80bIKHo+SjH5zfLnYyl+5WuOCEqfB
         4YYYSKEua8KW7UOIituw/U/0jx5BqrHSvzGq5w9v4M5xgU+g2v0cKEhrhOX2U7HSTBjz
         PoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733283785; x=1733888585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QoORBSqdOkBi+IqSVmSUU1mXcBQYj6OIptczyNoNm5w=;
        b=h195W2hhPOOe1gj9hLBHq2Cw0TJPxMuZ0udScmhD4LIL/u8grTOQiojGRJjVDRl4yn
         FAQy9mWImAC7xUty63zqCZPlZ4yewQhrgtKJjlfwunc8WqJBkWe2vJEJwZ/SGUP9cWDN
         WUUxLdkvyuS9dW7ee+y0IZJsetsLQjQywD42nE5d4WOLw9qtfJSDb1+6ZK+gnoTXJYm8
         p0RsFO4aOJ8Z5ov8NxRqLrjqRNF9++huJwzS7FrWURaruuJoR70yezKlOcL1QcgvNqfr
         4AGx2wv9baIEqLacobwhi0l8eGeCfOAOr2A4haOFhyUh060pu6t+XmkZ/45JFpmRGeQw
         MpQg==
X-Forwarded-Encrypted: i=1; AJvYcCXJJuZGVYCxAcX62HZGI/YfHg/Jp1aGGnZi65i40MaERqZWDN9BE/RM63rjaDKFWvd9Lsnis6v0FUp/rdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZZUACGpftIJaSTFKrNxGUlXHF028fD64UJ+FriQuj2r4rkmeV
	XQob1nD1pwHHkfIOpHx0ciHg1FyrLeCrDfmd0Thwh1W58tcJxlGIfsYOnlSLw07VIHRFeJmynrv
	EGtalV/ag5mMMd63qDEcPYoa6lFFXbUzh9ANZ
X-Gm-Gg: ASbGnctF4U9bJi2SBtSaMUg7R0/XFvDLBPRbP3gZl9JRnWQaqfrSiDZ5kSC+jg47Y92
	W53qByRoBeVAAFXUQVuE+B4H8kyNXSw==
X-Google-Smtp-Source: AGHT+IF1DmwLdapXYhis7mRNAhuhXb/NeXsgk3DX+Aqex62iJmPjrDTZ7O9mnNWJaWEEaZTu71CYS+Ri/y2hFA55lLA=
X-Received: by 2002:a25:c104:0:b0:e38:86ea:eff8 with SMTP id
 3f1490d57ef6-e3971426a43mr22628043276.0.1733283785533; Tue, 03 Dec 2024
 19:43:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203060350.69472-1-laoar.shao@gmail.com> <CAHC9VhTRaX02x+KFpsxmguze3R=AAF9yjTtDxf_ghVpQ3XdU2A@mail.gmail.com>
 <CALOAHbDgb5LW+XF1_VHGpr7zcjenMwSQzOy-pTsyV3buOW1N6Q@mail.gmail.com>
In-Reply-To: <CALOAHbDgb5LW+XF1_VHGpr7zcjenMwSQzOy-pTsyV3buOW1N6Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Dec 2024 22:42:54 -0500
Message-ID: <CAHC9VhSA7U5D0mzg+OmGi5RpDpw-+eufyTEDtLu9m=nkMHe+yA@mail.gmail.com>
Subject: Re: [PATCH] auditsc: Implement a workaround for a GCC bug triggered
 by task comm changes
To: Yafang Shao <laoar.shao@gmail.com>
Cc: keescook@chromium.org, qiuxu.zhuo@intel.com, rostedt@goodmis.org, 
	lkp@intel.com, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 10:00=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
> On Wed, Dec 4, 2024 at 6:06=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Tue, Dec 3, 2024 at 1:04=E2=80=AFAM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> > >
> > > From: Yafang shao <laoar.shao@gmail.com>
> > >
> > > A build failure has been reported with the following details:
> > >
> > >    In file included from include/linux/string.h:390,
> > >                     from include/linux/bitmap.h:13,
> > >                     from include/linux/cpumask.h:12,
> > >                     from include/linux/smp.h:13,
> > >                     from include/linux/lockdep.h:14,
> > >                     from include/linux/spinlock.h:63,
> > >                     from include/linux/wait.h:9,
> > >                     from include/linux/wait_bit.h:8,
> > >                     from include/linux/fs.h:6,
> > >                     from kernel/auditsc.c:37:
> > >    In function 'sized_strscpy',
> > >        inlined from '__audit_ptrace' at kernel/auditsc.c:2732:2:
> > > >> include/linux/fortify-string.h:293:17: error: call to '__write_ove=
rflow' declared with attribute error: detected write beyond size of object =
(1st parameter)
> > >      293 |                 __write_overflow();
> > >          |                 ^~~~~~~~~~~~~~~~~~
> > >    In function 'sized_strscpy',
> > >        inlined from 'audit_signal_info_syscall' at kernel/auditsc.c:2=
759:3:
> > > >> include/linux/fortify-string.h:293:17: error: call to '__write_ove=
rflow' declared with attribute error: detected write beyond size of object =
(1st parameter)
> > >      293 |                 __write_overflow();
> > >          |                 ^~~~~~~~~~~~~~~~~~
> > >
> > > The issue appears to be a GCC bug, though the root cause remains
> > > unclear at this time. For now, let's implement a workaround.
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202410171420.1V00ICVG-l=
kp@intel.com/
> > > Reported-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > > Closes: https://lore.kernel.org/all/20241128182435.57a1ea6f@gandalf.l=
ocal.home/
> > > Reported-by: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
> > > Closes: https://lore.kernel.org/all/CY8PR11MB71348E568DBDA576F17DAFF3=
89362@CY8PR11MB7134.namprd11.prod.outlook.com/
> > > Originally-by: Kees Cook <kees@kernel.org>
> > > Link: https://lore.kernel.org/linux-hardening/202410171059.C2C395030@=
keescook/
> > > Signed-off-by: Yafang shao <laoar.shao@gmail.com>
> > > Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > > ---
> > >  kernel/auditsc.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > Thanks, does anyone have a link to the GCC bug report?  We really
> > should mention that in the commit description and/or metadata.
>
> I came across a GCC bug report [0] while researching online. This
> issue was reportedly fixed in GCC-12.1 [1], yet it seems the same bug
> is still being triggered in GCC-14.2.0[2].
> Should I file a new bug report with GCC to address this?

I was under the impression that this had already been reported, if it
hasn't, then yes, please report the bug to the GCC team so we can get
this fixed.  Once you have the bug report, please post it here so it
can be included in the commit.

> [0] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D101941
> [1] https://gcc.gnu.org/git/gitweb.cgi?p=3Dgcc.git;h=3D76fe494230477a69f8=
fa8c8ca2d493acaf343eb1
> [2] https://lore.kernel.org/all/20241128182435.57a1ea6f@gandalf.local.hom=
e/

--=20
paul-moore.com

