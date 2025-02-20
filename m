Return-Path: <linux-kernel+bounces-523120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A95A9A3D23A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12E3018883CD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8901D1E6DC5;
	Thu, 20 Feb 2025 07:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yyDaD7fm"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564541E0B8A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036546; cv=none; b=BqlhHjD47ZFhee+S5Bk8hlbMNjmtOC2RInQUq7ofkhk0vRA05eMmJMTUpQCQiZRkMg+gQdim3fOoRqbRbDiCeGOEV7dJmbp7sY3ZgAq1BddbP+q9olD2rq9DZ3iYv4soPobSVZHkbjK5l9BikpiwwNrhtWvrCauLBcZQjxGOP64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036546; c=relaxed/simple;
	bh=lcJEuk4/4jbH/EZsuKCBZXHlYP+kf+2wyv7GftgY15s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ommgFhq4emP2yE/BPSCrjj2t/5DQ/dcZfXXOjem00LZ3HEjOQQIvVMT71qZ8SD/Q4FA+UMbCJL0j3pvp26AioZf53X6tAMOFlEQIILIH7peCWLXnk7Ee8nsiaYvj+XUvRh+NhG489hq3cLwknEy2Ee7Q4CsrWwtqVh4EGw3rSC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yyDaD7fm; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fcc940bb14so893876a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 23:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740036544; x=1740641344; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4yu+qDcRvEoeT6r4FiW36lSgvTaoNTDkAM5CUwZ27Cw=;
        b=yyDaD7fmXzNWckRgb97LS1cUrq8LOKXF3JpFaEac7TrUM0WIxcQB03lvu0Cinf1FTe
         Dunj/NpqKoGaRfweNGVGRv2Ta5yIoX01cxqGgQftF3iVe/Lka+AN2VOiiTV0i8kfMRVC
         wx81kmVpbMq9EK2MxWTWRT+kvym977ZzoCNizjD1cBYpgVqraTplcmMJKEW7R9zO5+NV
         /2dyyzTnVBrA63lto7O9J0jpCD5szYyoWD7mMUklNlwEE+v6cXawp0dE1xpzamhlf5AT
         dWFwyAfmc7uJW7Wtw1z/rlBhAG+XymsWUr8RdaI0f+zqeYfPFtTC4WH/TJuZxh2BoON1
         dSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740036544; x=1740641344;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4yu+qDcRvEoeT6r4FiW36lSgvTaoNTDkAM5CUwZ27Cw=;
        b=uOMP8PKDL9X3H8EmDvp58wpKPMbdP7d+vccRUdqXAXyQRa9EYSHvnPHM2x2BgTvjxz
         RdwOr8DUjUsILjhiv5JWbPw3waSGzQ2Y/Huv3LUFMl6zFuCPeg3aZbWN5KJRY6ycGXd2
         YRdnFKgi9qX1JapETzwkv6+pB2Ugo+ncZvsfdIwDEiMEclXu2tOUxeRmvq1RCUZJ0nrz
         3Aq6hAIET9PFWrO9YHdoVbFP4w3F+Tkd03sA7a2AAjbVl7wnQrkk2ecuJ75aX+Tt3xGs
         mD6FRPItiRuTRRqWik98Tf1TXwI9sTvMfMbFiXzJ3tKMN4GTYYftGoQnO+RNMa/m9JrD
         exJg==
X-Gm-Message-State: AOJu0Yxbo7FqBzEdtwqfRmNyVsoIqqsjBVhnal/2TwcHKbDrXbYRbWie
	a48yex5nevp8g+barkjneVNk/H+lV1xRfqyRvWE7ZGpEK5jnRSae8WVYVUPmN9S0qheW7K0IdKQ
	=
