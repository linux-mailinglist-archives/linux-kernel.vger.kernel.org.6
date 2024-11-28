Return-Path: <linux-kernel+bounces-424277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E619DB28B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 06:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEA2E166BA2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 05:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545E513D891;
	Thu, 28 Nov 2024 05:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORZIMI4C"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1191386BF;
	Thu, 28 Nov 2024 05:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732772432; cv=none; b=j0rK809ODFBoX3O+xDzG253rIqgxwS5rjRnbSKZM5s43pFiAtAkhg8gaVpxRQl+qAA7B4CKGSoOMSF6+ieu51FRHEJu+Hf/ijdzLpvfq55ae06hz3FlFKWArqTEaT8fDpr2W61ZpnnNQqnsGHrfW2fUf21BaW4SOHrdrK97WFd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732772432; c=relaxed/simple;
	bh=Q35w+fjv9qC0X2E1aqSiCBw9O02+ixoPN/iWPcYJV6I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YXvnwuswpIJr2JDdh08QKDdFuJs/0TGDhPD6jmKY3XaGGuk919TXi2BE0yVOcI+t9usyl0E0OH07x87czrX1qe4ncRatlrlto16wMfKrSO7p/vFQ/fIXs/5GdRFazW5AgxFVLFV1N+OwzAVgBpMHLQPtvtL7q8bUGFTQLvNS2n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORZIMI4C; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6d41864d745so3494166d6.2;
        Wed, 27 Nov 2024 21:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732772430; x=1733377230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P1O3kQxYL5LasoZQGzNcMRxsMn4N5HVqW0HCKPg+PzQ=;
        b=ORZIMI4Cg3PNN7hx6vhMsSZCs9d8Kxb9xZ/+ulPKk+w8sRzklmr1oJPSDjd9AzmrU4
         lCbq27o+2/aTGYWM6uTcNZptXlL7WOPoL3gqUTEx4Exe919IHHHvdKe/yNKUB8encEo5
         41uJyeTkXNQDfmQqBfcy2aefDUWwb3J0MQViaMyFEyOcXJK1hCBI+bWF/R5O2wTZrhfS
         auS7YU/rfubuIirNSgHXmmHsKbfVYiAX84+ujMDcne8SNZ9tIV1L23kehv0gfJgdgcPo
         U+X9a6FoeFTTbeoc80iTX6F+DJ6qvhR65wb8DBXGAH9vRwwVttHWAEwEC5qltNpldunp
         H8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732772430; x=1733377230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1O3kQxYL5LasoZQGzNcMRxsMn4N5HVqW0HCKPg+PzQ=;
        b=hQgHhAYtJZqPZc9/ztDYk/tPIJ3DbZO0gQO6cdXOIoV7Tc6ALSG/kdzl4JxSQxOqaI
         TSSYysUwGRXvBNRXSH+0BpeLvK7VkfmZH1eaWeGUDx6/7l/jk72qLGv9zNHBhrMvYsNo
         ub1/NAZzRzhS5OFnFTjC+NwF2qeWsstyMqV6YKmiVTZVgdsrd7Jzov4JlTRa/2wE56cB
         qsnJQYv0pyYQlep67rr5WPymAQTIjPAZBChFWxIvVmEEYXvLSSdmklegssaWD3Jp3tMX
         V2FDL9m/mB8kefd/bjgerMvWYFrc5FLzqNfgtyLKlIr2aj22K4lNibnQgGp8bMkL7jRg
         NbwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7DKszaEL3bgcVLo3FTZ6fnar6ggYZugsFaiTLmLZizvieKBTopM9NN7onJgxrERZJ7w6coC7lZ9i+m4HUp+k=@vger.kernel.org, AJvYcCXvPNMbOIebbHyluQBzujE4CPQUDKpq+GUIadSEVvYwEhDIc96ROdQiev5amrg9KH9YBjZ7B+69k0/POXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKMIY5IhibUcR3kofzUBIyslXg/qlXUORFyFBV1BndbREhnzGr
	wkBfT7mr6TwmpDhYbGOs1BHGbNzNTdzmbE+bVowj67IC8A3BPnQF
