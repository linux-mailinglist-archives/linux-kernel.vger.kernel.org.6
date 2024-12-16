Return-Path: <linux-kernel+bounces-446896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CB09F2AB1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC26D1881CE8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 07:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140151CEADD;
	Mon, 16 Dec 2024 07:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W8a1cwRe"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8731CCB4A
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 07:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734332770; cv=none; b=cSmR2vLBS9qBdqnQcNWX5dM/FeS0V0qLpTHXrMLZwPC00zBYAu/hFnRMr+KkeaZpnrVjIeCqrrd2YgyoHpob+5Q/9vvNP45PQjFglD3abj1jARnWNia18Lqw/9X/FNc6ep/6GerJwbAJYm0WJrV9iVYp4TZrmrIjHDPkSZ8dpjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734332770; c=relaxed/simple;
	bh=I238hIWx+Cz/FYS1dqqAD1UvSMg2hrKOWPzfKgLdgzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdxRF/h7YGbxxhL4qko+Lq9S6Gyl9Q2yMFZzbN02q0ee7YEgu7VN1HzfZmF6tRE89EPm1l2/bCbVs3OePAL8lxkSt6rP86IZua1cuYB78wh4lxvjFp8EZC1Teu1nNsIWaBO2xuLqu4wWNFHRw68rSw/qP9h+qa3i40dsBj63kDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W8a1cwRe; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-216395e151bso23782755ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 23:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734332768; x=1734937568; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ziUY36k0W7WB4ux5sJzImTve/z2GKofoJlBRVwKWqug=;
        b=W8a1cwReF3qGOL4xtCqxo8jmsIYarB4qqNJ/V+0dlpy5C4WbszUPEEg9qmvuLvHH95
         1Vy+j+PmQc2ABj/K7N9XmmWjAsEQMLNxnaX8IZ0CUEgFJQ2L+KQ+4rhz6AZK/3uPnwaq
         Ce1jwTduKGXbhf75oQtLYsT56+ADeA/wPsvEjIbMRLKT5gTWVByPA9GkUlLonJ9GErmN
         VljnxRzfzdifaKvvsPQswuc9spy9uxHtFY2siapjqYb0EyxZnOB3HU3w9r/nKEWoUAF/
         6FSeBAMvixfNY5JP8gRnMOar3iUoisA4CFvuqsgiSZa59ffAXDaKdlo7y+dsaPG3mr01
         ioTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734332768; x=1734937568;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ziUY36k0W7WB4ux5sJzImTve/z2GKofoJlBRVwKWqug=;
        b=GSrC/cOKjo8yLbIwGpTb4MvY5OqFpYs9lFX/bbm9zQhA00jZRpim6It5bWL04rSnzc
         02ea/cfWzGD5RkgWRnTpwq/UB0c48zcL0w+8eiGC0A8zunmib4WtAkuViM7Kn4YblA9M
         q2fynjeKWdrxgXkFk/7MdLRLBtHx7RbijwzSw/8UEl6HdOiLpR2A9wkn0XF4TC8VgyGC
         HYATWP4w+aL8Pvkhs08Be+jRkP4t5xvyIqoIohk7yZUZenRy8g0kl2DY873Ge4BDPcDt
         T+wPgTb5tXdr+U094PE1/N/RQZuQuzFqzcDaMn4lXZvP+jYNhR4PiQJoZFLoBA3ZkF+5
         VtwA==
X-Forwarded-Encrypted: i=1; AJvYcCVAy1AeZtcEXSDk7xpx5T/p5DjrA77/Z2rNBg+nlD8OdlMQ72sMaSAnBCfiVkntDnGNdLJFfN6JAqFzDR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhdA80r3qvy1Hppt31keNAudTYVugySIJQtmZQYIhztsZo8gJA
	yYSS4iDUPpEu43CPW/qCKZ3D8NQZJ4RTVY1b2ASGyCqMqnrLe/6IAkr6+CMlgA==
