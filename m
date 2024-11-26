Return-Path: <linux-kernel+bounces-422339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 150AD9D9823
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B1F283981
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 13:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25AC1D5141;
	Tue, 26 Nov 2024 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LjXmzCdv"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B4C1D4613
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 13:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732627117; cv=none; b=pPgynt1wu/taxCUaKzB7/A/NL4hEEv/Y+dMtFgw6QwUgTrNyQw5PCGmXpgxDUznXhgta9C86nI1geaZNPkSURh35fDywId2KoJYzpZoYtasjBhzZJVFQHpBMbjFHDPKMdjnCKLgB/FoOSqcuUsawqZYpnyy6HLJ1fp7NVcDnI7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732627117; c=relaxed/simple;
	bh=XvOczRYBHnqj6D4ESxktzkTKZPxGuV4JkG6dG5SfdTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioWN8LmyrkwWTKuB0vKTo5x//2pQ/nouWOT0Jet11hU70/csETh9b/2pyoMMLXoJ63t04h0CsQgibEox4VryJDv89YjC/4oNykLnQvPsBzGTSY1qgSRARHD8N81Jaf34krzRxjreFjHIVrHy6sRY33uv7ne0ElL4mux/6y5kH5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LjXmzCdv; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a7ee3d60so2681315e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 05:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732627114; x=1733231914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EaXfKxew919ViwJMv5co2YOm9WoJznHpNhie1VQ2zKc=;
        b=LjXmzCdvIScCjXsJrKI7BUlXw/ogvQqZrE7ogbKCfawG7sPVTW/r2yLzkHRjgoFOAl
         Ju+jLwmC9/OZ22gOeC42n+91AOxESV2xd45CXrzGxdwuefih23ZMZJO0ZMqMcy2R3mwA
         0DcC2wGHhm+SScrURizhrfX5bwnrhQd4/Xvl1+pyaVNeKD7pwl87GtVzyFVtPi84jdJC
         JLudHHyA3kcZIdVP0fE1atuifeeTjT0e7i7lpB5fwd7/LL7yGMaFHhz7qRyTnev4cS9p
         /hJWaX3YsNlqD9j0oQTErqM0IbimmTe4jLY2PenWig8HVfUAo63b6En3u7MToe9VC5Eh
         lG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732627114; x=1733231914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaXfKxew919ViwJMv5co2YOm9WoJznHpNhie1VQ2zKc=;
        b=OKdZlP6qR9yCPWKY3Gx8iDAqfaz2zdkXDCkGfogeFyMG8yG/RNzn+cjduFuPYdcPgJ
         sEEDjzi6dw3+YfYTTrg+S05hE5dYEz0N+jC8Yo2bDDhkjM7Ysihpq4jbE7xo05U6lg6g
         07lEXq39IBkWZ3eHz+eoa9cSThlZZID5ukDDt8D1ENmq1DqFIFyLh8dG4jl85klG4O8A
         7nUGEUu96NsXkdsAMdFQUbsrJAEvsJz4G0AX6dlOOASA8Mv/60ql3QWjpWu2ADg5XDVx
         JDJo/hC/hC4p6zd54gJ6e1E5+75X6K7Nf75UbLsAaXYimRf7HIwDyF3oMM5GKQW2C192
         DbGA==
X-Forwarded-Encrypted: i=1; AJvYcCUK0xOAingiTsifbtFjUHPi7bCmrxkfWSnzGzkKKs4Ytp2ignp/EEIAq9//SWDLGIH5zewYqsg3w2NRLuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr5NIVlqBze49nFaGmcu6Wvw/ah4pRH0Mrtn79bdXMPjV4YSsM
	mdaBGIwHTDBbYzzpQqP0ePmONnyF9sWC6Hhz8LLsvLD/e0Hvp1FXf3QZaNcJFLE=
X-Gm-Gg: ASbGncuRrsbDpklT933qp0DZgfPygZUjPR8DkdEYvLmuNrG8pGBfJazedvqvxYz3O1i
	h98pEuyblIEGpBxsKdb1+FDK+Ew5I+ss08x33uW4j9rHA/rliKGm+7LIi2SEZGvLlXw8xW5JyvP
	Zm/ppjR9AHKtV3UpIA08v+E4wFYxCt737qeWAl1QP0uVk3Wh6XG52O8BYT7/8Yp2geSxC9i0rHW
	YsZ2B6yd5/0KFMxQ5nO0CwkfPVIIDtyDmkUHHu6nZESaKeOrhI=
X-Google-Smtp-Source: AGHT+IFqrzqPLKiXN8EGHTiOqvtymXHH3HCsdhZtbH4hWUr3e3NQjnGkP9XHsrV6DaHZ2smDfxKoOg==
X-Received: by 2002:a05:600c:8a9:b0:42c:b67b:816b with SMTP id 5b1f17b1804b1-434a4e56629mr27530185e9.1.1732627113846;
        Tue, 26 Nov 2024 05:18:33 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4349e80e51esm82131645e9.33.2024.11.26.05.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 05:18:33 -0800 (PST)
Date: Tue, 26 Nov 2024 14:18:30 +0100
From: Petr Mladek <pmladek@suse.com>
To: George Guo <dongtai.guo@linux.dev>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, shuah@kernel.org,
	live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, George Guo <guodongtai@kylinos.cn>
Subject: Re: [PATCH livepatch/master v1 2/2] selftests/livepatch: Replace
 hardcoded module name with variable in test-callbacks.sh
Message-ID: <Z0XKpjs53Da5nEvU@pathway.suse.cz>
References: <20241125112812.281018-1-dongtai.guo@linux.dev>
 <20241125112812.281018-2-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125112812.281018-2-dongtai.guo@linux.dev>

On Mon 2024-11-25 19:28:12, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> Replaced the hardcoded module name test_klp_callbacks_demo in the
> pre_patch_callback log message with the variable $MOD_LIVEPATCH.
> 
> Signed-off-by: George Guo <guodongtai@kylinos.cn>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

