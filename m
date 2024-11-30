Return-Path: <linux-kernel+bounces-426463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A20979DF34D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 22:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA30281227
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 21:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705611AAE00;
	Sat, 30 Nov 2024 21:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZhUzwRpO"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F6B132103
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 21:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733002468; cv=none; b=ZHmqG2mjVn9Ou8CvY/vXJXaS9+9M+ji/o/d0PPsKBRtSJWhaagHSDJOI5WZg+lnqfcjEOPuQztjdpPE1y/5DPc5EbMt4/htsqidXfE3Jy0+20zm/KOeNd9tUUdcu0oFCxS3ENlAXmG/CFNJQS3NQ3MvIu9TBfdGLMyXHEw1t7eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733002468; c=relaxed/simple;
	bh=9dW6bWsFGFk529Smtr9Gpb2nVhhhhNJjaw2Mew5NbpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iuxvq0BpabpgdiWLnQg/D4uBq9PlzS6SuxCvOkFJZoIIfWm0gMEzWREO999etoc4WD+Cf2Tia0QLGNcx7b0WfVDDPbXGKPjS26PHHah00S5wSK9SbxS++1PHiS30df2AXickwKBrClDdVJ+Is/pNHdLGw7jrXpY2g0f0MNk7Z68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZhUzwRpO; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d0ca0f67b6so1241846a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 13:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733002465; x=1733607265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RNyysF0czXG+9VpzTWGbzEwJuxUcYyjjRR4QdXrg+wU=;
        b=ZhUzwRpOSGdelDJvL6ta2G8xuA1qBd/9/0OkfN6hTTiK2lz7pO8GOc4e9y5QYoK6i0
         pJOe9y8m682QBLiJi4lRFMTzrC/8Vns0YfCqLTQsOYs3SusOBo3V9weP6sHgPbBFAO0y
         FSFKN59N460NzNNT8bRvSHiDoKehAlFyL3AtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733002465; x=1733607265;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RNyysF0czXG+9VpzTWGbzEwJuxUcYyjjRR4QdXrg+wU=;
        b=pe7/eu1xWZZku4eUzqUfF2CH76IAOLNgJwba8u5PXw7SL4j19Z18DmAlt3vQvryvL9
         SR4409IC7MaIU+zAAGmHdhOMeVRkboZOfXpF26XBY7d4JVC+hoPPbhcY+D0Ssat2qIlG
         WppwHW/GWGVjKyVd3ktkkHc20Lr1jJLBCf0TIV4qIkdfsUD6wgX929EcleBCqZkfhGXf
         7+NTb2QgXlloABfkTAAOT8nZcyhiVRWrQOlySqHACJ5FitZLrIB87ktDyvAUMgWf1anP
         vOoKzDL4qYwjeLkcLzqPYpfPwRlSnZ6upJTq41Hkf4jabI/Ygv4Tl3vEtoy4SfrWBYzg
         jhnw==
X-Forwarded-Encrypted: i=1; AJvYcCUQ2927JfScDorUr0gLrgub9HC3gIQZRrrlLavK8+/Et+UhWOMu+43Ku217Mtw9FYJCLXhIDFTpgiPt3pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlMpqjjo1HyCKxQxqM7CNtodYkrLT0/4LefvCwqeZDKaG9ZeEq
	PBr7nWVFvKYiGiqgjiF6V7mhmXPqvzvkDk7oOMfoVLsV/0MJ09I/2PXg0Vh7NFuDT6AU4IJJQ9c
	9JKwNOw==
X-Gm-Gg: ASbGnctWfDt8GfVUrI7N7rpslE+5KUle5ojnkQ4/X+leQn8H52V1n0E9CV2M/XbAZ9A
	H7Xs2KqGmsAiHroKdp06YHNjc44dKieliDcbJpb3/BGY6sQ6s4FwOARUekAJTdFWhz4/chov38C
	n7KVT4ioZchnpgPtKHzRRV7jHZzumOul3ocCOtx95VyXoRg/sF2xyJzX1x1rEOKOBzxjvvfhOzo
	ApWLjUbt2pGlf3rNkm2mcZ4FUfQoBhZAJ6emygDgA/ysh9z03Xq0DpL/sVcvnLTCcpoHZre/Q7K
	+OYiweaWEMtp0Jyg3313i8w1
X-Google-Smtp-Source: AGHT+IF12lwaRm27PLKag31F5mXfRybgBlkWxOxZaPcBWHuIVMf9xlFr9oF5RaIih9EjgdGZLokvVw==
X-Received: by 2002:a05:6402:524d:b0:5d0:c67e:e263 with SMTP id 4fb4d7f45d1cf-5d0c67ee4a2mr6773398a12.8.1733002465096;
        Sat, 30 Nov 2024 13:34:25 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0c757c8d4sm1274964a12.46.2024.11.30.13.34.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 13:34:24 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5ceca0ec4e7so3711570a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 13:34:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUfYDau6OjWBgcOkAQJsxP7WsrihRNulSVNAr5y7V53dWUvFfCAll4J2WMl+jxXkpobIvozhgHE+L8bZww=@vger.kernel.org
X-Received: by 2002:a17:907:ca20:b0:aa5:3b5c:f640 with SMTP id
 a640c23a62f3a-aa58108aa80mr1263837466b.54.1733002462844; Sat, 30 Nov 2024
 13:34:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130045437.work.390-kees@kernel.org> <ej5vp7iifyy4s2faxsh72dytcfjmpktembvgw6n65sucyf77ze@gmbn2bjvdoau>
In-Reply-To: <ej5vp7iifyy4s2faxsh72dytcfjmpktembvgw6n65sucyf77ze@gmbn2bjvdoau>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 30 Nov 2024 13:34:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgAVEbjFzhNpqvgTxKymCi6uE5UO7BzyB6ch7pDiUz+Yg@mail.gmail.com>
Message-ID: <CAHk-=wgAVEbjFzhNpqvgTxKymCi6uE5UO7BzyB6ch7pDiUz+Yg@mail.gmail.com>
Subject: Re: [PATCH] exec: fix up /proc/pid/comm in the execveat(AT_EMPTY_PATH)
 case
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	Tycho Andersen <tandersen@netflix.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Eric Biederman <ebiederm@xmission.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Nov 2024 at 12:28, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> > +             /* The dentry name won't change while we hold the rcu read lock. */
> > +             __set_task_comm(me, smp_load_acquire(&bprm->file->f_path.dentry->d_name.name),
> > +                             true);
>
> This does not sound legit whatsoever as it would indicate all renames
> wait for rcu grace periods to end, which would be prettye weird.

Yes, the "won't change" should be "won't go away from under us".

          Linus

