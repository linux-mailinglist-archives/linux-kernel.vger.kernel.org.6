Return-Path: <linux-kernel+bounces-288336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E299538F4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F041287E63
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4381BB69A;
	Thu, 15 Aug 2024 17:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bLieWqsR"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3230F1BA868
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723742581; cv=none; b=OXcoWv+dXTiOu73XltV+T/CVzQ7+TjJ3iLb27t7eHfPLnpyVioqMXinzhDK9JAfuyu9zxEBrZ1zR66CGpnab37z+Ol0x2fYu1tm9ls5T9Lski2RUCnT4ksDKbzXqixQozuP9HbRt5vT+N4mieHnEA4S3wkAK1vwzinypQmmvVeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723742581; c=relaxed/simple;
	bh=d+92bmdJWL8dG05kjul1M2zn2ivm48HvaLaUolBE4n8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=fgWfPRk0av3Pp8fZqxtToQ3AZYeLypQuI41Ao5wD0dYRLQWd6+xUG22b4UltIzJTlrke+OVUSw2I/tbPnpgf6xgyrg4Y7ZwAfslJCKJE/00Oui0DNbmisEAo0nuO8XSfvJohJuePM4t6LXEG5uS09/ghu7xOVRJcCTnL3TprDbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bLieWqsR; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5bec507f4ddso418a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 10:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723742578; x=1724347378; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qc9txLFNP269GzTRVSd78UBtF6r7wyFfjH4FKGxwoMI=;
        b=bLieWqsROwQv2NXegrKpzv6O0RtVW3IwLZMnGJZfs/YnpLwcW2oFzodfCgjdvDCZmX
         Z0VQAT9v+WUujYBi1TF5ACwnUdLJycV76kEFLbAqJTw46EpPcSLx+aKzbk83PmqR+X/x
         PwZdv3d+ZeI60faPtxcUh13FiO6X223AdOma6olAhnwv1vZYTmzYVPaJKeb4QImtZvuI
         3N4s6hUHoAZkjecnBRQ0sGuwACVt9+b1wG6QryOLYH+EH8IAqxafBDWj80PzbeFTSjBi
         hMxUTL/QtBTD7feF4ARThHzt0rVjYJ2cnGbSZvH9Qzqm7dlBBG4SsIz3fYl5KrgXonm5
         ohyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723742578; x=1724347378;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qc9txLFNP269GzTRVSd78UBtF6r7wyFfjH4FKGxwoMI=;
        b=wzH3yqrjzQiHtvBuC+H2J+Fxna5kXna/WnJndsPuqBd622uBp0rVZBasr/pmDthf0f
         g0+/pvodWxzNl00CvG2odXJ18SnU6lpR/tBKV+hOmulLJjrBMWqUZmpYcl5Rvr1JZYxr
         5W52m2PNXQ7my4nbLPzl9lZgPj1asfKI0iDtixzpOYGOA+0k++l+/dttSoaw7M3uV49R
         vRdsn+79pu6Ex2A2gS6dAOEyA1HqFtlkXUPnIAT/4QEFQYkiGA/F4k1+VMkQnv07w3QL
         cx2+XXj+mdze57vZUrnF48hRdR7bc1MU6ldMIalyvl7H34PwwUbP+czHxOjYmPv1zvPh
         prbA==
X-Forwarded-Encrypted: i=1; AJvYcCWzHWcpVmN05ekHu6oCJfArYi+9Tysrqz3xgn8ndbMLNrhqoPOyrymM4Xw//rEPJBRmzr3H75lYytFJjsPtwNpwEcc4GKNiomLaBpZV
X-Gm-Message-State: AOJu0YyptElqp8NjEs70mr41QRvh7CCSCRHDz1fd1mopFxod+N282Vsy
	ORWP5Bf4g08ScG+4llQHkLJu1tODQ4Hmi1a6B4tT1QB82T1fqOQsiBP5qgAMjCRh3otRRfbpMIZ
	8SNeoYNjA3MH0Jql640cp0KSqWDbKLfmRlZMU
