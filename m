Return-Path: <linux-kernel+bounces-572913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA3CA6D043
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 18:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 419AA7A5C8A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 17:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3220914A4FF;
	Sun, 23 Mar 2025 17:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxuYs1Gu"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0861278F34;
	Sun, 23 Mar 2025 17:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742751393; cv=none; b=uZXX4xnHpemAnyv627YKO/6oR+2QLcTW13oIv7XZpF/ortZyNQOO6RYu4L2D7VSDmZfl78JIO+Tp4pJsI2GOr3YRie2jWbj4ARt7aRpzw/SPlVi3F4vLIUdI7wTV9BUOi8s6jk7DNM/7OOyIJJrftLPIoYcS5e7w8c+81YXUVUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742751393; c=relaxed/simple;
	bh=tw3/0MDVahV5gYA1D5ZUev1jqNbxH7cuac9JUXXrv2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqUIaZzecFtkaJ6EQn4LCng+dMoh1Gw+KnSaQ7UWI3fW2xoHeV43eIp7PflCyYF/xwLO2OZ1GgKIQL03jwRVwdrSbFoMim4o6BcfI830S5abCZCvuykj4jPiNCs7nSyd0uPeB8QrA19XjBMk5tyVhGYVFDMHt5ML8OV1p+ZosZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxuYs1Gu; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c5ba363f1aso385095085a.0;
        Sun, 23 Mar 2025 10:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742751391; x=1743356191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJmxmLHnI0b74eLfgzEkn0Xb7QzO7kjHFPv4KK92C4k=;
        b=LxuYs1GuVw+9GCI8vWlDAbGUQUZEBz+wkGgaz4Md0262pCRb3BHda9tr/uT/WqVXyV
         UUb+w9lT8vTcWxRxkikeDfca83w/nfD/8ZrPXIR+if+QdDpLNNffi93FQcszphaaXHnk
         afnFQwvFVskbpv72no2G/zT9zN46okVgrASP+CHPM8fiY48lkbiQBx0NRK7KMPrUfEUX
         12vgFYSCJzKiaOO3R14XIicGAhyOw27n8x6ebuUXGisjyUn6l6KRPXQ1sjSTTqSOXEOw
         70YVVB5OsTEwKSoFKmyItj/BXQSmEPh+8yuZvu5RVAw7bgyVhR02m8R4tztypk7EVvvo
         wMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742751391; x=1743356191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJmxmLHnI0b74eLfgzEkn0Xb7QzO7kjHFPv4KK92C4k=;
        b=wLq6M/mMwwYwJyxBt1book28UxWnbZKMo0vJsHaTC92sCMpIGfkvvZ9rzwLPzU4gaX
         BQXosR3Nw8UbaKD+kSkupqsIBY01uXZvCgv5O3D8Mpwpknj5+F39nxE0V8OmmQrNNPno
         q2IJMjQJ5mjdnNJsc0s0h+u+jwS1vk/oryjd+21FUqaiPJgITNg6Rnx4/f9JN/AWqkWg
         fuM91N6kgEzTN3G6F/QbG+0XRbuPbwdieDj8Zi2bQ5WcdXnpTokR2Jf7zQkf73jeyKjg
         mQZXymVOwlD1y3K48JCb3z7iJs335lksU3nrqnm+Vb6AJwBBNreqPZPhCNvqfsFEbXwI
         G0mg==
X-Forwarded-Encrypted: i=1; AJvYcCURzDqhZzqvAkDGMAUNrWJ+ES/q3kobpu1VzG24+FwBBTU4BbtTkybtrfRIu2wjPUMCyyqaNl58+lS8nxs=@vger.kernel.org, AJvYcCW6ewqoUutwL57ukleYiGqLA+l9fmfA2SepYqGrKeBELEgdiL7fpc8fzk+oPi7dwFYZF5aofxupwOSczIBamcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQcx80xx/VesHU+7jn8bEN9o2q//sqMLBfXAdufSbBZ3IWl6K+
	fpveMVtH3lGBFX9U6FEBrphKCbEuRfU/EvaRSug+vCcKHntip6UV
X-Gm-Gg: ASbGnctbuEXQuK8Uim0eOVox5wOflU/92SbqXn3Kxm9dfJw96aNxdwr7YweGmLipwza
	WUcuqtzp2Ix7h9Qp1kGYPzSi/AGPbaGVWwdjBgVZnIC+jfq/CZxoF6V6d5NMCBHN73f5RfMRjJm
	uCHVSB5P4OalX4F8hoLo03gIhplh27keOfsOWqmGzoPreRurOxnPcAR04xPrFDGEcNTioqf47A7
	/Lx+0FNajnfMdRKfazKAkLlJhhTI4nTw526C5g4xDEa4UH5JtKkgNUwwcenF36Qp4saUEUteuty
	C0iJQPhTIyQKnoZuC2Yhrimatp4ApvTYeq4uAS4O0NzfFL8j3kK8TUjzAMe6MPMCrXDdmIA4Irv
	Hk3GKNxR+HU4I8GY+IziO34hkMFH4GqHyi5U=
