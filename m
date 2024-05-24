Return-Path: <linux-kernel+bounces-188479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8AE8CE27F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11BD51C20B46
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E887E84E03;
	Fri, 24 May 2024 08:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="hMyYGSxi"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EB622331
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716540476; cv=none; b=c/Fz0vYpyAzrCdrCCGkmmTdkXlX+EpEjCcUz0lZP31vbJO79WMunK5fPiAWbSfm5J7QskiDO3ppsjSlN4R0DXVtBAskB6WtCuWfDlk8unY+Of26/KhLVGGaLcaJOpD2YaW/b859avbYnjLJNd75FmwH33bRbKm9VBJRv//5vzys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716540476; c=relaxed/simple;
	bh=NtnvrfQrnbChckPUpoJEclyqdwNU/EzDkgssCHBUtAg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hhihiqdvb9ue2D2t2IR7x/D0OFF1WWVTsOHIJLFvp1eb9HNeXfHa2pNMkm3jMVsq2yXot9qznalvmQKIXp186DhsvoEPWRm7DwgAWuXL7pwTZsuWmhAWdYXe+rap7d8dA2eVei5a7ypjAorUYK6G5bjQoTbR6voMo9zTrj6EOQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=hMyYGSxi; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=+37b90Lx/brt8rw4v1F6llZaQY8yfFwNx63kKufwdlE=; b=hMyYGSxi0p2F+gDPEhOi/EfhDT
	s3Kii6AQ8H54ZZjgdQgtE8OS8NrHwl69Q6Yhwp73bUOgDKRzBX2RFzYGN0jLSXNwwXCn6y1sZ8pLD
	PweQGkRqZix293wWYhSG8NdvfyO83188dNO+PY38VCoqEePIbNF9bNlBeYKNgMEbfuspT9s4wvCJj
	qJlDiC+3nZGL51jOLskf2W7EpEmQvQJWVbOGxRjUsbGKGWCEvbQw0AWKwzldbz8ILP12v+7cJOlIP
	hl5+0ZMsm7a+cHp55dcAQZ1r1YEDchuMDPyUO9aqSTYQm8a7YlnIfDdFRqQl6M0PawfNgjjHqfmf8
	6w9Amslw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sAQac-00028n-3a; Fri, 24 May 2024 10:47:50 +0200
Received: from [80.62.117.110] (helo=localhost)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sAQab-000IJR-2z;
	Fri, 24 May 2024 10:47:49 +0200
From: Esben Haabendal <esben@geanix.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,
  linux-kernel@vger.kernel.org,  linux-mtd@lists.infradead.org
Subject: Re: [PATCH] memory: fsl_ifc: Make FSL_IFC config visible and
 selectable
In-Reply-To: <9a7f73f4-f5dc-4342-855b-08df6a839bb5@kernel.org> (Krzysztof
	Kozlowski's message of "Thu, 23 May 2024 16:36:17 +0200")
References: <20240523-fsl-ifc-config-v1-1-6eff73bdc7e6@geanix.com>
	<979fd913-050b-445d-9ca8-0ec6906ce3ea@kernel.org>
	<87cypc38gu.fsf@geanix.com>
	<9a7f73f4-f5dc-4342-855b-08df6a839bb5@kernel.org>
Date: Fri, 24 May 2024 10:47:48 +0200
Message-ID: <87le3zoatn.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27284/Thu May 23 10:32:30 2024)

Krzysztof Kozlowski <krzk@kernel.org> writes:

> On 23/05/2024 16:32, Esben Haabendal wrote:
>> Krzysztof Kozlowski <krzk@kernel.org> writes:
>> 
>>> On 23/05/2024 15:58, Esben Haabendal wrote:
>>>> While use of fsl_ifc driver with NAND flash is fine, as the fsl_ifc_nand
>>>> driver selects FSL_IFC automatically, we need the option to be selectable
>>>> for platforms using fsl_ifc with NOR flash.
>>>
>>> Which driver is that?
>> 
>> This is drivers/memory/fsl_ifc.o driver. It is for Integrated Flash
>> Controller (IFC) from NXP. It is used in various Layerscape socs.
>
> ? I know that, I mean the NOR flash working here.

Ah, sorry. The NOR flash I am using here is a Spansion S29AL016J.

>>> Which DTS?
>> 
>> It is for "fsl,ifc" compatible devices.
>
> That's not a NOR flash.

Nope.  The binding used for the NOR flash is "cfi-flash".

/Esben

