Return-Path: <linux-kernel+bounces-179389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5418C5F9A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA74E1C21DF8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5B338DF9;
	Wed, 15 May 2024 04:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ba/rrUgM"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E0038FA1
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715745988; cv=none; b=jhdx2C0M/CAV8uy1bnM0tsyKAQoXWQ+NJE9d7aQoGq+wa4Uwpn9POktC50R8fjIj3NBV8iQnP6HESZlax4HkAUWSKkOs3SQNXgJ2DQBp5+sQr38594SGLk2bmb0iChOvEKBIn2R8HGS8+tLyH7BjU4rJ4TkONmr3RK/GipThxE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715745988; c=relaxed/simple;
	bh=oDK0dZjxuFm0H+MXlbyx+nVtTUik/dIpxYkVCNyTtUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SDhlSqxlU/yFNeFL5dQsO4ZYWaZ7QhC6fH8pd0RpdLIs/6dL2o2q+XTru3L+3Eo9X2yrt8FTplwRte24BhA37sfgrLFQs6rqqykKLeqWH86TyEfTbSFEyqYWQpcv4VZjXTkY0opO8bR09a0rczgqc3N89xReAHaIS/kZGxZ32X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ba/rrUgM; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a599a298990so135978266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715745985; x=1716350785; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+u4pNlcSDf7Fk1kCACrrWSs8MI1xPyfKcfZOZfur+Vc=;
        b=ba/rrUgMqTY3COfZZjp0hpAesSpYB71Oi6ydTUngd4rWDWzhCFGmaNI5K6Bi1nfxmw
         h9KKZY3XlUYkn7IbXDib1H0auNWB2+ZPcVEjKJh39ZUygevs4kXjA/cYkR8QXJMrpGI7
         yPAUe8xfCRBsFcMkkQ9fcCq65dMvLhpUPhDm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715745985; x=1716350785;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+u4pNlcSDf7Fk1kCACrrWSs8MI1xPyfKcfZOZfur+Vc=;
        b=uh63z0FtHcNgKBIVuZBrMNQ+CrIj7mBqmXceQX4kEmJYzQA/Vc2y9jcFaZIUapYYs1
         +vnr5cobFnccj8K64dgoV26UrTr1o44RKMdQBtmXDJEH+pBohdcdBDiWVZSl7oj7vizA
         dbBKE2xcvFjw5z122bxtiOinTA0ZtGNljCM9S+kdUpjZSabJryiYw4n6SoM9vA1PZUXg
         Dg7pRT7FZNbmxKtLjRQK9/WoRWVj/qiuLnEtHt83kY//pFUt40QYQn13SUtfm2cEQV08
         J/nVhc0B8LtSuQqvuf9ZVx41atzcmwd934KItI+WJK17zxKP8a6o8xXPrlLBmBmE7vrj
         ANOA==
X-Forwarded-Encrypted: i=1; AJvYcCVjp24+uZ+xsiyI2uU40W+uycG48cI4cjQMOWdFAP4LrMmHZ3kwNGvuXnM0d7z8VPsbk4ppfqx0dmWZL98GuKJg7CxU+yENQYKQsSDf
X-Gm-Message-State: AOJu0Yzne4hkzBDuCEes8p7cFW5//u0fmHsO07n+YxWdrvhPs0309B+1
	O+ZynTxEvGYRoPw+BbHMsQ7OLckzt+4MWfDEHatlpBaHgR3Zpsc4NDVSAIe+NkpW17Vwg4LOnPy
	p77NVyw==
X-Google-Smtp-Source: AGHT+IEy2poJf/m1YaTz15+Yh3CK6P61XpvRwVewTZ2WyrtDxdA5wjBBmg3kkWW5zEzHAug8bpRx0Q==
X-Received: by 2002:a17:906:f296:b0:a59:c833:d272 with SMTP id a640c23a62f3a-a5a2d5356eamr1048514466b.13.1715745984956;
        Tue, 14 May 2024 21:06:24 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c81b4sm798177566b.113.2024.05.14.21.06.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 21:06:23 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59b49162aeso100259166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:06:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYRaSLTnl6XB6ux1ZrYitl8PWD0TGBB6nYeCnW+TNhMse0ATekrbhS249BUjnW/LeFtkPYRK6BL52fB6gsk3Mk59Aw/q5SRiKkX+q3
X-Received: by 2002:a17:906:7196:b0:a55:5ba7:2889 with SMTP id
 a640c23a62f3a-a5a2d5c9f69mr956803166b.42.1715745983374; Tue, 14 May 2024
 21:06:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514231155.1004295-1-kuba@kernel.org> <CAHk-=wiSiGppp-J25Ww-gN6qgpc7gZRb_cP+dn3Q8_zdntzgYQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiSiGppp-J25Ww-gN6qgpc7gZRb_cP+dn3Q8_zdntzgYQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 14 May 2024 21:06:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2ZJ_YE2CWJ6TXNQoOm+Q6H5LpQNLWmfft+SO21PW5Bg@mail.gmail.com>
Message-ID: <CAHk-=wj2ZJ_YE2CWJ6TXNQoOm+Q6H5LpQNLWmfft+SO21PW5Bg@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.10
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 May 2024 at 20:32, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Why does it do that disgusting
>
>         struct bpf_array *array = container_of(map, struct bpf_array, map);
>         ...
>                 *insn++ = BPF_ALU32_IMM(BPF_AND, BPF_REG_0, array->index_mask);
>
> thing? As far as I can tell, a bpf map can be embedded in many
> different structures, not just that 'bpf_array' thing.

Bah. It still needs to do that array->elem_size, so it's not just the
spectre-v1 code that needs that 'bpf_array' thing.

And the non-percpu case seems to do all the same contortions, so I
don't know why the new percpu array would show issues.

Oh well. I guess the bpf people will figure it out once they come back
from "partying at LSFMM" as you put it.

           Linus

