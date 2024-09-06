Return-Path: <linux-kernel+bounces-318089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0F596E835
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 05:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037F4286068
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 03:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6913B298;
	Fri,  6 Sep 2024 03:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2vBpzKLd"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBBA1E521
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 03:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725593236; cv=none; b=el63qcC+v/POyA7zdJkyH4QLf1BwBrUKsHJUWS+exoKgX1ZWmMF3z0SUYfkkj74IQmGzU05DxJFslkPSjEcM1SQm37kBwy+YRcw/ycOkk+zwpnyuaKm3D9x6lHnZxhaPNBLx92337NYyvyBNRuAz02B6nLiWvDMF8/jyopeYlmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725593236; c=relaxed/simple;
	bh=uHRZZTLN7NG2PPLmddrZhcMaT4Ou4KFO8Rg+wmXsM10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NyAgJYznHct0asZlZGJAd2X1BeZhL8EPRHLszwbJd/uMKPhANr/oIcZ9PZD5drIOjfsef4doJbvFVrXHlMbLfru8AJjewhfIxlj0g5OCBFk8/BwdL1jCBqTZcNmpfq6CG7q7Oyd+MyUQgwdva9ixZBdHL9KCGo26Q8ccj6gLuLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2vBpzKLd; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20260346ca1so68155ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 20:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725593235; x=1726198035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCJ8hEVau+Kqq/+vO449Dp7HXhBGlpfc8/wWuzjXhhI=;
        b=2vBpzKLdxiH3PPiz88fnCevMUs0LLr6RHcCdjRAwrW9x5YZz1rvdUKxEtCXUYoFNHs
         n6HHfxiknqfolRlBNS4Jyzhjl1Suau6TcmE1Eych1kZ5YKE+Qwl3Yv5ybUIOm1crgZCU
         0OJjqPkQd0ar0fJTW6uFIQnmFa4pjV/55AdqOwJHvjiwPqD0wj5t6q6PwpH2eB4U57Su
         yY1Nb3vigAshg1PTmQtTx73j7JO3sGSYQvqf6ZwYSFbnaLTwIoGmAZpZ32YKIG342dYl
         k3bqYJ0nc15BG6ZHzcSeYrZcyzx5eEAvPJ7RPRLwZPDaRWQJIN/clgHX38ei31syqNwH
         mn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725593235; x=1726198035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCJ8hEVau+Kqq/+vO449Dp7HXhBGlpfc8/wWuzjXhhI=;
        b=PTT3DL+ml63lyaFDoiL+9HxcGrVqZKljoqjRrl7akdyc67udQz2VxBbNHDHqGG3pCK
         DNxgPRm8G+VvZORSO4/QP/RZYQXH9X9v80cT+S2wkL1dR6UC2QahFhTcLt9kKcTXre9x
         os2//urUj1LTMJNh5uDGmpjQj9gW4cPqgprCOnIhx0rp90Rzd/QMaJ0oFqOk9uuBYPY4
         t41Tgwk+ZON3OBXxUDLJdb6MY3tFe3Y91qICnQ8BCqRG7UHAcHm+FEwzhjvV8bpMavcK
         t5X6RBgOb4VRP0aBswfOMbBERTjRmJlH4flHHWNfX5XSSfGQgJk93Pk0P1z/OSdDf/hI
         fA8A==
X-Forwarded-Encrypted: i=1; AJvYcCUupmqDpMo6w42X81qafvss1QkGQ2IGIkZ5WAuslX2J5eIG29FN+vesXnmo1WzgRNcjQ9ANp8Ru0KAjp1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+YkJsisLkpj1wa2/C3GqdGV1du0kRx4iznc5IyRzXtmfmcvMV
	iuI94ejsGDsgPOtSIiKPssD7jcAABUWdSy1j3KZkoMXjpUyp4BNXtBSjo0brir+4kbE53Ffbrzp
	XjK+wYO2TSwPafgvipbvXe0sHq9RFCPLsN8hm
X-Google-Smtp-Source: AGHT+IEIWepPJHe1y4opznzQE+6YAR0JiWUKSdr6mVlt+6uHnt4Nw+NMAUw/nAkr0CVlx+juQQARPA5vN91bCM35cTU=
X-Received: by 2002:a17:902:cec5:b0:201:e646:4ca with SMTP id
 d9443c01a7336-206f2b2f6bbmr765485ad.14.1725593234164; Thu, 05 Sep 2024
 20:27:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903213649.3566695-1-yuzhao@google.com> <20240903213649.3566695-3-yuzhao@google.com>
 <20240905162524.72c5bbefa075adb466ea6057@linux-foundation.org> <CAJuCfpE323zBTNhE7Ui_JCiNn4cb-w+Hu3Paxi00EicWULLfwA@mail.gmail.com>
In-Reply-To: <CAJuCfpE323zBTNhE7Ui_JCiNn4cb-w+Hu3Paxi00EicWULLfwA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 5 Sep 2024 20:27:01 -0700
Message-ID: <CAJuCfpEfNVSH4R+2i+5tqXfvQRcEb-80vnKw37-oK-5X463sMA@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 3/3] mm/codetag: add pgalloc_tag_copy()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yu Zhao <yuzhao@google.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 5:03=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Thu, Sep 5, 2024 at 4:25=E2=80=AFPM Andrew Morton <akpm@linux-foundati=
on.org> wrote:
> >
> > On Tue,  3 Sep 2024 15:36:49 -0600 Yu Zhao <yuzhao@google.com> wrote:
> >
> > > Add pgalloc_tag_copy() to transfer the codetag from the old folio to
> > > the new one during migration. This makes original allocation sites
> > > persist cross migration rather than lump into compaction_alloc, e.g.,
> > >   # echo 1 >/proc/sys/vm/compact_memory
> > >   # grep compaction_alloc /proc/allocinfo
> > >
> > > Before this patch:
> > >   132968448  32463  mm/compaction.c:1880 func:compaction_alloc
> > >
> > > After this patch:
> > >           0      0  mm/compaction.c:1880 func:compaction_alloc
> > >
> >
> > I'm thinking that [2/3] should be backported?
>
> Yes, should be CC'ed to stable #6.10
>
> >
> > And possibly this one, but for that we should identify a Fixes:, please=
.
>
> I think for this one Fixes: dcfe378c81f7 ("lib: introduce support for
> page allocation tagging") would be the most appropriate.
>
> I'll review all 3 fixes later today.

Looks good to me. Both [2/3] and [3/3] should be sent to stable 6.10.

Acked-by: Suren Baghdasaryan <surenb@google.com>

> Thanks!

