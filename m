Return-Path: <linux-kernel+bounces-440524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FB79EBFBE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 01:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36DD12836F3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 00:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876B529A1;
	Wed, 11 Dec 2024 00:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="YpLjZILz"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3274FA50
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733875479; cv=none; b=gnMdwBrblWMHGNpiI9A7j3xlr2TMqM7MQYiJH/BCEtfKce+FlXI7SVRJyf/BapW7brodHAS9EmNqYYiO8oCgmChgs43dB7LZ21qARMtM7mqujsIOjYKEGWAXq9Jb0lQ83Z6OmbpRZFUJ1qkWcG0f7s4WGLoQHVJ4QkM88OVxoC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733875479; c=relaxed/simple;
	bh=OCHV6HmvuE1qzKNAPSoYhRL/7FV4ReXNkxuSygUjwFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TenxGcqHlN5rr8mREsQJS0WILqgnlyJdoDDxw3fSWPjOmxpmY9mgeW+hdZV5vqavW8py6+mG5nXrwFuiiBEP/zzR6b2n6j9Kv+WfK6Hj8vTnlyPhzNitBC69JA8+3W0dqUBNzNcnVlf37aRXkB4e4Mt9ew2cpeSNYK1HhqykvJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=YpLjZILz; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e39fb8548e2so5054736276.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 16:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1733875477; x=1734480277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCHV6HmvuE1qzKNAPSoYhRL/7FV4ReXNkxuSygUjwFc=;
        b=YpLjZILzLMYgXC7X3hw3H3EPw5j4ApF7GiexGBB+lCJcoVysqfJDNhgGbn3MTUGS11
         vt+LQTNUBG2/RV6wYQUAcf4Yl/tMbLy58Fj5WAacs1QD0H7VMR4ZR4g3TwScRCEMN+vp
         ML4mzeT6dy5kpGBM0I1acJnIeEQof47hQ85Mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733875477; x=1734480277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCHV6HmvuE1qzKNAPSoYhRL/7FV4ReXNkxuSygUjwFc=;
        b=apx17Xgx7iVk2jjhyBGxrcaRYNazv5OwV7TUZODa5a2E4+m79Z8yPHwI9wOTOjfMuH
         M1XYIHpMBsi5Iw6vABWwlJPbw8zNfvXrlDjK6RZuWvbpUdIa8SDfMQOPB1ysnFWy6Eed
         w8hHXvtP+TqXp/mhUEGiTgR1JPy3Tcmf+v14QnlA/t9IrL7AdEa+fTQViYyY7TsHlZu6
         8OWEjbLaqZdmfKOW4kx7+ikL4MNogMRjsUp4PppA+zVmw/bhvZNtVzhprj6tp/a+YtRR
         U+u6cx0T6FKZblTr+ssyFTBuurLukO7VwbCorn38ij4VBPwcyLvf3kYnznGZPUeDDU9D
         Wb1g==
X-Forwarded-Encrypted: i=1; AJvYcCVtSwbUZ2ZbMIiojsUKhEtMO3RgY6cBHT/gLTCDCFnCWOmeIaWfgaDaXH4SGIjZO9nGGpIy1pKatXChWv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJkkEo8sShwGEzFqyHEHeo9QlLWAYgH62d9AJPqjUYbwkQwDFq
	20bkHsSmNh+Y6/scbKbqC8JheuWdYe3S4aw+nK2NRPW0xCxK3oBbiR+8XGWlFWPKncbn0upMn7r
	0PkVr8m74/gVA0hLIaWhNZoQF80fgNU20nL5Ryw==
X-Gm-Gg: ASbGncszBuy2i0pTtOCs9ze/6LRKb4rmvj93APmcrWE+AZOVdo2t+7b5LySJhxNl9q5
	mVvzZNIUKjy9+4QUc88T+qak0yIDJ9Txu2D+h
X-Google-Smtp-Source: AGHT+IHAdKnSSZvTjoIr7mwXDQmX65FsKpemA7psolWqer3VHIGe/o3rpMktPHVLVXQ+RdM6hXLdwcEW5U5tsp0AJDI=
X-Received: by 2002:a05:6902:120c:b0:e2b:e0ba:d50 with SMTP id
 3f1490d57ef6-e3c8e42e3a6mr1140093276.5.1733875477096; Tue, 10 Dec 2024
 16:04:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204-udmabuf-fixes-v2-0-23887289de1c@google.com>
 <20241204-udmabuf-fixes-v2-1-23887289de1c@google.com> <CAEXW_YRb4PsFgEvHW2QBDY5dxJ+aoMTn3qtj5v9eboxO3SxPLg@mail.gmail.com>
 <CAG48ez2cTrD2_4iKo3+zrPH=e29znYOKLBkC4OLA3yhsu5oMNA@mail.gmail.com>
In-Reply-To: <CAG48ez2cTrD2_4iKo3+zrPH=e29znYOKLBkC4OLA3yhsu5oMNA@mail.gmail.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Tue, 10 Dec 2024 19:04:26 -0500
Message-ID: <CAEXW_YRUVwWxuoWs1fU8OCsOf+vAWc__csX2Ed0W+yVr0Y49aA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] udmabuf: fix racy memfd sealing check
To: Jann Horn <jannh@google.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Simona Vetter <simona.vetter@ffwll.ch>, John Stultz <jstultz@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, Julian Orth <ju.orth@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 6:12=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Tue, Dec 10, 2024 at 11:51=E2=80=AFPM Joel Fernandes <joel@joelfernand=
es.org> wrote:
> > On Wed, Dec 4, 2024 at 11:27=E2=80=AFAM Jann Horn <jannh@google.com> wr=
ote:
> > > The current check_memfd_seals() is racy: Since we first do
> > > check_memfd_seals() and then udmabuf_pin_folios() without holding any
> > > relevant lock across both, F_SEAL_WRITE can be set in between.
> > > This is problematic because we can end up holding pins to pages in a
> > > write-sealed memfd.
> > >
> > > Fix it using the inode lock, that's probably the easiest way.
> > > In the future, we might want to consider moving this logic into memfd=
,
> > > especially if anyone else wants to use memfd_pin_folios().
> >
> > I am curious, why is it not possible to have a reproducer for this
> > issue, is it not reproducible and is theoretical?
>
> Sorry, I think I must have forgotten about this part when I wrote the
> cover letter: The original bug reporter (Julian) linked to a
> reproducer that is linked in the bugzilla bug report, at
> <https://github.com/mahkoh/udmabuf-seal>. I haven't tried running it
> myself though.

Thanks, I appreciate the pointer to the reproducer.

Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