X-Gm-Gg: ASbGncsYctM4aRD8EyC+RBaDUhKS6QEYGqYe4tJqcLsrFHvpl7uSUQxkyD3NbCYA1vS
	zqhwIxYr5B5VcaLPOd+F+hESfIsFaeNi+xPDeEac5dN97CetlgnQXYY/XbftFEmf87P3/gsTUdk
	gDLB19XUAStab5p6WfXYQkgOtkX82xCChJvxwoNW2kIBtmHTKmGiFrMYAezT8WetJdZjMujCZjM
	mI4NikrLMi7PtH3OqWOA1jNoA+Y6XCOorAypMHmPkEF/WiWOOz9VGp8k8f5pJAzZvo=
X-Google-Smtp-Source: AGHT+IEfZZiyHGK/1Nx+GCELiO0Jo8KYv56K/wIilz36vVZ/8tAo3OmYY9U/N6lMaVPZU9l74zQh9Q==
X-Received: by 2002:a17:903:230b:b0:216:3e87:ca00 with SMTP id d9443c01a7336-2178c893460mr217810835ad.28.1734332768003;
        Sun, 15 Dec 2024 23:06:08 -0800 (PST)
Received: from thinkpad ([120.60.56.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e64034sm36057015ad.231.2024.12.15.23.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 23:06:07 -0800 (PST)
Date: Mon, 16 Dec 2024 12:35:54 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFT PATCH] Revert "power: sequencing: request the WLAN enable
 GPIO as-is"
Message-ID: <20241216070554.ym54ozdw45zhveo7@thinkpad>
References: <20241203141251.11735-1-brgl@bgdev.pl>
 <Z1x6ti2KaMdKS1Hn@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1x6ti2KaMdKS1Hn@linaro.org>

On Fri, Dec 13, 2024 at 07:19:34PM +0100, Stephan Gerhold wrote:
> On Tue, Dec 03, 2024 at 03:12:51PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > 
> > This reverts commit a9aaf1ff88a8cb99a1335c9eb76de637f0cf8c10.
> > 
> > With the changes recently merged into the PCI/pwrctrl/ we now have
> > correct ordering between the pwrseq provider and the PCI-pwrctrl
> > consumers. With that, the pwrseq WCN driver no longer needs to leave the
> > GPIO state as-is and we can remove the workaround.
> > 
> 
> Should probably revert commit d8b762070c3f ("power: sequencing:
> qcom-wcn: set the wlan-enable GPIO to output") as well?
> 
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/power/sequencing/pwrseq-qcom-wcn.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
> > index 682a9beac69eb..bb8c47280b7bc 100644
> > --- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
> > +++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
> > @@ -379,7 +379,7 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
> >  				     "Failed to get the Bluetooth enable GPIO\n");
> >  
> >  	ctx->wlan_gpio = devm_gpiod_get_optional(dev, "wlan-enable",
> > -						 GPIOD_ASIS);
> > +						 GPIOD_OUT_LOW);
> >  	if (IS_ERR(ctx->wlan_gpio))
> >  		return dev_err_probe(dev, PTR_ERR(ctx->wlan_gpio),
> >  				     "Failed to get the WLAN enable GPIO\n");
> > -- 
> > 2.30.2
> > 
> 
> I'm not sure why but applying this patch brings back the error I had
> before. It does seem like setting wlan-enable GPIO happens early enough,
> but maybe some timing is still wrong.
>

There should be no room for timing issue now :/
 
> [   17.132161] <gpiod_set_value_cansleep(ctx->wlan_gpio, 1);>
> [   17.480619] ath12k_pci 0004:01:00.0: of_irq_parse_pci: failed with rc=134
> [   17.491997] ath12k_pci 0004:01:00.0: pci device id mismatch: 0xffff 0x1107
> [   17.492000] ath12k_pci 0004:01:00.0: failed to claim device: -5
> [   17.492075] ath12k_pci 0004:01:00.0: probe with driver ath12k_pci failed with error -5
> 

Are you sure that this is the same error that you noticed before?

> Any ideas/suggestions?
> 

Can you verify that the pwrctrl driver's probe is completed *before* ath12k
driver starting to probe by adding the debug prints in both drivers?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

