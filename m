Return-Path: <linux-kernel+bounces-371532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C68D39A3C59
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ABE41F21627
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8B1204F7C;
	Fri, 18 Oct 2024 10:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="N0LPbRsl"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C4B202F7D
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248862; cv=none; b=Lxm850Alp3KnUt4B1OZEeKLbIvdODOcz3/3dSRP0fvL+IQwGGmzUs8vHxn7HH2o3QlS9JQHFMDLpisWxaPQfJFWv5rlXXw1A3QaQwQAWPfODwmD0p1Abcid3IfqtfiVxNLMdRu6+lZQbuJVkAboDwcJkUihU0dCaNElHk1hT/XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248862; c=relaxed/simple;
	bh=4KdIkPIu8+BVH/HhxDVkrlnmCaApwKvkSreVyNO50nw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQvu4FRLZr+QmI5JlVrfIMnQtaVtSoZFrygei6UMmOt0tXFukpVhFOtHKrI+YGcM8+3862rg2lNLZiqWuFjcbJGN3v0kyvPiShqn04sdxV/+BEM0e/jZfCMQx6L3cNutLh2o+UUak02bbDoaXaEeF6DyhAcksEsnjUZCDQ9ZTFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=N0LPbRsl; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso254986166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 03:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1729248858; x=1729853658; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GAUQbRgxeTaGabj2y30qoVfCLTrJkkrVwRxImKaAGOc=;
        b=N0LPbRsljKPakgISvZst6DDhm0pC4uIXZ86cUb5oSYQMgMMUGUFWLmFDKQvjP/y9st
         zV0aZ/MYHbKSFVt89TQBD0RxYyI2WDaDgAA8nuEYlfHueOq4V5sz62T14gz7CoZnC7qX
         3rAqAE+fQZ1pAd0FprjsAMLmFB4tRwULrm/h8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729248858; x=1729853658;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GAUQbRgxeTaGabj2y30qoVfCLTrJkkrVwRxImKaAGOc=;
        b=lQzX8XofZV3UesbafsCD+v9xhjiUzLVs1DNQyyQANkPRjsH/R64CdCQhkOEhi4Qgbl
         aT9IqsnRnmCE1E+nqAKQIlFW3gVwciu0uOGe3L2dGm3r/Z3xLFNwf46Iuf3vazX+67Nx
         gVuszzSwW0LBYjA+R8EvDQF7s4B6g9vteeWBntYNbj1wHW9z6pSrcQNefZH8voy2pIwI
         xSGjCOnMaw3RZnm6Qb6Kwl2eMMJanPPdTzgJahIjC/Cq1fUaESNvB5SeEjr5Gz7C9jcC
         SVMjNFl/xyTUZ4jlsESGeoKi03mLTeB7XGITwxfQrwnO/OwsVLc0qEu0knBUtcrnQtWT
         XODA==
X-Forwarded-Encrypted: i=1; AJvYcCVyeCGELsOPLt7dMA1xkCpL+duByK5WV1Jusk8Hz2GnYSv66tO4rmXDgkCdh+TvOx/OxqgvlkBLAlN9x/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUOGP8bzwkt8/ETiI0x1WAhkvjANH61Ljjp65CcPjHhIlXGg4C
	om84BObPiC7EB6e+OIraZmfIbMpSI2Q0tf5FRHKbNius58Ftm39W5Zq8F3AsbwB+te3ucVeBD0F
	uSR+uVsZWg8Z7+HKVpwfkyGb9WxNXVgGCDNE0Ng==
X-Google-Smtp-Source: AGHT+IEUJUA2pq8KDG9toWCxMK1E3E/CZn7+Yka64gVWbmzLoa6UO/Pp4meoP0n2MMwKk05OG44tsPblS7BNCM2AQ9k=
X-Received: by 2002:a17:907:6ea9:b0:a99:368d:dad3 with SMTP id
 a640c23a62f3a-a9a69a8083dmr157649966b.30.1729248858070; Fri, 18 Oct 2024
 03:54:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66fc4b74.050a0220.f28ec.04c8.GAE@google.com> <CAJnrk1ZrPcDsD_mmNjTHj51NkuVR83g5cgZOJTHez6CB6T31Ww@mail.gmail.com>
 <CAJnrk1ZSZVrMY=EeuLQ0EGonL-9n72aOCEvvbs4=dhQ=xWqZYw@mail.gmail.com>
In-Reply-To: <CAJnrk1ZSZVrMY=EeuLQ0EGonL-9n72aOCEvvbs4=dhQ=xWqZYw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 18 Oct 2024 12:54:06 +0200
Message-ID: <CAJfpegu=U7sdWvw63ULkr=5T05cqVd3H9ytPOPrkLtwUwsy5Kw@mail.gmail.com>
Subject: Re: [syzbot] [fuse?] WARNING in fuse_writepages
To: Joanne Koong <joannelkoong@gmail.com>
Cc: syzbot <syzbot+217a976dc26ef2fa8711@syzkaller.appspotmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Oct 2024 at 21:04, Joanne Koong <joannelkoong@gmail.com> wrote:

> > The warning is complaining about this WARN_ON here
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/fuse/file.c#n1989.
> > I think this warning can get triggered if there's a race between a
> > write() and a close() where the page is dirty in the cache after the
> > release has happened. Then when writeback (eg fuse_writepages()) is
> > triggered, we hit this warning. (this possibility has always existed,
> > it was surfaced after this refactoring commit 4046d3adcca4: "move fuse
> > file initialization to wpa allocation time" but the actual logic
> > hasn't been changed).
>
> Actually, it's not clear how this WARN_ON is getting triggered.
>
> I will wait for syzbot to surface a repro first before taking further action.

I think the issue is that fuse_writepages() might be called with no
dirty pages after all writable opens were closed.  The exact mechanism
is unclear, but it's pretty likely that this is the case.

Commit 672c3b7457fc ("fuse: move initialization of fuse_file to
fuse_writepages() instead of in callback") broke this case.

Maybe reverting this is the simplest fix?

Thanks,
Miklos

