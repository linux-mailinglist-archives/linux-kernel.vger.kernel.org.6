Return-Path: <linux-kernel+bounces-227324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E57B1914F70
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F771F21C67
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CA2142903;
	Mon, 24 Jun 2024 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="INR8yCWv"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7711428E0
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719237597; cv=none; b=rhEhJHDe2PkNoz5T86eT0BST3wiFtWHnqBdgR5TLjdFC8iyGLsRCcPlhdH5fFxflZhYiAV0Wzqf8T9O9hsJnpnLH5BJ8yiHubFBWJ3cXBaY3R0n7+NS9GA5KdLmz42NJvqWsdUWX0zc417dYFll0MtpWh1TQypPnrRNNMb4kVTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719237597; c=relaxed/simple;
	bh=1RmILU7sEfgOL5C8noYL1Mesy9QeXfx6SH6gs1dytiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gIGNfpoKE4eDGDPqdsxtLINdH6zG2ICrSkRqEeX56qwDmL4byO0zR8IbYfnEXK7KrwRt4XejmmnNBcfDfKzrmlPhjShrhLlQK+Qrm4lz/AtuAKTmgrvKw4itVu6VHQFBncQHE4m0wNH1TxAzy/BAOd6ubCjjoOuXBX6oalwyz2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=INR8yCWv; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52cdf2c7454so3185903e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 06:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719237594; x=1719842394; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FRxJqV/9V3WmotPQQur7o3YnAN57z0pSUs0Lyii+xZw=;
        b=INR8yCWvxDN0WlASBYa0RJ5hY56X0j0WVqqpWyFqkIBcie9IeVgqNBCeQ6IqODIV8T
         +kVBx03zXy1AkKCbpU/eMglxCaXC799QQqo9n/KH2LmiKYii+q5nS85YUfyYu62SgTM4
         /ga9LtwcJ0ZG8fXLZlM26alJE9hKDXaeAcRbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719237594; x=1719842394;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FRxJqV/9V3WmotPQQur7o3YnAN57z0pSUs0Lyii+xZw=;
        b=hWi5XTHvUxJ3+OJ5Et9Ek4np3iSAmheFl+Tao4sGkc8IeMkWsee648xx2fHtZz8IFg
         ZOsbTt3EFSMEPI/FQprqaTYajOGe7JhFRvy3TCHZ7qPdr3mTbS/npUjVg860KOvkBLIq
         IBv9yCUBaq1qSC8ULCU6SRhhTxCdENFDByi+GqZkR/YjnILx7gu0Q4Krn2LldcoPY6Kk
         12NlmYarAV/NLhHdcNoOTrvmlQRlnEhZY5mKSk3ToC1ZXVgSu3sDocyWSopQBRzOHz79
         EAyXu1FQbEZsCfrpYddKH72F7GB34qHFXGU9lTjb28VJcKkqhdqBnnzXesvdDmFGQNi5
         yqDA==
X-Forwarded-Encrypted: i=1; AJvYcCXEBfelSZsYr6X47EFqF24b2zjtLgUF76AhzsdBdFr+olIF7Bw+n5QLze72GYsNmhKZ1fSfLA+5lXqvVjpid8oqrZaz0alHueofDYLX
X-Gm-Message-State: AOJu0Ywn3RizRB3g//F6Em5FqhbSsOvoblY/gr84C34IISOcB5qJ91Tc
	KzprUvpJiWUynORHUNYmlmFp+ARbNSojOocwRVAbDtdR4h5LRK0G2gnn2O0Phki2asMa1mIMVbX
	BNpz89Q==
X-Google-Smtp-Source: AGHT+IHLZ5s8FlgdBw8OVk0rD7TQRnjWtRlh05yADu2VeRjqjG8QaZqEYy688IKH4wTgXr1BrBrBvQ==
X-Received: by 2002:a05:6512:1cd:b0:52c:83c7:936a with SMTP id 2adb3069b0e04-52ce18526d3mr3546649e87.42.1719237593601;
        Mon, 24 Jun 2024 06:59:53 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ce6accddesm269236e87.114.2024.06.24.06.59.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 06:59:52 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52ce6c93103so1171742e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 06:59:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGgfvyOmhdSm6m4w8YhWHuxarLXqRPMA3Z8OJt1wjMdPRkMOvaMMvc0SX+POy+/qdFVFzGK4+LbkyWTHBIrvr15qkhjwL9SON0rVna
X-Received: by 2002:ac2:592e:0:b0:52c:d5ac:d42 with SMTP id
 2adb3069b0e04-52ce182bcadmr3212857e87.9.1719237592124; Mon, 24 Jun 2024
 06:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406230912.F6XFIyA6-lkp@intel.com> <CAFULd4YVOwxQ4JDaOdscX_vtJsqJBJ5zhd0RtXXutW=Eqh29Qw@mail.gmail.com>
 <CAHk-=wg1h4w_m=Op1U4JsyDjsvqG0Kw1EOVMQ+=5GX_XytdorQ@mail.gmail.com>
 <CAFULd4YR-VkAOKiS5yxSUYi0YMzY1p=pkYe4dOkgFs+A=9AFFA@mail.gmail.com>
 <CAHk-=wi_KMO_rJ6OCr8mAWBRg-irziM=T9wxGC+J1VVoQb39gw@mail.gmail.com>
 <CAHk-=whPqqZVSeJiQsMvsAxtAmtR9iAuB4gg_1sUK2D-uBPpLw@mail.gmail.com> <CAFULd4YAeF7=q7DYUh016kabxS8b32qRbFqDBJQrvLq6RjwEVg@mail.gmail.com>
In-Reply-To: <CAFULd4YAeF7=q7DYUh016kabxS8b32qRbFqDBJQrvLq6RjwEVg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 24 Jun 2024 09:59:35 -0400
X-Gmail-Original-Message-ID: <CAHk-=wiHo2YeA=TOUf8vxFLOc0+BoH8USaiT25fnX2ynXbrZkg@mail.gmail.com>
Message-ID: <CAHk-=wiHo2YeA=TOUf8vxFLOc0+BoH8USaiT25fnX2ynXbrZkg@mail.gmail.com>
Subject: Re: arch/x86/include/asm/cmpxchg_32.h:149:9: error: inline assembly
 requires more registers than available
To: Uros Bizjak <ubizjak@gmail.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Jun 2024 at 03:36, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> A real fix, not only a workaround, is to rewrite asm arguments to
> something like (untested, but "should work"TM):

Sadly, I already tried that, and it didn't help.

             Linus

