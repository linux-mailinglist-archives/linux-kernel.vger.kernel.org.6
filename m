Return-Path: <linux-kernel+bounces-321736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B02F971EBA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A1F1F230E7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EC8139CF6;
	Mon,  9 Sep 2024 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XHR+6EIf"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02721BC39
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725898019; cv=none; b=mOLMc7duJJuGdXkrHEJgO64BSMGzWYRNCBQ4LxQkJlO9lqGRf3DH8eCn4KX/JDZO0QhBoQacM80G+nHiH6BFm5xbK33TuAO1xpGAPptyEmoiS0WflQqarghHAXMrcjlypwD8OGtzvrurBqx1GFFVmC8x7OtjBgtTIcRzNUgG30Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725898019; c=relaxed/simple;
	bh=AMn6y0LLnUyZw3lQvi4U/9tc1ZepqvIfjkITOcTT8S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgpMbLCqGL9PkWD63aFOUm2Qf3+gnHCfNr4wKZ0nAveCkY3bZd/7nt81ftRGdQVs0w05gtQ1uUrlhxQaZYDwzuCnYeZb6J3oec/ps8OKuzp850BOBucNPg5kWM9YGNNzUENq3+bWUD3cjbhZFZ/NMY0oakSLSIFn+efD4Wjb5DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XHR+6EIf; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5365cf5de24so2769174e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 09:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725898015; x=1726502815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TBo7euW2AxmzY3hCumIAJKbC5cFKmjP+M3T4dF3osUk=;
        b=XHR+6EIfmNl1HgRhbdS6lME0yKMujaUdAF64w1heWjtDTQ3eEZeuLVa+1p3l2A/ESS
         roBa8uuPoLdqpAi/Go2L4AbBmsMmfoM9s+NOjIydS8NdD1mV39TX9Kx7FQOtJlRE4DZ3
         OsuHrB66NXC8njQdm3GJ4bktqJW55ZlSHuvxbpLHW1KMkcg66vj+rLaIbwCE4Rn6LMdZ
         Q/6xHnV4bYPV+vrdd6gt4brFwsAuvlXWZqkt3Vntu1gEA4qRKVVFXecFAz/MtZKjYuRC
         /akSp36H4M5Pc+fSr4QqGfC7UlTQ6lnQbRqRcVQIbpJ2NblGH8WcmRZrLKalCymly9zZ
         Ybgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725898015; x=1726502815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBo7euW2AxmzY3hCumIAJKbC5cFKmjP+M3T4dF3osUk=;
        b=jqyHWiIpu047DLrnHk55OYHiVYxDPFiffSIfCxCoheFyBeSyQwO3ldQOpdGCJ/PAhS
         5UU3Su8sZq4XvEx2UaPwiTne1Hz0DsTP3MVoPnhzX/m5DwFfwBJFrslp/3/v5CpmQmFi
         lG4TF1oFdB1+RTSiuh2A8kUI65w+mQ4SvQ6Wa3zVbOHseEUa7jiYTkG2fECo9iwbsMH4
         ONHwmIk78Vv5bs/M7QBfbwiD6H+FqcsaTyJ2tETGb5ifuc9rKE6CAGB8yRi0Mr+nfP9F
         KkH26K2NeIM9cP3T4rJ+WalMsUG72TOliSqTT16140bX7POoa5AMae9W3xu/TUrri+ga
         dVIA==
X-Forwarded-Encrypted: i=1; AJvYcCWXV+CaAoz+6hTLxsJwm3Kb9rQaAb7nog6uXxUKtpO+QatUKfoOUhLYjCENtAwk0wQ/tjk4dbHTzRRtBrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk8PRzLiHmaJe9KFdsEw1+uNZkiAGP/bedLFdf0cK6NJSrMdkA
	ODNe+hVDShtXGnSsh1cJ08dyPMJkD0IsgP11bknkhv+15gHruf/SCaDV0srjP/zX7d8UIwS3vm7
	u
X-Google-Smtp-Source: AGHT+IGXD9saRSaDZFp955XdoS7d6+sE6nBRqw5e4xrE88B8h6aYoLJLp6Rx0f9mJDF0nGUiOGewzw==
X-Received: by 2002:a05:6512:10c6:b0:535:6908:d4c5 with SMTP id 2adb3069b0e04-536587c6517mr5195463e87.34.1725898014850;
        Mon, 09 Sep 2024 09:06:54 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d5dd8csm354635166b.205.2024.09.09.09.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 09:06:54 -0700 (PDT)
Date: Mon, 9 Sep 2024 18:06:53 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yu Liao <liaoyu15@huawei.com>
Cc: tony.lindgren@linux.intel.com, liwei391@huawei.com, rostedt@goodmis.org,
	john.ogness@linutronix.de, senozhatsky@chromium.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] printk: Export
 match_devname_and_update_preferred_console()
Message-ID: <Zt8dHUN3Z78fmYFd@pathway.suse.cz>
References: <20240909075652.747370-1-liaoyu15@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909075652.747370-1-liaoyu15@huawei.com>

On Mon 2024-09-09 15:56:52, Yu Liao wrote:
> When building serial_base as a module, modpost fails with the following
> error message:
> 
>   ERROR: modpost: "match_devname_and_update_preferred_console"
>   [drivers/tty/serial/serial_base.ko] undefined!
> 
> Export the symbol to allow using it from modules.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409071312.qlwtTOS1-lkp@intel.com/
> Fixes: 12c91cec3155 ("serial: core: Add serial_base_match_and_update_preferred_console()")
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>

It looks good. I have pushed the fix into printk/linux.git,
branch for-6.11-fixup. I am going to send a pull request
later this week.

Best Regards,
Petr


