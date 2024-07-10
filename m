Return-Path: <linux-kernel+bounces-247760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5CB92D42A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75745287DC1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC462193467;
	Wed, 10 Jul 2024 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t1RER4hI"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F1822084
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720621482; cv=none; b=AepnQmUPvb9e8YaNr4ALmWwwec6uP0fE3l7hx3KX4Acwp5oaFYafWlapHNIi70QEDOYdNLsXaxEOaHvL2DnVEKerqIgoO0dzntGtJd3MzQHwhqr8WvQKWx4mGOyxWbM2Lvj3ORWAd9ulVgB0IrEwVK7qUa2KRyoqLi8gzP/W1WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720621482; c=relaxed/simple;
	bh=ChF+b4cIyc7fCjOcYOy7UtdhfzOyBsxNJFTkDtUUcUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6DqWMmHThLOoPPVIG0wZiCXfhILSfBh4iNlf2pq3G0HXquoN/ARDCuSXHx5YHCQGD5bITGXNH81ugi1O3Xw/GGK9HvzqZfnOuNs0CkqnF/67OOn9pSpL2bfPm5ec3I8wNLsQLPNgCtqpMf7Kc7HcOQ7diYCHOJTToQDmdDhWbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t1RER4hI; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2eea7e2b073so45043381fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720621478; x=1721226278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5H9IHnb2BfIy5LWjrgIDA3ZNIdnegixuQukc5lGoDAc=;
        b=t1RER4hIHPNenyEfK6vkXD0hfBX7c4efGIBAowhiaQ+eWlwOrCiRNLXau1+jJjbC6U
         io4JozGlW7geMg4P4gicbBwqL+kHHJ+ZkKTATM8okF9kmA1HhcEaGNxvAPD1BrNofOxs
         ORffN4yun7HtNrlCfvAgIWywf6b4ZcwzUDW6HKIjHB5YwrCgH1K0d1KXqLfeKfkHpe/n
         nxHTJDnZ4kNcnEdc4G2xu5C/pzreUbEnpgHuKQAvfHLQ/9dqeasHNdWojPuLtwyT9KwB
         QnAo89nmHJV9BrWTum72DSVqyhX34S1+n5f46k9SG1npzjHANH+s+PclOuyPcLa6jBbL
         IOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720621478; x=1721226278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5H9IHnb2BfIy5LWjrgIDA3ZNIdnegixuQukc5lGoDAc=;
        b=xPqzDOhSDrl9MYQlDicXTBNMDB8L9bebvc8BaZUKxPc8RgyshMLInKZi8d7+5TqSqs
         WzMhTIWq8LbbILJ8KqDM2GyP8PqmuRe+3jqsByE+67xSpne/13eOzki0MCpq0EryWsz3
         kXfej0ScXb2TR+rloNWzSPmcjXyZtJBUldX7zE4Cu1fE/20cuW7evqPbStd40aweZ3rx
         c/H4BapSMigqSr3MBdupJvaLdzfYzWOL1amx+u/c66x3E5Mu7Ct4uyWTSYa8lko2TJtH
         VmcSbllRnWLd/gIGUmRypR5OXE4uCQGXn6Pa+1WfPOdUd9pncw7BmvP/XlowenfCL2YV
         tqrw==
X-Forwarded-Encrypted: i=1; AJvYcCXAwjxEBZRixwvW5KQJ9iI+RglPPlCAiRoFmXf+MGJw+8gdN6ObZoSeYp948u2mT5SW9Wb+cMeeeqiVDweDbtqHoVyp0fQeSPY5VYSw
X-Gm-Message-State: AOJu0YzCioepTwxVcL8FZgcbMsw+85Xi8x7ImvukJ0dHbrryoxcMmzyQ
	6S0vh3Q9/Y6M1MiiGpxt7kMeJHY1nliWNzmbma6w1+07h70LAzMm7Vh2f2cyBzQ=
X-Google-Smtp-Source: AGHT+IE+lvP8VMUstzxL0cIY1jUrmGsR7qKPN8HrdXbM7Juk1xxZxDuuslhOFTVEqHjsa2fzcF7X1A==
X-Received: by 2002:a2e:8805:0:b0:2ec:54ec:1741 with SMTP id 38308e7fff4ca-2eeb30e397emr35473451fa.18.1720621478488;
        Wed, 10 Jul 2024 07:24:38 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2eeb33fff6fsm5140421fa.24.2024.07.10.07.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 07:24:37 -0700 (PDT)
Date: Wed, 10 Jul 2024 17:24:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spmi: pmic-arb: Pass the correct of_node to
 irq_domain_add_tree
Message-ID: <Zo6ZpFDECO_MwGsl@eriador.lumag.spb.ru>
References: <20240522-topic-spmi_multi_master_irqfix-v2-1-7ec92a862b9f@linaro.org>
 <Zk5JWzpc8a9Dyfay@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk5JWzpc8a9Dyfay@linaro.org>

On Wed, May 22, 2024 at 10:36:59PM +0300, Abel Vesa wrote:
> On 24-05-22 20:08:17, Konrad Dybcio wrote:
> > Currently, irqchips for all of the subnodes (which represent a given
> > bus master) point to the parent wrapper node. This is no bueno, as
> > no interrupts arrive, ever (because nothing references that node).
> > 
> > Fix that by passing a reference to the respective master's of_node.
> > 
> > Worth noting, this is a NOP for devices with only a single master
> > described.
> > 
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> You forgot the fixes tag here as well.

Fixes: 02922ccbb330 ("spmi: pmic-arb: Register controller for bus instead of arbiter")
Cc: stable@vger.kernel.org # 6.10
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Let's hope we can get it in 6.11 at least (6.10 would still be better)

> 
> LGTM otherwise.
> 
> Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
> 
> > ---
> > Changes in v2:
> > - Un-delete the missing ampersand
> > - Link to v1: https://lore.kernel.org/r/20240522-topic-spmi_multi_master_irqfix-v1-1-f7098b9c8804@linaro.org
> > ---
> >  drivers/spmi/spmi-pmic-arb.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
> > index 791cdc160c51..e6a4bf3abb1f 100644
> > --- a/drivers/spmi/spmi-pmic-arb.c
> > +++ b/drivers/spmi/spmi-pmic-arb.c
> > @@ -1737,8 +1737,7 @@ static int spmi_pmic_arb_bus_init(struct platform_device *pdev,
> >  
> >  	dev_dbg(&pdev->dev, "adding irq domain for bus %d\n", bus_index);
> >  
> > -	bus->domain = irq_domain_add_tree(dev->of_node,
> > -					  &pmic_arb_irq_domain_ops, bus);
> > +	bus->domain = irq_domain_add_tree(node, &pmic_arb_irq_domain_ops, bus);
> >  	if (!bus->domain) {
> >  		dev_err(&pdev->dev, "unable to create irq_domain\n");
> >  		return -ENOMEM;
> > 
> > ---
> > base-commit: 8314289a8d50a4e05d8ece1ae0445a3b57bb4d3b
> > change-id: 20240522-topic-spmi_multi_master_irqfix-f63ebf47b02c
> > 
> > Best regards,
> > -- 
> > Konrad Dybcio <konrad.dybcio@linaro.org>
> > 

-- 
With best wishes
Dmitry

