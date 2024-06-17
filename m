Return-Path: <linux-kernel+bounces-217181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA7490AC93
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E9521C216F7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75354194A41;
	Mon, 17 Jun 2024 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="y1Mf+C6N"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A00A381A1
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718622302; cv=none; b=QRManXbB8UasgZ2TecgRj7gPgph1Hkcnuk5ePuXQWPHPuaZxhYpd5piy2nzWVSJHwW9X+FBcI7HfMIBvl/lQsv94qdeYYkyeoUbWa/AI6Tt7qXHwyzFfdQy6Vd6AhUrgffTWG1B5VtcTgoWISlUT6w67YzjXFdr0tcMXF3JImwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718622302; c=relaxed/simple;
	bh=3qORiEE5M9optyTrFU3CyLuP3Jx28FNOfatBvsvLqeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMArOM8OYIxlea2UL2DbOHdLuootigDWGadvcrmIUcabKXpN8t2GtCfBHp8ZX7jnZ8KFcbjp+wb+0nC+pazWSuysgHi0uGzzkm5RLUa+HWeu+Z6NOZuuQ72H1Acf0QG+mTYMAJozu42uWCCrKu6Go/3Z0AoGLE3ui3mZTvFlFhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=y1Mf+C6N; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4217c7eb6b4so36955345e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 04:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718622298; x=1719227098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3qORiEE5M9optyTrFU3CyLuP3Jx28FNOfatBvsvLqeo=;
        b=y1Mf+C6NeQ6TgKAeqkA1L+I6VYMVIcrG6Yoc+wbHOoZX9+s9h1I+CJh8Mv3Fo0tIW+
         4fVLhEBY+WG4IIN7XKLYmmg1V7MYwoh+2hXEn3D0ItnmTN5D3s+G+L4OOV2ANFFjw00D
         Yxp48K7Huf0YJ4uJWZ6vVGkBedVPb0022d/xnebdLG5a9z4Sr1MuD2xAYKduaq6bPppQ
         gcgayeMBjJB6sLdLsNsQYeFH3zdlvFdXA7F3MFA4+7e9DVKe2gpdVZvTqf0htxKcqd6g
         hvT2uv0/hZkJqdcMHad0Vf7L8wGi6pHZ/1Dwwiv6NujpEQM/7pUxDZWWnF5xIpCZs9Iw
         YdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718622298; x=1719227098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qORiEE5M9optyTrFU3CyLuP3Jx28FNOfatBvsvLqeo=;
        b=tveFRdDSxzr41iXU7GSTDDFjQlwXup4TeZUXYVm3hY3JqePgYvE8dMN+LSn8nrDnlu
         8SZKAImNsrxdHLX1m2pjz7EAa5nS7AWrXPhSkAjBI0RwYUYueJJUmtJgNGs7Tn0kvaXm
         /fOAq7QmEbXBUzzw4epiWbMgO+zu5bdJ8FyswhhsAX9zU1/wur+xUlrA8iWTBafU2msX
         79SVnLOOaz8e0HnYMT/Iiay9T0ToBzi7HFdJulVLpTH2is7Jz93/Uynz/yCyU73iTnLi
         iA8zHWL1JOKv/lb/3ZOyHNRd/vBNrvi8m3M3QNM/c41F3kvTi3Sa4apoiIhho+Bxvkdi
         PIVw==
X-Forwarded-Encrypted: i=1; AJvYcCXmna0AvHiEPcWivrfg+Pd6bBWCRe+Wr8dZz04jVJbFdNm66TUrgrHNu0AN0MJTJpJik3707UrcQxCYYR8HMK+jqFBGybzEdosglUGC
X-Gm-Message-State: AOJu0Yz+hgNYxon5v2fqYf0dF6N1dm+wR4txkkAJtra5R5DDTyQJ1NzB
	BzVx2eQmJqlgbyUB0Ui0kIEkVmcF2sSt/sdL4CH2GKb8MUbp0PLeUZVtljl1YQs=
X-Google-Smtp-Source: AGHT+IHY80bEQptoc3M5uPoOPvK/WIzy5fFAbdS0fC6vAPCAtC/168s+7ed/XFen5aGNMn9KBFDXFQ==
X-Received: by 2002:a05:600c:1e29:b0:422:1a82:3ebf with SMTP id 5b1f17b1804b1-423048592dbmr72452565e9.35.1718622297510;
        Mon, 17 Jun 2024 04:04:57 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f602ee95sm159482515e9.13.2024.06.17.04.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 04:04:56 -0700 (PDT)
Date: Mon, 17 Jun 2024 13:04:53 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jose Abreu <Jose.Abreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] net: dwc-xlgmac: fix missing MODULE_DESCRIPTION() warning
Message-ID: <ZnAYVU5AKG_tHjip@nanopsycho.orion>
References: <20240616-md-hexagon-drivers-net-ethernet-synopsys-v1-1-55852b60aef8@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616-md-hexagon-drivers-net-ethernet-synopsys-v1-1-55852b60aef8@quicinc.com>

Sun, Jun 16, 2024 at 10:01:48PM CEST, quic_jjohnson@quicinc.com wrote:
>With ARCH=hexagon, make allmodconfig && make W=1 C=1 reports:
>WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/synopsys/dwc-xlgmac.o
>
>With most other ARCH settings the MODULE_DESCRIPTION() is provided by
>the macro invocation in dwc-xlgmac-pci.c. However, for hexagon, the
>PCI bus is not enabled, and hence CONFIG_DWC_XLGMAC_PCI is not set.
>As a result, dwc-xlgmac-pci.c is not compiled, and hence is not linked
>into dwc-xlgmac.o.
>
>To avoid this issue, relocate the MODULE_DESCRIPTION() and other
>related macros from dwc-xlgmac-pci.c to dwc-xlgmac-common.c, since
>that file already has an existing MODULE_LICENSE() and it is
>unconditionally linked into dwc-xlgmac.o.
>
>Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Looks okay. Missing "Fixes" tag though. Please add it and send v2.
Also, please make obvious what tree you target using "[PATCH net]"
prefix.

Thanks.

pw-bot: cr

