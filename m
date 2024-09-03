Return-Path: <linux-kernel+bounces-312518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 627869697A7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6A7DB225EF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF161C984E;
	Tue,  3 Sep 2024 08:44:27 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03751B984B;
	Tue,  3 Sep 2024 08:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725353066; cv=none; b=lLntUqtBgybxvkJcPQCQEt0LRt0z5qCfLAMu1po1onPAk7XqNi5pC1JgcdUAUtU/xH1KJWfzbKH82UIi8bZd59Qoiu2sgSSFxV1e9Y3oM28YBXPWzpWLrY9XRg4Nd4Zh29++b467PPZhjDnRTf/mLKN2q7UzZRUYkU2WERSX1fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725353066; c=relaxed/simple;
	bh=c/2X/wcjltZ9G+w1mU8HRZYclrI90PAhceXyxXMB2Eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mgbpDWrzla2OnVnnjcGgWv1X3vCVIJi0SuczEH6TxLQF96sdCdrWNC3OvDTSU9W0c1jIN0VJpA5bs4LoV0Cx4BoKFm/GIRZ9SrX0MywzG8UOdtyI7UmiH3cE/jJmKvOPZUXjkdEf60vibuvYLh3brSa4Owq5N8y2EINpqlthjro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WyfLZ5NCCz9sSC;
	Tue,  3 Sep 2024 10:44:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ei9JIriNpoNU; Tue,  3 Sep 2024 10:44:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WyfLZ4Xrtz9sS7;
	Tue,  3 Sep 2024 10:44:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 85BDC8B76E;
	Tue,  3 Sep 2024 10:44:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 7IFIJofcuulb; Tue,  3 Sep 2024 10:44:22 +0200 (CEST)
Received: from [172.25.230.108] (unknown [172.25.230.108])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 55B0E8B768;
	Tue,  3 Sep 2024 10:44:22 +0200 (CEST)
Message-ID: <7688f95f-3f08-404b-8c01-813ca5e23a3d@csgroup.eu>
Date: Tue, 3 Sep 2024 10:44:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/36] soc: fsl: Add support for QUICC Engine TSA and
 QMC
To: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240808071132.149251-1-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/08/2024 à 09:10, Herve Codina a écrit :
> Hi,
> 
> This series add support for the QUICC Engine (QE) version of TSA and QMC
> components.
> 
> CPM1 version is already supported and, as the QE version of those
> component are pretty similar to the CPM1 version, the series extend
> the already existing drivers to support for the QE version.
> 
> The TSA and QMC components are tightly coupled and so the series
> provides modifications on both components.
> Of course, this series can be split if it is needed. Let me know.
> 
> The series is composed of:
> - Patches 1 and 2: Fixes related to TRNSYNC in the QMC driver
> - Patches 3..6: Fixes of checkpatch detected issues in the TSA driver
> - Patch 7: The QE TSA device-tree binding
> - Patches 8..13: TSA driver preparations for adding support for QE
> - Patches 14 and 15: The support for QE in TSA + MAINTAINERS update
> - Patch 16: A TSA API improvement needed for the QE QMC driver
> - Patch 17: A clarification in the QE QMC driver
> - Patches 18..22: Fixes of checkpatch detected issues in the QMC driver
> - Patch 23: The QE QMC device-tree binding
> - Patches 24..31: QMC driver preparations for adding support for QE
> - Patches 32 and 33: Missing features additions in QE code
> - Patches 34..36: The QMC support for QE in QMC + MAINTAINERS update
> 
> Compared to the previous iteration, this v2 series updates device-tree
> bindings and fixes issues detected by kernel test robots.
> 
> Related to the QE QMC device-tree binding, I kept the unit address in
> decimal and the 3 compatible strings in order to avoid blocking the
> review waiting for a confirmation. Of course, this can be change in a
> next iteration.

Series applied for 6.12

Thanks
Christophe

