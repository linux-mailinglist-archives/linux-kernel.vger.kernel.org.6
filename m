Return-Path: <linux-kernel+bounces-516236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0660FA36E8B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 14:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6659818929FC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 13:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF42D1AA1FF;
	Sat, 15 Feb 2025 13:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWKm4jZD"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0535B1369B6
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 13:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739626500; cv=none; b=cVNf/S/2Qig6v5jirCtn5/7fLYGlIGAxWwCbsUwochuGZLS952/D83FdyCzBBrxMYumqqWZhqtKHVTVk9NTMG0cZ8Rg8Vcz1DubMNYKqBESSZK+GVVPaNvCrUSeEaggJw1e95GvHrN9aFbqtafrByYK+SUbLKYkNptd3466jEvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739626500; c=relaxed/simple;
	bh=qtISEi3VWWpCQFwIz4erk8DnBh5MPj5P2UoKg+Kghd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=maUcSN9349uIJkv8K3Ztar9ICctpyhhv0uJ56NQCkat96jy6JwgcjXBB06QWtxA/oCK1qgctkGpjRc4A7/2n/DX54vHCNYdbB+qml6XORHNlCYe8xglZ/MAhp+l2RLrtGSTNsYs8u+1QQi4GTyVYbyzU5FvFiFQF0XJ2Hk4SUe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWKm4jZD; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30613802a6bso30273431fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 05:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739626496; x=1740231296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtISEi3VWWpCQFwIz4erk8DnBh5MPj5P2UoKg+Kghd4=;
        b=MWKm4jZDPa4nf2j65T2ok/KQMmAYqvddr3AMrAJO4DWuKR7woYpqtk82Rrq5McgqVu
         rRFEr0iuZ6gh8P0pR6Vrj5evLXkkN7jEkCNdizqzRvIsz5BRVztfPeoCDqjmhAJuyRGJ
         q85/az16rNR8I++tQKgszVMBs4TZa+OWlY9+5GxmfNpx7nHMoC3yLAJEPqsfWk2Yawfp
         JBRm3Ie1K7NA9oGpB3IjvInieHS2HaEaGdxCJw+tzC8Z6wLzMMGeS0FhtjDIUQuEH2hu
         0d203Fqxz/XLPqx1HEekVGaGYpWhh8nFvpOAhMzEtpO+ygFW18abzaAwmhG7lSavMUol
         32PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739626496; x=1740231296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qtISEi3VWWpCQFwIz4erk8DnBh5MPj5P2UoKg+Kghd4=;
        b=AnuYr7/TrIowK+YWI48w1kaFVoEin6G30wVkjlqQVg9NmoMuCUr716rmlIm7iPyoff
         da5AjauxluboYDXqr4bGRhuRMExMSJ4g7G55ra438w/jf28DB2mNae+P6trA8Ml6r7rx
         eqlUWNyMARmDvivDelBO1sxqCxEIoxFa6AvYvAfixOXRv+CR7WNZynDDzlTFdo7R/l6X
         vruXhU/dNIlJwNyMXtNb4R2qU3ikGqpaO6dIhJ9nDPDS9dy1Lmn8tDbI3pqfervnhyJn
         Tdd2rdBv9QAAKIr2mCmMgBAAAPKjMttoPQsEHdZGyFv9aq7xTuXIasJf7hz1UVgFQZYr
         3jSw==
X-Forwarded-Encrypted: i=1; AJvYcCXkD+1fradPpbOA9oCIFyKfZ6ZdP+vriGJJ9ZHhkX8XHnfyt/eayunvitUIuCiaOTrnepL+t7MGvkpxYlk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9aLd7F3T0r53jfvJl06gnmSQw9NO1e4nypc+0hlPN6Bhp84No
	4K5ytvvWVdlXUZkhRMkziuCfKpzknCYi6T4NsSYLOd4oO9KhZ7AZXnJX5nJxUcLMY3iZSy9HxQc
	8jOh953uNcrkoeIO9dKvcbuY8KPo=
X-Gm-Gg: ASbGncuPmjhvIlj2MTgVaVmhKg8C6gEAklIW766JLpXChxxY072RtY49J9Omrz78lcf
	9thO5bs6e62GPudNiIdcx9EQ8pcUzkl/O0VFoDZgjcIIckdph9fzwpCzxS9ErEFVoVhg7JtRF
X-Google-Smtp-Source: AGHT+IFkHwrDrRt0v3rd10LeQLiumvR8TIbe+AmPA9arbLlMXfcqEz8MruliZZoJuyuyz3DILPXeMOp8rIAD30/IGqU=
X-Received: by 2002:a2e:87ca:0:b0:309:2012:cc59 with SMTP id
 38308e7fff4ca-30927ad5181mr10239421fa.26.1739626495747; Sat, 15 Feb 2025
 05:34:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214175709.76029-1-ryncsn@gmail.com> <Z7BsL2v6+oweqWE4@MiWiFi-R3L-srv>
In-Reply-To: <Z7BsL2v6+oweqWE4@MiWiFi-R3L-srv>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 15 Feb 2025 21:34:39 +0800
X-Gm-Features: AWEUYZncoCkFOJoAvMT12FkOeKGzmq1T0gZdXeu6E3ZvgiV4Ma_hq-Uj00l-Mmk
Message-ID: <CAMgjq7DUdcbRdYLtFF7_VaBkzY4=VQXsRtDg_xhqTyBLmtMG9w@mail.gmail.com>
Subject: Re: [PATCH 0/7] mm, swap: remove swap slot cache
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>, 
	Hugh Dickins <hughd@google.com>, Yosry Ahmed <yosryahmed@google.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Kalesh Singh <kaleshsingh@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 6:28=E2=80=AFPM Baoquan He <bhe@redhat.com> wrote:
>
> Hi Kairui,
>
> On 02/15/25 at 01:57am, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > Slot cache was initially introduced by commit 67afa38e012e ("mm/swap:
> > add cache for swap slots allocation") to reduce the lock contention
> > of si->lock.
>
> Thanks for adding me in CC. While I got failure to apply this series
> to the latest mainline kernel, could you tell what is the base commit
> of this pathcset?
>
> Thanks
> Baoquan
>

Hi Baoquan,

It's based on Andrews's mm-unstable here:
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git

I've just re-checked, there should be no conflict. Sorry I didn't
include this info in the cover letter, mm development is rapid so
usually I send patch based on mm-unstable.

