Return-Path: <linux-kernel+bounces-317976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A2896E69E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 02:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B62D62856D4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E4814286;
	Fri,  6 Sep 2024 00:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qY6w90sU"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3368911CA0
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 00:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725581028; cv=none; b=K854pSN94E5v8eAvQvDYYnW/XkyJQhszjQRWnoX7fdWSedVLDnMP84EMQO1weQuBRsD2FKvf7AqDiWDxtsossR//b1SqFKGHPMCEMxQc6TiyOciIAZDyY4Jw5W2/nsqaK3606gCc85bgZ1D76g0DHIu/XYaubf6ZSWbPp6bM/xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725581028; c=relaxed/simple;
	bh=FTExDr4SsPThTsASqlRPtrV3OJun7x5QME0S7wV2v20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQFKAT0lYzaDmmHfMPbL4NDAYlHi34POh9y79nID4fPJvqrZpJDx1A/TG6TqmAEu3Ge0RQGDZ/dyp1z3EpUFxVjLtHh3g+XJL+Syyy+FNicOYW1i9+M7bdm9P9oZAVt3rF/6WRKJRCfeFO2A/UpHvRdz6yzovf9ktPb9+ipi5uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qY6w90sU; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4567deb9f9dso69441cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 17:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725581026; x=1726185826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPXmI/TyDF/D9y/43rIHmWzNwquQ5JxVMzVjaWvYv9w=;
        b=qY6w90sUxjck5XDf+ssvXbDL73nPiP74HaBiIG6NHoWcIcEWXJOnSMxy+/59H+11FH
         CwzmyGV5cLrWDyAlvXFulC9kxHW0nucey9W8n4OVhNbJCHAK7rkMCDzbC6Q8I5ln2AsE
         HOYddNOzTwB5TXBqcCRIizyYYUgioNYr3IFRBMRsz07VcDHIs/11ob0vw/Y1NtQ4eADU
         9JYDpWWGgXmDXce1WCSI0ndrvKnIaOX5efIehsLcyTL+6q77YerA1nyp+ny87O1hk0/n
         ViiHUiwn6/+F3gQtFQhy73u6ZIm88ukUYE1Gxc2ZPBn7+WyPbYo9EXaOy81UOt7FiStu
         m0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725581026; x=1726185826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPXmI/TyDF/D9y/43rIHmWzNwquQ5JxVMzVjaWvYv9w=;
        b=XyA3qFFP1VB1pD6mOLgtmd/IU+z0hi7bAIa/6TfKmTLw23mCslgTegYL/iEHtea1vr
         LUcJRJxKXgggHZOt4JpDwK+dxZHhALYyOzoHakAvvyrD8kajrWFRhTXqPw3NitdHTS1B
         5Lxj7g+tbPHbKpFyhrEsvThxTGRz9GMCJF0ABkDTzH+zD16ewOS8PKaBKbBoWk/HNeg9
         OOF/UR9QfNk82kcrtuFasCpzNSbsmI9vM1H47p3C9yd4L0IFuhpgQBTapZdfoXKRcobP
         sjkrlrfBWeZAtq/MPNy44JzBBN2KNDKnZdLhT+FovLmNJatYiw4DfRUJmyUJxfJ+JNUf
         CF8g==
X-Forwarded-Encrypted: i=1; AJvYcCVdAhv8+zWkf9iY7ZlN/jHZGro7Usp9fUOO3r/cXsRPP6iSvVsnR4ZzfTOxI5ht3qeXfJAD/GezsqGgojI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6bfEcBFia36iOZGIBj/6/GuGrVKYtfZm4IOU0cU1Gu9Q377Pz
	Cy5adQILUrV4HMJ0CsPiTZtgZRP0Q1UkzVVio30/nihi56NnV765NxZK81IZKPQDK09uCeXvdvI
	3NeGkzTGG9UFtjTK1jjjVJynVQXkFFfpGkBct
X-Google-Smtp-Source: AGHT+IEMZOh/UzoIimnuqEtAjbzHrbOYH62Ua2jrTuhF/uafkgaZriow6f5Xx4zrd1iIHD53QkVwCDQzgbxVfYoEb7g=
X-Received: by 2002:ac8:7d0e:0:b0:447:e2f0:4d17 with SMTP id
 d75a77b69052e-4580e534e70mr361941cf.7.1725581025736; Thu, 05 Sep 2024
 17:03:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903213649.3566695-1-yuzhao@google.com> <20240903213649.3566695-3-yuzhao@google.com>
 <20240905162524.72c5bbefa075adb466ea6057@linux-foundation.org>
In-Reply-To: <20240905162524.72c5bbefa075adb466ea6057@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 5 Sep 2024 17:03:33 -0700
Message-ID: <CAJuCfpE323zBTNhE7Ui_JCiNn4cb-w+Hu3Paxi00EicWULLfwA@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 3/3] mm/codetag: add pgalloc_tag_copy()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yu Zhao <yuzhao@google.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 4:25=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Tue,  3 Sep 2024 15:36:49 -0600 Yu Zhao <yuzhao@google.com> wrote:
>
> > Add pgalloc_tag_copy() to transfer the codetag from the old folio to
> > the new one during migration. This makes original allocation sites
> > persist cross migration rather than lump into compaction_alloc, e.g.,
> >   # echo 1 >/proc/sys/vm/compact_memory
> >   # grep compaction_alloc /proc/allocinfo
> >
> > Before this patch:
> >   132968448  32463  mm/compaction.c:1880 func:compaction_alloc
> >
> > After this patch:
> >           0      0  mm/compaction.c:1880 func:compaction_alloc
> >
>
> I'm thinking that [2/3] should be backported?

Yes, should be CC'ed to stable #6.10

>
> And possibly this one, but for that we should identify a Fixes:, please.

I think for this one Fixes: dcfe378c81f7 ("lib: introduce support for
page allocation tagging") would be the most appropriate.

I'll review all 3 fixes later today.
Thanks!

