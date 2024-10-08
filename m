Return-Path: <linux-kernel+bounces-355745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6796C99565E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7A98B242A2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB57212D13;
	Tue,  8 Oct 2024 18:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Ao4PoGI9"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C43F20ADDB
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 18:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728411771; cv=none; b=N4RfSbSwgnu/i39+hSwGnCSw3MoyprxBbVZkNZR6nfjZbTWNq9f4QP5v9xuS24WmTHRodJ5AOWoHtL4CfObn2ygSCxVKrravxJUDvEOJGRPlVChsjUy8nDH4t43Ezun6AfHOQ1PqgKbecCPpdVzgJvluin+zCzcwqw7iHR3a03c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728411771; c=relaxed/simple;
	bh=Soj8mFaLd1Cyy0ejjBioY9cxLP9QIIW58JDFeiu2ts0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMWcOWCqpsrFn07drD/g4W1Gu8M7X+M/GYJdMky7gSjndifHzU/Iysn5F/xta7M8OLT9VqLt7HQQ8rfyRWmUYu6clgTtGnBd5fEIoZ1Jv2CIR3gamTkDqoNSsTOpZncUE4uvkLNShlV4f/P0F2i8vWew4g4o7CIFp2R9q9UmGsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Ao4PoGI9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20b8be13cb1so63888765ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 11:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728411770; x=1729016570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfgCpS5PaaDvZjkTJaE/xBzcbJqmdBm8+yyCnyw3De8=;
        b=Ao4PoGI9vwBp2XBS9TbUrC82t+VibfUVIqpnOWesXqezv0Br5BL3Ty6wA+tIYl1bwg
         Gl3KwX7OxATwATQ4aFYcSBL764vZgdr5lfvNManB36kYOHUNNMjmJjglTqDhY7hkgNAh
         S6g4uoFnk9dwmJfotqQFxrZf4dItl8v4X5YDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728411770; x=1729016570;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mfgCpS5PaaDvZjkTJaE/xBzcbJqmdBm8+yyCnyw3De8=;
        b=IJznbtNklTm7q89ImRSm8SEZMHVigSDt3/ansRH+w0g7q7Ev2ipR9XtENc/DnW4Ago
         neai+fE6HGkNgKqsmrzqQ36aF5DxUj1Zi3GIDjrL0MI7D2xfGZcQwJ1gSP2poG2oXt9C
         e4Qhe9Ky8NMbv6fePS1ZfYKby0KCP+rPoq/ANTZ2SCaqQhfbApoeZBIkOybfSlRKR7bd
         LIl4reT7+kj3wzBcuMBsBylMnvHOXXfHppzkeuIDh75X6RLFzipvO8aHtBU8Mvkc/6fm
         QyvtKKB9ALXdhHPjJ5dHlJ1KI32laRejx+JQdeWgY2F6seU9NetdvVYWp6sfDFYDAEnb
         YzMA==
X-Forwarded-Encrypted: i=1; AJvYcCUgw7UwHD+tkbn3Uf8fg4OnucEVKhK6vY5QU0Y4IF+y28jUZGToJPC3RXTfAqh+fapU/CYpA4EuRNEPUjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3HEmP2nhbqbg/hDc3aiGJBeumEBHKVBTvz2eMcs90zERFcc7W
	PkkN3/8rBC84wWOV0tXnZ1Fu5qCTs4mWeo1WenII4BVJesD64jKVNPMySVeDiVY=
X-Google-Smtp-Source: AGHT+IGLwKH5D8GmqT91lF+IEqFV1bkPlXaOCwMdX6WQyBYQ2vbuWPbJ2h7utnI4zy5Lzw/E/iDnDg==
X-Received: by 2002:a17:902:ea0f:b0:20b:a431:8f17 with SMTP id d9443c01a7336-20bff1c4055mr294243605ad.58.1728411769685;
        Tue, 08 Oct 2024 11:22:49 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1395a408sm58422345ad.193.2024.10.08.11.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 11:22:49 -0700 (PDT)
Date: Tue, 8 Oct 2024 11:22:45 -0700
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>
Subject: Re: [RFC net-next v4 3/9] net: napi: Make gro_flush_timeout per-NAPI
Message-ID: <ZwV4dUxPZIVG366J@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>
References: <20241001235302.57609-1-jdamato@fastly.com>
 <20241001235302.57609-4-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001235302.57609-4-jdamato@fastly.com>

On Tue, Oct 01, 2024 at 11:52:34PM +0000, Joe Damato wrote:

[...]

> Note that idpf has embedded napi_struct in its internals and has
> established some series of asserts that involve the size of napi
> structure. Since this change increases the napi_struct size from 400 to
> 416 (according to pahole on my system), I've increased the assertion in
> idpf by 16 bytes. No attention whatsoever was paid to the cacheline
> placement of idpf internals as a result of this change.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  .../networking/net_cachelines/net_device.rst  |  2 +-
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  2 +-
>  include/linux/netdevice.h                     |  3 +-
>  net/core/dev.c                                | 12 +++---
>  net/core/dev.h                                | 40 +++++++++++++++++++
>  net/core/net-sysfs.c                          |  2 +-
>  6 files changed, 51 insertions(+), 10 deletions(-)

[...]

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
> index f0537826f840..fcdf73486d46 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
> @@ -438,7 +438,7 @@ struct idpf_q_vector {
>  	__cacheline_group_end_aligned(cold);
>  };
>  libeth_cacheline_set_assert(struct idpf_q_vector, 112,
> -			    424 + 2 * sizeof(struct dim),
> +			    440 + 2 * sizeof(struct dim),
>  			    8 + sizeof(cpumask_var_t));
>  
>  struct idpf_rx_queue_stats {

Now that idpf was fixed separately [1], this will be removed in the
v5.

[1]: https://lore.kernel.org/netdev/20241004105407.73585-1-jdamato@fastly.com/

