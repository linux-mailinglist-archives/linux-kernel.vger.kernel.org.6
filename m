Return-Path: <linux-kernel+bounces-521752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0832FA3C1D5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41A318944EF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE6C1EFFA5;
	Wed, 19 Feb 2025 14:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xq+AeVod"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8A81C3C00
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739974477; cv=none; b=Eg2cP6TvclUL7lGrTbOGvaRbUgLbifVGGTxuCpObCAMI1pIIQOalPm6rEc2j8EoJTTZxc9xd2hEc7dLIHpKttbxvBi++MPuLVkHuab1V9vuWxnHIgEPtkZzBLizTMsT5Xik7p/5TFiAPoXVcRYhb+AVhzgGbOdDKkvuSB9XhQvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739974477; c=relaxed/simple;
	bh=XL/FuYGImCvBKeDZ5q7HHmrFeYjloKD4TxJcQv2X7dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7fbl7QK1sr3gDjVvHY4R/pjsV/ll0lStXIMSTrYbzbifZy4XIzyQhGM3lD70JNKp6hW4VYEI/U7GrXtQ5mxu+2GA7z6MUBbNaezlibOT7+uQk2MRHgGkz7BRbw2+dq3zgi2qqU5YrO7WJCTipmVEI2nnSNz6z5PMn0RJS4804I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xq+AeVod; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2211acda7f6so81789665ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 06:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739974475; x=1740579275; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k2HtorTRfJCn5gYcOpWXXoqPoc/mFZAbh86mTY6fdYA=;
        b=xq+AeVodkDfqETC9Aotc8cT7ekjktpBVL8857scDXYMFgszvpBf1UWSmk+/urmhSZo
         EhD9xRSfW6YbSkTynaVjFC6yDGFl/RhJCXahLCIy6GWPHXJ43z8D550lcQ5rBDJBKsa2
         dlLkAlfw1dCDne+FnmFjb86SMFb3Y2E75K8ugu8b7ObxWGgiZfeGBBtsXLkBLt6SG5DQ
         LcZFifNj0ocPquO+GzARodHjjekm25w3Ow9OfnkWVKkfarDUJNNnx+UjXov5OJpZEZPl
         nAcoH3lycgN9riK2zuqiQJyOHIjSKZuz6OoyIwsoTPh83KfnigOrLIT4d9bAqweePXCL
         JSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739974475; x=1740579275;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k2HtorTRfJCn5gYcOpWXXoqPoc/mFZAbh86mTY6fdYA=;
        b=dn2NGnz3zFjlCMHkiABPCQhitEOLLnMuNEBdF0Zrf5Hakk5ECw0gVE2PEIxWBnkvEW
         ZKNLwzAoMneD9NpfteRru15xOZXvyWfJtTD7dBDkQY0V0YX9+ymvhhniWLZlybYvNOfw
         WJnQ2b3+8A2p2bGLRas+e8h3h/bEmNlE+yI7dlt6FYNNuhPm3TTI7UaTSCkYnx4mslOe
         mZD33GBzS4z4I3fRIPsF0FLSIdaWkfN+G+tv21n1qtIClWX4MxEWS+Y79sUreTIU4p68
         pHmJusQJSJf6JEblJpBi9jDGoZ01y1apWTwyCvel5nOyq7PRZaHfrFwrLVQndRjjqlYN
         HXaA==
X-Forwarded-Encrypted: i=1; AJvYcCWvDVcHqLPImNYYboYAvapoiCxA4T/WCYrXf7tDgKrlpwfuEoldZvtWrQjhzAsj/BdaA5E3undID3HZzUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDtEv+okbY223GrD95HZlIL0WO6oa9oxIPYDte2hfPcqNxlj+D
	/OS2TANXbeoZKwzZWhmbHkgMcDQrA6FmI5lD/9VSaYIbIrYBBOyCZwoxj8G/vxBIqOOpPb2cESo
	=
X-Gm-Gg: ASbGncvO02RckdlkG/y2+7wvu0eE5yeQD6UOT/+HuLiYebXJ7a2oSIBEW/eZNkwWxkT
	3BQq6mEWInezDDn91uoNgzsE0DxDLWnoIdMZiBEOtcZIuac2k7qC01D1EwFhLQHrgUiCF5AXIdK
	AKyVz+fbb76Cuny92cTh7kZMrO3/z5tLXK2H0wLT00vEgKvzDGpMjjJntP2ePXjjoZQTClYyKq+
	5k5QKUFKwsjjwebf/XBItZdwYAjiJfanVMSKcgQZAZsBbCS92QIRveojI6liM4glfirnyqepQGO
	88b34OYlxxBrGk8uURizKfR6bA==
X-Google-Smtp-Source: AGHT+IEeDEo2ltT751dR/sJKjSakroaM7te99A5gVKkjsKbIG+a1YUgHPEJvPjfTlYxMDg3qEDsA9g==
X-Received: by 2002:a17:902:dac2:b0:220:ec62:7dc8 with SMTP id d9443c01a7336-2217065a24emr52285695ad.2.1739974473812;
        Wed, 19 Feb 2025 06:14:33 -0800 (PST)
Received: from thinkpad ([120.60.141.99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349024sm106270075ad.8.2025.02.19.06.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 06:14:33 -0800 (PST)
Date: Wed, 19 Feb 2025 19:44:28 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: mhi@lists.linux.dev, Loic Poulain <loic.poulain@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] bus: mhi: host: pci_generic: Use
 pci_try_reset_function() to avoid deadlock
Message-ID: <20250219141428.oiqgf5b2rg3aukvw@thinkpad>
References: <20250108-mhi_recovery_fix-v1-0-a0a00a17da46@linaro.org>
 <20250108-mhi_recovery_fix-v1-1-a0a00a17da46@linaro.org>
 <Z5EKrbXMTK9WBsbq@hovoldconsulting.com>
 <20250219131324.ohfrkuj32fifkmkt@thinkpad>
 <Z7XiKBD63EE7ZzNr@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7XiKBD63EE7ZzNr@hovoldconsulting.com>

On Wed, Feb 19, 2025 at 02:52:40PM +0100, Johan Hovold wrote:
> On Wed, Feb 19, 2025 at 06:43:24PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Jan 22, 2025 at 04:11:41PM +0100, Johan Hovold wrote:
> 
> > > I can confirm that this patch (alone) fixes the deadlock on shutdown
> > > and suspend as expected, but it does leave the system state that blocks
> > > further suspend (this is with patches that tear down the PCI link).
> 
> > > > Cc: stable@vger.kernel.org # 5.12
> > > > Reported-by: Johan Hovold <johan@kernel.org>
> > > > Closes: https://lore.kernel.org/mhi/Z1me8iaK7cwgjL92@hovoldconsulting.com
> 
> > > > Fixes: 7389337f0a78 ("mhi: pci_generic: Add suspend/resume/recovery procedure")
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> > Makes sense. Added the errno to the log and applied to patch to mhi/next with
> > your tags. Thanks a lot!
> 
> Since this fixes a severe issue that hangs the machine on suspend and
> shutdown, please try to get this fixed already in 6.14-rc.
> 

I usually send fixes PR for bugs introduced in the current cycle. But yeah,
since this is a blocker, I will push it to current rcS.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