X-Gm-Gg: ASbGncvSKR9d7Nf4u+FV0SAqzW/XiAYahqCCdl2GKh/XjMvym2x6AZmXSRFJ3MfjX+D
	+vtJ/c78SDJYRoryuhe/jwzI6rOc8UAruvRsjHuosyLNnKXZ+i74J6vUX0OXVq8VuhtuE+KY2qb
	YQbCalkBEZuwUZ0qGTQOZvF8oPYgdXgkz5v+zEdGSr5D4MJ+lcM9yPwL8ICxjCXadEkVYz2nG+8
	ln5GxeO54RyKVzmdLnjFOPG/KuVQ/ImMik67ieNjSnZZsYCZa7uNvvfnIXLuIag9Rwc4PDaO4JC
	EN331j9Lasrzt48j4Wr7Iz9BzA==
X-Google-Smtp-Source: AGHT+IHvmbBcZQlr4RFuCX85MgT+QPvX5l2kk9oHva1NwUqERRlLBYOJkBXqNriLrgMsjKVq98nKgQ==
X-Received: by 2002:a17:90b:2e4f:b0:2ee:dd79:e046 with SMTP id 98e67ed59e1d1-2fcd0c7328amr2568747a91.13.1740036544577;
        Wed, 19 Feb 2025 23:29:04 -0800 (PST)
Received: from thinkpad ([120.60.70.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98f4fffsm14827588a91.24.2025.02.19.23.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 23:29:04 -0800 (PST)
Date: Thu, 20 Feb 2025 12:58:58 +0530
From: 'Manivannan Sadhasivam' <manivannan.sadhasivam@linaro.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@Huawei.com, fan.ni@samsung.com,
	nifan.cxl@gmail.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, cassel@kernel.org, 18255117159@163.com,
	quic_nitegupt@quicinc.com, quic_krichai@quicinc.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v6 1/4] PCI: dwc: Add support for vendor specific
 capability search
Message-ID: <20250220072858.cxjanfdau6hvzdil@thinkpad>
References: <20250214105007.97582-1-shradha.t@samsung.com>
 <CGME20250214105337epcas5p3a385fdb0bd03c3887df5c31037f47889@epcas5p3.samsung.com>
 <20250214105007.97582-2-shradha.t@samsung.com>
 <20250218144126.5kapvjj4e64bamvi@thinkpad>
 <02de01db835e$b94171c0$2bc45540$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02de01db835e$b94171c0$2bc45540$@samsung.com>

On Thu, Feb 20, 2025 at 11:44:36AM +0530, Shradha Todi wrote:
> 
> 
> > -----Original Message-----
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Sent: 18 February 2025 20:11
> > To: Shradha Todi <shradha.t@samsung.com>
> > Cc: linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org; lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> > bhelgaas@google.com; jingoohan1@gmail.com; Jonathan.Cameron@Huawei.com; fan.ni@samsung.com; nifan.cxl@gmail.com;
> > a.manzanares@samsung.com; pankaj.dubey@samsung.com; cassel@kernel.org; 18255117159@163.com;
> > quic_nitegupt@quicinc.com; quic_krichai@quicinc.com; gost.dev@samsung.com
> > Subject: Re: [PATCH v6 1/4] PCI: dwc: Add support for vendor specific capability search
> > 
> > On Fri, Feb 14, 2025 at 04:20:04PM +0530, Shradha Todi wrote:
> > > Add vendor specific extended configuration space capability search API
> > > using struct dw_pcie pointer for DW controllers.
> > >
> > > Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> > 
> > I took this patch and modified to pass the 'struct dwc_pcie_vsec_id' to the API to simplify the callers:
> > https://lore.kernel.org/linux-pci/20250218-pcie-qcom-ptm-v1-2-16d7e480d73e@linaro.org
> > 
> > - Mani
> > 
> 
> I saw the series. I'm okay to move that to a common header file to avoid duplication but I feel that this movement will
> cause my patch to become dependent on your PTM series. Since that series in still in v1 stage and mine is already in v6,
> I feel the debugfs patchset will get further delayed. If you are okay, I could take in the changes as part of v7 after waiting
> for some more reviews. Or, the debugfs patches could be reviewed as it is, and the changes or movement could go on top
> of that?
> 

You can take my first 2 patches. I'll post my v2 on top of your next version.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

