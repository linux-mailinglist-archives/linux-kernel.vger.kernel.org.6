Return-Path: <linux-kernel+bounces-313443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D897596A57F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B1D287431
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E6D18EFF0;
	Tue,  3 Sep 2024 17:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QchsLL4F"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F04818DF6F
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 17:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725384924; cv=none; b=IvkCCEPumswijNUqmSInoW+ps/FyTZ0Fy+1y8V6H/gDGo9UTLzsgMfVpv8DfbZ2bdgh0p0erjTjSN1wy5TArSorzapRO58RFnRsEUK9vk4dEohElfw7P4p1UthtSc8EpVojf8wpMxOQYWUlzPVYVyCWue/3VL4ogDoOierxc3oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725384924; c=relaxed/simple;
	bh=j0CW8rhLDFUaQ71X8gGMvzqTFZUTuOYdHKvSZuUSgKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QhOyhP6zNvPXSAZdBiItmpNDlNAjATZmBfb5dIG4PtOS2hqKGVRo/XrSn28V1FPJwkIYZb4UbIcgIZ3uHlz2srRzpPTmDYOGgLcYbiYCCwiAiMTUO3E5Rz7S5Riwa2ypPKFy0TWNck0p/2eI5hvLOkv+wBet7setSy3inxyKAFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QchsLL4F; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5becd359800so5816079a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 10:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725384921; x=1725989721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0CW8rhLDFUaQ71X8gGMvzqTFZUTuOYdHKvSZuUSgKg=;
        b=QchsLL4FDmA02tiTsPwT8k2lr61IbSTVo2bgialds/Z9VW0iUfAe8gjutOMbM0n80l
         OUPTDf6Kx7bzMsmSk2TAYyQAEcapt96H4+wMeIU3jrD8a6U+VvnEHiWo5tFH1Mz5BBue
         AG1wZ+1lcrPzgWtK/uHgE2+Z0LKcl5nrbdYi4Kz2RJkVlpME0/wTpyVuPQWeASFqyzgm
         c/2OCCqpuxUXM4zYCgTla8165sTvYcxrUxA+a8QxxiIm/6Zp3zneTsHql8/pYjL7kGib
         oxfGOSYv5Kt1Dnij76/KsLEWxBxB2tsx0iWfIH2MA+B7nvkyEosYpZa3Q0mYYE11sTFs
         5zQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725384921; x=1725989721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0CW8rhLDFUaQ71X8gGMvzqTFZUTuOYdHKvSZuUSgKg=;
        b=D11i3O57RK30+aHYUgMwLZIygD4HmH+QpfMyRLJfnOtJD6VZ7GiA9E2jaKlfOQCyyz
         0x032G2K2789c2SHhZTRfiVBubOfHvaF5+dL13JhaJJ65JnNNXLpwlaK85piFUZeA+Z/
         ziQ1lAriYBYkiBbNCs2nFGjUto/lD/YkenKTw7JboYNrwAbhYKNFpuyt+qzZXYqp8gWE
         4UbFvr4dEaitWGWM6/wpJGOkPRHd6diWOqhOA9wTwm9bbnzgLM+qrB23+GUmf5ISuZ/1
         yAerZUBNvuek+M78Nx0UB965IhBGC3x1g/m0WxBj8J4BDqMdTPAERc8S8oIYihZjOA8M
         Xptg==
X-Forwarded-Encrypted: i=1; AJvYcCUMZx3U06QhcWQsEZ1wg4/aquwk6bmrxGnm6Sim6y7+BHaPO1BMbSYUlb7BtzytpQdPtlJzfeWgWMYz9zI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQnz+3FpJLQ2jdHTQEfJAItHJJ1ZKzGx9ShDMMW5IMU2+K0dHG
	7TiEXUB15tw2g9S3Sg2w+/zFkXotN0yGUggw+uK+JMRlEynOiu83e+SnGQM3DDPpzyD19oWqp6z
	xsBpqubClx2tVCkdGAo0gvyQUuLc=
X-Google-Smtp-Source: AGHT+IGu5gblqbaozzhufThg/mHSRVx/NXnG34ZnNs6Ee6bJLangyPU8DmwziVvYVnfPWEKpUV/Il8jyWlPB3vFdtmI=
X-Received: by 2002:a05:6402:26d2:b0:5c2:1298:35ee with SMTP id
 4fb4d7f45d1cf-5c243724727mr7664368a12.2.1725384920570; Tue, 03 Sep 2024
 10:35:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806022143.3924396-1-alexs@kernel.org> <20240806022311.3924442-1-alexs@kernel.org>
 <20240806123213.2a747a8321bdf452b3307fa9@linux-foundation.org>
 <CAJD7tkakcaLVWi0viUqaW0K81VoCuGmkCHN4KQXp5+SSJLMB9g@mail.gmail.com>
 <20240807051754.GA428000@google.com> <ZrQ9lrZKWdPR7Zfu@casper.infradead.org>
 <20240814060354.GC8686@google.com> <66ce5eed.170a0220.387c4d.276d@mx.google.com>
 <20240903032003.GB9738@google.com>
In-Reply-To: <20240903032003.GB9738@google.com>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Tue, 3 Sep 2024 10:35:09 -0700
Message-ID: <CAOzc2pwzEVNDoXqXmG-Y+doBO=K9NY7=M5NGUJmohfjHcM5hyg@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] mm/zsmalloc: add zpdesc memory descriptor for zswap.zpool
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Matthew Wilcox <willy@infradead.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, alexs@kernel.org, 
	Vitaly Wool <vitaly.wool@konsulko.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, minchan@kernel.org, 
	david@redhat.com, 42.hyeyoo@gmail.com, nphamcs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 8:20=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/08/27 16:19), Vishal Moola wrote:
> >
> > Or should we aim to leave zsmalloc as it is currently implemented?
> >
>
> Is this really an option?

Yup. That would be similar to your initial suggestion: zpdescs would be a
wrapper around struct page and we "chain zpdesc-s together to form a zspage=
".

Although, we may as well aim for an improved implementation of zsmalloc (if=
 at
all possible) since implementing the zpdesc wrapper requires us to modify a
good chunk of code anyways. That way zsmalloc gets direct wins for its user=
s
on top of shrinking struct page as Matthew described before.

I believe you would be a better judge of whether or not any improvements
are feasible (and worth the effort).

