Return-Path: <linux-kernel+bounces-227138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D61BF9148F4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F4C2840AE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DF913A3E6;
	Mon, 24 Jun 2024 11:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hkzGVanZ"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485A8125D6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719229186; cv=none; b=eKKcVuZHYea4+INiAj5Odqd/NMR/CFSln+sTS/6CbKyBCjLFPTmPSXkrs4CzTC9W5Hlzo1xvSTRvOqrK8Ezd+ZC3QQKH0cpdi6tLdq13456ldzD+xAh6Dj/TQZ6I+iLaMCpEf1IXYOgWuxlRB4O+Fvq+bUSaKHb1YdCaILuwAJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719229186; c=relaxed/simple;
	bh=M6E+Z4q0t6fWuppwjmqdhl1cVxuMUHJxywE5tNzb6uU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LxdxAyyxBTsnb0ZQUv1ISratTb879Qe3icfZ7CCvBey3U4deVFRGJDyDiPCzLNTOK0GUdXhIxNwiBAX8rC9ZegQFbqlGuHA/WD57cKPj7ChT7HXg2LXVNSf+NGEGIdI3sWmS674Q6GtsmPVcqR2rZ+oTFc1JqEs9AvYTJYR7kOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hkzGVanZ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6fe81a5838so169995566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 04:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719229183; x=1719833983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6E+Z4q0t6fWuppwjmqdhl1cVxuMUHJxywE5tNzb6uU=;
        b=hkzGVanZ/aQrfIZG2zHyuIFdv6IIxasirOyBZyTV35ZW1QMhxTODw67MQ2ArmBOXKv
         sOweL9cNHpSoSSzUTqggcD+EH3fEDPwbtkltrKmzmLZzzd4IG8B7zhUxrOZd+bVAYZms
         4ExIvukn8cznicrPfClPGPx0C83fZHRFr/RUpM/b1gI7yjFiIh7YtkEr0DWdpWLp0HUV
         w7HXa57DGMuGj3y0SadEat3ApLKPzGCB8se0l14TAbj4LY+1C+hohVPWJ8H2+VK10b0q
         V+nhOTiNjytLQLxIvfHa5GWaxA+VMaLsKTGcNG9NEnvxmwVIxmxsMR1UBIedrxPTmPUt
         JRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719229183; x=1719833983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6E+Z4q0t6fWuppwjmqdhl1cVxuMUHJxywE5tNzb6uU=;
        b=DkTwWnejYpRcmJdPjRM9LlKz3Z3Da5RrDOdGGasRn0aWhFYDm0XOydwrOUQZWSogTf
         6UdtBnBgUorLvPY4jBJjfni4KFzdc/LkO9Jz9S3dkWF+znTeoRvzwEhJG8zvVabhnd9W
         8tqkRB4e2xAS11ZDtB5aRmigoAXfHrxJwD559BA08RBZZqYDt2CtmIgMKZHfpUbxUoaO
         xU/dyOkOVrNwKTf61JshlfUm34dKDUmyJ31Ogid0VrDw7gaG/4xFyZ7y2gYMNLpSMJRL
         2ukGucdr1UHnzOew0y67eviR2/6q7pqsPJqybsqyrAXwCtqjyBdte8GJdvK61CsPr2zI
         o28Q==
X-Forwarded-Encrypted: i=1; AJvYcCVdycy1JRXjjmdU/5inbgUXfGU/C/QHFyED/7XnIfCPhFF0WOboNOO0a5wAEkIBO6J+EAPT3F51tw3wW9IELJp3HQpoTzc6hchj7JAZ
X-Gm-Message-State: AOJu0YxuGVLu6c0UqcLnEeQWS8IkRmsIgWA/CbCaPha9bIOLfAmbkb4N
	B46OmfZ2vzcPo5fJptNlwCptT8nSHq+VhRrgXXZpEeP/iIHopfuqv/AdPRvJSOg/wmhsfgibMBC
	JmkLrr9x/iF98qc4Or/ewpL+M0R5t3zt1du7h
X-Google-Smtp-Source: AGHT+IFVDjJiW5tRgKr7Rv6jfLtNj4pMnHxoB1S6WgpkGHM8UIogHPVME1RMJr/Emfw2Q+GzhXHVWc9V7sBVpGwkqRo=
X-Received: by 2002:a17:906:a8d:b0:a6f:e552:aae4 with SMTP id
 a640c23a62f3a-a7245b648aamr247139366b.25.1719229183074; Mon, 24 Jun 2024
 04:39:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-zsmalloc-lock-mm-everything-v1-0-5e5081ea11b3@linux.dev>
 <20240617-zsmalloc-lock-mm-everything-v1-2-5e5081ea11b3@linux.dev>
 <CAOUHufaCYqwZLwCzHbC40KDjSWKYFoVKiPfRxvxr+2Z8JRRXaA@mail.gmail.com> <CAOUHufYijvmo+-jRJWCeDEhvyf4z6EBMA=2ZOW2OBxnC2Y2qLg@mail.gmail.com>
In-Reply-To: <CAOUHufYijvmo+-jRJWCeDEhvyf4z6EBMA=2ZOW2OBxnC2Y2qLg@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 24 Jun 2024 04:39:07 -0700
Message-ID: <CAJD7tkaYnHvQmq=6OfHP-k7Bgq650xYJz=o7XzAg7ArGNtxQxQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/zswap: use only one pool in zswap
To: Yu Zhao <yuzhao@google.com>
Cc: Chengming Zhou <chengming.zhou@linux.dev>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Takero Funaki <flintglass@gmail.com>, Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 1:20=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> On Mon, Jun 17, 2024 at 2:16=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote=
:
> >
> > On Mon, Jun 17, 2024 at 6:58=E2=80=AFAM Chengming Zhou <chengming.zhou@=
linux.dev> wrote:
> > >
> > > Zswap uses 32 pools to workaround the locking scalability problem in
> > > zsmalloc,
> >
> > Note that zpool can have other backends (zbud, z3fold), and the
> > original patch was developed (even before zswap could use zsmalloc) to
> > make sure it works for all the backend.
> >
> > This patch only makes sense now only because zsmalloc became a lot
> > more popular than other backends (even though some distros still
> > default to zbud).
>
> And this might also have answered Yosry's question about the
> "historical context" here [1].
>
> [1] https://lore.kernel.org/CAJD7tkbO+ZLdhs-9BpthztZX32i8C4=3DQEnoiXGS7bM=
399nqwzg@mail.gmail.com/

It does, thanks.

