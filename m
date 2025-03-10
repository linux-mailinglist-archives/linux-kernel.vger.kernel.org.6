Return-Path: <linux-kernel+bounces-555146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97596A5A610
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8470164BDF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB411DED5E;
	Mon, 10 Mar 2025 21:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlmndVsg"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531DF1BDAA0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 21:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741641546; cv=none; b=gZU2+SOE6AeTijENrXULqoSmhPuTvgRjwhu/NDUGXSPoeeYIXWvjBd5K9FdWH5NppH6vhO4Hn4WRsj4T9Z4Rw5GtSjFPebUnnKO2SdbXnclbflWVrGLCvxAPx/FitNfjryiVms9cnTfZDBY8GFUYZ6hBG8v5dHr9X1qGPDZ7Els=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741641546; c=relaxed/simple;
	bh=7j+Md8lZZu8OrwInvF8RF9XDJvEX3psljnYdgEnaQCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YuNUDd3xIkmTCTQnKHRBWkv95TiEDL4WqPRkwe/0+xBKCvZvR43PeRxiueC1Q5fqRCe65sNTWW/39M6OEUPCJL9ZjmAiHTcjvtEpCP6czKk5e0zLNt25qd7UM5KWGTNzAInBmaEjiXqPVAC5XxHCgEj/WDQMVPlondTrVbWy0to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlmndVsg; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30bf2513a2dso48344241fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741641542; x=1742246342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7j+Md8lZZu8OrwInvF8RF9XDJvEX3psljnYdgEnaQCA=;
        b=BlmndVsggzoWLKBIon3mCDZC8l5Y+5J4QILXCVYzJ1oUGeMzo/7/RBEp6shTymb18q
         qB1F/IPmHI402J9f9t1prXoksaUeEBLc9iYZzhnoOpPSJyhYcdWTTkfNOL7zwWvzjrAR
         ga3jRPO/1buUtDdNEg9r71VjZM1rtBS8kdQwWPfNSq5Qrfg4P36uuNl0SkNaMCj4xHA4
         gKvv2t3t1MoBi4jxcIKcqpvWsX/AW0ySgMWB1AHSmhY5BivB7ulWZILYxKDZN89c2mmv
         8FwJb4ypbapRJphDO4BWQjqvVNzVdcbrANstTGMisVB5NV9QfwoVOl44FDascjU5J5Gn
         47cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741641542; x=1742246342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7j+Md8lZZu8OrwInvF8RF9XDJvEX3psljnYdgEnaQCA=;
        b=tpz1qhCfKbr6bnEEN9xUyauFSLsGbR2ccudF+sPg5QAzvmNIMHRKmgdqkYe8Fn1uer
         43iI+NAMxBwj5zu6awGbdqs69K+hhWt3RnDDKRvNpchAm+huuj9UfwmwVGo8NtVbcI8H
         yLChl24qDHJSNCVGVmzDxLiF3IPQDQ0SxIuQF760TljME+sfXILnCYJQnvIYSC9U/GG0
         r9S7pSV8wkHukNlIizuQqq3qwmLnTqzCzz4I5TVn+G0sWCULvebcwu/LcvI7Dl4yScME
         8dzlqmPyfTVAoSvqmg2/+EaQRHqr4/QNh7mTN+rcUB1zmYaGkUlBC5nibepIx5DVWvq8
         InwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmLg2wzTdqhC5ihmmWzj4xyIieyKKk0o2wGQNtyFyo2xmRWEXHZn+u7Xu5Q5X7RFUYyQymKj+g6YD7hDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5bt9J8tRyjQWzXnLkMmWD67pMEXG7Rpifh0s2EYMsI6PI4Eyy
	HVIl/t8cIyOB/QomjYrPTYCKDqNmPi/iEpmqkM3DWN3cQInCFNVToQBPbHhFBbzuWYmWhVMC2Vw
	cJJwr2qCaoOxysvZwMtx/aZxOjkQ=
X-Gm-Gg: ASbGncuiKyPP8EsXNiDsa8D3e0ATCAsJ02FD0G2++OJMrC9VzQL0DVkWCNqyTvWuWOb
	QKNP7YZl4FJfBiDqqgBUALQA/a1JZpp9iJW7srOubBOiQoopQaiDurBv86zivXdrOYckuy6VuEx
	J68X5Lgvwljm/seC6cXrDkDMINB5EcxNuYBvs8
X-Google-Smtp-Source: AGHT+IF066+pVK8sFgPpi7vkJmc58CtIsAxIYndt38gvuPnXL08M9GeWV4DvlU3yGjsyivVG+CAkkJObRYIh56dfbEw=
X-Received: by 2002:a2e:a9a4:0:b0:30b:bfca:bbe3 with SMTP id
 38308e7fff4ca-30c2063a8e6mr4753561fa.6.1741641542074; Mon, 10 Mar 2025
 14:19:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310200817.33581-1-ubizjak@gmail.com> <20250310201227.GXZ89Hq5LVWKHjHBeO@fat_crate.local>
 <CAFULd4ZCc08kJU+3ZVdyWhO4s5fu0Y-RDPS-Y-_sPB1R0KrnoA@mail.gmail.com>
 <20250310204454.GYZ89PRl3dBR-9oBIY@fat_crate.local> <CAFULd4YwQ3dcRwugyr9-GUWbVh2cREu6qNQctKG2S5JpoEfQcg@mail.gmail.com>
 <20250310210753.GZZ89UqRTKo2OE4UOl@fat_crate.local>
In-Reply-To: <20250310210753.GZZ89UqRTKo2OE4UOl@fat_crate.local>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 10 Mar 2025 22:18:50 +0100
X-Gm-Features: AQ5f1JqjWn9ktk2Fu16C7bxy6rghfETqKY5C98EBDzR_FvN-FsTc6fryjoLIo1E
Message-ID: <CAFULd4Y=LMs0wWLwEg_WLoDeffo0T6cXhyBuWJVuSk4o_cNQOA@mail.gmail.com>
Subject: Re: [PATCH] x86/hweight: Fix and improve __arch_hweight{32,64}() assembly
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 10:08=E2=80=AFPM Borislav Petkov <bp@alien8.de> wro=
te:
>
> On Mon, Mar 10, 2025 at 09:54:25PM +0100, Uros Bizjak wrote:
> > Ok, so let it be your way and let's just sweep the issue under the carp=
et.
>
> Can you please read my mails more carefilly? Where did I say we should sw=
eep
> the issue under the carpet?

The "stop with this silliness" part? But let's put this at rest.

> The commit message should be *perfectly* clear what it is fixing. This
>
> "a) Use ASM_CALL_CONSTRAINT to prevent inline asm that includes call
> instruction from being scheduled before the frame pointer gets set
> up by the containing function, causing objtool to print a "call
> without frame pointer save/setup" warning."
>
> says that objool is printing a warning. When I ask, it is not really prin=
ting
> a warning but it can potentially do so because the compiler is allowed to
> schedule things wrongly.
>
> Do you notice the difference?

So, rewording this part to:

a) Use ASM_CALL_CONSTRAINT to prevent inline asm that includes call
instruction from being scheduled by the compiler before the frame
pointer gets set
up by the containing function. This unconstrained scheduling might
cause objtool to print a "call without frame pointer save/setup"
warning.

would be ok?

Thanks,
Uros.

