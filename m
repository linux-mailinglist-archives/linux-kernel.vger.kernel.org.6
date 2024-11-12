Return-Path: <linux-kernel+bounces-406370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE669C60DB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96581B27058
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423F8208224;
	Tue, 12 Nov 2024 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kbnMvFI6"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C668206E7C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 16:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731430699; cv=none; b=h7j16ZE1xPGaNe/MKzaoxK6s2326L0Ymur3h9MLl2UKhrD/NiFzOkAqmkos9rYATCzitWb6jUZNF6CI8t4gnjx5ZnbJAs0CstKvtsYakgF2goOPTlSqO5OcrAojDYPBFG4HhZ3VID/R5qy1KXU0RTym1/a+LtvLpSra71d257u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731430699; c=relaxed/simple;
	bh=uw6GZpPLfyeji4d0zzVBBXtfO7VGREIoZj1JUlXSkwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F2SPBVREPvT0rnQ7KsOi9dpaWpqAV+7ksu4VzvoJRBVzgvpCxyEgzUtX1Vz/6h3HFHaLw+Bf+Zix0yfV4AuL7zIK3jUqxGO8mh3iGuFPXLoQLFT3uqgHjxBJQ2shlp4Rrr06qCnbmMQl8YlqsAtlcjYDVZFTezZz9biBaCmIQno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kbnMvFI6; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-460b295b9eeso263941cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731430697; x=1732035497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Q349X4O3ThW9mGj94pBdAshyZ9YK6Y/LlQyE9ZF8/4=;
        b=kbnMvFI6fwIchPm0dHHewOUH8LwcSxBjRwS0O8Noun2hXeV0aYplspYFGdVUCRX8id
         nKhCLntfjMAy4HWZfFCSmPqwPR7FW01gK78X48rf5Yh1AT6CS0/aCumfccAWNYjHwb4B
         vILKZmPod3jw7+IPlPDU3dQ3zZyAgxevHCdfIiYnI/L5EYf8PJoDeEycH/vyR7BHpu/u
         rB54gtwpmFbJ9y8N1t660fun013EFHOdaBINIsgJhITreiDaihD2o60jVb185N+1lp57
         guoCRLvdXsRnyGMmt5ND4xHUYGPkxgbf2TFVLVI79/6uB8XOZDI5L2YGK6jBqx2ZMGyu
         O3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731430697; x=1732035497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Q349X4O3ThW9mGj94pBdAshyZ9YK6Y/LlQyE9ZF8/4=;
        b=MgKcCUgDb7Q2Ajx98Sv7QePH6vYsZxPanZX8gGkVdLk5//8mNH2sXHqv+0agsghJDj
         VJ5EygM8wqDF2pvaAC+q3UOqKfQXSobl/Evs2yo9P1fmNcX+yAN2L/Y3OAGHV5UymkTE
         6JvgCAU41vG8HN05JhTqyzNoxbh3pa9ragIbzGB4Pvd0n9xzV/uE3bhtOO5bvPydfm5c
         b2z9pd1CezOhcWRxQcSocG0A6fXC2S4qe8dG9IE6y+x2MtmQIdE52+GPgg601+7M3erU
         NLTP/1y4lywJwN3Fy0rajbg4791c7MAgjb+u/xqcu0s2XXQqTdUr93WyH/gLAK0D46X8
         OFmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5eyUEVJLYq0L2KwjuVwL9xxsJHMTObW5SNTcShMBj7exgth2EPQGL90wgfP+WJ9c72fiN4TdJiP7KHrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd+NqtOqrUMzYY3AhH62XkGuvJ/sWKR9OTfNiZtpOzX9mnCZxc
	dccvxZtuKS/1K/iBP4uyMl5rHXCxBgnQ338MvYAtTgs5Z7ZRuWq7S3og5WJKf5hVEk0xS61Zo04
	1DPzwRtJU7mI2tItbE5Pqt99ub4Euv7T6iGzV
X-Gm-Gg: ASbGncsKl1HOmWfdMeA38i0YJT81XUNbffED3CrpYGawwxEe0NZ4UA4URXJ69RvYmKs
	/AYTRGfQ+z/rQTBm0Zm2F3Q45eCT1a3G7MXR5keW6Aymb2Hf3B/DyntXfPWyPNw==
X-Google-Smtp-Source: AGHT+IHXNK6wQ46kS3qqgXDpujV8J8Zp6o5bogO1xLkDGWaaY7Yqk5Zv20VA3J7KtvY5Q0Jucz8mZPryLXDwsX3i80I=
X-Received: by 2002:ac8:5d94:0:b0:461:66ea:ea70 with SMTP id
 d75a77b69052e-46342894062mr2679711cf.15.1731430696665; Tue, 12 Nov 2024
 08:58:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111205506.3404479-1-surenb@google.com> <20241111205506.3404479-3-surenb@google.com>
 <07a72c38-22f5-4b99-9d74-0877eaf2bee2@suse.cz> <CAJuCfpFvPis7mdHDsgK=H54SXDNpbJDpDQ2aVYKiFViueQj4Sg@mail.gmail.com>
In-Reply-To: <CAJuCfpFvPis7mdHDsgK=H54SXDNpbJDpDQ2aVYKiFViueQj4Sg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 12 Nov 2024 08:58:05 -0800
Message-ID: <CAJuCfpGOjnwXuDh4y3O=8NzRtGFwMS8qEpmiYMSaC9JbWFLfZg@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm: move per-vma lock into vm_area_struct
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, hannes@cmpxchg.org, 
	mjguzik@gmail.com, oliver.sang@intel.com, mgorman@techsingularity.net, 
	david@redhat.com, peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, 
	paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, 
	hughd@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 8:08=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Tue, Nov 12, 2024 at 7:57=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> =
wrote:
> >
> > On 11/11/24 21:55, Suren Baghdasaryan wrote:
> > > @@ -511,7 +476,6 @@ void __vm_area_free(struct vm_area_struct *vma)
> > >  {
> > >       vma_numab_state_free(vma);
> > >       free_anon_vma_name(vma);
> > > -     vma_lock_free(vma);
> > >       kmem_cache_free(vm_area_cachep, vma);
> > >  }
> >
> > Have you investigated if this allows to perform vma_numab_state_free() =
and
> > free_anon_vma_name() immediately, and only kfree_rcu() the vma itself,
> > instead of performing all this in a call_rcu() callback?
>
> Yes, it should be fine to free them immediately. lock_vma_under_rcu()
> does not use neither vma->numab_state, nor vma->anon_name.
>
> >
> > Of course if we succeed converting vma's to SLAB_TYPESAFE_RCU this imme=
diate
> > freeing of numab state and anon_vma_name would be implied, but maybe it=
's an
> > useful intermediate step on its own.
>
> I'm thinking maybe I should post SLAB_TYPESAFE_RCU conversion before
> anything else. It's simple and quite uncontroversial. I will probably
> do that today.

Uh, I forgot that I can't post SLAB_TYPESAFE_RCU until I eliminate
this vma_lock_free() call inside __vm_area_free(). So, I have to
bundle moving vm_lock into vm_area_struct with SLAB_TYPESAFE_RCU.

