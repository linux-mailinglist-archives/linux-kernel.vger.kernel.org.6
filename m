Return-Path: <linux-kernel+bounces-449117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31609F4A18
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EADE16BDAB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F221EF080;
	Tue, 17 Dec 2024 11:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FlquAj4t"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF621DDA35
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734435684; cv=none; b=RoEO0RglDInCpT3HphJOPSuPPf+t6LptkDM6DPwm6B8Zr9b6YkaX/CxzrlrP3pdGm4+yp0UuNQzUZtAeG40PTksPf6EQocIBoLHI0UTqrrsXAqAv1WMDiVFnbHB6C9AcikejiiC0hJ/nLcsWprdK5NiROM+O9jyxjbaOtmEwJMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734435684; c=relaxed/simple;
	bh=kPUdKaQO5uNQFQG6V0ETQ3Cz/bW8IbNQNYsjq9ssp7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YgnkD68NjVWAISZadTn7OWd0X/RoWNq7x+necrTdwyzcqRRrAviOn7pTpy0EdcQMhpmB2YWUinsu7hCOX/HPvZjIC5k7a4C5ZZe8jMip6Qo0h4J/lv1mqlOcP9cIIKNnqsunJbKf5Y8W0OiO+aiPLOc7N5igSudSNR06U8obPjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FlquAj4t; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21644aca3a0so60853715ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 03:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734435681; x=1735040481; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b0EZW6LlfowWIgAwJtFx9CvahXq/dyYnxzkbI6o/02Q=;
        b=FlquAj4tXLDX9cZmCYCMaOvaS1LWnWXeQ6eMfF9gri5J5LRcF1pYOSGaRU1xcnlFh+
         U0whzpxO+ZG162AIN+ZPwQnwxkXXETSULYc+8l0GsyEL5RF2ShXdjpOnJKJz25slwumA
         yy0B075kE+UjVF5bVaRbyYv6VpdLGfnd4KSVPO2pAjPPOkKEczXmpRXgpqxIW9FzcRSS
         EhR9584nRV4sS7g/LmyVfIpohC6RuL1GL7B1aXgC95Q/8swRPW1SwaNlmbCx5tmr4Znb
         ahSZwZ8UFR3geiO/MRNoi47NNHwsSYKPN0wyMBIh0a/hVYDwNanIchT6WJIdjRL6Enmy
         YYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734435681; x=1735040481;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0EZW6LlfowWIgAwJtFx9CvahXq/dyYnxzkbI6o/02Q=;
        b=vMczhXAx3tamAMcCWxYRfTrK0iYjL9xIqT2hgiqUSL5inQjOSsaX9JaMNORe/QaKRo
         Z7GAy2rsAEI0Tpb/Yi8PGhLubXkgwbUL+mYfOr3BCwlvMnzxvWfXzq7ViCeDhkblbwpq
         2oj/oDxFEsskIe9QYDdvkK40XpO597LzFkYCfL6DO13uIwaq5KGN7/MKUVr/t6pwUzb/
         cmb5z+q3JJS1Pu1cICPvlsL77q89oNJq2vblQqJONwoZBzYwbInY4PbUQ1yCQA+Jps77
         GCheO3+pXyo8xjd/gOjRLaf3lJzw+jiCwNLwxroAKRquZI/9w1UWFW+IqrCIKany6Qw4
         UPhw==
X-Gm-Message-State: AOJu0YxDwRVRH14BM0k5vVI6RTbi8jc66+nWx9DXdhRCMVmVsONQvuxn
	qMRBypk7m4U76puv9o9J9r7av7A5wUvpOig7UGQT6b7W0BKCJhKpdO/X4fQ13GttARDmR2t2wUI
	oWKeKQfVU5MMvIqMOArQ1Tj/R7eipTWN3n7O/D2zP2B8G1zFZ
X-Gm-Gg: ASbGncvSfLqpkylXl3D2sSs7Myr7wvTBQmImgfQ8NmLoarsLIzb3eejz+0M8TAwWkfT
	MbIGwL45KcdsSt9XpKx/3u2m33TadhF7BM8+lQ5A=
X-Google-Smtp-Source: AGHT+IGIDfrYNaywRoWFo3CQSbMxXhWSle7L1Jb4vz79u1YZalyqFK7FlUJMk0NlWFVnhyTGxjaH1yzDfdnlavipwTg=
X-Received: by 2002:a17:90b:4b06:b0:2ee:9b2c:3253 with SMTP id
 98e67ed59e1d1-2f2901a2a67mr23276889a91.30.1734435681520; Tue, 17 Dec 2024
 03:41:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213144919.110642-1-mike.leach@linaro.org>
 <20241213144919.110642-3-mike.leach@linaro.org> <9094b068-ed3a-444d-b790-e43a652ab6e9@arm.com>
In-Reply-To: <9094b068-ed3a-444d-b790-e43a652ab6e9@arm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Tue, 17 Dec 2024 11:41:11 +0000
Message-ID: <CAJ9a7VjCK+FGB+EMbcgaRfkv13TYYgBNHTG+AGp=52dZ7EfQAQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] coresight: tmc: Update error logging in tmc common functions
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	coresight@lists.linaro.org, james.clark@linaro.org, 
	alexander.shishkin@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

Hi Suzuki,