X-Gm-Gg: ASbGncuFVJSeyqV9gtTK6fNmUnH6xgYxPxyNKr5OET4VpG+hA/7QNF7Lgok/hz+FNhV
	t48QoSzbgNzzToagzxW7Iq0++ZF3Yp6D2jf/rjYO4i7sOndYYpVQCtpv+3IcSm6xxtdVCW+ei0b
	vvoQBEL4WIk8XYgYzT4eMLTF3rck3mjJCcZ+MutADhI3zfFnsZN6M21Wbz6GtVT0SJne5Rl4zZv
	cWY/1uFrgP5oy02G9mgiNTHt2N2hyGyLNmtLAWnh+7Str06QnOHaGbqme37s3bU6789KBGDg5Qc
	x8nvnYHd8bSHUYKgtnI0fndbpPxIKvCucnJJRE5C
X-Google-Smtp-Source: AGHT+IGZcQ7mwVy7ZRi4irOVtUqnCmp8NkKRtQhd9dY0a743HOqRaLyAnq3vMXu02QHf7FNLO2+J7A==
X-Received: by 2002:a05:6214:20a4:b0:6d4:1d4a:70e3 with SMTP id 6a1803df08f44-6d864d1ee30mr66983336d6.13.1732772429724;
        Wed, 27 Nov 2024 21:40:29 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d87517dd37sm3180936d6.30.2024.11.27.21.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 21:40:29 -0800 (PST)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id AFC1B1200077;
	Thu, 28 Nov 2024 00:40:28 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 28 Nov 2024 00:40:28 -0500
X-ME-Sender: <xms:TAJIZ8KQx8uFM8-pdNEo9HxttK4TsRsZx-lnQZKzzs6Cg6oZA7G_SA>
    <xme:TAJIZ8IK1QaZM_gOY1B13DKyPTNO3i5kdZSVBSeF9onwxWIkQmzYJMaZOtSEcfwO_
    G3UNuR2gtXGa71-BQ>
X-ME-Received: <xmr:TAJIZ8s4mG7AErvxCuCDd969GJz1nF5VQWLr14Z42bENTiQeZW2vY4rq7H2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedtgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhr
    ohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomh
    eqnecuggftrfgrthhtvghrnhepgfetfffhheejgedtudeiffduteefhefggedujeduhfei
    fefgiefgveeuudeludffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidq
    ieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilh
    drtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedujedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpth
    htohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepohhjvggu
    rgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopegr
    lhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrg
    hrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgr
    ihhlrdgtohhmpdhrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmh
    gv
X-ME-Proxy: <xmx:TAJIZ5b83YMtKjQc34kCII05dx2NbiCw7HDe-8uQUjzfFmDQYPj3_A>
    <xmx:TAJIZzYU_8COatUKCZjDAH0kgOOYLoR6C7IizOxMKxcJB2pz_KCylA>
    <xmx:TAJIZ1C7ck-9DoJ_ILI7KxUxw-75tywwxEaTA396kauVEGIl8vVlfg>
    <xmx:TAJIZ5YygWghAjspLQFc09b8eYGxV0ZFtyhez3pTBpgd7Exsj-0_bA>
    <xmx:TAJIZ7oablGEOveP_9Z0O5zGt7xPHhGh6n7JESxtW4hq9MobOwjrKWci>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Nov 2024 00:40:28 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lyude Paul <lyude@redhat.com>,
	Filipe Xavier <felipe_life@live.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC 0/5] locking: Start watching Rust locking primitives
Date: Wed, 27 Nov 2024 21:40:17 -0800
Message-Id: <20241128054022.19586-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ingo, Peter & Miguel,

I want to propose two things in this RFC:

* Add Rust locking related files into the watch of LOCKING PRIMITIVES
  maintainers.

* I will handle most of the Rust locking patches as what I already do
  for lockdep patches (i.e sending a PR to Peter at around -rc4, so he
  could put it in for the next merge window)

Patch #1 is the related changes in MAINTAINERS and the rest is part of
the patches what would make into a future PR if the above proposals
make sense to you.

Let me know how you guys think about this, thanks!

Regards,
Boqun

Boqun Feng (1):
  locking: MAINTAINERS: Start watching Rust locking primitives

Lyude Paul (4):
  rust: sync: Add Lock::from_raw() for Lock<(), B>
  rust: sync: Make Guard::new() public
  rust: sync: Add MutexGuard type alias
  rust: sync: Add SpinLockGuard type alias

 MAINTAINERS                       |  7 ++++++-
 rust/kernel/sync.rs               |  4 ++--
 rust/kernel/sync/lock.rs          | 25 ++++++++++++++++++++++++-
 rust/kernel/sync/lock/mutex.rs    |  8 ++++++++
 rust/kernel/sync/lock/spinlock.rs |  8 ++++++++
 5 files changed, 48 insertions(+), 4 deletions(-)

-- 
2.39.5 (Apple Git-154)


