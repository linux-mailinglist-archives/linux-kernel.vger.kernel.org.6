Return-Path: <linux-kernel+bounces-410344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 842829CDA27
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10272B228C1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893D48460;
	Fri, 15 Nov 2024 08:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vu+OFTJL"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CA7188CD8
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 08:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731657732; cv=none; b=W41Z+mfI6jgtcb9273k8bcWiz7zBh16GfmJNAHWOr+LM8zcsB7VYrgaIFQHJwg4Mf5Ruexeb4pt19CHkFxR8/l90fAPUar74KWf6KPDgNsOKaFD88SIfGt7kpBXea/cF+NNOlF1U0+sek+2lJ/ZYcaS/GzegWZX1Y1diIt4RMtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731657732; c=relaxed/simple;
	bh=IyO0F26tiWDwAJKdtJ5ldmOb1hy7SlrpIN1PLz8k/0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iB0eea4bNBwp5+E8SJ+u9TZG2YnmZ2aiMo/jiJMf4hy4X1XkG+r27CtQZuJTXNEx5k5TpfwEFsTD0Jfgqv15XpohhO36iG5DUHllxAUwvHJ5YahvIwI7dFeyg1n2SlxI+8/pc9G0gYsvAFrDeNOXfK6TzpJOqSdv7jx70X5hqI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vu+OFTJL; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6ea1407e978so14061677b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 00:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731657729; x=1732262529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSb2nT1bOZ8cqLIJo5pDYayW9eVckwb9N3dVvgH6GX4=;
        b=Vu+OFTJLm9zqqW2LpIjjF6ccJBe4lEUvmOu/zCM02wFREeDWgBuhjS2z1mW1anBK8x
         TPnM4X+UpJ0drWweaizenMtogQjA5t7n4NX+eclXFzLpuL2U/8NPrWDMDnP/va6Aq+sY
         f2XsblLZ/CCQ0ptv2BGWtuLZrL/bygfcmikwCUHBJsehOszVqfe/U91hXMPbM4ozW1hi
         n0RpBf5sILFecwoMIJMHWMD7liVNqkQAJtBFCbBevMpXPTKk1PCT+2DKQxF+5mMY66IN
         A5R+cC9yLQC3dCTf2yYy21T8wJ9WM60mguw4nr6CmcWfBaCepSCBQ/iBq54TVzg/wEJi
         LELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731657729; x=1732262529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rSb2nT1bOZ8cqLIJo5pDYayW9eVckwb9N3dVvgH6GX4=;
        b=an5CTPuZfT8Kz3utmgJ06gfMt/TymgtgJMiSMa/XdNRNoYJ16AeZEINu4GTI14CXy0
         5BkebHEr6vLkokMSfQVpOf6jPfal+VliCul4tump4YZcigpjODzzKDUmor6DlU4sFjGl
         A9X1o2IZlqPDNJ+3O/rydn4rT/wjgHCbvuzlf9OGJFEeeWGRRCDWqihpRmAsfwGO5xD3
         7n840IU9p+eWsqjDOndLAveFxy38I1MTeBxUBHQ/esbffAT9Fy/TrxHjOSZ8Olc1m/QB
         /ajWBbBiNgLdIZeCu675h2Ng2pYTShBCQwNzyHjzel3v0mIDGpwzm8K/it0eiyjDF8/2
         0eqA==
X-Forwarded-Encrypted: i=1; AJvYcCWSJ0aU80eSuUBWjDXbtHAAuyBcAfpJsabYfvSSztYqnwHyi15hoiUIRbexIkQKT24zKEHXPhV+5lVZXwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG+mmDXrNw/shevRB9Q23DkK0fKMiN8CJnKvTmypBiol4tKJww
	s47x/pJ/v35y3BpJRuR8B2pXTXb/ONVeQtkrV7k/fRvYnnM3/EIg0Jk9i6ork6xyEsW54IMsnVD
	x2hi3vc6LRlGbXpV/+SenJqsmlUs=
X-Google-Smtp-Source: AGHT+IFQkVHPcnysrgsGIfAqUB9AY9NECNlY+Q+Met+trlCRNulDRu+0LDIvxWmIMIG3zHowXj5aM0s4+4NmCTmFoVE=
X-Received: by 2002:a05:690c:b10:b0:6e3:26dd:1bf5 with SMTP id
 00721157ae682-6ee55b7ac61mr20989327b3.20.1731657729403; Fri, 15 Nov 2024
 00:02:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113080913.182499-1-danielyangkang@gmail.com> <35b0534a-0ccd-4b92-b493-33434a81845e@linux.alibaba.com>
In-Reply-To: <35b0534a-0ccd-4b92-b493-33434a81845e@linux.alibaba.com>
From: Daniel Yang <danielyangkang@gmail.com>
Date: Fri, 15 Nov 2024 00:01:33 -0800
Message-ID: <CAGiJo8QV_Y6JO8xdYp6AEhavHp+_VvLJ02gU=fwUC5b_5NhcbA@mail.gmail.com>
Subject: Re: [PATCH] ocfs2: replace deprecated simple_strtol with kstrtol
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	"open list:ORACLE CLUSTER FILESYSTEM 2 (OCFS2)" <ocfs2-devel@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 5:05=E2=80=AFPM Joseph Qi <joseph.qi@linux.alibaba.=
com> wrote:
>
>
>
> On 11/13/24 4:09 PM, Daniel Yang wrote:
> > The function simple_strtol ignores overflows and has an awkward
> > interface for error checking. Replace with the recommended kstrtol
> > function leads to clearer error checking and safer conversions.
> >
> > Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> > ---
> >  fs/ocfs2/cluster/heartbeat.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.=
c
> > index 4b9f45d70..dff18efbc 100644
> > --- a/fs/ocfs2/cluster/heartbeat.c
> > +++ b/fs/ocfs2/cluster/heartbeat.c
> > @@ -3,6 +3,7 @@
> >   * Copyright (C) 2004, 2005 Oracle.  All rights reserved.
> >   */
> >
> > +#include "linux/kstrtox.h"
> >  #include <linux/kernel.h>
> >  #include <linux/sched.h>
> >  #include <linux/jiffies.h>
> > @@ -1777,8 +1778,9 @@ static ssize_t o2hb_region_dev_store(struct confi=
g_item *item,
> >       if (o2nm_this_node() =3D=3D O2NM_MAX_NODES)
> >               goto out;
> >
> > -     fd =3D simple_strtol(p, &p, 0);
> > -     if (!p || (*p && (*p !=3D '\n')))
> > +     int p_to_long_ret =3D kstrtol(p, 0, &fd);
> > +
>
> Please define at the beginning.
> Seems we can just re-use 'ret'.
> BTW, the blank line can be eleminated.
>
> Thanks,
> Joseph
>
> > +     if (p_to_long_ret < 0)
> >               goto out;
> >
> >       if (fd < 0 || fd >=3D INT_MAX)
>

Ok. Made the changes and sent PATCH v2. Lmk if there's anything else
that needs to be changed.

- Daniel

