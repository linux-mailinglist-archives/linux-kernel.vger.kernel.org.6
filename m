Return-Path: <linux-kernel+bounces-524842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB54A3E7B9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3713AF3EB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911891DDC3F;
	Thu, 20 Feb 2025 22:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAGdJ3Jr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3303286280
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 22:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740091542; cv=none; b=M70BlOZA7J/CipdnbeDGCQ/p0YjMy1aXMX3xKGlmdtBuaRCvQOI93ezzSUpyScZ7a5ZGa3cGljRwaQETgOggfyTTAAFq80ivBaa/SybvWRN78AJRkgYRE9DO3anBnG+KXBuNLg00XDUeVzGl01W6s1XYbz4V0/H5fVuvcuGn3ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740091542; c=relaxed/simple;
	bh=1RKFvNFgnbVUB7sQohFik+Vnvtz5LrNqQpGq5s4uJQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DeI4TXC1OZCWhZ7/L7W016tU/zEzKz+TQDqhZo8/c+IdkBlOZxQpEpFHsFNFc3vFE0BzyzL0WWoaqf01wm/mQNdg5wTFv+YLKRI5OOeDlGBA6tUEg2KWqBi1Y8Y4qRhwAUSd63JFf1OGcQnc37dVoo95NxZ8hcnCr1kpm5PlJ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAGdJ3Jr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DC8C4CEE3
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 22:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740091541;
	bh=1RKFvNFgnbVUB7sQohFik+Vnvtz5LrNqQpGq5s4uJQE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aAGdJ3JrNIKa1yPlifrzuaBKrzGtWrmkAwObr8sXI59uMFjl1gpYCNpu4ICZtX2ia
	 5DPEK8rZCqWVVWeKMXToBj9bVeCJ0O1n8CpO2KlE+WetP5+3HnI7NWk3jSWAXmzl+U
	 j2x58gwi0Nc7D1sqGyQ01B+Bw9nIybJgRgZ5TfGykAFxNDtrpbOWZ7FpSkmn6woqeo
	 mKNclJ3n+pj1iphPlk6HD2VKy2vecDK68duuVrBitFUzpQJwkEK+BbA9xX8d+1a5Ry
	 2HOAYLEahtR4HIsHb1mK9yxr0CqFEAAAHlrGms4yBoO5Z8Igt/S2FvSvPiuRQ0+9tE
	 r6UhFF5LCw38A==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30613802a04so15821981fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:45:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXpWDEqCLntfxT1pMKQDz29IQjPX7he4DnmM2OMAr5tYj8GTjWhfHAd6bgR91Vhi5FW3+sVkXSwks7rdns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxux+BGpCv6+SGNz7q/OG58o6i5yhctLGfoMnq78yR61SkUbqSN
	m1nGhISDDsCV5hmXWmUrw3HeyrUp0hRta4WOp3L08BJib8RePaohEbzektlzCyZrdOoTfrdMoVl
	+a9DPAG9OMl/B+zL8DL27yLmcwww=
X-Google-Smtp-Source: AGHT+IEMZF6f8GfEbahsZWoYqni3RDwernAV3UsWUx2CDg6uQPWKDHJtxur0zF/64FFaJpwtPbmIuvNnLpRy5TP8L0k=
X-Received: by 2002:a2e:9a8a:0:b0:309:2175:ac0c with SMTP id
 38308e7fff4ca-30a5b182e27mr1209971fa.15.1740091539744; Thu, 20 Feb 2025
 14:45:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219105542.2418786-4-ardb+git@google.com> <20250219105542.2418786-6-ardb+git@google.com>
 <20250220212515.on6esv3rffkmdbkq@jpoimboe> <20250220212718.idjwb33t44d6fjbk@jpoimboe>
In-Reply-To: <20250220212718.idjwb33t44d6fjbk@jpoimboe>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 20 Feb 2025 23:45:28 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFQgFG-68FQtvpmjssAAPu_E-nwqT1+qijz6NhxwrMD+g@mail.gmail.com>
X-Gm-Features: AWEUYZmIYaPNqmQhIRhdI8IrFJPPN58B09nBeM07NX1Es7Q_3K-EBhhj5Xplkzo
Message-ID: <CAMj1kXFQgFG-68FQtvpmjssAAPu_E-nwqT1+qijz6NhxwrMD+g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] objtool: Use fPIE compatible ELF sections for C
 jump tables
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Feb 2025 at 22:27, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> On Thu, Feb 20, 2025 at 01:25:17PM -0800, Josh Poimboeuf wrote:
> > > Fixes: c5b1184decc8 ("compiler.h: specify correct attribute for .rodata..c_jump_table")
> >
> > Reported-by: https://lore.kernel.org/202501141306.GYbbghj5-lkp@intel.com
>
> Or rather:
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202501141306.GYbbghj5-lkp@intel.com/
>

OK i'll fix that up.

