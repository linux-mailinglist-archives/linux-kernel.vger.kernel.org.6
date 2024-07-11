Return-Path: <linux-kernel+bounces-249460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED67F92EC0A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EE25B23D77
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8013416B72E;
	Thu, 11 Jul 2024 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XNWNLECw"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E27316C684
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720713370; cv=none; b=caiUj09IEGdrFg4ExYQt8ld/H9+I4nMhhm6x5GDVXOyvVszSY2EjmZhB+3k2aL6DKgPE9SnlSCarNhQ0Z1aNSQBih8OBmbFu7ZfSjxiWmtAPzVlIUSQtUFqMEt7dxfJL5N84gAgX+I+//FCz+J/mViOdpjOAUasMWs1tMBsr5vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720713370; c=relaxed/simple;
	bh=fK93rdN7UPAjzzNdY9a2W7zpHlmO1W+0cPnbEmcEXTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DbdFaCr3CJZbTyJFSs+n8eLjzkaASSzwKviY9sgdQSDACWMA5DSHH9WM7YRpjPRJU2MoQuiyE8AKnIppLZyV9OB84PxQyKCr6AAQ3Gd9CZil5V3gK7FKDmYpct1/QPVyfxHIBY2OHiuq4f9IyDKY1PIcuO+PdpT86dv347Yyk+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XNWNLECw; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e026a2238d8so1065746276.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720713367; x=1721318167; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o9NK8vbwSl6fVYipiYD+K+b1VqL0LZzXwcN17mQG4N4=;
        b=XNWNLECwCeqYN2s8mXpun7H5BoRAbK3P8xAtol1uqw1cP2DWYnc7Vg5cKAxEpyEbn3
         ROwCxaMsYrwpAEO+WJel+fWtNWRlZ259Do37x7xNp+Ba3l4EYfJXlMeQIIzPzdK706kL
         2aCadurOtzdadzyZnK/O74GN4K9zKX0DDX73QPVyJ2WdR9Sm/NyhqrrykeXuGmpIQAcT
         2X1OLou1BCwgpiyGJKqVEAovIGDfJ0ROYOSRRzVMtiapETt0+uSMrHXZuIucDBQSUzuR
         bv4wZJW0kaCfDO2qWGQM6wkrkLhtcbR9wfpGFVyIUDjmn9GSUg2K3UN3RcR9zwGU1Wx3
         qmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720713367; x=1721318167;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o9NK8vbwSl6fVYipiYD+K+b1VqL0LZzXwcN17mQG4N4=;
        b=vjmXhPj2iAOgxUppEqywh47Q+kmQjBV7rs9mT1i8FUfNRbeOpfUrb1qKOzqb3xAluP
         6SpZw3kRJvv0R1IKkV8PQz6NUyYjvJbGAVGhlRJFpCwwuFs0ndxioARo8C7afD+8D5uw
         o99OExp6LRTP6mUo7L/FfC3wbZLZ/SJ3KyEBqTiK49qsPWb55z2EhMeRnVBxqEY2Afw+
         P3xqthSVMDFc4EFJcqzn5PUFGQCf/9kWDgNptarCtDxkGDGiz+LOgK7upVzs4K9yPN9V
         HUUIOJn5BumtGwBBTdzU+xZs6FyypqK96ekUbm3ollCpJTcTprFcOcD7Dwb/FiqdX6pp
         s3qA==
X-Forwarded-Encrypted: i=1; AJvYcCXc1bfOSn3m5hvlAMQEST+raXwOwj7iwDY2v6IYXx8TXPllEmQPcpnxXr5YX2H3bUq1XOdPsru8m9yc3aPsbdyQfhTqVdR+5P2hqvwu
X-Gm-Message-State: AOJu0YwW3IM+WhGGtdAjZ43oj9KgbgJUSdv6ZhnKyTFOrqR4N4ulAhTf
	stJBDCq8IUdIGEMbiEWogF1qedQNq8VSRbmdVawBQzXCbu5gPR1N20gDNiETq2Nxq4zHwATxHPS
	XZRzwFJMuzBBNGRSzooc5/Tw/JNLqH3y+qE2pZQ==
