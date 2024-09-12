Return-Path: <linux-kernel+bounces-327022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7D6976FED
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B31AE2829AC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7259C1BF80F;
	Thu, 12 Sep 2024 18:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Aq/LBPqP"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF4F1B4C26
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 18:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726164226; cv=none; b=G8A6CVEo+J3E07ZEhITd931eypYDE1F8A7a0V2xQHN8aVCH4z+6L0WKdflDHMg25Vlxuh+/XYWz6SRrmbKBW//x/TntW5ZkpVP/geRdAy5v1yH7EwFHtJEsNCV8ijQfdIznh1iK/50s4pvmRm3xoMWgQolA0bQBWqeQp6siACmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726164226; c=relaxed/simple;
	bh=K9bHNXidNq1NONjRV3KqfvBuioQWkPY4XuRvNYCCu+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDfjMWKKSsP9+OFi3hvO9vFdGJF/KF+L+ZTcW/V04UmWVxVQIvRFMbG2fORkKm/sWzhBLH0Vm/dv2eW0xRgMgSFKGMHtRnbLsMYOU+Dvaw+MdoTtjMpTwQ4/A67HXZCCbb3/eR8geGarVjB3HmZ51xANWGmK/4MzKJlJyV7AI1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Aq/LBPqP; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f74e468baeso1748081fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 11:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1726164223; x=1726769023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mv9p3quoHSsHUIbL7kx+Hg9JdnYpsM4+W5Q4SWHht7k=;
        b=Aq/LBPqPqwSwTtXmXH4ycohnbySVMjyOC0V3KrneLHH0XDN7l5u3u2UFnnA3xMHl6H
         EXMV+Y3JrPccogepbohYDDYc2oAiuhCw2LqdpFvXek2HErffqNENBEpvPhhic1FabG9K
         mcav3JMtyzdNhk5rg52cHBKzpTwK89qRxn1+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726164223; x=1726769023;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mv9p3quoHSsHUIbL7kx+Hg9JdnYpsM4+W5Q4SWHht7k=;
        b=ud6rxEsr/06poFOTp2zwE3fLEU/L5VupZoY5bhBXaoMF8dUmEQnc/QIM/ruGCelKIO
         mEcPWQnB3g5Hvmd0vEsCMxXXmEX45Z7EMWNEMK1y5kbVttMAhPI0q2f6hS/w/xJldceN
         LmzBNnDoGlUsNrAz0bF1DU1ypWbOoUesFxfeqdlf25XAT0QFDBN96oeWQjenZ6C5THN/
         c86UvlSlEics2GWfpRYnLVbTU4x7FI/TBdTiBd1IFxmPlEONfqb3svYEK1Y5Y+rapT8f
         vhsS+5+90Fvk+bpnF23QyAx+qrHdo9+jJxDuazKSgcdLEzjfToYjUWWFyd2FWxzu6Q8b
         48kg==
X-Forwarded-Encrypted: i=1; AJvYcCVHpYgWSXWIwXX4QK2+CstZGDCLisZjYK8qxHo08ypIl7Dgfr/MpDZ0PAaVU2XrswVeRvL4Euss4f2662Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFCymkrRH7JyYMS4n5SM272i5g08FUOlnj9bOLutQ3d/6tenuz
	5kb9S85j1/Gt19KJO3s2wTOaGNnJaqQJ1wITgw/0KDb3CFI+v8VtDywI489eh8k=
X-Google-Smtp-Source: AGHT+IGutxN0EFHWMjO/BNwOFXuVUe1ZaE+f32VgpdmDZHWKMPFXtSdvr1s4Lp4H00pwKJtMkdD0bQ==
X-Received: by 2002:a2e:1312:0:b0:2f5:1ec5:f4fb with SMTP id 38308e7fff4ca-2f79190619amr922161fa.13.1726164222726;
        Thu, 12 Sep 2024 11:03:42 -0700 (PDT)
Received: from LQ3V64L9R2.homenet.telecomitalia.it (host-79-23-194-51.retail.telecomitalia.it. [79.23.194.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd76efbsm6823344a12.67.2024.09.12.11.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 11:03:42 -0700 (PDT)
Date: Thu, 12 Sep 2024 20:03:40 +0200
From: Joe Damato <jdamato@fastly.com>
To: Brett Creeley <brett.creeley@amd.com>
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
	davem@davemloft.net, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] fbnic: Set napi irq value after calling
 netif_napi_add
Message-ID: <ZuMs_BXeLYX0_RiZ@LQ3V64L9R2.homenet.telecomitalia.it>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Brett Creeley <brett.creeley@amd.com>, alexanderduyck@fb.com,
	kuba@kernel.org, kernel-team@meta.com, davem@davemloft.net,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240912174922.10550-1-brett.creeley@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912174922.10550-1-brett.creeley@amd.com>

On Thu, Sep 12, 2024 at 10:49:22AM -0700, Brett Creeley wrote:
> The driver calls netif_napi_set_irq() and then calls netif_napi_add(),
> which calls netif_napi_add_weight(). At the end of
> netif_napi_add_weight() is a call to netif_napi_set_irq(napi, -1), which
> clears the previously set napi->irq value. Fix this by calling
> netif_napi_set_irq() after calling netif_napi_add().
> 
> This was found when reviewing another patch and I have no way to test
> this, but the fix seemed relatively straight forward.
> 
> Cc: stable@vger.kernel.org
> Fixes: bc6107771bb4 ("eth: fbnic: Allocate a netdevice and napi vectors with queues")
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>

I agree with your analysis, but I'm not sure if this needs to be
backported to other kernels because:
  - It is not a device that is easily available (currently),
  - The bug is relatively minor

I'm not a maintainer so I'll let those folks decide if this should
be a net-next thing to reduce load on the stable folks.

In any case:

Reviewed-by: Joe Damato <jdamato@fastly.com>

