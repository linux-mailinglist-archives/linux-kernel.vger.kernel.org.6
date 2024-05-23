Return-Path: <linux-kernel+bounces-186868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E098CCA30
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 02:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4DC283BED
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 00:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F8C1879;
	Thu, 23 May 2024 00:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KLeBkCQP"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAC9A34
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 00:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716425621; cv=none; b=gs2x6gdYVF5241RwSzuSl2bp7DQpfCYk5V8Maotd5YMPq99ycpMC61WWFus8uxe1QnUDOJvlZUlYSCYFOY42Hwrz960itIP0BQe43/XX1A2+ZNxlETlafZD7O2Pq76roUGUt+0mcpbKBq0PT1ejggQla4yQ335iXIsX4GCDn8Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716425621; c=relaxed/simple;
	bh=Z5XHSaEKc5ri2JYza9/Yyvvs0yPAYhbfrv9f5+LytjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRAVxtSnyjd0EpfFhx8V10QjHkwLP32djPwcjXmGt05sfpqCLLFSo136WKTLEPoj3nBQ5Od/T5QaiKj/PZbw9NjVSlmGq5RUe2q4qZhAlxvk3FX2eSNSKqmCh3LYjOWBTXZrXZ6KONB0fB9IvOvRiTAbxwbwea2wMBnv9sI7C74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KLeBkCQP; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2bde636ddc2so83649a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 17:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716425619; x=1717030419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cEB3Ssz3rVHNy4q2CLUVPtWI6iR5h31rZRV5aPJlcX8=;
        b=KLeBkCQPg4n93In8pSvwACpBeJPiCxGGKhOo1BqMz3SW1n29nkp6NP7gS6lLd9ODgq
         VRJlxFcemeCY9ABP8LiK00Sr5vG8dxG3BYxyNjBaXJGmFkQ4FWMOw8f6VELDq/WrK1vs
         /S+AyHmaSzFXnJgcIzOH0SzJGw/hox5Masoyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716425619; x=1717030419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEB3Ssz3rVHNy4q2CLUVPtWI6iR5h31rZRV5aPJlcX8=;
        b=wmvxpe5gGGTAPTg/zUbodr8/mCUaeJ+XPjPqwam7tEaKPl/dg2okFUHAc9jSSxfkmA
         svIiv4+5Hnas6UItYRsORXlkQnKwJcmIHPGRlguxGh6UXqWRp6/9BxlZAt3i0KjVJKZE
         /S5TsexAd2lCposA5w5G+TdfN+FgjKF6SsvCODfQNM6fppN8IGzd71PlW6FpgWEt/ApJ
         tzDW27gGrLaukDKrFPebpp9U/xMAzLGdxjIbchinj/eJXP4vQspZTJ4jWUYIBisXAch8
         BNGVE+sCKOfKHN8zawmShmNzbtEHtMfTUEBwbcAy6FV6d1HwFiiFr2szcuTJSS0NapOx
         Ddzg==
X-Forwarded-Encrypted: i=1; AJvYcCV1cCWpoetUb45rTHrp6SHfkkGKETxe/ISCJMoPOgZhMJT+H9ThxeA86nw3ceGcbiVXRLPV8AgfH9Agnjztfdrq0tyXHZUPmVBcgdVf
X-Gm-Message-State: AOJu0Yxco/nyTaZFxoTGj8JPS81R/9xj4I4OvwuH0Av/5Dt0Tjhh0pkX
	CCNufLOU5XAD6izKy2J4AszAx4L5cdc/zvhB19cQQBqFjDwR841OdeeBPWDO4A==
X-Google-Smtp-Source: AGHT+IFXjRxkrOsEyl/V02ONwKQWgBc1mPyEiToakMTc8T7ppk4TKN20qemr5r7MQhrJky02k7Cdhw==
X-Received: by 2002:a17:90b:2381:b0:2b1:e314:a5e6 with SMTP id 98e67ed59e1d1-2bd9f46994emr3841475a91.7.1716425619372;
        Wed, 22 May 2024 17:53:39 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:3a97:1cc8:ab6c:8d0f])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2bdd9f2389asm392569a91.43.2024.05.22.17.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 17:53:39 -0700 (PDT)
Date: Wed, 22 May 2024 17:53:38 -0700
From: Brian Norris <briannorris@chromium.org>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v10 1/2] wifi: mwifiex: add host mlme for client mode
Message-ID: <Zk6TklTIbxZxIWyb@google.com>
References: <20240418060626.431202-1-yu-hao.lin@nxp.com>
 <20240418060626.431202-2-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418060626.431202-2-yu-hao.lin@nxp.com>

On Thu, Apr 18, 2024 at 02:06:25PM +0800, David Lin wrote:
> +static int
> +mwifiex_cfg80211_probe_client(struct wiphy *wiphy,
> +			      struct net_device *dev, const u8 *peer,
> +			      u64 *cookie)
> +{
> +	return -EOPNOTSUPP;
> +}
> +

> +		mwifiex_cfg80211_ops.probe_client =
> +			mwifiex_cfg80211_probe_client;

For the record, I feel like this question was not adequately handled
from v8. That thread is:

https://lore.kernel.org/all/CA+ASDXM1PEMRyxRpBryJ7G6e7yzG8Ku+g2_qpHN3g5djFpAWkw@mail.gmail.com/
Re: [EXT] Re: [PATCH v8 1/2] wifi: mwifiex: add host mlme for client mode

Brian

