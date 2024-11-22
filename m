Return-Path: <linux-kernel+bounces-417717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C58F9D5847
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 03:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5553D2822A1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 02:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAB77082F;
	Fri, 22 Nov 2024 02:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jj0N6OlR"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD28230988
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 02:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732242442; cv=none; b=IGCssTkkldrrXmKIR2SxcfzhCjg3KUpfqenLFlYfQxCM0XqWpoTUyYn5Mq8qUgFTATRxNj7qHkIeRf3oPwBjF/1GT4htnpxIWXUD0fyZm2UQJViemaRt0hhCz1TtrADv/OS4XYVoX8TkMtaxX5y0us04fRMoBFoHHivRQo+u+2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732242442; c=relaxed/simple;
	bh=rVOZwI1G+Fgq5lVk5BWwOOiVro1VFLMzI9Q44du6vp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdLkj5Hol6H5FgsfNOxxCNOslt3qc4NHzJYX4zQW66viCwSd8Ho97fdYDoMsN6L8spjaTTrlddis8LJ1FA4ZCP4TVG8GiAuu9rkr3urxb7ILo/YYt7QS/VcMLEcWFSesiTDvynykwxyIgVia5JdPpKlmx1U19HQiExIpSRRvWDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jj0N6OlR; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6d40d77aa97so11079286d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732242439; x=1732847239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kTERV/2oUFlBhQwtQ47etI7WaUJ5dknqFfZGDdtF5s=;
        b=jj0N6OlRoJFUgS/XpSpQE0hJm3JfMt0tlLbgZY4+izZdcLaloBdqIuX6fBQ2trdixM
         dT29S9A51ARfqKsXIa0Ut7G6k7r/eNSsbdo0+pQ2u/1ejC368QTAwzTfozSvU6xPqeDB
         3CuokP1e+6N9JqIvedbtqaADA7RkhJXJ5EXwtMRoT3/3jaIa//kSJquW/UiiiBtranSL
         1Bs+DxVD6wxYx7IPxkXWbJhOPc+DGlFVAPqYxmIsgtt1/AmfWz1V03zx2LAnxtnQ0vcq
         bJ7xO2J5OPDLQHmrVMbecKAxlzoRuIOOWDVZzVdr9V15ff3AOWmDX6Q0VsDNaOQxsgco
         FxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732242439; x=1732847239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8kTERV/2oUFlBhQwtQ47etI7WaUJ5dknqFfZGDdtF5s=;
        b=ncizwofvVnVZWv2oKSE1HBiBBsgfE74eEy+NS0XwMdIK3VMdv2/xF+FsrWEnDDFdmx
         jqumtQXOXasfGodtCWoxXJTSlTqDI/yqaYylM1FGy4mrySs/sH0w8nog53wHjiqIenZB
         c0cvOsKvL5KHY1HjPDGNVOvCXtE1PasWWQ2GVIv+Btv/y9XQybbvw7m870fmOgLaT2c4
         9FDCfd+0rTGhPVJ9+uLx0tEuga97w09AaZf2gVi0IkgfUZU0IS+2pTDTLp5gwqi0ADIs
         ixHkPvxwR05X0siTbDqRaTl49e+Zr97jVO0tESi3HP/SSp5A/jAy7Iu+RGSRW/7/hAsE
         00kw==
X-Forwarded-Encrypted: i=1; AJvYcCXpx1CzJ2rj12cQ87T8vnGWOUenRZYimqK5NzrvFwKgwcMV4J0nU1vNvtThWlMThomqXeFFopsDKS/Nkzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYEEkYyvkFcehvddSu2HaVPk3eOKjFM7nnnRs5MWUFqRs58clo
	CV6oePelFpRzb3uDvdTLAkGDE18i27DwHHbg4L+OEfJXuKtzP9FZ5lIeCtFzd57HyWzK3LlG/i0
	MiFT9WMCdsFSqPorjvsDMoAgMZxE=
X-Gm-Gg: ASbGncsDSENFSMxV1zekYhlEhDVrbkZu5l6H6Xg+dBzCsfEsBHL7YZQW1jWugn0eX97
	WPtP8qqXvMAkJHkdyXkPJlQz1yfGbCGw=
X-Google-Smtp-Source: AGHT+IGHahGiZ6PgT6/jXf9z7Xpjq6JZOgjB+/uQlJi6nmU9FA9C9TzSht7MNUIGmKgWltVojs3BiI7yonHgQ8ihbCg=
X-Received: by 2002:ad4:4ea5:0:b0:6d4:2c85:a8a with SMTP id
 6a1803df08f44-6d451357c2emr21547716d6.31.1732242438980; Thu, 21 Nov 2024
 18:27:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120122858.22190-1-laoar.shao@gmail.com> <0aa9f3bd-b1b6-4089-b9eb-5b72d7a1541a@redhat.com>
 <CALOAHbBMebKtsRnfOFvNKorQk_4KGoCzKd0JcYv2p6pXhJqYbQ@mail.gmail.com> <2024112134-theater-jasmine-61f3@gregkh>
In-Reply-To: <2024112134-theater-jasmine-61f3@gregkh>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 22 Nov 2024 10:26:43 +0800
Message-ID: <CALOAHbCGH6_n2v65SMzpXf44EvKcr4AZCjOMaDRHUynNPZNksA@mail.gmail.com>
Subject: Re: [PATCH] /dev/mem: Add a new parameter strict_devmem to bypass
 strict devmem
