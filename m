Return-Path: <linux-kernel+bounces-236751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C17FE91E6AC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E05C283A12
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6355B16EB44;
	Mon,  1 Jul 2024 17:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlpfZODT"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DC028683
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719855083; cv=none; b=tfuPTe7YX7SDWIlTd7ifQrYE30e+DD5ERnLYnnqSsq7zaftiJXCT3B6WctHgfoz01c0WFGPb3bPm8ObEeiu3LTqROxFzEhrimF5UaYcqsyOrtNaO4f5FNOAc7bweGzTEFN/3SwvSdCpuM7ElIgv9wp0SwJNiyAdEmwKX4YZlooM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719855083; c=relaxed/simple;
	bh=kLTpQjX3SiR8I8/5MQ6QATez9Q7Uz3p3ow5fadDaLzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkFX2YbArO6Fh0vk82Y9Bc1NcU822NsAhNKnncxoesPq/kjW77BA92cDpsgqPms4+9lIrWPq9dIlSCktFWg7wKB4bLl45nAoi0+77z2PgoayQ2Ha/4xMTM6gzU9yH0mlVsLBYjwWq0ZdQm9GH9jueaii+1i5dqmZuFuKjPCWY8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlpfZODT; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b4ffc2a7abso24593176d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 10:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719855081; x=1720459881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUzeLJ27BF4DSVucZzd+qxK6LhkWds+RiDklC+9YXMs=;
        b=KlpfZODT/tXufwODjl8EVQR9pi6R45J2Lo2ZqCU9ectDlL8l2z9f3/+GbkOaV3QUzV
         v76LDYo9TUktuAkn4aZucpgJlhHO7mQSt6vyzDIRqmxbrDqiVy0SFM5BZM1h4R0JDuEo
         flMept9Hm1WK5BkQ/VoftfOfMOrkFME5PYd5Zp1H6wQa2NdA4EcRPJDOuno0jpzKwCP/
         fnEE15W+FH273hhxd4D3gamd8Gv9deQF7VyaGnbT8gCG6pYaLvVhqb+l4RLtd2f/9Fou
         EFgJHIAclD7uIAJHMILibbe60BrYiq1cgtjBplWnpig/mVKTe5qyB6a1gJXvfFwKJ7Fa
         savg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719855081; x=1720459881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IUzeLJ27BF4DSVucZzd+qxK6LhkWds+RiDklC+9YXMs=;
        b=wIiib2v74IZHbejKpt84UkZGbmCYUGfG2Sb8Fgn+p0Ahru4zZap6aWLSMKEi/qH38z
         iy28DLJXomQyUcfhQQdU0mPwVB7g79Mh6lmEAsS/UF7zeqtPxXlP3lfA9a4dnNsYqlyT
         i7fk/mfh+mJZb4f6+0uOQBPWLbDRdpwIMT5cEkVOtRdG84tjG2rnnEfr7IMVy8JRrFzb
         14V8JZCKCorcE8bIsuOqPR0+LTHbIpbuOZR03NC0IhDviRJNsayjswxepuGX3+4F2ZVA
         Mo0DAGnr+sk0FbS37/mWQAflRvdAMUH98hUCYLvz6Cm0xh7cOdhgrODewZyYpC0i186L
         yFoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVstDZmJNeROxunkBGY2g/r3rfrOzjRo16ynl4Dqi1X+0zNq7Q24lQRzSbaWctY0P62J450EWHBQ3ZJJNgyK8Uv3pTCKe4O0RlXx+Yt
X-Gm-Message-State: AOJu0Yx8kayzUHFqxxZIyw7EuXQcpo3OzJh4rm8QdlVk51yXKnvAOH9D
	oOhdfXnDIRYbWTilocaBcPzCWNmfzjWOgBWmxv6/gl5/QFiigghn
X-Google-Smtp-Source: AGHT+IHmh0wwSaNGMs8t3cBhv0e6md7IzSeO/tTDzfrRE+QeUYMpvgDfBjSFleDJ0+DuTYdPoZdcjw==
X-Received: by 2002:a05:6214:240e:b0:6b5:7e74:185 with SMTP id 6a1803df08f44-6b5b6f5a5bfmr114168236d6.30.1719855081246;
        Mon, 01 Jul 2024 10:31:21 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e563230sm35300586d6.35.2024.07.01.10.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 10:31:20 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 676211200068;
	Mon,  1 Jul 2024 13:31:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 01 Jul 2024 13:31:20 -0400
