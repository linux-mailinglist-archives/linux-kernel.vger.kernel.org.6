Return-Path: <linux-kernel+bounces-384839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0E39B2F14
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EBA128194F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCDC1D619E;
	Mon, 28 Oct 2024 11:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AeoPWa0X"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2CD1D61A4
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730115860; cv=none; b=i0XLKkxMYGaLL7tp/fR3VNPnNbUeVM/bMiCq6CNroNAIhCSXr7Djc07WFls4yRIuKexKMrAfnheuBOSgWr26jpENzGqz1YRYtY6aWESZKey20cKD7GMchz6z3lAKPUUHuUdceEnr66OpLpWQkErRiF4AkNJFttgKF9HSpN41wgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730115860; c=relaxed/simple;
	bh=oHN252Cm/PR4IfsmtjEHlgEfFHmNRB7exyOEQK+Es38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/RIGKudTExlDCQfkkUkT07K6oz+S8GJO/YVTPuMt/3MT6DTVL+JbGQ1eoYtqD92EVyNaOUpiI9l/KCRVhsTf2t3yc3kcRFN7Nln7yeZuEb1sW6RDsx0tCJP9Ohx7zJmn2qc3Bur6bme9g7lHqRBiIG3FKrEAPSbY02TrugO7zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AeoPWa0X; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e390d9ad1dso33695627b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 04:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730115857; x=1730720657; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=szANAidLxxi7S1PZCTPLqWZlMP+zv9KWhvcW3ZJkZQM=;
        b=AeoPWa0XlYxQDg/X6POZ/NvoPCLwXVGYgXitiKqPr2RiwlswK4KUsKDpfY5F2VT7fU
         JLgx/zu7KPExzDDCOootdJAqCD7f+tWzpotEzdt7N/ImMlz1RXbMh4AdeE9EMuRBiEku
         g0lYigKR6yVkbk5JY53MjN7ncWKpx99c59wYGi/RP8puBcWA5NHIgVZuCBeY5GSYEcU3
         O4g44+WOQ+pQX148deIuBP3xwB7jG2qWpi3xwNz21u0evouY16/zEU39n7zWEi5sJ+cD
         oN7FDgE4aofeWgj6TTQosqgLgOWSrZrF5LSkIJs8lfqXF4/CHZKnMv7AJotBEchC2J4m
         7GlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730115857; x=1730720657;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szANAidLxxi7S1PZCTPLqWZlMP+zv9KWhvcW3ZJkZQM=;
        b=qteahU1gkUh8GEKJeSWtC/z06Z7fv8zHRQPtloix7ftFdUBs1+omkvZtkBvUQIcWtL
         NMPVKdV9VpqpD3dGbQLLt8YvByu1q5oQrU+3DFl1qEpDGyy1/wXFnETfokt9ZfOsSvt5
         ldr/d65yCJB7k/80do/yarP2RXZIWj7zWyUZEUHHZFsYRdJ2CjShFNnMs12CJqLEpMTg
         SxZ42/MKR+pjAPbSV1f6/XEzMqCPLy0gsYXUEb9NihEKmWVzOOSL6+cIT9q5v8Z0O9R1
         SF9pdY7FTsdcnyVdPvJtx9emRg6aAUhHbc0z/S7tRHZdAoRGmERgDaCfKA8O839c4Je4
         TE9w==
X-Forwarded-Encrypted: i=1; AJvYcCXTu0MjfnkBR1Uu9shRP9p33vnaau0AixM9Zzd7350EWDE2zUdoxyHWa2X86aFxKZyqzymHdCzfyffN2dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMNye2CqobjNO4V1yWmTJCntXKNqq2cwgmcN02Fkibllykf3/W
	JBw52MXVEavzWd0Am6dNtIHk1FJtKUDw0s7xO2PLIEpRgiclTYUPE5AcsSYSaIe7F4NdJhaVC6j
	zTEQIDIr0RUtRJiq7K6H+JLBBP/5athPQGaEWZQ==
