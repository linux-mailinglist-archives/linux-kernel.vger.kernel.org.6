Return-Path: <linux-kernel+bounces-351546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AB39912F6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 01:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912611F231A3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 23:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979501537C3;
	Fri,  4 Oct 2024 23:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aTGvnViL"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A095D14B061
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 23:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728084297; cv=none; b=s4HVhsLIofGXCC4RnlbuOoiZ+M+baneMlTBVKzD/fYa+r3vxxYrq/H2fljAkcRMm6e6nf88N931Vrafaa/9/TS71xZcqzPe63Y13oVIjZD4bseMWTL/jkZYaZM3QnFWLMZ5HQGOZFvjjZFDoYlJcfvi1h6Oq8ohbWDOl6Jf9gwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728084297; c=relaxed/simple;
	bh=TJOu96rYMl60HiNFYN8472od4zNgX/vpXVk4giBXSLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrDuOD/PWfKS85bLfA7LIkKR8UDvZ/Fni+mLS3xM1y8THPQkJSoyTFRhyeigRiJ7bdharQg3Esipl06UFP1RnGqlMGdlF7Fd7xWNF1aoiyTA34SDwhALGqTzXUqtK3qoe3ErnQ8FCIpEudheJsY/ZR1aW3DC3HHcJCDeflUDGO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aTGvnViL; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so1540284a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 16:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728084294; x=1728689094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jTPa7+E4o1wGyCtejrtt8lh7LwXJ+ELK3Vr+c6O7bFA=;
        b=aTGvnViLJKeosYjccBQXHGHaUEXsPC8wm0n+af22e8qRmd4wS7qywqNRHXVu3ARLyV
         SC5lGUsOT5xPN5I9xPDmzVqK+2/zQ8Rgy+O/5pf/yrg8TF8J34NlGXw+9Bk8jgFyuj7G
         Ox53BvJIlIPbC3gWPMLkBAgxIUu1Io9zwK6NU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728084294; x=1728689094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTPa7+E4o1wGyCtejrtt8lh7LwXJ+ELK3Vr+c6O7bFA=;
        b=LBHfbgQGShEeG6nnZMyCRdymVJDiGc45YQ1qmf61/tOLx25ggHfLF56SmKHQypixTX
         AasgnEjSTXzTT7goTFVIsUgN0JyDpTXjKSMJVYWBtPOZ5euTwAnGBENq/jkXYt+scyEW
         LFkYWBR7/RD7IBSUOZ5n1v5W8M685+BkAh1pIR9IXXcoebiZKd3mejNQ6UwRxWmTxT/v
         j3PG0AVXdcPthmlYnrcpuu7NquWFqnX1yUD7mnLWsiIA2cyesAerO2Amdw/dPWsQEkJd
         xIztj5vF1rKNO6GuWvC0ghXb2oKZHhbVcyUn4tYM0pdxIPb6Oi05QosLkzLOT/hCSAlj
         BPBA==
X-Forwarded-Encrypted: i=1; AJvYcCUIIyOb4rFpabPtwkjt6GAVMy72ZOMOB+VYE7yMU/BOuCGTLdbl88qBvYu6PVqJyhgf+TclP2+4Yi2SRQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjXp+zucWwl4SLufvmYXVvm/D+xYgD0GNltAEigY0dIgqcFhl0
	hBUQe93mdtujRWKwn7t7sgShzgOj1X9l6yqxl0FxaJld7Akpg3hmGZ0hZUSj2w==
X-Google-Smtp-Source: AGHT+IF2R3tEmtJDKg1teHd/pUpxmNXBwOp9mFLYPfS4Sx/KLmiJLMGsstUxZheibiWLBKWpsCB5BA==
X-Received: by 2002:a05:6a21:3947:b0:1d4:fd63:95bc with SMTP id adf61e73a8af0-1d6dfa25a7dmr6061489637.9.1728084294010;
        Fri, 04 Oct 2024 16:24:54 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:431c:f73a:93be:1ac2])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7e9f6c35e9esm535321a12.66.2024.10.04.16.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 16:24:53 -0700 (PDT)
Date: Fri, 4 Oct 2024 16:24:51 -0700
From: Brian Norris <briannorris@chromium.org>
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lin <yu-hao.lin@nxp.com>,
	Dmitry Antipov <dmantipov@yandex.ru>, Kalle Valo <kvalo@kernel.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Sascha Hauer <s.hauer@pengutronix.de>, Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] wifi: mwifiex: Fix memcpy() field-spanning write warning
 in mwifiex_config_scan()
Message-ID: <ZwB5Q4_P42DVMr04@google.com>
References: <20240917150938.843879-1-alpernebiyasak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917150938.843879-1-alpernebiyasak@gmail.com>

On Tue, Sep 17, 2024 at 06:08:41PM +0300, Alper Nebi Yasak wrote:
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
> Also adjust a #define that uses sizeof() on this struct to keep the
> value same as before.
> 
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> ---
> I found these relevant patches that modify other such arrays, where the
> second one removes a -1 from some sizeof() calculation:
> 
> https://lore.kernel.org/lkml/Y9xkECG3uTZ6T1dN@work/T/#u
> https://lore.kernel.org/lkml/ZsZa5xRcsLq9D+RX@elsanto/T/#u
> 
> So I think we need the +1 to keep things same. But it appears to work
> fine without it, so I'm not sure. Maybe it should've had a -1 before
> that I would remove with this?

Thanks for the investigation and patch! I believe I agree with the other
comments, that then "+ 1" isn't necessary. It's just a wasteful extra
byte of allocation. Can you send a v2? (Bonus: with the suggested Fixes
tag. Double bonus if you test KASAN with __counted_by, for a second
patch.)

Thanks,
Brian

