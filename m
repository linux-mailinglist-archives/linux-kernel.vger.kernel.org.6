Return-Path: <linux-kernel+bounces-407079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8110F9C687D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 248231F23AE5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 05:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F9B170854;
	Wed, 13 Nov 2024 05:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kAdy2dz0"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7EA482EB
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 05:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731474530; cv=none; b=Hes5RlgQFe/X+PzWWmXn3p3BWKx8qhpgYQCR3H8jBZ/SNqA8oyzyqXi1p+f0Lh/TBt0zvRi+Dz50a8yzXkW05vc+Y/N2YWH5ySBGlOxXVtH3qN4+NWcoSQo1vZyeUoeySuTye7LHQvZDhzZqbiHbVHP4WSxuPnf8QGUfzSaMgeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731474530; c=relaxed/simple;
	bh=HglbIYhYX9VPsayjWnzIK9QEnblwtzQw/L9bJ5dXIyY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eTXUZAFB5oHmbQQr4OV+HKahWPycpstII7CaP5lYdnMVqnfpjP1m+/+Aukli/eur1XYM1sWS+Nam+OOd5oWaT4rx5CtPhVj9/S5JlzVVbKctIahKYUUPTXPj+9h54Sr1bxm234XQ/sU8eTCiMKLg5TsXgc5zHAbPZdxBVM0hx7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kAdy2dz0; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c693b68f5so67532565ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 21:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731474528; x=1732079328; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PocdKWCIOcIAveRiyakr3Jmx0iCKZXkHZErP8Vwl8cs=;
        b=kAdy2dz0+nLjy2JbDCfmuRxrZvu+BoYdpmOBWHg44zx1X/8XuVNgOgFMIKYjnbdeF8
         +bCtUYDJLxVy7gpHyvMxTRyegThF+PmBWeFhFUh9mIiNc4apSSkMzTe43wj74IGYmaD0
         aFCP0HlUmjivrPmKeKT6DYCDqwZv4VQWvPF1ROcOmWc8gQvhLmVpoyZy+gDtNnpaxy7d
         2jvfNhUOoT21plYOgyY2fnGMQHM6ZCa2dMXzMeg3BGyCT5Fq04iFazy57dgG4/2NrN9E
         bDxKpMfrlIEc28I54dB0ctA3nHFTWnHhEleKK1QDKQCiumfjaK4CkON8MzVFKu+/g5jN
         VRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731474528; x=1732079328;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PocdKWCIOcIAveRiyakr3Jmx0iCKZXkHZErP8Vwl8cs=;
        b=iy15cZT3Tfe7siQXjBuZ2wCT6e+XcYFN3cr340dGAFD2kX8W4/kUlQzH+/5W4D626S
         5QgjCQsKIP3UTyMzwTHU3mc0jQFY3EjuSlDcmi/xc4ndJVKPfhzkiutocrqQSJQB8w2Q
         7rJiFoUay2yWSkYyIDkl8f/x1V0yXtqGvJ7yvdPtot4AykdQkAAI2/J7+JEHG91/5JXf
         AWH4U0anoUc3ZJh7Pwui6gcbIeOFeGW1nYBQ+ZUOS8zdAyAwJAag7Lz9p+qjRuoTiQ1A
         M+85s/se0PC5WNurs1u/e3Igg5N4TihuXTKLr91xDZtEiT8sxKQ74tamoy9VbGXE9Ns8
         BWzA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ85zEgXGWPeRI6hdmZXSKutR66ijJ2ERuXG6+8zFkV5yu10h7C6SqkKCb8QJ8RxhY5QavMxed/RQhxVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YziN4l3V/UaU6ZQqVtoEPuFawJNv3o+BT+0OfFP3hsilwpphOHJ
	qfEPx8ONQgH9/oYYMq4RkeD6i2jTkKuFoX4f4wZYL+Txr7bH0NEZ+6/pOeMhzA==
X-Google-Smtp-Source: AGHT+IHremYgx5NSRN53qdWhX65/NLKA6MKwyE0NVL9BJz4gJwLmJDMYiZ/8j3xp0KSJRj0SWaQTgA==
X-Received: by 2002:a05:6a21:9d83:b0:1db:dafa:e9da with SMTP id adf61e73a8af0-1dc703b54d1mr2469949637.27.1731474527881;
        Tue, 12 Nov 2024 21:08:47 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f5bcad0sm9781575a12.32.2024.11.12.21.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 21:08:46 -0800 (PST)
Date: Tue, 12 Nov 2024 21:08:07 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Suren Baghdasaryan <surenb@google.com>
cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com, 
    lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz, 
    hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
    mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
    oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
    dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
    minchan@google.com, jannh@google.com, shakeel.butt@linux.dev, 
    souravpanda@google.com, pasha.tatashin@soleen.com, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 4/5] mm: make vma cache SLAB_TYPESAFE_BY_RCU
In-Reply-To: <CAJuCfpFd2_7q6pi1=G9B0VW5ynCWhkkDDA3PU293FPtT_CcBQA@mail.gmail.com>
Message-ID: <6d0c5c2d-2963-489a-2376-8edaeb064de3@google.com>
References: <20241112194635.444146-1-surenb@google.com> <20241112194635.444146-5-surenb@google.com> <CAJuCfpFd2_7q6pi1=G9B0VW5ynCWhkkDDA3PU293FPtT_CcBQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 12 Nov 2024, Suren Baghdasaryan wrote:
> 
> Thinking about this some more, I don't think this works. I'm relying
> on vma_start_read() to stabilize the vma, however the lock I'm taking
> is part of the vma which can be reused from under us. So, the lock I'm
> taking might be reinitialized after I take the lock...
> I need to figure out a way to stabilize the vma in some other manner
> before taking this lock.

(I'm not paying attention and following the patches, I just happened
to notice this remark: forgive me if I'm out of context and have
misunderstood, but hope this might help:)

But this is exactly the problem SLAB_TYPESAFE_BY_RCU was invented for.
You just have to be careful that the locks are initialized only when the
slab is first created (allocated from buddy), not reinitialized whenever
a new object is allocated from that slab.

Hugh

