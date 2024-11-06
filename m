Return-Path: <linux-kernel+bounces-398630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF439BF3DC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0BEE1C233AC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F16206506;
	Wed,  6 Nov 2024 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E2wpFy1V"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FF4205129
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730912666; cv=none; b=lf4Vx3sndMkUbbkz7CHAGzn96PdCIm0pP0yiU2prg2Su48AHFbTefo183Olm1Vsq+/EIEqyFLSxNlQbSPZfNsqs3YGNovmE8SafkKiDHFiMZqqk3o8touzMa97o107+8dGD4Rs+ilitNeCu4aqEF7XDFp5o/pUV6hX9VMUVCJu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730912666; c=relaxed/simple;
	bh=IqW57oiCoBaCk36CniFqvizF47SHTBcgPQmGYek9qt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ak52WhCk5s1LHvYkRbXc0+dYFy87QCg0zJ37z40edu3sdeXYnpPbDuSpTOOeZYri90e3St9lc4pp/TELGJPD/IKokiRRN4NPvYNlk+z/fwgjL2yB5PIf66UnFCUP/3NlQQZLubRQBTGqVRl+lfMHMMTw2l8dqtLdwuys2xIArkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E2wpFy1V; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ea9739647bso66320a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 09:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730912664; x=1731517464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rDaQLdznzK7seqYSBe/wCoaA0MUN6ZM7xHd32DKGHh8=;
        b=E2wpFy1V4LcM8Sjf+T9lJHkgp2HZjgkTNCNRFwG9qGmsNMUBBtUNhBb80D0twCHrzx
         bMFYUFq+sO8wZlQpMd0bKECkSAhALJ8iTIJgzTkooIQsSkZvOLNs1hUOFAt220fGk9tS
         yfWCygVv7RshrRCSmfy3KKk8EAzEyRbhuZBMzGPSmVh6Djt5GgUMS7IVSvPDRvxN18yv
         gOsFRCkEV06ZGoJkNYZjArFQyAqJXhgs7SQ8XpfIS0nopGY0cE868Ar7Lo1qZldUsxmq
         OHoQS87UBu56IM/w1wYKDuwWCfv8vD73LQ++DmK6vccFlKZNGiqybV1K2A9X/nk00Am6
         iRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730912664; x=1731517464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDaQLdznzK7seqYSBe/wCoaA0MUN6ZM7xHd32DKGHh8=;
        b=DhAF2Bow2iZfzMZ/1Y7on0+sPdhb0UhtJMlZJG7cL+NSfpR1H6a8IniC96MgmxvvCU
         wEydXaNibnNAu/g99R5waSp5R+6+9Sl4vvfphp/ltSQmziP5u7MOum+jNFCCXroq63Qy
         VaIN2/aStMalieTK2snzr5zz1+S3kvDjBJ8+hLxtMPwJBUmw4S5hjsOBJQw9NAZ555Pw
         siMjSVhWVURgFRBRr/ms1IGJSlZOa6MX0BvV1nB5hO59oSGapJaK+cE8rCP8kOxcNkxb
         e5ETv749lqJRIaxa3yr/IxJXe+o0zonD6SypkkZYZ0aK27r0Sh76WQzTYY5BYoBkZUGN
         tqeA==
X-Forwarded-Encrypted: i=1; AJvYcCV1SDC47kyBBuY0Iylv8THXSpIwhazswxc1zRBpxHXd+6VmhHcuGXaeEA7ASrkQhighj3n5fxbEy3fP0/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUYBWzS72MfBrxuMAPXYSBd72QJ/bcK3wyCCN7iz8kdQDD83Wl
	JeGHAR/+1a55FvOYXkMERf51ELmfrnx1fw2Dn/kj+lE8zcheGtrhZZSq2X3Jbg==
X-Google-Smtp-Source: AGHT+IFTRmyv3jddEWzwMk7l4ToMoo9qEgn6PMk6nfoP7kxnLFshmvLNCipLw+gSEmO7+UOuZw7W7g==
X-Received: by 2002:a05:6a21:3292:b0:1db:f68a:d943 with SMTP id adf61e73a8af0-1dbf68ada69mr7915594637.17.1730912664141;
        Wed, 06 Nov 2024 09:04:24 -0800 (PST)
Received: from google.com (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee452a7ffesm11355388a12.23.2024.11.06.09.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 09:04:23 -0800 (PST)
Date: Wed, 6 Nov 2024 09:04:18 -0800
From: William McVicker <willmcvicker@google.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
	yunkec@chromium.org, hverkuil@xs4all.nl,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, andre.draszik@linaro.org,
	kernel-team@android.com, stable@vger.kernel.org
Subject: Re: [PATCH] media: videobuf2-core: copy vb planes unconditionally
Message-ID: <ZyuhknpDgVLl39zL@google.com>
References: <20241106121802.2939237-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106121802.2939237-1-tudor.ambarus@linaro.org>

Hi Tudor,

On 11/06/2024, Tudor Ambarus wrote:
> Copy the relevant data from userspace to the vb->planes unconditionally
> as it's possible some of the fields may have changed after the buffer
> has been validated.
> 
> Keep the dma_buf_put(planes[plane].dbuf) calls in the first
> `if (!reacquired)` case, in order to be close to the plane validation code
> where the buffers were got in the first place.
> 
> Cc: stable@vger.kernel.org
> Fixes: 95af7c00f35b ("media: videobuf2-core: release all planes first in __prepare_dmabuf()")
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Thanks for sending this fix! I have tested that this fixes the video playback
issues I was seeing on my Pixel 6 device. Feel free to include my

Tested-by: Will McVicker <willmcvicker@google.com>

Thanks!
--Will


