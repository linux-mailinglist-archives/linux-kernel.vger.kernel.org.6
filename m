Return-Path: <linux-kernel+bounces-409789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03529C91A1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81C132837CA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCD719645C;
	Thu, 14 Nov 2024 18:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DvHfA7Dq"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ACC18BB82
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731608903; cv=none; b=L7GxFK/jjrxBcVvu30DQBGPDvKHF/yW5u1zTW3mOwlGXFdIvJuNeFxNyufNWHjKS7kvqmJqqhPkBjllOYM/RizcB9cyweBCjw8ALnKniCde1/OSb/u6WAKl7ojB/y9kq1A1JMzc6DARSno0wQk5zUzS1KVXZJ4vaXtS5evUD1Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731608903; c=relaxed/simple;
	bh=KCc0gSJuw6M6GZeBy+cbkCwwo7HpbQ8dLEdU98bWO6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PbNSWf+8r33j81RZ9i3GbUUXpiF08wms9FlC5F6SDsXN2PusGxl4/5BhM7y4urLIAjwsuN66Ae+v5sjDl9BP5gE8nPwARlPJlx1AexmPus3+/sH/esmsM9koCGI3RXnxPYkYIO4VigZihP8/03J2+6tUAzFEpqCkedrkk6/tvTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DvHfA7Dq; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso132708266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 10:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731608900; x=1732213700; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DaqaoJAF7E7zv6sqRicq9V7Po6v7/UVcqTEzLTnHU3M=;
        b=DvHfA7DqYC2scy1u+OFbr0McJwUi7JJcahySZIHRd/Rs3biVZWbOle5Movg7TAUoVM
         NQwyhqVIaEjpimJ5GVth0xakvuslR9qH8kzFjMX5hcqD83ESQuR9b8EMPWS8NsdMRjTU
         hYsnS6WzblI5GWWLsnoICxPGr8QaLXUyc6Sks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731608900; x=1732213700;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DaqaoJAF7E7zv6sqRicq9V7Po6v7/UVcqTEzLTnHU3M=;
        b=Smo3h6VOiDhtI8ZokcNe0uMMyN2g+VANPNXHTJnq0EeF1u1BaT96nn/dVz2UMGf/j1
         VZORDL7qoBCEJoOF9evMzxVGNqNngAB1aPMWqx/CW+JlcaDCuA6HFbqaiE6WlSCb9y4r
         xALwXaTogn6NV2PTd9W4m4S+GvClVeMZa7qPfIZYcaBesyhsTWfgOEEXHV9uuhqoHlTr
         tLXUw6idadpk0LBUgacLU+tDVgfna3GUem0gSs31/fkpnUCnjxcbdrmDz94RoD+XYd+o
         Z+nYhZyq+d3KILqtnkrwRnTgGmvC9s/EtNkSWWif5UKR1+bh4AzZmtrv97VtHFsLqhui
         qmKw==
X-Forwarded-Encrypted: i=1; AJvYcCU8o+XN0mLGEJ4ttI24nQBWJqrqv5EWqej3YiLvEGl9v+LKGJjCxciyJvCZvMKviqKpUGCLaWgXWbKWAEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx13vSjuiW/RWQNA7mP6cIHRp5sxVxiqbyMHYazTeF7XThYuJzW
	y2HQsVYIDUPORdsGjDLcGjPbkZM0MJQqOCR7u00SwTtQwuPRIAzMQyk4WAMoOpRUdP0KfudvsNN
	zgFpKRQ==
X-Google-Smtp-Source: AGHT+IFsj+BgS9qiFs26+8aY1jSetxuJzB89ykztIlHzMLUTtYSjxbAUJkYyGV3ovFexLu6YnZEp5Q==
X-Received: by 2002:a17:906:6a10:b0:a9a:bbcc:5092 with SMTP id a640c23a62f3a-aa1f810639emr734782266b.39.1731608899633;
        Thu, 14 Nov 2024 10:28:19 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df26fc4sm89745266b.12.2024.11.14.10.28.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 10:28:18 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso151472366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 10:28:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX34KH0yiPyOr/ZaVvSuuZqqTN+9hfZaUiRyQ6iWyNi+rT3rXN9llrnaHYF1kneQ2vJGDwogTLxf5NCxeE=@vger.kernel.org
X-Received: by 2002:a17:906:6a29:b0:a9a:1437:3175 with SMTP id
 a640c23a62f3a-aa1f813b795mr748535666b.51.1731608898491; Thu, 14 Nov 2024
 10:28:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114101402.156397-1-philipp.reisner@linbit.com>
 <20241114101402.156397-2-philipp.reisner@linbit.com> <CAHk-=wgn=e3gD=tty+p1o8HBy7qxBCgCHiDEd5+FMtn9jdwd2g@mail.gmail.com>
In-Reply-To: <CAHk-=wgn=e3gD=tty+p1o8HBy7qxBCgCHiDEd5+FMtn9jdwd2g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Nov 2024 10:28:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjLSEcZ5LdW+3C+9rtjvNPHZT6zdk0POj67T5k2ZpDbgA@mail.gmail.com>
Message-ID: <CAHk-=wjLSEcZ5LdW+3C+9rtjvNPHZT6zdk0POj67T5k2ZpDbgA@mail.gmail.com>
Subject: Re: [PATCH 1/1] compiler.h: Add missing include statement for build_bug.h
To: Philipp Reisner <philipp.reisner@linbit.com>, Kees Cook <keescook@chromium.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Nov 2024 at 09:42, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I think a better fix would be to not use BUILD_BUG_ON_ZERO() at all,
> but just use _Static_assert() directly here, to make
> <linux/compiler.h> be more self-sufficient.

Damn. We can't do that, because we typically use this in contexts that
require us to return zero (because the assertion part of an
expression), and then that whole expression needs to be a constant
integer expression.

And because _Static_assert() isn't an expression, we'd need to wrap it
with a statement expression or something.

And *hat* we can't do in arbitrary contexts.

Grr. I absolutely detest how bad the standard tools are. It's kind of
sad how we need to build our own hacky BUILD_BUG_ON() to do this.

There's probably some trick I'm missing, but yeah, it looks like we
need our BUILD_BUG_ON_ZERO() thing with that crazy bitfield hack.

                           Linus

