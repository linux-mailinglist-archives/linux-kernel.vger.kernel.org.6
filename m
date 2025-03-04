Return-Path: <linux-kernel+bounces-545414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52386A4ED44
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8184D8A03E8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C10259CA0;
	Tue,  4 Mar 2025 19:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QF02SaKV"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E39224EA9B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741115060; cv=none; b=ffIxZxOUcvGN3NvCokkBUpkyZS5M7nx3YHtpWtYACtRYPXMNdWueMHeC2VYpl/ZlyoPa/mMOkbIjS1Vgm4AyFzvcdh7rXpMNjVW96a19p01gSj0BFUjurkBzv0RdL+UDxgwFILS12J/xuWal40hle4u0zXHBTY6DPyTYz9+ew24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741115060; c=relaxed/simple;
	bh=AxRo0zwXpsaIo65pvoetfqMIqPPXFYbyNGJ0gjZ0tk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UVKLpoi/k5o34BuXyMrZM4A9yKYiB07c+6bIxWdmJ5Xp2UOoZRPYrDibC3EJfVS1O/9rcbfMOF8Vj1eLKKQr7h8irlc2qezquUeyfPRHYGsn/Klnw5w7kTy6O3guHO/96tOstZEiwMR3LJiPK8RkZMVGAw08i+9v1h09bmQX3Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QF02SaKV; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac202264f9cso117170766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 11:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741115056; x=1741719856; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dkh2pb5EhGcPf5n6D2I0IyHjDxbdm1W1H8kQF4e+QHw=;
        b=QF02SaKVAE0aUO5tw6dwm6MQkVtCNXucNvH1iAWeDCWY1fCSYJnLloV/e21/8SCPWO
         dE9tcFGgcPvAqbFxZdaSkOdf5O46I6UHWBgJktsUaFUKgpBNn/4Ziv0h1L0m5R4a4w7s
         qZ3VW1g5E8MZCPjghfHrQslg0EAJh3hK4ZIso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741115056; x=1741719856;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dkh2pb5EhGcPf5n6D2I0IyHjDxbdm1W1H8kQF4e+QHw=;
        b=mmqMP8/DVN6tLGyRRXCGve6scV9rGwK+ksIJpvPNhN3e4EVYWpvb6+WLs8uHAS0nYr
         RlnrFcj350rziLYExCnnXXa2S16cUNAsdGrXHM35/AR0TuzdlO9+aBQg3l2QGfWbaOKB
         zwb2sxecuD43WFoN7RLyfk3GezACzd6yigQGa16btr4uTw5BNyrQ98JWetFC+B+ZzeRI
         EWFU/2fLeP4zGMBAfU1QA5LPErtT6rcf68ExjLmvHDVTwGQrictShSLAsrya+RlwoNlZ
         NVN7UPnSHJWpdyx3iza5yf175DR60Q6HRIZANTe3bAaxQ98SZNsKgB+DVmuEBy5DwhiS
         sa3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDKDbL4clUm7nw5qDfmwjqvwk1OTRh+DCylLbwi2hMfa6x3WUHhHB/BTwTlP4IfHFrLk3QrUiWUqizark=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1GuxXvJSRP4Lk2kRCZP2MAbmNJYHnIyQ6M3ndf2wUotbuRGSj
	nzqyQyDMumsw+bHfzXVfpBE4TX2w/se6n0K1rEM5t3hEs5pUPdnJ6w2KL7aOq0oZZTEt3BwnShE
	tdk1uBQ==
X-Gm-Gg: ASbGncuVVnaM5UAUky1W1Gm4Im2LSzUpsOHzp8DzD3ITat+mB7ZHrQih2AMErmg0zCG
	trK7R7TOYKdCa9GwbHg5doCriXflWV00vlm0XSpfXo4E7ioBr6p1BbSC9bsKVSyIkv6EcG8AuSK
	aIBdc1sgHsOb9krSZFh/QXajj13GjTJS3kHTI7PumcyQKy83SW6n4Ik/DYLRywTC0VJLE3C0KA8
	uaKpa3TVmcCplPeVX3B+VWBeIiBntOvr8cyYmHzyknPYyB8JOQeIbC2EKXYtrNRWIMNncBVPjiY
	Mt7MrBcn/gTpzBN+2tiL9Ye/FvS6I0wFsJ58LDiaz3qtd6xRYEv9MGafdto4ZlcQsGxYMvuVvp5
	ezqcI53dymfGHMfAKtA8=
X-Google-Smtp-Source: AGHT+IHLpOX8i3tLkVdLFwJFZ5VXPVlq0yO1/vs8VQaNZip/Tw0VOZlC+UuKvf+J/T9+KejVBr9MwA==
X-Received: by 2002:a17:907:7da4:b0:abe:fd0c:68a8 with SMTP id a640c23a62f3a-ac20e1dd1a8mr32756166b.52.1741115056367;
        Tue, 04 Mar 2025 11:04:16 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf744820c3sm429833666b.31.2025.03.04.11.04.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 11:04:13 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abf57138cfaso638085866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 11:04:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUe2jogr2FBrMvbgOHSKFKH5zYDoETkwoxP0iAi+E1F/lmSA+cv8gyB1QAq26IoaIRxfF4IwqvmWTO4ckg=@vger.kernel.org
X-Received: by 2002:a17:907:970c:b0:abc:b8c:7b2d with SMTP id
 a640c23a62f3a-ac20dc6f379mr42747466b.32.1741115053374; Tue, 04 Mar 2025
 11:04:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiA-7pdaQm2nV0iv-fihyhWX-=KjZwQTHNKoDqid46F0w@mail.gmail.com>
 <20250304135138.1278-1-kprateek.nayak@amd.com>
In-Reply-To: <20250304135138.1278-1-kprateek.nayak@amd.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Mar 2025 09:03:57 -1000
X-Gmail-Original-Message-ID: <CAHk-=whfrgndT5Y8PJtHtFwhuef2eCEr46NUdsMD9MVEom_HXw@mail.gmail.com>
X-Gm-Features: AQ5f1JoQsXqnCtGHgj_JQVYfx3eeBRZjtvg4HR-JParHdoIQOMiLW8mY8t0w6ig
Message-ID: <CAHk-=whfrgndT5Y8PJtHtFwhuef2eCEr46NUdsMD9MVEom_HXw@mail.gmail.com>
Subject: Re: [PATCH] fs/pipe: Read pipe->{head,tail} atomically outside pipe->mutex
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Alexey Gladkov <legion@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Mateusz Guzik <mjguzik@gmail.com>, Manfred Spraul <manfred@colorfullife.com>, 
	David Howells <dhowells@redhat.com>, WangYuli <wangyuli@uniontech.com>, 
	Hillf Danton <hdanton@sina.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Neeraj.Upadhyay@amd.com, 
	Ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Mar 2025 at 03:52, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
> pipe_readable(), pipe_writable(), and pipe_poll() can read "pipe->head"
> and "pipe->tail" outside of "pipe->mutex" critical section.  [...]

Thanks, applied.

                Linus

