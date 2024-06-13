Return-Path: <linux-kernel+bounces-213914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93217907C85
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16B61B269A1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A658C14F10B;
	Thu, 13 Jun 2024 19:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GWpdvu2d"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DABA14BF92
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 19:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718306522; cv=none; b=Xt8r/JOURUeXlA9YgfbXdFxRRZ4RhNBO3dPAyQ62sN+EkESgYl9I5Q1E3HnflPYw33Y6jPN80oY9Wqfg6js/NV/RsaDSpPborcYtvCcRju/XqbaVGqUGNjpnYS9O+7D3oPlWVDrKlR1ElQDWUAlUA2aJSzHwgNjCVpkHSJ1u4yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718306522; c=relaxed/simple;
	bh=DtpVjB5sWQlCVYIqC72LrS433BYoesAm2RPCyqhlDqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2s9rtJ4cMFbkzZXj0tfQcnytBw5aWoV0eCmEQO1ynoxfvM4/RBDnNUd+n3t6hhQll3dTd8XHfEZyyvlzFqMixxxMgcnvJ1tixfJbhLPCcGky3YQLW0RkvP/43+OuKOPPTdMf9tvBQLFjm8qdBCc+x4o49u4PDPWFLctmmb1GiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GWpdvu2d; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42172ed3487so11039985e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718306518; x=1718911318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n7FkFcl3NcUnPjJ/3i8zWPfRNnb33v+XbwikQNsK1NA=;
        b=GWpdvu2dLDUgacvbCz9MR74DHXp373fA2TA6K6drvCMyedFQI1fWvlDd3A1S+n6Mlz
         zj5TrsJzg4uNQzkZvfzTVEZB2UPrFa9m6pwJclK+tJ4kbajcS02gZgrpHWOGEVKFm+26
         Jehz29RQoV/hIGSvYXOEKqtF0/wA3g8XCn0vdAsJ3aSGig9WhSHN4/UmDS5COp2yc/nZ
         KwrjdqntGKx4KZ7SuWP/U/PTeyKtRhz9QzgDQarqUqWEcFMTq6WuEKiGKPN1jr+QRQI3
         X8C2yOW9Q52A4C+ZK8UWmHq+LbunqA9uMcXS0+m3eTBsE2qGEB7wgP8cZVnMAK4KAhiX
         hE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718306518; x=1718911318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7FkFcl3NcUnPjJ/3i8zWPfRNnb33v+XbwikQNsK1NA=;
        b=rjjpnjhw/Ozt5w3o/BAKacihIcClRt3i/HMhpSMpGbZtZOoCIzC3KuSSUE/vuq8qfi
         hWfKPq231cl9rD9Wyasa4J1PiiIH4CAatDtV4IWXecEp3FdJWKWDhylXPoWatiBPtTLl
         MHtLPiKLjBypcRsSGOd3ObAyVf6PCy4RziXPeAOzBZwXhXEjDNNhcH5SIeDysbVJe9S4
         pgfPXP7pCus2qurwyZFGNLFsIEoKNVxns+ocNKkLW56YM1Ff59Ph1qATPZuDGvHkHWkp
         eQz9Rlm24w431A4kI51Jhz21qa6Rg1t/3RA3BQIJjNlluEwVWnrQkLhJgacn4aFiz8x+
         X68A==
X-Forwarded-Encrypted: i=1; AJvYcCWXS+6XzOigBBKTjW5ASFZ14RcftdnlFdItMyhIlnRd4qPtC33dOdO0ktg2qQ79LF2h8GUVzOIFU3hB0lU0lZlpMnaMT5naaDjQzGm9
X-Gm-Message-State: AOJu0YxTJdzGqoiAHM0G3dIZDVwOeTfO6M6l/Z+mEZtfyHwi/myej0jB
	BK7gI+NNKRQD2AGpDAUp0tu+KJ3Pki6SUqYYgjQH+sXdHdyYCRoyb7po7KDsqrG7+duRqp6lfz3
	z
X-Google-Smtp-Source: AGHT+IGX6SQaOm6gsbMfRyp/T0mtjG1ZhlSQ10k4BzkF3I/QyjnCIlOiS+4+o4+r50rTnJ/QZr1CdA==
X-Received: by 2002:a05:600c:2d8c:b0:422:140:f440 with SMTP id 5b1f17b1804b1-4230484adc9mr6269195e9.36.1718306517743;
        Thu, 13 Jun 2024 12:21:57 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f602e802sm34335595e9.11.2024.06.13.12.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 12:21:57 -0700 (PDT)
Date: Thu, 13 Jun 2024 22:21:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: Teddy Engel <engel.teddy@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] staging: rtl8192e: Cleanup multiple issues
Message-ID: <c0f2bca8-a7e6-4874-b5fc-98911a7c09d8@moroto.mountain>
References: <cover.1718291024.git.engel.teddy@gmail.com>
 <ee01dbd2-fe83-46cf-9ceb-279a06ce9aad@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee01dbd2-fe83-46cf-9ceb-279a06ce9aad@gmail.com>

On Thu, Jun 13, 2024 at 09:05:03PM +0200, Philipp Hortmann wrote:
> On 6/13/24 17:16, Teddy Engel wrote:
> > Remove some unused constants, macros, and structs.
> > Capitalize a constant.
> > 
> > No specific patch order required.
> > 
> > Teddy Engel (6):
> >    staging: rtl8192e: Remove unused constant IC_VersionCut_E
> >    staging: rtl8192e: Remove unused struct phy_ofdm_rx_status_rxsc
> >    staging: rtl8192e: Remove unused constant WA_IOT_TH_VAL
> >    staging: rtl8192e: Capitalize constant RegC38_TH
> >    staging: rtl8192e: Remove unused macro dm_tx_bb_gain_idx_to_amplify
> >    staging: rtl8192e: Remove unnecessary pre-declaration of struct
> >      net_device
> > 
> >   drivers/staging/rtl8192e/rtl8192e/r8190P_def.h | 8 --------
> >   drivers/staging/rtl8192e/rtl8192e/rtl_cam.h    | 1 -
> >   drivers/staging/rtl8192e/rtl8192e/rtl_dm.c     | 4 ++--
> >   drivers/staging/rtl8192e/rtl8192e/rtl_dm.h     | 6 +-----
> >   drivers/staging/rtl8192e/rtl8192e/rtl_pci.h    | 1 -
> >   5 files changed, 3 insertions(+), 17 deletions(-)
> > 
> 
> 
> Hi Teddy,
> 
> please combine patch 1 and 3 (Remove unused constant ...) . You can change
> more than one item in a patch. But it has to be of the same kind.
> 

Could you combine that with the earlier patch that deleted
IC_VersionCut_C as well?  (Unless that has already been merged).

regards,
dan carpenter


