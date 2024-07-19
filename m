Return-Path: <linux-kernel+bounces-256815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC24C9370CB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 00:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 604ABB2248F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 22:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A19146592;
	Thu, 18 Jul 2024 22:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AIISX/fv"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC9E146580
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721342426; cv=none; b=Dk0uJfwWCtvcveSTYpYrn1Vm2WpMo8cwQb9pXG+uYJwZMpmgxr8FJfZs6fG1eEiu3cjDoevehBAd0fdp9kvj4kxVHShThxNVn5R9EtttR9VCoOI0dWA/x4W9mFTUOv6EtoA82i8MdA2qfdmDGjPaXR9sfqv55cbTT/oK1xTF/94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721342426; c=relaxed/simple;
	bh=eO4kp5UnAFjHe0AUrdjmpzGkp19tTMi8cto7wpmuUo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OG8ugasmNFj/GDBedwJFQbWGfdnhfspl0GnQzulKBsmvt1kHEW2fmJOpqCj+PeZF+4tG/HXBwRrdD4h5jBlJvorg8Ja5Sb3U8iaXtFoK8zq0e7RXBv6pG1SXkuQtPGbEQF3b1fYmFUXJkw7z6zOibpc86FIbefJ2RAqYFp30238=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AIISX/fv; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fb3b7d0d3aso8552965ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 15:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721342425; x=1721947225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PRG+NPGSiSWOUHh6HQYRv8V/Xn8Q2Cj3365oPP+4wFQ=;
        b=AIISX/fvPYmotAlIDBwA9zKc8Pn7TVbSxl+UYLqh1nk2vWtkMcnycBo/yQXeIYNFtt
         6AsDK+2lyHBTMzyBu5+4cW3PLYvBUPy3rxPKnbumnMrPFp3gj8lee7Q7quenYPvVIOhH
         QI+pNFy1VF3Hz8O1TthUYzQmk6RcMNnWDlOFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721342425; x=1721947225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRG+NPGSiSWOUHh6HQYRv8V/Xn8Q2Cj3365oPP+4wFQ=;
        b=n59SFtbndjua+zhHPTJow4+IXeEO+1bSSGjoCJmD0T15FLpma8CC1M71kr+4WPRW/j
         IZOyFxI+s7D9WXgN/AJDlcm4V4VGjIy2RAL23F0TgsjkajFZav9OuhQUyHnoJH9gUFO+
         jT5SvjQWmy8tRcfN3HEQTV496NPOjyQje1YXuk7nIr+DcwLz9FQZEpz4EZc2/JDfFDj0
         aKOj50pqUiWjqSJECYIH9ZDzjI43F9jZOspWClkiNFwXXpcmS/mZPlRSeOXcuwssV2sa
         VoSbQi28+a4LgU3cDc6mrrGWW0cZ5nt0s4VGi6aFngt+yg3Qd1cCIR5lTMmnxKQaeODy
         oCQw==
X-Forwarded-Encrypted: i=1; AJvYcCUa8yGcGy3rx8isXsreavxK7jScwQaabe6DxjYotK2nQIk60oVfVCbLsNT0v7CKCC/oPxaj3wqjO1fuh30EaxGnKsNUrvZqgXMR12lz
X-Gm-Message-State: AOJu0Ywbi84xmPmVXF9ZlRAnpFAwpyUmt5+RcUU0L7+Ld724PKo4R6mu
	HRptMQHv3xthdBGZ0+kB5U8IBGuGxc3/lDT05oYvrXGVF8t4+mtKHfNQ/fQOpWdJJugybzaGSbI
	=
X-Google-Smtp-Source: AGHT+IHPPfOj5xqA6lG9mYFBLww0N5/Dr3B2IsBfaETqr5dvarjLSc3DnhpSh6aTqlJa4NnhTIS1XA==
X-Received: by 2002:a17:902:d4c9:b0:1fa:2e45:bcb8 with SMTP id d9443c01a7336-1fc4e1540c8mr50924495ad.2.1721342424734;
        Thu, 18 Jul 2024 15:40:24 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:35aa:f87d:7549:3938])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1fd64b49c7asm912195ad.21.2024.07.18.15.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 15:40:24 -0700 (PDT)
Date: Thu, 18 Jul 2024 15:40:22 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] wifi: mwifiex: simplify WPA flags setting
Message-ID: <ZpmZ1hXWPRCpUaUt@google.com>
References: <20240717-mwifiex-wpa-psk-sha256-v2-0-eb53d5082b62@pengutronix.de>
 <20240717-mwifiex-wpa-psk-sha256-v2-1-eb53d5082b62@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717-mwifiex-wpa-psk-sha256-v2-1-eb53d5082b62@pengutronix.de>

On Wed, Jul 17, 2024 at 10:30:07AM +0200, Sascha Hauer wrote:
> The WPA flags setting only depends on the wpa_versions bitfield and not
> on the AKM suite, so move it out of the switch/case to simplify the code
> a bit. Also set bss_config->protocol to zero explicitly. This is done
> only to make the code clearer, bss_config has been zero alloced by the
> caller, so should be zero already. No functional change intended.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/net/wireless/marvell/mwifiex/uap_cmd.c | 28 ++++++++------------------
>  1 file changed, 8 insertions(+), 20 deletions(-)

Acked-by: Brian Norris <briannorris@chromium.org>

