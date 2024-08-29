Return-Path: <linux-kernel+bounces-306364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC634963E07
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AECA1C224A2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5C518A947;
	Thu, 29 Aug 2024 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCWcbbvv"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D60818A925;
	Thu, 29 Aug 2024 08:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724918848; cv=none; b=he/Jvk9KP63ZVyaKbfAWbeRjcnQUjUYKw0Nwx7B3dFbAIwczrIhmDXC9gWEBxnRQ0Bm+GthcfaOU4gl4F3/ZUstCmoLMGQUhkJapip56v5w4q9Yx4pz1i6LA+Rj0sk1EwdRfPetWXSoJUwevwDYFYQCHrvoKip8uu5Cxla6RlrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724918848; c=relaxed/simple;
	bh=6D9s2PHaOeXO0+gGj2oPHhq3N9H2yBwvLb6+qVDuqZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qgte7xeX1qIhCMahZtV+rRxj1apty4pVw4B5xMQuGK3K8DBVmRh+u4ll3heStH1wAuCG12/S7PyoW77XCcG0OD0GvyageYtIDDgQ7QTfZcn4VIMZz2XT0+WRyJwpQ8DzYQwELZzfuFqx8FWpbr38pTB68TAUQW9YI2OBwYOFkOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCWcbbvv; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-68d30057ae9so3860617b3.1;
        Thu, 29 Aug 2024 01:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724918846; x=1725523646; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6D9s2PHaOeXO0+gGj2oPHhq3N9H2yBwvLb6+qVDuqZY=;
        b=ZCWcbbvvV+bwptQZpd2WNo+rEIzdSCjE7XyZ2xwm1eexR61NzjJbqQDzwkP6Fd0Mt/
         J/Ql5yRsW4fMQxu910jfoVn83Nz4xEYkuPkJL/NM7yvmwkphhAsacyEMuMYJMAUCkSsM
         Us6q+VLr95uCGD8rqmoLOyfqmkYf2oKphEK5UMZEDGWTTT1v/TL2RZrcXJsK9l8qqYBU
         O+WqIFYyAyh2NYG3eEl5TcCdhKhJOWEmen7hytJvJOauvjUZLY+WSeqNyWZzcsqGFoLc
         Kihg3SwyEmifEn8pXll4eF6f8qR7F8mND+wwXS1B1zfRDqCFawPHfsgFAoS6YVb4CEpJ
         ITag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724918846; x=1725523646;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6D9s2PHaOeXO0+gGj2oPHhq3N9H2yBwvLb6+qVDuqZY=;
        b=LCu8BLFH0f7hagbIN+q5FwjdOexb76gCdXUdsERsC7xiTOvg+79PYW7B9Zktr4Oqgm
         iorfRJbkg7Gpn2dSg9L76BM0fxUnG5hlzIPdxzuzw70XjcUSynrpvwXxYsA7dM14aE5E
         BAebmm4or31wHXJgrQgDMvnxk7nlN17yYuwK5D9cYmnLgQbUtziLssLyRevUXw4G52Se
         42qbsGrRtJliIu2Msjt5cI6EWinPVJDcgmvqXEza7Jj/66870c4IZMfVZYuoeuA81gw5
         BUjin4fnCGIJkQtQD1cR0DalIaFJv9kCKa6lA5a8ZyzJ0uNrrN6ShSGZaHlZ+HdjGoKN
         TmPA==
X-Forwarded-Encrypted: i=1; AJvYcCW3+oIcP4tOfAjj56KsF/9iy6g82pM59Lo8PaOJAkrytb9XaqB48B/icLwdwSRWGXOusCQp3ExElmgV@vger.kernel.org, AJvYcCWOUTsT4nhD7Ohe1wHk/qnUwoaklGhXs8+rfW0J4XY6N1hAw2HrM4TDjHnwpWnegdnVq3o4j6H1Pc6BKhJe@vger.kernel.org, AJvYcCXN3hIKEqQGXDjjSmHyRBJDsUQpo1QgXje1KoJXd0Erfu9M6dymM8+c2zZ/hZJuUl5UBu58ofYMbkD4@vger.kernel.org
X-Gm-Message-State: AOJu0YzomkzBS8WEb2Dxp9460Zjk0Z48XtojbEiMDfbE7P6CGS6VNczU
	TyEcuPolueOqqlWhHBm7oRBN5+mmouja+2rEKPjRVsTriOejEBiZdRgF8rvCJ+2FNTlcTZLKxUG
	YOzhJF3KGJOL49yg9OlsAreTeFNQ=
X-Google-Smtp-Source: AGHT+IGI+aiI64QeCszkUSpdOS1NlRrB8CzhcK6/Tl8ikOKP0qadNbGrBXByMOplW48ZmJTnXiN3tu7FN/K4wcAWEYs=
X-Received: by 2002:a05:690c:6608:b0:6b3:a6ff:769b with SMTP id
 00721157ae682-6d272708f30mr24127897b3.0.1724918845847; Thu, 29 Aug 2024
 01:07:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815150255.3996258-1-tmaimon77@gmail.com> <2f21322a2412684c6aa7bb7d817e861c.sboyd@kernel.org>
In-Reply-To: <2f21322a2412684c6aa7bb7d817e861c.sboyd@kernel.org>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Thu, 29 Aug 2024 11:07:14 +0300
Message-ID: <CAP6Zq1hxwb3eWakPJecWXbt6_JqOmph-72bRn6pztxy1KiuF+Q@mail.gmail.com>
Subject: Re: [PATCH RESEND v27 0/3] Introduce Nuvoton Arbel NPCM8XX BMC SoC
To: Stephen Boyd <sboyd@kernel.org>
Cc: benjaminfair@google.com, joel@jms.id.au, krzysztof.kozlowski+dt@linaro.org, 
	mturquette@baylibre.com, p.zabel@pengutronix.de, robh+dt@kernel.org, 
	tali.perry1@gmail.com, venture@google.com, yuenn@google.com, 
	openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Stephen,

Sure.

Thanks a lot,

Tomer

On Wed, 28 Aug 2024 at 23:54, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Tomer Maimon (2024-08-15 08:02:52)
> > This patchset adds clock support for the Nuvoton
> > Arbel NPCM8XX Board Management controller (BMC) SoC family.
> >
> > The NPCM8xx clock controller is created using the auxiliary device framework
> > and set up in the npcm reset driver since the NPCM8xx clock is using the
> > same register region.
> >
> > This patchset cover letter is based from the initial support for NPCM8xx BMC to
> > keep tracking the version history.
> >
> > This patchset was tested on the Arbel NPCM8XX evaluation board.
> >
> > No changes since version 26, only tested in kernel 6.11.rc1
>
> Thanks for working on this! I'm waiting for Philipp to review/ack the
> reset driver part. Until then I don't think I can apply this series to
> the clk tree. I'll add a review tag to the clk driver patch in case that
> helps.

