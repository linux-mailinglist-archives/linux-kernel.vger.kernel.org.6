Return-Path: <linux-kernel+bounces-399496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EEB9BFFD6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FCFD1C21439
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2A21D1E64;
	Thu,  7 Nov 2024 08:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYzUNY6h"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E067784A2B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 08:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730967696; cv=none; b=uPR4ifnT4EXOWnyWOmG5PbPPbTt8L6PfkGNAClxvRXp6pS2vG2uW2ZVHHNvFcOsYoXxaPsesI65qCHvqAOso59BhKC/b0Kkf4uTZeRP7tVxLQjyQ2Sfu2tVNkbk4p6TEUgPo/PszgKMzwoeoM/4cc1NZah2fdoQGjhGG/j71MU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730967696; c=relaxed/simple;
	bh=5VOR5CG5z5tJAz08GO5kOR/f1vtcXPoi8DLyImsNBw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8ha8bUbipRAlR9qFzC8awCcwEpfd11zL5nt+d/6/GFpuOJ28tsWKlL/5wCJY2f5AgIhu/aLKbX4GDgI4EYrbXZUZWjcv95uGw5Qd0L1x6O11tX7vDR5bT3wKbyuS4vrxC0I90Cz6dKoywbwQL3Zd5bxzqEPoXRvC0d66SrA4+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYzUNY6h; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9ed49ec0f1so112426866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 00:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730967693; x=1731572493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VOR5CG5z5tJAz08GO5kOR/f1vtcXPoi8DLyImsNBw4=;
        b=RYzUNY6hCnBHHs+xgjecA7g1urvnrvAwS81r9XVcE57Sj26xHKKs3fcIskdCH37aee
         sApl+FFGGyYsEMis1v0yLf16Lmx+wXeH8g/n2T3CU8e0RhPSvCJukBIWi9GWqEnbOENk
         034m3WvX+YJ/6CqGMQqzyqmZDsYNHVIMJ2qD6O6VU2mpyATt6qok9HpNfeHPT4ch3L0v
         QIWCioPZMAK15xnV9EsAVPzol84pxjlSHkg42B+TBYmnPBvPvTf2FG6J8r4iDPXDw8UR
         m+SU2ILxQowSw5I33dgWTDaQaTdqh3XxOd6Riuag5Pe+yrkciLAgtUe5fV6TV/pJ9GSl
         d1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730967693; x=1731572493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5VOR5CG5z5tJAz08GO5kOR/f1vtcXPoi8DLyImsNBw4=;
        b=HDVha+ZA3qkj9YAYFx6CySyy2EPEktFma4o4HxD36LWIoP3sjb74dK/Q3qA3M/kjm2
         XLmLFd0G05JIBhJlIYl5ZM56HdTFi4SZVtDGyKYYZW7F1BcnpoQCX8tThCALc4rCNuGb
         p7D3EpklTv1W755VbhIZQXHspSM7db5OLwpNBjfqGJrax1q5ywQqlju3I9PQ6SIfLBZY
         1yfq6HH3H1+LQD9Pqun8GiV+/ZpV2VShbfwKMjLes1b94f7lM7aPYgPDpJ7gTLKsRahG
         a37L/gsVmaIMUzhNX7I/04QAYsjYzLCEwkoe9KyO3rh1fujRYO+IwbHcn7gzvtZQFPVC
         IFkw==
X-Forwarded-Encrypted: i=1; AJvYcCUk5nIymM9PokPW68MZ0bbFqyYHZcsLqORuZvOT8JlLRa26jLO6O2e69MRaeHKQmu1T4rVQN9jllFc3TPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeAy63ChCwXVA9fquxRhTKwA0B9U5nv4askc9oArpS1uS1ciH5
	+eniWCc1onhnkEy5Xjtoj8Q+5fvID2YXj4b2jvy1/bhxb/BSMxuPM+Rk54S0uERJyvXdQsP8zjJ
	kKH3PX4hC539EpIKRT1ArRr9Di4o=
X-Google-Smtp-Source: AGHT+IGzp4ZhM15P5BuZqJNwFlSO7u7lx6xlY6hASCP8GFqOKEug7q8+mJvAPBHNOu1UYfSi3ksydcl56G/UnZhJGfY=
X-Received: by 2002:a17:907:9622:b0:a99:5234:c56c with SMTP id
 a640c23a62f3a-a9ee74cae8amr8688466b.33.1730967692918; Thu, 07 Nov 2024
 00:21:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017075725.207384-1-giedriuswork@gmail.com>
 <CALt+6nqxMZjuZuOKaj8Cx4dcNZx0n-0F9aa97d-vZoMWeN=bOw@mail.gmail.com> <Zyk8dFthM0EA2A_K@intel.com>
In-Reply-To: <Zyk8dFthM0EA2A_K@intel.com>
From: =?UTF-8?Q?Giedrius_Statkevi=C4=8Dius?= <giedriuswork@gmail.com>
Date: Thu, 7 Nov 2024 10:21:21 +0200
Message-ID: <CALt+6nrS2aRHYCyrba5uBUXsHdPntELdj0MYPbv69PupHBKMtA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/i915/lspcon: do not hardcode settle timeout
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, 4 Nov 2024 at 23:28, Rodrigo Vivi <rodrigo.vivi@intel.com> wrote:
>
> On Mon, Nov 04, 2024 at 02:09:46PM +0200, Giedrius Statkevi=C4=8Dius wrot=
e:
> > Hello,
> >
> > Kind ping.
>
> There was a pipe underun in CI... I honestly don't believe this patch is
> causing it, but anyway I decided to trigger a retest there before I push =
this.
>
> Thanks for the patch and review.

I don't see that on my laptop. Resuming sometimes still doesn't work but
this helps a little from my testing. I will continue the investigation.

Best regards,
Giedrius

