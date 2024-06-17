Return-Path: <linux-kernel+bounces-217005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A74D90A995
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2DA1C21BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F1A1940A9;
	Mon, 17 Jun 2024 09:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="NsRKd4Y5"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBD519148E;
	Mon, 17 Jun 2024 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718616617; cv=none; b=Hs7UhcJlVyv61qMjJlHmErFa26P9P0AatWXDhU3ruo0EIMvrJUQgIhJPQMK9+cIYHARwX5+08+yMPNy2k+rgjVq94eUl8uF6hG//SdblPn5B7DiDGX7BIBVEjEGiyF9czQ4fTLVR228/7RPzZmVJpfDG1mTPO9cssUThGif6/M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718616617; c=relaxed/simple;
	bh=UVZVJHqKyxefE2x0YQ4CWZUo/PW0cgeri4NNWXPqPJM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XoR43V9xIG+LYVqxAPhoIcoC+TJ79reQCf0h9JgK5vdeGPfzQXisGT8MghijUljuz67Fhcn32WyvSlxhsyuyMjd0qEC8IBE7RVTdj6K8rEkho8YJGmQJ4XR3MqwmwHLwuxycJk1/A6WXXewh9Ycv/jPp2Jix/6XhvsYqi5Q38eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=NsRKd4Y5; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45H8OJYu017972;
	Mon, 17 Jun 2024 11:30:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	aF0JQQPrdJCOmYR/NHbXY7BM1NJtIHpyzX7cqy8Of+E=; b=NsRKd4Y5ROqmyxX0
	/bsiKXf8LJH97VOpLG2bH94lpYrtVFbXTPuESqvJ6VsZGCjPgAZJspasM2ZfYszz
	fxG2tPxM8IYah4r2XQj31JJ4xWO+aP8FTUSmwPRAsciYdndVQ0+RnNAfQ6zblauB
	Ol1iJJ7TKPCrOyphV7NEogHEacVYLVYK74jooiuY8ZkYTSgvr0OBwBiz9mn6ZnqL
	uX8urQIiTR6t/eZRCoirRJIoFzT29YxdTyhaz+ZrqjKlzw/PLMuhHmMEhgsO+pCQ
	RPbQGEGfXzBd5+RhGX1U69GccG7Vq7chQhY8ke7YztWbYCPbdtRUm3oow6Cgv4D3
	QU/d7g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ys1ucnkca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 11:30:07 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 91E6940046;
	Mon, 17 Jun 2024 11:29:48 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CC69421197B;
	Mon, 17 Jun 2024 11:28:39 +0200 (CEST)
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 17 Jun
 2024 11:28:39 +0200
Received: from SHFDAG1NODE1.st.com ([fe80::b848:dbeb:cd0:84a0]) by
 SHFDAG1NODE1.st.com ([fe80::b848:dbeb:cd0:84a0%13]) with mapi id
 15.01.2507.035; Mon, 17 Jun 2024 11:28:39 +0200
From: Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
To: Conor Dooley <conor@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring
	<robh@kernel.org>, Lee Jones <lee@kernel.org>,
        Pascal PAILLET-LME
	<p.paillet@st.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] dt-bindings: mfd: dual licensing for st,stpmic1 bindings
Thread-Topic: [PATCH] dt-bindings: mfd: dual licensing for st,stpmic1 bindings
Thread-Index: AQHavnBANREaHm5dr0++I2dfU9ynK7HInNMAgAMW9as=
Date: Mon, 17 Jun 2024 09:28:39 +0000
Message-ID: <c32960d239dd4a1d94b3253e66bf276b@foss.st.com>
References: <20240614153346.2656871-1-etienne.carriere@foss.st.com>,<20240615-booted-spoon-f538994dec8f@spud>
In-Reply-To: <20240615-booted-spoon-f538994dec8f@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_08,2024-06-14_03,2024-05-17_01

Hello Conor,

(re-sent to to right patchset thread, my apologies)

>
> From: Conor Dooley <conor@kernel.org>
> Sent: Saturday, June 15, 2024 2:14 PM
>
> On Fri, Jun 14, 2024 at 05:33:46PM +0200, Etienne Carriere wrote:
> > Change include/dt-bindings/mfd/st,stpmic1.h license model from GPLv2.0
> > only to dual GPLv2.0 or BSD-3-Clause. I have every legitimacy to reques=
t
> > this change on behalf of STMicroelectronics. This change clarifies that
> > this DT binding header file can be shared with software components as
> > bootloaders and OSes that are not published under GPLv2 terms.
> >
> > In CC are all the contributors to this header file.
> >
> > Cc: Pascal Paillet <p.paillet@st.com>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Rob Herring <robh@kernel.org>
> > Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
> > ---
> >  include/dt-bindings/mfd/st,stpmic1.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/dt-bindings/mfd/st,stpmic1.h b/include/dt-bindings=
/mfd/st,stpmic1.h
> > index 321cd08797d9..957c48300cd4 100644
> > --- a/include/dt-bindings/mfd/st,stpmic1.h
> > +++ b/include/dt-bindings/mfd/st,stpmic1.h
> > @@ -1,4 +1,4 @@
> > -/* SPDX-License-Identifier: GPL-2.0 */
> > +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
>
> The usual dual license for bindings is BSD-2-Clause, was there a
> specific request for the 3 version?

My mistake. Thanks for spotting that.
I have my company agreement for the 2 dual models: "OR BSD-2-Clause" and "O=
R BSD-3-Clause".
We expect to conform to DT bindings preferred licensing model. Indeed the k=
ernel documentation explicitly mention "GPL-2.0-only OR BSD-2-Clause".
We prefer to conform with it. I'll update my patch.

By the way, I'll fix Lee Jones e-mail address that is deprecated.

(fyi: I've sent PATCH v2: https://lore.kernel.org/lkml/20240617092016.29580=
46-1-etienne.carriere@foss.st.com/)

BR,
Etienne


>
> >  /*
> >   * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
> >   * Author: Philippe Peurichard <philippe.peurichard@st.com>,
> > --
> > 2.25.1
> >
>=

