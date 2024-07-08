Return-Path: <linux-kernel+bounces-244832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22E792AA08
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3181F285DA8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939ED14B95B;
	Mon,  8 Jul 2024 19:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mxpqE81a"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842D320DC3
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 19:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720468022; cv=none; b=XK98qYwDJSwhlCEAM6DUk7Eln2gDT7qiGb86SvVU6STzwRFB+1xIxEEtxvwDeZ4rZBu9zQIeRenJ+/SbKyLMTIC7qi19Qa+pOBF+ksxWmn8ubxuqizbn3RcTK040B7wfhmjmrbQIwMX9rUE9ai00GEm1gfrETNuMgnaQltF/kKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720468022; c=relaxed/simple;
	bh=xfUwHFgIQzzqJP6stxoZusU7xDn7i1MUCcKHTwTW1G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2tPX942RBu/2axGlHu7Td/4vYhXq47tt5IxveLjaBJp6h1FcmjWYN5JdmK+eNBsZqmrThmI4pdSwsv5WoH6od/3KaTZqHZOUkrQvtFpSc7JJZrqp7BolIUnAv6V3dS0NgM2SAn7NaxjpuproOAKR4FlhoOpsC+8PUlBtdDESYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mxpqE81a; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3818c2d364cso19681295ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 12:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720468020; x=1721072820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NWkzAQQtVxjkKH80LNYbBQ6QWoqweGmef12U+XNbKY8=;
        b=mxpqE81aQWiTYlUnXRU+rSop04gIYr92zHo69qkzfebkHfTEVQRFhy4VEUrPdSQw2H
         89P+4envOytRCs1/0Ic0eE5xPYMkLZEgt0d29jnwhWMULUBhDugBjq/4JkQuQ9RWZmjl
         oUoUiJdw4Gkf9g+xpFuS/jk6ANezqkUIA9L4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720468020; x=1721072820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWkzAQQtVxjkKH80LNYbBQ6QWoqweGmef12U+XNbKY8=;
        b=sz3hkp2bQoD9SLFSJkKT7QiWXlS1zx9FW4yFKJIfE5xgxUw393q95SpwOJbWcMkD3s
         Pw75dYwxXcVda+awR3n/tqvVwwzScFvHVUFmTlSnjrhMp3RWlPX2y6Qam664AR2r9IFj
         JqTOlOYFHjDfkEltPZnSxV//2aTczQwXzpgTfCxrdOZbGmPLw2ZrYOjUviceN0h+pF1X
         Me/Q0kdufY/9dp12Ib5ovmWkhNHIBhXHmuIkjPNpmwu7lbCmwpxvnpkxqbiifHFVS+Yr
         4uv7ESXv35NpSDlD6VnoxxAqPwvEAP60gxqtxMa2Bnbkjk1QLORBdjm8HQxRvf87NSrs
         WnIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT4nKlf5T94JvNBdD/sEPRnsauEgfUCRi1Q893BG7bwNEafYpI4OPqH7G9hMeAe+iiNRBljyNwshVjV1LVbjbq41KroJaEJ38Zffgs
X-Gm-Message-State: AOJu0Yw64Nn6eLdgT8Dt4BmYzxa16i98jw+bRnTXxognk/6XV6vhb84m
	TwVSG2lYAx+1nLvtJ25MB0XwjHk32Uggab5MufeW+BalZEV7DBJoKJCkgIx/qg==
X-Google-Smtp-Source: AGHT+IErjqc2QuiwhjqsE6ydLSlVepI8J8lRB04ybk799vAbtxt2hOpEu1DCYDbIFaBbcAs4+l8Lkg==
X-Received: by 2002:a05:6e02:18cc:b0:375:9e20:beef with SMTP id e9e14a558f8ab-38a53e858b0mr7958815ab.0.1720468019700;
        Mon, 08 Jul 2024 12:46:59 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:3e22:9cde:6b65:e5e8])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-77d603f9bfasm192237a12.30.2024.07.08.12.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 12:46:59 -0700 (PDT)
Date: Mon, 8 Jul 2024 12:46:58 -0700
From: Brian Norris <briannorris@chromium.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org, Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] cpumask: Switch from inline to __always_inline
Message-ID: <ZoxCMp_ZQ-Su-r0D@google.com>
References: <20240514204910.1383909-1-briannorris@chromium.org>
 <ZnsML1RYMmEhhdPP@google.com>
 <ZoWhPFJIvGpMGKm4@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoWhPFJIvGpMGKm4@yury-ThinkPad>

On Wed, Jul 03, 2024 at 12:06:36PM -0700, Yury Norov wrote:
> Hi Brian,
> 
> I never received the original email, only this reply, and can't recover
> any context.

That's unfortunate! I don't know what happened there. My usual culprit
would be something in the DMARC/DKIM/SPF spam-filtering space, but:

(a) it made it to the archives, such as:
https://lore.kernel.org/all/20240514204910.1383909-1-briannorris@chromium.org/

and

(b) I don't see any red flags in the mail headers on lore
(https://lore.kernel.org/all/20240514204910.1383909-1-briannorris@chromium.org/raw)
such as DKIM, SPF, or DMARC failures.

Anyway, if you just want the original mail contents that I stripped from
my "ping" reply, they are available in the above archives.

Since I don't know what went wrong on v1, I don't really know what to
fix on a v2. But if I send a v2 and don't hear anything for a while ...
I suppose I can "ping" again!

Regards,
Brian

