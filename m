Return-Path: <linux-kernel+bounces-260311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8931493A64D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED608B2327B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EDD158A22;
	Tue, 23 Jul 2024 18:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YJ6TjiRh"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFD913D896
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 18:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759635; cv=none; b=kmvRzQspMVP1rmV1YyfzovcpG0V3sFLEJvsNugMIfbB0as9dYlna9o3bivcEY9qDwxPFzVUky2I6PJKCx5/h4t6nJK/sGNawHO77bdCqwsr7nXs/ovnagFoPDoBwWXHX7+bLFUJLQfaGQLYuPGNwzjcqBUEllbLBSqC+KYjnsuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759635; c=relaxed/simple;
	bh=NFq/ekDOEm1BCUiEQxAbPVsS7vv5PxDQqveu1WlBUdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uc/kUYyguLALdUn21xR+kYVEkOzhq5xG0It0ljQUIxHM9O3BiM/WZwt0mw4mvy8qW2TqUBS3X5RLCwlHJ66aEpC/hgVk9+bkC8267tfI2CPQQD3YYVI+F0ALuLfwHFafFauFzWVnchMnYmmrv4E2quyDCWCyG9niC3LgFXT9ElU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YJ6TjiRh; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a2ffc3447fso5172957a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 11:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721759631; x=1722364431; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jVlnyN0btPbYCcHbH0TkKobCqtHm6zMls3/CNbNfk/I=;
        b=YJ6TjiRhFssJkGpH6v+xkifhxaj5ysktR5U3rOcLwfA2zRbdx0j9/b18LlEd8nor/p
         lotahvolBuUeRPNH8KUfHw6O5oisgn82xcdRoCBnKfwQN1liPl2SJL44DzpUFv3DuP1o
         o6U3s2EDjyNjZrFpxM7hP3SZz7JOPf4FCXjpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721759631; x=1722364431;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jVlnyN0btPbYCcHbH0TkKobCqtHm6zMls3/CNbNfk/I=;
        b=PzD8cs0Zcd7yyFK65Zm+4Ol/IxKT9Tvc3QiZEtNb5Qdj6XMDfakdB9d2YHD+OzFVvD
         AHdLxHQQl6zV8/p4+IWfm3xLm+89VHvSNfYgxaeF83B7KFLjVy7ngSZO/d9SLK4bqtXs
         SbyjobwRFFRTsjbfNWMooRCmeUP2hKqquKfU9jYjyF7M7h1CxTH+4kscu1ih406Udzcc
         cD4s/dbRjAO8rTHqVp84fG+vRw0sd7c+C+yW8flZoNZkALCFX3APdDSBucF4GufLQHXZ
         zfyW8IR8TNrLHJ2IbTOgqu7x4QHPDYh0LkrCsjPud9KfCFxtodC0o8oPSxOsrq9kQnZz
         OHcg==
X-Forwarded-Encrypted: i=1; AJvYcCWkRlucott2X2FEodWSKop0cA65ebg1FJ1xWeDnHxH3UnejERjecPmYUssWHsL7+DzdOX2lxe8uh9999u2dlmvjmO00sSfweHtYjWv3
X-Gm-Message-State: AOJu0Yzbu34LOjPz48G8bwUZzQmvNZyzAseXbIUl00W5Lm4bxyPRnCbg
	xHgO8rAOlGvB+6Yl/Isnjm7VwGe0ysunfbB5VLMiJLyVR+AOEzuE8tlyIgd2rtABaACQKJm7No9
	vCXJyvQ==
X-Google-Smtp-Source: AGHT+IG5+F3bPQFaIqhsBaiZEXNjUNMRkYIhfQGqMVrEcCNQR9VVBfktkEj4DalbZNa6Edd+m/OmZg==
X-Received: by 2002:a17:907:3f0a:b0:a7a:a138:dbc5 with SMTP id a640c23a62f3a-a7aa138e2e2mr175220666b.65.1721759631475;
        Tue, 23 Jul 2024 11:33:51 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a9ee292cfsm82941266b.54.2024.07.23.11.33.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 11:33:51 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a2a90243c9so4768734a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 11:33:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVU/MLksBeuDfLYCDRdIqGp7MjfI3Q/tiwveRwF3r+jlMm6IYkFsidsX/gwwWZIi3jzHr9N+NeODa3AQJq5p3kkPhdz93ydX5r+0ZUK
X-Received: by 2002:a05:6402:26c2:b0:5a3:f5c6:7cd9 with SMTP id
 4fb4d7f45d1cf-5a47a61f330mr9178333a12.26.1721759630852; Tue, 23 Jul 2024
 11:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723171753.739971-1-adrian.ratiu@collabora.com> <CAHk-=wiJL59WxvyHOuz2ChW+Vi1PTRKJ+w+9E8d1f4QZs9UFcg@mail.gmail.com>
In-Reply-To: <CAHk-=wiJL59WxvyHOuz2ChW+Vi1PTRKJ+w+9E8d1f4QZs9UFcg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Jul 2024 11:33:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiU8igSGkycZ1e8+6-NF9obbbt1aZXYwd0ONzXnHsBgHA@mail.gmail.com>
Message-ID: <CAHk-=wiU8igSGkycZ1e8+6-NF9obbbt1aZXYwd0ONzXnHsBgHA@mail.gmail.com>
Subject: Re: [PATCH] proc: add config & param to block forcing mem writes
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	kernel@collabora.com, gbiv@google.com, inglorion@google.com, 
	ajordanr@google.com, Doug Anderson <dianders@chromium.org>, Jeff Xu <jeffxu@google.com>, 
	Jann Horn <jannh@google.com>, Kees Cook <kees@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jul 2024 at 11:30, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> but while that looks a bit prettier, the whole "fs_parser.h" thing is
> admittedly odd.

.. don't get me wrong - /proc obviously *is* a filesystem, but in this
context it's a boot command line parameter, not a mount option.

The "constant_table" thing obviously does work outside of mount
options too, it's just that it's documented and used in the context of
the mount API.

                  Linus

