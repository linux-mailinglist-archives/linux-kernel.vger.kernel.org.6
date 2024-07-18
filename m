Return-Path: <linux-kernel+bounces-256301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAA5934C3A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18CE82834A0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1691312EBCA;
	Thu, 18 Jul 2024 11:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b="xJ0Y85f3"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7978B4D8A1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 11:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721301046; cv=none; b=GbKMHwgbUjtjR4scTEFKAJv7N6gOqUhtrBugqXiRDS5HpZI/9O/hG7FjHaxmLJ+Dva083oief/3ifIPbzTSj56UYjP4GzPwdE4FpT9hm1swcYr8cBHdHpyyCba7hN0+mUhx6gIU80KozvXUN2UTxuCCPqCLjWXcGccdVcTsTxVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721301046; c=relaxed/simple;
	bh=g2difOvlWIEO63yHi+zzCArMOSeh2R/YOZyOxHPP5y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IXLf9d44jpIN65G/Soadf56JZ+W0iynAWA2AmQDKCoV9520/bd3Njc9GZq+pGh8pJ8QXK9hdPM+jZ9iNbLMEAPF9gNWRpC2+DC1UdRxphgfRWx3WShBSePcra+CmFPbgSYKl+iIYZqwvXtI0XC3p2NIru9x/MgpJcPRyxCHtjIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=none smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b=xJ0Y85f3; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79ef72bb8c8so8113785a.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 04:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20230601.gappssmtp.com; s=20230601; t=1721301043; x=1721905843; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g2difOvlWIEO63yHi+zzCArMOSeh2R/YOZyOxHPP5y8=;
        b=xJ0Y85f3mfdBeKtiCg7XdEZwkFGTICo8gm6Q2EFOnFpfghD1KbWYLHERZABaJGDmzg
         Yuk8Ld5Ja7lOHq/DZvasjXIDKNw5A7F9Jlo8E1bxE0hMVpIZkMLDI279uA5W2MSvTtVr
         9Du9ryY5Iayxmmco/EeobRBxwvjQ4V8Nxf8mnMnlSbyUFXmlVI+c5MXEw0yjTFHf1Rb5
         jCSEVyDMAafWTSPflv5qcYmVfP/MCEEuFxaCSP10LHt8hiq2y8CC2WZKbUA4JPAEyWyX
         X0av3t4UybDji3OrdbJN/HShdM7U+t54uvWpgoDK4W0ESorNkpCPzHeEOsUMeBiTjUea
         PW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721301043; x=1721905843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g2difOvlWIEO63yHi+zzCArMOSeh2R/YOZyOxHPP5y8=;
        b=N5zxTgXf5IiyghrItLkpUm9UZ5vWwnPPEmTH98N24PBzVCpW65AAagMZBRECPMX7/1
         6JMwTQsgJ0RvTR0kuNvYgcosfL2heN3LwxgUa0IY4jIeOiWmJa7CLIR9JGq0ANFJ71HG
         B0GbYTmi5hWpMrxDfdrnIIElt0eKyJx26D49e05Kwy0xWVHhO6vx5ONrVj4ATsS8U+zm
         2l/tlP7xakwVyJfosPm+BDBLGPFaT8fdT9aIJUXEmBgO3vhpX8/+EJLusDTfLVN3umW/
         1e3MpGxRbcP1Z1s0+SWNO7iPX1t4eOgKVsH4ixOwQDPW7RHpqtbPX58LLdZ6920/QErK
         RDwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhaJapagiLoRx9MYjrRmRXne+0fp/WEGQHNUO1YxwEZBDFy2SdsgSyCGOqcR2OA1UN1KbdHx/ZZxd00S9AAcrsWnf3Klv33IclJMPN
