Return-Path: <linux-kernel+bounces-558720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B534CA5E9F6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 03:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B46C1896779
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 02:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DFF86337;
	Thu, 13 Mar 2025 02:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hBDZujj1"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB0F7081C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 02:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741832998; cv=none; b=fDsNsdDJW3V3D1dnh7iBk7l2hjlCXiH9Wqr4DpcB+TlpBcwVxm4u2dyAuUX8E99gEZDTzr03oB4eRpt7A+oFUaSlyrJwGgAPqPNvPzT894ZOrGWvIvq8n1CiZvRqt030VGyed8FX1/sZhiuxXkYsiUUlu/fSjkyGO/npbKBn/HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741832998; c=relaxed/simple;
	bh=qmeGXx2A1NAbuljKwpxBnF8ga8bqqzllLRpOlTd+ZSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MINXWd+Y4C9wMVnpsF3MppGxU82FkPAHdSGSLFmiW35XXrSKv8iRbkQyrMRyY3m0VhHQnuTMQDGjmtEv6n+CGjYXSTqHoffewJzJSxJLCjCwUy3rU0swQW8lnjgFCF7Zq+QU4FqPsgcutMHzAvhcCHAWEYqRmGVAil5LcVgxhfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hBDZujj1; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5497590ffbbso474179e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 19:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741832995; x=1742437795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmeGXx2A1NAbuljKwpxBnF8ga8bqqzllLRpOlTd+ZSw=;
        b=hBDZujj1NJR/iMQyezqpRnNsUv3rWLgKkyO9+9VkC2wkRbr+6U/G54DRmLf0g1Zjvy
         wwMAbsuFKT0msyRd9CRzsdwdXH/+oMuc1rF4gaIt/mElPprBTNoBmRfdzjgKGw2+k+gV
         sQIjQcvBOJv+ZvUl3jBf+9RZ+uhwPrv3rPpgPI3wYO3u393J8WMGUblrkQZ8jWjPPOsS
         BXSdEa+Ai9uAkXo6OKCwmuhtu4yKebvPN8SG2DPq8E4M+byHPPTHdQZEd58GCV9mmjYS
         5glSR1iHO0UUIXHVaqKg6/t2+pnU279H/2mN9t5JGJGg9c4Xae4RBqANLQ/aVTYniG4S
         UwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741832995; x=1742437795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmeGXx2A1NAbuljKwpxBnF8ga8bqqzllLRpOlTd+ZSw=;
        b=EneQpKWczP3ZXT/zyD/RuiFjFX1/Ok50v+bt4Vxek0UyU3hZIyeSqVC+RB3bE9fwNe
         PEC4etsUl1zan7PG187ZMafGTyP5TEogoqRxm7LjCYB8hPnYdTDjcHIeqAdE7o8IfB7c
         r9QhnTtYQibW+0hfmxI26PQEWveEoRi5BRUkcfTpOoUHwwaY4esNVZFzbRwdSwkB4idE
         1c8cuVTFJ1SLOlFZSqMcQc4x3uLEDZHVq5aOLVGL5Nt9TiLILu+7JX6m/UAD0BQurvcu
         4A+iXjWdEs1YJellFfcHU6WlxUnTUg/ZU8FjGT4+iqF2CrWFrajsPVMxMxpnHl45c15G
         fp2w==
X-Forwarded-Encrypted: i=1; AJvYcCUNbvPR7rMU1zE3fUneCXP7+PO/aLg6k01PRnaNMyjAZ7/HSn0wrewiDJ3IhXfmNsKvyYiWZlfD38he22s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw91ahl/tmkWN5ohL5d/asml6d9962msDiBa2Pen2yTCaKFfNru
	ffXQ0SRLQ04WLmejANS6KJTP0E14lC2tqBVQB5U6OHRVCz6cqSYDYEzETmbrJ8ms8d+TvFBbFVZ
	ahm4+IXJ+K/RlESRMdZlE+MqA9ELLfWnrTWyqww==
X-Gm-Gg: ASbGncsuF6dEFBlOzA14IuN3Xbh7vkeeQc7M9zUl5mA4/gRj/oevlo7CNgr+tSAQnWf
	sXi50sd+ysOsrLnCGeDnKJyh2mk3rAPl8iSlBGSzTGXXdgb/AzM1/JDaDQmcmgAj5nmHGLSt6uu
	JKsnRUGwJA2dCj6MOI/i6DKg9odv7CX1PA8kuOPgE=
X-Google-Smtp-Source: AGHT+IEYUXGUA3sRaQka4rGnypq762oPO2t+iGxw34uT2EYx5soBJ/th0pt98TvntWgNemnIDsXkqAPQgBMFBqc70Tw=
X-Received: by 2002:a05:6512:118a:b0:549:43f8:824 with SMTP id
 2adb3069b0e04-54990e6737amr7225418e87.26.1741832994619; Wed, 12 Mar 2025
 19:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312094337.2296278-1-hezhongkun.hzk@bytedance.com> <20250312153618.e24f399d2d9767ebef87519f@linux-foundation.org>
In-Reply-To: <20250312153618.e24f399d2d9767ebef87519f@linux-foundation.org>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Thu, 13 Mar 2025 10:29:42 +0800
X-Gm-Features: AQ5f1JoUFfEcEatvUScsF6XsU-mtQkFAWzpm1bhdyrvTSYorPI6yVK17DfDQmcY
Message-ID: <CACSyD1NgeJTbrg3aad6GFL=iaYZqdyU4iB3sTLwXk2w9OKLoOQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: vmscan: skip the file folios in
 proactive reclaim if swappiness is MAX
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mhocko@suse.com, hannes@cmpxchg.org, muchun.song@linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 6:36=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 12 Mar 2025 17:43:37 +0800 Zhongkun He <hezhongkun.hzk@bytedance.=
com> wrote:
>
> > With this patch 'commit <68cd9050d871> ("mm: add swappiness=3D arg to
> > memory.reclaim")', we can submit an additional swappiness=3D<val> argum=
ent
> > to memory.reclaim. It is very useful because we can dynamically adjust
> > the reclamation ratio based on the anonymous folios and file folios of
> > each cgroup. For example,when swappiness is set to 0, we only reclaim
> > from file pages.
> >
> > However,we have also encountered a new issue: when swappiness is set to
> > the MAX_SWAPPINESS, it may still only reclaim file folios. This is due
> > to the knob of cache_trim_mode, which depends solely on the ratio of
> > inactive folios, regardless of whether there are a large number of cold
> > folios in anonymous folio list.
> >
> > So, we hope to add a new control logic where proactive memory reclaim o=
nly
> > reclaims from anonymous folios when swappiness is set to MAX_SWAPPINESS=
.
> > For example, something like this:
> >
> > echo "2M swappiness=3D200" > /sys/fs/cgroup/memory.reclaim
> >
> > will perform reclaim on the rootcg with a swappiness setting of 200 (ma=
x
> > swappiness) regardless of the file folios. Users have a more comprehens=
ive
> > view of the application's memory distribution because there are many
> > metrics available.
> >
> > With this patch, the swappiness argument of memory.reclaim has a more
> > precise semantics: 0 means reclaiming only from file pages, while 200
> > means reclaiming just from anonymous pages.
>
> Please update Documentation/admin-guide/cgroup-v2.rst for this.

OK, thanks. I will add it in the next version.

