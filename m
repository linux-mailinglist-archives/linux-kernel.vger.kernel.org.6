Return-Path: <linux-kernel+bounces-512024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE95A332DC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 23:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95521162F8C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 22:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0745E25B67C;
	Wed, 12 Feb 2025 22:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LUNIucAr"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80AD1FBC9C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 22:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739400320; cv=none; b=SCnWKwGpdc3fqTu4bmTnLlvYznhgLcRUT0/L793yNxbfRrwFytM5759JuZ8AY5y91cYpBPYGb34DaMxiA4nCEE9bQ4J/75YoIg7ubRFT45qjghyqT5htPqoBg8XRBargJejN37olWLbVw9/YsWSNf5pJDLMcLVTPTMbFuyabxKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739400320; c=relaxed/simple;
	bh=TrYhj9YtDhjs2+zWIm8UW+a8Ijj+74m1trvWbyQOCSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiIKdE7fS3jCLOJ2MWhvEykpXRm6ugzu+E+fgfQqouZaqSTnrqvG2LCIn9wcqkPDKutUv3hY8K2l+f3rfnb0TlwQ+RrdFV3qL4pH2c1KZH8uAQ2MbqOP7kTPzCh5aJ+3Rsd1B8QkBJYo2v6JIyjRL5c2fPBG8ZRuhvgvhB60zHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LUNIucAr; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f44e7eae4so3065385ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 14:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739400317; x=1740005117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxmsI4n3mNC29jNhrwky8mt9Y2e3VkJ4dixbH6NADTc=;
        b=LUNIucArorYsj2QN+oCyqiEc2Od7dBSV+ZjPnevnjEjxbZhfKGMumO2ZzVzkBwu/Ey
         2lInL35zv8oPciwRZn/7czzNrsBg+nlUyMwCvc8zzgRTmklGBobSmcg3iOYgZdCCf16p
         1F3mY7XrLro9P7leQ6T6w4g4vxBH8hqzj8j+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739400317; x=1740005117;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxmsI4n3mNC29jNhrwky8mt9Y2e3VkJ4dixbH6NADTc=;
        b=TJLGFP/E4i9FxWqUReRXkr1KngGdc+kicIJtHkLNLgpPOLyDz6DtHvCNk5Z9xdPFp5
         RhNXNgty5bK08dJCQLUQurJExCA4u1jkyGOsPbIN0Rq3WqJN1PC4oACJbexmucVJs6Ck
         MzoSYsOzm+zqsJ3h9kXgLciXWhgJnMiC2cGSzFOm5oyBviWE8lUdP4LsKTMcB/Xh2/6N
         SVsahTK+BCO2KtxYNjUq/reyiejJ3jC1MSjo87vb+bvauRncbl0HD5mf1E6xrPe1p5r1
         GSNsAkGv01hqoJxzT9RZFcEBlhlhZd33Ei+f1Yzp7Lry1iGlqCoADGCIY4n2zk4JsS9K
         bG/g==
X-Forwarded-Encrypted: i=1; AJvYcCWXPMTn2qJNW0Hh1xliThoBQqk3dbwkDao9E+DHVLrPAd0UIRmXhm9wAs9TVhv3zz9UOptqialF1cwd2Rc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFzOobT1S7YjEWcojszIG11IBEwOjNsrv3gAMk/Oy+KdsuxWfi
	VQwdYX2k2K7hqFEl+jp3Gh4EbDF66OWKvTSbHKS9mGWaSd4CakxoNNuzpC7hgWo=
X-Gm-Gg: ASbGncvkcvP93rClCTM4J61pHsCPaSmRk4nfBedKbezVwiKDlms+S8+kPjAxXVUUag1
	A1nec2K9UeZPbQ58Ic44ESjpxQhv091mHXW9vJBxjiT58OLtyGNEHm58GUYIrFpHrHcKy8iG85b
	nm0G3OT4SwB2/u1NWce/i4JheOVOaEYJnadcy2Eospa4Gx7Jj9irlkRI+UX8PLkfbVjdwtu7UTS
	vIJJ7xM5oleNQHBqT6ol+O/FJLVXG/nDM5sxVkyLZ6g5Z3fPNCCbbeUr6tqGNRGQmDudAdqId8y
	NHHogEKlLVVWkAUQKkDcSuSOct7itNZbrA7ly2W8bq86KVG1k8muihyPTA==
X-Google-Smtp-Source: AGHT+IFUBiyhDYvXIFj3i8/1IXRfWTJGO1CJwO79pTr/N2oVci7/x1idO4rC9J9iW9gid4RM7SPniA==
X-Received: by 2002:a17:902:f682:b0:220:cab1:810e with SMTP id d9443c01a7336-220cab18355mr25527595ad.6.1739400316978;
        Wed, 12 Feb 2025 14:45:16 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55858d6sm541515ad.223.2025.02.12.14.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 14:45:16 -0800 (PST)
Date: Wed, 12 Feb 2025 14:45:12 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stefano Jordhani <sjordhani@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:IO_URING" <io-uring@vger.kernel.org>,
	"open list:XDP SOCKETS (AF_XDP)" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next] net: use napi_id_valid helper
Message-ID: <Z60keJDOL_50cGbY@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stefano Jordhani <sjordhani@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:IO_URING" <io-uring@vger.kernel.org>,
	"open list:XDP SOCKETS (AF_XDP)" <bpf@vger.kernel.org>
References: <CAEEYqun=uM-VuWZJ5puHnyp7CY06fr5kOU3hYwnOG+AydhhmNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEEYqun=uM-VuWZJ5puHnyp7CY06fr5kOU3hYwnOG+AydhhmNA@mail.gmail.com>

On Wed, Feb 12, 2025 at 04:15:05PM -0500, Stefano Jordhani wrote:
> In commit 6597e8d35851 ("netdev-genl: Elide napi_id when not present"),
> napi_id_valid function was added. Use the helper to refactor open-coded
> checks in the source.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Stefano Jordhani <sjordhani@gmail.com>
> ---
>  fs/eventpoll.c            | 8 ++++----
>  include/net/busy_poll.h   | 4 ++--
>  io_uring/napi.c           | 4 ++--
>  net/core/dev.c            | 6 +++---
>  net/core/netdev-genl.c    | 2 +-
>  net/core/page_pool_user.c | 2 +-
>  net/core/sock.c           | 2 +-
>  net/xdp/xsk.c             | 2 +-
>  8 files changed, 15 insertions(+), 15 deletions(-)

Thanks for the cleanup. As far as I can tell, LGTM.

Reviewed-by: Joe Damato <jdamato@fastly.com>

