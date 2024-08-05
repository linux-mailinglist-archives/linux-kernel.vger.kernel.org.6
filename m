Return-Path: <linux-kernel+bounces-274750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E40947C37
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0B3D1C21BD7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3A43A267;
	Mon,  5 Aug 2024 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q4iKV2Zh"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF043381B9
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722865916; cv=none; b=A6GJ0uEFZFWKh39MiT0AiGGJWBots4TKB/DQhXeqSfAPaJ4sXBmXhN3WHhcy/QInsXg4c3htmzwc5LDIahU1S0djfuCHP3FCfVo9gwoXxNCETh3rFN2zFzYYnyWpboFoO95ZSIuz9S11Gs0S7ulP2SwKrJqhzmjRqFkV6HB/zlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722865916; c=relaxed/simple;
	bh=/AQHrtR5h5O7jPYa96FCXxXdYahXu4b6b7nQxDZkFvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSREBDxtmksbqHrJy43stlHfElyGBwFA22kGz7AFKwCL4IVepyGxr69AvdYwyvkvbGMs+ay6pjT9vupGWF3JwvRUQO4IqgwwhdKaSdtX8DFDp1/e9BtSCAwaHR9ISwbjRxqNAq6IKWw7Uc0i9KSd5aQvbnVM+HMjshpKrnE9zIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q4iKV2Zh; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7ad02501c3so402267866b.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 06:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722865913; x=1723470713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=24KhsaR7Lyt0pADalfMlyDC/kBHqcMJwqIFxV24o+xI=;
        b=Q4iKV2ZhcuvMcFHmLjKWEZzpHC8j7pofGci6A/BeV1naAQDisioB9O9LCwadk3FsjG
         LZDwFZrnTS3Xf4GYx0pTfuH1G3TyVPP4bEX7hfYHyM5BqDtZ4N3cfUSpyX09IJL/rcwW
         V1X7rEyqMP64Ia0xW4GydB/35RiNExh5AX16OCIFrgto1PBv/EgeQD7a7E2HyXtWNpxq
         gZFdVEohUMFg1eBFoURVVCfELN7oRbTXQveK9bMG311Tkr9XQoLAhue0gYbXXxKTpctL
         5VMr+FV3pXMmcGTCRJxSTPO9zx14thsZM/bESVU/q3zKDZIJW8k9vPrtaVhaC3X4G51S
         9Tvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722865913; x=1723470713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24KhsaR7Lyt0pADalfMlyDC/kBHqcMJwqIFxV24o+xI=;
        b=Mn5fSnoJsbnb0jhM/uBJpcgdBA1Usjz4xHo/wUUKEhqAKAwY9K/lTWC7JrE3pix6Ix
         olpVE27ZxNar52pKwS66VH+syaMmEn/+1pY0WP+oLr2r1NQczsUOAcsdIc01PdMtdD9P
         EVZVAAy53arcVl7Ncay2Y3nXskxd8CV9qgSNVO1JsLRL02Opp+0zSx9Zwncwi/Yv0HRc
         S4sBieXMAgBA93uvb+ucsw+bM9X+BIbKZgdMeqi0vIsD5Ss756gp/hZkH7RUFSbplT1r
         VGQsbvl6v5bNa+8R2nXqaU1+lGOCJEdR6IqWJJwT8Dk3hlmoXX1mqnLTzmr3uvD+ocpV
         C0GA==
X-Forwarded-Encrypted: i=1; AJvYcCX05ei63XUYD2DYhpKfGU1V+KmnRm5SXmXUpcRnjHuMBbK5hWrsm4v9dl6B5gi3gnvtoxmiarVprO/DMMitRkVDPpPjBg9FGBHvji+g
X-Gm-Message-State: AOJu0YzyS0Mf+RZiJjdeBKQtFHEtOnxLNCFIHzGxFvFnzbmrflIy6nqV
	ja7ExeoFHxEGB+cULQhRxrzqVaUjhWaoEhfB94oWpVb2xTJ6R8Zp/2tCga3gMOI=
X-Google-Smtp-Source: AGHT+IFFM/8blKXit81pVr2Mv0h8jRP3TcYzMugO9+xBcfDh4uEgqi7RuNIHOiT7MH3GWierzUp2Cw==
X-Received: by 2002:a17:907:3f0b:b0:a7a:a2b7:93ff with SMTP id a640c23a62f3a-a7dc51bd262mr893412466b.57.1722865913037;
        Mon, 05 Aug 2024 06:51:53 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc3d2asm457320966b.45.2024.08.05.06.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 06:51:52 -0700 (PDT)
Date: Mon, 5 Aug 2024 15:51:51 +0200
From: Petr Mladek <pmladek@suse.com>
To: takakura@valinux.co.jp
Cc: rostedt@goodmis.org, john.ogness@linutronix.de,
	senozhatsky@chromium.org, akpm@linux-foundation.org, bhe@redhat.com,
	lukas@wunner.de, wangkefeng.wang@huawei.com, ubizjak@gmail.com,
	feng.tang@intel.com, j.granados@samsung.com,
	stephen.s.brennan@oracle.com, linux-kernel@vger.kernel.org,
	nishimura@valinux.co.jp, taka@valinux.co.jp
Subject: Re: [PATCH v2 2/2] Allow cpu backtraces to be written into
 ringbuffer during panic
Message-ID: <ZrDY90xLj50CJ-jG@pathway.suse.cz>
References: <20240803080444.221427-1-takakura@valinux.co.jp>
 <20240803081649.224627-1-takakura@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240803081649.224627-1-takakura@valinux.co.jp>

On Sat 2024-08-03 17:16:49, takakura@valinux.co.jp wrote:
> From: Ryo Takakura <takakura@valinux.co.jp>
> 
> commit 779dbc2e78d7 ("printk: Avoid non-panic CPUs writing
> to ringbuffer") disabled non-panic CPUs to further write messages to
> ringbuffer after panicked.
> 
> Since the commit, non-panicked CPU's are not allowed to write to
> ring buffer after panicked and CPU backtrace which is triggered
> after panicked to sample non-panicked CPUs' backtrace no longer
> serves its function as it has nothing to print.
> 
> Fix the issue by allowing non-panicked CPUs to write into ringbuffer
> while CPU backtrace is in flight.
> 
> Fixes: 779dbc2e78d7 ("printk: Avoid non-panic CPUs writing to ringbuffer")
> Signed-off-by: Ryo Takakura <takakura@valinux.co.jp>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

