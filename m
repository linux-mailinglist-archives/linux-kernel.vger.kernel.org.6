Return-Path: <linux-kernel+bounces-282571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8051494E5EB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 06:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAFE8282243
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 04:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B233714D28E;
	Mon, 12 Aug 2024 04:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="loQXyudo"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C178B1494B8
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 04:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723438486; cv=none; b=AnSdVdSUEp0m8hD6bc/qbEEIbS+WhXoZu0aFsnsi62mE5CBZ31E279gMjx6gXq2LM2S6ZyM/ovyijsZ0jWub9E5+Q/7XUs5bLB4nxLwgcJgsugNlcwlYzpGoayetbVrCLKbVNQXbTpIWtsvRuySGcQFZ3Ncv2ZnPldGxgkAgrrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723438486; c=relaxed/simple;
	bh=/7JNJRSA6Qai8rSOw/cLVCEzVurU5rT/F+Aq6+y0Oe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iw6C7/W7xCH/OHG+M99sE/NrH1kNNAh3naOSjP5zakIvL/piKJaaXn4jL3P5qz/lADi7LqIy8vjHczx/7zusJzFyIE84CJRTqpfO85Otjoskya40nI1x9qnBzAH7BrYO7Bfi0XbSs0f/j5p7WNSmawpmKmO+EPrimaoebFV7+UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=loQXyudo; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fd69e44596so26480475ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 21:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723438483; x=1724043283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mM8hIk0Il1OoNYTiO69SEs09clvslubSlLyTOMarmXI=;
        b=loQXyudoUtfD1nXJou73uJficJgn8I8omRJAndOy6PwHV+dtrNDKPbGsRecVxB3idJ
         nlmdfD0xIQPlfYvwaoKprJmBITljBAR24FCZZ9boyQV2v0kT1H6SwD59HstOyIeFwO4D
         Zzv3kTRx/bervfrv6DyTzS2oO3aGLIJla4o+kNLn8yhYw/ZoQWSY0Jhx4QCrPWORlrOP
         7+fC6WSaMXl0BQbDsRn4O2BOE/FcV2l/fDQFmv8jIFhj4nNM08lnZrkyalTrUx+0To8I
         c+s+1EoW4rYbVzcW8ShzDNQ5k4lL+K1pIskPsT6fJhsaKX9wJYmQEJEcLCzHNqydJhjl
         Qtyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723438483; x=1724043283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mM8hIk0Il1OoNYTiO69SEs09clvslubSlLyTOMarmXI=;
        b=drwDcb9kAQUaFM8gxEzdrgyLlbzsGB/0Ldl+aK6zvCpTPGSsjZhGpAPECXA6+lK6/x
         Qx/t6I1WGy7ZUFa8w1L60vzkGqezk2NPWfO10A2g0fqX9qf2ZpVttVubCDZ184KfsFU2
         ApT7njw/8keVwwMDt3tqjfQ6A1B0yKJH/FLYQDRgfWH98YUAsblZBV2nGt36ienYIxLg
         DPa8i+DUdms51uJwMa738V//C6W83cQDsHbWbQChgcsqF80YVvaoG7vs3GInQIVq7+18
         OOARENCNVelQkHMlv45Zq+ILgfFaamLX/rI0uWW+qBm4Y7SpIA6GZ8pHbGYduUSmWwkI
         lQPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlrMBijmmNr3pST4qslV5Wc0QS0ykMnLz8z1lVX/GfycbndsROCOv0wr1yah2lWLt11b2V0TTiCAkEJi9MwD0MvhCuTzRAAoFhGbOE
X-Gm-Message-State: AOJu0YzWbZUJvK7YhTcY+mPonV9JtCAeu4R2jrEY0/tpuU3KYSfg/qTD
	FQE4Vos2PLOQxXnO+U7d/A51T2BwwAN0rIJJfWjzY3LOv6zk5lkRG5Bm/P4atnc=
X-Google-Smtp-Source: AGHT+IG9Hm7mz2IYGlrpM4SuzTL62Qbzr6jN0CUn18M/7AjFxPVmd28eUBvkwj+lz/oTj1+27nZaOg==
X-Received: by 2002:a17:902:e845:b0:1f9:e2c0:d962 with SMTP id d9443c01a7336-20096baa066mr174277115ad.31.1723438482987;
        Sun, 11 Aug 2024 21:54:42 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb9fd0dfsm29338335ad.202.2024.08.11.21.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 21:54:41 -0700 (PDT)
Date: Mon, 12 Aug 2024 10:24:39 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ilia Lin <ilia.lin@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel test robot <lkp@intel.com>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] cpufreq: Fix warning on unused of_device_id tables for
 !CONFIG_OF
Message-ID: <20240812045439.tbdsbdwcxntoafdh@vireshk-i7>
References: <20240809172439.908092-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809172439.908092-1-robh@kernel.org>

On 09-08-24, 11:24, Rob Herring (Arm) wrote:
> !CONFIG_OF builds cause warnings on unused of_device_id tables. This is
> due to of_match_node() being a macro rather than static inline function.
> Add a __maybe_unused annotation to the of_device_id tables.
> 
> Fixes: c7582ec85342 ("cpufreq: Drop CONFIG_ARM and CONFIG_ARM64 dependency on Arm drivers")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202408090714.wcrqU6Pk-lkp@intel.com/
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> Note that 0-day only reported 1 warning, but x86 W=1 build gave me these
> 4.

Applied. Thanks.

-- 
viresh

