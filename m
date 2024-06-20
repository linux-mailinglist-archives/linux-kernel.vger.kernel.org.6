Return-Path: <linux-kernel+bounces-223273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 423D1911086
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1611F23BD6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2243A1B9AC6;
	Thu, 20 Jun 2024 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FcIls2yS"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C719C1B29B1
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 18:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906731; cv=none; b=ObCkp40bMA23w9vB8OecvUyJvS/vit2c+iw2gzOB+7LxKDMomegTEJGCOdr9HKm4wzSJHsu42SfbB/Ezo3urHk9D3EMRfso49CjKSqm7oZ0DIIK0IljY68l8PmfrE0bYTEZQrOxO1vu+WwYINosBoDOHMl315zxoWBZFgPeHIKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906731; c=relaxed/simple;
	bh=/UyRgHfm+sZS+tI1rHL6/bgIgJ35C5s0UbiOdadK2DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CODu65B1V9TuW3DO6u+2qym1Seyyc9QVmfLhP1Uzh22EIfyNEYvumcm8RDIdkMS8wa2RUrTb9JC57StEAKukEM9a/fsGK3iypvwcQTuvRGlqGFE1H+Gt0mx55o3ycV3wR0z4H6JiaDsNCL9R7sO7nk8tXg8FptYqeUfyOyS9TJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FcIls2yS; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7064afd7011so439169b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 11:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718906726; x=1719511526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AyAepGt8zwC+Uy9TBQ5kec4y0GaIIr8mJzAf1XxO3g8=;
        b=FcIls2ySv07eS1sSqfmhMVLmlXp5q0AYvXBwL8v77Yg1azs+IY8RlYm8fCdMJSwi33
         3+m5JNJsbqDIoYfSlUkVtnevOawIXqOmMsRx8hmaGrh7uorRG14ckY6ZJb1PcL3LMf5/
         ABRIwxfI/s9zmELcHNfQIqmVb7H/CwRTRkW0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906726; x=1719511526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyAepGt8zwC+Uy9TBQ5kec4y0GaIIr8mJzAf1XxO3g8=;
        b=NbgRoZmSUAdtoN1FXL8MuAzZIsFHi9cDqS2GulOlfkZFStkOHsfN47/GeP9+WihzqY
         XjGQfLMpnspToWhuOaBQBoV7vw6lKSHSqxjdqlGTpjAjtuY/zbzBBpo5CkVnObR8t4ll
         Nq1aOdbwc6cy71CFtMRdaB05h/CE66c9Z8w+s8CA3qcx2SL/vd0EzbgjnlMPFQrbQQal
         tOJVwRsm11oomX2F20cQdW5C6+egE0emo3R6p2gONj0yEWXKn9NKkFzhrpNDh5YJjVjr
         vR3TCzkB1HzRN3Htq8qSWdKIRSkIi/sPZNMX/z5r6CmrWe0Cqn0TnmxohK2+m+9xr2r1
         U5cw==
X-Forwarded-Encrypted: i=1; AJvYcCUj+9uAPUx/ke2RVaVQ/dOjT73Eh4vEdWphqqOblbEvSaPlvbyX/BuEQWR265eVc/yb/UIbe/jiiG2RJHk+CwVlM406WlEpeyebyjZF
X-Gm-Message-State: AOJu0YxZvEKyAXJgIPyjPm/1MURLY9Ygr90exdyS2wW/5h9YqWSqmInS
	wDcrJ/RehqA66s8PccjfpDWqiIegUoXqyCBUZmSoig+YJ+Ryel0q+jgE2QGdmQ==
X-Google-Smtp-Source: AGHT+IFtxCTApS5PLIaX0tBJ9IiKUk5qiPoyB9ue7cA9nZarmfct92p63kyAz41a4pryyVQqjS1i0g==
X-Received: by 2002:aa7:8b50:0:b0:705:972a:53f with SMTP id d2e1a72fcca58-70629c5bcf1mr6759832b3a.18.1718906725954;
        Thu, 20 Jun 2024 11:05:25 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:3c9c:a224:3ec6:17d2])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-705ccb6bf4fsm12605308b3a.169.2024.06.20.11.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 11:05:25 -0700 (PDT)
Date: Thu, 20 Jun 2024 11:05:24 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>, David Lin <yu-hao.lin@nxp.com>
Subject: Re: [PATCH] wifi: mwifiex: increase max_num_akm_suites
Message-ID: <ZnRvZMQJUr4APwUU@google.com>
References: <20240530130156.1651174-1-s.hauer@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530130156.1651174-1-s.hauer@pengutronix.de>

Hi Sascha,

On Thu, May 30, 2024 at 03:01:56PM +0200, Sascha Hauer wrote:
> The maximum number of AKM suites will be set to two if not specified by
> the driver. Set it to CFG80211_MAX_NUM_AKM_SUITES to let userspace
> specify up to ten AKM suites in the akm_suites array.
> 
> Without only the first two AKM suites will be used, further ones are
> ignored.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> 
> Current wpa_supplicant/hostapd only put a maximum of two into the
> akm_suites array as well, a patch changing this can be found here:
> http://lists.infradead.org/pipermail/hostap/2024-May/042720.html

Thanks for the patches and research.

Possibly dumb question: what's unique about mwifiex here? Everything you
describe above sounds applicable to all drivers, IIUC, and I don't see
any other driver that touches max_num_akm_suites.

Brian