X-ME-Sender: <xms:6OeCZvkUaYp9eIWMB1Ud86RL8p3KzyLIFdfl6ADNLmJ5tF0fGnoWmA>
    <xme:6OeCZi3AF-OhouQFpxGZHnRlUozxVyMwADAqKe-skW4KhD5_zGXrWo2DNgclgoyR3
    QZtcysKqyolnqI9XQ>
X-ME-Received: <xmr:6OeCZlqZoS4DBmUDa5aw3fiNrvvJRWagUH6ZOxZhxcTjNYBRROs5VtDDG8tzPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeevgfdvheehleejieeujeehffdugfefgedvffdvueehgeekkeekiedvkeel
    vedvhfenucffohhmrghinhepshihiihkrghllhgvrhdrrghpphhsphhothdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvg
X-ME-Proxy: <xmx:6OeCZnmTcLo-CGzlVX6hOKbulIKZunzX9wRAxiauE_Fa_Z0AMq6d4g>
    <xmx:6OeCZt1EPaR7aUeXs4UHIdaUvxcGASme3Kelf6-8lV9Tyl2BHzUyjg>
    <xmx:6OeCZmt8l5z9E0_AdXYHTLzbLsuLxAobk_lV2ErZytAGNa0dTI4ifA>
    <xmx:6OeCZhWtibUwqkNE-H6w9HqbhdxY4XglfcS7HdIrJJpm8ApufA3eRA>
    <xmx:6OeCZs1cLMvisJta3ZmTZI4AzdV8GpYaoC7NMw_7WGTN_nBXZkKIGEwP>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jul 2024 13:31:19 -0400 (EDT)
Date: Mon, 1 Jul 2024 10:30:25 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: ahmed Ehab <bottaawesome633@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: lock classes
Message-ID: <ZoLnsZ47vJNSuxa5@boqun-archlinux>
References: <CA+6bSauVVgprKxB3f=Dgo0p5ZN0cyRAYATzGOe6CgsJ=Ai0trA@mail.gmail.com>
 <6be3513e-67d8-4ead-b44a-e6dcdedfeaab@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6be3513e-67d8-4ead-b44a-e6dcdedfeaab@paulmck-laptop>

On Mon, Jul 01, 2024 at 09:20:02AM -0700, Paul E. McKenney wrote:

Thanks, Paul.

> On Mon, Jul 01, 2024 at 03:52:44AM +0300, ahmed Ehab wrote:
> > Hello sir,
> > I am working on a bug reported by syzkaller
> > https://syzkaller.appspot.com/bug?extid=d4200fc83fa03a684c6e . I am getting
> > 2 classes with the same key but different address for the name(different
> > name pointer but same content). The problem is that this info seems to be
> > persisted in the vmlinux itself. Is there any place where I can read about
> > how lock classes are persisted or something?

You could start with code that initializes lockdep_map (which is
corresponding to one lock instance), for this case, it's the
init_rwsem(), and the name & key are linked to the lockdep_map in
lockdep_init_map_type(). Eventually, usually at the first time a lock
instance is used, it will register the lock class, where lockdep
allocates a lock class and store the addresses of the key and name into
it.

So the problem here could be the string literals (i.e. the name
"&ei->i_data_sem") got instanced twice.

Regards,
Boqun

> 
> Hello, Ahmed,
> 
> Adding Boqun and the list on CC in case others have better advice.
> 
> One possibility is that there is a lockdep_set_class_and_name() call
> that is separating out locks that would by default be in the same
> class.  See the use of this function in the rcu_init_one() function in
> kernel/rcu/tree.c for one example use, in this case to create separate
> lock classes for each level of the rcu_node tree.
> 
> There are a number of similar functions, including lockdep_set_class()
> and lockdep_set_class_and_subclass().  These guys might well duplicate
> the name, but I have never used them.  Me, I encode the level into
> the name in order to have better lockdep diagnostics, but that is not
> always practical.
> 
> 							Thanx, Paul

