Return-Path: <linux-kernel+bounces-200561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02CC8FB1BA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58423281862
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F007145B2E;
	Tue,  4 Jun 2024 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxmqnVtj"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0817D145B07
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717502632; cv=none; b=eJp1Qj5wGO2SYOr5gkwOP9dhvMIWv3WTtYJcamaAc1ETcmKDATm0b85fc7R6iJsL5+uxBRHOQKoOYg/lgzn3i0AoGzC6oVRVOHrwfD3F2qXhdwWAWxF3eoY9ewTAPt52FgpadpoSAWhvLkdHr7DgvKA3y+gemDRr7AI3kFe96VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717502632; c=relaxed/simple;
	bh=ohUteCCr14DvVrrrPnFI1Jm0Fo1hkuR15Sefi+jOngQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=WnFaH8/nEFuNqTgjr1KJXJ+CO3MAw97roHnANnPZ+Np7QZVxWGmF0+9ULx6h0iHG3unxQd9cOR8WYuwtsDrem+G3oTZNxYmeNvQxZvhHbmqzoylsfXmw5oJTCvDdO47xO/vouvAvNT5ch0/3F+g0LuBmPlXTauWapQDxButELng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxmqnVtj; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a626919d19dso974448266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 05:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717502629; x=1718107429; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C4nlrs5Q5b1jrnGdcQAM4D0fQRXIDjBPjqNQMqZMjmY=;
        b=FxmqnVtjcbPhFf2ctS1qHZLt+O56dPdFdWEW12sQqWYuhIQXlhOyCfWAn2su2yzLaZ
         b8Zh0l/Nzvdo7e8EmpG02TZr/Du8tdYpZKqPiBB1Yts4Q00mLq3++7lY6p/gdxdvAOvB
         r3Iiz0hXZb3BLJQDQS2BDBltNTDWFjWC9t5WdL6kEV2K+RNInmuzaHVLjGWC3ROP7Ei0
         Xcb0aUyVn0SpnxTR8lvqaiKbErtBAXl2Lx7m0NeSlq6Kkb0wv53M6jolMVTrl69kJkIK
         xzAhtWmE3fulheS4XYLiruFaoyVjxFu+nYDp/x893LeXpd66C7TFpKt+KF+vh6GPwjGQ
         VTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717502629; x=1718107429;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C4nlrs5Q5b1jrnGdcQAM4D0fQRXIDjBPjqNQMqZMjmY=;
        b=ITpnUe1yX/IP16aPfBo2IWly9cymz67il37iZ5G/+TN3ui1EKs0K83Mrxy3QFeKNqE
         ew/YKiCKuZtR6bKSl9lEDsHhiEs8XBC0sfpjaycGsHDgabKyPQPkQfZWmmn9J09VPu47
         64CGcZaEK+33NTD+PPhEJYY3k5dM945Ww8jkuH8EUm/eukcvGaz0ZoEWWh+L/vqXfsK0
         EBe2AKrLeI+K3+XEuyn9317S2QV/f+kF7NZxWt11LXsAJBsCO/cUF2MYETM6revZLH0P
         Zhu0bV5Iu96IcwTyT08u5d3L008A2gJIJcNwcHdMtf/0krWqNGgLi7hJ7P5j78GWrJvD
         gN0A==
X-Forwarded-Encrypted: i=1; AJvYcCWIICN/GKcxyYKGIMeEcsjQZ3Orp+YhX5u69N/TpXkHphyLrRRbPEQ6jHzh5zPWl6N6ZX/cBHo/zarBka2eO56VEC9Kt7cgGy+E5Jt6
X-Gm-Message-State: AOJu0YxArneGHKZRSfoYZChYSHc18CJ57P9wCwSDan4ppV3tG2fbO8FS
	XbhAZfRspqhLH/6lQ8PZGtcjVLnG52IisHfuJ/+ujxMu7xz7sTLwZlEqWouFZGeW4W2ug3ZJ8fd
	upRX31ed+2E8M4U9NyAceQtf1pAQ=
X-Google-Smtp-Source: AGHT+IE/QK095tMqeR7Avx3enQ7Z5Hcs2NL5seKcPKRkFbHhUpQlCH9zQn3vuOJNjrF8fHF1xmIDsEN9dj00DV7A8eI=
X-Received: by 2002:a17:906:cb8c:b0:a67:f689:b695 with SMTP id
 a640c23a62f3a-a695429a195mr192822566b.16.1717502629119; Tue, 04 Jun 2024
 05:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601025536.25682-1-rgbi3307@naver.com> <ntycfywrhmt2beba7pgyxmahwhncufgnpjxjobl33f2tyrhzpb@cckdgisyqlra>
 <CAHOvCC6vZQkotPCvOafGxXWb5GygMSUiYUaYZu3RwFA9cCY2nw@mail.gmail.com> <57xfda6fbz6m4sig4kdyi5jinibcqycobwrpaih45cykfqyr5a@fstc2xjyw2x5>
In-Reply-To: <57xfda6fbz6m4sig4kdyi5jinibcqycobwrpaih45cykfqyr5a@fstc2xjyw2x5>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Tue, 4 Jun 2024 21:03:36 +0900
Message-ID: <CAHOvCC7AFYg1UEQNcgNSAF-bAqeoYjBB2gTcHWHnx_0GQv1WZw@mail.gmail.com>
Subject: Re: [PATCH] maple_tree: add mas_node_count() before going to
 slow_path in mas_wr_modify()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, JaeJoon Jung <rgbi3307@gmail.com>, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello, Liam.
As you pointed out, I did enough testing in the userspace and in
previous versions of the kernel, but I was surprised that a syntax
error occurred in making newest patch because of my careless mistake.
I will be careful not to make this mistake again.
And I am going to study the low memory situation in kernel space in more detail.
Thank you very much for your detailed answer and explanation.

Best regards,
JaeJoon Jung

On Mon, 3 Jun 2024 at 21:29, Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
>
> * JaeJoon Jung <rgbi3307@gmail.com> [240602 05:06]:
> > Hello, Liam.
> > Thank you very much for the detailed answer and explanation.
> >
> > I tested this patch in userspace.
> > In user space, this phenomenon always occurs when kmem_cache_alloc()
> > is executed to allocate a new node.
>
> This is expected in the userspace test program.  We test the error path
> most frequently, with only a bypass for those who wish to test an
> initial success - such as preallocations.  I was concerned about the
> testing since your first patch had a syntax error with a correction
> quickly after.  It is good news that you were able to find and use the
> maple tree testing framework, though.
>
> > I will try to test it in more detail in kernel space.
>
> If you test in kernel space, you will have to hit a low memory scenario
> to see a difference.  stress-ng would probably help.
>
> > I will also refer to the notes from the email list you shared
> > and send results once a more clear analysis has been made.
>
> I don't think you need to continue with this work as you will find that
> the low memory situation is going to be rare and in a very slow path
> already.
>
> Thanks,
> Liam

