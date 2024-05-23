Return-Path: <linux-kernel+bounces-187648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0827A8CD5DA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B403A1F22179
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDBD13C3E7;
	Thu, 23 May 2024 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="w4xREilk"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CE81DDEE
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716474727; cv=none; b=CslzIm4ojm2hElmzkC7M/Cq++quSGQ7laNoowZBKVL9LPQ9mtfq9vFUzFT6GPf1Favt5W3gOJv2/tILrC7hF8AXkZdTF9lpiCjy8khP7sLQAg5ZWHnD45oHs3/txiM+RIa+Ds79EAnQ+QWpewxEovqk756z8PplCRSCfvfwVI+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716474727; c=relaxed/simple;
	bh=BgtQCP6BWnj0hRmGehM9bywN+sdsudwiKyVkchOsOcE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kPAMw+3+Sj/10DYR3qJgr+Q2SIo6NJ/za0IMZHq3cnrmeYbuXfb2dhQV0llT0eAfdzhuVrYzfhYPzg3uf5oRvnx7bLgut35bfw2hN6hl9xi5HroU8dTJmQ+fZAEU+XrXRCeMF9dNF6BLDTCBOS6lgUH8CX7jTJo4Xouk01U+ZYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=w4xREilk; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=BgtQCP6BWnj0hRmGehM9bywN+sdsudwiKyVkchOsOcE=; b=w4xREilkyEQQd0NwD/AflGGIMg
	7OJ6VqBJ01JHn+GLQJXsH9U8HZ1hrOYGWv46vofTf9uYokTE67ZpgU9ASXFsN4MMnUsDuruGp5dCQ
	wcf/gNi/kS3jaoGMbJAsTB55QITEdL703+ck/zu26irY54bst09AR/wF5SULbetN1pyp3ayi8akq+
	BtTSIXUXCNkpsuZQhOb4wp5qN7neMFAVSIZm8jTwS8uWKtjtxq+zuQbx4qJiTfO5YnjsR6Juxp8kn
	fuL0PqIM+ujJ+kCTCYGLcam0t+GfO6nPligH28OmMMCHPFslorQvYcnWjLmvUg7sda/VqLwxP3tFM
	wn4GRwig==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sA9UA-000FCg-Po; Thu, 23 May 2024 16:32:02 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sA9UA-000NG2-27;
	Thu, 23 May 2024 16:32:02 +0200
From: Esben Haabendal <esben@geanix.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,
  linux-kernel@vger.kernel.org,  linux-mtd@lists.infradead.org
Subject: Re: [PATCH] memory: fsl_ifc: Make FSL_IFC config visible and
 selectable
In-Reply-To: <979fd913-050b-445d-9ca8-0ec6906ce3ea@kernel.org> (Krzysztof
	Kozlowski's message of "Thu, 23 May 2024 16:01:49 +0200")
References: <20240523-fsl-ifc-config-v1-1-6eff73bdc7e6@geanix.com>
	<979fd913-050b-445d-9ca8-0ec6906ce3ea@kernel.org>
Date: Thu, 23 May 2024 16:32:01 +0200
Message-ID: <87cypc38gu.fsf@geanix.com>
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

> On 23/05/2024 15:58, Esben Haabendal wrote:
>> While use of fsl_ifc driver with NAND flash is fine, as the fsl_ifc_nand
>> driver selects FSL_IFC automatically, we need the option to be selectable
>> for platforms using fsl_ifc with NOR flash.
>
> Which driver is that?

This is drivers/memory/fsl_ifc.o driver. It is for Integrated Flash
Controller (IFC) from NXP. It is used in various Layerscape socs.

> Which DTS?

It is for "fsl,ifc" compatible devices.

/Esben

