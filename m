Return-Path: <linux-kernel+bounces-514494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1FCA357B2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFDC916CB11
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9AE207669;
	Fri, 14 Feb 2025 07:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KbMGqLFw"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81A11547F2
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739517361; cv=none; b=XsJ0d4+BPN78XJ6FI0rAcDJRSIFhNomt6fUmOzAHzhAs2GF1k6R7q/8vF7ScqKJHLVmLqrtsJwXySRTz4GDlVew6ftrAPJZh7SwvsZLWL9CLkwnOw5AIVv0owkLF03tVq8qjWb+6MJRyKo9cku8OstY9ul5MG1ixZBvPibH9CbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739517361; c=relaxed/simple;
	bh=d85vQEKXzobX9r5qZo9mtj6Cou/uCva0qLJ6RmcWFcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/NyEw+QSUW25pxYbEGH59NCNWv9Nb3K/p5ELbLGGMd4h3tZjn+zaMblfdxh+6g0fUQv0cFDDDgSUsN3X6mppUqn6lmLHoXOBAQUUCmjAYHK+cvDESpfW1XRZfH0oR3294dG5q8+FuoG+8gZkVMB7J4Uh39HXXyHuD6InC9MDBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KbMGqLFw; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f42992f608so2821861a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 23:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739517359; x=1740122159; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i8tciIHtrTxfE7xK87cnn1lbhRKqUoH9Dla36dWV9Zg=;
        b=KbMGqLFwdzi+gTP8GCXcwJ6iRoCGa8o+QnzSVAwcJq9Fh5Gxi70F+GulDOtcGWrToD
         mj0ughrGzB6kKwh+5kC9OSQgmCkWfoR+JRHsOCuw6xmktpl0ZsSNJjMG0RrfKJNwDVO2
         Gikz1zGjnPbKXqT+MRYluqz/8VwLbmb+H/zPyK2drEjMCtYyrzB+xASktSHTLV2ANhJ3
         wrpx1icPS++HRzASlxJri7BzQQrM/YZy+8lBBIq/mhPDabCafdhs57UlHo0WS5vvPuV3
         wZuIWUEAd5DGuu+k1ixM9aGUMTGtq1oMoog1NZ5Uq9vtd+iKyiP1z9e7NRXOxnJnOgMN
         IeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739517359; x=1740122159;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i8tciIHtrTxfE7xK87cnn1lbhRKqUoH9Dla36dWV9Zg=;
        b=vu0M4i9f8ey/wPVKgBF0E/L5rAJ1htunmWc1+6l/6A2kFOikS77NZomUj75UM5rIis
         GjdOWmV4Ds39KfVrh92LiVr3GbNKuE5fODAJPiK5LjA05WMBeoNeOORUotxSWdCZtmjK
         sie39uQTsrN6UP191DF0pgKtW4DjBtQOq+6j49ytue2eDRhUyCOwzhr6BH/e8U+czZaP
         uXF52bn6m/GUrCzvguxhDVudVV4rqg50aBBLEqam4LfM8Bb9SiOEfLMmi8IPSk14Hh/y
         pbDHBtO5/AKpk46veX+sphPkwDjZQta4Ca1FYYkrq0XXzIzDCU1bmodkxFsT0crg9y5x
         fhUA==
X-Forwarded-Encrypted: i=1; AJvYcCXkzeiV++8DGxepZOkrCgs+x6bPXAgHJaIp3OaP8zPpuOxdEcPHdBpk+JGoDFf7seIXw4mQZUuJS40VX4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyTa8bAdUSe7TiedUwUfsJCJuYuefqYYTx3DN7IyFwNtkPIQhj
	fI9eLKDpdcE9WQ9d/3z34OAmR2NStRva7uT2JPJADXMVaadKA1yQ8CuLirbLvA==
X-Gm-Gg: ASbGnct89HshVsIbzS0pCP4rt0ZVem3mmitA6UcZqAGBheOZQBZd3HRUDpYXol3MeMG
	xlNwzCmIP7E3es+Il84btdg3OTAB6FkW1PlPtAvpwY7dTgk45r+hkarGsL0PeHVHfCTDI/EYnGl
	pem1K6AOZynhbOCAM1jk3pXlrK+m/jBllh/5fj55anY4bR9pQNrBtcwiZVpKPgqSs3eDgIvOUU2
	99QdOXBZG524pWmEtnhtisd+qMOabUCYYzQ6+hKBg20hquoFIpvZYbCKpGSlMtGUg0IZ1sPKDUK
	Q+1kyi2hpIhwhI8HWDh/EhNtEkEBmKk=
X-Google-Smtp-Source: AGHT+IFWwENUebCr4voLH+7s7sJwk7o6ApVHXiQcusFpsycULm7vbHAgg//4YnMm7TLwfmgr806IKQ==
X-Received: by 2002:a17:90b:180a:b0:2ee:5bc9:75c7 with SMTP id 98e67ed59e1d1-2fc0dfc7a5emr8983543a91.5.1739517358814;
        Thu, 13 Feb 2025 23:15:58 -0800 (PST)
Received: from thinkpad ([2409:40f4:304f:ad8a:8cb7:72db:3a5e:1287])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53643ddsm23043555ad.70.2025.02.13.23.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 23:15:58 -0800 (PST)
Date: Fri, 14 Feb 2025 12:45:52 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Tsai Sung-Fu <danielsftsai@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@google.com>,
	Andrew Chant <achant@google.com>, Sajid Dalvi <sdalvi@google.com>
Subject: Re: [PATCH] PCI: dwc: Separate MSI out to different controller
Message-ID: <20250214071552.l4fufap6q5latcit@thinkpad>
References: <20250115083215.2781310-1-danielsftsai@google.com>
 <20250127100740.fqvg2bflu4fpqbr5@thinkpad>
 <CAK7fddC6eivmD0-CbK5bbwCUGUKv2m9a75=iL3db=CRZy+A5sg@mail.gmail.com>
 <20250211075654.zxjownqe5guwzdlf@thinkpad>
 <CAK7fddDkQX1aj5ZyTjh1_Pk+XME3AY=m5ouEFRgmLuJjBJytbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7fddDkQX1aj5ZyTjh1_Pk+XME3AY=m5ouEFRgmLuJjBJytbA@mail.gmail.com>

On Tue, Feb 11, 2025 at 04:23:53PM +0800, Tsai Sung-Fu wrote:
> >Because you cannot set affinity for chained MSIs as these MSIs are muxed to
> >another parent interrupt. Since the IRQ affinity is all about changing which CPU
> >gets the IRQ, affinity setting is only possible for the MSI parent.
> 
> So if we can find the MSI parent by making use of chained
> relationships (32 MSI vectors muxed to 1 parent),
> is it possible that we can add that implementation back ?
> We have another patch that would like to add the
> dw_pci_msi_set_affinity feature.
> Would it be a possible try from your perspective ?
> 

This question was brought up plenty of times and the concern from the irqchip
maintainer Marc was that if you change the affinity of the parent when the child
MSI affinity changes, it tends to break the userspace ABI of the parent.

See below links:

https://lore.kernel.org/all/87mtg0i8m8.wl-maz@kernel.org/
https://lore.kernel.org/all/874k0bf7f7.wl-maz@kernel.org/

- Mani

-- 
மணிவண்ணன் சதாசிவம்

