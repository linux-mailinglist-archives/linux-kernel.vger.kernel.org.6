Return-Path: <linux-kernel+bounces-565095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86829A660BE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BDE43B5A17
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 21:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61BD203705;
	Mon, 17 Mar 2025 21:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IRGyhp6E"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB371FECD3
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 21:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742247611; cv=none; b=I4UNEviHdbVF3VXtl3VLuKwxXoJY6FkvZpkfaW+qibPdbgwz0iZCMJwNQ+kqFY7AxXcn0lTH7m8i+REDyBRnoVWWMMHzm4bpJqZNn7pep8nydli2FIUEPO8c5QYouuvQHOdp6iR/ortLqfaZvWfmwKE/UTx1UhQpPq8HmzUP0ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742247611; c=relaxed/simple;
	bh=bUEAtvQR5s2tX3GyZhMpQWue2ZNVBU7uYcJVngm+jJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ffeg1nv64wgoJvlvnfs8t8Q800Vwf9IQP2eJWp8A1BLk++3nc5sdb5JekbImdK+qUmJFDYeYa/UZHvqhTr1BDbHHA96dPwB8NGl4xkyBc5hU/CSyMvgm5vBPVCLypJuo1n71LAdgseVWsAGx5VJcKC/tiTBBzq6gnB/iB0++oto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IRGyhp6E; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e46ebe19489so4084526276.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742247608; x=1742852408; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rml2EJIC6CXg96fja+IWIHQfO9nBY/Zlsy5OuUWhstM=;
        b=IRGyhp6EsgTcj4NstBxwx3EDc3YNSyFZZ7iuRV2HZ3ZC+oA5oVpQIoSv/7A3ET663b
         XQhGFOYCIWMXwPwbxGxe1LPx8RT2TR7roLamBcaJQOAokDsbbyJkTRE7n8EXB8m0qT+A
         uvieAQmfZtgHGMJ4QFmfkn3CG6qEIe3KZGZ1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742247608; x=1742852408;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rml2EJIC6CXg96fja+IWIHQfO9nBY/Zlsy5OuUWhstM=;
        b=sNjvBoQdfUrbCUOX0M60fJHLBuuZlqkT5xsvfnZXH3YkbvlkHMdHRthn/m+Euawjw0
         OB9PGEnBi/KUPJ5/OMWVCrpS0db7W/tcWi4Y4AuE4w8GGCboVMYqMcvTNXTkwxkCy9UH
         zIU+wAcYkSmvwfc+M36oqSvb8AiyRon2Wqy51WnFBzqiH1YaXbyJsjKs8rFWnJke5mDN
         /Id94dwfdkWgPsZrzV7IF2zKAbAbCQIRR7izsGYcuhu/nxvcYbieprWSToa7rCAMDAnV
         GFzbGiM78flarIUyfq/aRxO/kDadISEjo0IEX8WBOpJkG96nocSe5y/AihGyaeKUd90j
         0O6Q==
X-Gm-Message-State: AOJu0Yxy5j8+ZTjFquG9zY4HPDcGUWi7IK9tEo9JmMdPHvdxYuBkvLJD
	zPO+OPDC583e7pNhfrMYTE9150BZa+x5+GomOU2VYf+MqKabOD8vYMnbtxUubPtTDhwaQYAGbo9
	WXhg5XZ3bgdsdF9j/KdBloQQyy/ts7RmRK94fRQ==
X-Gm-Gg: ASbGnctyRgHWyYk5+5UM0+96kV6Gdbjj/WD32vJdaEa/DbaceXhNff4OarpUVoHeEs6
	rrhBzhZ3wOFO7c4BicrnlElFBYoWpTYUXmFTYZ2RZqA7ddIJ2SfL+KBaHDuj06LIF5/XzrDNMoR
	a6qmb6vnUXhpK32Rmkc+qT2POhHm/57jsTCNwidjyF7oM9heN44afXovwn1p4aSLkKAsu+Zg==
X-Google-Smtp-Source: AGHT+IFUN5zUrLCWX13itNLXJewnRfEmZtsIyRWbAYYyUB99mOpyjGSH9HfjiMipJpIMIzhmSwL0i2TiDwBDgfg491s=
X-Received: by 2002:a25:7dc6:0:b0:e64:e91:d36a with SMTP id
 3f1490d57ef6-e640e924914mr9441045276.33.1742247607854; Mon, 17 Mar 2025
 14:40:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317104257.3496611-1-mingo@kernel.org>
In-Reply-To: <20250317104257.3496611-1-mingo@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 17 Mar 2025 14:39:57 -0700
X-Gm-Features: AQ5f1JoYwHgAypBWEM8ojoiPyxd4l2IRARWTsh79MJlbs9vuvJDqvua1Oy-rAR4
Message-ID: <CAADWXX_Fce0AFDS67OzNQaH0TtqEi=6-MsMO346wXzGSRcdiWQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] sched: Make CONFIG_SCHED_DEBUG features unconditional
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, 
	Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Ingo, please fix your mail setup..

These were all in my spam-box, because you used

    From: Ingo Molnar <mingo@kernel.org>

but sent it using gmail, so the DKIM signature looks like

    DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; [...]

and then that results in

       dmarc=fail (p=QUARANTINE sp=QUARANTINE dis=QUARANTINE)
header.from=kernel.org;

because the DKIM signature - while a valid signature for gmail - does
not match the kernel.org signature.

So you need to use 'mail.kernel.org' to send the email to get the
right signature, as documented in

    https://korg.docs.kernel.org/mail.html

otherwise any sane setup will mark all those things as spam.

              Linus

