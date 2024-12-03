Return-Path: <linux-kernel+bounces-428973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9AC9E159F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A56163C94
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3521D90A1;
	Tue,  3 Dec 2024 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYfmyWsL"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669A81D47BC
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 08:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733214377; cv=none; b=JyI6qDMCTN/ZkF+PAxKpnE6csCwOFsh48MEmqLDPH/l5ORzlLrYj/SX2arP10BoR7ijeAsaf/kK+2FpXTP2rtZ6RgHVC5008nxAOkDn5Z2IP35VdbsFRs2jXx7epz7sxHaKUcqTXPmb0VEcVLrq+pipu+V4/JYX9PzWWOgEeSc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733214377; c=relaxed/simple;
	bh=a21GzhU/IcEVKODw1iA3Sw21iLkE6eTaO6jTTA4AJAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FzAKlHcJoNDZCn8uwGqRVoJmYQZRXem81Nxf9rkOWpXOvUJoVnfM0mZo3hc6weGynSNfzTMhnG/vU4yiGsVy+4TRfvUYTLau9cjfI3OLLk792jNu/UcwYePmRH59iNFXW/aoBPn3iibIdYuOU4tb9JbBFalwG84PxOMuybp0tAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYfmyWsL; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ffb0bbe9c8so59955191fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 00:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733214373; x=1733819173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jf5I3RuoC20RN0IsV/jbFVx4wBkXAmSkQkbAnkDREIg=;
        b=AYfmyWsLErc3r+CCpX8MCBbsHVF88NYYx6o2vZvsn07EBMNU6Mh0W/o7P151S1ZJaa
         I8wOcr507qpUBCd6qZD++J5tN0F1a2otv0fYVgpkZgccamgDPFmeMoMqF7LLzqLQo2Sb
         s5mulXirqyBkiAbl3UPuYu9BzahJ+erDl925b5LghQC1lgv8TXb4Drm9aui1Uo1QLw/V
         zJG/qkOMZvByNRrPGUllFaaw/b/08uzH2tjLjaXYLsaPEOygdvH3gvPWidEwrLYkJa2K
         g1IhcbQUjc+NOzxeiMH5C6/q0ab1+5ngNBqNlTkosIGcd6GYJrhIqVrpV+ZYBycBhfAm
         FoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733214373; x=1733819173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jf5I3RuoC20RN0IsV/jbFVx4wBkXAmSkQkbAnkDREIg=;
        b=g9q89wvFN/j30le8z5mOefLkLQVMvSrnNI2walWYmCLJVJEzaSba7fsMppctvHydA4
         6xswxXRZ/B6ygPtNlao4eSvvdo5jsUFyFR6rEhKHlE2ySS/dQfxn3m/CDhuvNfJPWIDf
         JZDEN6vhtRgzZQjrAu/l+9vF4KPNjOv5siZPaNEsbW6dsix7Y0LT/zNwBgYtcrkpytIk
         gjs1+m7FhbhbL4/855IRhNQLXXYIZ7J+J1OyMS8f5Kl/kOZYhDMm+yZqWJ4W4rNNw4PG
         lG46gD2ZMxVw/ERybz68GJxbTqhfs+i6pEuVjhgfNU1w6y0Mceb8Ya6wdEar7m1rHtG0
         lw4A==
X-Forwarded-Encrypted: i=1; AJvYcCWixEKDFKwYV+NFL+hFAvXWD5ZRmTZSsJuuxbdffkYqSmKqyXDt47U69ABeQFVSJtzrCDcXg9axna9F6ck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+IQqsapmb+sGKJOR45rQaS59am1cHOjre12RdZnp6ArdqseTW
	/7SO2EYojM4+Ant4AnNJ3OFJ81bExuMZn/FoFyjD1wSVUq6Mi+uWW9teclQmx/Li1pzG1tumTIK
	SxCggtgart2i/XlyjtEB32FvdI9Eoe5LRsE/icw==
X-Gm-Gg: ASbGncs/8Mf6GB7tVzp2TcNaSrUc5p0DMGpkA9nYGrMgr6gPLBpRXeXfj6Zh0UX+Lw+
	k5tIexyGo3/GToqGFlJUfpbOMRNZGkg==
X-Google-Smtp-Source: AGHT+IGfKFlAAQWGLPjwb8FCHA8+RmFCdqsvJQTdi78qnXBU0bxqK3oOGEt9JI24RUBM5MWP2/YI2cLbecsls+P9cCc=
X-Received: by 2002:a2e:bd12:0:b0:2ff:a7c1:8c31 with SMTP id
 38308e7fff4ca-30009c6e485mr11387831fa.26.1733214373311; Tue, 03 Dec 2024
 00:26:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202184154.19321-1-ryncsn@gmail.com> <20241202184154.19321-2-ryncsn@gmail.com>
 <CAJD7tkYemGu0iqt+ZW9t5zr21PbHkFBRnc=EixiwoNbq0xq5Ew@mail.gmail.com>
In-Reply-To: <CAJD7tkYemGu0iqt+ZW9t5zr21PbHkFBRnc=EixiwoNbq0xq5Ew@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 3 Dec 2024 16:25:57 +0800
Message-ID: <CAMgjq7Aeh9LCtSkG_RMrZjO_tvGryYA-QuvU9k1ahOzEv8LkgQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm, memcontrol: avoid duplicated memcg enable check
To: Yosry Ahmed <yosryahmed@google.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Barry Song <baohua@kernel.org>, Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 3:11=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Mon, Dec 2, 2024 at 10:42=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > mem_cgroup_uncharge_swap() implies a mem_cgroup_disabled() check,
> > which is already checked by the caller here. Skip it by calling
> > __mem_cgroup_uncharge_swap() directly.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/memcontrol.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 7b3503d12aaf..d3d1eb506eee 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -4615,7 +4615,7 @@ void mem_cgroup_swapin_uncharge_swap(swp_entry_t =
entry, unsigned int nr_pages)
> >                  * let's not wait for it.  The page already received a
> >                  * memory+swap charge, drop the swap entry duplicate.
> >                  */
> > -               mem_cgroup_uncharge_swap(entry, nr_pages);
> > +               __mem_cgroup_uncharge_swap(entry, nr_pages);
>
> Would it be better to instead remove the mem_cgroup_disabled() check
> here and have a single check in this path?

Good suggestion, and the kernel test bot just reported
__mem_cgroup_uncharge_swap is undefined with !CONFIG_SWAP, so better
to fix it by removing the check instead.

>
> Anyway, FWIW:
>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
>
> >         }
> >  }
> >
> > --
> > 2.47.0
> >
>

