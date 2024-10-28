Return-Path: <linux-kernel+bounces-386064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E6D9B3EAF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 00:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8B7F1C221A3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79CD1F428D;
	Mon, 28 Oct 2024 23:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="sdnGTgQM"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C7A1EF92F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 23:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730159567; cv=none; b=X6Gsty2w1iE3cvC+8Q5sSDKhk72gHojBqryrFvEQEXNMLhhVeDJtg9vplGTYsS/qjcNcI7Wjn73R0jeR93I0BnYLs6nWvalGe5vcE5Exgzi3194bLDEmfXV+RmORI0Rus9Jba2S4xa33FJm4MtUAj8KCteeTa+C04WVk7570Js0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730159567; c=relaxed/simple;
	bh=tIbXoRz+grJKX0Pg3BpU/0uybo1tRz+5ub/7PaOexe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/Bvpc5BsWMA0QxWqNjQK+m6SCcGLBlaGD0Gd0BRjZ3+kuH3gNF7pjl2gy6osBI/pPPUITdRzvP0tmqX1fZ1JPN2A+zX1PDx3lGOOifywU2w1cHnQ2g2sBNQtzrtCkS/uW7EvPOzHDaYwHf54r7m+y9whIC779dEoiIoDv+UooE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=sdnGTgQM; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43161c0068bso46906105e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1730159563; x=1730764363; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUNkA7BddWMVnGRV3ZcWZ9WpOODwgvLHaMwCA3sf+Bg=;
        b=sdnGTgQMbdYSrFEuSzp2j6tIigsSCP+uhYNM3cc80z9YHdSV6djt33laNlf+wTvOLS
         uWS5Y/p6VQeS4sx4PP7V7X35AJ7uDeL3QyiGO1c7kLSKyX1+73shu5nIQrnvWHYLr6zp
         2K+DKvBnL/WnF10jETS2lv1oq8tjQsQhpX+Po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730159563; x=1730764363;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUNkA7BddWMVnGRV3ZcWZ9WpOODwgvLHaMwCA3sf+Bg=;
        b=CYUYWDzSG3jtsZ9/M6xUASWMRROqvRJMpNdiDGrlZkrP725Zo20s7MjfLrjZwQPtGI
         sAaHGgXciuc097p/5/Z3BycUkjFO3HZZ/sje4wFXG3CMpZityDpfHNbvnur489Pme203
         U9A2Tjk3UFjmOp9+CPe973E2OpEioCdMboMXCHJy4TdoTn+r3HoEY3ugWk9N0aiPef3d
         nynC6g/W7ZUC7hhhcmrJd16fXwtUwYTHBvDf18ySN2/kSETQ9+quRmA+wTx/0M8joa5i
         Veme0EMNqNdU+i287CQrhssGx8T7mVtHp2T7mlAU2KNmDun+gLZDwszH2Ldv+HWxcUtX
         vbtA==
X-Forwarded-Encrypted: i=1; AJvYcCXxGgaL3P4/fzAtGMWv3GElU0fjCbUy9d16ulRiKjAYahmkEOcEbYpumy271IjaoABxiTdmMBA75lTEt/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHLmack7pz3UOBOClJaRlta27qZn/rPMS9+5/FgDn5bYYG8Iir
	owgwNYtriDdce/KBpUmK010yA8W+AL6FEr0v0lY4a8MnjZcAsjR2YX4UCGz5I20=
X-Google-Smtp-Source: AGHT+IFzIpiIDrJyM/bLP1KzfaKFQi11v2oVRVznDwVrGRcSZ4H/R/Qcm8ilwsnf/5fI6znaZyOlMw==
X-Received: by 2002:a05:600c:3550:b0:431:4a5a:f09a with SMTP id 5b1f17b1804b1-4319ad16150mr83149375e9.24.1730159563185;
        Mon, 28 Oct 2024 16:52:43 -0700 (PDT)
Received: from localhost ([93.115.193.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b56742asm155362795e9.21.2024.10.28.16.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 16:52:42 -0700 (PDT)
Date: Mon, 28 Oct 2024 23:52:41 +0000
From: Chris Down <chris@chrisdown.name>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: Re: [PATCH v6 05/11] MAINTAINERS: Mark printk-basics.rst as owned by
 printk subsystem
Message-ID: <ZyAjya4rFmw-kE48@chrisdown.name>
References: <62e6a36052a1759e7d01669c5c760b6a1760a9c8.1730133890.git.chris@chrisdown.name>
 <87msin3j28.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87msin3j28.ffs@tglx>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)

Just a slip from indicative mood ("This file will be updated in the next patch, 
so [...]". :-)

I'll change it if we get a v7.

Thanks,

Chris

