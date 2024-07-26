Return-Path: <linux-kernel+bounces-263470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B804593D68B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDF8C1C2321F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EBE17C7B4;
	Fri, 26 Jul 2024 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ve+2u2d6"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A6B1F95A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722009933; cv=none; b=nv6+pdDs06vpSVcGTZG97ibdZAZexYhscVZJh5KsC1yxRpjoeZPb86rrw2ADLK8hrt22rGlJYStCrPKKjLkfHM3+ke9RwO1SQBS1LVxP0rNlOYgUHuJx8HnWvZW5IBQimSzaGLCIlPj7mTVFEdzZeU45KMyXgm0pWzqfXOSrOlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722009933; c=relaxed/simple;
	bh=2MbdNmKtwPeqOyRsREhggpkzEEHLVnh/W/q0rkLYlPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUtsphVF1GJzqnybV1/cCQZjdNcXh4aQakdpL1KQlWNbHNHFvMpKWNru2pOaO16UC3Nl/vj/bjd3uCsVMrKEHRhb5zPVD8SytXCYkunXJLOQD+w74IJ/wErwNiZ4x41jJRry/aF+EtPGfFdqigivr517MBZXzDjbmRoCrLRY0eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ve+2u2d6; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5d5c2ac3410so578532eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722009930; x=1722614730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HvVt5nqDEIRc2f/L7PJ1Rm2eKJYsGEP/DbZbM7/vcvE=;
        b=ve+2u2d6gcaL/i8BhvXGLQRhi107PXS11TSYozAnn2c1bNNhMHkjP+M1jE1mhettX7
         CUeuyRDTtSF2FQWVRuhCUOv1VdQI0va1ZGuZAqjkW0UOywBJt2X4QlrAKUkQP6yACMjD
         QH+vYMB+9zr8jIwbgtQSa7bsv1qsepS0Ch9LHlkf4qQDzOtejyOiXNyb8MsAr0rYOYdq
         7yDvybniYImv++1x1KJPov3J8xhvtj4HaSDtvSCq+6iG0EDtcLIUZWNgC9TWWoxpSryl
         VBs2/oKTSkPLFR+98a6Up8jKLcpJXJ/+QPsyEXtNPzzuUqXan+/Oij7fIPK2TJp9au9X
         qamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722009930; x=1722614730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvVt5nqDEIRc2f/L7PJ1Rm2eKJYsGEP/DbZbM7/vcvE=;
        b=BP4Agi1Ly09A52KHPEjNEufnWo5ZIgn+S0UAJ5HCL5aQhMgfDVKjAfvD97FISRMr22
         Aa+BSipgVQNiPg+9p1tLSyYWNNo5DILzUzFPkIanUjaF3a0mhBk8I29k9Xyww506zypk
         +WeIUYguyT1HK3VT0Qae4G8UxID3D8490PSpr3H/NyP0oHGHarvaIY6HLgX9s776GDfm
         3a52HcnRC6r1HKcboITmEEkEiDRQMALTMN2XOfAmwpv4QnoDcflKJUolD2ac1fNAksq7
         ZRJzvxKvzvLBXVZj3TyE/RN4SXN+30U96Xq9m4s4pH9+LppLEvae7gIbOXpOkgyww8Uw
         ykCA==
X-Forwarded-Encrypted: i=1; AJvYcCVokj83yGt3Ar7MAn2oebnmQrFuwsU8ZU+9A0QpiLVBMHauZNuSnRHL9DUX0KMv552evhXzU5iv5ezI/2gUmXl6gPOd51s5+vGn7IOU
X-Gm-Message-State: AOJu0YylN16UMCzV4qvs6z/WC572L69mC8qF+z2xxOq3vCTpNAGJDHvu
	ebt2SbOFr+086s08f5Qz6Txzx1bkdY3gv2OL/uAC0kPFhq5JNKFBCZpRXOePnPM=
X-Google-Smtp-Source: AGHT+IHMViRYg+LFHUT03Gbqr2PM6XGJAYoYIxG9GIgcChTJ6CaHiGtRIicZYyM4DJVQU0Eicwe+lw==
X-Received: by 2002:a05:6820:2292:b0:5d5:6733:ca74 with SMTP id 006d021491bc7-5d5d0d99472mr50338eaf.2.1722009929830;
        Fri, 26 Jul 2024 09:05:29 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:928f:fdbe:c604:7b3f])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5d5b346e0c3sm436523eaf.3.2024.07.26.09.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 09:05:29 -0700 (PDT)
Date: Fri, 26 Jul 2024 11:05:27 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
	gregkh@linuxfoundation.org, sakari.ailus@linux.intel.com,
	hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: media: omap4iss: add check for
 media_pad_remote_pad_first
Message-ID: <f61bbcf4-ca29-44c7-bd27-3261781a1a91@suswa.mountain>
References: <20240726072814.3534601-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726072814.3534601-1-nichen@iscas.ac.cn>

On Fri, Jul 26, 2024 at 03:28:14PM +0800, Chen Ni wrote:
> Add check for the return value of media_pad_remote_pad_first() and
> return the error if it fails in order to avoid NULL pointer dereference.
> 
> Fixes: b2e44430b634 ("media: mc-entity: Rename media_entity_remote_pad() to media_pad_remote_pad_first()")

That Fixes tag isn't correct.  The patch just renamed the function.

When I look at that patch, the isp_pipeline_is_last() function doesn't
check for NULL either.  Why is that one different?

regards,
dan carpenter


