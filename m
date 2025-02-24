Return-Path: <linux-kernel+bounces-529372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33E3A423CC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2302816303A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6B4194A75;
	Mon, 24 Feb 2025 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="U3Q9Visx"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D0A13F43A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407992; cv=none; b=p41oD0SozzpkuSPZ4grS2qgCB3Pu01VICSiwmfNeEckmcZbpYRWCJo7taY8jRmyjgCnXTKCcSq4Ujbzuw1GHET1jsIPLjTfwVBBFVehDVUeutja7bhDiymQ9aIz1j3nV6XJeCWzItl/mCfEK7CDXG2sCNEvq+i/6eP9dYeX2A3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407992; c=relaxed/simple;
	bh=94wPLtJyrUjvI0EwVuVFieJSPjMtnqdOvnmEEzQI6AY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LBlgjZ2xBuYNdCSPqssVFFnG3R96tAr4NKOJgcCmYovOkJHLQq17PxuqZRYswwjCbWbowX6d9mtBacyWitU+SO9GRzarXD598gcxDDcDiwydUbrslhlPyksAT91xfAmmdvueR/AMQ+JxlfoIfVsT0FYCoYj6cO8ywc4zbJH1RK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=U3Q9Visx; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4721f53e6ecso40060981cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 06:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1740407989; x=1741012789; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JC3QeVYDt8u+GiWrpVVB4VRltEGag4G5+mxmLi1Yh1E=;
        b=U3Q9VisxsMlAMyqVuKqgyM5HxOpND3jpdjo/uZj7k4u5Jz+AKYRFJjPF1zzmsuT6RK
         OcuXeJgQg53cssk2aaTXjiVyJdRnwTH6TNmOsusJt+9vRqPQD6rKkx5vhJLWfuX1ZuTq
         lDuzxqC+jpViy1PZwyF6qSeYYJfd0vOua8EwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740407989; x=1741012789;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JC3QeVYDt8u+GiWrpVVB4VRltEGag4G5+mxmLi1Yh1E=;
        b=Dzam5Z4Yx7aY4HMyWl7MhLd4BRLavcyxM6w/hGiNLCIqPgFsMMhihtBlXRzucXm952
         puZt84Ttcccq1B7dAargXdTBwcJksmZAah0EuQx8M4EnafSSatzwHA18XvVqE0yUDikr
         4+WS1geEanLkYQ9QXUwyX85jfDqCgsGa7Lg33D8al6eZCBZ/RsGLmqmRQ3mV3qUHjZpi
         RfHjwEzrLWfiERxl710C0Q3BbM3Tner5rkxIZiOOUN/J0HIqlJUMcreq7a6YrTIKxxqp
         ewXR8UJLDGKFVfZdF1iciTSW9BGSfj2XrnFbQ5UWuflhtEMgI/TPxnC6zRZY+Xi0yPTL
         8Exw==
X-Forwarded-Encrypted: i=1; AJvYcCWwE/AGDU0Af3fvKlPD0O5VKjX1+oJaL4CZuxaeyGG2q2SG7L1UhLnsdmyET3QFC/Od0F/Kx1/V2CEHIuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqq0dPx29AXjp8qEBEoXeiz3hE4rUonnb2oFOJvMxW1mmT6A3A
	CGukS6/34jJv9e0LJ/mcdL3ZGfpHQDHsmFKzv+BEQdfAMNo+TrXN1dWlyo2umTAAKjo2fWLvs/P
	nNnKzIrbaMeuVt7SNxYbT2R450tXISYa9hYU90A==
X-Gm-Gg: ASbGnctIT4ndcv4VxXDklEif0SP+TkG+rI0vXcd9odhSEfGQxL4/GKj3nMFJexvabWN
	q+bLoN/fABabbVCg90A9+mHT1HcmXCzMTPAstFSo6QuOM/yK42WsUl8b70XZEv3GhdbNqnRC4Lh
	Pz4sPFIiHN
X-Google-Smtp-Source: AGHT+IHZpU5mAGW93Jd5L4tacEoM3CWPtQbRj5Xt6W3Nz6pXQ1Xx1AgYfWsJilDWbc/tX30TC8rhJxnhdq0BVyB2En8=
X-Received: by 2002:ac8:7fd6:0:b0:472:bbb:1bab with SMTP id
 d75a77b69052e-4722485b110mr134700401cf.24.1740407989180; Mon, 24 Feb 2025
 06:39:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250130101607.21756-1-luis@igalia.com> <CAJfpegsrGO25sJe1GQBVe=Ea5jhkpr7WjpQOHKxkL=gJTk+y8g@mail.gmail.com>
 <87tt8j4dqe.fsf@igalia.com>
In-Reply-To: <87tt8j4dqe.fsf@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 24 Feb 2025 15:39:38 +0100
X-Gm-Features: AWEUYZlaJmnQNd54xQ10tByWjlNqJJ8043f6HbvteQ8zLViYYirluMOYpoF5EZQ
Message-ID: <CAJfpeguQTZ8KcdffKvY8kknZVnBH6h3Tz1GSESwBjXSz_25TLw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] fuse: fix race in fuse_notify_store()
To: Luis Henriques <luis@igalia.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bernd Schubert <bernd@bsbernd.com>, Teng Qin <tqin@jumptrading.com>, 
	Matt Harvey <mharvey@jumptrading.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 15:30, Luis Henriques <luis@igalia.com> wrote:
>
> On Mon, Feb 24 2025, Miklos Szeredi wrote:
>
> > On Thu, 30 Jan 2025 at 11:16, Luis Henriques <luis@igalia.com> wrote:
> >>
> >> Userspace filesystems can push data for a specific inode without it being
> >> explicitly requested.  This can be accomplished by using NOTIFY_STORE.
> >> However, this may race against another process performing different
> >> operations on the same inode.
> >>
> >> If, for example, there is a process reading from it, it may happen that it
> >> will block waiting for data to be available (locking the folio), while the
> >> FUSE server will also block trying to lock the same folio to update it with
> >> the inode data.
> >>
> >> The easiest solution, as suggested by Miklos, is to allow the userspace
> >> filesystem to skip locked folios.
> >
> > Not sure.
> >
> > The easiest solution is to make the server perform the two operations
> > independently.  I.e. never trigger a notification from a request.
> >
> > This is true of other notifications, e.g. doing FUSE_NOTIFY_DELETE
> > during e.g. FUSE_RMDIR will deadlock on i_mutex.
>
> Hmmm... OK, the NOTIFY_DELETE and NOTIFY_INVAL_ENTRY deadlocks are
> documented (in libfuse, at least).  So, maybe this one could be added to
> the list of notifications that could deadlock.  However, IMHO, it would be
> great if this could be fixed instead.
>
> > Or am I misunderstanding the problem?
>
> I believe the initial report[1] actually adds a specific use-case where
> the deadlock can happen when the server performs the two operations
> independently.  For example:
>
>   - An application reads 4K of data at offset 0
>   - The server gets a read request.  It performs the read, and gets more
>     data than the data requested (say 4M)
>   - It caches this data in userspace and replies to VFS with 4K of data
>   - The server does a notify_store with the reminder data
>   - In the meantime the userspace application reads more 4K at offset 4K
>
> The last 2 operations can race and the server may deadlock if the
> application already has locked the page where data will be read into.

I don't see the deadlock.  If the race was won by the read, then it
will proceed with FUSE_READ and fetch the data from the server.  When
this is finished,  NOTIFY_STORE will overwrite the page with the same
data.

Thanks,
Miklos

