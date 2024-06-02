Return-Path: <linux-kernel+bounces-198426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A848D7810
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 22:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4423B24453
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 20:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F8C86622;
	Sun,  2 Jun 2024 20:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="HcjnBhuB"
Received: from mail-108-mta139.mxroute.com (mail-108-mta139.mxroute.com [136.175.108.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28AD86253
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 20:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717359661; cv=none; b=D50ALhEnE8D5qc/Xg8Er/ivhUPHX68SBVf59U9KWWZPw4uQ/WBSw9J0armsrI21z9eD7LOpecz56wTAsdSPMTpd9dDfFyLRiMhN/qlqzzgy07jTqrR5vvrEj0Lm2P0WR7b5R8U9ZnKM3euJ/AxRC3VFLowTairSd04fGHQGgZ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717359661; c=relaxed/simple;
	bh=/E4N5+Izk3+TZWPd9JNj8m5aCwC/uo+CScFnKhMCbXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zw5+4BKoSa7jce8xUx+KpauOxXo6Wz6aiWpQvgelZoha7XP4ZMvfBDtu8LeTFDXF1+ygHqxPXMlTQV5nged7H5n1AF4CMvV2tHrPufWi5ubUccJsccA8IbC4UJ1njlF4vjaGOz6LYvk+oCtd5N9NlYjZGxApyUCTJj6PEFFVqH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=HcjnBhuB; arc=none smtp.client-ip=136.175.108.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta139.mxroute.com (ZoneMTA) with ESMTPSA id 18fda9c982b000e2b6.011
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 02 Jun 2024 20:20:46 +0000
X-Zone-Loop: a8fb67baca0128d5512df94bcc0be8c3b0654ba7a074
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xESbskVsJ/UekNf8oJ/eOcd17UaEATsi5lYv7WdxMBY=; b=HcjnBhuBLrdRimIXjySjBE/HED
	9cysO7VHcRevplBnbLuJuWBF5EVrxkwTwJu0y7msC8qernHHsJlp/TN3CEUUyQytAYhSzF/42FTsj
	1tknbRGHM1wJPXbuPoQl8QerxaxxMMaXr7epIdA++qYbDqp+q84ptwNAcuE5NcBgssuOVUGOD6PBT
	Ge4Q5GZpj6CPn5JHZWEbo14kLIKnYk/6jVZZTQtUppPV1rWftw05w8M/TEUffcINLVJUTypVq7hm9
	JTI5HADruqwpGVC8XlEl/9GWqq9jlHM86n8G21LoreK9PoYRgPabUAhecpqNFJC3lrxJxoKG8I/+j
	UVhStoDQ==;
Message-ID: <a366a29b-3657-47c3-925c-5dbc6bcdf2e5@luigi311.com>
Date: Sun, 2 Jun 2024 14:20:42 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 21/25] dt-bindings: media: imx258: Add binding for
 powerdown-gpio
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com,
 jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 pavel@ucw.cz, phone-devel@vger.kernel.org, Ondrej Jirman <megi@xff.cz>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240501152442.1072627-1-git@luigi311.com>
 <20240501152442.1072627-22-git@luigi311.com>
 <ZkcV5xWZz2jCszxA@kekkonen.localdomain>
 <ZktHCpsW8SaVdTBk@kekkonen.localdomain>
Content-Language: en-US
From: Luis Garcia <git@luigi311.com>
In-Reply-To: <ZktHCpsW8SaVdTBk@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: git@luigi311.com

On 5/20/24 06:50, Sakari Ailus wrote:
> On Fri, May 17, 2024 at 08:31:35AM +0000, Sakari Ailus wrote:
>> Hi Luis,
>>
>> On Wed, May 01, 2024 at 09:24:38AM -0600, git@luigi311.com wrote:
>>> From: Ondrej Jirman <megi@xff.cz>
>>>
>>> Add powerdown-gpio binding as it is required for some boards.
>>
>> I thought the conclusion was that this wasn't a property of the sensor? If
>> it needs to be controlled, then this should take place somewhere else than
>> in the sensor driver.
> 
> I'll take patches up to the previous and then 24 and 25 from this version.
> The rest will need some rework.
> 

Last time i looked at the comments for these two patch discussion was still
going on so i was submitting fixes for the other patches while this continued.
Looks like the final consensuses is for these two to be dropped so I just
submitted v6 with them both dropped. I also tested it on my PPP and it still
continues to work as expected just like it did before. Take a look at v6 and
let me know what else requires rework on there.

