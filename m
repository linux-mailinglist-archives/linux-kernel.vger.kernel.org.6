Return-Path: <linux-kernel+bounces-366768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2964999FA22
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B0B284606
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0260C1B0F07;
	Tue, 15 Oct 2024 21:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PtWFFG5r"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BBA1B0F08
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028052; cv=none; b=JemI9iLxSc3YD32yV3vdZ9c3c6mv6tsFMJqd3ohCVwiBwI8OufRre5jI2nGT7vh64fsVKuxpQ7vCodRuFVk8XPFOG0Ut7UhTmKfMbxLMRc63OpvnhC7QwnYdTcn6aveFOWRUZ2xkDc5jK16py+XCUAvtpI2ZODd86dlWLOwBUMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028052; c=relaxed/simple;
	bh=knTgNecEkYKeM/JJuIkK3FnpRRBOBT0/xY6PnfCDNgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0q0kIIh5zV1LWM19I2HhJEm7MeInFxapF/7YE7D6rNmiVBLFuj3niVVuhBclZ7KOSElW4BE3DSgurmaIuR2uQ7aADeW5raw33kHQDx4X7SMvySM3nn+U5zEAggptOM5wJZRIqDz13JMV9jqc5tHIV87oaAST47MOPKCjJeWTa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PtWFFG5r; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e30fb8cb07so2764297a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729028050; x=1729632850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DKjBORgdklEf0VcX5F4hTKcBGHj5kwXdCtAfdZCcB54=;
        b=PtWFFG5rP5EVlcOQHNmvJwMM5bZKj2qn7HBXaBvmSUg4cdzcDaaESuhDNjkpfF305g
         /JZowdpoi/ZfEWNqjPw9IA6vzW1IaNC1/mYdQMy49BztjFdI0zGz2AR9kSVMVXEz9wyi
         whUh6BatT7C4yEVnAMc8Wx35VLWfRM2924oxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729028050; x=1729632850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKjBORgdklEf0VcX5F4hTKcBGHj5kwXdCtAfdZCcB54=;
        b=xRYo8ZdqlPLGQ31G8m9xqMyN9lm1r+xR+F1FISCxNWGXuEynLzSop0Qz0ZezCtPesD
         ffsGCJKVhh1sDmhZhWac2cGK7l5Aih6TCo2xyUszpYtJAwZcg0x3/qqn008VI1nc/NdT
         xCTZ1M1q6IVrpcIYcWsHPDKEMqwm+6pFxS52BWBmzk9HQ6WaDSFil1nlxqcKGWr3daxd
         pBCx6h4Lo1/PlyRrxbTohGnVdy8as9yMewwxGqykZQjTfu25E34xjCJYPDZuRbw+yaf9
         lHPYuvI/mqLaskCl6UJAUbzBMNiw+FzUS+L37+03jrhEJ3Wv53Rf27LngL1nIlIc6dT7
         e+zA==
X-Forwarded-Encrypted: i=1; AJvYcCUlum27jYqikSI95/+ER8A3XFqFm54QQU4Si34a6f3nPkHHUJbY9eFOofjk8dF1usGKOhNtYVgzbyFUwC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg73UVyOLBdvQPmWZwDKrKXtyF0SrsM9IkJrUl6/7v9lnmBGbr
	B0w4g6UWA2qw5ltRt+mSVowf6ud/hlgVAmrsEa+hqwRFY3lCnWOU2TwDEhDGXA==
X-Google-Smtp-Source: AGHT+IHRze0IzcATBijgCp06ZoOiRkVXgkxhi7l6ZEkczzicwWYspql4/Tq/D7z2iq5VXHb4rA81kw==
X-Received: by 2002:a17:90a:b017:b0:2e0:ab57:51ec with SMTP id 98e67ed59e1d1-2e2f0d7c939mr19519508a91.30.1729028050216;
        Tue, 15 Oct 2024 14:34:10 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:eef3:dbf8:fbe3:ab12])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2e392f753b4sm2409874a91.49.2024.10.15.14.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 14:34:09 -0700 (PDT)
Date: Tue, 15 Oct 2024 14:34:08 -0700
From: Brian Norris <briannorris@chromium.org>
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	Kees Cook <kees@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	David Lin <yu-hao.lin@nxp.com>, linux-hardening@vger.kernel.org,
	Kalle Valo <kvalo@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/2] wifi: mwifiex: Fix memcpy() field-spanning write
 warning in mwifiex_config_scan()
Message-ID: <Zw7f0FTlGk__kE6e@google.com>
References: <20241007222301.24154-1-alpernebiyasak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007222301.24154-1-alpernebiyasak@gmail.com>

On Tue, Oct 08, 2024 at 01:20:54AM +0300, Alper Nebi Yasak wrote:
> Replace one-element array with a flexible-array member in `struct
> mwifiex_ie_types_wildcard_ssid_params` to fix the following warning
> on a MT8173 Chromebook (mt8173-elm-hana):
> 
> [  356.775250] ------------[ cut here ]------------
> [  356.784543] memcpy: detected field-spanning write (size 6) of single field "wildcard_ssid_tlv->ssid" at drivers/net/wireless/marvell/mwifiex/scan.c:904 (size 1)
> [  356.813403] WARNING: CPU: 3 PID: 742 at drivers/net/wireless/marvell/mwifiex/scan.c:904 mwifiex_scan_networks+0x4fc/0xf28 [mwifiex]
> 
> The "(size 6)" above is exactly the length of the SSID of the network
> this device was connected to. The source of the warning looks like:
> 
>     ssid_len = user_scan_in->ssid_list[i].ssid_len;
>     [...]
>     memcpy(wildcard_ssid_tlv->ssid,
>            user_scan_in->ssid_list[i].ssid, ssid_len);
> 
> There is a #define WILDCARD_SSID_TLV_MAX_SIZE that uses sizeof() on this
> struct, but it already didn't account for the size of the one-element
> array, so it doesn't need to be changed.
> 
> Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>

For patch 1:

Acked-by: Brian Norris <briannorris@chromium.org>

