Return-Path: <linux-kernel+bounces-514661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FDCA359E3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53ADB1891A11
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D513B245029;
	Fri, 14 Feb 2025 09:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KEVQshiQ"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845BB23A997
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524209; cv=none; b=PuOuhQkQXSO9KZ7H1bUc4qRE57eO9Fk8s6dYuw/fM2D1VR9O7JVDvHCfIfDIQAmMGMDxZSopmnMSjagInNcWI364LAvkORnIQjG/8y5W10/E0AQ/u6rH2Pki4DCr1Z+vSoth7DbcxWVgzaDkUD9g/Ws7P+PsVzgPDjOHJY4mUyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524209; c=relaxed/simple;
	bh=DER3TMntGQq5jg7E86/NDM7bx6lqw/lzX8FEgotNMUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NqKsIJ3Hr8iTUnI2KK9RJ87+ogW+ulFDgqypLQjSvDxVKrhiuOtb6KmsVVUd8Zvfk30+7PMyXbnjxyKX15AkPuqoq1IDH+7RdNKcIxdztO3lF/PkEhxXwG3xSqEnqs8hVXocDYd6JFEE2+cHylKqh7/bNRwHc/LkaqVezEkIqR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KEVQshiQ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54529e15643so328987e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 01:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739524206; x=1740129006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DER3TMntGQq5jg7E86/NDM7bx6lqw/lzX8FEgotNMUY=;
        b=KEVQshiQVvW/yhbbEuawfh5arnnzKMijXiqe7mZ1k+ZNvXcfC0IxX2pESBhVrK97ue
         /fAr/yPiI88bgYbLm73BDR5OloDF6j/oYSVth3HMejKsl4KkpUulQ0+hVi4iYBqUEp/0
         UT0feugGfAy/3CQPC9nPgqP01dwccfgjAzU5896WNfNf7EWHMDb2bRilp3anPuvI5crT
         Jv9pTQMZT+q3rxzTlvpSP9T9lD4Y2io/Cecxb3qr8JducIpFzSAbh+lmUhaVXzgYZJM7
         d0mHDP85aFpytG12T5wp0W/6RL/aHvN0AXn3XfycDkhOKKKR039gCGxb8kZPcW4RYjdQ
         wDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739524206; x=1740129006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DER3TMntGQq5jg7E86/NDM7bx6lqw/lzX8FEgotNMUY=;
        b=fv3RNb49ckRc1pah+KUYDQimzzutd5dK3ikE0zstV7zJHwzhF8hKKdMuiCrXANqkh5
         4KXm9WQjindlVExDXgJxg8DvwYikFzN8llCGFlDGPZ73xWunYgq4dxJodxJSpyMs6yNk
         +CIodYnhwQFLeEx82RClq7EMxHCIaCQKCBP+xsWODD6y4xU2n4TK216OZoNj4lz2wpPR
         wweF4VvIgmBmOuK2j01X0B1mcU03c4dy/b094kTc9/3+5zxJb1uOuVoz9zVluo19ji6i
         QnD1YTnj3MqkEgTqFgMXrEdfbDfAqfnBWXgIx8hTIupP7v1AhyRSJ1WZq3GAvuqO+4u6
         NTkw==
X-Forwarded-Encrypted: i=1; AJvYcCWqLyqLQoECqK0LJpQxgEw+I48Qxvz+zQe5GCaK9FDv3NSzG34SY+0oT+HBDbnyFQJpFG5xhCWjwqBN3Es=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0PkON9OCVpANqdGoPsGlP5c0+a85y5Fi3siV7IPEOXpLyghsa
	BCiG3hLhRYFb54EhEKcHlQIBmGDdc4KygEAoPpAtMj2ZAh/JHEmMil2zjjVwXaeSLbi+oQx3lY/
	AoXEWbSC5B0Bg5wWW95Glr8J9qscCPyPC3biISQ==
X-Gm-Gg: ASbGnctIvTdZ5B704o3D4LnrzKQ0IfEOJrbifxiXqgWainwtRZ8erUzB3LxNnx5FMcn
	DZm4UKqpg9Teeiv5kZDKrvpoNOxOKq4GqNmdRZgqui6s+QS1HJmLDYSjrMn6is+Otk6z36p8m
X-Google-Smtp-Source: AGHT+IEAkug4IoXZCrjNUEs/f2U7SdEyFMpm+LMsw0oq/cisRKgOMzIhJOtnVLJvvA6rdUxdvsRrfELmDBHc4ke/nAQ=
X-Received: by 2002:a05:6512:1598:b0:545:2474:2c9b with SMTP id
 2adb3069b0e04-54524742e1dmr1124028e87.22.1739524205568; Fri, 14 Feb 2025
 01:10:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122120504.1279790-1-mastichi@gmail.com> <CACRpkdbtjS54+g-K1azE2hHeTsiyzA_gFa2NBX6QZZ3D_H5Ryg@mail.gmail.com>
 <CALieaedTCPNkMBZaaFWME9LHDE5OypcaOw0uDBK5fFFcNSO=wQ@mail.gmail.com>
In-Reply-To: <CALieaedTCPNkMBZaaFWME9LHDE5OypcaOw0uDBK5fFFcNSO=wQ@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Feb 2025 10:09:53 +0100
X-Gm-Features: AWEUYZl9vF-zSUt9bEaQ3FecnTlzAqqBsm5OSza7G4Mrs2iP2A6zz2vX5Rkx2to
Message-ID: <CACRpkdbpWgZHUn4SouR3yL_xjhjnyC0ogb8bErDuECakyhPW_Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mcp23s08: Get rid of spurious level interrupts
To: Dmitry Mastykin <mastichi@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"e.shatokhin@yadro.com" <e.shatokhin@yadro.com>, 
	"arturas.moskvinas@gmail.com" <arturas.moskvinas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 9:36=E2=80=AFPM Dmitry Mastykin <mastichi@gmail.com>=
 wrote:

> I made more tests and think that this patch shouldn't be applied.
> It removes duplicated interrupts, but sometimes they increase the perform=
ance:
> a new interrupt may come during handling a spurious one, and spurious one=
 will
> become valid (it's kind of a polling). I see the number of my touchscreen
> interrupts reduced from 200 to 130 per second with this patch. It may be =
a bigger
> problem for users, than duplicated interrupts. Sorry.

Don't be sorry about that, we code and learn by our mistakes.

So is this patch causing any regression for users? Like touch
events being slow to react? Also the expander could be used
for other things than touchscreens. If it's not causing any regression
for users it seems like a reasonable patch.

Yours,
Linus Walleij

