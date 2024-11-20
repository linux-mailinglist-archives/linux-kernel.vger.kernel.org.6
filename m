Return-Path: <linux-kernel+bounces-416434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE659D44B4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6D06B257E0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD3C1CACE5;
	Wed, 20 Nov 2024 23:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ILbPTznm"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08511CACC8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 23:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732146793; cv=none; b=ksX4SEfnkerIfxf54rjuTY9h53djNZ6Dfpw46QS07RwKBcjqN1ITA6ZyEsGVD3RGeWfuH00UxmbhecNo9cI8TMe/9t1kDqzLDit+py0jZPsFpvOHLmhyvz2NZ2qBXpGWefrR/tNbjuHvLiVU81iAxOXfl2dIBde/CcFKPJknOPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732146793; c=relaxed/simple;
	bh=tfSoJca5Mys7vmbDQ2ZgrFBGA9utin1j3Zw1PxzFbUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7ZMAEgbfwdXqPhFfqVlSuievDMDmdeBVuk8E9o+h2vhSYEk7CNPS5SqwBMRUlhXAHNqWPWgEbdfLcNdLEN6l9sB8A8MgS36VQHUWDe+IYOGd+DRedM523opEszlLXpj021aV2Y1FJMkwpLNK27r3OUO7GTVqxUynZQ9ySdNUkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ILbPTznm; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4608dddaa35so150841cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 15:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732146790; x=1732751590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfSoJca5Mys7vmbDQ2ZgrFBGA9utin1j3Zw1PxzFbUo=;
        b=ILbPTznmoPrwisJoDE6rtUOqk4dYM/nbaWIKzBY392AtjECBhRLloYM5WGqH9JHZCv
         nMt/ezOlc7JpRSGzhJMYrNzhj/Ubyd5rr20I8uSA8jWUYktZnB12XeuZhRZPSDzAEIGl
         UC3Yn/DyhcZ/Prot7LemvewVu4E9TDxKuOnA4yrvAL0xEY+ygCiYXs3frDTkHVCGs6yL
         4g+FHmO0nfdCi6Se7dB72WhTSfrJiRhulDO1LZ+pGeo6C532UqnIEwQ8OPK32+eQ2Wwl
         n0/V2rf5VnMqvhtPXOQc/dbo/G0IEDJWZ8aWIlocczF3Ro8mdYa0ciJlfyN9ztAE5AYV
         x6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732146790; x=1732751590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfSoJca5Mys7vmbDQ2ZgrFBGA9utin1j3Zw1PxzFbUo=;
        b=U5j8fO3oIqxqoiyO8li47FuWTmdqcCHgkcaERHnOdQE4fXe3N4kGtDN/22oGJwCaHB
         3WTMbkeSnlhIuGG3sMwzg3aEX3Zlb1SfATqVfaKxiV9itXddC4biCI6KLg6mMDRRRa7Z
         FOlANEpUU9m6pghbUooV1mwDcPHyyLQ3VLR7uZw6bbNiwYZhREIt0cHZEuCJB3ody1Hv
         XYl28WIkoF0lBNU/tQ7Gt55Dq75GomRWoyAxW6CbibhdplCrWF1/jNo5V4Yqa7eV8Llc
         dZVXKpj2V+gpT2H1act1m94TCnWPtIhq2KA7aHJ5iF0cgh0oSW6Ik0MnbpEMG+3I7rgO
         0YtA==
X-Forwarded-Encrypted: i=1; AJvYcCWYSJ44eQgmhSOKWZ+iyVuHO8D77GALo3OzlJMlV+B+nE6oNEBrDGyGmyzewB1/SsByZhhP1/cga5Jr0tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV17WW4o49pyJxbWgKRjrxLPOzGkgmp9yFL/hQSEFlp+l116AQ
	7gnLmM1zfqYn0TnYzU1XIksbA6rwsO8A1r2EyWPW65LCcrWBeLWSAII0XBq2eHCvtQuAV9bFuhc
	/dChl0HNMs4NgsaBl5o/msWDyHBE766FT9gs+
X-Gm-Gg: ASbGncuNTtesoR987IAvDHCePMkIIcprehMASx1PugTwI9TdAT3TJ90zX8al+2nVzFi
	pOSISMTjpUQoKfD5bsGv2IBseO0bdMh4=
X-Google-Smtp-Source: AGHT+IHOHqtu12HxKTzwQ9ea8Tgqmnl1gO3SOvsktFa3dqeLwFmRLXisS/65u0SwMQl44JLD7qB1bPGBItqFEiOgUCo=
X-Received: by 2002:a05:622a:191a:b0:45f:89c:e55 with SMTP id
 d75a77b69052e-4652ffd2a22mr1447381cf.8.1732146790188; Wed, 20 Nov 2024
 15:53:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120000826.335387-1-surenb@google.com> <hdvig2tptf3hi6nmszafarzqb6j56abfbebppqmruvpihlf435@46b57hyw2pfc>
In-Reply-To: <hdvig2tptf3hi6nmszafarzqb6j56abfbebppqmruvpihlf435@46b57hyw2pfc>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 20 Nov 2024 15:52:59 -0800
Message-ID: <CAJuCfpGjm92OiWO_APpZRsRdgC_a=g5cTmwfHoovOPYd+-RGPQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] move per-vma lock into vm_area_struct
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, minchan@google.com, 
	jannh@google.com, souravpanda@google.com, pasha.tatashin@soleen.com, 
	corbet@lwn.net, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 2:10=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Tue, Nov 19, 2024 at 04:08:21PM -0800, Suren Baghdasaryan wrote:
> > Back when per-vma locks were introduces, vm_lock was moved out of
> > vm_area_struct in [1] because of the performance regression caused by
> > false cacheline sharing. Recent investigation [2] revealed that the
> > regressions is limited to a rather old Broadwell microarchitecture and
> > even there it can be mitigated by disabling adjacent cacheline
> > prefetching, see [3].
>
> If 'struct vm_area_struct' is prone to performance issues due to
> cacheline misalignments then we should do something about the
> __randomize_layout tag for it. I imagine we can identify the fields
> which might be performance critical to be on same cacheline or different
> cacheline due to false sharing then we can divide the fields into
> different cacheline groups and fields can be __randomize_layout within
> the group. WDYT?

I think that's a good idea since shuffling these fields around does
affect performance. I can look into it once these changes get
finalized and the layout gets more stable.

>

