Return-Path: <linux-kernel+bounces-420622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5149D7D70
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFF79B21A29
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01B618CC1D;
	Mon, 25 Nov 2024 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uN9xHY4X"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E99916EB54
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732524555; cv=none; b=MvzEnv+ssYgwoDwmNJeKylcYxUJUx0lHoIb6g8s4GhRWqMhmETwOko1EvgzWVL/+AwPOjN2ih6BDzuERAiur35X+dc5DTY++7Kx84IacIuZiJQ0KDJaTD9jPQVAz9kxYx4eIGDVkIMj1gZ8GwTBEhgC/G/W6qf+NYE8x89Anvss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732524555; c=relaxed/simple;
	bh=4RLgH8DotN31qT1086DXFyu/dfqEgTSa+OguTyYp7nQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bq2uYzRpwZPkTWJunfG6RQxg3NHSBHFyfHxuMes+pNW2RcIBJ+ekbNLJ9TG4U3f0jEhTG94TetiHb268f8ulA5aGUkv9ch+bMvBc3PXK41bUCy4TmLrux7HfhMv8ZKB4lBsjV9Dzre50UdpluRf6adLPqhHtYc/+mE/SzWpI0/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uN9xHY4X; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53de27f1478so1088940e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 00:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732524550; x=1733129350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1rTcVpCTeLQN8k+ZxIX2C9rl0ao46Uuxk14w/Clbl4=;
        b=uN9xHY4XDaJK76C0oaPzqSxcIBGCK0LRvWlR/9CTkqXOUFULuR/ob61uS38WkJRfYE
         pG6o9A4xE575WihsnVO10QfDxE430ZxRQiB7gjDm7IYBjxKYe6wE1P4RSPBna56Jpuvc
         5tBF7GnESgzbHIlybIJ7NM/zlPT8tMyv9Y4f4eDgPrexDjzhbMJGeAYyrKF7aGej5v0r
         h1KtEhFF8DeS9yuCzYWS+SPMBhEaHxrIcTSucjHjhQtESW+jw7ypMNp/JLrxTTE5p+bD
         STXj4QY7qA4fp3bSKG9WsenE7Y3irTHqGjx9poQ8nglrNPOk6Yd24+WNvnl4Eu3ZzgWH
         gWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732524550; x=1733129350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1rTcVpCTeLQN8k+ZxIX2C9rl0ao46Uuxk14w/Clbl4=;
        b=B3Oh/MpWd4CjbbJkgARPkfyQwAg3DFL16iVWcZ04YlIiqTCPqs3nzha3HltvyjKTYb
         hWrV2FIu6byr9IzIFlrFd3wK8KpHKnY4Yk7xZ8SCYz608Y0fCgcinvYoDj9CZmSH1r/U
         eomYEG5cP2ByESisBb0jIkyXq7fU+WG0lwLPj2I5HqZWvXTuHISRcaKyFX4loOsUoLyq
         8BODd1yKQUNJ5LhuhrHkXeCpZGbgyAU4nDY2W/rzzF1hfUOftSidPHvkD605Vog4e4Cm
         IhEWewpal+lk1Iq+/QLTNQ5HPW1nEDfdJ41jnpg4V6mhjFxMIKBu+JA22qJsYH4DUpfl
         KQow==
X-Forwarded-Encrypted: i=1; AJvYcCWu+TF7imYfvXz2EDjpJjzMzqyClrrECDn3j0stCJvYiZ0+4WCGOnjD3XTCoO2a1eljcY+U7qWoV7m+bbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeS4A7GSq8au/sEnMT91qO9WBvDonlexTAbY3WObZM9Ed3YjFw
	8yIc93a9O3zU7W2BdiJl2nJUnzinx/J0Pzne0KT9yjkBiSLMPSuNXk9f1yJd0K/CNNJegGKQw55
	IQvkmlfp1D+SR6e5FPParYb57CbjEY5VVwil8vCgLEr+nJe05yqTcaw==
X-Gm-Gg: ASbGnctzqlhntM1n2XRVup35GwIGbs2unlPui7L8tjmp53af+XgOWUCGFnTxEVE9eLW
	vtPsupYXbOSJMn4dGKmRvr5p6LrTDCRw=
X-Google-Smtp-Source: AGHT+IH0qO8VgtI4FMGXsSFrTONtuxq++JyNmNCc2iSKwpaIiDBK6LvgvP+XFRoiMgkpMn299iGAQD9EbtbxgwqveI0=
X-Received: by 2002:a05:6512:3b25:b0:53d:e397:2dd2 with SMTP id
 2adb3069b0e04-53de39730d7mr1168732e87.2.1732524550278; Mon, 25 Nov 2024
 00:49:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACRpkdZWqTOTzYYgD-wAps2Ygsh-D+nxaW76hrWSdTDZZKBA_w@mail.gmail.com>
 <Z0NaYhtZy89ObgmR@sashalap>
In-Reply-To: <Z0NaYhtZy89ObgmR@sashalap>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 25 Nov 2024 09:48:59 +0100
Message-ID: <CACRpkdaZ=YvMSLYWUrmsjknk-gNV8o5v_y8sasRcxweyTSkKHQ@mail.gmail.com>
Subject: Re: [GIT PULL] pin control changes for v6.13
To: Sasha Levin <sashal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 24, 2024 at 5:55=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:

> I've just hit the issue you've described in this PR:
(...)
> Is effectively a revert of one of the commits that are part of this PR:
>
> >      pinctrl: aw9523: add missing mutex_destroy
>
> Would it make more sense to just re-do this PR without the offending
> commit? I understand that this is a fairly small fixup, but I'm
> concerned that this will just create confusion later on...

I don't follow what you mean I should do. The offending commit is a
fix and it is already upstream since -rc4.

Torvalds could probably fix the issue by simply reverting
393c554093c0c4cbc8e2f178d36df169016384da
instead of applying the fixup though, it has the same textual and
semantic effect. I just tested it and it works fine.

^Torvalds: looks like revert on top is a better idea than fixups
so we don't upset the stable maintainer scripts.

Yours,
Linus Walleij

