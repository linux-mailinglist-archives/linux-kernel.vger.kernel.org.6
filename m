Return-Path: <linux-kernel+bounces-275614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F659487A5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85CACB2361E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8C9F4FA;
	Tue,  6 Aug 2024 02:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GFOC4Jvh"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE722AD51
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722912029; cv=none; b=sWCmY/L6V0Vkhm+AxyQ6i/UIkBmEviE9xl/gUcf62YloJv1fkIt8JUgy43IbuvlyrWD6ytPlBmgXfUG90FlxcZRKMTzXkbxc3YMWAUwFg281YbE1FXXaQ1/UeXG1n3vusoUdh/FAhOR7gr3eXjSdqp065nbjMKvkV9yX3Y9Z1NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722912029; c=relaxed/simple;
	bh=COfUYXbJKUveep27uxZ7UXw2hvYIRWDjK4rBCDkRRAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d/aimggjaWmK21iU6LlQIe8V9szX3h8fVDI74RtmfnNvlNOs3V1azuzgFzZkR489JHVFiXaqoBb16dAUrIXEVvdiCFeAn0tnLUbDSoD0Zn4VfEGxkQUqpLcpwb+jZ1zUles3KZVaU/yI/uJNWvxzMcFLhWuX/CsAVDFCpNiP6e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GFOC4Jvh; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52efba36802so96445e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 19:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722912026; x=1723516826; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GiE3uPG+buMywDt07lopvW/6Wu6VAkpcGKr+ydokuls=;
        b=GFOC4Jvh0ufsnvDSjEURgqBblnNnKhlNuEMvyPyHFeou27rsKpxY9U3lt58xrsRLqO
         8/zChyUPxk9dScbg93Iv0uz3d808Cww3LH8IRf6zqfmEUU/NEY2ylxGeOQ/NJPsX45rq
         +YstH0xrojyKC3EWCz6JPc7+7MpcOIkstzYr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722912026; x=1723516826;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GiE3uPG+buMywDt07lopvW/6Wu6VAkpcGKr+ydokuls=;
        b=WhWG6r5DY8QtJRg1kiJZuDZAf7kabv968zgQc6rsjcnA5g4fSvOE+mS8BlqBSLe4p/
         CY9/cCwX4dzNjzNWZXG6uut2JLVtVBtAWEAd4b0OB9UomwNRuKZHhx+I2dRRdjJaKaC1
         L3eyhbUtcVdUvJeoP0TAX0tCu92ukgUIfIiEef5uuiFmsRgkFwitvX8qluDvJ77xhKC8
         YK17jwLtlMXC/lUiQHLAUxTT9JidFifUjCiXjXp1a9yTds6JhqRgPuttPDdj7Cp3Ehx5
         tuCeP0yvnJ04WjHL6c1yKCPxkNKeozQZ3WLzME8nt3iRzIP6FhZmGYXxyrM0Ire7bh+O
         O1Jw==
X-Gm-Message-State: AOJu0Yw4RpJO5lvYSl0Dl+HLDmvtotHGF3zZXdYaeDAlG19uM/0cMgWD
	Aa3UNGvAkvjrpPGBxAR1yFz7gl9PEVjucnGurA+eKGMZsitdB8juiJdsWgZw1rkq0S8zU9RVUeA
	uMIMbww==
X-Google-Smtp-Source: AGHT+IGSHdtVEX2Gr77kHaBn4I2EcSbDFR14agSyHdWPa293GsDcyyqoPHCwXT9LvFzP5qMV5NXDxg==
X-Received: by 2002:a05:6512:2395:b0:530:adfe:8607 with SMTP id 2adb3069b0e04-530bb3a2bd1mr10753035e87.51.1722912025297;
        Mon, 05 Aug 2024 19:40:25 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba4a512sm1303163e87.300.2024.08.05.19.40.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 19:40:24 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ef2cb7d562so873481fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 19:40:24 -0700 (PDT)
X-Received: by 2002:a2e:9816:0:b0:2ec:63f:fe91 with SMTP id
 38308e7fff4ca-2f15ab01fe6mr97347991fa.38.1722912024066; Mon, 05 Aug 2024
 19:40:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731095022.970699670@linuxfoundation.org> <718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net>
In-Reply-To: <718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Aug 2024 19:40:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZ7WJQ1y=CwuMwqBxQYtaD8psq+Vxa3r1Z6_ftDZK+hA@mail.gmail.com>
Message-ID: <CAHk-=wiZ7WJQ1y=CwuMwqBxQYtaD8psq+Vxa3r1Z6_ftDZK+hA@mail.gmail.com>
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
To: Guenter Roeck <linux@roeck-us.net>, Vlastimil Babka <vbabka@suse.cz>
Cc: linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"

[ Let's drop random people and bring in Vlastimil ]

Vlastimil,
 it turns out that the "this patch" is entirely a red herring, and the
problem comes and goes randomly with just some code layout issues. See

   http://server.roeck-us.net/qemu/parisc64-6.10.3/

for more detail, particularly you'll see the "log.bad.gz" with the full log.

See also

   https://lore.kernel.org/all/87y15a4p4h.ffs@tglx/

for this thread.

I don't think this is really a slub issue, since it only happens on
parisc, but maybe you can see what would make parisc different, and
what could possibly make it all timing- or layout-dependent.

                 Linus

On Sun, 4 Aug 2024 at 11:36, Guenter Roeck <linux@roeck-us.net> wrote:
>
> With this patch in v6.10.3, all my parisc64 qemu tests get stuck with repeated error messages
>
> [    0.000000] =============================================================================
> [    0.000000] BUG kmem_cache_node (Not tainted): objects 21 > max 16
> [    0.000000] -----------------------------------------------------------------------------
>
> This never stops until the emulation aborts.

