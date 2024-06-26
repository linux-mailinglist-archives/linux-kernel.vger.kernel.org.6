Return-Path: <linux-kernel+bounces-231192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BDB91876D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01F71F21D52
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345EE18F2E1;
	Wed, 26 Jun 2024 16:31:31 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544042BB02
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719419490; cv=none; b=PXUljn7HrOF9Qgg+vrom4LQqB+38dP32VGn3YZM601ch2W75KEYJ8W9XODH24B/oex0BMues2m6BNiUDpffnYBdO+N8PrSfvNckSAoRDWy1iXlIfE7eVTCEu9aiDy293COcwp6P0dEbcTp2++f/Sny39FRTtqHZm46//f4y4FrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719419490; c=relaxed/simple;
	bh=L3DMo6xjUcb0NUtbnq+M9VldQ0YVOfIyVz4Yk9W8rFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i13gTt2OMue1eC6L6LqfLVU9VuP1pzdnJuECzRAdtu6lCQdFzFS5FDc2eVI2ieHGufgyO3fiBp8ENdOoHvE9s8vti+Vn1Itrx0i2ZIq/67cuRYi2zHQWAqmnJIo6L9/960swercjxlFAdpnYNR0EaB9kxEGBbL6eVv7JQGH9gcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1sMVY5-00023P-8W; Wed, 26 Jun 2024 18:31:09 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1sMVY4-005AYB-13; Wed, 26 Jun 2024 18:31:08 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1sMVY3-00GABg-30;
	Wed, 26 Jun 2024 18:31:07 +0200
Date: Wed, 26 Jun 2024 18:31:07 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux@roeck-us.net, jun.li@nxp.com, devicetree@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH v3 4/4] usb: typec: tcpci: add support to set connector
 orientation
Message-ID: <20240626163107.mnivhlyjvttzmaw4@pengutronix.de>
References: <20240222210903.208901-1-m.felsch@pengutronix.de>
 <20240222210903.208901-5-m.felsch@pengutronix.de>
 <ZfA8XHyxzPePwzV6@kuha.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfA8XHyxzPePwzV6@kuha.fi.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Greg,

On 24-03-12, Heikki Krogerus wrote:
> On Thu, Feb 22, 2024 at 10:09:03PM +0100, Marco Felsch wrote:
> > This add the support to set the optional connector orientation bit which
> > is part of the optional CONFIG_STANDARD_OUTPUT register 0x18 [1]. This
> > allows system designers to connect the tcpc orientation pin directly to
> > the 2:1 ss-mux.
> > 
> > [1] https://www.usb.org/sites/default/files/documents/usb-port_controller_specification_rev2.0_v1.0_0.pdf
> > 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> 
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

seems like this has fallen through the cracks. Since it doesn't apply to
v6.10-rc1 anymore I will send a new version with Heikki's r-b tag.

Regards,
  Marco

> 
> 
> -- 
> heikki

