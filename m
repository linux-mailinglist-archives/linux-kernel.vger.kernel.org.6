Return-Path: <linux-kernel+bounces-439008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC889EA974
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7A0B1648E2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 07:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01DE22D4C6;
	Tue, 10 Dec 2024 07:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g746tV2w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0325622CBFB
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733815331; cv=none; b=bf3K5Tumc1V2LgHhUBdiVxzdGSLRJfVASKXfpFA8jQXm9nXAyKbHtm+AUH0dscCVupK7rN3rHgaPVyl+BU5VEIQ+O5L2p52ZYHLv1MaEZkFp/CVav5SEpKbJ4THOwTwNhVFZnyVy4V//U+FdViaAS8vFJwhMh62QGLT59FswFhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733815331; c=relaxed/simple;
	bh=JgANJvetXmjIIjl82nst3yjcT2gPPmG3hKpYbXFTbw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J0jlJmlBLuHV3nqO68daEM6/mOmWr4LVyHu6z+/LzgNAq6Seg0KImx3CHONFJCxHy2YFxDokPo+VhwdfpALVlH7zZnoY8jynuVakMcobjgU5uJYpjFb0NUnsGPZIrTiK4a8CPftwEph4UXyfLApWcFW3LAQMxWN4b4BFqQ27/6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g746tV2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7886C4CEE1;
	Tue, 10 Dec 2024 07:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733815330;
	bh=JgANJvetXmjIIjl82nst3yjcT2gPPmG3hKpYbXFTbw0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g746tV2wi685w2F5G28yyNEMLGzKqI4WaKqm4YNNi++0FWX3g98gL0rN9gDMPAeSs
	 Vk5i8QQLpk2jRwskrArklqy4fFW50VC5U1YmmQtMN76DmDgdM97mRvnwRW5HXEN2gU
	 7WlHfeufS3O9ZSATytRgdIVFFpKD1MwxiqlKnbyuN9BrzXTkLI+jbL461ZLivdON8z
	 Uw8qhnae05T0L7JtzGyAMSZeFkfCxeJZ+z283ERrTBveXYS6oZTMUT5JjF1vVk/Zs8
	 8KLJ1DqxgOH+Azp9Py1h32H7uXkKW1u92DrXTx3s6XiGxgDYfA1Rd8roW14ewU5Ltv
	 1g7ZxKOPTKDdQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5401b7f7141so1837533e87.1;
        Mon, 09 Dec 2024 23:22:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVjELcCphe49wSOhmGvkrKSqKm2MyUG8dW+8FwgjUqlwEVnA1Mp56DbmcaU+fpK+RUMTuH6YhC9Rg==@vger.kernel.org, AJvYcCWNObQFdSAPdRmqz9Ef1w1hryLD2uLwQQ0xHOhlgwJ0vOk1gqOx/F9yTpzOpHe8E9kABKAB1yH5MyUAYlpy@vger.kernel.org
X-Gm-Message-State: AOJu0YwNuKnLKlFje1z2SBltzm3teIc/dRSFf7krclwSl6OfoF0mhj62
	WXV5g5Ath8pvmMyuw+GGh04L+Ll7jlFkpl/1KioQPUi2A5ZU7ohSlt996gL7DiEaY4J3adUTa2y
	Kl96GqqSDA24tnQkJX76q8IcgI4A=
X-Google-Smtp-Source: AGHT+IF5CuEdhlOn/D9CixIkKFmGHI+XYu1ntkKIj+2KqlMWLHpsTP53kTpyF4KcjlSBayaIjQoT95J9Mbji7/lO+o0=
X-Received: by 2002:a05:6512:3e15:b0:53e:395c:688e with SMTP id
 2adb3069b0e04-53e395c6941mr3861054e87.10.1733815328190; Mon, 09 Dec 2024
 23:22:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209072020.4743-1-shijie@os.amperecomputing.com>
 <20241209072020.4743-2-shijie@os.amperecomputing.com> <d13f1879-7fbc-458d-8fd3-4340b51165fd@arm.com>
In-Reply-To: <d13f1879-7fbc-458d-8fd3-4340b51165fd@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 10 Dec 2024 08:21:56 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFJhFfhy=Gwm=QrdN6XPUd=7SKNKFBF_Z4eQ30r509BCg@mail.gmail.com>
Message-ID: <CAMj1kXFJhFfhy=Gwm=QrdN6XPUd=7SKNKFBF_Z4eQ30r509BCg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] arm64: refactor the rodata=xxx
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Huang Shijie <shijie@os.amperecomputing.com>, catalin.marinas@arm.com, will@kernel.org, 
	corbet@lwn.net, patches@amperecomputing.com, cl@linux.com, 
	akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org, 
	xiongwei.song@windriver.com, inux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Dec 2024 at 08:17, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
...
>
> Reformatted and cleaned up the above comment a bit but feel free to
> improve it further.
>
> /*
>  * rodata=on (default)
>  *
>  *    This applies read-only attributes to VM areas and to the linear
>  *    alias of the backing pages as well. This prevents code or read-
>  *    only data from being modified (inadvertently or intentionally),
>  *    via another mapping for the same memory page.
>  *
>  *    But this might cause linear map region to be mapped down to base
>  *    pages, which may adversely affect performance in some cases.
>  *
>  * rodata=off
>  *
>  *    This provides more block mappings and contiguous hints for linear
>  *    map region which would minimize TLB footprint. This also leaves
>  *    read-only kernel memory writable for debugging.
>  *
>  * rodata=noalias
>  *
>  *    This provides more block mappings and contiguous hints for linear
>  *    map region which would minimize TLB footprint. Linear aliases of
>  *    pages belonging to read-only mappings in vmalloc region are also
>  *    marked as read-only.
>

If linear aliases are marked as read-only, how does 'noalias' differ from 'on'?

