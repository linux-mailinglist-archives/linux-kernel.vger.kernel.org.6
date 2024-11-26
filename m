Return-Path: <linux-kernel+bounces-422901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF9F9D9FB1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 00:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6965B1663B3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 23:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4623D1DFE23;
	Tue, 26 Nov 2024 23:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UulNPFtX"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928131DF992
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 23:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732664012; cv=none; b=GQseKg3qKEsQOg56GSTwL7a1F/kbahRxzzqUPn1h6ZP9q06d+cxTZLZvwiNJ9wE6KLtL5GTkNpp5SuId0oNAx0zwH3BNwuuFGjeL3RR8AN2AkSKFTOUehtr93MtqaLG0oUs36VE5p1RLEID3de8U6zxobF29sLBFbuKBBmsXxBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732664012; c=relaxed/simple;
	bh=6T91vbcoefGNJCw9c0uoZWNFJ/ID0VtTnKcS/ejrjyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kbizWbFe4NOWgBDRzI0TVSXJWFAbyFlfSMNRaLOJgJMTnYq7rOx6i0BcEXtcNgxWqOL7LE9eR6BtyhcCA5AMh510ySFKG9ef40gtprNkUccvt6zN9zb36CwYzFeFbswWWLOIvWpR7NryZRRd5kEmsW8mXXcEAxeIqeUIHGuDtUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UulNPFtX; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cece886771so524139a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 15:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732664009; x=1733268809; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bLwSUJtOTgfC8HrzNmFuxmXt+8eehSMuWV07yWPRKKU=;
        b=UulNPFtXJzwUa8F+5njRis2LsjRzVtTXk+YxneS9IwWPBGdughMNj8coJhlUj2rxTE
         bXsS+g4qNy6xSkSuT5P9phPsgBKOmWwOQbo29p1n/Wmjy9ExgKaRy/JFe3Fjs+7LRu9v
         Zx7V79RN48Wbt0NEq6Mm6qyRlyoKTXVNmcU6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732664009; x=1733268809;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bLwSUJtOTgfC8HrzNmFuxmXt+8eehSMuWV07yWPRKKU=;
        b=awOVZeKaKJHof2B503EaGZugkqMdmjsl4bYxNHH7PaP6Elx9gD2llCCYVES7EZkJHB
         uoo84bfcwx8mqkX+dKm/4/X5WrhHOhFp3wAeGg5B1YWGYo3BfvtHp8kD8wiWklWumO7N
         gm8+SogUdWA82RmpuEfRg+qFYRnHsilJuyFzus34reZSkuwxVl3pNV+zc0Hsgc4T3QoN
         uoA0rWUnhLWpr8CiiJN5Pdgj4ab2dCA1tQPHjEonF7Pxd42UoqhJ/uyin8FSJ2g942cY
         1yQS69bT3XMOJKeLQMIsPF6u5l85YXVD9oDbb7JlkDjttBdhKiJ2+K/8XqHoPtES+S15
         2+UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEucicD4BnHPZDRdEHbsC9HwqZFdt59qQAashwAxpB3sopkGZ42Mgx9EC11XevaqktZsiRamIUf981dSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwloIaCO3GMEStvEUjdvo5REjzsZsobhF+5xwwRCFGjehN2ESXw
	QNBnECSyi6Bb7sI09qqDDeeTe2SdTw63Ika3nIFxI+FTi8gm24ByMx9Ply7cp2xftlfnMU2+1uG
	XL1gJLw==
X-Gm-Gg: ASbGnctrYToKXRfP36TNy0FSEimsd/dh11scKNDdWlSUgN+aruQ5lFw7sdKssHEcsZS
	SXDcojVSP7AvTcsjtWjDd+DmhKoppQDFRtkl0dTscgtKM0XJJVfjxtFMFhPVtDeV6Yp8mO9E1vQ
	yTe6FNNsWSLrt81sETitM//SOi8SL9wuKC0TJ9t2aGH3yLj6E0y+FSq7MRg5utavxl8OP7fEjcP
	eKWzK5So62HRx4XjV5t/7qP2FPyOcraC2JdRcjNw/b+vex6rkLejl/fb+c8h6FdjcWgefnno1bA
	ULxBV12XqbUZh/j+MS+T9feL
X-Google-Smtp-Source: AGHT+IF2EXZvH3tfX4XPqMvbDb8UccqCC9rJwqdae4gMbyjSeX7NNnueHfZ8p7k71+x0UtLmbs6zkg==
X-Received: by 2002:a05:6402:2546:b0:5d0:7282:6f25 with SMTP id 4fb4d7f45d1cf-5d080bc7bd3mr1014455a12.6.1732664008730;
        Tue, 26 Nov 2024 15:33:28 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3fc658sm5497657a12.71.2024.11.26.15.33.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 15:33:27 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cf9ef18ae9so439006a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 15:33:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXowwS9OYbO+XujW5yToAtSkWigiOCv7AOe+bYjytyE/GQDKbaZAUsDCJxXT9GpfODOiCMWFCDcbd7wI8o=@vger.kernel.org
X-Received: by 2002:a17:907:9409:b0:aa5:2e71:3727 with SMTP id
 a640c23a62f3a-aa564970687mr514064866b.21.1732664006733; Tue, 26 Nov 2024
 15:33:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125071653.1350621-1-namhyung@kernel.org>
In-Reply-To: <20241125071653.1350621-1-namhyung@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 26 Nov 2024 15:33:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=whQ_yeRDh_zZjhz-4q8G=vu5Ypb-Y3f=efHQSwd5Kas3w@mail.gmail.com>
Message-ID: <CAHk-=whQ_yeRDh_zZjhz-4q8G=vu5Ypb-Y3f=efHQSwd5Kas3w@mail.gmail.com>
Subject: Re: [GIT PULL] perf-tools changes for v6.13
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Nov 2024 at 23:17, Namhyung Kim <namhyung@kernel.org> wrote:
>
> Please consider pulling the following changes in perf tools for v6.13.

Hmm. Has the default search path for the vmlinux image changed?

Doing profiling with this, I get

    openat(AT_FDCWD, "vmlinux", O_RDONLY)   = 5

which is very very wrong for my kernel build - it basically picks up
the vmlinux image from the build directory, which has absolutely
*nothign* to do with the image that is being run at the moment.

So now I need to point "perf report" at the actual image, which I
didn't need to do before.

            Linus

