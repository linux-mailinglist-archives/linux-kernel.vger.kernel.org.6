Return-Path: <linux-kernel+bounces-188955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8538CE8EE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 18:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95E77B20E34
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3915D12EBD4;
	Fri, 24 May 2024 16:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IHWvqFSU"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A2212CD90
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716569437; cv=none; b=mQz4xAD3UDV5fyOgnkJeq7+9y6mJsXg+HJdvFoM5sMuWQWwduo3feMYZpg2CKMGB0kNspkidrWr3LcgIpP+Pjqh++yy1A8ETbawKOonEdWejcZV/TFdpY8/G+5TkLyvYy6VV7ONYEo/IVXYpwWeUZBBCuc+10qImKytPEERpNbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716569437; c=relaxed/simple;
	bh=HcJ3lytpbQnXo443M5BAMEUyaYSBLtuCf2kCkQUnnPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vAdSqYnQngKyeCOw2qIsy0fgzbRyaKVH0m7C8JkiPnlQlWef9JHpfd6SLkxSIFbXFTop8G4HwMadYT8SpYA/OOKvgaZuN/3y138p1EkHThLa8yuDXe5ZaDSLTl/BUaljzdvBTj7QsPzd6Q9GD6Hbc3ixs3gbXbwevS+KNQ48gAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IHWvqFSU; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52388d9ca98so13862349e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 09:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716569434; x=1717174234; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/wd0aVWeaab4pkRhA/5Mkwde91KCNjgTYomFjikwQ9E=;
        b=IHWvqFSUUdak0YQMUAlHb4mzO76TO1wwpddI2HAy89X9ah0f1uLMJCMk6CgqDdoEoH
         2xJXWb6uyoSYvsIZoDDTAVbtzBKo2LLFRUR/qVtBXcSfEyns5kqoCql8+Ieoflxwr5BI
         jH5qSIgo09fwRUsOr4mIaF2V+iX5WlhGM2tWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716569434; x=1717174234;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/wd0aVWeaab4pkRhA/5Mkwde91KCNjgTYomFjikwQ9E=;
        b=UEY1SpXJTPkSusD4bNL1J8zweSGd2ISNnowrBfSmTaj9dXg8dNIuaQ5myZiIGOkyyo
         e/rfd25umgN4glU+37gUNX3pHzO/Trz62FNeR8psoHbV+f3Pe0SM0ANw/E8tK4bAY+YM
         T2slEImQJvMCdteVeB+Rz0nEe3X+QKdB8TOyXQejlmPxZ9TUDzt7ODhTDSUnD0XoIF8n
         VrE/tHDTqUuZqOSALr+3CEX2NuzQdScaAB/Q5Ry6Al66NOI7CE/xgHKjpj3+pEUNexWG
         mEiiwqu5m0CQ3OV2YFcwCzIm2PvKqLKfB6vY5DW7y9gHZAsY7XHdY4u3RkTa+MoDVGvj
         3cUw==
X-Gm-Message-State: AOJu0YzajfKJilOXHISN9zobKZ5HZu6mzwd1hm0jH4IWcN9ubVHaUwr/
	1BLxDGKs1ON5HlOWjjJhk6r8dtpiAXf4IRkUYCWDkDreS+nXPfDbnVqhV24/vwAen62NeA/6Gp3
	Zr3HNnA==
X-Google-Smtp-Source: AGHT+IGMsL/k44RAutIoXwXBvSbgsGa8Y+aAXzxdTHgEoR2OSM41e1jJ9TJLaA98Gsx8iHo5zJurPA==
X-Received: by 2002:a19:7410:0:b0:51a:c7d0:9e84 with SMTP id 2adb3069b0e04-52965384ad9mr2240758e87.12.1716569433560;
        Fri, 24 May 2024 09:50:33 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5297066b23esm207943e87.125.2024.05.24.09.50.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 09:50:32 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e576057c2bso134758371fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 09:50:32 -0700 (PDT)
X-Received: by 2002:a2e:7407:0:b0:2e9:485d:45a4 with SMTP id
 38308e7fff4ca-2e95b096de2mr23558551fa.16.1716569432516; Fri, 24 May 2024
 09:50:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zk_rXBV8E8Hwu04W@google.com> <ZlCv3HNhfcaEYjHf@google.com>
In-Reply-To: <ZlCv3HNhfcaEYjHf@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 24 May 2024 09:50:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXJcLOGizFGmVyY3cd9+oBwsh3-PYPdVBdqCW+Djgz8Q@mail.gmail.com>
Message-ID: <CAHk-=wgXJcLOGizFGmVyY3cd9+oBwsh3-PYPdVBdqCW+Djgz8Q@mail.gmail.com>
Subject: Re: [git pull] Input updates for v6.10-rc0
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 May 2024 at 08:18, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
> Oops, forgot to push the tag, sorry about it. Should be there now.

Possibly related to that, you didn't get a pr-tracker-bot notification either.

So beep-boop, this is your manual robot notification.

              Linus

