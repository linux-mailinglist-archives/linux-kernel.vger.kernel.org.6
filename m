Return-Path: <linux-kernel+bounces-415090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 034309D3175
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 01:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12C31F23524
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 00:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E253FA933;
	Wed, 20 Nov 2024 00:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NTbf0iri"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606104A23
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 00:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732062848; cv=none; b=MLCrI5u7utqTMYrAbjlqjIay2oxj5Sv5l0W2U1bEmyGHOlgjOOOfWNUqJhVZbbYc/Cb/qc/shfNR+uNE9cecVYShlQYmq3uGLO6HR783EzcfmvC9GerFvv564YwJgW+dxAH19nvxj3K2P1rgg7bEQI7ptdkhsI01xoQ7TvAy7N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732062848; c=relaxed/simple;
	bh=aSBC/uTqw1yuSzgY7tz9IpSiw34WInh6RGUr7uTflJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXoZV/blZJEyJHNhB9xxe5iAGvSI4TCbCsfROmgZzgTTNwF6OPQk5dXqgwBxA4PUcCuzV0Hsj2ghaSwdc4zEUGI0UZvb5ofLTntTc4uaiTa6C1gmWSkQNWMas9veU1GGz3NWJv54F/8F4nW55VS316PCKqD418QLtDzivT9l1is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NTbf0iri; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2feeb1e8edfso52051511fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 16:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732062844; x=1732667644; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bVIGRvmzr61wd/815Bbyc1WZaMRsK1Yw/OFgzZziCYE=;
        b=NTbf0iricTjwwp5OWV6b7Fn6xp7bU07Fl9ZNU/sv49Ts0DQlXkAelJPiWLq5dc8iC9
         15JdKFJ3N/u//W2A4QeCe659QKpkYbIuyGJYZD9TGNtzLfj/kRjbPc+eXhjyuBFJYqHD
         BEwJ376suoOZ57MMOq+ySwfPtTu+HznNSv8T8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732062844; x=1732667644;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bVIGRvmzr61wd/815Bbyc1WZaMRsK1Yw/OFgzZziCYE=;
        b=gku4JXs1/qW1Xt7fNvLpWdqZjojDEbY50TdoKvxBAQjQeAoJyimZXj+0t92TGJsRaT
         EP81s+hpn5sYkWl9oux5GLZc2QNZj10Wbt8y1xQWCCGd2C9vddqlszslYqOVA5s8WWit
         t7CoESoMuD86KvOJdb5iwO0gN63o6BfnqrzznHqnCIJPCdbswu1uH5nm+OR8GxIhq5Xr
         L1cTO0y0ptVKzZYI4ckEq39CYTR+ZpL5hNBzn3V94hVnwikk7jeC+oaWMqWdWeOypXv3
         Q+jotZw/ZI+sqrR3wqP69KLLnrIAlDr4d4IMyE4ZQzfGO7zos4mjoypJPoAkb3oowVSn
         IFxw==
X-Gm-Message-State: AOJu0YzDkNIHhX5WcbvkJHf4RIJi+WwA334ekZUcD3sY7jNzAoPMYEJp
	C6Yknn80PfBAbANkrOq1kZfZQ4fN3B85/LKEZpyxThfpial9LWaqOizCy0OklE97jtOup9Xr3YE
	i0W5PDA==
X-Google-Smtp-Source: AGHT+IFLD5L+H2fOwECCJRYFPxg6CBZaykKY4cLLmePmE3LICwRsxoS857kHeFf2wFKToWkS7XINqA==
X-Received: by 2002:a05:651c:b07:b0:2fa:d84a:bda5 with SMTP id 38308e7fff4ca-2ff8db163bamr7724701fa.7.1732062844386;
        Tue, 19 Nov 2024 16:34:04 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e043e80sm704417066b.141.2024.11.19.16.34.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 16:34:03 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4314f38d274so51903405e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 16:34:02 -0800 (PST)
X-Received: by 2002:a05:6000:1a8a:b0:382:372a:573a with SMTP id
 ffacd0b85a97d-38254b1b9f3mr524288f8f.50.1732062842189; Tue, 19 Nov 2024
 16:34:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <173195757899.1896928.6143737920583881655.tglx@xen13> <173195758632.1896928.11371209657780930206.tglx@xen13>
In-Reply-To: <173195758632.1896928.11371209657780930206.tglx@xen13>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 19 Nov 2024 16:33:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiX7=bqOEO06+BsO_25dHoa=KBWcNzLg=-rAKJ=dqKxYg@mail.gmail.com>
Message-ID: <CAHk-=wiX7=bqOEO06+BsO_25dHoa=KBWcNzLg=-rAKJ=dqKxYg@mail.gmail.com>
Subject: Re: [GIT pull] timers/core for v6.13-rc1
To: Thomas Gleixner <tglx@linutronix.de>, Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Nov 2024 at 11:22, Thomas Gleixner <tglx@linutronix.de> wrote:
>

>   - Core infrastructure for VFS multigrain timestamping
>
>     This is required to allow the kernel to use coarse grained time stamps
>     by default and switch to fine grained time stamps when inode attributes
>     are actively observed via getattr().
>
>     These changes have been provided to the VFS tree as well, so that the
>     VFS specific infrastructure could be built on top.

Bah. Except the vfs tree didn't take it as a shared branch, but
instead cherry-picked the commits and as a result they are duplicate
and caused a (trivial) merge conflict.

Oh well.

                 Linus

