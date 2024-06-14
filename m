Return-Path: <linux-kernel+bounces-215228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC7D909009
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 336F01F22898
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7A316F0D1;
	Fri, 14 Jun 2024 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hvP70R8Q"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6252116D4FC
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382126; cv=none; b=AXJSmH4aR+y8Wk7UTfGFo4+Nnm+69eoigJrqaB9vGvR3hBR4FcM1cxg7effKC8Q0DCuXUCVTXhKs1C6UR1nGzpE/X+WWOCejluo1e3HMk5zf4uAovwUAjjoIJxQc+xcOze3rbosgbDjkDaLagJrFEqmEJuw9cZerI6ZqX+Mpn2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382126; c=relaxed/simple;
	bh=G2rYSLJPNHleJbSS9VWXp8bNWC33cYg3vroTfpYKgzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TY3OzaK283C2p/y7ZNcm07coeJ9DsylhsODG50Y2AflxYb54cN3RfG9ghXDidQ3bKDab83PixYIeO5jd8+OAstTSqlml3H+2PDMG950GRq4W82oTr2nNBsQRkRgseySVJRYkjcOStx2qtOQsyGHCrgXjyPBUOol2T2Sjve+uLAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hvP70R8Q; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6f176c5c10so291537666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 09:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718382122; x=1718986922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=307WA05poQdKSmwHQchgPVIxFWT4GF9NFWhPoKqw/Q0=;
        b=hvP70R8QI2oVfNvyemxf/NZ6LKG9bf1+L1XFEXCZ6dOkamEPIF4SDU/mGkE8OfUohu
         Ksd3nKdvySV+hxM57kwE8oTABduqyhlknmBO12MGyQAMCHsi0DAnDOWS6QQgRGWhzS/9
         mJq5QRjVolCzmPn9TsKnw08AN2FocOHtd6Kj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718382122; x=1718986922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=307WA05poQdKSmwHQchgPVIxFWT4GF9NFWhPoKqw/Q0=;
        b=FZBe/DZLr3t38txQ3CbLPP7JCYxt99gKopbbmFBA7VDhXdLgGsD+N6ydJSOjAvs3PP
         swYFedb7jaq5wD8k36Fymde1/fq7QwFo7iEtSy3cMbN+J1+HY0EB1Sydy5tlcHgFk9J0
         +b1s6lSKNX3882mj4S2eiLlxh5j2E0XUipfExs6RpKIR394m1bFyfTFtwEcl64Ny1T1c
         4G/7xdxfv1Q4L1Jzia5KdUF0oDi+p7yXYUuxmO7H4mAopcRD0ZQar4SAAEH7RTNyiv6F
         efjM/f+GEEadwnFJsboo06uDQxip9kPofM/GbNb88OdUbRursKO3ndqpJnNpv0iH0+zs
         /VwQ==
X-Gm-Message-State: AOJu0YxWHrT61oFfpvbIqxzufcP7HgcW0UmQxKUeMh671KnAkwHXPe64
	HEjM1knJzgu1TbTusX6wEj8pFwOcJlfs1nlHQK9MCtcNrsrRy9joqyCt12keNodtTKmkMmihCfB
	pe1+6Ag==
X-Google-Smtp-Source: AGHT+IFXdJfmAN7nAlTJa4QUm52tJkp3H4Ug8FGsTebkOdfNfjgq4cmSbJmFEq0n029ZJvZGlCtmEA==
X-Received: by 2002:a17:906:48d:b0:a6f:5fa8:1b7 with SMTP id a640c23a62f3a-a6f60cf333amr219397566b.15.1718382122352;
        Fri, 14 Jun 2024 09:22:02 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f416dfsm199522466b.164.2024.06.14.09.22.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 09:22:01 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57ca578ce8dso2813883a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 09:22:01 -0700 (PDT)
X-Received: by 2002:a05:6402:520d:b0:57c:c166:ba6 with SMTP id
 4fb4d7f45d1cf-57cc1660fc5mr2095600a12.19.1718382121390; Fri, 14 Jun 2024
 09:22:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjQv_CSPzhjOMoOjGO3FmuHe5hzm6Ds69zZSFPa4PeuCA@mail.gmail.com>
 <ZmrTZozoi0t/tuva@duo.ucw.cz> <CAHk-=wjqHL7KjOWYBVKFewcKPWL7CJxddWfJnvL3AfOqfR8vMg@mail.gmail.com>
 <ZmwHGviv/6J6FQLf@duo.ucw.cz>
In-Reply-To: <ZmwHGviv/6J6FQLf@duo.ucw.cz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 14 Jun 2024 09:21:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wigB-wVK+4=NuYJxoKLnoUXB52J5WU2hpKj2de6vGuY7g@mail.gmail.com>
Message-ID: <CAHk-=wigB-wVK+4=NuYJxoKLnoUXB52J5WU2hpKj2de6vGuY7g@mail.gmail.com>
Subject: Re: Linux 6.10-rc1
To: Pavel Machek <pavel@ucw.cz>, Dave Airlie <airlied@gmail.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	intel-gfx <intel-gfx@lists.freedesktop.org>, 
	dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Jun 2024 at 02:02, Pavel Machek <pavel@ucw.cz> wrote:
>
> If I can get at least basic metric on the gpu (%idle? which process
> use how much time?), it might be feasible. Is there tool similar for
> top?

Let's bring in the actual gpu people.. Dave/Jani/others - does any of
this sound familiar? Pavel says things have gotten much slower in
6.10: "something was very wrong with the performance, likely to do
with graphics"

To bisect it, he'd need some way to judge it reasonably well and
without too much of a bias.

See

   https://lore.kernel.org/all/ZmrTZozoi0t%2Ftuva@duo.ucw.cz/

for the original report.

Thinkpad X220 - which I assume means old intel integrated GPU - at
least one listing I found for that thing is  i5-2430M, with "Intel=C2=AE HD
Graphics 3000".

                  Linus

