Return-Path: <linux-kernel+bounces-338174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7164985453
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791841F2256F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF801157472;
	Wed, 25 Sep 2024 07:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwKU57b5"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE3214B950
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727249931; cv=none; b=lb3bLF4wBVWfsIXG9Lj++Tl4BCwdillUrUgViYtjgVA4wKvT1js8Db2N+V5Zylve7IL/rx3aPbORiubMv1Zgp8+oUnBoBSrntaUdzAAnAsTjqbO4PpAPKQvR2K4ux2Fji0TxERleOOB2I6Rn6ndNzYk4hwLSnslJAYPvUfrwsKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727249931; c=relaxed/simple;
	bh=eVbUDoeIBcNvlO5gxlqTp0ulNdo0eonphmZw9Xp475E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RETPwEozLn+R4ZXnikX5FqPtDMo/B/s4oP/uJ4TXVuuhRG7SPI0XPMyI9kCSGgfUMsdMIgrEgj2Q1zPjqHJMJ4KLLUrO7KqeCdl8BxoV6Zjwbu5lULUyPaOH/pDqaxGildTGfGoJFGHuo9OOfX6zCTBSwNnkNUk1ajepD0t2UeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwKU57b5; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-84e844f7a18so180532241.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 00:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727249929; x=1727854729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5OK3JfJFsgzfIgKm/ygd2dDIm5Oqx4bAcuCB92HWbY=;
        b=KwKU57b5aYBFEn5CQJrSqjuTFwBQSfI/K2wU3WRrjtw4HOQ2bG5dk7kap7M7B8dokb
         jmZs+h2PL97MTaM8982RN2Pb5K3vp7YayUenAnWh6u0x9TB5Se+z5Rf5KoXGxv4Rek+D
         W7mKqt9HxWh36g6hLTnQABuiVcveNysF74v50sa+e1F9W9a0j0OxV+tu+lXoFS2zORRs
         cs8FLu5mrRmAJW8lKz37TnNj+YfDPqsMnnx51BhVHGwPIi1QEkbL/Lt76mBg00sQgDZA
         yBs3B6N0V1NKL797HMy0Ua5hABfDNSLecyTvLQoz0lMrr6l1dYiwfZb+dPDTqjpj+4rl
         0vrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727249929; x=1727854729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5OK3JfJFsgzfIgKm/ygd2dDIm5Oqx4bAcuCB92HWbY=;
        b=xPnSFM8hdiY7Ey/vTWf8w41ItjcY6rNLlt1yZiIisJDIZeoHYyBSogXkZqMWvNbBD6
         iwd7QxygUjDvC25T/qGp7LRgIVa0xHPfH9LCdlcp13WU7/ncsPNZ2c/LsYplBjgkiM08
         CYowSXfFPQburRnm6FDXEPq7jCWLMfo6BY3LqiB4W90u+5PjUrqoalZ1TSsiZ2rtgyZ/
         Z+Jd+ifDI8bhW5z3GClSAVnEcuHly6lXgsxb9ne1P+FzGo3tMgqZytFSwNWsbLGRt5gS
         EASiGUSBSsAcOsuwYOW3MSeVF5r6EHemq9XY5H+SAVQB4vDM919hh7l80HaIMLZ+mIQj
         OBfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfRPQ3cPg315yXfvLzsxGRG0hig+13Tn+N9wSzXt7FSfjTku5+vne0dFZ/tOM+QC0/Jdw2RkitlEdikxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSEeLCQ8nTOQpGU/8db1E0JajvBZM+LHEj5WSojOfOMQBUlYBe
	4gSpkH9aTGKDp8Pl5NF3Ab42L6hFLJx7PKMJEKhnkeY4Tr2ca3oaWgziDO4B6jeBFTbcsrk7blD
	iGLAYm3yTH7tOqoRQhqSHE55yFTs=
X-Google-Smtp-Source: AGHT+IGTzBvqdtPuY0x0mNIFpnzOw5Ccj8XoWi2NhPop//5zJfc98FneRMNXrFL44v32YgxFggKhKPwBaVwCNlvzMeo=
X-Received: by 2002:a05:6102:41a8:b0:493:b9a0:8ee8 with SMTP id
 ada2fe7eead31-4a15dd04969mr1751357137.22.1727249928665; Wed, 25 Sep 2024
 00:38:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923231142.4155415-1-nphamcs@gmail.com> <4d38c65d-760c-43a5-bb47-8e0235c13a51@linux.alibaba.com>
 <CAJD7tkamKcaqHR5V+4+9ixmFc3dC2NnGcu7YzdXqxqNEe8FqqA@mail.gmail.com>
 <9a110f20-42ad-468b-96c6-683e162452a9@linux.alibaba.com> <CAKEwX=PiOdrR7Ad5XoT8pRZDLB=q6B_fmwQ3ScgWFPNptBuHPw@mail.gmail.com>
 <CAJD7tkZFu3DbovTwyRdQmEG=7nQtmzrjQVgyhE4mNzbCtZxFZA@mail.gmail.com>
 <CAKEwX=ML4+iW+WkyjezaqipZU=N=DeB561M4XzOqQMD6drk9dA@mail.gmail.com>
 <CAJD7tkaZwkBbMPaL0mUNyftOUxOgMsAk1KDupZqPq0SO-zeZcg@mail.gmail.com>
 <CAGsJ_4yMxNsmPJn0W9puKWcQD3T7RDyQ=QmPhAtoq=3_u=m+TQ@mail.gmail.com> <87jzf0ryab.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87jzf0ryab.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 25 Sep 2024 15:38:37 +0800
Message-ID: <CAGsJ_4xe_Cz=+tEpX5uu5KVXa61e2D6U2pFvU5MhwUeZo2CD_g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] remove SWAP_MAP_SHMEM
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org, 
	hannes@cmpxchg.org, hughd@google.com, shakeel.butt@linux.dev, 
	ryan.roberts@arm.com, chrisl@kernel.org, david@redhat.com, kasong@tencent.com, 
	willy@infradead.org, viro@zeniv.linux.org.uk, chengming.zhou@linux.dev, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 3:28=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> [snip]
>
> > I am perfectly fine with the approach, in the first loop, if we find al=
l entries
> > don't need CONTINUED, we can run the 2nd loop even for usage=3D=3D1
> > and nr > 1. this is almost always true for a real product where anon fo=
lios
> > are unlikely to be fork-shared by so many processes.
>
> One possible use case is ksm.  Where the map count could be large.

Sorry, I overlooked the KSM case, but it seems this doesn't significantly
change the overall direction. :-)

Since we can fall back to swap_duplicate() and handle each entry one
by one after the first loopback returns -ENOMEM, KSM isn't a concern
either.

>
> --
> Best Regards,
> Huang, Ying

Thanks
Barry

