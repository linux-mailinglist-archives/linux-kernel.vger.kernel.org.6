Return-Path: <linux-kernel+bounces-315823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C0996C761
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E7FBB24507
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547161E6313;
	Wed,  4 Sep 2024 19:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="kZ+MdXSG";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="DFe/ARZB"
Received: from mx6.ucr.edu (mx.ucr.edu [138.23.62.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E1B1E503B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 19:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725477548; cv=none; b=l1lJ+ga59LXPoAjDabh+IDs2+eo3+SPjwxJmOzWsVey5gGONxNhDgMhtWCiPuLQ+GuQ/xqRENsihNYI0sUOzoMumD3JCazYT70QUGjk43gJgtiAzsJbz0yBonHUo/a4ny3sd7B9Iso60HIKHcSWS9IcvsUBtJhxtP9tEX+jTZOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725477548; c=relaxed/simple;
	bh=V4W941XLc6H/+dnu0gbSD9ilMORE5y9ZR1cBEZLstFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r3TrWWntDEB2EcX62tnuYXpDx+2Ou81NuDCim0gOT/1A6ZxYFP2OUhcWEMtiZTFCGO9ofeWKV5N+20oyPF8a/PacGCen7mvYfcl43yJAG65WF0AcNtGe/g00HDSWCQc3+NLx+oCx+QLCtRwlzYyuJmM4upsLA45B6uZYI4SedNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=kZ+MdXSG; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=DFe/ARZB; arc=none smtp.client-ip=138.23.62.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1725477547; x=1757013547;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:cc:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=V4W941XLc6H/+dnu0gbSD9ilMORE5y9ZR1cBEZLstFs=;
  b=kZ+MdXSGj1icm5rbMr4Vcvp8S+UgJl2IjLGG6jYio7MOBS5UOa2pSzQE
   0BW8uyI+E0UApboYSNmYBJ5jbOvSCTkB7d1raCp31XfJSUGWFTKvD/beq
   Bh47/nQ7Q8Q8/vGtmw09dFJ4fwHjNxbi3hh5mxDQKWuPwH3UpcqO2hcIk
   1a98ajK/a8frBkhPCkItZYPhmhwHBPuGevteTSSANUsl/m4i2a99sjrnT
   d/Iq61r58C2UkXUDMlGn2VjkPm3KoLVcMIDYricT+kh7xefzcfxXGkSgz
   bIJV9APCsuIO3jSTnCJ5L1qesP+UqXXz0KSzKetyKkUj0SE/W4RkbmxFk
   Q==;
X-CSE-ConnectionGUID: gzWwZCofQNqgF3QS8rDdAQ==
X-CSE-MsgGUID: V/Ci4hatRYOJinyxv1+Tsw==
Received: from mail-io1-f69.google.com ([209.85.166.69])
  by smtpmx6.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 04 Sep 2024 12:18:58 -0700
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82a246b5043so820559539f.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 12:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1725477537; x=1726082337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wp619eUyj/srIfkacGO/5/4OpMLHA+ypleVADcaGWJ0=;
        b=DFe/ARZBd/BmKtNRoEt5qGW3j2cRznABpw/Esl54WnLgCDHhyQ/XY+KtttnJZkonoP
         cNLsV3vVQHXXKmjsSuBgEsZj+iQgSNvbpkcovHWlEBuWINHNao/ir7gemB0Q9ss83XO0
         tDMb/pBGkp0ykKqMnKyAHuxRbFr4BdfpP9sqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725477537; x=1726082337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wp619eUyj/srIfkacGO/5/4OpMLHA+ypleVADcaGWJ0=;
        b=RpHyzTI3EzUomfvXG4IZGXHmmgDylxly0ohf+H+ASxAqg2cgywJT8nhj7L3qVN8du5
         Bjv5ERYsjHIhDOIf6VWVFjjemPL78P5PIMskF+VxzGYWE67uDDloy64RbHAvp8l6oZSz
         QLbquw/rgcCTwg6XTXGOHjcJCVfHe6VMtQ5H/apBrYkIT995fUlEP+n8818QUln+iO4J
         oJddxaaR0v2vYjyiMzwTTkY6DZ10GzVaTnkjmKnPfdVv/FrWaxTV6n+yZmOuEBDLmd9n
         qL1XROxhNmQiFIZshUvgHSYZ3yIzAY1z40xW3Aaghx36+Q1c0wRyfyQOcTDVaGZotY/g
         du5g==
X-Forwarded-Encrypted: i=1; AJvYcCV5ZkxHnDorQHaLc9Vnak2dtOmP05If1cOgI6e+CS6s8yjm5SNIRrfdoxVOTaVQQzkB/DhMhCRdlLo1mRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YytXZgyuyPv74DICgLqF9GvGK+p/LPQ5Wnkc1qS0XduKZusW9V+
	PiEdpzq1aB22wY8SpktpP4U0NdyHpikXvff73USZ6HglbZiZf5LfKwhiT+vKnJ83ecazOjvK8HD
	T3EMBJxVfG8D/kuTmhBLJXckb0QNygYokgtGkYvVs+Eh7hhE8mvn6ENd52jUyPgcrQOflDgo9VR
	9qLrrZm4cgL4WSBqSkSxBhM2KW8Gmxj1AZ7+RyTg==
X-Received: by 2002:a05:6602:6b07:b0:824:d9c0:3fc6 with SMTP id ca18e2360f4ac-82a3730aecfmr1566823239f.3.1725477537303;
        Wed, 04 Sep 2024 12:18:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8Djcz+0ooKKXLxn8YKkL5axvVjXixex3XMagQYxCNHQNt+JxXVPIaHG4A9H0SHwKI9lJoq0O3HO/addLf7wA=
X-Received: by 2002:a05:6602:6b07:b0:824:d9c0:3fc6 with SMTP id
 ca18e2360f4ac-82a3730aecfmr1566821739f.3.1725477537024; Wed, 04 Sep 2024
 12:18:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALAgD-6Uy-2kVrj05SeCiN4wZu75Vq5-TCEsiUGzYwzjO4+Ahg@mail.gmail.com>
 <Zs_gT7g9Dv-QAxfj@google.com> <CALAgD-5-8YjG=uOk_yAy_U8Dy9myRvC+pAiVe0R+Yt+xmEuCxQ@mail.gmail.com>
 <ZtEDEoL-fT2YKeGA@google.com> <CALAgD-6Vg9k=wd1zaJ+k-EaWLnzosAn2f=iz7FvhVpdS6eq-dA@mail.gmail.com>
In-Reply-To: <CALAgD-6Vg9k=wd1zaJ+k-EaWLnzosAn2f=iz7FvhVpdS6eq-dA@mail.gmail.com>
From: Juefei Pu <juefei.pu@email.ucr.edu>
Date: Wed, 4 Sep 2024 12:18:46 -0700
Message-ID: <CANikGpcg3_hVS+-h5egaLNkHGvG50qVAZ21syT7Ogc6iK1SzKA@mail.gmail.com>
Subject: Re: BUG: general protection fault in get_mem_cgroup_from_objcg
To: Xingyu Li <xli399@ucr.edu>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, hannes@cmpxchg.org, mhocko@kernel.org, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

After several tests, I found that the same PoC can cause multiple
different crashes for some unknown reason. Thus, I suspect that the
bug is capable of performing unintended memory writing without being
caught by KASAN.
For reproducibility, I've created a GitHub repo at
https://github.com/TomAPU/Linux610BugReort, which contains the
software versions we used, the QEMU arguments we used to boot up the
kernel, the kernel config we used,  the pre-compiled kernel image,
Dockerfile that can be used to compile the kernel.
I hope this repo will be helpful for analyzing the bug.

Yours,
Juefei

On Thu, Aug 29, 2024 at 4:28=E2=80=AFPM Xingyu Li <xli399@ucr.edu> wrote:
>
> Juefei: Can you give some input on this?
>
> On Thu, Aug 29, 2024 at 4:24=E2=80=AFPM Roman Gushchin <roman.gushchin@li=
nux.dev> wrote:
> >
> > On Wed, Aug 28, 2024 at 10:20:04PM -0700, Xingyu Li wrote:
> > > Hi,
> > >
> > > Here is the kernel config file:
> > > https://gist.github.com/TomAPU/64f5db0fe976a3e94a6dd2b621887cdd
> > >
> > > how long does it take to reproduce?
> > > Juefei will follow on this, and I just CC'ed him.
> >
> > I ran the reproducer for several hours in a vm without much success.
> > So in order to make any progress I'd really need a help from your side.
> > If you can reproduce it consistently, can you, please, try to bisect it=
?
> >
> > Thanks!
>
>
>
> --
> Yours sincerely,
> Xingyu