X-Google-Smtp-Source: AGHT+IFPXx3Q4TX1Xs2Z84TncJkMZsWBNJhJ343KnGGojWAVSXxnbqwjcFG7410Xa+SesHkkJ5NJcg==
X-Received: by 2002:a05:620a:29c5:b0:7c5:9a10:7824 with SMTP id af79cd13be357-7c5ba15d9famr1184377385a.24.1742751390630;
        Sun, 23 Mar 2025 10:36:30 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92cfe65sm384903485a.28.2025.03.23.10.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 10:36:29 -0700 (PDT)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 42AC81200043;
	Sun, 23 Mar 2025 13:36:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Sun, 23 Mar 2025 13:36:29 -0400
X-ME-Sender: <xms:nUbgZ8Hy1gTIxowI2y2C-W_Y0z2hfWYovxZgPJevFIS-YQFT0N77Sw>
    <xme:nUbgZ1XegJ1sibZCAMIvAwQ-Te3mIZohopMiyXckDwexXgF26Rb3LS8Q9-iuoVQjQ
    G-P_BPQzrHTOKKATQ>
X-ME-Received: <xmr:nUbgZ2JgW3uB0mTmllBXEif9LeoiRy2jqL6LVvKosEkkBoh0VXWUDIun>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheejgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefftdeihfeigedtvdeuueffieetvedtgeej
    uefhhffgudfgfeeggfeftdeigeehvdenucffohhmrghinhepghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhunhif
    uhdrtghhrghnsehlihhnuhigrdguvghvpdhrtghpthhtohepohhjvggurgeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorh
    hnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegsvghnnhhordhl
    ohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopegrrdhhihhnuggsohhrgheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:nUbgZ-GBu7karf7bxbSTuXjOrc3z5CeO4meI733rVw8v5mMfWUfUvg>
    <xmx:nUbgZyU3NqHbamDSNkk9sbFzZX97-PHhioyTcJrtgVSsYU2WEvyG8g>
    <xmx:nUbgZxNVo8Yv1hxoYNi0O6FcW81f-526reDkRUSopUsRdjxMLordag>
    <xmx:nUbgZ53cG6zvlV6vCYO4c6xafq44DB0cDqIhLfz_Yi__rs39bGhEZg>
    <xmx:nUbgZ7XJft9LcxmzcTaFm4p0v2uNPgplr_2L0IDjMnTQ2o1NyfkzZjGM>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Mar 2025 13:36:28 -0400 (EDT)
Date: Sun, 23 Mar 2025 10:36:27 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Kunwu Chan <kunwu.chan@linux.dev>, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, tmgross@umich.edu,
	dakr@kernel.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	morbo@google.com, justinstitt@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Kunwu Chan <kunwu.chan@hotmail.com>,
	Grace Deng <Grace.Deng006@gmail.com>
Subject: Re: [PATCH] rust: sync: optimize rust symbol generation for CondVar
Message-ID: <Z-BGm3zBEGazp5gb@Mac.home>
References: <20250317081351.2503049-1-kunwu.chan@linux.dev>
 <Z9f5fehO186xoNAV@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9f5fehO186xoNAV@google.com>

On Mon, Mar 17, 2025 at 10:29:17AM +0000, Alice Ryhl wrote:
> On Mon, Mar 17, 2025 at 04:13:50PM +0800, Kunwu Chan wrote:
> > From: Kunwu Chan <kunwu.chan@hotmail.com>
> > 
> > When build the kernel using the llvm-18.1.3-rust-1.85.0-x86_64
> > with ARCH=arm64, the following symbols are generated:
> > 
> > $nm vmlinux | grep ' _R'.*CondVar | rustfilt
> > ... T <kernel::sync::condvar::CondVar>::notify_all
> > ... T <kernel::sync::condvar::CondVar>::notify_one
> > ... T <kernel::sync::condvar::CondVar>::notify_sync
> > ... T <kernel::sync::condvar::CondVar>::new::{closure#0}::{closure#0}::panic_cold_explicit
> > ... T <kernel::sync::condvar::CondVar>::new::{closure#0}::{closure#0}::panic_cold_explicit
> > ... T <kernel::sync::poll::PollCondVar>::new::{closure#0}::{closure#0}::panic_cold_explicit
> > ... T <kernel::sync::poll::PollCondVar as core::ops::drop::Drop>::drop
> > 
> > These notify* symbols are trivial wrappers around the C functions
> > __wake_up and __wake_up_sync.
> > It doesn't make sense to go through a trivial wrapper for these
> > functions, so mark them inline.
> 
> You don't need to send a new version just for this, but please format
> the paragraphs better in the future. For example:
> 
> The notify* symbols are trivial wrappers around the C functions
> __wake_up and __wake_up_sync. It doesn't make sense to go through a
> trivial wrapper for these functions, so mark them inline.
> 
> > Link: https://github.com/Rust-for-Linux/linux/issues/1145
> > Suggested-by: Alice Ryhl <aliceryhl@google.com>
> > Co-developed-by: Grace Deng <Grace.Deng006@Gmail.com>
> > Signed-off-by: Grace Deng <Grace.Deng006@Gmail.com>
> > Signed-off-by: Kunwu Chan <kunwu.chan@hotmail.com>
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> 

Queued for future tests and reviews, thank you all.

Regards,
Boqun

