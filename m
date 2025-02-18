Return-Path: <linux-kernel+bounces-519111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B734A3983D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E69943A2ECA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3408234979;
	Tue, 18 Feb 2025 10:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="d6aJvRm4"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DFD233D91;
	Tue, 18 Feb 2025 10:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873162; cv=none; b=J9Q4+7HZ+uu0MxevjiMSPMPL0x371KCZZM/LgoJxwMykMGauy3Eq/+onvh+Hylj7QAd4yxMMFovcvcQVYVJXWhbsss7wWJ/oA0KtWDVgzs2+/j9Y73HkEdxBFSNBQYSVOtlvkPu4gJVWVgMMpDVI/6OyNc/IqlwDiLQM+sIUkCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873162; c=relaxed/simple;
	bh=nrKMktRPvU5Z3hqIzD/ZWShh2l5SdtIhGZTIzKRhd0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWzrgHgyTyrza5QpBodhy3PBltDz0+s/J/J+KFpSagyN01tMHoyLzp9fgRRgH3d3o7E/mMMKrawVi1IgFJSc948Ut2eWKUw2lChKoa+9Qhr91G9D++6OM7JIXQFU5z5ryJNVRs/YF18iAYwo+E3EkfqdfJ+PstK4TR3icL+V2Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=d6aJvRm4; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=NnMwhEnzZlDnNZbKeqVTyqH7UMhTN8QyA0rAjVzJafc=;
	b=d6aJvRm4llb3gOD6zts96Oakj9u2LBColm3KDmfsYfTOQMe9qeOv3HB5ibEtDh
	OAYDxeaAM3nSSNL86qafeA39uqxR6SfIy2salA/w5hDcYJriQt/wBtIFNj+0/tt1
	buHNCmBLC0t1f/Alhyl1HF512pgdN5/P4w60+RUbW8hbk=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgCH28hCW7RnZJAnCQ--.17115S3;
	Tue, 18 Feb 2025 18:04:52 +0800 (CST)
Date: Tue, 18 Feb 2025 18:04:50 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	NXP S32 Linux <s32@nxp.com>, Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH v5 0/3] add I2C DTS support for S32G2/S32G3 SoCs
Message-ID: <Z7RbQqBfKtM+AtsM@dragon>
References: <20250113110512.506007-1-ciprianmarian.costea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113110512.506007-1-ciprianmarian.costea@oss.nxp.com>
X-CM-TRANSID:M88vCgCH28hCW7RnZJAnCQ--.17115S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVdgAUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCxn3ZWe0TnUxPgAAsn

On Mon, Jan 13, 2025 at 01:05:09PM +0200, Ciprian Costea wrote:
> Ciprian Marian Costea (3):
>   arm64: dts: s32g: add I2C[0..2] support for s32g2 and s32g3
>   arm64: dts: s32g: add common 'S32G-EVB' and 'S32G-RDB' board support
>   arm64: dts: s32g399a-rdb3: Add INA231 sensor entry over I2C4

Applied all, thanks!


