Return-Path: <linux-kernel+bounces-321848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE0C972052
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 19:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8DFE283D0F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9B3172773;
	Mon,  9 Sep 2024 17:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N1Tyz1gs"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900A316DC12
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902460; cv=none; b=F53TxyefU3y4WNsR5fBChyKHEq2JQp0LeZA7PtLOe6xJsYNZw15w+ySxijy1w7saBdK34pZ8pWOJH8xxJfLR79+tRsfW8VsQbNKSCWoCQ2eoqW+NiPti7Zqyj2T8jIxBr4YSQP6YiQ/jRGL6MTqQokypPpPOt6iO+3hHY30YzGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902460; c=relaxed/simple;
	bh=CFGndf6+Xj/OcozYle3EJLLaDe3XNlSVsUPxx6tiLjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DjdvAY45g6AdElp3xWw+mu/rbPa9g/aPjcLFhtdz3vBK3an5BaMc+V4CciYr1LOZRYeZcFKhswO9DzbTMVPxf4Dt7ptzYV2brT7x9bdqeOL9d3KaxE7OjeXH5e1GdlVaQiFE/MfSf76cTw+wg0ak0v4mj4+y4P8/6J1bX4iJmzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N1Tyz1gs; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c26852aff1so5170002a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 10:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725902457; x=1726507257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFGndf6+Xj/OcozYle3EJLLaDe3XNlSVsUPxx6tiLjI=;
        b=N1Tyz1gsYTR+RD4N6oP9E3fWeqETO/xWc6Sn1arnbuAL2Z8uvvJ5sfTOcnldIoDLS7
         jCuqpm4dCm6ejuR+JPLUyKP0JB7Ano9juJeTkBxOZYFGQGDxEdFoZXHH1Fahb4248RRL
         wB4CKHtrAmffSSe3KFjgdyo251RqCEqMS2k/h+9+b1MHskLjpeiGaN2f+fRd3e+xJDNs
         Z0UIUMpQBf+yVigkQ1JagBdRqdX8YG3mYNrmm2U6nhCdUcgfZB491jLcf0SOl67O4Rr+
         kgKy+s3aToc6cAHh8LO8OVSwUAP9V5w31+m/x2WNj3rxHLKZVGiY8RWeFYvnc5YyhtyY
         LJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725902457; x=1726507257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFGndf6+Xj/OcozYle3EJLLaDe3XNlSVsUPxx6tiLjI=;
        b=QCb16U6u7kp78GWSF99winQdevP3hKxY+xuuhDlT2QuTZ5AP1g+PZ01BImesLsnOd4
         9dJ23axDZzgBfyyV7Y2+2Nw7KAsDAxQyR54xmRpTPPPBbN2PB/KPu4cM1q8e93uScBWb
         XAzmiQVwbI1G0BzD5rPJ4yBShWWKFyl3pozj/KPloHxCxLJWdLVjUpVfFw8SvfF3xm3o
         yH26Dlh+t0bQ7dHAG4v1b+W/J7dmgKHUS9Nxmgc3ZW8HyGwtebicc0SgtKyJ++qdg5p2
         eNZGEW6vSgvG8PzZ4A8Yi9ltUDRJFP37EN8sIEaY+5ll+jFYWJjUBa9J4oC0/U0SdBPB
         xskA==
X-Forwarded-Encrypted: i=1; AJvYcCW+3f0EBR2Z1fWuhx0xQaBnDfhI6T7ETK65FoMRCtIjBP1b1V+n8kKdzBQ2TnHkAzcwH0zREVQvnmmbStE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNMvuxgNOIJe7Ol9g6mnV+bnTiNnThdj1vwdxGqnL1WZB1PDu7
	lSYYCXoBQiaWvBNcSFcmbxfrZHDB1RxI/ioGLtS85mnvAzkfCVauJXHI2Y29rZXs3xHc86wxT+q
	5ZPjHNRYGmPNeWPGTn/q913wPal6IclFL0Qv2
X-Google-Smtp-Source: AGHT+IHEMkXRi8Qojfd5ZuTkY9ul6MC80RogKg7lfulxwokHMBECv3XZL6XRA4yYXJEOQGWoOekFvGU/bnyKPClSXW4=
X-Received: by 2002:a17:907:1c23:b0:a8d:2e3a:5303 with SMTP id
 a640c23a62f3a-a8d2e3a54c6mr540762566b.39.1725902456088; Mon, 09 Sep 2024
 10:20:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905173422.1565480-1-shakeel.butt@linux.dev>
 <CAJD7tkbWLYG7-G9G7MNkcA98gmGDHd3DgS38uF6r5o60H293rQ@mail.gmail.com>
 <qk3437v2as6pz2zxu4uaniqfhpxqd3qzop52zkbxwbnzgssi5v@br2hglnirrgx>
 <572688a7-8719-4f94-a5cd-e726486c757d@suse.cz> <CAJD7tkZ+PYqvq6oUHtrtq1JE670A+kUBcOAbtRVudp1JBPkCwA@mail.gmail.com>
 <e7ec0800-f551-4b32-ad26-f625f88962f1@suse.cz> <CAJD7tkZNGETjvuA97=PGy-MfmF--n6GdSfOCHboScP+wN1gTag@mail.gmail.com>
 <bda30291-ab04-4b72-89c1-b4cb4373cfce@suse.cz>
In-Reply-To: <bda30291-ab04-4b72-89c1-b4cb4373cfce@suse.cz>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 9 Sep 2024 10:20:18 -0700
Message-ID: <CAJD7tkZpbS-ArHC16sfysKcWjM0BwQCuNoKAQhRoPA-OV5Mv1A@mail.gmail.com>
Subject: Re: [PATCH v4] memcg: add charging of already allocated slab objects
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	David Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>, 
	cgroups@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 12:59=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 9/6/24 19:38, Yosry Ahmed wrote:
> >> But in case of kmalloc() the allocation must have been still attempted=
 with
> >> __GFP_ACCOUNT so a kmalloc-cg cache is used even if the charging fails=
.
> >
> > It is still possible that the initial allocation did not have
> > __GFP_ACCOUNT, but not from a KMALLOC_NORMAL cache (e.g. KMALLOC_DMA
> > or KMALLOC_RECLAIM). In this case kmem_cache_charge() should still
> > work, right?
>
> Yeah it would work, but that's rather a corner case implementation detail=
 so
> it's better to just require __GFP_ACCOUNT for kmalloc() in the comment.

Fair enough, thanks!

