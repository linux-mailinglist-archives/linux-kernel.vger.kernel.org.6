Return-Path: <linux-kernel+bounces-221594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E79A090F5D4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 20:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DC511F222F7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C6115746A;
	Wed, 19 Jun 2024 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="VJCjcqGa"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F47143865
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718820910; cv=none; b=FXBDFKD9nrtZMyIVGm6GukLU/5cCpSxJ8ehfp0T6OAc8nEhFTj8AI10cqsGR7rU/YC1u73/YvxA/JSB3eEgLuRERROAi72kfH+qAGhQTqHrfvngttVK5AfiWZsN/rvzSU/svoenGKdLHOhh+QCRLGjU682xbK+jn6ohkTGEKPVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718820910; c=relaxed/simple;
	bh=fVNJ46LFa+YhWYpSphStOCOSpTawRC5Ibrt5BRhp/I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfJJa0joFb8Hm0OL+e2XA03Pp+plTODk6hB7yvVuk+jd0dQtamSnqMpbohsTZ5b7cNLL0lm7JHvFA52H8yEND1QES+SQJvXtIULSS512FflTuOccxyrgGdaDuORyHL14XqMxKCbcTts4HvgP0aX3YEyASeus1+E19uPtqHdQwQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=VJCjcqGa; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-705bf368037so133792b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 11:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1718820908; x=1719425708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ObNK4nw+goLT3sduvlOOitPrsfAxlE+HFMLfQaVSTdo=;
        b=VJCjcqGaTcR6AOxzCG/JkLBXnFVZ/voA0rOBgBYAJOsr5yqXKTSBeV2SHrA4CVbTvD
         guW4fPs6ZDfD4JT7afhhC8nMZGqI0fZtWnDaZmSZ6B/9jamvb7SEg/2ceREW3r7pBOlh
         9U2939CqmKxIEM6XlwPbF4qd5bOTxGJCGmn9TmPkDr9V8snlNbIjk2lcQiAHikPQAHWt
         LZG16jK0W9fdKYXFr5zp6+QF8hO/Lb5F3+RHlLyvXeBm3sU7H+UjLC4s2EGCXm0qb7EC
         WcgUzLhrYYK7f8/swgI6FYXVDxlvKK6pYTCoaVmuseHN/21NgqCVW4+kt9qnPFi2P7/K
         bqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718820908; x=1719425708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObNK4nw+goLT3sduvlOOitPrsfAxlE+HFMLfQaVSTdo=;
        b=uUrTDcUAIUsPVKTDRlXbj35HMVxDcFrenw8swo+ziUb4gqC6a+WjI0o9j8CGRi5sNZ
         Mj2LYxX28vgh4UnxOyinz5ARvW1xgkAklfPqasmMilLObA2+Mm4Ti9dYj7DZ/ssWO6mO
         LYF9rr98ky5KdMIlHFtdrtIRpbnu39FTQAg1EC2+bAUE8cK2P2+hN5ns2q5foaKdok0z
         96yOCNp0hqn/iyP9PW9hb0g44XRF64xSCPyiGjxqMi5N10ntuuhAbu/X2cqlSuma93mV
         hMdn/bj81hZkjaUUE0ot1zGuA3yMP9NfcNFW8UmUBSQAR5KNKGiw+gqWtKeONFfolsMk
         3rHA==
X-Forwarded-Encrypted: i=1; AJvYcCU/Sy97O03tS01kDWaW1C0Bah7leaSZ+NCcTA/Xy8uJWsL+m2MGJFOvvBlkZevYn1yoenRwMX7XJa2KwNfmc/sZ/wHUhVWj0GsPea07
X-Gm-Message-State: AOJu0YzXXZCh9q4LtIHrUMmMvR7Q/0bJgc95VMcrT1Ey6tJMHKsrrA8u
	bcZARRgRQBUdb46qmEgXjLmNvIrXqB4nQaJ/41dnhcvHuzxYuaJZddSugcLG5IY=
X-Google-Smtp-Source: AGHT+IGj5wpO/mjLKZrOGKZvpPOXW2hKDnc/Jp/UqhQuyCI6Q1OQJ7aj2Y4azc+GePSR7cngyftNOw==
X-Received: by 2002:aa7:9e90:0:b0:706:29f0:33fa with SMTP id d2e1a72fcca58-70629f038d4mr3002643b3a.6.1718820908271;
        Wed, 19 Jun 2024 11:15:08 -0700 (PDT)
Received: from x1 ([2601:1c2:1802:170:7627:e2a7:42c9:f02c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc967334sm10993307b3a.57.2024.06.19.11.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 11:15:08 -0700 (PDT)
Date: Wed, 19 Jun 2024 11:15:06 -0700
From: Drew Fustini <dfustini@tenstorrent.com>
To: Conor Dooley <conor@kernel.org>
Cc: Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Yangtao Li <frank.li@vivo.com>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] clk: thead: Add support for TH1520 AP_SUBSYS clock
 controller
Message-ID: <ZnMgKs/dUcYXiisk@x1>
References: <20240615-th1520-clk-v1-0-3ba4978c4d6b@tenstorrent.com>
 <20240619-tapping-jaundice-471811929d96@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619-tapping-jaundice-471811929d96@spud>

On Wed, Jun 19, 2024 at 12:12:30PM +0100, Conor Dooley wrote:
> On Sat, Jun 15, 2024 at 06:54:29PM -0700, Drew Fustini wrote:
> > This series adds support for the AP sub-system clock controller in the
> > T-Head TH1520 [1]. Yangtao Li originally submitted this series in May
> > 2023 [2]. Jisheng made additional improvements and then passed on the
> > work in progress to me.
> 
> One thing I noticed on the dts side is that the GPIO controllers have no
> clocks provided. Does the AP sub-system clock controller provide their
> clocks too?

Good question. I see that dwapb_get_clks() in drivers/gpio/gpio-dwapb.c
does call devm_clk_bulk_get_optional() for "bus" and "db". There doesn't
seem to be to many in-tree examples of clocks being defined for gpio
controllers with compatible "snps,dw-apb-gpio", but I do see that
k210.dtsi defines K210_CLK_APB0 for "bus" and K210_CLK_GPIO for "db".

From the TH1520 System User Manual, I do see the gpio related clocks in
Section 4.4.2.2 AP_SUBSYS. The peripheral clock gate control register
(PERI_CLK_CFG) has:

Bit 20: GPIO3_CLK_EN
Bit  8: GPIO0_CLK_EN
Bit  7: GPIO1_CLK_EN
Bit  6: GPIO2_CLK_EN

I will add these gates to the clk-th1520-ap.c and reference them from
the gpio controller nodes.

Since each gpio controller will only have one clock, do you think I can
omit the clock-names property?

Thanks,
Drew

Link: https://git.beagleboard.org/beaglev-ahead/beaglev-ahead/-/tree/main/docs

