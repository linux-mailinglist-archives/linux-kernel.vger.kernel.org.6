Return-Path: <linux-kernel+bounces-236754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FCA91E6B3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7C12838BE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D7D16EB59;
	Mon,  1 Jul 2024 17:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIiUcCMW"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1CE15EFC2
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 17:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719855148; cv=none; b=jwSyvsHv88JYr0wuEjpfmxncrAA8fF93C3SDKtQH8eMOtqOf5Ua6x/U+VFmdIre6FDJ/GTr+I44ycR722c+VMFeqczsm9rSIx2y9kR8cXaHGh/Fm8tdm1hYf90M5pspc+tSOTYKq+W185EW03hjbBFuaTNeghW0bzH9Ie2vBD6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719855148; c=relaxed/simple;
	bh=8Od/MgOnHO9mA7z6pHLcRjf5+XMPEkF1ZQnArpRiABM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhkGwVnrFc88jDt+ODibWHYbnbwIu9OdWFL/bXkvep4YnwxfxjjSPXu8QqL4jnBjT3wYUlIC8joV0nyxklPrdTzUwR9lGjBLws24Isg9qyJdVpgJ7q9IBMJLh3H26dSFu5oaHbgb1sW+kMgcHih9HdU6wXlnqE6DslO/ZOEl/U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIiUcCMW; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7201cb6cae1so1632202a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 10:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719855147; x=1720459947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KOquWB6R7jPlu+/gNBjC1zvoBMEzqFFKAHKl/0V4Xwg=;
        b=VIiUcCMWbppBNreRWzCn+dLQStsI87mFBqIJuWKFR1OEPZ8QJm0Exw31YEK5saNOcj
         RcQTLlbH2CrCDR0DiPrToP7ArGNBiVYqJnfSO/C3nRj2ccuTXzEeWiwGai5ui4VLzPup
         la3C6Vu7pZ0V8g/1sZtMG/Nt53lnoIh3PjPcL2ItdxxKomJTpPRVFYEpxsGMyOKnpxDG
         mDgs3w2qpRmRRMJFjSmlWM6TS4BZOPp3gHKiNxeK81iC3cob6fdgo5qkhmZkk5z+AAqg
         6cDC2Fv//6+ITKwHCV3tJ9//oJt2Z3D+zu0uj7N4JDb46gxTtMjM0wT8H/e9CXoamfTt
         yw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719855147; x=1720459947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOquWB6R7jPlu+/gNBjC1zvoBMEzqFFKAHKl/0V4Xwg=;
        b=NYUQNw8xfbAovNsxcS5lT2dP/b4QGfztnSOPWB4J7c1tOSvK0YHWj3SGzLXNFl4GGT
         fUBvcC8mHxplBve1XmCpWcIHcu/A0+iTuElBFtKaVpfEwGUS2V83sdivCqE0tjcAXiKe
         XQVpJNFmZlsOtwwC4KP4IjJ2/KXWm62n/QqwsI7EXfj/SeWHQG271ZU1VTJo0n8Z+1BV
         5jsOQxMZvBeosbfO68Ud63IEJExbsliGZTTSnFP24VKol004RPdild5D4YaB4UiuAH3e
         gSzxchbl7EQZHwcu7cS4T2J1VFu+2Tsdg96/c26vG38Zw+ot5mCqjEOBVkdRUuGO1Xgk
         kWDg==
X-Forwarded-Encrypted: i=1; AJvYcCXWlr8PNDmIB/6cd8BZdC2qlryODgmkb3WqY4JO2leJq2bi5EzZmb1Wi2zuP8VWr9R5//rah3jXZ6x8EBGUDCY0u+EInoEGyUEZsHRh
X-Gm-Message-State: AOJu0Yxi9m37J27PAhc8NP2TGOxeS/tNBdfT/e/FfBEi7L69rLrJ7hBY
	puKd1nKyWRRrnDEWmkv0eBGgZWcCQYqGA3Pp22hyHJOq6sVj9Bkq
X-Google-Smtp-Source: AGHT+IGcwRW9DViCRjPwgEa62mvDogBZ+M8MLZrIQVFOfdrcOpInk15Gh5BLpx+aoJP25OEp5yLbyA==
X-Received: by 2002:a05:6a20:7aa1:b0:1be:e961:6a3a with SMTP id adf61e73a8af0-1bef626e7acmr4371786637.51.1719855146803;
        Mon, 01 Jul 2024 10:32:26 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e3827sm69111705ad.85.2024.07.01.10.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 10:32:25 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 1 Jul 2024 07:32:23 -1000
From: Tejun Heo <tj@kernel.org>
To: Yi Sun <yi.sun@unisoc.com>
Cc: sunyibuaa@gmail.com, jiangshanlai@gmail.com, jaegeuk@kernel.org,
	chao@kernel.org, ebiggers@google.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, kent.overstreet@linux.dev,
	niuzhiguo84@gmail.com, Hao_hao.Wang@unisoc.com,
	yunlongxing23@gmail.com
Subject: Re: [PATCH v2 1/2] workqueue: new struct io_work
Message-ID: <ZoLoJ-uBo9qyAlMg@slm.duckdns.org>
References: <20240701075138.1144575-1-yi.sun@unisoc.com>
 <20240701075138.1144575-2-yi.sun@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701075138.1144575-2-yi.sun@unisoc.com>

Hello,

On Mon, Jul 01, 2024 at 03:51:37PM +0800, Yi Sun wrote:
> +/*
> + * If a work may do disk IO, it is recommended to use struct io_work
> + * instead of struct work_struct.
> + */
> +struct io_work {
> +	struct work_struct work;
> +
> +	/* If the work does submit_bio, io priority may be needed. */
> +	unsigned short ioprio;
> +	/* Record kworker's original io priority. */
> +	unsigned short ori_ioprio;
> +	/* Whether the work has set io priority? */
> +	long ioprio_flag;
> +};

There are fundamental limitations to this approach in terms of
prioritization. If you tag each work items with priority and then send them
to the same workqueue, there's nothing preventing a low priority issuer from
flooding the workqueue and causing a priority inversion. ie. To solve this
properly, you need per-issuer-class workqueue so that the concurrency limit
is not shared across different priorities.

Now, this limited implementation, while incomplete and easy to defeat, may
still be useful. After all, ioprio itself, I think, is flawed in the same
way. If f2fs wants to implement this internally, that's okay, I suppose, but
as a generic mechanism, I don't think this makes a lot of sense.

Thanks.

-- 
tejun

