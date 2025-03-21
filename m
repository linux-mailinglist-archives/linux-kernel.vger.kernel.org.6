Return-Path: <linux-kernel+bounces-571175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4803A6BA09
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352EC3AC35B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAF1224B09;
	Fri, 21 Mar 2025 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rih5WJyU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA761EA7D3;
	Fri, 21 Mar 2025 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742557323; cv=none; b=CKYR14MnzLwevYcR8nC0uh7N82w5gu56H86OlgM2c+Ox31z8bje0BTk+tpo/e8nz+WCC2Ukb+489Q4Mv7DocSaDUJK6iHEoWep29M28hKoIEP57VS9Mbjp3htriwMTx8BikDkogrodSl6bTd0lpeAsy0BH39lxiCtqdmHVVblkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742557323; c=relaxed/simple;
	bh=KVzZGjFPG41jqp69QVYd/mRyk1rD77DMd0M54wVUmyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvBFTEbrvHWczXok+pD/D3sf+5tENENoPn0J2ckIGbQ6y+PJnNlanGDRSA6GGWoV1UsF6uZGyepcH4V0gq4S/BEXnVmDr4fMTfJx67nAnG47jzsT9uIUhOD50RQNqIHg2zzew+c02NTMcVFbegA+YVMgyFo+RDO898ddw5/DeEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rih5WJyU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CBBC4CEE3;
	Fri, 21 Mar 2025 11:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742557323;
	bh=KVzZGjFPG41jqp69QVYd/mRyk1rD77DMd0M54wVUmyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rih5WJyUzFc3bexfx1zkYZ9nv6sKHXH4lFF6pDhaBofyshl6lp4O90d2nFPdQuTjZ
	 qVBN6CduVcYZ/8BZ10WmoQV5TAfjZrNb8yc418Z+3+jc4CtoRAHnzUNQsaJKidxflN
	 REMtZr94VG0IoxTOB3nAsTvbXEeH9ublW7cXstjqUdyey9aZeNjK0fepgHMy+zdkk2
	 k+490lot8ulO+tHFyiIGEHJMaYMwZoIUERkap/GCOZSr45HV8dgqm89ZppoFZ6DSpo
	 07Hy4eJSpIwDmb4yiFvYum0JXpW8szzl/+BxIy/2ulretu8D/aWBB2yoKu+QOXRYTt
	 /u5rtfnewbWkA==
Date: Fri, 21 Mar 2025 11:41:59 +0000
From: Lee Jones <lee@kernel.org>
To: Colin Foster <colin.foster@in-advantage.com>
Cc: Rasmus Villemoes <ravi@prevas.dk>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Felix Blix Everberg <felix.blix@prevas.dk>
Subject: Re: [PATCH 1/8] mfd: ocelot: refactor bus-specific regmap
 initialization
Message-ID: <20250321114159.GJ1750245@google.com>
References: <20250319123058.452202-1-ravi@prevas.dk>
 <20250319123058.452202-2-ravi@prevas.dk>
 <Z9skKTf30m9DVaC5@colin-ia-desktop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9skKTf30m9DVaC5@colin-ia-desktop>

On Wed, 19 Mar 2025, Colin Foster wrote:

> On Wed, Mar 19, 2025 at 01:30:51PM +0100, Rasmus Villemoes wrote:
> > diff --git a/drivers/mfd/ocelot-core.c b/drivers/mfd/ocelot-core.c
> > index 41aff27088548..78b5fe15efdd2 100644
> > --- a/drivers/mfd/ocelot-core.c
> > +++ b/drivers/mfd/ocelot-core.c
> > @@ -200,10 +200,12 @@ static const struct mfd_cell vsc7512_devs[] = {
> >  static void ocelot_core_try_add_regmap(struct device *dev,
> >                                        const struct resource *res)
> >  {
> > +       struct ocelot_ddata *ddata = dev_get_drvdata(dev);
> > +
> >         if (dev_get_regmap(dev, res->name))
> >                 return;
> > 
> > -       ocelot_spi_init_regmap(dev, res);
> > +       ddata->init_regmap(dev, res);
> 
> I remember changing this from function pointers to the direct function
> call during initial development, per Lee's suggestion. I like it though,
> and I'm glad to see multiple users now.

Yeah, we're still not going to be putting call-backs into device data.

Either pass the differentiating config through to the core driver or
handle the differentiation inside the *-i2c.c / *-spi.c files.

-- 
Lee Jones [李琼斯]

