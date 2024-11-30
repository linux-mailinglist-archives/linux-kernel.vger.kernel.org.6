Return-Path: <linux-kernel+bounces-426413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC129DF2B4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 19:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DD0AB21178
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 18:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD091AA1DD;
	Sat, 30 Nov 2024 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqaX9nAI"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918D417BD3;
	Sat, 30 Nov 2024 18:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732993145; cv=none; b=nLo/ISx+kuMM+zU27y7r1+Em+enOqKrgm4jh6slA4LRMsKzGLfaN8ALSK21/Km0e268fMSymhpiW9O6ZlfS3CZ6tlKlJ1xQBwzV+qBowMc9CbRjmFsC/r8yc0y1M6Sd18MIOjNCihhoXjwnXXdJV0dDKUJR9h+xHD3uI6+Uzy80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732993145; c=relaxed/simple;
	bh=psXK7nwI7pWzYjyTuJLkhhZPKh/LpnW5SK2nngdFs/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TMNr2Gn6NDoZa6ia7QiyWBXRev6l0xpFNgJ3tHsxa2N88aBsQlefmfC8eEdD3rl9taZbe+BpuFCgRYAhGLfLBdAvCQqLOlHcoarn2juKFBNQJiQUonSlAdI0hF6BS2Wlyu9WgdR2DoHdt30OcHQQVi1IXuZG9zWAk7aTByZYzmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqaX9nAI; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e59746062fso2237547a91.2;
        Sat, 30 Nov 2024 10:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732993143; x=1733597943; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=psXK7nwI7pWzYjyTuJLkhhZPKh/LpnW5SK2nngdFs/I=;
        b=nqaX9nAIMHHpso2NBiwCFNKllgajR58wb3UTylm14R5PTreC01sQAy52lsaOEeZDYG
         sSs8kJZPnLYlAjvvjBcZU1YNTyNqsMolQlDh9cDV1yXDzhPVC4+Zc+ku9PFfG2ETjxjr
         1iS+lrK0HdGJgCd44c5M6Vzp1MXFh5uP/oInZ2LkoS0OCHyUMWFzIkyMYV/W+0qwjOMP
         DkxYHNR9HeyAhPwm871dD3lOmaN5CCAz8rUGXwRPtlfDOTKCbvgeQ4BGAbSnFaFu9qqA
         cjKBj+aeu5bujDkdvzWwEutLh8lSpv0kySq4w9/NlnZ4f8EGUWhdfBjFd99pW9Ix9Mrq
         5XRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732993143; x=1733597943;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=psXK7nwI7pWzYjyTuJLkhhZPKh/LpnW5SK2nngdFs/I=;
        b=h9r2zMNAvb4ww0S5XLp/wo/2OJd0rHyd1GE2xAoTkxLWqGKVe74EvDHoMrcIBnVQrR
         zltVbcMYtUQZtULDIS0MQjvFLorBXVDv9lGfBKMu+ZLkTCQnKJsUKAmsjHu528oc5SsZ
         K0AHd8K5heoT9NEqz72Fb5fZjgMvuBJ/yn41V2IGMpkxRzoH9F+XiuOsG8q2wl6CoGOS
         X1uWCUTs6FHbWQv3mGOf0sgoTaT4TsQVfGeulFT6+padXtGhqGlL3Vr6OFqE2NVlzt1d
         RO7IMdy1lii14zs/7RjPEaIvMLE3rHo5AG+0Ew3Rz6WYqHB/gHOMhJ+PM23HUCK7a0BU
         NhFg==
X-Forwarded-Encrypted: i=1; AJvYcCUDGHpiHDsCYl0ENCuFmPnhjJGPfBeG+bnlmk8QzC1YqURnHjwgK08VMR27Zd2vYvRIVGh9mIENhmbsOtWD@vger.kernel.org, AJvYcCUZAqmLZVJgrql2B3eLHaMjT3pwSp0kIlFdflwWkz47C166r9Ug8Z3kFOAcnzk8AsjTpNknH9IB6/Y=@vger.kernel.org, AJvYcCVc1GHnx9qlvDRDekuDOJ+2u46llXZ4RPE+ZwjwqgszTw+OePO/J6gNktL1k3O4OwZ0MWaq2j0KywVwOJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhdBTSbo8L0A+zOo8d/Sq+lnZDf8U5MWYrWbFXQaiAq7rb7wNB
	zRsIVopAFly9HQ1AB344d4U8dZRVK8adXvXH6JGjZwPIA+Tg1stZnCG+Qn+T+1lWj/R2oajOgOm
	bJkQZvna2mfDL8kjHK2y0MvpgMiI=
X-Gm-Gg: ASbGncvkrFBNQ0IK/rANuzvec4rLG/NqjuHM1+pyFVT/6wYZLBVA31tdMIWW6w3VAIG
	A20+0ryuhyZKDLSkIjr/ZpT330X4FDwHlizEahZiOG6fFvlgFMpWQge+taQxLBXwhAA==
X-Google-Smtp-Source: AGHT+IEg2zNwEI69Sc3gdOMX6xw7rks/I8M6+9dH3BdFI1LeVgyON6Y/WXekD6MY0taVS1ULiyFjcck9sLJdD2WTgfo=
X-Received: by 2002:a17:90b:3c12:b0:2ea:8c5c:ff6c with SMTP id
 98e67ed59e1d1-2ee097bf2damr18485432a91.23.1732993142752; Sat, 30 Nov 2024
 10:59:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114-alc287-nitro5-v1-0-72e5bf2275c3@gmail.com>
 <20241114-alc287-nitro5-v1-1-72e5bf2275c3@gmail.com> <87iksmq8ho.wl-tiwai@suse.de>
 <CALiyAo=5aLbYEyRWWw7QscTk6cXy5qckHToiPL6h4fKM9=skLg@mail.gmail.com>
 <87ed387ioq.wl-tiwai@suse.de> <CALiyAo=awTsGQnGH5UPB7dF5QsZ2AFkKv5LcJkJRXV9sv51iqQ@mail.gmail.com>
In-Reply-To: <CALiyAo=awTsGQnGH5UPB7dF5QsZ2AFkKv5LcJkJRXV9sv51iqQ@mail.gmail.com>
From: Hridesh MG <hridesh699@gmail.com>
Date: Sun, 1 Dec 2024 00:28:26 +0530
Message-ID: <CALiyAokt1zY4a6F0DTpyYAmu38D1Fk0k0QvsFtXYHzQ7suS38A@mail.gmail.com>
Subject: Re: [PATCH 1/2] ALSA: hda/realtek: Fix headset mic on Acer Nitro 5
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Stefan Binding <sbinding@opensource.cirrus.com>, Kailang Yang <kailang@realtek.com>, 
	Simon Trimmer <simont@opensource.cirrus.com>, Joshua Grisham <josh@joshuagrisham.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

> know. I'll make an attempt to understand the cases and process
> coefficients before sending v2.
I did a deep dive into the code and frankly I'm a bit stumped right
now since it appears that the code for the headset type detection was
written by Kailang Yang from Realtek and i could not understand it
since I'm not sure where to look for documentation on realtek codec
processing coefficients.

To rephrase what I had meant earlier, type detection for the ALC287 is
currently not supported. I made an educated guess and added the codec
to an existing block of code, which detected it as CTIA. However, I
have no way of verifying if this guess is correct. Do you have any
advice on what my next steps should be?