X-Google-Smtp-Source: AGHT+IFkr/j+VnCO+Vl5QVu0QsqTKrqy4owjYSW/qtao35IwLP4Q3jMZYHSbiM4nmMtUoEAIPyhT561j44bWpNjvOPg=
X-Received: by 2002:a25:868b:0:b0:e03:5dd4:ec1a with SMTP id
 3f1490d57ef6-e041b03c277mr10295295276.4.1720713367555; Thu, 11 Jul 2024
 08:56:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708121018.246476-1-ciprianmarian.costea@oss.nxp.com>
 <20240708121018.246476-2-ciprianmarian.costea@oss.nxp.com>
 <6a577d6c-04ad-4c12-bfad-815e811deee3@intel.com> <123ce7e1-1981-4a41-a131-168f4f7b5417@oss.nxp.com>
In-Reply-To: <123ce7e1-1981-4a41-a131-168f4f7b5417@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 11 Jul 2024 17:55:31 +0200
Message-ID: <CAPDyKFoHmvZLogUY=-WXM2G+g1h=fbaakySHCJh7MSaFMYuCXw@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: sdhci-esdhc-imx: disable card detect wake for
 S32G based platforms
To: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Haibo Chen <haibo.chen@nxp.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, s32@nxp.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jul 2024 at 16:26, Ciprian Marian Costea
<ciprianmarian.costea@oss.nxp.com> wrote:
>
> On 7/10/2024 3:34 PM, Adrian Hunter wrote:
> > On 8/07/24 15:10, Ciprian Costea wrote:
> >> In case of S32G based platforms, GPIO CD used for card detect
> >> wake mechanism is not available.
> >>
> >> For this scenario the newly introduced flag
> >> 'ESDHC_FLAG_SKIP_CD_WAKE' is used.
> >>
> >> Signed-off-by: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
> >
> > Should have:
> >
> >   - put the patch set version number (v2) in the subject e.g.
> >     [PATCH v2 1/3] mmc: sdhci-esdhc-imx: disable card detect wake for S32G based platforms
> >
> >   - added Haibo Chen's Reviewed-by tag
> >
> > Anyway:
> >
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> >
>
> Hello Adrian,
>
> Sorry for bothering you with this question, but should I send a new
> patchset adding the new version or what is the process after this step ?
> For example, should I send this patchset again with V3 adding all the
> ACKs & Reviewed-by tags to each commit from the patchset ?

No need to send a new version this time, I can add Haibo's tag when
applying. Although I prefer an ack from him for patch3 before I merge
this.

Kind regards
Uffe

>
> Best Regards,
> Ciprian
>
> >
> >> ---
> >>   drivers/mmc/host/sdhci-esdhc-imx.c | 8 ++++++--
> >>   1 file changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> >> index 40a6e2f8145a..21d984a77be8 100644
> >> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> >> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> >> @@ -201,6 +201,9 @@
> >>   /* ERR004536 is not applicable for the IP  */
> >>   #define ESDHC_FLAG_SKIP_ERR004536  BIT(17)
> >>
> >> +/* The IP does not have GPIO CD wake capabilities */
> >> +#define ESDHC_FLAG_SKIP_CD_WAKE             BIT(18)
> >> +
> >>   enum wp_types {
> >>      ESDHC_WP_NONE,          /* no WP, neither controller nor gpio */
> >>      ESDHC_WP_CONTROLLER,    /* mmc controller internal WP */
> >> @@ -298,7 +301,7 @@ static struct esdhc_soc_data usdhc_s32g2_data = {
> >>      .flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
> >>                      | ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
> >>                      | ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
> >> -                    | ESDHC_FLAG_SKIP_ERR004536,
> >> +                    | ESDHC_FLAG_SKIP_ERR004536 | ESDHC_FLAG_SKIP_CD_WAKE,
> >>   };
> >>
> >>   static struct esdhc_soc_data usdhc_imx7ulp_data = {
> >> @@ -1726,7 +1729,8 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
> >>              host->mmc->caps |= MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
> >>
> >>              /* GPIO CD can be set as a wakeup source */
> >> -            host->mmc->caps |= MMC_CAP_CD_WAKE;
> >> +            if (!(imx_data->socdata->flags & ESDHC_FLAG_SKIP_CD_WAKE))
> >> +                    host->mmc->caps |= MMC_CAP_CD_WAKE;
> >>
> >>              if (!(imx_data->socdata->flags & ESDHC_FLAG_HS200))
> >>                      host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
> >
>

