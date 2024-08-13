Return-Path: <linux-kernel+bounces-284461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E0F95012E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20DADB24EA4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A6E17C235;
	Tue, 13 Aug 2024 09:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="O+2mn4aj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="NsFbJuu2"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B44B16BE01;
	Tue, 13 Aug 2024 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541250; cv=none; b=ay+pnKrziN0EyjaSbQuXlizBX777ruNmFCuZ7/l0dtcd0/rJOmNdXGMqCxJi9Pg3EGmgmMwGnRdle5faChm7hQPUZm/xWLFVri3/JsF9ZxHGRU854HA2putoemTFCYqICwiU+SrJGSlXwPLOWR8YvFuXUy7saxhRju3nCmC+30k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541250; c=relaxed/simple;
	bh=zWKBpp1fD8CLOQCnYPuwXtK/LuxFd72qNCF9B1vaz+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bOhAOXyPVJVbAwFuHhYiE4ZJ31l7r2y6KJi0Si32E+IPLTUv/JlGRwHfjZJfgwR8xYoFi5TDwgcwiD+1lCB8fKz7yeWG2NYzTWz16zyOh/Al4HtgIJ1LkQ+oSohXNKlgyTXC9mxDAtOEjshmcaULyVzQecRfbU9WoFnpPqMnSMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=O+2mn4aj; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=NsFbJuu2 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723541248; x=1755077248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AiPyUN9SZEn/2DxqAiamaEu3TLRdS5TFR2v5vsla9UU=;
  b=O+2mn4ajZcdqteK6HBKOqeP7AhUx0DqJme6TT87tuAfxVLgOaL3P6EJV
   q85CkG3XuoECbeSJPEjgUWpIHzJC+r2JxOOPNJaRkS5oToHl4L1DGJ357
   bedoLlJ60yxT2UczYyHYgS90lFJix6PBMCySbopUCVUHnqlc2AxyG22Gx
   /St7tYP3/pJg/lOS1Lgl+Vuf3rvFE4c3XEaAWTcLrNMesKk6//ZLw4nlH
   EZEWfMNnWYLpH0wcsau23EJVSagc4kh4a/qiuep9h1clikWTBEAQCNZ0/
   86SVphVxnMkCOcXzoU7MRTINS09CeTVxh2MlpyBhZMrmF1qn14kSmljgB
   g==;
X-CSE-ConnectionGUID: vQDCJkZKR5+N7c+nnQOkNA==
X-CSE-MsgGUID: kkpTOROmT56mQfd4Xia0zw==
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208";a="38381022"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 13 Aug 2024 11:27:19 +0200
X-CheckPoint: {66BB26F7-16-E9ED6009-C4B0BEC8}
X-MAIL-CPID: 9A041D01685DFD5BA42E4A134572F148_3
X-Control-Analysis: str=0001.0A782F29.66BB26F7.01BC,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 80FAF1640C1;
	Tue, 13 Aug 2024 11:27:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723541235;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AiPyUN9SZEn/2DxqAiamaEu3TLRdS5TFR2v5vsla9UU=;
	b=NsFbJuu2E39m2ROafNdDaW75fHdglVZUu9NWqrgw6Qjv31JJEG05Dx6p2Zr6KZJQs9hgtn
	RnqKw3a6bQzLnPGxC7EgZtkRhAuMHRzr4Zc5+6zk568GrGeUGHPNR0YEiAvvJH04ihP+j7
	6tHcRjUf7Z7DCAxL/0yNR98aPJJnfs9BqlyY7QoSaNMJzE7T6SNpknSH/FRoxud5vrK+hm
	GvZ46pGd25g015z1MTbeKIuXwtDN/DVODPhpQrjhH+UETCDgJYYgLn+j2ql2yfovl9t6td
	1frOL65+KWjbuhrhZDvhhUfO/nGg49Fr5sDNDb/wxSkhtQ9d/ATosFSl1YDEiQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Markus Niebel <Markus.Niebel@ew.tq-group.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: Re: [PATCH 5/5] ARM: dts: imx6qdl: Rename USB hub node name
Date: Tue, 13 Aug 2024 11:27:16 +0200
Message-ID: <1901821.CQOukoFCf9@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <781e8fcd-3814-4537-8ecf-efab0a380fff@kernel.org>
References: <20240812143431.98323-1-Markus.Niebel@ew.tq-group.com> <20240812143431.98323-6-Markus.Niebel@ew.tq-group.com> <781e8fcd-3814-4537-8ecf-efab0a380fff@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Am Dienstag, 13. August 2024, 11:20:08 CEST schrieb Krzysztof Kozlowski:
> On 12/08/2024 16:34, Markus Niebel wrote:
> > From: Alexander Stein <alexander.stein@ew.tq-group.com>
> >=20
> > According to microchip,usb2514.yaml the node name shall be usb-hub.
>=20
> That's not true. The schema does not say anything like this. Old name is
> correct. NAK.

So, is the schema incorrect? There is the dtbs_check warning:
arch/arm/boot/dts/nxp/imx/imx6q-mba6b.dtb: hub@1: $nodename:0: 'hub@1' does=
 not match '^usb(@.*)?'
        from schema $id: http://devicetree.org/schemas/usb/microchip,usb251=
4.yaml#

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



