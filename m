Return-Path: <linux-kernel+bounces-311804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CC7968DE1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 20:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15A61F21978
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 18:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E295D1A3A93;
	Mon,  2 Sep 2024 18:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZiwGOn42"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4C61A3A80
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 18:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725303052; cv=none; b=QmmvpjuPyQzTvopgDtK5+5b1V2XQRaHIrIhYxypM4ehFvsuxxk81/CeiSCRNAp+FDp44RK0jvkJDnGjmeeCVezu99QwuuyaSbayjVav8Zky4L6Sdj4JBiP4LiRtiER2GoBYuoliTaOuASmpGWA4gxaQGGWCTlmNSkZJRF7fNcwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725303052; c=relaxed/simple;
	bh=scnjxMUTBm5lpkFZg2zxbUepcu+Opzuiv8h6z0jluuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+r41JijCD6P1BOo/KxgVB2ubvv1YVnKh3ii7EdEPVO+RW2GLLQqI3SgdUIqo+p+uvb1eljT3JZlL806LqtuV63++h+qHMZzR1L8X+pKX50NW4Xajjzex1NJAmqCM3e7eNZzSpxzaD51xGqumVWaHB0jx99h00vouz4FqR4romc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZiwGOn42; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a869f6ce2b9so493452466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 11:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725303048; x=1725907848; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kHHFr1bSKCjAEvzYH7bbTIeP4nShgQftg0qlBcYnkiI=;
        b=ZiwGOn42zj9V8eZB5cbau4OT1Ho5PD/UHdJOmVh55BioeNU/eYFW9sY0i5zB9/ipiz
         skSGLuvKb4YOsYVECrA81eL6l+uP1EJSjZROQBdf2+aI7wYFdhbZLWoBwl3n6G4Jet2F
         kWN2teFn8xHDiexLDru2BuXzer54mhrUwHcUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725303048; x=1725907848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kHHFr1bSKCjAEvzYH7bbTIeP4nShgQftg0qlBcYnkiI=;
        b=n48c7nibsfldGxoKI5K9MlQNoz4665FmdPCsPV4ukQZr9EsT8aQ5hE1IzbKf1FzAwK
         I92zo0BBF/AoQTuPiW2IpBofS7/iW4yLQ1Mgkjg/L9UhHdiQOSmY3a0PWBYJfu1tQ1Lf
         LffXUKNM25wYeHFl9CnGCQ+GeJBOKvfh2mb92W/eevOsv8OyVSj/c68RsXMyHZ1VEvMV
         gngz5jlb+UxIa5rJrHvXlVJfBr4nhLEWnAKVd6cspcJvnGTHBfO4Ybj3kgOt0xcieGIo
         HQcK7XnYkjnnBThJUysdtJ+VdnJ4AxwewVahI8CCxz3v6T9kezpQqgRdTqUofJBGNFu3
         7nNQ==
X-Gm-Message-State: AOJu0YwmDPkUdnVVuBF5/I73S1cest3wfSIv3GITU0gQkmNiHp2qkLLO
	nRmVVyWOJJlCQxhbwqvglro34MMebQsfUReHmieW3tk/ymIc8dF0D9LENoEQk4PpTqSvaEsYFgB
	5oZI=
X-Google-Smtp-Source: AGHT+IFLY9ZHpmjFFkW8bxqnL+GHnS8AACj1jloM8wK19xLKG4/QmfsOju1z/r9mqr6W6cwNvS/QDQ==
X-Received: by 2002:a17:907:724b:b0:a7a:952b:95b1 with SMTP id a640c23a62f3a-a897f865743mr1001167266b.24.1725303048197;
        Mon, 02 Sep 2024 11:50:48 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d7834sm600527766b.177.2024.09.02.11.50.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 11:50:47 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c245c62362so2033937a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 11:50:47 -0700 (PDT)
X-Received: by 2002:a05:6402:1ecf:b0:5c2:6a7a:5795 with SMTP id
 4fb4d7f45d1cf-5c26a7a625fmr657739a12.6.1725303046725; Mon, 02 Sep 2024
 11:50:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wgumCUwjVkGREh1WwZ2ia5EqSjAQ_4wjUDw3-m0aT7KFA@mail.gmail.com>
 <b9d58888-d94d-41c6-b0c3-19e4598c1bc8@roeck-us.net>
In-Reply-To: <b9d58888-d94d-41c6-b0c3-19e4598c1bc8@roeck-us.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Sep 2024 11:50:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=winf5CvEvEGMUQmEYWFtp9b6YE0+SwhVTB89OpHRS_ZEA@mail.gmail.com>
Message-ID: <CAHk-=winf5CvEvEGMUQmEYWFtp9b6YE0+SwhVTB89OpHRS_ZEA@mail.gmail.com>
Subject: Re: Linux 6.11-rc6
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Sept 2024 at 08:07, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Thanks for merging my fixes branch; that was a bit unexpected.
> Had I known, I would have made sure to collect all signatures.
> I'll do that next time, just in case.

So I'm *hoping* that it was a one-time event and that I wouldn't need
to, and all the regressions would be handled by maintainers in a
timely manner.

But who am I kidding? It will happen again.

I still think that me merging your branch was a sign of our process
not working 100% right, but hey, nothing ever does. So maybe this is
the way to deal with it in the future too.

                      Linus

