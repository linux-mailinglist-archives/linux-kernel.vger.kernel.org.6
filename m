Return-Path: <linux-kernel+bounces-540508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCF8A4B173
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 13:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CBB9188E888
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 12:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3481E32B7;
	Sun,  2 Mar 2025 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKETooVz"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DD62594;
	Sun,  2 Mar 2025 12:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740918002; cv=none; b=UM+Ik6wSltAzJ/BOiCw7r2rIQ3OmrEEDIDhk1O0zMSc8apBPhEngrgPzjFKOiQPfZTn+/2kSNvZUJDclG3XU3DnyDS9yV4PG2SoNJNyHFdvPL9yVPuDOJuM6UWnTKKNe9S5nlTIj2emwsPJZ++jmEO0rkm6JJRU21WRCIvG4pxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740918002; c=relaxed/simple;
	bh=ZrBbCj0ibZn0HW4gHwjyxqJOkO6cqMU6RSDZLyfOTyo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zv1dHJMAsFuyGbpYb0GJVZT+/3CkoF0oEKsfIx8hbzQ0TPGfGZgsLVsl5ERQW/z9RLWjwz4mnbsJRZLwrX42GAfskY2W00cpxWjlqRBnrqxDNm4cay5wyOunpFtjwELAUYAm3SLC92mc8mKjL8dTckaYzMxRttQ54vBcIacjDoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKETooVz; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso22760425e9.0;
        Sun, 02 Mar 2025 04:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740917999; x=1741522799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgCqjFsdmVPmkwwHKifVvYTCFuUFMQI0XhP4ZU/3jAA=;
        b=TKETooVz6bWpQIGn66SZibkuJXeIgKJp6O1o1UJ7U+VRetWhG5+4bOOipIPE4Uu9ts
         +mvKGTCVzh1OSRvNCUYry8kE8zN9KTi6fSGPHqMN/FvdZlSffwkUSxk49GutHo+oXc1k
         4vbnPzdXDKeFXSXhBt+kRtNdKa3ipYxVqmxIBn1+hZSuAEGKYhkjUrI8/Q4fR/L7+N4v
         I2jWhZTO50v4caQMWQ410JUkvHQ1Th5AsUbDMZMZ9RWS5iA5EOyEY50YgDeyT/Mw8VXe
         Qoa1JjQ83fFMn5czUEArdZ4o6dY6jphRWZbg8q0JBFnMkUqdACvJ1C0MECcAwPFwhGR2
         ItlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740917999; x=1741522799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgCqjFsdmVPmkwwHKifVvYTCFuUFMQI0XhP4ZU/3jAA=;
        b=qxvURNXha+klL3QFSmTPm/VlasiFIhg86K+xX5H/8ZszEHL3XvE4arBVR+QMPJ1b0M
         Sff/2GhKkrXpATASjWo9JKnXicV3XjHM/oMDPfnWQABAZQt2wYzDVfWBcTYmEDfXPhq4
         JfgkO6SSioCE4hL/Ib/dx4Ff7XgFllijJgXllCcR0E8UMedEk3S+Hot9L0vgutLjzCFt
         GeAC529nx4d4z+d98YK2ZBSsrNB4fqTu4ZCo2XPviQot7biU0bbLUWYvwTTU0nJGaZ9c
         4z/e/yA/nvP2ek/Nao4AZzN2NWQtcpgxwf4nFuei13l+N0+Ct0MBcb814Ah9x0ere6oy
         KSAA==
X-Forwarded-Encrypted: i=1; AJvYcCV0y5q7g4RIdYs5LzmMYRM7usSLDvQlj/a72u6Jg7yalSYkUZgQDbFb1Rx4+PvndM3BGsFcG+KXoHdokl0=@vger.kernel.org, AJvYcCVeX+gPYIoI3mGF1qd/byXRxMGNpvITG4qwLmRTTMNUNLbZQZzbkSl3xfwe8IOudqmwDflnl8M4rhRpXnG+/rA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQvCfQ2eN2H6xzvXOyS+Ztn4KNF3mpum/rUaadaGC4sMKDEO5u
	AiT98QpCpNjzLF+rGBQ4Djl/FnZ7WVRJtYsVF+EMg+uYjdGBCk8/
