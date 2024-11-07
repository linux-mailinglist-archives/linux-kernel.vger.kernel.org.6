Return-Path: <linux-kernel+bounces-400390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E88159C0CD8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69513B22729
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B519C21620D;
	Thu,  7 Nov 2024 17:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gxzwkbqg"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1178DDBE
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 17:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731000564; cv=none; b=rUBFYO6xDj68XbU1A3aNVrg+h2n297ESb5BNdhP0nAo5j3NpdItp6mAMLcwIAGqmW+w6tWBMpzXA/EYrjtZTZbb+7BwBmY+oM6ry8HGmFtN8GUndyE9db1CKNXdFJAME0uIuAzaTuPMRIp8e61FfxAypt6tinZuW/ndp7wVeAJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731000564; c=relaxed/simple;
	bh=GLhZ5IsmgwaX7xwyGAImLOlKHAH8HMGdBhfDUIuPfdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qs9pOkdd45+5WXgmD5qMhtxDSvLZ/pXdvEiR7YQjprqHgQOb1+g7EoVuQJ2uHIMg5ot+xF2pTpzALZqwIY8c/i9xOVvn8x/RJl2CzeokfXkilz7UjcEmxL9PL0/2b9KCIKkIwWgw3tcin8Yl+pyhgFIlh5x1ecjqtIt1tRCV1Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gxzwkbqg; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7f3f184985bso939906a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 09:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731000562; x=1731605362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLhZ5IsmgwaX7xwyGAImLOlKHAH8HMGdBhfDUIuPfdY=;
        b=GxzwkbqgF2uTcNa1DeUg/OtrLqEYBp46pXT/omilwqcNvriMlRQUWvoP9vCTsC5rEr
         l6jqMXIRY6KQ/T0SE0F6cLTSp9bNZV6lBo99KwbjUpKM5XuJFM7sTzWnN3oa1OFJRiNF
         4YILlM2My2YOUXPpPGvb8wZLdu8KHnHqmQ2FGjz6bdBpBMLRv25iSMUAtaOIzoF4U1yc
         EJLsgtNcULKM8iKv2PdV+P10f9lNQwtam/p5aJ1AXQKYGcPnWdwFm3jimAzyrqvg4yLB
         DQ3WcP0g1Q9Jdg4KjW6Q2hz96QI2neNLnNZIIBpqm4zuP3//4zEUQXHRFGPvE0lwbnFI
         ilvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731000562; x=1731605362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLhZ5IsmgwaX7xwyGAImLOlKHAH8HMGdBhfDUIuPfdY=;
        b=N2RdLfFHMYB+XKGjAsvnygIAKOMais2jieIlTdqPn110RiaLpF8vSYTx4tjb+yRF+J
         NCQmgz5mz69IWjpW8xjzSbiHCQclalhwGUkTAOkFffK/6uk9aUA/NKpwXuYb0Tdhw6Xt
         k4huDwacIYQ7V8Dazk9std/24tzgTERyImstS0c8O0IU/agS1Jo3NXeem5VhHPC34G8+
         ym6s++QjXxU9BAAoEQEPH8Dst0v1fkNKwYBctNlsF/NG0USfiAESYiHkdCGaceloHEzx
         bRp5QEVaOPR+l1GKemmnQmlE769myGkGhY36lRWPnPQIqY1qXLHE1nA1iRce80CLBYOC
         fXzQ==
X-Gm-Message-State: AOJu0YxeipHK2d3bzXYXKA3KW7B7LUJc6eB4DL4avArnoBEuHq9RgJ1/
	EhWWCSUzMKsPhMN3GSL+H8qbu5YcietRQNjbzGoJ9JjXulV/BvKZ+UsecBxMkJr8JWI2qXlJZFa
	V9M/o//hStTguYOKEwMn2wzasFMs=
X-Google-Smtp-Source: AGHT+IGkBkyjC0D8UPk1uZJC9YSuqP3z1kMcZD2n3wHUMqDe55S56nr0cbOcmGMgT4Q31VwH1PLmZsVVvK2SDgFPUHI=
X-Received: by 2002:a17:90b:2dc5:b0:2e2:e31a:220e with SMTP id
 98e67ed59e1d1-2e9b13e90a7mr75394a91.8.1731000562022; Thu, 07 Nov 2024
 09:29:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918031537.588965-1-masahiroy@kernel.org> <CAK7LNAQjKNrAK8ffZiz7qOKRFcUqQds5bMjdOXKPd0gedzhjYw@mail.gmail.com>
In-Reply-To: <CAK7LNAQjKNrAK8ffZiz7qOKRFcUqQds5bMjdOXKPd0gedzhjYw@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 7 Nov 2024 09:29:19 -0800
Message-ID: <CAMo8BfJG9EPAoLqPRwq8DNvMOy9Q0BOYcZ8fV4W5f+B7X9bqOQ@mail.gmail.com>
Subject: Re: [PATCH] xtensa: annotate dtb_start variable as static __initdata
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, Chris Zankel <chris@zankel.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 8:51=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> On Wed, Sep 18, 2024 at 12:15=E2=80=AFPM Masahiro Yamada <masahiroy@kerne=
l.org> wrote:
> >
> > The 'dtb_start' variable is only used within arch/xtensa/kernel/setup.c=
.
> > Mark it as 'static'.
> >
> > It is only used by parse_tag_fdt() and init_arch(), both of which are
> > annotated as __init. Therefore, dtb_start can be annotated as __initdat=
a,
> > so it will discarded after boot.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
>
> Ping?

Thanks. Applied to my xtensa tree.

-- Max