X-Google-Smtp-Source: AGHT+IGlwVOjMs2uEyjnINxzYdhzOYC3xUxuhss1DI1A8rYReLEVT61L75XVgrauUGWoh5wtBcMP1/AClNWL+Q5J27A=
X-Received: by 2002:a05:690c:f15:b0:6e5:e714:3be0 with SMTP id
 00721157ae682-6e9d88fd767mr64305097b3.1.1730115856984; Mon, 28 Oct 2024
 04:44:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025060017.1663697-1-benchuanggli@gmail.com>
 <CAPDyKFpb5ZePhXziLH3VbuKKywJZbo8UBF1NM1_dyOWq9oLDng@mail.gmail.com> <4dd25dca-f217-4abd-88e8-0a6b03760dd7@tuxedocomputers.com>
In-Reply-To: <4dd25dca-f217-4abd-88e8-0a6b03760dd7@tuxedocomputers.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 28 Oct 2024 12:43:40 +0100
Message-ID: <CAPDyKFpx=FwMH0PgaQqd+hFVa3ncuUjnikC3vfDHwN9V65H9mA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-pci-gli: GL9767: Fix low power mode on the
 set clock function
To: Ben Chuang <benchuanggli@gmail.com>, Georg Gottleuber <ggo@tuxedocomputers.com>
Cc: adrian.hunter@intel.com, victor.shih@genesyslogic.com.tw, 
	greg.tu@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw, 
	HL.Liu@genesyslogic.com.tw, Lucas.Lai@genesyslogic.com.tw, 
	victorshihgli@gmail.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Werner Sembach <wse@tuxedocomputers.com>, cs@tuxedo.de
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Oct 2024 at 17:40, Georg Gottleuber <ggo@tuxedocomputers.com> wrote:
>
> Hello Ben, hello Uffe,
>
> thank you for this fix.
>
> Am 25.10.24 um 15:22 schrieb Ulf Hansson:
> > + Georg
> >
> > On Fri, 25 Oct 2024 at 08:01, Ben Chuang <benchuanggli@gmail.com> wrote:
> >>
> >> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >>
> >> On sdhci_gl9767_set_clock(), the vendor header space(VHS) is read-only
> >> after calling gl9767_disable_ssc_pll() and gl9767_set_ssc_pll_205mhz().
> >> So the low power negotiation mode cannot be enabled again.
> >> Introduce gl9767_set_low_power_negotiation() function to fix it.
> >>
> >> The explanation process is as below.
> >>
> >> static void sdhci_gl9767_set_clock()
> >> {
> >>         ...
> >>         gl9767_vhs_write();
> >>         ...
> >>         value |= PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> >>         pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value); <--- (a)
> >>
> >>         gl9767_disable_ssc_pll(); <--- (b)
> >>         sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> >>
> >>         if (clock == 0)
> >>                 return;  <-- (I)
> >>
> >>         ...
> >>         if (clock == 200000000 && ios->timing == MMC_TIMING_UHS_SDR104) {
> >>                 ...
> >>                 gl9767_set_ssc_pll_205mhz(); <--- (c)
> >>         }
> >>         ...
> >>         value &= ~PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> >>         pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value); <-- (II)
> >>         gl9767_vhs_read();
> >> }
> >>
> >> (a) disable low power negotiation mode. When return on (I), the low power
> >> mode is disabled.  After (b) and (c), VHS is read-only, the low power mode
> >> cannot be enabled on (II).
> >>
> >> Fixes: d2754355512e ("mmc: sdhci-pci-gli: Set SDR104's clock to 205MHz and enable SSC for GL9767")
> >
> > Is this the same problem as being reported in
> > https://lore.kernel.org/all/41c1c88a-b2c9-4c05-863a-467785027f49@tuxedocomputers.com/
> >
> > ?
>
> Yes, this patch fixes
> https://bugzilla.kernel.org/show_bug.cgi?id=219284
>
> This makes my patch obsolete.

Thanks to both of you for helping out and fixing the problem!

I added Georg's reported/tested-by tag when applying and queued this
up as a fix with a stable tag.

Kind regards
Uffe

