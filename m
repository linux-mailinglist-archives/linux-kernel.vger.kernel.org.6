Return-Path: <linux-kernel+bounces-404830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B43A49C4915
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 23:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 141EDB2F658
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 22:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC78F1BCA01;
	Mon, 11 Nov 2024 22:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NrxXdrQy"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6F71BC9F4
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 22:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731362910; cv=none; b=GlE5qx/hsSCOttpQ6/6drmk/euaIM1299c5pK8ObQw/3GRNgPPUKQOwQgrdM4qfhLRTdYRvB/GwPo5S59J0GTpe19/mKEnBP2DUnWAPhe9R81PnzFllkhFkznL5YCkdqIejSIh54XmCGmHIlGXrZKnFh9imPMfEhB+U7qXYFA4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731362910; c=relaxed/simple;
	bh=o1ZuquSTxhS5616xdtKNJOYl87d15TuDgoYPTqWYoEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2kAQqp5lC+gB7uXJieAzOK0knIXFgScosCe14fi2nzZoQB0Xa3lCJsQYehIK3uXPYdRPblQoiiAopJ60T4oxUj/xh1IDdf8Fr1JyyQ7KFN0/B6KIgvuMFy70Ubb4vdnPdhY1p8okrZAibkmRIJjt6IzczRDPhwaIKK9URNb3js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NrxXdrQy; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9eb68e0bd1so692554366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 14:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731362905; x=1731967705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nw7jmBqAAuw6PQ4Oic9brWgvBuX8kaVtKrs+xC4V9TI=;
        b=NrxXdrQy8aryRV9UukpIQrWq3R4mEkkINW2zLw2FNlu9Rs/wS/dHBCT5nxkYGAe1R6
         kWrST3w/8bPt+g4gphx4PRrWhErcfkVW68SsRAtCmGQn3WS7yrHw2WqaVDMBZ/EwfJXz
         BXF5+Pn6HNGDI1U12z+rifG0e/U9LoYIAWmJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731362905; x=1731967705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nw7jmBqAAuw6PQ4Oic9brWgvBuX8kaVtKrs+xC4V9TI=;
        b=FWhQs4pfKK/rvbUAwpNEQcBOLvEU+xcGYpJP6pUF43uDVQ29dk2UZ0E9NxVif00rTC
         iLjol3cnscLWIjDr23BB7d06XN5jtIRlxa4b9LJW9tmQxF2saA1Y8mlzhaRg9lsqx0VD
         KQCtSZ5O+5b8/lndT8VBP5K9Bg1uLBBR+YmqwTWPCqSIQOt6ugVMn7HaBi/PE7fbapYo
         XjqZ6fqj0tDQQdtUUlUjvXx9rISK0AQEEmRER6P1X9JOlageW7Xj4/mbGkpU3Eyv9FSR
         9HC7Ra65nGZM8YCuPIvKeWbT1UycZ7xt+oVcj6qrKN203Rv8h47tNF9aQlK++5RPhlvT
         ePvA==
X-Forwarded-Encrypted: i=1; AJvYcCUwpFJGD1T35Y4pecozYgOpCwwAGwe9IlCmRqlC++H+K5ZkYPtojEZzRvFyn0Q1NcNsG+BlojTpX20mLPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw36pQZB5tSRkIJ9l8lVY6ZpKMgLMegoXED7MAupe+L/biuiZwM
	R4QGzsX3uiLsCV9VcCDUsO3tD5nePPTuLkmCMK5UVB0CCcWOgNpyKeTDvfMmQq6svP8ZCS6oqLC
	ut8A=
X-Google-Smtp-Source: AGHT+IG+2wcD6Mo9M6DtBO86PMVTCzkPFufHkNT82g832+IxstXoajerM8BOV3AhnO01C9qxChlrzg==
X-Received: by 2002:a17:907:d8c:b0:a88:b90a:ff30 with SMTP id a640c23a62f3a-a9ef001701dmr1269684566b.50.1731362904598;
        Mon, 11 Nov 2024 14:08:24 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a1769asm640040166b.1.2024.11.11.14.08.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 14:08:24 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9eb68e0bd1so692552866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 14:08:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXKq8sUpqgHo41wVeU7EAmMSLviJxmogZH23nf4kQd6tpzm586ZVnlZsxAITPvqucVzyItp+CidyCBM+JM=@vger.kernel.org
X-Received: by 2002:a17:907:7e8f:b0:a9a:3c90:60c5 with SMTP id
 a640c23a62f3a-a9eeff38583mr1475828766b.28.1731362458220; Mon, 11 Nov 2024
 14:00:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111164248.1060-1-egyszeregy@freemail.hu> <69be42c9-331f-4fb5-a6ae-c2932ada0a47@paulmck-laptop>
 <8925322d-1983-4e35-82f9-d8b86d32e6a6@freemail.hu> <1a6342c9-e316-4c78-9a07-84f45cbebb54@paulmck-laptop>
 <ec6e297b-02fb-4f57-9fc1-47751106a7d2@freemail.hu> <5acaaaa0-7c17-4991-aff6-8ea293667654@paulmck-laptop>
 <a42da186-195c-40af-b4ee-0eaf6672cf2c@freemail.hu>
In-Reply-To: <a42da186-195c-40af-b4ee-0eaf6672cf2c@freemail.hu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 11 Nov 2024 14:00:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiEuh613GjBefTRe-_Eha1X1GoU=1nLt65uccSBC8Ne=A@mail.gmail.com>
Message-ID: <CAHk-=wiEuh613GjBefTRe-_Eha1X1GoU=1nLt65uccSBC8Ne=A@mail.gmail.com>
Subject: Re: [PATCH] tools/memory-model: Fix litmus-tests's file names for
 case-insensitive filesystem.
To: =?UTF-8?Q?Sz=C5=91ke_Benjamin?= <egyszeregy@freemail.hu>
Cc: paulmck@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, 
	will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, 
	npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, 
	luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, 
	joel@joelfernandes.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, lkmm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Nov 2024 at 13:15, Sz=C5=91ke Benjamin <egyszeregy@freemail.hu> =
wrote:
>
> There is a technical issue in the Linux kernel source tree's file naming/=
styles
> in git clone command on case-insensitive filesystem.

No.

This is entirely your problem.

The kernel build does not work, and is not intended to work on broken setup=
s.

If you have a case-insensitive filesystem, you get to keep both broken part=
s.

I actively hate case-insensitive filesystems. It's a broken model in
so many ways. I will not lift a finger to try to help that
braindamaged setup.

"Here's a nickel, Kid. Go buy yourself a real computer"

             Linus

