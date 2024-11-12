Return-Path: <linux-kernel+bounces-404979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA9B9C4B46
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 01:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E76B1F238B1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 00:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5428C200CAD;
	Tue, 12 Nov 2024 00:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zfEcyGTh"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEEB200C89
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 00:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731372761; cv=none; b=Jlt7mxENZpgMgEYA+0qJ5RnoHbWC4P3eYMHpH1FG3fkjwyhSanog3YDaq8dqUadMwx844y4mAuXwyB4xaOL61MKKoO43nZglh14rcF6oB6UxzNJYly741G6GXpguVuOsjy/ElH6Iieg1DeDxPROHu1IZ6pqvDBDWNtGHZgj4R+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731372761; c=relaxed/simple;
	bh=Hlzm0KqNxjcC0EneLl+5zpP4AedDiFrExP44WasP2EE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMqU/KpCO+BVpT1VeSV+8qdRMIOm2BhPPE+zoRkyXd0kLWPmEcG48K8rcrCpsvp7zbJVnmKBek59YzoKnVnZ6SajRFg8jXLK06loQyrspHaBTVTGI9VwSylZ9yymgk0cxFOypnztVL8n1/xvcf4zfi1AHrkga2jph4lHHW8AT/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zfEcyGTh; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-460a8d1a9b7so65561cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 16:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731372759; x=1731977559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6cCgx4AVJ1dH+dX1FVPAJitnY7ihOCkP4FFSYddmJk=;
        b=zfEcyGThk+tmPHPeOidFncd6SILatLme2Mv/jFjrWsvmP/dCSCXCq40MuA8LGJIqQ1
         qBAIZXHIXZdpueMqbrMFwIlj8qIVJvRs0IsleN9EAlDO8HnxE3qRu3/T3Hi/v/DCtZyM
         nD8OhHTHNkD1JAqwCzQ+68aUXh+pvtytzIEqsjYKs/go7ZAJNphjnHZqI59LtoxD5dMF
         Gx2peCb/p2pxIG6pRXf0gBIF1iD0pqnqAZlzojibtSNHq6staki3fNFDhPowCjB3BvQw
         btMzKa009YgApLEt1B26gr8CF/KntkvqRdtDBpnp0x3ED1oEeNrrUJA8G2DWpmw9acNV
         4NsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731372759; x=1731977559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6cCgx4AVJ1dH+dX1FVPAJitnY7ihOCkP4FFSYddmJk=;
        b=k45/h9cLx58992unq+SAdCoHMM029IfXUl6FyyIGyqWktdSp4g2Rs/qmDB56xe7fUL
         xo9fZCKrPXNi3avgu7Yg1PJRsyMkSyJ74Xh2AMhocrZIp/puPFpqRwE2En/aI+E0JCNM
         jQ+Wj7IR+icdyD7e5zVoPS4F0eFuWkkeSkF9akn3pgRlVszjJr7Kvb7SXTm6p6mEC8Si
         ASTTWXflBvtgiWzw85YGAQ70ZABYlxTuNHREruKnMkQQs1qay6LMYSkUVaPHAW9sDPOV
         j5Va05+0b7uKod8fW4RfomAoFqJVrKUnQsJwcV2zpsH8Ft9JnLLWAxtqKDreS+pyakbp
         SvPw==
X-Forwarded-Encrypted: i=1; AJvYcCX3A4kGxBS3Rq8NpVa2ALMf3MCeu8c3N9AkgFal1H+65z7UhNjI/VDlqalvtW9Z9UnFgveLwnyw0UEg75M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUcA3GUI3w8IiQnGbgkaZz4nwlPpxL7V9gEI5S4q9MjvZVX+F8
	nYdev3+tO9EEPflhub77Z/bEvUv8soDtO+uVkY2OsL7D3eNdJmPw1BoMUF4Vt65VE2q5NibHXPK
	Zd+W27CxeT6W63J4DGaF9w4l6hbr0m+JrQI9J
X-Gm-Gg: ASbGncvRdgT0cEJDtRUT5nvLPSz7cm3/NLJvNWsjKYqwf8G+MBqnpDsFEGBF3elzwOI
	07FbomvkImLqaC0qMs2s/dKdHLbX7KnE=
X-Google-Smtp-Source: AGHT+IG+zAIYzLTdQ1lwXDTvgz6ll7kQtaxTe66Wa2ZuB18yocTGfTX10sR6zUj2cm7Dae00sJL4gqfTk8oPb8vvcG0=
X-Received: by 2002:a05:622a:4e91:b0:461:3083:dbac with SMTP id
 d75a77b69052e-463427ddeeamr153921cf.5.1731372758867; Mon, 11 Nov 2024
 16:52:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111205506.3404479-1-surenb@google.com> <20241111205506.3404479-4-surenb@google.com>
 <20241111160659.14227aaa3481648df9892372@linux-foundation.org>
In-Reply-To: <20241111160659.14227aaa3481648df9892372@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 11 Nov 2024 16:52:27 -0800
Message-ID: <CAJuCfpF=uyhHXjU3+j=QKKExMcWy13jvhi7Y_X+iEOKLoxkunQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm: replace rw_semaphore with atomic_t in vma_lock
To: Andrew Morton <akpm@linux-foundation.org>
Cc: willy@infradead.org, liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, 
	oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com, 
	peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, 
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	minchan@google.com, jannh@google.com, shakeel.butt@linux.dev, 
	souravpanda@google.com, pasha.tatashin@soleen.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 4:07=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 11 Nov 2024 12:55:05 -0800 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> >  include/linux/mm.h        | 142 ++++++++++++++++++++++++++++++++++----
>
> There's soooo much inlining happening here.  Perhaps we should have a
> "default to uninlined, unless a benefit is demonstrated" guideline?

Implementing this lock as a separate type as you suggested should help
with the amount of inlining here. I'll try to keep it sane once I
finalize that.