X-Gm-Message-State: AOJu0Yz9pqgERs/Jt+uoGLbVYZcOWgOtfbP1CHsqgfN8jZz0soaGfyLJ
	Ne0nJz99u8k4q6fZWo6bUm+7HBv3elLcjgP4jeLC/zbpTqXj80y66+chGMjeTCDbO+eyDAmuG4N
	xP9agfunIaqr9XoMHov/xWo5LWXItmg3Nj0mTDA==
X-Google-Smtp-Source: AGHT+IHkpXrj6tfe5GKUAxDloIykkCd7pSLfu610KYCjUhm0uSHpFNmHy8/JsbORj2vqFg5Eb30UAAlM+BNEUmR4XcM=
X-Received: by 2002:a05:620a:29c6:b0:79b:ea85:9f9f with SMTP id
 af79cd13be357-7a1938c1e9amr47232985a.2.1721301043317; Thu, 18 Jul 2024
 04:10:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718082410.204459-1-angelogioacchino.delregno@collabora.com>
 <CAGXv+5GBg73kWuiDt=9s7M4oJeHhWOF3bPY7Ju+qn1kJgNNaGw@mail.gmail.com>
 <CAC=S1nigoJWAECBrm-Q=Co1-qd_yUhx3R4D9=dYeUV=gr5UYfQ@mail.gmail.com> <74e7477b-81c7-4713-80cc-1cb476185bc9@collabora.com>
In-Reply-To: <74e7477b-81c7-4713-80cc-1cb476185bc9@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 18 Jul 2024 12:10:32 +0100
Message-ID: <CAPj87rPZRjmMPjaOY-UH4auTuMS6mh9N7=maRBzxut2OgtALbw@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Set sensible cursor width/height values to
 fix crash
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Fei Shao <fshao@chromium.org>, Chen-Yu Tsai <wenst@chromium.org>, chunkuang.hu@kernel.org, 
	p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch, 
	matthias.bgg@gmail.com, shawn.sung@mediatek.com, ck.hu@mediatek.com, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"

Hi all,

On Thu, 18 Jul 2024 at 11:24, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
> Il 18/07/24 11:27, Fei Shao ha scritto:
> > This matches my preference in [1], so of course I'd like to see it
> > merged... if maintainers are okay with it.
> > Given I've tested the exact same change before:
> > Reviewed-by: Fei Shao <fshao@chromium.org>
> > Tested-by: Fei Shao <fshao@chromium.org>
>
> Thanks!

And:
Reviewed-by: Daniel Stone <daniels@collabora.com>

> >> OOTH, Intel recently added a feature for enumerating "suggested"
> >> cursor sizes. See https://patchwork.freedesktop.org/patch/583299/
> >>
> >> Not sure if other compositors will end up using it or not.
>
> Yeah, that's good, and we might do that as well in MediaTek DRM... in a slightly
> different way, as it looks like they are simply hinting the same values as the
> mode_config is declaring... while we'd be adding a hint with a sensible size that
> is less than the maximum supported one from the overlay.
>
> In reality, here, the issue is that the most popular compositors do not support
> overlay planes (as in, they don't use them at all)... my first idea was to remove
> the CURSOR plane entirely and declare it as per what it is for real (an OVERLAY),
> but that would only give a performance penalty as that'd become yet another unused
> plane and nothing else.
>
> If at least the most popular compositors did support overlay planes, I'd have done
> that instead... but oh, well!
>
> And anyway I hope that the maintainers are okay with this because, well, otherwise
> MediaTek SoCs won't be usable with any popular WM.

Every compositor is going to use it, yeah. But until it does, people
are just going to use cursor_width and cursor_size. A lot of older
desktop hardware supports only a single fixed dimension for the cursor
plane (hence the single values), so rather than guess if it needs to
be 32x32 or 64x64 or whatever, people just allocate to the size. Not
to mention that the old pre-atomic cursor ioctls actually require that
you allocate for cursor_width x cursor_height.

So yeah, this is the right fix - though you could even be more
aggressive and reduce it to 256x256 - and supporting the CURSOR_SIZE
property would be even more useful again.

Cheers,
Daniel

