Return-Path: <linux-kernel+bounces-429835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DBE9E2B5A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21A40B35463
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097A01F8AC4;
	Tue,  3 Dec 2024 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="H6o9CfyY"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD4B1F7093
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733243047; cv=none; b=D087N3lh6/kfsTdDLTZOM4eHxPne8tHDVEjxCXcRAQTEWCgxG/gf9ddSeVJxbXH4O0T8JZ1zGNJiL0vJa4S7B4U0HDc9OtDfBv9OYDfGG2Ekjew1pSiPifGeMgvGlbFMxXLpkH6bIwYXHPXrt47F5ZBR1wgJ0BfZxyBzcGyG7h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733243047; c=relaxed/simple;
	bh=f+P/kAbB1gWGPCsxHq/pGGSoaVxgmWew0X65TGH31wQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tN+j+44JMt9GZkftt2CYNCvAFr/avMkf70JH4zqXXuFofgLsvKaRIxAcLqieln6Cy5JHek83dTMEyvQpWwbbZmz5IF0Nrx1v9ygLqg+LECJcd+pEA9NRIe0rhZeI7t4DfUVy4rl388AIzXaVLzZJZ089qVQR0spE5EoMVyxR3r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=H6o9CfyY; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53de84e4005so6694627e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 08:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733243043; x=1733847843; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wtSjOuVKtZRnK0WO9fp7EqIM7Es6Bf3JeXvEkCB5I4E=;
        b=H6o9CfyYlem5jZWF0Aehbsa5B+h7qb5OKHMheRkWET8NxZIcIZaUeJEyot9lcT60U8
         a7oR+4x36myMjUyhFWcuLviAZg3D7UMGUK24VkwnmxuVUjnOO039g9ElSxLgPpC6tGUV
         2M5hfyaAPIv9I+kaHfmjhzTbm5BD1qfaJctvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733243043; x=1733847843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wtSjOuVKtZRnK0WO9fp7EqIM7Es6Bf3JeXvEkCB5I4E=;
        b=R6fgYEQNdoTRBSSiNFdnL1DV3JvPVl4VjYtWS/hcE2xV9L+9LG/EUPBnQk1VyvGRYP
         adRsa8fRTqR/LyI8ZtcKisqI+V0sv9BBQdmJcOwIVJ62jzq5SkFtfFV+kB3Gh8fgJk6c
         iI4uVy1Eh+hQI/Ko4jIIwzGyjXwayTURhjVxnjT1YJ6ZxlWzIDAAXlJZljljDeTTOJTd
         fUhiWw0dBTn/a4ywbqVjc/oW7kb6B8AWQ48xpo0U/cHiG625OZce+rNnp8J1dlozEeOs
         B/7mbeCZz2Y+UPFDseHF2Y8nsH1osE94n5r2G063+XcWjwCIYgq6NGuzTz9+hu7W+CI/
         4CzA==
X-Forwarded-Encrypted: i=1; AJvYcCX4f/6zOxry5fbHbCrCXfIoExAfA7fmu4U+Fgv+i5xPHZo6f4vemcM/EEgPAcx0qvzbOJyjkfj2EEw7GCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoy/2tNYhB/KeuO95catVXwI4Md/Sb2r7AjyCYBi3RktYN5Bq0
	RhJzvhM14VsvcTk69Ndt2lqv4qYuCoZohGo9kJHkDSPGHOTJhd0Wh2IeWAJXLhPADx14n+h+obR
	DkS/YoA==
X-Gm-Gg: ASbGncudcZb3dfkMsJqF+A3YWwXBiuMyX5SCFQYTZT/kxz9uhQ6xIzWdpg03mtJn7lQ
	VVsOwqtEWdxbKiUjZ3h111ly33f45aRbCaY/X0cdEs4xKLbZt5ub4bbFDDTndNFGKNqkQ+y5OyZ
	Jg9OMD5pYwIGBXiGquaT9BMTHJYaIpV6YchJBzz0TZhH4fp5XvrdHjiNIUNRBoP948Dt4qrsjTq
	doxVUcfsbKn3YIyL9egbhnjsYxbytDAQ44dXL3KqYQQKpKBMX+7MR0J4WMho7+EnZmtaSkRSxHZ
	pXW1xn0xGNovwi0RN2hMIU8m
X-Google-Smtp-Source: AGHT+IEUvpzs7SLgyvl5QyDrz4QHS9ZSnQwW1cyJr5MSUvHIkS7QsYwUvlHILldG7GVs/3V/438IRQ==
X-Received: by 2002:ac2:4c45:0:b0:53d:a00d:e7b8 with SMTP id 2adb3069b0e04-53e12a2e472mr1934031e87.48.1733243043161;
        Tue, 03 Dec 2024 08:24:03 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5994a66basm629970866b.0.2024.12.03.08.24.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 08:24:02 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa549d9dffdso919882066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 08:24:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX2ad3oZc/QVF/L168SZsF+i0bc8bnmFRWY13t0yndsuDcBYJ6a8qvJ5xL7GCmPEBZcLbFnydohk2OUdP4=@vger.kernel.org
X-Received: by 2002:a17:906:2922:b0:aa5:2575:e76a with SMTP id
 a640c23a62f3a-aa5f7d154e9mr213082766b.13.1733243042083; Tue, 03 Dec 2024
 08:24:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203102124.3147478-1-masahiroy@kernel.org> <CAK7LNAQ8MKTWWzLNYDBMCcRzWGVhX-kUyFM=BwK8-maKtqZj3Q@mail.gmail.com>
In-Reply-To: <CAK7LNAQ8MKTWWzLNYDBMCcRzWGVhX-kUyFM=BwK8-maKtqZj3Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Dec 2024 08:23:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgCZX5YzWhKMvyF9Do_9hvOfFV8mMa_GGfh0RRLv0MJ+A@mail.gmail.com>
Message-ID: <CAHk-=wgCZX5YzWhKMvyF9Do_9hvOfFV8mMa_GGfh0RRLv0MJ+A@mail.gmail.com>
Subject: Re: [PATCH 0/3] module: fixups after module namespace conversion
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Matthias Maennich <maennich@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Dec 2024 at 03:09, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> I submitted this patch set to you, hoping you can merge it.
> Please let me know if you would prefer a different course.

Applied. Thanks,

              Linus