To: Greg KH <gregkh@linuxfoundation.org>
Cc: David Hildenbrand <david@redhat.com>, mingo@redhat.com, arnd@arndb.de, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 11:15=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Thu, Nov 21, 2024 at 10:31:12PM +0800, Yafang Shao wrote:
> > On Thu, Nov 21, 2024 at 4:51=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> > >
> > > On 20.11.24 13:28, Yafang Shao wrote:
> > > > When CONFIG_STRICT_DEVMEM is enabled, writing to /dev/mem to overri=
de
> > > > kernel data for debugging purposes is prohibited. This configuratio=
n is
> > > > always enabled on our production servers. However, there are times =
when we
> > > > need to use the crash utility to modify kernel data to analyze comp=
lex
> > > > issues.
> > > >
> > > > As suggested by Ingo, we can add a boot time knob of soft-enabling =
it.
> > > > Therefore, a new parameter "strict_devmem=3D" is added. The reuslt =
are as
> > > > follows,
> > > >
> > > > - Before this change
> > > >    crash> wr panic_on_oops 0
> > > >    wr: cannot write to /proc/kcore      <<<< failed
> > > >
> > > > - After this change
> > > >    - default
> > > >      crash> wr panic_on_oops 0
> > > >      wr: cannot write to /proc/kcore    <<<< failed
> > > >
> > > >    - strict_devmem=3Doff
> > > >      crash> p panic_on_oops
> > > >      panic_on_oops =3D $1 =3D 1
> > > >      crash> wr panic_on_oops 0
> > > >      crash> p panic_on_oops
> > > >      panic_on_oops =3D $2 =3D 0            <<<< succeeded
> > > >
> > > >    - strict_devmem=3Dinvalid
> > > >      [    0.230052] Invalid option string for strict_devmem: 'inval=
id'
> > > >      crash> wr panic_on_oops 0
> > > >      wr: cannot write to /proc/kcore  <<<< failed
> > > >
> > > > Suggested-by: Ingo Molnar <mingo@kernel.org>
> > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > ---
> > > >   .../admin-guide/kernel-parameters.txt         | 16 ++++++++++++++
> > > >   drivers/char/mem.c                            | 21 ++++++++++++++=
+++++
> > > >   2 files changed, 37 insertions(+)
> > > >
> > > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Docu=
mentation/admin-guide/kernel-parameters.txt
> > > > index 1518343bbe22..7fe0f66d0dfb 100644
> > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > @@ -6563,6 +6563,22 @@
> > > >                       them frequently to increase the rate of SLB f=
aults
> > > >                       on kernel addresses.
> > > >
> > > > +     strict_devmem=3D
> > > > +                     [KNL] Under CONFIG_STRICT_DEVMEM, whether str=
ict devmem
> > > > +                     is enabled for this boot. Strict devmem check=
ing is used
> > > > +                     to protect the userspace (root) access to all=
 of memory,
> > > > +                     including kernel and userspace memory. Accide=
ntal access
> > > > +                     to this is obviously disastrous, but specific=
 access can
> > > > +                     be used by people debugging the kernel. Note =
that with
> > > > +                     PAT support enabled, even in this case there =
are
> > > > +                     restrictions on /dev/mem use due to the cache=
 aliasing
> > > > +                     requirements.
> > > > +             on      If IO_STRICT_DEVMEM=3Dn, the /dev/mem file on=
ly allows
> > > > +                     userspace access to PCI space and the BIOS co=
de and data
> > > > +                     regions. This is sufficient for dosemu and X =
and all
> > > > +                     common users of /dev/mem. (default)
> > > > +             off     Disable strict devmem checks.
> > > > +
> > > >       sunrpc.min_resvport=3D
> > > >       sunrpc.max_resvport=3D
> > > >                       [NFS,SUNRPC]
> > >
> > > This will allow to violate EXCLUSIVE_SYSTEM_RAM, and I am afraid I do=
n't
> > > enjoy seeing devmem handling+config getting more complicated.
> >
> > That poses a challenge. Perhaps we should also consider disabling
> > functions that rely on EXCLUSIVE_SYSTEM_RAM when strict_devmem=3Doff,
> > but implementing such a change seems overly complex.
> >
> > Our primary goal is to temporarily bypass STRICT_DEVMEM for live
> > kernel debugging. In an earlier version, I proposed making the
> > fucntion devmem_is_allowed() error-injectable, but Ingo pointed out
> > that it violates the principles of STRICT_DEVMEM.
>
> I think that "primary goal" is the problem here.  We don't want to do
> that, at all, for all the reasons why we implemented STRICT_DEVMEM and
> for why people enable it.
>
> Either you enable it because you want the protection and "security" it
> provides, or you do not.  Don't try to work around it please.
>
> > Do you have any suggestions on enabling write access to /dev/mem in
> > debugging tools like the crash utility, while maintaining
> > compatibility with the existing rules?
>
> I think you just don't provide write access to /dev/mem for debugging
> tools as it's a huge security hole that people realized and have plugged
> up.  If you want to provide access to this for "debugging" then just
> don't enable that option and live with the risk involved, I don't see
> how you can have it both ways.

I don=E2=80=99t quite see how STRICT_DEVMEM could pose a significant securi=
ty
concern. If you=E2=80=99re root, you already have the ability to do whateve=
r
you want on the system if you=E2=80=99re determined to. This option primari=
ly
serves to prevent reckless or accidental writes to kernel memory.

As I understand it, STRICT_DEVMEM is more about enabling functionality
for features like page table checking and virtio_mem than about
enforcing security.


--
Regards
Yafang

