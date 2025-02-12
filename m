Return-Path: <linux-kernel+bounces-511609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB87EA32D40
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 895C716318F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07279215050;
	Wed, 12 Feb 2025 17:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1aLoNpYB"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74E21DC075
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739380863; cv=none; b=POlWea/0D7dWhtmKuPhQJ0OmUnUuPFjyoFgZ0jOzRv/7Uz4i0uZGYqCAqXF0g3s0Rp731TjkqnxGh6DzfBy+yZZWyXU0OUCkwP8BWGgbjjoipMO4+kAvuJIlpKK7gHshbiPUPXmbO8jvs0+BtxwlwFj4EjUz6/yMqVeBqu7uoiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739380863; c=relaxed/simple;
	bh=fBg8h24XaQGCvCdka9UCyImBhwkLLelkqwpSo0A3WzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m06lP/8BgiOsjgDGB33Q9x5Z/r7bQZzwAW/EQFB8924F4/QjWquvV14MGwPeJwe9XRF2cu0zCh/rFdunmnDfxFwOu+bqRarLvYKomWPfGIfsH2ZBNqZkjiOAlaxLMYbqKHlonmTxmqk/7+JFLjBmgjc8KlAtwARNXacGF6kj0N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1aLoNpYB; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e65a00556aso4546d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739380861; x=1739985661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeSSZK4PSeNrLf/UkOnBIv88I7lwE/8/f+TqwBpL03Y=;
        b=1aLoNpYBvy6EuOJp6qSu+lUJ5Nb5ViE+8xQlL+6EovjUNOV4ULBRDUnYInXpAHy/S5
         6Ori6B0kqBuo+pB6UIVAK55KMuygSgpUWhypaKT9U2Z7H3juTrDo0huA8x3WIv5tMXtH
         XUn50vEtV8L+jDg8lh2cEfrZwRoi5iefTEuWvi1SmQyDhvE+5cIay0i11Xy749h4ZsQr
         3kmG6NNB9tr318lmgX9A6AA3Dg5nltRRB826TaRAXfckkTX+GB8fy2g5dej+Fl1SPSxw
         FCAYww8M0rBkCfR3uHn9RqeaerT8BEkJIkC3PAOeQln5UjZJEAQLqGm3iPBRV4Qob9fp
         pJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739380861; x=1739985661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jeSSZK4PSeNrLf/UkOnBIv88I7lwE/8/f+TqwBpL03Y=;
        b=Fg9ivXMUnNQyfhBv3pA7Gl24ozxdriFYt07MoRJ3y/4BHAPt+9EiMNZcGnd1szKES5
         5rt7akWiexpLy2yCHNp2VWS4Ko6VGWt0wxfM5qdgYZzUu+voZe/FtbZwCA2gxUio0RHC
         Bq2W+t1Y/PZ9bs+VH4DmzMm90ZL/4IPl6W5xsv29O7kGy6t6lkNjq9dQwz5Y6iujuySj
         2A/CFN3Y6+DM7sKdvRYkSFKZFVYs1AAseKKYT8Ut7AowI1vt48vo75bmKOXToo85WUkK
         6eBrM8iABd80c+OgLrfr+yIXHjMK4FBBqSO3EV9GZ8fKRtFXNRDKw3zXqKC21PDzX7AN
         54xA==
X-Forwarded-Encrypted: i=1; AJvYcCWB7/Z4pc87pVfAxZroTCB0x0SgwkhSRt7B3ZrYxCECQoreGAcGjQQ7gHEMagxV4Ra08zf8+IWdOGucIKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKQKfBwLWMoS02/+ahFCfZtbug06G5hR4RhlG//jMxWq/1b1qN
	v3NkpbO9n4yMakglhDEp0dgmqdCR6lCbpJPuJkuORQtVVPUilumgBzqnwayODVe2aEXIvibm25R
	+dqC+xC1KCAESiQfjY8ZxkBz4hwojMQf89742
X-Gm-Gg: ASbGncurK4FXMryw6bOpTC2nvNF54DW1bhrqOK2otkLTF3Jawr7UeixWz/W7YamBl9C
	0Xd5LLHmz4bDlztTtRD83mlm6l4vx1ywSL4DS9e8g8v4t4w8WKslQG1XtGkVNvJCzbApsHA==
X-Google-Smtp-Source: AGHT+IFOkxUKiInOFKVjEDV47EXlD3ULSW6dxOqnsUEPvjxezkS9zqVjaKFFy5oyAWENy0XvWvkqFUEKm6tzA44qU9c=
X-Received: by 2002:ad4:5c8f:0:b0:6e4:4484:f357 with SMTP id
 6a1803df08f44-6e65c14e596mr4105176d6.30.1739380860578; Wed, 12 Feb 2025
 09:21:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318204212.36505-1-21cnbao@gmail.com> <0000000000009221d60613f58726@google.com>
 <CAGsJ_4xdKbH8v0WaBFo_kDOHPXQnX7zrc43D=+irfzM-=2RxGw@mail.gmail.com>
In-Reply-To: <CAGsJ_4xdKbH8v0WaBFo_kDOHPXQnX7zrc43D=+irfzM-=2RxGw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 12 Feb 2025 09:20:24 -0800
X-Gm-Features: AWEUYZm3mTuZ-aqDMu9sN78o3Ka1eekgR0-dKvrCFpfG70KvnGGvV3eUT_2Pwd8
Message-ID: <CAJD7tkYA0ZjdjXAx3ZcFtFzAAbZ2+57QLh99o3JVBVSWNtZM7A@mail.gmail.com>
Subject: Re: [syzbot] [mm?] kernel BUG in sg_init_one
To: Barry Song <21cnbao@gmail.com>
Cc: syzbot <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com>, 
	ira.weiny@intel.com, akpm@linux-foundation.org, chengming.zhou@linux.dev, 
	hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	nphamcs@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 2:03=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Tue, Mar 19, 2024 at 9:52=E2=80=AFAM syzbot
> <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot has tested the proposed patch but the reproducer is still trigge=
ring an issue:
> > WARNING in __kmap_to_page
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 3529 at mm/highmem.c:167 __kmap_to_page+0x100/0x19=
4 mm/highmem.c:167
> > Modules linked in:
>
> + Ira
>
> Hi Ira,
>
> I noticed this warning is coming from commit ef6e06b2ef87077.
>
> you have a commit message like
> "    Because it is intended to remove kmap_to_page() add a warn on once t=
o
>     the kmap checks to flag potential issues early.
> "
>
> Do we have a replacement for kmap_to_page()? The background is that we
> want to pass a highmem buffer to sg_set_page() but we only know its virt
> address.

I am reviving this thread because new zsmalloc changes will make
mappings sleepable, which will allow zswap to drop the memcpy() in
zswap_decompress() -- except for the !virt_addr_valid() case. We can
get rid of that too if we can use kmap_tp_page() in the scatterlist
code.

Ira, could you please answer Barry's question above about
kmap_to_page()? It has been a year and kmap_to_page() is still around.

Thanks.

