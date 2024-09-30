Return-Path: <linux-kernel+bounces-344329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5E898A85F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06141F24251
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE8D1922F8;
	Mon, 30 Sep 2024 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwbnM0L3"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D0418E758
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727709745; cv=none; b=GG2/OoaZpcdDOrOyt6Z/V37bJDPLGlz70THlsP6n2wfxsWv2HpcwxOgXrmjVrnq7cobhQyjMJDEG+DjTvWMNMhxrOpM+269N7n2QyB4c/eAO5bf822RbGEA2H0vG6eLhIEJzCPeuMVEj1eC35IrXpvAyxct4SuTAKOlthEFaLQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727709745; c=relaxed/simple;
	bh=Jpsi6XfXMSfXSnaPz1xwqznOlaE2QGeKuMig8ThwdsQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6yxk/G5yKL506Rwa1ocdWT1K1QUSbdFsdKroKgFPKjtAVYQolepURpLxENXJrkKZnsdikOZ+zb3oGcSQDtS67+uCJoatLHxDfUAKGkUM1SCVzZoBYE18vU1gMHGSvwkeLcWRsgB2LvDasUb2gsWilPlNpGH4nVIms8027T0+Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwbnM0L3; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fad75b46a3so3420431fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 08:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727709742; x=1728314542; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R8XhM/SVrfi8Z4HLnJdUMQS7Li3/arNhnHXWrKzEAUM=;
        b=NwbnM0L3INjsyjvcNz4tEIEIlPD6uHXcnO5cDkUmgjxbaSayM+4jUfUVYv+v872JLP
         /gx/X9NtzJ/c5FTGMCDRI8+tAmKSpUR4TPd/057mQW0mIy4hG/PNndTgFbsKADwuWp2h
         cEhQu2QtKKaFPEJ5ZOi4/Ah+8fUX16wcXuYEOhzTcCrIazDoH7HGvkmO5ApVEmw1e+lG
         0nEld/fVLf266EMJvP7cKwRQQ8x3WFd485NJrw32JwoC28ioLWXoWLlmzzCS95yjQ6B7
         qQ0IE1buxgvqhD93mZONg5e+2r33VK1GOwNFUZHGJIb6jeDw+stcsfnLrlZptqYugyVk
         e6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727709742; x=1728314542;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R8XhM/SVrfi8Z4HLnJdUMQS7Li3/arNhnHXWrKzEAUM=;
        b=g1ffpuKxVQPLs61YuajsqHy33ITRkvowAEgbLNnRuznvJhHU62+6C0Eog2UQmvx3V9
         6GccG9w4w0P4AwH/E8Lc1izqRt6s/Kczk++5xj65Q0zag1reaBznz3CjF1CX9UG0mbfC
         Hf5NKQSuC56EBZnKusRqe65ykkiMyKKhbsDREm1ruSrUFqzT8UKgUx/PtaSD1Qc/eHe0
         7uIoJdvnMOonKDxAe6ry6x+/H4k5/3r2ydm11WwJWJJ1GF2stpmQKPkyRCxl6a/pbQ0I
         665BtPapr5LE6zzxk/2e4yOEKA+CMJWceyFuxC5fQrB50F9uV1vVwSy1CH9Gvvcv9zJE
         /oxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJQmUjbYYEaiOR5QtHMAXccwjLokicgoOGKu3kPV+JtIcLwfiTJgvcu+Pa6gXJiD9VbE7O6liIEHkhy9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAq2kS+cug0iHHcxzoJkEZ29jnhxLdDzYNjX7g1sO87yCRk1+1
	ukYX6vf2nABT3Jy2gXN3xUnFK6swZlHqnuOiJD/+Kff3gSmCiaJ1
