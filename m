Return-Path: <linux-kernel+bounces-423670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5689DAB21
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F13AB216C8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5F920012E;
	Wed, 27 Nov 2024 15:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ctAjhJiR"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B58C20010F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 15:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732722911; cv=none; b=dbOqGQvbM/5qlAfMHRUEcbWFuTr7x7B0EqwoOKTJy3Arh5KV/qCq2Sq/G1TL4plCLvmQydzCeH85RXPut07o45lmCREykJDD6MFcdG46QWEkYiK8cUiv1EdST2ruDhJZnbqSc8IWbHkL7dOgushnEJe6SK7LTa92vr+aL4sRxxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732722911; c=relaxed/simple;
	bh=hYOF5+CSvFGGwMZxoKhXQ5ulU8SpkTAOXD2Ro2loI+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ArffW3qgcwhkl2F3xlqOeAJ8swScexEeIWJnUisKJOSi0cU/tLs+y07T24fOgvf3xMmzWOgErpMuQTSBMd4EhgVXgHeD6YBIybkz11iYQb+p33iB+7/e9ubMLcem7Nkpn80foheZP4FKcXlzXVUr7pZ9Jc3q5bbEUH/THRZmkJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ctAjhJiR; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cfe5da1251so8372204a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 07:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732722907; x=1733327707; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hAr4TZdsOU6XWFX8oKIJY4uIFZASuI0VfNTDSWNUv0Q=;
        b=ctAjhJiRMRQ7qyYnxDQf9kC8p6JrlrmnEG1eNZO+sU2o2eB5d3HWAuCACA1R4WV9kF
         SvUTfQwocrNaiWKTH7NS/pj3ai4ixYeBu77znXknbOZnEDYONvGcqOaglgdfLLOwVDfu
         k9M6PnUFoawWD5nZA86x3Ellr/rxlIcFuQrps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732722907; x=1733327707;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hAr4TZdsOU6XWFX8oKIJY4uIFZASuI0VfNTDSWNUv0Q=;
        b=o688uyR9trrmxSSWcUUP6KXajhnxQIW0m/MzQvYPxfZvTrXTyW2/ue4vYsNGShGhKG
         PWXLzT6lmmLZ+s2Pci2a7eBpG5Tt15SMq4DiCI9ms5u4PMptI8Hd+PJA6ORLLcWIvLv8
         VU0u0S/gExy/MoePimfKet272Z7UYeg2k942qKujYoxw2Gaol+bJs1HvaW3u/roOoKSX
         WQj1d7kXYOt48FISxy2iKYi1fTbyRhrldSuL6PCLux4gmCf9yL6QTjdeYsOYlng/IZyp
         cAjQXG7YmK6f+asIKxc7h2PqNIghRoFUYpzJXF8cg5rbu+yoUDxLYZMOhybmVrFMHBBM
         R2sA==
X-Forwarded-Encrypted: i=1; AJvYcCVje1AcQGtQZFyDPQowxw3xIYRcq5YSx3SjMvanCKQIT2/pqrAbLkwqhTyyKWBp/UEP/3+8tOLo/iw+Fjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Aqdyz4uKwzjtCV/M/M8ZfeWnfc7rTB80xjd7TtGhtZBibBPu
	E/bsQoF5t/GgfgeS8kFz23dgzpIh3hZxBABov/z1GBpx+QSPBkk5NPdxE+5RwTLmEa9sw3D5P8D
	Kfi3zrw==
X-Gm-Gg: ASbGncstIn1YrYhLf8hmUurOQxICeukRqDcMYVo3AYBsrejyLZLFqEFPfPHsAcXVJ+0
	yvYoToeKr3CyQPPW7x3YgaOMYcYG9qnlbo1olw4ucmVstc9wjKiQng5pQTNAuhTxkW0sJ1grd3p
	XvZ4CYOGOz947BngTVUIgygN+ej7ujPA9xWv0kMvO+qJ2H8g8ih9ll1++zzfBkEJ3knN0HrZwxP
	9XastJbDOwkD61f4BTh1jfkmnEKfc9b/wSUZxMlkCFqw/3JTyLAileVgZVVt6Q4azDxjusTG8Hv
	QhyHAtf3JI671vrs1mPApyTM
X-Google-Smtp-Source: AGHT+IFiSjdMyOibPNooqpsvFbjYW2Ojwfxw9jyKkXRLZeakWa0u6P8G8lLpS/9ZNIskLBwvUedYJQ==
X-Received: by 2002:a05:6402:3481:b0:5cf:cf81:c39d with SMTP id 4fb4d7f45d1cf-5d080c97f04mr2820743a12.21.1732722907538;
        Wed, 27 Nov 2024 07:55:07 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3a345dsm6249891a12.13.2024.11.27.07.55.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 07:55:06 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5cfddc94c83so8575814a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 07:55:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVhet9RxM5GXb0qojTcYM91TV4JZi7CpKIs3DfUkbyU8R4/Rnm2+K5pcCwqBb6PTkOHo95/Wpu1hqTE1QM=@vger.kernel.org
X-Received: by 2002:a17:906:30c5:b0:aa5:1b7a:5579 with SMTP id
 a640c23a62f3a-aa580f202d9mr211472566b.21.1732722905907; Wed, 27 Nov 2024
 07:55:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACKH++YAtEMYu2nTLUyfmxZoGO37fqogKMDkBpddmNaz5HE6ng@mail.gmail.com>
 <4a2bc207-76be-4715-8e12-7fc45a76a125@leemhuis.info> <CACKH++YYM2uCOrFwELeJZzHuTn5UozE-=7PS3DiVnsJfXg1SDw@mail.gmail.com>
 <20241127-frisst-anekdote-3e6d724cb311@brauner>
In-Reply-To: <20241127-frisst-anekdote-3e6d724cb311@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 27 Nov 2024 07:54:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi+3qEU9S9sgRLesCMKJ1w_e6zwEt0f30=8NSKhN+2LjA@mail.gmail.com>
Message-ID: <CAHk-=wi+3qEU9S9sgRLesCMKJ1w_e6zwEt0f30=8NSKhN+2LjA@mail.gmail.com>
Subject: Re: [REGRESSION] mold linker depends on ETXTBSY, but open(2) no
 longer returns it
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, regressions@lists.linux.dev, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux-fsdevel <linux-fsdevel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Rui Ueyama <rui314@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Nov 2024 at 04:11, Christian Brauner <brauner@kernel.org> wrote:
>
> Linus, it seems that the mold linker relies on the deny_write_access()
> mechanism for executables. The mold linker tries to open a file for
> writing and if ETXTBSY is returned mold falls back to creating a new
> file.

Uhhuh. Ok, unfortunate, but this is clearly a real use case, so of
course we'll revert the kernel change.

           Linus

