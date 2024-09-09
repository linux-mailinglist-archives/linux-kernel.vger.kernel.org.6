Return-Path: <linux-kernel+bounces-321542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FC5971BD9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552CA1F2239B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6FD1BA29E;
	Mon,  9 Sep 2024 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVDzIztp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9FF1BA26E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889937; cv=none; b=R/XSRxtSMa9J9sLJ2CBXgJdHqsRmGXV1VAbkzlW6Lbk2Kt2AThqC9Moi+Udgbv5e0hKs+8p247tSpae1Ygtt5BJFvEfae6BwTM8+tl5h58cSdVA2pids9oeHJoSv07Oao2Wh41wS9QpZQzWpFLd9GAtENsoz8UAW4lp1EYjI2Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889937; c=relaxed/simple;
	bh=6I0KDNkGMAXRNHGe9spyVHeJ5YDo7zX/iCZiLN03fbI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MfXgRqoC5lNF08x/ZARgPv7FiT0NKpqSFtObBCmy2ImiIf7Iil5m1CYTCTMv2cezhHcG0azD40xCbJE+sQMEjTIH7ia1z4iuk9xNO5ZtOHZ+LZbzYdjdKrSd/ZTu/+5po0nytUCTDQPcY9K5F0a1weil4Dju/Sct3ZyE6+uUT4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVDzIztp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06675C4CEC5;
	Mon,  9 Sep 2024 13:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725889936;
	bh=6I0KDNkGMAXRNHGe9spyVHeJ5YDo7zX/iCZiLN03fbI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AVDzIztp30tX+CaV0suKoMd8+sXQnTK94H3BXn+ALOKyWs8nsVxyv5XbjjxUpUZH4
	 yh8VaF9qqeK6lP3BG1SfHZpirlzbh+Kx34ESq6heOBoKE3EnJWeJ/Ya6Wj+nonpx/a
	 uqPF+GOQ1CN98/kQp00XDRNvG7d1IceJyuC9594sb5JnR80WQQvXXvUBcakj2BfPw/
	 CJrGSCIg7Fn+qNZ21+cZbjFuA+poEQw9GUI108tKrmyWQa3wRqVdSdRWEzBZmrqkoB
	 A+Qc3ZVcXdDaThNsaISGrmzoWR/2a/2/SZLKDi6T7s/5jwNZRvff2QixUYKDFC7wGi
	 2APfD1WLFcrbQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Michael Walle
 <mwalle@kernel.org>,  Pratyush Yadav <pratyush@kernel.org>,  Richard
 Weinberger <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,
  Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,  Jon Hunter
 <jonathanh@nvidia.com>
Subject: Re: [PATCH] mtd: spi-nor: fix flash probing
In-Reply-To: <20240909104753.0ce41fb8@xps-13> (Miquel Raynal's message of
	"Mon, 9 Sep 2024 10:47:53 +0200")
References: <20240909072854.812206-1-mwalle@kernel.org>
	<ad9ee29c-b96a-4861-a7cd-b8649a3d1f3a@linaro.org>
	<20240909095247.48358afa@xps-13>
	<b2d0ce1d-fa46-43e9-bb29-c98d1161aae7@linaro.org>
	<20240909104753.0ce41fb8@xps-13>
Date: Mon, 09 Sep 2024 15:52:13 +0200
Message-ID: <mafs0y141exyq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 09 2024, Miquel Raynal wrote:

> Hi Tudor,
>
>> >>> Fixes: 2095e7da8049 ("mtd: spi-nor: spansion: Add support for S28HS256T")
>> >>> Reported-by: Jon Hunter <jonathanh@nvidia.com>
>> >>> Closes: https://lore.kernel.org/r/66c8ebb0-1324-4ad9-9926-8d4eb7e1e63a@nvidia.com/
>> >>> Tested-by: Jon Hunter <jonathanh@nvidia.com>
>> >>> Signed-off-by: Michael Walle <mwalle@kernel.org>    
>> >>
>> >> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>  
>> > 
>> > This patch will only apply on top of spi-nor/next. It would spend more
>> > time in -next if one of you applied it to this branch before sending
>> > the MR?
>> >   
>> 
>> The patch is intended for spi-nor/next indeed, as the blamed commit was
>> just recently queued. No need to take it through mtd/fixes. Pratyush
>> will take it via spi-nor/next.

Right.

I have applied this to spi-nor/next. I plan to send the pull request by
Wednesday/Thursday so it should get at least a couple days of testing in
linux-next.

>
> Ok perfect, thanks!

-- 
Regards,
Pratyush Yadav

