Return-Path: <linux-kernel+bounces-227820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D247A9156D4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7067AB23FC7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503B23A1B5;
	Mon, 24 Jun 2024 18:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NEk2i8XH"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA982556F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 18:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719255505; cv=none; b=GB8L2lQEWIo9vQE+XwhuEDgeDo7LwNrON3KJLJtK5vYhMPr99tkvrbZNNYpxnSecW1V6q6iSw4LuCTx4xeWlOIczcTwT+ks4uvV0lvTVLQ5xn3xgoT5fulDM7+aNQvz5WZpgM7oYQBsjOFuXAj3f1UiU31iFSgYyWRwSa1S4RmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719255505; c=relaxed/simple;
	bh=DfhT8mFcn1a2LnOPe6P8pC0Ip5/ghH5Ia7q534z27A4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fecu/kcQ18xoNJB0ugZnMZA1LvMcUc63bsJTgRLEnJlP9LNciG7E1bRHhK76dzSbxIDwgIVbq4L1A3ThMeMna6gGI2bKRZsopVcQNAkEEHDX5mxJF4wQowg1BTdGTRgBJLSFs3lmwnC4GC7xE2LJdB9uX9z4l0iG6HOEzOdkXnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NEk2i8XH; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52ce674da85so1405377e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719255502; x=1719860302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6eHEi9SDkMR5e8OVKWA2OEJfqCnQ6uOrn8cT6wmAEU=;
        b=NEk2i8XHqfDNSnDytQwUPYCdJPr8AgSs9Ko1gu0EGAveLSOlVumtUu82kiE+RcL7GG
         m/CFXbr6/Aak14aU0FtcES7/aEfS9JitVENhQD0UmmACGAnAp25ApHG7+Os6fXADw11W
         2YQZgUpyEdJXuvMt2oZpT08fEbUYqsm1AErh/iLiZyDGCUZJ/UeJvgA50OGoKAlCxUuY
         iptylppEq3u5VgAxUNR9AMFpfkaGntOsoysS6gqOwcm9tAS85XHRx7Rit55sXf0jg2Mv
         aQNuYQZXxlttqW4PDhTyPqIyDrQUkqRtLodFrgdCU7noRAbeOs03ZZ2xex/NY0M7QfX0
         v6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719255502; x=1719860302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6eHEi9SDkMR5e8OVKWA2OEJfqCnQ6uOrn8cT6wmAEU=;
        b=EiyofzdvYxyGJwBUfGLZph9WbiMQedR5xx8eOFCWV7UN0HRbRrgc+9P4vR8t1uFd6m
         ZmV4TchV+icIlD9GC3GU3jB7gF/CThvok55+hQhjSxksDocFCUkOGYfyny47d58IpJbQ
         jShkhklZXrPTNMmAUsUAFuJLJ/SlTcyuChgvFNe7A4Cw0ilroLxxQVmajeG6TPkiOREM
         gygWKgQhvLRabBzq7vyH/polGLoeItBhyYCZnLCa2jSr+qk75nZcx7PMbU4whoah1P5u
         vzmcl7gFZK6S1e8LNneEPKmGbBCsPRzJjpnji2kZaojF3F5521HIRyArCV1vI0/GBjjA
         2VAg==
X-Forwarded-Encrypted: i=1; AJvYcCUw7kOYm/b8DglI8p62TMWv9QEGEf6va880IrPqX5dUHIWmWerb3SKVVNRrNGNc5ytP57+b65O3vXRUI3AaghbBTUoloBVCoIxXzpDc
X-Gm-Message-State: AOJu0YxPw22YSsN5md+Tirag4ahfVL55Hl662JMzxZi/CrYZJRcymh1j
	NE9j6zy9CH3hVpxsKgZuB3JUeiVr4H8g2GyziT39VAo3DwbqWj+JqWtfTWkEIsBKB0t60GIoXlI
	FUCB3oCqMKITZ0CtyTVgHXZQR4h0WSsfiFxLz
X-Google-Smtp-Source: AGHT+IHZyMdLsQ0W8EhH8qJWEWYjdB11FpXA4gznRxXggQHm6CWkxFasr+6EMUBtpjMO8i0fGNvQ63unX8iPSPC2YxI=
X-Received: by 2002:a19:8c0a:0:b0:52c:842b:c276 with SMTP id
 2adb3069b0e04-52ce185d1c2mr3618157e87.53.1719255501855; Mon, 24 Jun 2024
 11:58:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406241651.963e3e78-oliver.sang@intel.com> <CAJD7tkbqHyNUzQg_Qh+-ZryrKtMzdf5RE-ndT+4iURTqEo3o6A@mail.gmail.com>
 <Znm74wW3xARhR2qN@casper.infradead.org> <CAJD7tkbF9NwKa4q5J0xq1oG6EkTDLz8UcbekSfP+DYfoDSqRhQ@mail.gmail.com>
 <ZnnBVBItTNWZE42u@casper.infradead.org>
In-Reply-To: <ZnnBVBItTNWZE42u@casper.infradead.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 24 Jun 2024 11:57:45 -0700
Message-ID: <CAJD7tkaC6d_RkhRhMpEeS1zTEtoQYw56J3LLdzD1aM9_qu-3BA@mail.gmail.com>
Subject: Re: [linux-next:master] [mm] 0fa2857d23: WARNING:at_mm/page_alloc.c:#__alloc_pages_noprof
To: Matthew Wilcox <willy@infradead.org>
Cc: kernel test robot <oliver.sang@intel.com>, Usama Arif <usamaarif642@gmail.com>, 
	oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	David Hildenbrand <david@redhat.com>, "Huang, Ying" <ying.huang@intel.com>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 11:56=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Mon, Jun 24, 2024 at 11:53:30AM -0700, Yosry Ahmed wrote:
> > After a page is swapped out during reclaim, __remove_mapping() will
> > call __delete_from_swap_cache() to replace the swap cache entry with a
> > shadow entry (which is an xa_value).
>
> Special entries are disjoint from shadow entries.  Shadow entries have
> the last two bits as 01 or 11 (are congruent to 1 or 3 modulo 4).
> Special entries have values below 4096 which end in 10 (are congruent
> to 2 modulo 4).

You are implying that we would no longer have a shadow entry for such
zero folios, because we will be storing a special entry instead.
Right?

This is the "fundamental" change I am talking about.

