Return-Path: <linux-kernel+bounces-181261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0038C79A7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EF3B1C2103A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5815614D452;
	Thu, 16 May 2024 15:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YCZ862VA"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CC0143895
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715874492; cv=none; b=ldnK+EbuEwJ4JQdpt7QQWq8RlMf9IWZbzQI0G1Xf36RNLGOsRGM0z99J0wQ11OW/vNInUJj4m4ItbWPD5CWTc6RkznhjfcvATBL2e3yRKM5mF69ksejHYbEqUq3FiszIXM+RGGQFSWR2EOoQ46xMbCWEtWN2o5ohXrw65PG7o2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715874492; c=relaxed/simple;
	bh=RZiPgzca9nwRTHTXn6EH2+cSL8F1AcH3O8sQBRT+8O0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCq6zNzbD7fE9r/eB06oaSgbVQpWFB3x9R2cFTaOzlqwSrhAaopuDN4MzRi+gE++ftxjk2CoCpIymfeJPRPoUxh8tZlwv+tsWlLxJpAy1HZfyStBNF4E+sOWeC4RXhIWr0YzU0AbEURD0sRlXqhJ+8oI0tXFZ6buXCrIqxpTLqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YCZ862VA; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e56ee8d5cso4180401a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715874489; x=1716479289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BftxJmB2CreY3+o2q0X3TymOit6faQaIr4Dqh2PnWeg=;
        b=YCZ862VAMeLFnCRZoBg65Mw8ks76lTYZJy+uZwFNJquNeby15EV2i1Q/NA5MiBOeIJ
         9RmgfdABPjxTNv+dPpcK8pzkxMPEIvO+qkAQMpf2pQxgiYeoNVlpoNmuU75M6Yo2NQoF
         IcAgrbXgmlw9uk1eexdXgRVZ9UNjrV3nvJ8f8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715874489; x=1716479289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BftxJmB2CreY3+o2q0X3TymOit6faQaIr4Dqh2PnWeg=;
        b=wxgO7NKAMjaFHeCk5514JsOIdJBaiyTEqRtj9sheO8+qazDnz0MQ+p2sZUw0Jdo6l1
         2sSbxy1qHoOD3yMf1enLCO6RKdBKNWpiANdusHMnpAG1zg+VzIr7rlsn4rPi9xcJRXHD
         XeBsF0SiKVpnjwEboV79E43mBKLAKbvu1GpJC70JARP8d3Pk/X3HUVTAbR0vEbX91MKN
         hZIBQ4ENr3eToU6Yl5RoKcctNtENty80XgeknkKuA09rmnmpqI0gtO1ccu9anzmenazQ
         FQ9ExWQykK0qvSJ1xoHwtxgtQ2gDhJbQcRLCpJJhIam5tbs27y/7cmjyEVlIn83Hh5Y2
         w7Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVuB/1ZS3M2ZchPxJw1K1t6vvIVIFO9h+KandUihP5vyHFMCBVGzLcXE1EFqjFHmBPOOytLTWnEWm8FEgUlaxbwz99v8+0EvVuSUnHe
X-Gm-Message-State: AOJu0Ywa7HnhSHDmkrvOfO/BWZ0PZOdS0BP9EGbPf1CAp8q1DrNEX6nJ
	jruiFcfv1C5AnQIelah9C8OUK6b979WcB8ptqC7BUcoXCsL/FouCBJeFi62lR2MIGrYbi05luzt
	XPYssOQ==
X-Google-Smtp-Source: AGHT+IEFwE/tLTVGPH8J46/eAhHZH+Zpjh52dM/gJG9cXkGD4aWlwpFlQuqMFy9Q0kmE47xVFkSmOA==
X-Received: by 2002:a17:906:1406:b0:a5a:7a4e:7e80 with SMTP id a640c23a62f3a-a5a7a4e7effmr778909566b.72.1715874488930;
        Thu, 16 May 2024 08:48:08 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d6bfsm989453566b.31.2024.05.16.08.48.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 08:48:08 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a5a2d0d8644so335401666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:48:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW+z9k+wgFRBXMTHo0eRpqBuu06VxubS490bRxZo/xRXZcmHJ0KRNWQrs8G08ChuM7vUMjWMfgyoJxqfKFl4jAFZXbbI6bQA+3ZU1LM
X-Received: by 2002:a17:906:2708:b0:a5a:84c8:7710 with SMTP id
 a640c23a62f3a-a5a84c8b9eamr575885166b.55.1715874488199; Thu, 16 May 2024
 08:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1715616501.git.dsterba@suse.com> <CAHk-=wgt362nGfScVOOii8cgKn2LVVHeOvOA7OBwg1OwbuJQcw@mail.gmail.com>
 <32730052-b40e-4262-a1c4-0d45a9b6de53@gmx.com>
In-Reply-To: <32730052-b40e-4262-a1c4-0d45a9b6de53@gmx.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 16 May 2024 08:47:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjKp4Scs_9zE0a5Bh=tFYuzaaE7q9ZJ8X1n6RsLcZYX6A@mail.gmail.com>
Message-ID: <CAHk-=wjKp4Scs_9zE0a5Bh=tFYuzaaE7q9ZJ8X1n6RsLcZYX6A@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs updates for 6.10
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 May 2024 at 02:02, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
> Considering aarch64 is going more and more common, is the workstation
> also an aarch64 platform? (the Ampere one?)

No, this happened on my regular old AMD Threadripper.

                   Linus

