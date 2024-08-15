Return-Path: <linux-kernel+bounces-288346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A4895390B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35377B23ED7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDEA52F70;
	Thu, 15 Aug 2024 17:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i+mps/zp"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D729341C64
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 17:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743126; cv=none; b=SoppTMwYgZnezoA+dG30o5fK+CTypKTBb6B3zOCqkXJrsyvtyqDoMid/c4cQ8DQQ93rpW0TzXWCT4vmfgxjQkySjNXo/mqlXDKMXzSZWrmxCciTJj74sme43UqMXHLeSlRuL5JkLwkyBC9URL90qy0oFe0AyPXxIsFyJBFz70b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743126; c=relaxed/simple;
	bh=bJF14wmu9jsa43+2yR+/HNeL1nQvM/2EmjSz0o16s0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FicqQz2w8Fl6ZIEXi58AwxPc8R6gHbMQXJZiR3KwwJ4KsFBV+ARF5zFvV7Sl0qpTahnRkx2Yhx+9ZFPlMbuoIGir0brhd7Bx+RRBDW3mdsJ+9kgh+TF6fpFHErh5dLlnIdkm9Wd6/SI0/AAIwli2dRZ+zmlvsUfHG2ios+JLGG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=i+mps/zp; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d2ae44790so909931b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 10:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723743123; x=1724347923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KJF/UOMD5eEDAA8HbpPiltNYMc2YMJhbR1FeAQVndRg=;
        b=i+mps/zpqec7OWA39EeUDR6ldZZRxjf1SaUE1I+9ayfcr+x0OF/zFKuWisWwHhvqA4
         tks3FyQD/WlSNm43djYyZ57hhoEvuORj7brCekyaopRjh8tOkKIhYZIvaYqAGbAaXtuN
         YQn6Jq1Hbl61Z+/fOoTDf/Uo8WRXIozpQDzFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723743123; x=1724347923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJF/UOMD5eEDAA8HbpPiltNYMc2YMJhbR1FeAQVndRg=;
        b=JbIk9LYWitRSkxp1Kyo4aE/dRNpmuOPdeBTPhJRuFV2XI6Xd+oyaah9rDKnrP9r2yD
         bMcfTCHWkyETFLMUl7/xh7LzRC34mfD2mFph2yf3/pkWSLKxzWe7MYZK47hAy+XYrK3a
         2Cf7MlUh9MccvMwdYq351h3i7tRc3bjUKkblzPTUbhD1jwhKLIV2wj9ReAvErku+iVnN
         knEv6r1LMaCOAhugOsLHh4Xb3CtzaKPdB1M6cqA07DpMxQ0GmdlC1+3kRU6A8guQ82PC
         toRmfmHaHQR6Im/+Fw1+1Zxl4KsWlS/wX/+OgYKWo3ZkY9+cq0Ulr74JPyjg7a4kyv7T
         b+zg==
X-Forwarded-Encrypted: i=1; AJvYcCWRBNF0AKmhLDbGE5OqzhdpHOJyIll9DU2dCNXHmri6J47KWYOkvF0QTcGy6f0FSBLm1F+HOos7tsXzpQt3ncRuJwYFDcqzAEklC3tt
X-Gm-Message-State: AOJu0YwBd82y1IdmMXR4JKvTQ+msEdULQ7Gj+Xb+X7rKcMGzXwSCvETT
	SuicBgqKz3b/3EO5Yk8/6Gg1V0A0nZBQiCRbdzMPl38fq7Rf5uqD5qJVlhh1lw==
X-Google-Smtp-Source: AGHT+IFLsfQwfWCjQHECvs9QdlrI8dsI849S+aGHrh3pWIyHIF/blT6qN6I3iN7jmcbQFzZw6wEX9w==
X-Received: by 2002:a05:6a00:14d2:b0:705:9a28:aa04 with SMTP id d2e1a72fcca58-713c4ed2c6fmr532021b3a.23.1723743123067;
        Thu, 15 Aug 2024 10:32:03 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:5afb:2a2e:f5be:2aed])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7127aef68casm1234886b3a.108.2024.08.15.10.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 10:32:02 -0700 (PDT)
Date: Thu, 15 Aug 2024 10:31:59 -0700
From: Brian Norris <briannorris@chromium.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: David Lin <yu-hao.lin@nxp.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Aloka Dixit <quic_alokad@quicinc.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Rafael Beims <rafael.beims@toradex.com>,
	Ruan Jinjie <ruanjinjie@huawei.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: Fix uninitialized variable in
 mwifiex_cfg80211_authenticate()
Message-ID: <Zr47j60F2NjclfcE@google.com>
References: <d7d043b2-95d5-4e1d-b340-5d7330053ac6@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7d043b2-95d5-4e1d-b340-5d7330053ac6@stanley.mountain>

On Thu, Aug 15, 2024 at 02:29:27PM +0300, Dan Carpenter wrote:
> Smatch complains that:
> 
>     drivers/net/wireless/marvell/mwifiex/cfg80211.c:4408 mwifiex_cfg80211_authenticate()
>     error: uninitialized symbol 'varptr'.
> 
> It's a check for NULL, but "varptr" is either non-NULL or uninitialized.
> Initialize it to NULL.
> 
> Fixes: 36995892c271 ("wifi: mwifiex: add host mlme for client mode")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Acked-by: Brian Norris <briannorris@chromium.org>

