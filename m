Return-Path: <linux-kernel+bounces-338115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4DC985384
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C5B81C23511
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AAC156991;
	Wed, 25 Sep 2024 07:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pga7sfP9"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CF6155335
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727248522; cv=none; b=YAOK5yAPr+gdg0p7Y9gl9t1f9LDNqLcUjUJgHAzSxs01kKaD5+n+Y6QSOOnwmqrK1ZpblF1V+UG6FWzx6Gegk94J0bFuKP+Yx15obGhGBBe7R22OnxvfPK/GRjuJhWQfuqfu/tiNMgWYoXBFpu7IvOsqpd8u7gj80rqka3yRL30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727248522; c=relaxed/simple;
	bh=bzDm4Enp3hXtpfidzf2ceHBrZX4lL5SUOpIuF63CRsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPWeqcUhgxfXDEi1dEkbm/9nOqNLmYg4xOwlqITx4P8tSUt5G6FuhxPzxoNckrhSHZo0kclc1zhBMJvLGnD9RYE6UeCMLPmE3/TxudzTXoa90PTl0p6oU0QQEExG7OxHzpNab0n8grNwgIn7oVJdD7YDx4XpgTQe51bv0DAKc7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pga7sfP9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cc8782869so60871255e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 00:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727248519; x=1727853319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CMsn/bPHV7l0Tw2fIB2aHezcx6bxNnjGnFjV9MafOuk=;
        b=Pga7sfP9lc06KLzb19mzsp4vCaXNxMx/B9xE9caNSqdOntaDCpSAzZTIpTOgufIXEG
         9oNeHKUMZyQ0agR+t+/h3s9Qo1JQVfpEF4f6Qt5DlbvcwkLQIyhw7Cm01YLl8NyrifsY
         OgqrT7O2wmKB2pr2tLCaiRf6mOy4WRVYS2OjqoRQ2CVhX66hTnUFUTjjMF2qVL8v8tb0
         JZ3R9yhazMP7j5X3MvfU+C5UyVj2HwcVI0wBtN1cbkOtUhUuQQIRuQxgUnEOG1jQAZL/
         f4i2yZ2yPpglvlYZcmtamL8W+nAVv2OqydX+XyudFPag0aRYOPlRdQ1WedsOQDnsbUCl
         8jUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727248519; x=1727853319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMsn/bPHV7l0Tw2fIB2aHezcx6bxNnjGnFjV9MafOuk=;
        b=dyDtUW8ffGv7gDXv4VmiqLAOYBLfwrx0AVFX0qo/SvU8wzJ60VzvGQcNzkJwnW9wkx
         D3pcvTYv+KfWhV9m0GUvwq81Lxm+oDq8MoAw3MvuWkCDJ9irugOPuwRojh9WC1HZ3T+z
         LfdjAdASu/uFO/GhZ9lkMLiJvQbSb5RYVG9UeiDNApMaAN5lVjCRCa1BDnKOxBNqq3U8
         SnXBWTnkhybFyveMiccTXEfl6vnerOGvX+WTv5PDltCFSw/VR9ATAWFMhDqOefna8CFd
         ECjHkCBIuhhUW07AzblwvGVqKM6Ay8DUx8NjYAwjYLMLg7vLIw7RA4995z/17YKREZNX
         PMIw==
X-Forwarded-Encrypted: i=1; AJvYcCWb04+7Vfnkziheedxrx227f3lKn/ycznispwnSacbuzlqDSlXk+NZ26x4hoQDHAafXBz9880hsA4GF9KM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCp0XPk3Mk4A9eqYZ/f6iTBZqmgRwC9PXuf6sBGf09vrxe2Aho
	U5bKC6IWRWLV1XXAdrKAwhB7v2z6rOn/xakJXdaSP6ij4CZvk6aVsJQQftcteck=
X-Google-Smtp-Source: AGHT+IF7DMs2N1O0IVGGMtrVRngCQqRx58CEUEwL0EQgeeKVizhe2O1tSrDeQaTz7DIsxKIolB78Hg==
X-Received: by 2002:a5d:64c9:0:b0:371:844f:e0c with SMTP id ffacd0b85a97d-37cc246b3bamr1236159f8f.10.1727248519192;
        Wed, 25 Sep 2024 00:15:19 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2c12b4sm3187911f8f.25.2024.09.25.00.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 00:15:18 -0700 (PDT)
Date: Wed, 25 Sep 2024 10:15:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: Julia Lawall <julia.lawall@inria.fr>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	netdev@vger.kernel.org
Subject: Re: drivers/net/ethernet/intel/igb/igb_main.c:7895:6-11: ERROR:
 invalid reference to the index variable of the iterator on line 7890 (fwd)
Message-ID: <a90fcff3-f118-4e33-ac7c-303a10f4f4de@stanley.mountain>
References: <alpine.DEB.2.22.394.2409131949580.3731@hadrien>
 <20240923140125.GG3426578@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923140125.GG3426578@kernel.org>

On Mon, Sep 23, 2024 at 03:01:25PM +0100, Simon Horman wrote:
> +   Dan Carpenter, Rafal Romanowski, netdev
> 
> On Fri, Sep 13, 2024 at 07:51:48PM +0200, Julia Lawall wrote:
> > On line 7895, entry is never NULL, even if you are at the end (which is
> > the same as the beginning) of the list.
> > 
> > julia
> 
> Hi Julia, all,
> 
> Unless I am mistaken (it often happens) this is an issue
> from about a year ago what was fixed within the same
> time frame by Dan Carpenter in:
> 
> - 4690aea589e7 ("igb: Fix an end of loop test")
>   https://git.kernel.org/netdev/net/c/4690aea589e7
> 

Yeah.  It's weird that the zero day bot is flagging this as a new warning
"branch date: 18 hours ago" when it was fixed last year.

regards,
dan carpenter



