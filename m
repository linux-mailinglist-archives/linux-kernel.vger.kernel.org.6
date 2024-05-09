Return-Path: <linux-kernel+bounces-174650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF568C1233
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 17:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD77E283455
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 15:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920F415EFA2;
	Thu,  9 May 2024 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RQpbrtA0"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE0013C68C
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715269720; cv=none; b=n3GcE5Ml7/P17B4BUcBbHRiiPdJVC/X1M1SEVPt2S9LluYboeGZNO1pSj8snunqeh66+k9sO4IVASJ9kLALjWH6Fwew+nAyQ4mJ0GzERAdd6q9yoiBZgZZrBCoFQ/b810bk8aX7DdyZiqOrn5PZmUormpkcUvMcTn+YHO8bQ1Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715269720; c=relaxed/simple;
	bh=mA/fCF0Hyf2s0C0NAXcut1RdJ0/A1Vl70kRKZc0yNVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I+TPZFVaogpFWyZ/uY6nSJE7o+xqDA2ZjOHSUOzPGDu1aSjrvGoDJXD5bpGKpNTCn+UAguHB6OZovX1E2JJ2mFwXOqWW79ZYEAbdmHu1fphE+EIjoPWbR1Zx+LhteOZvNnYNfg7vrQtk4bIp/rbedLJ4ZL/iWxwl5yiM8j7Feio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RQpbrtA0; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-573137ba8d7so3958468a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 08:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715269717; x=1715874517; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=38BuvpIpkB3oaxq+zw4VsWBKcS3P81IEjFcYuWVYCpU=;
        b=RQpbrtA0ArSgez7nh7jtI6MECUxUKjBpGDth1PWgzyQnl1IT4dZZIQWfxnrhCvQMMh
         kVKoF+TtkLtJ05WcAbK8Wh2ZU+SpGGzITb7RM84gj/T33NQI8ffaIyadAlWiR3T3ohCC
         qHA88+DOAoOiwGLeGCrpWn5NsYS12GI3J8nxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715269717; x=1715874517;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=38BuvpIpkB3oaxq+zw4VsWBKcS3P81IEjFcYuWVYCpU=;
        b=oHE5lfPHt2zBqg8IMle20EiXE2vbrGM1PAZLlD3QDU1dry4VrYDQso86NT0UKqtOmL
         z0LU+ZiaMImcwqIkwLY9KCdy48iI6OL8Eqng8qEFlN0YH4OFs2JXwpcL0nshEocLl/u5
         ArcpTcFczlip+leGVn+zU2OjGDhDOlLzcigndYS7kpH2z8jyRXTbuX1T2W5FdvwtM42c
         Z9OlU+DZkeFfvJ91vVu01ilNjH/6mO5+Du+nuY4txZPo754qDDOzR3stVm6UdV7jFRVF
         QFYekj2oxEf4nR4KSZV5rmIdCPVJ8bapFGQK6Q8AYRMsNpwITADsMUFX1AtuJGiwb/ge
         n7ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUTUo97aEhlC69VgNxNmTrbvkG1+fhNM0BVMViBDmhuTo5whOv1gIxMP/IVWKCf4ScxecLjnvYRaB07OTvyyDfPKCkFcEibuG+TAlPM
X-Gm-Message-State: AOJu0YyVVgJZFMy29c7gakZUyXjte3oe87CuIw1dmMEtktXJ9YLTob8C
	SwbrwiP8SMhzJIXdPO7tkS7m43cVI8mbjYh+LfD3pASJtkIJ3cUoyp8GgY/H4CZifCWJD0fmFET
	7CWy9pw==
X-Google-Smtp-Source: AGHT+IHjlNPmBtz6rerizzRxTi8e3437FfPjfigDdQaaaGJJb3LRLKHYtXn4uBYgOOlKvHvyxsNmIQ==
X-Received: by 2002:a50:870d:0:b0:572:9503:4f8a with SMTP id 4fb4d7f45d1cf-5734d5c1889mr84422a12.1.1715269717219;
        Thu, 09 May 2024 08:48:37 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bea65e2sm815546a12.19.2024.05.09.08.48.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 08:48:37 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-573137ba8d7so3958439a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 08:48:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXlTTU8h1GUtq3H8AXg4iWknVqY9++Z5fMuRSnkUR8Pq2ODv5Ej8MdiQmdLktVDNxS1obXGfh9wcNonxbk++palWsKsst0Em5DMMwWa
X-Received: by 2002:a17:906:19d0:b0:a59:fb06:5d35 with SMTP id
 a640c23a62f3a-a5a1156665fmr240732966b.8.1715269716628; Thu, 09 May 2024
 08:48:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240504-wohngebiet-restwert-6c3c94fddbdd@brauner>
 <CAHk-=wj_Fu1FkMFrjivQ=MGkwkKXZBuh0f4BEhcZHD5WCvHesw@mail.gmail.com>
 <CAHk-=wj6XL9MGCd_nUzRj6SaKeN0TsyTTZDFpGdW34R+zMZaSg@mail.gmail.com>
 <b1728d20-047c-4e28-8458-bf3206a1c97c@gmail.com> <ZjoKX4nmrRdevyxm@phenom.ffwll.local>
 <CAHk-=wgh5S-7sCCqXBxGcXHZDhe4U8cuaXpVTjtXLej2si2f3g@mail.gmail.com>
 <CAKMK7uGzhAHHkWj0N33NB3OXMFtNHv7=h=P-bdtYkw=Ja9kwHw@mail.gmail.com>
 <CAHk-=whFyOn4vp7+++MTOd1Y3wgVFxRoVdSuPmN1_b6q_Jjkxg@mail.gmail.com>
 <CAHk-=wixO-fmQYgbGic-BQVUd9RQhwGsF4bGk8ufWDKnRS1v_A@mail.gmail.com>
 <CAHk-=wjmC+coFdA_k6_JODD8_bvad=H4pn4yGREqOTm+eMB+rg@mail.gmail.com> <20240509-kutschieren-tacker-c3968b8d3853@brauner>
In-Reply-To: <20240509-kutschieren-tacker-c3968b8d3853@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 May 2024 08:48:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgKdWwdVUvjSNLL-ne9ezQN=BrwN34Kq38_=9yF8c03uA@mail.gmail.com>
Message-ID: <CAHk-=wgKdWwdVUvjSNLL-ne9ezQN=BrwN34Kq38_=9yF8c03uA@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] Re: [PATCH] epoll: try to be a _bit_ better about
 file lifetimes
To: Christian Brauner <brauner@kernel.org>
Cc: Daniel Vetter <daniel@ffwll.ch>, Simon Ser <contact@emersion.fr>, 
	Pekka Paalanen <pekka.paalanen@collabora.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, keescook@chromium.org, axboe@kernel.dk, 
	christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	io-uring@vger.kernel.org, jack@suse.cz, laura@labbott.name, 
	linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	minhquangbui99@gmail.com, sumit.semwal@linaro.org, 
	syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 May 2024 at 04:39, Christian Brauner <brauner@kernel.org> wrote:
>
> Not worth it without someone explaining in detail why imho. First pass
> should be to try and replace kcmp() in scenarios where it's obviously
> not needed or overkill.

Ack.

> I've added a CLASS(fd_raw) in a preliminary patch since we'll need that
> anyway which means that your comparison patch becomes even simpler imho.
> I've also added a selftest patch:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs.misc

LGTM.

Maybe worth adding an explicit test for "open same file, but two
separate opens, F_DUPFD_QUERY returns 0? Just to clarify the "it's not
testing the file on the filesystem for equality, but the file pointer
itself".

             Linus