X-Gm-Gg: ASbGnctdWQSDoRfC+Ph4UiUOIpTu3Ov2oWGgbPbmnIfoh7ayLrAxN8Eo3w4QBlp2zxp
	dFhS4FzPR6E/yi7Ax9m+9EnjlASK5xN6pU0xXxPzC6UNhoFKveyaRUsVkEoTCelgRMz3ZtsEzEO
	QNiQHK0PybDB8lZffWqiDXhgArXX6IQzwM8kbl1wKYbrEh9Dy5jahmYnTTtB9ekZWlxgsnThJot
	nvsJvcrQqe3g7H4sHJ2gm4B1acXlHBo9CHUDyG7RfkxHFZAOLZRrJyYU7HFT6wnixO4Qh4V8hqy
	TNOj5TodwK52amiiqO29b8H2PScB6miMPuLvJmdJ1t3ukGqW0K0OcwmpyVuzEIdpCGSAp76TJjl
	ovh8Q0Tw=
X-Google-Smtp-Source: AGHT+IH9JKVSqwCY7/dPDG8HlygkblxfEWt0EgMvbXyn+Sth5sEwgJ69CNPda359PKer/OXo7j7gpA==
X-Received: by 2002:a05:600c:a01:b0:439:9377:fa21 with SMTP id 5b1f17b1804b1-43ba6766be1mr76628105e9.19.1740917999301;
        Sun, 02 Mar 2025 04:19:59 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bbfb7e280sm7560765e9.8.2025.03.02.04.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 04:19:58 -0800 (PST)
Date: Sun, 2 Mar 2025 12:19:57 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, James Bottomley
 <James.Bottomley@hansenpartnership.com>, Greg KH
 <gregkh@linuxfoundation.org>, Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>, Ventura Jack <venturajack85@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Alice Ryhl <aliceryhl@google.com>, Linus
 Torvalds <torvalds@linux-foundation.org>, Gary Guo <gary@garyguo.net>,
 airlied@gmail.com, boqun.feng@gmail.com, hch@infradead.org,
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Ralf Jung <post@ralfj.de>, Josh Poimboeuf
 <jpoimboe@redhat.com>
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <20250302121957.28f08504@pumpkin>
In-Reply-To: <20250226124733.10b4b5fa@gandalf.local.home>
References: <2rrp3fmznibxyg3ocvsfasfnpwfp2skhf4x7ihrnvm72lemykf@lwp2jkdbwqgm>
	<CAFJgqgS-SMMEE2FktuCUimdGkPWMV3HB2Eg38SiUDQK1U8=rNg@mail.gmail.com>
	<CANiq72mOp0q1xgAHod1Y_mX86OESzdDsgSghtQCwe6iksNt-sA@mail.gmail.com>
	<f2bf76553c666178505cb9197659303a39faf7aa.camel@HansenPartnership.com>
	<2025022611-work-sandal-2759@gregkh>
	<16127450a24e9df8112a347fe5f6df9c9cca2926.camel@HansenPartnership.com>
	<20250226110033.53508cbf@gandalf.local.home>
	<9c443013493f8f380f9c4d51b1eeeb9d29b208a3.camel@HansenPartnership.com>
	<ylsffirqsrogli5fqlyhklhy6s54ngolvk5hj5fnpn3ceglyii@cgcvtm4ohtra>
	<20250226115726.27530000@gandalf.local.home>
	<olxh7iwz5yjuuqwpbzgohrl3dkcurbmzij3o2dbha5mtkr2ipn@wtee4jjj7ope>
	<20250226124733.10b4b5fa@gandalf.local.home>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 12:47:33 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 26 Feb 2025 12:41:30 -0500
> Kent Overstreet <kent.overstreet@linux.dev> wrote:
> 
> > It's been awhile since I've looked at one, I've been just automatically
> > switching back to frame pointers for awhile, but - I never saw
> > inaccurate backtraces, just failure to generate a backtrace - if memory
> > serves.  
> 
> OK, maybe if the bug was bad enough, it couldn't get access to the ORC
> tables for some reason. Not having a backtrace on crash is not as bad as
> incorrect back traces, as the former is happening when the system is dieing
> and live kernel patching doesn't help with that.

I bet to differ.
With no backtrace you have absolutely no idea what happened.
A list of 'code addresses on the stack' (named as such) can be enough
to determine the call sequence.
Although to be really helpful you need a hexdump of the actual stack
and the stack addresses of each 'code address'.

	David