On Mon, 16 Dec 2024 at 09:33, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 13/12/2024 14:49, Mike Leach wrote:
> > Enhance the error logging in the tmc_wait_for_tmcready() and
> > tmc_flush_and_stop() to print key tmc  register values on error
> > conditions to improve hardware debug information.
> >
> > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > ---
> >   .../hwtracing/coresight/coresight-tmc-core.c  | 37 +++++++++++++++----
> >   drivers/hwtracing/coresight/coresight-tmc.h   |  2 +-
> >   2 files changed, 30 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> > index e9876252a789..1a9299adae93 100644
> > --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> > @@ -34,25 +34,36 @@ DEFINE_CORESIGHT_DEVLIST(etb_devs, "tmc_etb");
> >   DEFINE_CORESIGHT_DEVLIST(etf_devs, "tmc_etf");
> >   DEFINE_CORESIGHT_DEVLIST(etr_devs, "tmc_etr");
> >
> > +#define TMC_WAIT_READY_FMT_STR "timeout while waiting for TMC to be Ready [STS=0x%04x]\n"
> > +
> >   int tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
> >   {
> >       struct coresight_device *csdev = drvdata->csdev;
> >       struct csdev_access *csa = &csdev->access;
> > +     u32 tmc_sts = 0;
> >
> >       /* Ensure formatter, unformatter and hardware fifo are empty */
> > -     if (coresight_timeout(csa, TMC_STS, TMC_STS_TMCREADY_BIT, 1)) {
> > -             dev_err(&csdev->dev,
> > -                     "timeout while waiting for TMC to be Ready\n");
> > +     if (coresight_timeout_retval(csa, TMC_STS, TMC_STS_TMCREADY_BIT, 1,
> > +                                  &tmc_sts)) {
> > +             dev_err(&csdev->dev, TMC_WAIT_READY_FMT_STR, tmc_sts);
> >               return -EBUSY;
> >       }
> >       return 0;
> >   }
> >
> > -void tmc_flush_and_stop(struct tmc_drvdata *drvdata)
> > +int tmc_flush_and_stop(struct tmc_drvdata *drvdata)
> >   {
> >       struct coresight_device *csdev = drvdata->csdev;
> >       struct csdev_access *csa = &csdev->access;
> > -     u32 ffcr;
> > +     u32 ffcr, ffsr, tmc_sts;
> > +     int rc = 0;
> > +
> > +     /* note any MemErr present when stopping TMC */
> > +     tmc_sts = readl_relaxed(drvdata->base + TMC_STS);
> > +     if (tmc_sts & TMC_STS_MEMERR)
> > +             dev_err(&csdev->dev,
> > +                     "MemErr detected before Manual Flush; STS[0x%02x]\n",
> > +                     tmc_sts);
> >
> >       ffcr = readl_relaxed(drvdata->base + TMC_FFCR);
> >       ffcr |= TMC_FFCR_STOP_ON_FLUSH;
> > @@ -60,12 +71,22 @@ void tmc_flush_and_stop(struct tmc_drvdata *drvdata)
> >       ffcr |= BIT(TMC_FFCR_FLUSHMAN_BIT);
> >       writel_relaxed(ffcr, drvdata->base + TMC_FFCR);
> >       /* Ensure flush completes */
> > -     if (coresight_timeout(csa, TMC_FFCR, TMC_FFCR_FLUSHMAN_BIT, 0)) {
> > +     if (coresight_timeout_retval(csa, TMC_FFCR, TMC_FFCR_FLUSHMAN_BIT, 0,
> > +                                  &ffcr)) {
> > +             ffsr = readl_relaxed(drvdata->base + TMC_FFSR);
> >               dev_err(&csdev->dev,
> > -             "timeout while waiting for completion of Manual Flush\n");
> > +                     "timeout while waiting for completion of Manual Flush\n");
> > +             dev_err(&csdev->dev,
> > +                     "regs: FFCR[0x%02x] FFSR[0x%02x] STS[0x%02x]\n",
> > +                     ffcr, ffsr, tmc_sts);
> > +             rc = -EBUSY;
> >       }
> >
> > -     tmc_wait_for_tmcready(drvdata);
> > +     if (tmc_wait_for_tmcready(drvdata)) {
> > +             dev_err(&csdev->dev, "TMC ready error after Manual flush\n");
> > +             rc = -EBUSY;
> > +     }
> > +     return rc;
> >   }
>
> All of this looks good to me. Do we need to move the MemErr check post
> the flush ? There is a potential chance of hitting a MemERR on flushing
> and we could miss reproting those ones ?
>

We need the one before - if there is already a Memerr then this will
affect the flush operation - on Memerr the formatter will have stopped
etc. But no harm in putting another check afterwards.

Mike

> Suzuki
>
> >   void tmc_enable_hw(struct tmc_drvdata *drvdata)
> > diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> > index 2671926be62a..34513f07c3aa 100644
> > --- a/drivers/hwtracing/coresight/coresight-tmc.h
> > +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> > @@ -259,7 +259,7 @@ struct tmc_sg_table {
> >
> >   /* Generic functions */
> >   int tmc_wait_for_tmcready(struct tmc_drvdata *drvdata);
> > -void tmc_flush_and_stop(struct tmc_drvdata *drvdata);
> > +int tmc_flush_and_stop(struct tmc_drvdata *drvdata);
> >   void tmc_enable_hw(struct tmc_drvdata *drvdata);
> >   void tmc_disable_hw(struct tmc_drvdata *drvdata);
> >   u32 tmc_get_memwidth_mask(struct tmc_drvdata *drvdata);
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