X-Google-Smtp-Source: AGHT+IEF2tMeyV2lmrHGKZUDmwUvk0j2fXTyq8LuUAZzHjRsUzJyQAyKwfaqwb6CHCU/AhJkYC9r4g==
X-Received: by 2002:a05:6512:eaa:b0:52e:a68a:6076 with SMTP id 2adb3069b0e04-5389fc6d4d5mr6096930e87.49.1727709741703;
        Mon, 30 Sep 2024 08:22:21 -0700 (PDT)
Received: from pc636 (host-95-193-102-146.mobileonline.telia.com. [95.193.102.146])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5389fd5f5d1sm1255598e87.114.2024.09.30.08.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 08:22:21 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 30 Sep 2024 17:22:18 +0200
To: Huang Adrian <adrianhuang0701@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Adrian Huang <ahuang12@lenovo.com>
Subject: Re: [PATCH 1/1] kasan, vmalloc: avoid lock contention when
 depopulating vmalloc
Message-ID: <ZvrCKmsDy9UiEYcr@pc636>
References: <20240925134732.24431-1-ahuang12@lenovo.com>
 <20240925134706.2a0c2717a41a338d938581ff@linux-foundation.org>
 <CAHKZfL0D6UXvhuiq_GQgCwdKZAQ7CEkajJPpZJ40_e+ZfvHvcw@mail.gmail.com>
 <ZvWI9bnTgxrxw0Dk@pc636>
 <CAHKZfL1jUs1Nh=aqnUrLLMiwb-F15kPc-fqC6i0hRaw0HbtMLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHKZfL1jUs1Nh=aqnUrLLMiwb-F15kPc-fqC6i0hRaw0HbtMLw@mail.gmail.com>

Hello, Adrian!

> Hello Uladzislau,
> 
> On Fri, Sep 27, 2024 at 12:16 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > Hello, Adrian!
> >
> > > > >
> > > > > From: Adrian Huang <ahuang12@lenovo.com>
> > > > > After re-visiting code path about setting the kasan ptep (pte pointer),
> > > > > it's unlikely that a kasan ptep is set and cleared simultaneously by
> > > > > different CPUs. So, use ptep_get_and_clear() to get rid of the spinlock
> > > > > operation.
> > > >
> > > > "unlikely" isn't particularly comforting.  We'd prefer to never corrupt
> > > > pte's!
> > > >
> > > > I'm suspecting we need a more thorough solution here.
> > > >
> > > > btw, for a lame fix, did you try moving the spin_lock() into
> > > > kasan_release_vmalloc(), around the apply_to_existing_page_range()
> > > > call?  That would at least reduce locking frequency a lot.  Some
> > > > mitigation might be needed to avoid excessive hold times.
> > >
> > > I did try it before. That didn't help. In this case, each iteration in
> > > kasan_release_vmalloc_node() only needs to clear one pte. However,
> > > vn->purge_list is the long list under the heavy load: 128 cores (128
> > > vmap_nodes) execute kasan_release_vmalloc_node() to clear the corresponding
> > > pte(s) while other cores allocate vmalloc space (populate the page table
> > > of the vmalloc address) and populate vmalloc shadow page table. Lots of
> > > cores contend init_mm.page_table_lock.
> > >
> > > For a lame fix, adding cond_resched() in the loop of
> > > kasan_release_vmalloc_node() is an option.
> > >
> > > Any suggestions and comments about this issue?
> > >
> > One question. Do you think that running a KASAN kernel and stressing
> > the vmalloc allocator is an issue here? It is a debug kernel, which
> > implies it is slow. Also, please note, the synthetic stress test is
> > not a real workload, it is tighten in a hard loop to stress it as much
> > as we can.
> 
> Totally agree.
> 
> > Can you trigger such splat using a real workload. For example running
> > stress-ng --fork XXX or any different workload?
> 
> No, the issue could not be reproduced with stress-ng (over-weekend stress).
> 
> So, please ignore it. Sorry for the noise.
> 
No problem. This is a regular workflow what is normal, IMO :)

--
Uladzislau Rezki

