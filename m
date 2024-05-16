Return-Path: <linux-kernel+bounces-180505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBBB8C6F64
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 02:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DE7F1F21FEB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 00:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA1AEDE;
	Thu, 16 May 2024 00:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVjACBBi"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955717E1
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 00:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715818002; cv=none; b=J0fuDIohSBJj20ewdK5UUYPlpQ/ZOCvar9ZQmnrBUIzBVDQq2CLhefSr56frpe0b0xmqeS4LaHt+/A7W3nSE0qDDrRGtnC7evH8sm2fap+fz0wkWXrdET4gMigKNhnp3pHuh4YFEyLHzEtbTMQBRtzqcLfAcHZLj48B1+2O8qFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715818002; c=relaxed/simple;
	bh=VZeWrx0OYS6jB47/+lrToi8ax+cCwo6XJFcHuhfBVFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ix9EKHfBX+SoGOlO28TiT4ZR+zGPJn9ZY4Z74Wz2ZSkVoEEcFUP0Pcln4mZEmpXxVp8R2jdxafzj6kBGnaPm2ZCTsbvTf7pidMQdHUluyaCc2f36f4hqxAO2h2x2XEiugDE/5dr2EnZjOi/4di4VLUG80onuWhHj81uGPgDJFBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVjACBBi; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a59a5f81af4so230472466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 17:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715817999; x=1716422799; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qXkt2d5OC0yazlvXkniMYKtb6wDXdUmwsgGhPTbJ6y0=;
        b=LVjACBBiRht8vTnPe+9ZrUT3L3pPVpNTpJDWK1+c0jk8qRAIJsrZuM0SzdAODxKuu6
         sUcHjEWuR0/5ZMpXZ7h0GBSJBikVBG4XTDtCqTtbY9vnLXpVFGd+mTj0Wf2sVcvgcQ3k
         HI30P7Pvn4NOgvRX4WUFijmrB6EmbtMknSH/BxhP8X2+h81XZY6SU2eLb+8KB13WHVtw
         BT734Okx/XW2b/kwAGj2Kq5oZwQ90UOvXpUhh5Wdsw33tkEucOQB8XUa8Q18mdtfgKqZ
         XNK03GIAQVq2n2zE5fvAfVklOVqEkNgYkHCPvOXaJTPJJlGyIqER/ud2vNP20TZ/Bt8J
         MXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715817999; x=1716422799;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qXkt2d5OC0yazlvXkniMYKtb6wDXdUmwsgGhPTbJ6y0=;
        b=bSiwE+X+Wr1agYVUThxvOjWMTxbqKhsSM9XthrvP+CsDiRSV5D1k1ufh/1oKtgjiSn
         Qq2YrN0o+Wo7Woxteuyu4Y5pFl/3KgMoNt1soUz810j+833H/WfU94Jx7wJHB58KsaNG
         +i6+Xlw4RuM/F1PpKrmCf6q820D0hnqXPUVFmTfIxqPQY9MHSQV6bzNW/fDO2fnIdiw4
         fIJYWgdRmSH/NO8NE0Qq2kncF8Ayh6slNkidEMv2OPppKeuOLoBh5pytEtOT0Zgdvmef
         S9SRZkwkYQypBHM6RTbj6MEWCnN5Vw7Iif7WunDEYl1plNc8aUTkj7KZQiFAGf1geGfs
         SmVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVA3KaIWCbXF+dtZo45kG04/0FPbSL3QrZa/923JRXsKmdfwB/ssQi3vXL+tcbO2aSH7qiymH6teOQcACyoai2Dzc4NAGD4MG1eMk+i
X-Gm-Message-State: AOJu0YwriTfHl9KYTdWriqeE9kVPk94QGN9jgJthQsjj2Cx/qAMO7os+
	jsNzuGO+cQM6GqriaQ71KgSegutuFiD9yrOVMfH3AaxMJcBk34tKBizhpWOQHIfe5I2hGeFNG+W
	DQWdoQEQjgrjW3QZlzEP4zVP3Ol2Vqw==
X-Google-Smtp-Source: AGHT+IFAEotjeBboaPBFp2QUGMMZIdoqD2WN1t5mGNJO/gCZeS/brOW+E0G5KfJnaQrvg7dmy3tbgJdNajWBs6sH8E4=
X-Received: by 2002:a17:906:528b:b0:a59:cf0a:4e4d with SMTP id
 a640c23a62f3a-a5a2d55a730mr1225744166b.12.1715817998859; Wed, 15 May 2024
 17:06:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tw-53PCvveRcdLUUQ+mjq2X2er5zp6n1KeE8Nu8x=VP2g@mail.gmail.com>
 <CAHk-=wge0et+3PP47OBnNx66Q=i_XgqfGfrSmDGHSyp=Jn-CgQ@mail.gmail.com>
 <CAHk-=whTqHgXZ4Aj8dNO3Peg9Rf0sh2F7zGWRUOmBwfMDxgvbQ@mail.gmail.com>
 <CAHk-=wgWJCcJRLBZ1xoAATFyvp6YKN+qzrePhxQbN1SFrno7pQ@mail.gmail.com>
 <CAHk-=wjm4BcsMrvgXocATBVvZ7N6LAjSvLTzTXWg9EFzyip_cA@mail.gmail.com> <CAPM=9twOiwquA7Zi_mr1vKFV4RQqhnbHv+c9Xz6BadF3tGEegw@mail.gmail.com>
In-Reply-To: <CAPM=9twOiwquA7Zi_mr1vKFV4RQqhnbHv+c9Xz6BadF3tGEegw@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 16 May 2024 10:06:27 +1000
Message-ID: <CAPM=9tyHnK_ReDmFf0eUGGuvKpXJQ0VWuKKhDqJt89URjOTU_A@mail.gmail.com>
Subject: Re: [git pull] drm for 6.10-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>, 
	"Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Matthew Auld <matthew.auld@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, 
	dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 May 2024 at 09:50, Dave Airlie <airlied@gmail.com> wrote:
>
> On Thu, 16 May 2024 at 06:29, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Wed, 15 May 2024 at 13:24, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > I have to revert both
> > >
> > >   a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
> > >   e362b7c8f8c7 ("drm/amdgpu: Modify the contiguous flags behaviour")
> > >
> > > to make things build cleanly. Next step: see if it boots and fixes the
> > > problem for me.
> >
> > Well, perhaps not surprisingly, the WARN_ON() no longer triggers with
> > this, and everything looks fine.
> >
> > Let's see if the machine ends up being stable now. It took several
> > hours for the "scary messages" state to turn into the "hung machine"
> > state, so they *could* have been independent issues, but it seems a
> > bit unlikely.
>
> I think that should be fine to do for now.
>
> I think it is also fine to do like I've attached, but I'm not sure if
> I'd take that chance.

Scrap that idea, doesn't die, but it makes my system unhappy, like
fbdev missing,

so for quickest path forward, just make the two reverts seems best.

I've reproduced it here, so I'll track it down,

Dave.

