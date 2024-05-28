Return-Path: <linux-kernel+bounces-192307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D941D8D1B54
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6AA285ED7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42D916D9A0;
	Tue, 28 May 2024 12:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qF6ynVJi"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EF91649C8;
	Tue, 28 May 2024 12:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716899471; cv=none; b=Zs+81Ae0xihOQbDqIdUtedBy6Kh2gAgqPBT62cJLtXseaMNpT6+jT6e+ROq+ePT+jCi+TLcnO51FsxKxpEzbtgpI+G3m1IxEnMZuWFXDwv3Xx/nYbUxlFQxevYBZb8PD5YuUdCxbke3J2UpJ1RR4hRJjoHEeBRNTp3nP8yzDVU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716899471; c=relaxed/simple;
	bh=sJ75o7q+Vvw53wXJXSQIT76PzPSdbgg2hAVbYs9/+QU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alA+R8zhPBiemGV88vAxvVIGy72LQcV5w7f11wuwI/GIlzsuVjnm81g4BAxMa3urWcdAnXH0xmyDNMO2TZn5+i7eArA38BqqRWCuOxRGgMAlJlM+sI1xrtX5JqwYeFjAglFZMV9R0hC89yr5TNmQGXNT4ZiEO18UpwInj1Za4zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qF6ynVJi; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44SCUx1I049533;
	Tue, 28 May 2024 07:30:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716899459;
	bh=0iYOqeSa87PT/VXHK/lmU7AodbYrFoOR/f2PAb1a6LM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=qF6ynVJinn9pBCXna10rNHF3hddymcjgAIvd5/sTlbT8u3huZh+ACFja8oITlYRHu
	 +m2JwvguKZ+9r9t42+AHyNgUqnmrVMc2wst7IcL7QvPUqm94mVCs181Nr8Iy3Jk93q
	 0UQTWOilnak3TeQqpvDWb9yw5ykMLBSXJi/Gt+Tw=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44SCUxQm031501
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 28 May 2024 07:30:59 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 07:30:58 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 07:30:58 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44SCUvVb033766;
	Tue, 28 May 2024 07:30:58 -0500
Date: Tue, 28 May 2024 18:00:57 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <afd@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>
Subject: Re: [PATCH v3 1/7] arm64: dts: ti: k3-j722s-main: Add support for
 SERDES0
Message-ID: <899cefa7-73e4-402a-a814-1eb7c1e9c7ad@ti.com>
References: <20240524090514.152727-1-s-vadapalli@ti.com>
 <20240524090514.152727-2-s-vadapalli@ti.com>
 <4774e4c9-55f5-4ce9-9433-86f9ae1bc610@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4774e4c9-55f5-4ce9-9433-86f9ae1bc610@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Tue, May 28, 2024 at 03:09:41PM +0300, Roger Quadros wrote:
> 
> 
> On 24/05/2024 12:05, Siddharth Vadapalli wrote:
> > From: Ravi Gunasekaran <r-gunasekaran@ti.com>
> > 
> > AM62P's DT source files are reused for J722S inorder to
> 
> inorder/in order

Will fix in v4.

Regards,
Siddharth.

