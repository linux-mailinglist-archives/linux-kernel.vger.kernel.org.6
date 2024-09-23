Return-Path: <linux-kernel+bounces-336339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB83983981
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 00:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA51C1C20D77
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 22:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F0884A36;
	Mon, 23 Sep 2024 22:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X28GuW5H"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206F614A85
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 22:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727130020; cv=none; b=Ho1SadT3eYNLPcKWUKFUmi4zRzPn3lfOuZ9uXpdz8S8ul2Uv0NxCAeytfDGrYNplBc+NZ7hT5nvnH9ah8DnHb9fXjvWTEt3DFNJwGam4UYUpMWD1doDP82FpBzmB1yOdsHb23d9SNd8EXs1vTzWnw8a/IjDMTshCU0vN+B5mf9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727130020; c=relaxed/simple;
	bh=kMUy2Oxv8jJ2tt5vf/Z5fPJ2UkRaSdByoRrEKHNQ4Cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMANrwPJq50ie1K/jGxi+Yc36IqDytdZGKNLi3cgTzrlzmZvTXQ8fdiFCN6iigU1yL7Sw+rDm1ThyXEvjqAYasqS09cJ2MPBwvj9fFq4zFNzjqA9hpH4sfhse+yWTGZtRkeMJqyrNdMxY1hxKeQLabXyy5a9zUeHxaK/egfWbaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=X28GuW5H; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7a843bef98so656515166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727130016; x=1727734816; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9S42eFJC2cZLzPSDsM30FylP/sErS75QRhGjAktHewM=;
        b=X28GuW5H96rPKiJOJUmPUTfpKpIS0UzhQ9GeXm0JuJjKnN3lB6AWAH/aeHhc74AuXK
         yqQhRaqKL5MG9lYtsrKiP9IwVsfIsNagkZcImHccRjeQ0Bk0bf+seLSSwChOW2oDI4VV
         EdH/2elGIvf3JsHwTDn9j0UJzRvXXu1itINxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727130016; x=1727734816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9S42eFJC2cZLzPSDsM30FylP/sErS75QRhGjAktHewM=;
        b=czj+4513WnaORTzhXf337HBcexO4q3ohRs/FaT6TrmhGw5PCzyDcf9qTJgpL7YqOuN
         TjGvMDeWBZvUNH1COFDmQsSQkImiSqGg6AXpkihsYAfDNtBTKQQglCAVXA8RN4Ps40cT
         SG+XvdipfH+4F0WFGLgTyFl7Uqfy0tI8I6dmrhA11OoRCKgj8u08fJ+ENTa7dyEw1nxi
         SBHTNKVOFB2d+TqjUxvuIWogb43RwbLeAhr20sYwj1j2KR+mVU9kWpsq9rIByqm6mLn+
         P5G72n+whb2pjs3bZdg41S06ZcTA5IAVhufpx1nP3l2/pKPyIKWwqe2KVLQefm9vIbmK
         5dCg==
X-Forwarded-Encrypted: i=1; AJvYcCXFVVU3tzx6C7MEe+IM7sbiaVUFjAIhRv+66x5mUvEzH2cZibsJP7shxyk57wca/I4lOcOsWGFMECE85z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoPB1cKwC+aKIAzHru3lqwf9104GGkp4RL0RYuqQdgFG9DAquY
	yV/6RKuPv16AtI6ZUaR0rHsWny+v2Mz8Ow0emhSN6zxeF+TC56G8yGvd9GWimV2mfBlmsYcRtYn
	+DGYlNw==
X-Google-Smtp-Source: AGHT+IHbaOyP6GS4nfTUuppkl46nt6yAqK/zd9ksViZMpf3hVmvqZC6GqXiq9lwGRLk5MOYwiZdixA==
X-Received: by 2002:a17:907:1b10:b0:a90:5280:8b99 with SMTP id a640c23a62f3a-a90d4fdef82mr1596759466b.3.1727130016194;
        Mon, 23 Sep 2024 15:20:16 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930cafa5sm7385566b.111.2024.09.23.15.20.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 15:20:15 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8d64b27c45so896370166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:20:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXL96Y6nUVbS1Op38m1rUCBF5M6uhTbDTS8V71889/Eobmgz15DUMZExyJ4Sf5I+jyzfqbcCXVoiMsMvKw=@vger.kernel.org
X-Received: by 2002:a17:907:e262:b0:a8a:5ff9:bcd1 with SMTP id
 a640c23a62f3a-a90d4ffda13mr1222335466b.21.1727130014805; Mon, 23 Sep 2024
 15:20:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923182958.818256-1-sboyd@kernel.org>
In-Reply-To: <20240923182958.818256-1-sboyd@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Sep 2024 15:19:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjquWwsrEhcJQ1r3nyp_yDbgptuaG1GSmb0WSa5dcPHdA@mail.gmail.com>
Message-ID: <CAHk-=wjquWwsrEhcJQ1r3nyp_yDbgptuaG1GSmb0WSa5dcPHdA@mail.gmail.com>
Subject: Re: [GIT PULL] clk changes for the merge window
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Sept 2024 at 11:30, Stephen Boyd <sboyd@kernel.org> wrote:
>
> The following changes since commit 997daa8de64ccbb4dc68d250510893597d485de4:
>
> New Drivers:
>  - Camera, display and GPU clocks on Qualcomm SM4450
>  - Camera clocks on Qualcomm SM8150
>  - Rockchip rk3576 clks
>  - Microchip SAM9X7 clks
>  - Renesas RZ/V2H(P) (R9A09G057) clks

Ok, that's useful information.

But Christ, people:

> Updates:
>  - Mark a bunch of struct freq_tbl const to reduce .data usage
[..]
>  - Drop the Qualcomm SM8150 gcc_cpuss_ahb_clk_src
[..]
>  - Constify some Amlogic structs
[..]

This was 65 lines of unnecessary noise.

The merge message is supposed to be an *overview* of the changes. Not
listing every little change that nobody cares about one by one.

Please edit it down to something reasonable, and something that gives
a useful idea of what is up. And sometimes that is just "lots of
driver cleanups".

IOW, try to distill the *meaningful* parts from the detail noise.

               Linus

