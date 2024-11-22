Return-Path: <linux-kernel+bounces-418385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C568B9D6111
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F0E1F21AB5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4D983CD3;
	Fri, 22 Nov 2024 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uQXYXjfL"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0526FBA20
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732287811; cv=none; b=dl1+e0S4TMUll4qlFS/i2dwoznWIP9uCRLvED0Xcad/wevk4Uq0XRIXpk/zFlnGupoRtR9HB52KUxrjfG4SRiaVr9qSVRYbdbUQHXnF9FavmuWTO9ZpGM0Lez5QGJz93YxQgjBPkQT0uUQ+3cmRpswtCWgFEP2QNulwUJHkF9wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732287811; c=relaxed/simple;
	bh=Nl63C1HLI2rSLnQ3HzG/YMnwzQrOjw+mDHM1P+Lsi+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/diRfVk3TDlSYoQOh7b0Iy6MtYNdZK0NR4uAojNqeYD+mGuakh3vJ+RyxuPiyCx6fK5TU6+RCcA3zT/j+0c3L3rHw/+b0ye5TmbrRUd1hcdLW85EBL2WdKTgPYij9/kWcRLPW2sWpwro8HV/0+7LLBZ+b20d5AmfM9gyhqwj0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uQXYXjfL; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4635b03a3cdso201501cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 07:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732287809; x=1732892609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nl63C1HLI2rSLnQ3HzG/YMnwzQrOjw+mDHM1P+Lsi+c=;
        b=uQXYXjfLHWUUiCG/sB62SYWnrpKYfJ0eFAnsLRo+phVR7fz2t0/VvJ8UvpBDyGr3EK
         xfZmOKr486EYr4rzbzbcWneDntgjLiLUJ4kszTP96rGa0AjMIOCQt2cCJDfzbf9XjyoD
         LF8Z5B9sJWQ+vnIlvNLQe4Yp6tss7QWxfEeZH1wa9x2zuBMXeX0cOZpnz4CNK6YPyTSM
         C1a+uTl57wyvPKIlCNorL2FhTEKLEf41U9D6+48xjo+aFmA/PKzc3L9122hs8r2EYog4
         poUqmp3ri6kDqI/fqcGrvnqSTNBJ1VM9073rKsikXqtJrPGsGC8ppnUwqk04N7DSwdPc
         1tBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732287809; x=1732892609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nl63C1HLI2rSLnQ3HzG/YMnwzQrOjw+mDHM1P+Lsi+c=;
        b=sluFCT/ua+ir8X0J4duwJNvBkFCjkP3rZyXbBZD7+G40ImkLsVQRG4hh6hmdmqs9V1
         12+mCHjTRNpJp65nI5JxyIcslwifjJBIeBi4yvM1nSBcrBtSQHvoN9Jelc5j9t1BgY6H
         zvqhQ1QY8oYI+WmFpsEzvmC7bpMZdsKrvGfphNYA1fQe0sh9ENJoQWtSead5VYHOc3hn
         4iSIIx3vKXL8HISO9qebQCv35L0wG0fETiy3VZtXgmcDmNc/lgILnOD1zzIAHo89V2Nk
         B2ub252aXK97EgrnNVmTWpI+kOUBu9fKtfB76yJCNL//e9XHP3Ci5RQOjJCXMyvAdshT
         qATA==
X-Forwarded-Encrypted: i=1; AJvYcCWCvNvwmEBGVyIklNjwkq7tAMV6GneiNbMDbKr58FTNj/z8FjV46kxANuVWNuCSXoRpEFtJfnIQ2R0qfHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrBTRmayxrsjmAgmTPCLvSvyxJ9w+yh3cCZVNi4pBN8gUpOYAW
	uQmVl+yz7uvuPbIePObFbV9XFKR8a62YWABPxjtwtVKqOy0GjqgkWGfrIivYu4H3u3bjBSRpPTS
	KXcj9GZpmddoIOwFO3Fv+G6jC0G+ZTeG/lRkp
X-Gm-Gg: ASbGncvxDpAS6kwBGfGrWKJuPSjUVsXo0p9T5yQwwJjmY0oeZsBjbkvJjw4lzfEf2H1
	o0FBTd5VhrI5oE8iqxOyzR4hQ9n4lk+k=
X-Google-Smtp-Source: AGHT+IGC+mRooV4pvoMCrSny5udIENMYHG/sHfhXWPlUlVFKZ9JEdboI6CKVxw6ofceuVB1DYK4nMwFS7443RiepK3w=
X-Received: by 2002:ac8:5f14:0:b0:463:95e2:71f9 with SMTP id
 d75a77b69052e-4658ab1a226mr2772781cf.23.1732287808524; Fri, 22 Nov 2024
 07:03:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121162826.987947-1-surenb@google.com> <20241121162826.987947-3-surenb@google.com>
 <20241122110557.GO24774@noisy.programming.kicks-ass.net>
In-Reply-To: <20241122110557.GO24774@noisy.programming.kicks-ass.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 22 Nov 2024 07:03:17 -0800
Message-ID: <CAJuCfpFF4AFiMZqEGzJKrboLJUqAMoz0b35L5MsQKVLOJnCmZw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mm: introduce mmap_lock_speculate_{try_begin|retry}
To: Peter Zijlstra <peterz@infradead.org>
Cc: akpm@linux-foundation.org, andrii@kernel.org, jannh@google.com, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz, 
	mhocko@kernel.org, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	david@redhat.com, willy@infradead.org, brauner@kernel.org, oleg@redhat.com, 
	arnd@arndb.de, richard.weiyang@gmail.com, zhangpeng.00@bytedance.com, 
	linmiaohe@huawei.com, viro@zeniv.linux.org.uk, hca@linux.ibm.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 3:06=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Nov 21, 2024 at 08:28:26AM -0800, Suren Baghdasaryan wrote:
> > Add helper functions to speculatively perform operations without
> > read-locking mmap_lock, expecting that mmap_lock will not be
> > write-locked and mm is not modified from under us.
> >
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Thanks for these, you're okay with me taking these through tip/perf/core
> for the next cycle along with Andrii's uprobe patch?

Yes, I'm fine with that plan. Thank you!

