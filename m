Return-Path: <linux-kernel+bounces-524099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FFBA3DF2C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99755421D7F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6A0204877;
	Thu, 20 Feb 2025 15:45:52 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEB51FE46E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066352; cv=none; b=E6W+5I+/VqJhjC4r1lZBbTuLcC5sPEVhaLcd3uZy/wG6g6F/TAp/kaWviGrQl7dW5vsRWjcW2+bAuVTw4OYy+CMltYKQoxur7L0hqc1xRWgQqIE1tniwx/K8/tGigVgR8XV7zDEJgbuUeuQz4JWlRhxrV3+Dn/6D9IP1A1aP1qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066352; c=relaxed/simple;
	bh=Iq9T7pMioPdDOZz4aq2ZIvplirUsKKpBikVGevZ1iTU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iB3nXMAwEoQWGWKKtX2FUtMQzikV6AouRfuPcM4UMYU3O8elmHwUAf5wXQ0ZRiXLYfmhoT5L6S3VKQN7zYFtP8E0fJXajDixblGyzLUp2YolJjC7EB88RXUn2pmSVDvkdYdVRF9dZH8WI0YqiMwqPD/+veuddrMbKhVx9B0PI8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tl8k7-0003MS-Ml; Thu, 20 Feb 2025 16:45:39 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tl8k7-001xUd-18;
	Thu, 20 Feb 2025 16:45:39 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tl8k7-000Clm-0p;
	Thu, 20 Feb 2025 16:45:39 +0100
Message-ID: <6e03b0c09c4e6d222670025c6540f73a0a0a819d.camel@pengutronix.de>
Subject: Re: [PATCH v2 8/8] imx_dsp_rproc: Use reset controller API to
 control the DSP
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>, Daniel Baluta
	 <daniel.baluta@nxp.com>, robh@kernel.org, shawnguo@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org, 
	shengjiu.wang@nxp.com, Frank.Li@nxp.com, peng.fan@nxp.com, 
	laurentiu.mihalcea@nxp.com, iuliana.prodan@nxp.com
Date: Thu, 20 Feb 2025 16:45:39 +0100
In-Reply-To: <c52e6c5c-f49e-4727-b669-086ae7cb0e1e@gmail.com>
References: <20250219192102.423850-1-daniel.baluta@nxp.com>
	 <20250219192102.423850-9-daniel.baluta@nxp.com>
	 <c52e6c5c-f49e-4727-b669-086ae7cb0e1e@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Do, 2025-02-20 at 00:22 +0200, Laurentiu Mihalcea wrote:
>=20
> On 2/19/2025 9:21 PM, Daniel Baluta wrote:
> > Use the reset controller API to control the DSP on i.MX8MP. This way
> > we can have a better control of the resources and avoid using a syscon
> > to access the audiomix bits.
> >=20
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > Reviewed-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/remoteproc/imx_dsp_rproc.c | 25 +++++++++++++++++--------
> >  drivers/remoteproc/imx_rproc.h     |  2 ++
> >  2 files changed, 19 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/im=
x_dsp_rproc.c
> > index ea5024919c2f..631563e4f86d 100644
> > --- a/drivers/remoteproc/imx_dsp_rproc.c
> > +++ b/drivers/remoteproc/imx_dsp_rproc.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/pm_runtime.h>
> >  #include <linux/regmap.h>
> >  #include <linux/remoteproc.h>
> > +#include <linux/reset.h>
> >  #include <linux/slab.h>
> > =20
> >  #include "imx_rproc.h"
> > @@ -111,6 +112,7 @@ enum imx_dsp_rp_mbox_messages {
> >   */
> >  struct imx_dsp_rproc {
> >  	struct regmap				*regmap;
> > +	struct reset_control			*reset;
>=20
> Maybe rename this to "stall"? There's also the DAP stuff that's actually =
used
> to reset the core so this might be a bit confusing?

So Run/Stall does not actually reset anything? Maybe then it should not
be modeled as a reset control. It looks to me like the
DAP_PWRCTL[CORERESET] bit in the Audio Processor Debug region would be
a much better fit.

regards
Philipp

