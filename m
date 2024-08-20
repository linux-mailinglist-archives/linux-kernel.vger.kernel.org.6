Return-Path: <linux-kernel+bounces-293296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA79C957D36
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 478B1B21AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AF914A4EA;
	Tue, 20 Aug 2024 06:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SVubNwED"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39531136325
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724133626; cv=none; b=l1oq5Z582nKRPHRg7I6tcl+8PPYOc+fUGACStSyAAaqNEzrVZpXoYhyuLqs5KYePv2ce7Vxt95kXq21WIFNFwovQvZeXP63gXlcES834JREbsc1ltbCeJzKVY3DN1d6xu1T02Ligpk6ZBeMYFbDzUZ9tVj5IZbY3zzwPCfTXwro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724133626; c=relaxed/simple;
	bh=sF3PRRiLeL/D5znM6gXQZ3NeF2qGdjIeuDfpPWTothE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMr6CqTcc2kGEgs005Fs6qLw5ne3dIp+Txur23MnFhVqIMzhiJtHnRbAMlqTlNbgupDeZ/t59LgRU4IiVeAARr+8YXs1/vkBVAZM5QdEzpsxq1VkdvnopN15hFxsQUMlQ2yVkmSLpjoWyn3Xzth7OHyefRaJ1D1ci3+fB3/fzig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SVubNwED; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-713edc53429so1567321b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 23:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724133624; x=1724738424; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lgLMdruNV2huc5fRfMZfd6Ggx0Cp1DwK5971y3VUjeQ=;
        b=SVubNwED69a/mXs1SjT0rjRq1WPUZ0detoMNm4mzDGId+IuW7LsyU2+8mJDHN+9UlA
         +Nx/n7yOYkzbra1aXxdICCB7VeAhcGjs4eiffZ4DMFoY5PfvTxmrwZdxjZJ2ZAOjBDuy
         1xH7H1ATRN1fS8wAPKD8+wPkj6bCyDkmaqGGsazK0s24NwHvvFMlSKBCq8FnYAW36SxP
         7WBW996b0+s+utBRglB49u7IN5L2eTAwYreXxnKJKKlWS/d6byeBo0Gh4vWdQoTwlUcu
         c0Bvmlkv/mSLa7IhS1JwoGUC55GNXa9dbnpoicKz2LFo2vBJ7npsHBTHpi4osoRh5njv
         xO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724133624; x=1724738424;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lgLMdruNV2huc5fRfMZfd6Ggx0Cp1DwK5971y3VUjeQ=;
        b=RnrvUb5mGN8MeJzShgEni+XHit3kto/K+c8j5DIV8nF+sVXsgJaF5uq5ctU2tFx9pk
         xTnzOQkb0ikktBzNZPNViUqyArBCrCXBd8oH+75AvRK+K6CXZ5CHvcQAk7ClZ443of73
         gkqTJfkm1e8TIX9Wd/FgL/GUolG6nnDVj2TdUOTDzUixVfPiD1d17mHhYVD4ueAef8Hx
         VYge56tL9ZhMzoFusg0ZnoeZKXSLbltRMUQFBCmYeJkoouyZ5q8dOK+Lmp0fHrxTOtas
         KjzSnoCpv7PY6iwXc2ESevHl+fu9Wz+PimrEUsU+NcBbjGte6mpOG7dZP721w+27I7ae
         pnBA==
X-Forwarded-Encrypted: i=1; AJvYcCV9v2F66zyC2QdXIkmnQVJmuTTKQP2PlOnUuVMIBpwYOxU2C4jAmAeD1NrOq1FJd42+1w/ZxzCoZ+yFhaO1mSuFRwQWPCG3Pem0/ukY
X-Gm-Message-State: AOJu0YxPR2en/lzkr8LO8gEhUUAx3aBh/zUSbgc79u7oGmDPF68lTDoN
	LWaJZKAx5+CtyKOmuASP4EQWv/fDeSo0/oyXKKuk3wM0RAs+Vr8yOaKpshioFdpWx+zkIf0Wzn8
	=
X-Google-Smtp-Source: AGHT+IGMZLlXvU8CAUAv9DT+q3r5OtQYUBhXTxRSLpbUg/fgZlURHFtLGiA10dUYE7hx79M25yG/rA==
X-Received: by 2002:a05:6a00:928e:b0:706:74b7:9d7d with SMTP id d2e1a72fcca58-713c4f19e9amr15133166b3a.25.1724133624443;
        Mon, 19 Aug 2024 23:00:24 -0700 (PDT)
Received: from thinkpad ([120.60.128.138])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af3c380sm7489929b3a.203.2024.08.19.23.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 23:00:24 -0700 (PDT)
Date: Tue, 20 Aug 2024 11:30:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	lukas@wunner.de, mika.westerberg@linux.intel.com,
	Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v5 3/4] PCI: Decouple D3Hot and D3Cold handling for
 bridges
Message-ID: <20240820060008.jbghpqibbohbemfz@thinkpad>
References: <20240802-pci-bridge-d3-v5-0-2426dd9e8e27@linaro.org>
 <20240802-pci-bridge-d3-v5-3-2426dd9e8e27@linaro.org>
 <2c5dd04f-8ac0-41eb-a11d-cc48c898c8f3@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c5dd04f-8ac0-41eb-a11d-cc48c898c8f3@suse.com>

On Mon, Aug 19, 2024 at 02:44:43PM +0200, Oliver Neukum wrote:
> On 02.08.24 07:55, Manivannan Sadhasivam via B4 Relay wrote:
> 
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -1434,7 +1434,7 @@ void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
> >   	 * reason is that the bridge may have additional methods such as
> >   	 * _DSW that need to be called.
> >   	 */
> > -	if (pci_dev->bridge_d3_allowed)
> > +	if (pci_dev->bridge_d3cold_allowed && pci_dev->bridge_d3hot_allowed)
> 
> Are you sure you want to require both capabilities here?
> 

Wakeup is common for both D3Hot and D3Cold, isn't it?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

