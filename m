Return-Path: <linux-kernel+bounces-562996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 695DAA63583
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 12:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85B991891093
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 11:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18DE1A4F3C;
	Sun, 16 Mar 2025 11:56:43 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7769628E3F;
	Sun, 16 Mar 2025 11:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742126203; cv=none; b=hmQr2rUiR14GwClt/+FeoNz60gq/kxV3v6XxAmUhY9XqjyLpWTbYE89qBvX728KOpoIKVd7LRfbxGaV4bX9LuMN2oqYq9hZSPfhuKpPScrGSQoDMNCThjQiy+SaAoZXTtEY40Cnk1BWVNbDEi/g0spPIPX9OfLYy5mOpRCXzdXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742126203; c=relaxed/simple;
	bh=LPzEn883RcsLOXAzEXVDhgtHrnDVbGsCusS9JX9lHFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jSIMcPGOVW+CYNH1WG9W1kPzKotxD0AtoW6YjUcsOqCod9l2BFGGqwtjH4MdL0nE4dw2eyfnlwlmE21vMVAoFp9nw4tpes09Brzgi0evNbMeHyLDmL+SCLYbma8lYM9IbLxRLJI2iQtEriRHnmG7vxQsAGyCkELHY4G3rlA1+fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6F112442C3;
	Sun, 16 Mar 2025 11:56:30 +0000 (UTC)
Message-ID: <8dea1327-747c-4fb5-b6f1-926c6811365d@ghiti.fr>
Date: Sun, 16 Mar 2025 12:56:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: migrate to the generic rule for built-in DTB
Content-Language: en-US
To: Masahiro Yamada <masahiroy@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org
References: <20241222000836.2578171-1-masahiroy@kernel.org>
 <CAK7LNAQMo0R09OcVw77=dyVnUbMv7gxxejHbr=dy4S-SgPT4-g@mail.gmail.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CAK7LNAQMo0R09OcVw77=dyVnUbMv7gxxejHbr=dy4S-SgPT4-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeeiheegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedtgeeuhffhveeujeetveevieekleekvdffudefleevgefgieekkefggefhtddtveenucfkphepvddttddumeekiedumeeffeekvdemvghfledtmeektdgsfhemhegvleefmeehfegvudemkeekjedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeeffeekvdemvghfledtmeektdgsfhemhegvleefmeehfegvudemkeekjedtpdhhvghloheplgfkrfggieemvddttddumeekiedumeeffeekvdemvghfledtmeektdgsfhemhegvleefmeehfegvudemkeekjedtngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehmrghsrghhihhrohihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghom
 hdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrrdguohholhgvhiesmhhitghrohgthhhiphdrtghomhdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: alex@ghiti.fr

Hi Masahiro,

On 16/03/2025 11:39, Masahiro Yamada wrote:
> On Sun, Dec 22, 2024 at 9:08 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>> Commit 654102df2ac2 ("kbuild: add generic support for built-in boot
>> DTBs") introduced generic support for built-in DTBs.
>>
>> Select GENERIC_BUILTIN_DTB when built-in DTB support is enabled.
>>
>> To keep consistency across architectures, this commit also renames
>> CONFIG_BUILTIN_DTB_SOURCE to CONFIG_BUILTIN_DTB_NAME.
>>
>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>> ---
> Ping?


It is on my list for 6.15 and *should* be merged.

Thanks,

Alex


>
>

