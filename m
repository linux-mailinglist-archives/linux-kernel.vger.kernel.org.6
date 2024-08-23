Return-Path: <linux-kernel+bounces-298090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA3B95C1EF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 02:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98E11F241F9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 00:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B23A2A;
	Fri, 23 Aug 2024 00:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gMxmBpXG"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54138197
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 00:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724371566; cv=none; b=XXpc7MOw9Sc3VJPs8b0zxiWVE3R0UoRRU3CSKGJlglX/QB+FONYsIY9sw7HPyXWFBzx3yiJXOoaLqo8qYzaZTo+UwIyTnFH3ts41d9JIRRD9aG1nLwAqRMaWmV0X7kuShGlh7drNGAGXGbqp3fapcQzECWf5wf/3jnmNE5wdeSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724371566; c=relaxed/simple;
	bh=4iv64pRtCw7dW8hTYbxzB/BoF83GDOhTtw/b5ukR+O0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c6p+g7qtwxxIKhZg2k0NQjtXewiwPh29K95iF4oI2nuY9OK9oEDZSlwJ6eaCJZywzgIHTrfllepIRBJMC30JH6sSFl9U8X8RsR+aTd/ES/2D9V0HxQ18Z8ggo+7gakmTcQDAknkrlsCOhcRA6LcXHafApDhuXs0iw4KpkA6+uIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gMxmBpXG; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5334c4cc17fso1922704e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724371561; x=1724976361; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G2PT7YMor9FcgwOjC3cZXMnMxjtj8zbdFSuetCOJ+xA=;
        b=gMxmBpXGsZMhwERbfNd37JAcsZCeOUu1mxqS7VWbQjHvugFXYZJccq9uq033IU379u
         dk7f+SeDbzTy5nTv9sok7ewsT6RXv6iEOcRam2BZrvLao/iki5TSN6ajcII+leqn4/5z
         zGzAie9XQUsbAsKjVQ1ajb1dgLwrQ98vm/DvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724371561; x=1724976361;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2PT7YMor9FcgwOjC3cZXMnMxjtj8zbdFSuetCOJ+xA=;
        b=Py5zHvqbTD3Ms9OAB0x+fioO4IGrk12uB8hDHHHiZ74q5rfvDNXU/gyRW6uqh0+l50
         57gepajP6mlXas0pqrRVhHb+pZHhp04X5qpOMu/sZdhMrHVPeh67WRsvinvNrdwKNn5n
         hoHq8klek/91kM5KG3lNc6tmTLuBqD4VTmA4AZSCjWe7eo6gpnZJqpJ13NNmKGwkKfgY
         r5QmLbb4kMzaEQ2aEKo7AS07yEbTXj5wKgHwJk0VYntmY3LVIEElnvLrOUymzbdgZo2z
         tW5EdVC9mYiJQNX/NbB09ny02p3i110D0rNX0pLXKBRszXJqU9wgjbgPY2eeRuDTgFQE
         psQg==
X-Forwarded-Encrypted: i=1; AJvYcCW277aLIx4lVyYKFdHu8SuPiZtMVXnLdG2t8yyYb0Tjp/lJz9HNZgNq5ITq/QuKMz2uiaeopLizpTJ/mtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkyUei1Ksdqrnauim67kzQsYmuybyq047C9HeZTc/CGi8QmsyF
	R0YOkiMgzYqK4ScwWqjRrtwkeioKvHHqugqd2KTxraMusxV/KxEh8gl0BvlNecemk/A7YIZL/BA
	Yo1i6qA==
X-Google-Smtp-Source: AGHT+IGyaEO2A7wWmb2GqMTLV9APhC9z7OzG0DwE8IU3ci51tOYbzqFzJnoC1AMzOHDXj98E6js73Q==
X-Received: by 2002:a05:6512:281c:b0:533:97b:e272 with SMTP id 2adb3069b0e04-534387babcemr260984e87.41.1724371560691;
        Thu, 22 Aug 2024 17:06:00 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4360c0sm179323266b.108.2024.08.22.17.06.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 17:06:00 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bec78c3f85so1766727a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:06:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZtuK56DE0m/Flzkbc0GYOGl3dLP9Xe3iFIJ5ilDNSDCoTzQwCexM31RUMVsx5jPuFc8wpDgoTX4/oKtQ=@vger.kernel.org
X-Received: by 2002:aa7:c68e:0:b0:5bf:17f:4b7b with SMTP id
 4fb4d7f45d1cf-5c0891b21aemr159924a12.32.1724371559743; Thu, 22 Aug 2024
 17:05:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822131542.785546-1-mjguzik@gmail.com>
In-Reply-To: <20240822131542.785546-1-mjguzik@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 23 Aug 2024 08:05:43 +0800
X-Gmail-Original-Message-ID: <CAHk-=wj-UanKTT-NZKLVjK3mgQsC0Ptv8mK8AM7LfZhj2dVCUA@mail.gmail.com>
Message-ID: <CAHk-=wj-UanKTT-NZKLVjK3mgQsC0Ptv8mK8AM7LfZhj2dVCUA@mail.gmail.com>
Subject: Re: [RESEND PATCH] cred: separate the refcount from frequently read fields
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: paul@paul-moore.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 21:15, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> The refcount shares the cacheline with uid, gid and other frequently
> read fields.

So moving the refcount around looks sensible, but I don't see why you
moved 'non_rcu' away from the rcu head union.

Isn't 'non_rcu' accessed exactly when the refcount is accessed too? So
putting it in the same cacheline with ->usage would seem to make
sense, and you literally moved the RCU head there.

Why not move it as a union, and keep the non-rcu bit with the RCU head?

Yes, it is rarely actually written to and as such can be "mostly
read-only", but since it is both read and written next to refcounts,
why do that?

Did I miss some common use?

               Linus

