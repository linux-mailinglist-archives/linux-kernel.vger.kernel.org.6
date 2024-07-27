Return-Path: <linux-kernel+bounces-264282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F1593E10E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 23:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A6AEB2168D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 21:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E13374D1;
	Sat, 27 Jul 2024 21:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c+h07xtG"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E849E2837B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 21:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722115374; cv=none; b=P3exSQ5I9DRgsY0yzR9YI0DT9a7PKdZBUgli5paYAYAI6XfsN4fEe39izX471n56BDW+6/C2I2U0SeWe6L8pB1T13eNoIiM8NjSC42hWBeOExRs/ClVQIAz0Qe6V7L9CUaxyd4/UIhVsad8y9L1Dqn1DgunpbwEnFhx927VsKt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722115374; c=relaxed/simple;
	bh=hdinI02OKCyE5Ga55USht0oER3XZ6m+Y0WwuCYbDF3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1bTL1xiTocyVwJDNa1jvlKHahXB2H3dq943f1d149HdyfvODZ0rzICsmRxlEj3aAg9xFkPSGyArYxo8IKHbqAthiaGagQfP/VYlk37PSmAniClvhGVJADBraz00QIZ8JsLDK4MC5z42HCGJ4NOzfdqs6jdC9rI032hInr7990M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=c+h07xtG; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5af326eddb2so2876909a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 14:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722115370; x=1722720170; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0inHQyiIPJkdygp8SQERZj9l7moWHxGKcXFJs6tMbcA=;
        b=c+h07xtGZZtie3BVArHaklK3FSpf8RcbjnbzpdiP1FfPYBH4RJzV4pVAcmLfcz5Bcy
         UeGDmGOkk0y5O7xxPh6w53G8qhP4acWyfAc6GlUbPocjR1QCI19yeI+HaEfFf1ADTAHe
         01Z5R66RniCKSX/5hAql4qAXSsFd14jmPWhQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722115370; x=1722720170;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0inHQyiIPJkdygp8SQERZj9l7moWHxGKcXFJs6tMbcA=;
        b=rEbwSLDEGrex6SVjApDAJ/L2PRmQLxV79MHFu/utwgouZat0sbI9iECoOhQN6FFWkO
         Zr9jiQ4NcEGM+4ZXBKccxbhiPArI8jTyOfsVR1a8uMhXI+6I4gG8904uN42vr1OuUDkc
         Y2BYGnqaF8o0glfTam/eAmQJKecXGDkxx1ZliMa7hYmSg11Q8nMT9XpAkle0dt7NwOaP
         DkqM9rRkKCp9GSoPhHvyv6OeotbBHxb4EWlq4Va9/XNY9fsidDJmgXzIZq7C6KwWMbj0
         RCYq862AZw8Wl8crhAWFn2O0+GCQsJs1UFZMoJGm1jA4Cl/s/ETapWb1dGXZhd4cRuJf
         4mgg==
X-Forwarded-Encrypted: i=1; AJvYcCUhq2RhB9ffVQo4XY5Y6eadosNs8UNwwjyk0amRuzhQ1DZGyt7eAMrsBDJwav2Y8JfvEmj294rhBS7U1HL/aJIZzQtZ5QtHLUOwUSSo
X-Gm-Message-State: AOJu0Yx5aHfrrppWX8W8D+d3TCVLZfnB3NBAzo6KzAlvuOEKzVrn883K
	+elFyPu1YswnBQBh4/qGLqBr7c4tXxfPqIUeIgP52ItRwnlQJ7cV0X+yHy+Ng950oUmB2x3V04j
	5R/CMcQ==
X-Google-Smtp-Source: AGHT+IHzPn967sMZ9gC56/ZjF8JeB7i60y7I2LSanm//q+MzRhLWTDsct2ePxNbKpDtyEJ68LtJcxQ==
X-Received: by 2002:a17:907:da9:b0:a77:f5fc:cb61 with SMTP id a640c23a62f3a-a7d3f51504emr340856766b.0.1722115369904;
        Sat, 27 Jul 2024 14:22:49 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad41484sm315916866b.124.2024.07.27.14.22.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jul 2024 14:22:48 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-595856e2336so5274043a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 14:22:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWWYbaU+d40sCxaS5iQZJvNBKBhTaBUATueB9Xq77HFPKdnCZntos4yRDVfjDcNeol0IEI9k9j4uW9JjwM8C1hUUBPvYOHULv+LRDr4
X-Received: by 2002:a50:9351:0:b0:595:7779:1f7 with SMTP id
 4fb4d7f45d1cf-5b0192a4b72mr3735398a12.16.1722115368458; Sat, 27 Jul 2024
 14:22:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5e42ce13-3203-4431-b984-57d702837015@I-love.SAKURA.ne.jp>
 <CAHk-=wgs52BxT4Zjmjz8aNvHWKxf5_ThBY4bYL1Y6CTaNL2dTw@mail.gmail.com> <87a5i2ttv0.ffs@tglx>
In-Reply-To: <87a5i2ttv0.ffs@tglx>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 27 Jul 2024 14:22:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg-qQGB2iM1OeprikBWp9-nUEDaWNxwwJ00u1vmUJVtHg@mail.gmail.com>
Message-ID: <CAHk-=wg-qQGB2iM1OeprikBWp9-nUEDaWNxwwJ00u1vmUJVtHg@mail.gmail.com>
Subject: Re: [PATCH] profiling: remove prof_cpu_mask
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Anna-Maria Gleixner <anna-maria@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Mel Gorman <mgorman@techsingularity.net>, 
	Michal Hocko <mhocko@suse.com>, Peter Zijlstra <peterz@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 27 Jul 2024 at 14:20, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Only people who indulge in nostalgia will notice :)

... and the *really* nostalgic people will be happy that we're back to
the old days (pre-2004) with just a simple array that is addressed by
shifting the instruction pointer...

I wonder how many people actually use this ancient kernel profiling
thing. I get the feeling that it's "one real user and a hundred syzbot
test failures".

            Linus

