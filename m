Return-Path: <linux-kernel+bounces-305451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2654962EE1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1154D1C215F0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F84E1A76A8;
	Wed, 28 Aug 2024 17:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kIKa0x+x"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C671A4F39
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 17:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724867369; cv=none; b=eKdMbQzvFVdkItUyAKLHBmjQpVkeIpZN8bAUksBNbofRiURVkQq05HSCHcXHQC1z87TG21mMyw2qfEfw36saRgV70o5q486p6rZdPf3C2uWf2icCqg1YKFMDEgXX4Z3LQAv/OUtV8Hq/IvN3A8h3XYcT2Hp/TwBJ/BeODOH0p/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724867369; c=relaxed/simple;
	bh=bkHRXutXf6U9zi8ZuWnCGRv2WAfUHYqC3OG0s30htvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f0F1iztnJTvBihGOSBX6QKIXmKGB+xJN9rvkn91eRsaUt/18HIAHcDXIKSZksoE2J6MTvrGT6G6Dc06gFLXPTPeXgxDRENCmel4OrvF1G1l8qMveGJ6lyF+7LREWril1GBKT4Jtmo78skBUbm0o//0JaC0ZmBe/GUXQs3IJBGg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kIKa0x+x; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4518d9fa2f4so29011cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 10:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724867367; x=1725472167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkHRXutXf6U9zi8ZuWnCGRv2WAfUHYqC3OG0s30htvo=;
        b=kIKa0x+xqtwD5EL7eUVlv3OVYMfSxfIdH9fac+x+FhYW+BuaLhvIEm4vz2Sipdp5ql
         hS9UE8NXU2DeNhibSrhsMajF1R3rsNbUblKIDI3nYGTwuIRGIHENOVv+yf+5vMiiDjIZ
         OAIl344Hao9zg/Syou0c0AwuldfVRLjgz0edROAtxP8OnvJfMKoEgupoWglugqi4dC0m
         cZVZrgu1iyLZTScZ2mFTEF7kYpCC/U9CSjAcX4O3rYNMMdCI3tepmfzZNjwHupSE2KW2
         o0XyEe2kTEoH9gKFcoRm+ng9IsqkgOqv7Dn2ujoouoHb7xNPYRawAGw0+azH+1CQpO6o
         VGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724867367; x=1725472167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkHRXutXf6U9zi8ZuWnCGRv2WAfUHYqC3OG0s30htvo=;
        b=N2N2oq0PKvbVxe1UDayg59B1AmTgax8imWdrykpX/gztUW480hwgQvmpEU3rYnHXd3
         rvm58pmM4uTFiUyTMcIvH2WeCjW0mpGKRhHu2jQjuJUGjF9NQgkyB2yxCN9ddGfH5ns2
         Oeyptk3aem3AOYM68XwW/u5v1gJFrnF6p02SOyYH/VA1qYYcKG6QrTBi3SbqyZ356IIT
         bHjxBkIv3oaPU76mdwYUPaX4nsaU4WbFxPHxWg5n/4UZoJoykYv/txFM8UKvhK+/cLR+
         Qx1ioLNq9pao5z7huTcykFZgsFuiaoUx/1ffIjsZj0FeirMbNY/KWaSCrjoQ0aRmCFT8
         VHfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxp9sk/Ix6fcI4opx8QJcvzrHfcmFtBBvNefOCUMdksMGry0kUkVPgCuRZDaxaq/bvHqjk1ZADypFk4H0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg2nygR88237hnoEhcX1DpFfzw6GcIXSxJgdKRoNQRQ9fGqddo
	iT/7/oYESCu5Hy45/bDUQHV3llQXCs44SbjneqZoZdYAxy+DD9Pl8S+GNpX9AU14xrgdRrseg50
	dSlzujIiwnDYnA3WVFDWqGOPVOK/PTzDms38P
X-Google-Smtp-Source: AGHT+IEYwBGfTFm2L33SK9fmz4kJbVLbv8hDQ2e+YiLDLKjI0fPHMvWbn4/4Yh3eoZmDzBbd9BzfQBf8B2iidi0ERBQ=
X-Received: by 2002:a05:622a:450a:b0:456:7ed1:c1cc with SMTP id
 d75a77b69052e-4567fcbf264mr58971cf.26.1724867366963; Wed, 28 Aug 2024
 10:49:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827230753.2073580-1-kinseyho@google.com> <20240827230753.2073580-4-kinseyho@google.com>
In-Reply-To: <20240827230753.2073580-4-kinseyho@google.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 28 Aug 2024 10:49:12 -0700
Message-ID: <CABdmKX1PhoEHuVWAZGcF175-7fhxptY57feg0M8RK4hcePFXfw@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v3 3/5] mm: increment gen # before restarting traversal
To: Kinsey Ho <kinseyho@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 4:11=E2=80=AFPM Kinsey Ho <kinseyho@google.com> wro=
te:
>
> The generation number in struct mem_cgroup_reclaim_iter should be
> incremented on every round-trip. Currently, it is possible for a
> concurrent reclaimer to jump in at the end of the hierarchy, causing a
> traversal restart (resetting the iteration position) without
> incrementing the generation number.
>
> By resetting the position without incrementing the generation, it's
> possible for another ongoing mem_cgroup_iter() thread to walk the tree
> twice.
>
> Move the traversal restart such that the generation number is
> incremented before the restart.
>
> Signed-off-by: Kinsey Ho <kinseyho@google.com>

Reviewed-by: T.J. Mercier <tjmercier@google.com>