X-Google-Smtp-Source: AGHT+IH7huTtE6fqc1WLO9yn5yOimi0bsXeAv6AujezGKXJ6Yhws088ojXAnpq6aCfUkHr5tUp+6H1NTcUzYk7TsaZU=
X-Received: by 2002:a05:6402:5201:b0:57c:c5e2:2c37 with SMTP id
 4fb4d7f45d1cf-5bebb9c498cmr82226a12.3.1723742578077; Thu, 15 Aug 2024
 10:22:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814071424.2655666-1-jeffxu@chromium.org> <slrsrycj73xrph5o2poicpt4cogpqw36bbwi5iqykvyce4pve3@suldmmv2mmo5>
 <CABi2SkV2LcrkYOGzkGm80eYw-mhPNN=Q=P3aKGm0j8_gAwXjog@mail.gmail.com>
 <mlwues5aus4uie52zi2yi6nwlaopm2zpe4qtrnki7254qlggwl@cqd42ekhrxez>
 <CABi2SkVrk-MyMGVDzRZi++7tzCu6k92Vz4hyaVHY2nbYDxd97g@mail.gmail.com> <szuouie2gbpaj6gynixelasgeo5fxtn5fd3vbmebzve2x3auum@2q4cjchfajvh>
In-Reply-To: <szuouie2gbpaj6gynixelasgeo5fxtn5fd3vbmebzve2x3auum@2q4cjchfajvh>
From: Jeff Xu <jeffxu@google.com>
Date: Thu, 15 Aug 2024 10:22:18 -0700
Message-ID: <CALmYWFv+cy4mL85e4fLCC6fbt4FxB1ONSnVaBcezN84bCbEr5A@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] mremap refactor: check src address for vma
 boundaries first.
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@chromium.org>, 
	akpm@linux-foundation.org, willy@infradead.org, torvalds@linux-foundation.org, 
	pedro.falcato@gmail.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, jeffxu@google.com, 
	lorenzo.stoakes@oracle.com, mpe@ellerman.id.au, oliver.sang@intel.com, 
	vbabka@suse.cz, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 9:50=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Jeff Xu <jeffxu@chromium.org> [240814 23:46]:
> > On Wed, Aug 14, 2024 at 12:55=E2=80=AFPM Liam R. Howlett
> > <Liam.Howlett@oracle.com> wrote:
> > > The majority of the comments to V2 are mine, you only told us that
> > > splitting a sealed vma is wrong (after I asked you directly to answer=
)
> > > and then you made a comment about testing of the patch set. Besides t=
he
> > > direct responses to me, your comment was "wait for me to test".
> > >
> > Please share this link for  " Besides the direct responses to me, your
> > comment was "wait for me to test".
> > Or  pop up that email by responding to it, to remind me.  Thanks.
>
> [1].

That is responding to Andrew, to indicate V2 patch has dependency on
arch_munmap in PPC. And I will review/test the code, I will respond to
Andrew directly.

PS Your statement above is entirely false, and out of context.

" You only told us that splitting a sealed vma is wrong (after I asked
you directly to answer) and then you made a comment about testing of
the patch set. Besides the direct responses to me, your comment was
"wait for me to test".

If you will excuse me, I would rather spend time on code/test and
other duties than responding to your false accusation.

Best regards,
-Jeff

>
> Liam
>
> ...
>
> [1]. https://lore.kernel.org/all/CALmYWFs0v07z5vheDt1h3hD+3--yr6Va0ZuQeaA=
To+-8MuRJ-g@mail.gmail.com/
> [2]. https://lore.kernel.org/lkml/3rpmzsxiwo5t2uq7xy5inizbtaasotjtzocxbay=
w5ntgk5a2rx@jkccjg5mbqqh/

