Return-Path: <linux-kernel+bounces-405365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9DE9C5061
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86F62B245B0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD4320A5FB;
	Tue, 12 Nov 2024 08:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GryDa0AN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B1F20A5E6
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731399389; cv=none; b=Xikdfgd0N3Yw01R0UzjtohYYDhO5gSxgB9r/iivwu870JvricKBmLgQjW/d1zpZROToSdjwaHABXXHOMoX76gpzO1lJlSajyl7uLi1IRqPzQQV6Xt32LjIfVMU6+0OPG7M95aDuZhvg9Cg1dR9koMTgis7xdkp4+V6bXGJH0XyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731399389; c=relaxed/simple;
	bh=7Jw4gzO4ApX7cSmGDlDzGFY5iS78Ixw67qfbU1eoTbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nYLWCqMJ1shDJlTy5OIRX2Zm+zTZLusXkI/HM8Yp0Zl+529IBDUDrprCFD2QKP8P+7W/96fDOyoC9idGaGIEDXe1tBr4CR+MD546wFx8Bs6YO3kcVHZVocg1L6j11za/BZNbT3runGxVqubIU8tdB3MT23TZLJXqSX0NF8/QrW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GryDa0AN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731399386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iw5zEH+WVurjSbYYg4DwClE0mzq9PladqDfxhWSI+Fs=;
	b=GryDa0ANH99cnpps48AltJspov172RH5BUBJjDULkoX4iaZdSclYZkZz+vDvzo4gasYm/y
	U1teJzfZ1Qlz2tEPK/nkPnj13zzTTysQERdkL5QW9arLBHxgXhprLFZkqgds2INi9b6ORN
	WW7QuRMPN0LVXfU6x5kUQlvoNKv0SfQ=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-1Qrsca2JPtuT8A_ZkYZO2w-1; Tue, 12 Nov 2024 03:16:25 -0500
X-MC-Unique: 1Qrsca2JPtuT8A_ZkYZO2w-1
X-Mimecast-MFC-AGG-ID: 1Qrsca2JPtuT8A_ZkYZO2w
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-28879673bb1so4399399fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 00:16:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731399384; x=1732004184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iw5zEH+WVurjSbYYg4DwClE0mzq9PladqDfxhWSI+Fs=;
        b=sH2GuFYxFHWwVyagBPoHfbcXm7ZxIhBl6ZVbkRR4VAdxqKv5f5CUGua2+QWjMFYSiA
         nM4ZvzARRJODmi9lgNUSNJ+GFrTRgIxxNLUf6URFl7U9oURQLcDVUDelYSDdY3YX3ZSz
         K+gr0Q5U1V2+r2DBX6mWF1tNQhqdWmKOyUE8LrNOkQ6GL4iNSmZLBEMSrTaNfLmw9SLR
         4lTBeRWsN+6RwJyhZd8Q2nJccQrqUAQvoF2x1ixOPYf82kfcer6R6YuYWaep/cBPLzAU
         WIeWWhZjOeJq8tGp47OmxoA37D7rLs6noTrZeo+rpvIU+JEwQo96FQ4mmIhUj/emPcJA
         LcHg==
X-Forwarded-Encrypted: i=1; AJvYcCX1oDX2OBW/Hwtq8ILEzGCx1wLf9Ui4I/BiuVOpjRunrUu5YPahykk0zQ/nkaln5iumvYuYwa1aXkHWLqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVtlbmiS427mSR5eA9r3ypNNqcFpAWSGS+uNnQDTHaesKbYHEO
	ISpMeK7y6gMVjn1rEKGL828e8n9L0+tpE5R7Gxbe2UlVpJQxrC2ZhojWJV4pBHhfqukEPxk3SDO
	y3OvYZxbWkzZptfNDsjEeHysn/NL/7ygm3/veL5Sem6FQwPquXdGcVg7PLeUvdauAWy+ZwuYQaJ
	iEWIqVADZzzphcWcxEb6ijLmZGjCse9K25YmJk
X-Received: by 2002:a05:6870:d148:b0:25e:1610:9705 with SMTP id 586e51a60fabf-2955ffe9a41mr12962447fac.2.1731399384244;
        Tue, 12 Nov 2024 00:16:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/lkXoMosE+vuhIZsKXSh6dnadfy80lrNwb31674RxlGAcwJ4kamrDbeIz/w57LrTzLzjmHpBdNA68ePwAClg=
X-Received: by 2002:a05:6870:d148:b0:25e:1610:9705 with SMTP id
 586e51a60fabf-2955ffe9a41mr12962433fac.2.1731399384018; Tue, 12 Nov 2024
 00:16:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730976866.git.jstancek@redhat.com> <20241111155246.17aa0199@kernel.org>
In-Reply-To: <20241111155246.17aa0199@kernel.org>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 12 Nov 2024 09:16:07 +0100
Message-ID: <CAASaF6zsC59x-wCRKNmdPEB7NOwtqLf6=AgJ-UO1xFYxCG11gQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] tools: ynl: two patches to ease building with rpmbuild
To: Jakub Kicinski <kuba@kernel.org>
Cc: donald.hunter@gmail.com, pabeni@redhat.com, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 12:52=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 11 Nov 2024 14:04:43 +0100 Jan Stancek wrote:
> > I'm looking to build and package ynl for Fedora and Centos Stream users=
.
>
> Great to hear!
>
> > Default rpmbuild has couple hardening options enabled by default [1][2]=
,
> > which currently prevent ynl from building.
>
> Could you rebase on:
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/
> and resend? I see some fuzz:
>
> Applying: tools: ynl: add script dir to sys.path
> Using index info to reconstruct a base tree...
> M       tools/net/ynl/cli.py
> M       tools/net/ynl/ynl-gen-c.py
> Falling back to patching base and 3-way merge...
> Auto-merging tools/net/ynl/ynl-gen-c.py
> Auto-merging tools/net/ynl/cli.py
> Applying: tools: ynl: extend CFLAGS to keep options from environment
>
>
> With that fixed feel free to add to the patches:
>
> Acked-by: Jakub Kicinski <kuba@kernel.org>

Will do.

>
>
> One thing I keep thinking about, maybe you already read this, is to
> add  some sort of spec search path and install the specs under /usr.
> So the user can simply say --family X on the CLI without specifying
> the fs full path to the YAML file. Would you be willing to send a patch
> for this?

I can look at adding--family option (atm. for running ynl in-tree).

One thing I wasn't sure about (due to lacking install target) was whether
you intend to run ynl always from linux tree.

If you're open to adding 'install' target, I think that should be something
to look at as well. It would make packaging less fragile, as I'm currently
handling all that on spec side.

Thanks,
Jan


