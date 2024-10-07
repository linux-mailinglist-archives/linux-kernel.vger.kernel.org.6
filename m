Return-Path: <linux-kernel+bounces-353102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACAF9928A2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13F3D1F23FB2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6081DED41;
	Mon,  7 Oct 2024 09:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T2AekC6b"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F831DE8AF
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 09:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728294892; cv=none; b=o3WJjKKohYsJKB85uErVOqrxv0Kho0tO7D0xIByRB2DSIfQIR/sngcSbBQsv/DlY7/BFdwkxHe2ej5DqO7UG5H5KyJz4ApUpzbBPLcxnLUy8zaNnOgxdl9zUa9VkhXx2yiWk3pJ/1/9gdpFqsgCSsdQq+PhJIsfu6dc7PgiM2f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728294892; c=relaxed/simple;
	bh=XPuTahtxHfXasKgZvlJ24F5uRaM7cQ4b1F15SQPxJl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFeXgZzN7wYz5quRFnuvP3b+Gw8R24j9jImTwYywWK5W4Ics+x0Qh4YD6v5jZKXmasUB3Hex1r4j/kNSFAAQsk6dXRIHEB8oZ0V2HPEaaee0CXgl41exTuZJcM9c9gDwDrMJgTW6rIr/oKN9VmzHL1Pflpz/d6w0yQyqpPKWwWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T2AekC6b; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cb60aff1eso43042205e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 02:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728294888; x=1728899688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gaUYthw6ApPY7iMEBlPEvXCrC/ELjE9zT9gwyCjWi3k=;
        b=T2AekC6bVcBTuQpMKcq8+kdZELdWRHWLETkG84tpVOJKPJW8sEnPY7s/VDZET7rOIJ
         pNid/w3I3a8mBR5nyLsg65+2jxxUvdHwi7tpiy2URL+nNFzBf9AAoP4t8zDL/Ro2OKnD
         K7ZCPxtGHg9yI8TzOqQwm1+as0U0KORlWK1ruX7ZrqkDE8G+2rj+mVaJjVrZ6pDF8xuy
         oMrZmv8yF5Os31LL2UNz8XIHYwqKVgcmAw2l6tz5Jzaa6sG2/ydqDgTYn2dB7GWR1fjh
         638n8SrrJO8lE4j/FDYM8fwk1Ve961wKkIU2PAeYpE2Ue75NNLSFic2Tq4u3lXpfrEzP
         F17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728294888; x=1728899688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gaUYthw6ApPY7iMEBlPEvXCrC/ELjE9zT9gwyCjWi3k=;
        b=KQf7g3BdeozX37Kf9k7tAQf2Cbj/BW9cdgeXmuW4dD9t5VgBSDjtfhh8x9Qs0Fx6aK
         EV9EU+txOhXxthSZCX25dbqYhFQH7Sx0/DTLbcz7ERqu9JAMnBMPBqJG1H9U4ZGgg6Kn
         kF2G95DSA8giuj5QKeXzibD1ACo279xnkm7iH8x8tSYA9db2RXn3MgM8EIIa0qwwAqH7
         KFl1pf+Jxl0w97aCMZR78fYzq+farj/flvgg80SjToCdab3SWHTM6aNAmSU5ubvZ+JT5
         XyonY18QVU/rPgv4onemufneOKrJrayjGBB8QtkbKfUJjkJsZ6dO0uUrXgkO5iUCUTjZ
         j+Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXGgI5w+Rig5OaXbGRo79av6CZ2VvS/deAKPyzeVsK1Kw1WYL8JbzHjY4xlo5XB5Nsg9o+7gVZekuC8aSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCG3CFm0NDLA0qLGc0rDp971G6S2ROKw9lLEc5WC46tgjYCQj5
	vvwoUY7LBDhL9nAx2WaswQWc7BtHE11GuLsDFRhENbtWZidbMZ9Zstmy855O2LE=
X-Google-Smtp-Source: AGHT+IFVxjKENE97XWETeGH6TckcY3Iu3heqkwwXnzL72mlbXZp4BBGafyTCRPMtDD9hj02mIVRoVw==
X-Received: by 2002:adf:ed8d:0:b0:37c:d569:467e with SMTP id ffacd0b85a97d-37d0eaf7aa1mr6482622f8f.59.1728294887935;
        Mon, 07 Oct 2024 02:54:47 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a56dsm5329817f8f.41.2024.10.07.02.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 02:54:47 -0700 (PDT)
Date: Mon, 7 Oct 2024 12:54:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] clk: imx: pll14xx: Fix potential integer overflow
 on multiplication
Message-ID: <3e0def9f-ebb6-4171-9395-1da118b0ea29@stanley.mountain>
References: <20241007084840.1167527-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007084840.1167527-1-colin.i.king@gmail.com>

On Mon, Oct 07, 2024 at 09:48:40AM +0100, Colin Ian King wrote:
> The calculation of fout is using int multiplication and assigning
> the result to a u64, this can potentially overflow if the int variable
> mdiv is too large. Fix this by making the 65536 a u64 value to ensure a
> u64 multiplication is being performed to avoid the overflow.
> 
> Fixes: 53990cf9d5b4 ("clk: imx: pll14xx: consolidate rate calculation")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

mdiv is always clamped in then 0-1023 range by one of these:

	mdiv = FIELD_GET(MDIV_MASK, pll_div_ctl0);
	mdiv = clamp(mdiv, 64, 1023);

so it can't overflow and the Fixes tag is unnecessary.

I think the reason why "fout" is declared as a u64 is because we were worried
that on 32 bit systems the "fout *=" operation could overflow.  That looks
reasonable to me.

regards,
dan carpenter


