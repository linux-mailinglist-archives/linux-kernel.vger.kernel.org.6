Return-Path: <linux-kernel+bounces-562397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF92A62549
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 04:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8112F17B070
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 03:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350DD1885B8;
	Sat, 15 Mar 2025 03:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZ9crivp"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4A9A32
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 03:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742008749; cv=none; b=HGdcQmvXTUaE/+I0Vio7+gULOnBFPjHrOng2f0izzXTvk9uwifjph/Yi9v/kmrHF2Rv+rVq0UfatHD8xogSRNmrSeGx8moOexF1hjJK1TuozyE3jwZ/o+2D60IbDjHwfHi+DTIS4hkeEILpkybC2TAqmiQME07CbzYTPFlVLt/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742008749; c=relaxed/simple;
	bh=3NhpaF65/3X/lXn5qRWN5knv+qHitSFrAxMfKLTtWko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cLD0/Ug59UHniibYgpmxqkJ1gcKyeOS1Q5ZxUyFKOFqM8ZI0Z/hccbqRVOAG4YWzwubapSXCuUmXykO7DZRL3BoBL5e7uvdZ0OWykzS98x7ZavzRfYIU56QkaTKcRjdZkI0boG9DUfnKYZXOmxGYr+nRn24U+3cVyAIVrAr9waE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZ9crivp; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e5491eb379so4043150a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 20:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742008746; x=1742613546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mp6xHW3BW8Ft5uIJu/wRbZRbjGrD1lXqYw4CUENFJ2c=;
        b=BZ9crivp4TDgCgLGBsdjCMH9Sg00zl73u+lnWiYBaZ3UIGcvSf6+kGgUW3avZzK1HQ
         HcuZP5JeKqnsAG6qg5zZHAPzCulZ56H35aGJdzKSgF7ZQCYd1ZvethGx7k4HxZmYZaK1
         trKXZL5Oyubx3mG2+62KLVjWWT/+01ecvPB0egpoFc3Rp8T4Jc79VbqL08ZACiEsVa5t
         zUNkTOwzo4ue1cB09jHnpR2rEdOeMkrVkikV6mx6HNLwxX7OiXL0RuPvD9pl3ADMyOke
         DVIR8H/04ab0Tu8OqX/I1gnnOY1JslgG7lvm98LnjFvcYJN9wZinKoHxiVUbtmvmbA3c
         TUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742008746; x=1742613546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mp6xHW3BW8Ft5uIJu/wRbZRbjGrD1lXqYw4CUENFJ2c=;
        b=lxGUtHKR2S62JFHRKnN0OHD6s1IRVhQx5TATU0JYSkbXeHIZU1Yu5T+AvB2gWZyoBr
         zwwUWqwaYY0dh/40jhvBH39IQG6z5ju7BxumYFahkG4wBZQ/1gfiEcPTaSTooURqREoC
         Iovzp2Fo+Ff/DaM002va+v7rjqTYnGr5nWF5166EckyQG1ZLhxdFroNq9Fm3oG7YuSvr
         jomWUYt0ONurgQKRKm3QvNYNpV+u+opMdTYGQ1c/dFEJZlTjJpicGbJK3yR/FVXTF8Wj
         tcuaAscF811Juy7Q63DY87sB65kKBMiHz7YE0Ts/P9PTx7601N2QQ09q6V++y8mw+S0S
         LbXA==
X-Forwarded-Encrypted: i=1; AJvYcCWGENRCzKa84c1Y7v7rhC4snE7ld6NhuLBxpUWHNSYnDwsvZRgCalASeno+nv+sb5XJVr8nJWwSJF3mM2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM5Fxohmt7W3n9Bl1LSpH7ZW8BSTZWm6pWrpVFbBdVnYlXkYn/
	La8sKKv5ZivTBmnkMa6msoaUd088yp1tQ/NW6Tti2X6tR914LgsjCO/F15NycVRbszKwr9SZi/r
	G+QwW/YOM0JRWOcL8OpnU+rCLydY=
X-Gm-Gg: ASbGncs6OBmR+KYJz+7eyS4WuQq7APkl/znMK9VuvhRw6ZOq1wiXZbeVYUqspd25jcw
	LQ8X63vOeFMpjN18qRDy5giVDjc0eSsW1zFE8v8sLlzlJQY+PfW1tPZ2W7mBGD1noJAOxUpXb0x
	Y1JIHDgVeb/WDX7VhxbfxuvPYK0St4
X-Google-Smtp-Source: AGHT+IFNwMYLLr9yqTyxKkZTYEEbIE/pQXHgAwxHs2qWdz81wr56JgxAY2Qv2X85vN3vcf48iRzw+zMFHx4j5EQRu1o=
X-Received: by 2002:a05:6402:50d0:b0:5e4:b66f:880e with SMTP id
 4fb4d7f45d1cf-5e89f24f5e8mr3819219a12.7.1742008745806; Fri, 14 Mar 2025
 20:19:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314144300.32542-1-ioworker0@gmail.com> <67d46976.050a0220.13a4aa.9cf4@mx.google.com>
In-Reply-To: <67d46976.050a0220.13a4aa.9cf4@mx.google.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Sat, 15 Mar 2025 11:18:29 +0800
X-Gm-Features: AQ5f1JrkRtTHgfdkUyn2wHIxM2h2LKKakop94cLmNFggeQ42d28KWWvc5zKD_ag
Message-ID: <CAK1f24=CUe4Ugb8GHb+yTyj692Z1=YK3gO13ABAKJUHWVjWQdw@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 0/3] hung_task: extend blocking task stacktrace
 dump to semaphore
To: Boqun Feng <boqun.feng@gmail.com>
Cc: akpm@linux-foundation.org, will@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, longman@redhat.com, mhiramat@kernel.org, 
	anna.schumaker@oracle.com, joel.granados@kernel.org, 
	kent.overstreet@linux.dev, leonylgao@tencent.com, 
	linux-kernel@vger.kernel.org, rostedt@goodmis.org, senozhatsky@chromium.org, 
	tfiga@chromium.org, amaindex@outlook.com, John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 1:38=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> Hi Lance,
>
> On Fri, Mar 14, 2025 at 10:42:57PM +0800, Lance Yang wrote:
> > Hi all,
> >
> > Inspired by mutex blocker tracking[1], this patch series extend the
> > feature to not only dump the blocker task holding a mutex but also to
> > support semaphores. Unlike mutexes, semaphores lack explicit ownership
> > tracking, making it challenging to identify the root cause of hangs. To
> > address this, we introduce a last_holder field to the semaphore structu=
re,
> > which is updated when a task successfully calls down() and cleared duri=
ng
> > up().
> >
> > The assumption is that if a task is blocked on a semaphore, the holders
> > must not have released it. While this does not guarantee that the last
> > holder is one of the current blockers, it likely provides a practical h=
int
> > for diagnosing semaphore-related stalls.
> >
>
> Could you copy John Stultz for the future versions? Because John is
> working on proxy execution, which will make a task always track which
> mutex it's blocked by:
>
>         https://lore.kernel.org/lkml/20250312221147.1865364-3-jstultz@goo=
gle.com/
>
> I feel it's better to build the hung task detection with that in mind,
> thanks!

Yeah. Thanks for letting me know. I will keep John in the loop ;)

Thanks,
Lance

>
> Regards,
> Boqun
>
> [...]

