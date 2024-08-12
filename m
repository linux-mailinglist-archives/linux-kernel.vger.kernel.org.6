Return-Path: <linux-kernel+bounces-283357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 883C994F16E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33E521F22C9E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED4E183CB8;
	Mon, 12 Aug 2024 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="mbpiOzog";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="aHWff47P"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5A317C7CB;
	Mon, 12 Aug 2024 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723475598; cv=none; b=d2FOnSBUP7Z9G/5CT5T/LcGL8LFuXvhUszuqIlkpHfS8lSoZ26dKITD4CXrjMRLSoMEdwyxec+HuDmtHNS7om93fhyrQ4Sm3Q4vN5i/eSN9KoH7b4R2PCBT3CgronH7aHjwkoEbAJFJrncFqoUHi9wIIYfgRB34brrnOKG/s9JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723475598; c=relaxed/simple;
	bh=vP9vVA4Ark93c0vzZVoMYZSb75FCURW94YeBDsvvGkg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n+JsqpCqj1dw1OdeBE462y9Oie3/iGyvizRdPqq3qsc0yjtW699abO2OCzzoUJ5vd/LGB4O6dCp2wAFcR6w/7tSnEeNUjFv3CnBxf6iiXbk0qK9UMpFo/+GI+wGsyJSVdNChncH8298s7V6pSAXtBLsj+/hJWoC9im+pgzu+DJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=mbpiOzog; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=aHWff47P reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723475595; x=1755011595;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=vP9vVA4Ark93c0vzZVoMYZSb75FCURW94YeBDsvvGkg=;
  b=mbpiOzogF3t5RkMV8HVCTvaw1YOnJRHZBNrXRc/LEQlLJlKB9x77w9Re
   S8xuWueS+g37jWQ4G5q+EKUuqbF7gCJzm2AEMIBm2941iuHkJQ4LB0CCv
   dp9GYXG8RCDLq1Z3ZHfQWCz5+/4gyjdRsXCBApas9CyPxbNk739iHfjGg
   i3lI+Zu3X6axx09DUchZ+vm0pHtSMogvRvTP/lsIDGD/EcK4bkt8RuiSf
   g3zaNoaSn7v/dBSmkpVwtyZREpietp4iffkmxDcZYrHOANyQ+3WxJVmGv
   ecMQXY7ef2dzbFOlWXGegTixmiwpNC9CyCC853cQoM28TYWIN2RHobEuG
   Q==;
X-CSE-ConnectionGUID: 0qGwey4/SDW6LmMG+TYZfA==
X-CSE-MsgGUID: MxRPnuHkQWO8dhrvNHvgPQ==
X-IronPort-AV: E=Sophos;i="6.09,283,1716242400"; 
   d="scan'208";a="38366494"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 12 Aug 2024 17:13:13 +0200
X-CheckPoint: {66BA2688-1A-751552D8-F91D2344}
X-MAIL-CPID: 2547DA9B08B53E1FE9A64D7061FF06AB_4
X-Control-Analysis: str=0001.0A782F27.66BA2689.0033,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B38E6160AD1;
	Mon, 12 Aug 2024 17:13:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723475588;
	h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vP9vVA4Ark93c0vzZVoMYZSb75FCURW94YeBDsvvGkg=;
	b=aHWff47P48jxegEaCIYVkMTGNUIEm0RngqPINrlJmn2vD8dnq0KQ493rDOBPWOuShGpukG
	WKmaNTWLjQLVMwS3dMKFzrqs9/+PY82WwjBfsIk+hyqsEmaQ+R52/XU1ZMVgEtkgqRQ8PY
	kXlSJomYtmejPp8sIm5odKdQrjJNsCOrR+skx54XAmT05WYdPjBvYyeZL8tTMh1Y0EuNN+
	P/wy1dBMYml8yPWNjJnIcnmGplJDlvRgkL1ktWbx8rFwMz3PQr8krZ5OOulNH4gWyehxmC
	+U77nYsRxxR3gS4hIXP9awXfn5cL7p+SO1j751W+DsclOWD1BS65gbqXckyUjg==
Message-ID: <c74cab94119bd6ba6b67dc75631dae56600429e7.camel@ew.tq-group.com>
Subject: Re: [PATCH 5/5] ARM: dts: imx6qdl: Rename USB hub node name
From: "Niebel, Markus" <Markus.Niebel@ew.tq-group.com>
Reply-To: Markus.Niebel@ew.tq-group.com
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,  Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux@ew.tq-group.com, Alexander Stein <alexander.stein@ew.tq-group.com>
Date: Mon, 12 Aug 2024 17:13:07 +0200
In-Reply-To: <20240812143431.98323-6-Markus.Niebel@ew.tq-group.com>
References: <20240812143431.98323-1-Markus.Niebel@ew.tq-group.com>
	 <20240812143431.98323-6-Markus.Niebel@ew.tq-group.com>
Organization: TQ-Systems GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 2024-08-12 at 16:34 +0200, Markus Niebel wrote:
> From: Alexander Stein <alexander.stein@ew.tq-group.com>
>=20
> According to microchip,usb2514.yaml the node name shall be usb-hub.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>=20

Sorry, i forgot my Signed-off-by. Will resend if needed

> ---
Best regards,
Markus

