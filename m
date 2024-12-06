Return-Path: <linux-kernel+bounces-435675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF9C9E7AE5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18866188A6E2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8408E22C6CF;
	Fri,  6 Dec 2024 21:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0b5ok/b"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678C822B0BB;
	Fri,  6 Dec 2024 21:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733519959; cv=none; b=MV4ll5TQLh0922IENzN2/4tR1Yzz5M/SCbTw9PhI8g8nvwSRab1WC6wPmktCWt0NUwFImVkSPtZfdIZ2GQDoS6AAeGo1KFg0SLOR5NbshrbiUrVehCvmhD580jG3jdpYUqr53pBdb7QwNhV8Hc26WVboZw4kYQbh5OwOQDIu7ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733519959; c=relaxed/simple;
	bh=TMpQbpHCvEIU/l3xCqo8t3qBhUVdQ/GwMV8fy1ObTco=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H/xUDTtw88poB8p+L+bKkSJKwKBg2BMoV60SoWPcgTcAFPtrGfSyXMGpQbZHFURbsE3ACciqxqEYDY1SkNNiXtZ9n9zJhCCHSYO1lmrH/rj3FT8DJcnXB5kntvHy4KUUy6oeMrmz5RxWIj3C276EOW80IYj2ZtXEZOpqAN9RpO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0b5ok/b; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-215936688aeso23854365ad.1;
        Fri, 06 Dec 2024 13:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733519957; x=1734124757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2zSIblMbayK4/kRTuxvLRY9FgToqz2lgeW7frRWffI=;
        b=b0b5ok/bLR9AMmyTCpfmGCN7avlTECO/H2zJD4JGXAmC56dwaeDLMuUgTHMBXFeE5o
         cpUva9iFIjNnQabuvmj9xRuOmMNe5OfUIdev9IMa+T00KoxfA/0SMUW8c46hnDN49eha
         j2Bipxej7ei90pPIB1HuTMxgADT++AW5jVtpGxUa4vQwRAbYVxabPd+pntYhesHUk2Z3
         tfhgCnk6ZwAZ/fQXIVVgwtzNNMQnSGXTOg/gaZmKiKMuNLmpMWrPHmO7MBLk8BsDmG7g
         dpoduCFJp6iXlgzKWSztN1hkJsw/6Wx9GFra9fRImMotKxVr9lvxCc9Fj3uscYyp1uX1
         zHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733519957; x=1734124757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2zSIblMbayK4/kRTuxvLRY9FgToqz2lgeW7frRWffI=;
        b=N4aEgI8tm+aPqVbxNWMETw3m4QJQhGK7t6WUzr2RgBj2eibs6FxQVl3JRehxKebDRn
         SDRziMs083EkDMR1Njy1MCx2LkikRAuH+U89FxNjrFFQ4QvX6HujLJefHTLViKDFzSdH
         Q/iNalJY/mhSgRk205KppQPwU8Lqb5G6G2MFZVQKWLkaD1VObrBWnpRgfrLCwf/YfXJy
         A8LDpyjUyeZr0X6JllIdnIUEyybjhpS6fV4h5LFNJDzfyWIMjrJZEuFZQfRxpkRuaNJk
         3QEbLmMxJoTBmZadfzlUrjtL+OecTat/DoYHHkS10ymvOUASi7k+mBvEl9/HpbsmnNoQ
         boUA==
X-Forwarded-Encrypted: i=1; AJvYcCXWho0Tpdui/s0/ZgRnc8P5nzvI0EQ7onYiD9hIfWM6zwFM+ecrHQW81V6vxZO3RM3Nq8wRqLxQcG4ZLy4=@vger.kernel.org, AJvYcCXxa2hMcrPDIYMBuyB//zZebXkMubwZx6ErlHcbFKpmQ7L4Gpkbwf9zlyE4WX3JNCStBfiCpaLQvjNCatjeoQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjEEHLgpowD9+fHaFn5t8KDoKIJ21hb4QE1ytvGBBhBoKsSKLK
	mSYT78d9LWkRSlVdWNYR3LSCaogCQuWLu51OXFKzqUrX/5w1ZaGc
