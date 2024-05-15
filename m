Return-Path: <linux-kernel+bounces-180499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727E38C6F51
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 01:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BEF528423A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 23:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD1C4D5A5;
	Wed, 15 May 2024 23:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9uCuaYn"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8295341A88
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 23:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715817109; cv=none; b=s+YNJSr9QCa7qq6pK+N+oVMOhYFUoW89Rr6wksxhH6K40qp+/ZlZ/ItdG1LiDE8TQg2SJwypSJslBMPBt1fNmlSU29Iv2aIoCRMljhA6Bcg5GoCnaL8sIGLuzhCRlLljENVAokoW2vtipXeeCpwMqCmoxcAHqYYsA/p+72q6Bfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715817109; c=relaxed/simple;
	bh=oPPkxBdcY1wh4bDKUOGdH6do04t2nI0mv3AZJLL7fVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bqkt5s67TwTwprjA0qWFDnS5v7aS3V7PBdg0RQQ0V0aE673LWNq9FyY7njxkhtHkDDtMCEjZQjPMUI6TV9l2T/dsln9PH0SUHEMrlZ/AchZLRU5wxTJOBwe/u09YCoGzBq74olE1esvW1gws9ywJGcRFkKB+GKQJVeNbHiLf8KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9uCuaYn; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59a9d66a51so225802366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 16:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715817107; x=1716421907; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6YXsou36uHdIuctIKNGUHwj1t+svMMfcpIbUPLQeTpo=;
        b=Q9uCuaYnIQoMWAeihOj++73PJV9gr50M/qoOV6hhhJYaRqWi+XIM1uksKBQiGBfMRg
         jV6Uv8ASf2gYOleFzkCbSoGD1xIdmiN9A+fMkwMF+qx627IL0HguUFntgpeal+JyRLV5
         /lV+jI6cThuZboeAWbXxR1D2KNpZqKQydovlco9cAfMMUN+fwkqdZoBiK49+PQMhADxN
         O4q+WQUEwAilo+FVBPEXywPPwsM1TSYKe07ne4KzBYyVPTF5jejH8hDbHJprTBrE2+Yb
         ssphLKg0T8cFzHdQfVA3uzdcHIZOUdqbQN/qb8JFyth4yXFaP6Lk/NbOZB9ZhEHFTZQs
         7hew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715817107; x=1716421907;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6YXsou36uHdIuctIKNGUHwj1t+svMMfcpIbUPLQeTpo=;
        b=c7+Oil7JxotfmxviEKjMUQulzCsxvNlckzoSX+HzIMETjeCoDcLQBZlxZlL0zzH0J+
         OmEPvAlK1r6EEOUVxm4dzKj8W+6NxPVSm1koPUOkL6tKun+MAW6VLQkes5jPZLFUI0Jn
         tvHYZWergAEF2HOeQdpiNWXeqjA7e6KczuL7UDYdx2oySShgJP7sA+QitJJdfsLeXfox
         H0woyYOnOIeEurGKdyWATjXWOhkjBkWhl4iyjdcEplaM+0sCYUtcLO49qYrgRx7xWfnD
         o12OOZr2rNWFxHbwCTzUeEhW0v1HqEs4m0srWv1WF32nw2RZCMCMRvvYdxAwd1/BRCzw
         ZFJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWks4v+UKIhjEf1WEDGfyLKSEELZF8FAqsZ7e39Luv4WeA1H5cvFX4GDsgQi/9PZJ/mmWFVEtPaUpjd2msREq5+LlgnBjrJA8UjBkIa
X-Gm-Message-State: AOJu0YxCnx+/vvLsjGuWOoe9DtniOPdIPz7TuTz6pmJvmRHWpGKpS52N
	wBPblXKDFxlDLZjZNCwkyheFAc5Ng8Q9SgUu0o0CZBE+sfS25kjFsgN0ZNL77LKz/4mxxx/W4VN
	zEp3wajmV1siW6wXDdfv7Jckhct4=
X-Google-Smtp-Source: AGHT+IHyVX6Um4N7w3Sw8E4PvbkDsTQs+nIgUiwyfzOQ/ygt5zRXx6XNIyWSkqZhazobgOQ7vLc4iwi52g/Gn3w6UlY=
X-Received: by 2002:a17:906:daca:b0:a59:bae0:b12f with SMTP id
 a640c23a62f3a-a5a2d6656c5mr1439369466b.57.1715817106686; Wed, 15 May 2024
 16:51:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tw-53PCvveRcdLUUQ+mjq2X2er5zp6n1KeE8Nu8x=VP2g@mail.gmail.com>
 <CAHk-=wge0et+3PP47OBnNx66Q=i_XgqfGfrSmDGHSyp=Jn-CgQ@mail.gmail.com>
 <CAHk-=whTqHgXZ4Aj8dNO3Peg9Rf0sh2F7zGWRUOmBwfMDxgvbQ@mail.gmail.com>
 <CAHk-=wgWJCcJRLBZ1xoAATFyvp6YKN+qzrePhxQbN1SFrno7pQ@mail.gmail.com> <CAHk-=wjm4BcsMrvgXocATBVvZ7N6LAjSvLTzTXWg9EFzyip_cA@mail.gmail.com>
In-Reply-To: <CAHk-=wjm4BcsMrvgXocATBVvZ7N6LAjSvLTzTXWg9EFzyip_cA@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 16 May 2024 09:51:35 +1000
Message-ID: <CAPM=9ty=xoLrCJGx+TfcQe66pMCi5-9etPhhb7HgWUOHFM8dUw@mail.gmail.com>
Subject: Re: [git pull] drm for 6.10-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Matthew Auld <matthew.auld@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, 
	dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 May 2024 at 06:29, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 15 May 2024 at 13:24, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I have to revert both
> >
> >   a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
> >   e362b7c8f8c7 ("drm/amdgpu: Modify the contiguous flags behaviour")
> >
> > to make things build cleanly. Next step: see if it boots and fixes the
> > problem for me.
>
> Well, perhaps not surprisingly, the WARN_ON() no longer triggers with
> this, and everything looks fine.
>
> Let's see if the machine ends up being stable now. It took several
> hours for the "scary messages" state to turn into the "hung machine"
> state, so they *could* have been independent issues, but it seems a
> bit unlikely.

This worries me actually, it's possible this warn could cause a
problem, but I'm not convinced it should have machine ending
properties without some sort of different error at the end, so I'd
keep an eye open here.

Dave.

