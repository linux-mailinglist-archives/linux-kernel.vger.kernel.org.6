Return-Path: <linux-kernel+bounces-287748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D56952C25
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655791F21331
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A849D2139CE;
	Thu, 15 Aug 2024 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W03e3rnW"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4628E21019C
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 09:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723713913; cv=none; b=knje3NagNDGjYZPUqT2+ElFoupP82zMzK/CF5+5TipabeP05HXPG44N17aME9eQwY0pLVtef2w8t1uu/iho3ja7VdGeahgjnYJXzlE6veknr1GLvJJUQdoQLBvFCUP291r95EsC7WS5MyAdb8+cvaTt6TD0kMW+EgqYMrQYnR7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723713913; c=relaxed/simple;
	bh=g/lyUWU8eCPaBAfe7GWY+aklIjDnUSlq0pYrPSLfBH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IugUUCP8z4nUCXm4Av8y8YW0w2GfVbpxPKf4zHt2kYXkUOg4cjiMrOrwll8CYjg7awZMyb6cOI5h8cjdnivJbMMFZT3ITpPPdgpggG3jZUVUhjb6m44RqQUvBBD0LJtrQl+vHSEKXCNkJ70p7lihvY9nrfYpUATvr4ix2tLpzSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W03e3rnW; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-428e0d18666so4184895e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 02:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723713909; x=1724318709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GIRH8ZYT8hEH2GbZtKPw+s8BGj/6k9t0nmVaDj+JHRA=;
        b=W03e3rnW/HgTS1NY2F1u5dD8MRAA1C+JCTjFBJDdicpnyXxw5Md/4ncMhOc5oOxCCj
         6PfdlTaJjDi1SdSx2BgFz5ByhBLEdF+YvdT+kft4hdy/RkvF9l+9wYO+kH+DMjnnnvb5
         YOkQ3Ov1562yS5mhVLPBNRS+qd8wXlcKuPILA6Agf3wbIXBDdxMbgaJWG8pEd++ysE+y
         6aAC2zN5iNt0vEUg0jpPGQX4mAPhaatge3JL5lheDaG5X9w4Yef5lVhZJlim/C0jt90w
         sTHpbKgU7kDx4MOl9jzZgTRK18ufg2P0we9HRiai3kvoYsY5gFZBePJyGEHMfVvS5p84
         pDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723713909; x=1724318709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIRH8ZYT8hEH2GbZtKPw+s8BGj/6k9t0nmVaDj+JHRA=;
        b=VYSgLIV8w4AzSFU12iRlUDwuYBJTMInVKesy/kGzSCgenZJ1LtBPjPPv5jh51Qy6X2
         gL0KYyu/+FWxufRoFeIVqAQ0HkuBOtp82D1hmyxrTFZB3t9BnBE5l5dQhBYIOc2hX1G1
         3DLWiDVFnXO1oZavzcx+OqQ6fKWIT3msSTadyUJMvjNiXtBIX7TvZFaWyPoFrQo8Y5ok
         46LdTWdqWPK5uu7wn2rDGdUgWYMWuZHxCVtDy2MbbYSMcZc+rGFSjocVcNbvGCWUOxE8
         VfjMsSU4EV4pkSHi2+1a47qhE8a4wtmC1/pnUzKL/ZD8CJH4/gFkI2VF3GunYnkIJq/e
         H++w==
X-Forwarded-Encrypted: i=1; AJvYcCWA6niD3CCMruEv46SRKvkON9Iwl83fAq9SwjyID+27Im5BYMQj+/9pDaMjJztxjJy3eE0s8Vk9uw67N9W/KGtKehFdlNh66L/UC0iY
X-Gm-Message-State: AOJu0YyacEoJd+HejrzPA7z/hqNzjIDC0s52xnLGhLo2LP6Q5XZyf9Ay
	L/1OMGFNmWHCC7liprCIurT84IxTRsW+WvLHxWC5fFaL2p/RZ2lXlMs5FDwxokM=
X-Google-Smtp-Source: AGHT+IE+tPJUHOuuXvabrngdhrbZZWdr80Ttb/0EIb25+QGq4bWEGFirvdOTImNxC7SQrW407I5RNg==
X-Received: by 2002:a05:600c:4f45:b0:426:5b29:b5c8 with SMTP id 5b1f17b1804b1-429dd25f6camr34903405e9.28.1723713909406;
        Thu, 15 Aug 2024 02:25:09 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded71ef0sm42739315e9.36.2024.08.15.02.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 02:25:08 -0700 (PDT)
Date: Thu, 15 Aug 2024 12:25:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Amol Maheshwari <amahesh@qti.qualcomm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Sukrut Bellary <sukrut.bellary@linux.com>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] misc: fastrpc: Fix double free of 'buf' in error path
Message-ID: <a301b77e-b833-482e-afa1-5306bd8fc8e7@stanley.mountain>
References: <20230602113602.1271695-1-sukrut.bellary@linux.com>
 <168656748193.162074.17313550564907901438.b4-ty@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168656748193.162074.17313550564907901438.b4-ty@linaro.org>

On Mon, Jun 12, 2023 at 11:58:01AM +0100, Srinivas Kandagatla wrote:
> 
> On Fri, 02 Jun 2023 04:36:02 -0700, Sukrut Bellary wrote:
> > smatch warning:
> > drivers/misc/fastrpc.c:1926 fastrpc_req_mmap() error: double free of 'buf'
> > 
> > In fastrpc_req_mmap() error path, the fastrpc buffer is freed in
> > fastrpc_req_munmap_impl() if unmap is successful.
> > 
> > But in the end, there is an unconditional call to fastrpc_buf_free().
> > So the above case triggers the double free of fastrpc buf.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] misc: fastrpc: Fix double free of 'buf' in error path
>       commit: 5b3006fffce89706a12741d7f657869ca2be1640
> 

This patch wasn't actually applied.  I'm not sure what went wrong.

regards,
dan carpenter