X-Gm-Gg: ASbGncv94ZRzMDzgoMQaDZY0RoZx6qQZ9Job+vPYMUNAxWJGVR52Osect1uLxCVM9qJ
	2hcv1gqz5EQAzWDK4lGbwnU13kh06ekVS8eqAsjvKnuP8ZMCkxHfIm3BfGoLtn021S+wB6SbVDa
	u8xnujY86B76xcrBKNBWg1CyBPkW991WiCDYebM/ogJpScHfEwaX68nA/GlPUlWDcXeT6QX9FqJ
	/CzxYl/3p3UjNJVzlQJk39yw5RaiZh35foNCJY6t8ErxTH9bcaSwoZT
X-Google-Smtp-Source: AGHT+IGYnxmO7iIqvaAYhhb7BNLq0dvZ/w6AQQRAyQf2isqLaDe/8WChO3Tvvhl2ShMg3Wp36cwTqg==
X-Received: by 2002:a17:903:230e:b0:215:b8b6:d2ea with SMTP id d9443c01a7336-21614d442e3mr71734785ad.15.1733519956594;
        Fri, 06 Dec 2024 13:19:16 -0800 (PST)
Received: from linuxsimoes.. ([177.21.143.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8efa1acsm31951425ad.126.2024.12.06.13.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 13:19:16 -0800 (PST)
From: guilherme giacomo simoes <trintaeoitogc@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	fujita.tomonori@gmail.com,
	gary@garyguo.net,
	linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	tahbertschinger@gmail.com,
	tmgross@umich.edu,
	trintaeoitogc@gmail.com,
	walmeida@microsoft.com,
	wcampbell1995@gmail.com
Subject: Re: [PATCH] rust: macros: add authors
Date: Fri,  6 Dec 2024 18:19:05 -0300
Message-Id: <20241206211905.444952-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANiq72neo_RtANWJu_GW5LxsR5KWxriS1L8nsXkNn7ioiaEQKQ@mail.gmail.com>
References: <CANiq72neo_RtANWJu_GW5LxsR5KWxriS1L8nsXkNn7ioiaEQKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrotes: 
> There are several ways we could do this:
> 
>   - A single field, that only accepts a list.
> 
>   - A single field that accepts both a string or a list.
> 
>   - Two fields like this (that cannot coexist).
> 
>   - Accepting several "author" fields and append them all into a list.

I maked this change like this way because in my thoughts I just thought about:
- A single field, that only accepts a list.
- Two fields (author and authors).

And how in the first option I would need found all modules that have the author
tags and I would need change the code (from `author: "author"` to `author:
["author"])`, I was think that is the best don't change in a thing that is
already work well. And this is why I choose the second option "Two field". And
if the new developers need include two or more authors, he can make this since
now.

But now, that you put the option "A single field that accepts both a string or
a list" for me this make sense too. I think that the A single field that
accepts both a string  or a list, and two fields (author and authors) is the
two best options. 
I don't like the options:
- A single field, that only accepts a list. 
Because we need found all module
that use the author and change his implementation.

- Accepting several "author" fields and append them all into a list. 
because in the modules the developers would need a several author field if the 
module is development for several author. And the module! macro would grow a lot. 
Like:
  author: guilherme, 
  author: miguel, 
  author: another_poor_developer, 
  .... 


> > -        for alias in aliases {
> > -            modinfo.emit("alias", &alias);
> > -        }
> > +        modinfo.emit_arr_str("alias", &aliases);
> 
> Spurious change? Or am I missing something?
I make this change because, the for() would need repeat for the alias and for
the authors and for avoid unnecessary code repetition I create the
emit_arr_str() function.

> In addition, there was a PR [1] by Wayne (Cc'd) that implemented the first
> approach, but it was never sent to the list. I pinged in the GitHub issue
> too.
.. 
> Also, this patch should update the documentation of the macro.
About this, I will sent a v2 PATCH with this informations

