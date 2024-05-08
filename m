Return-Path: <linux-kernel+bounces-173384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA888BFFBA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8E91F220E2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC30185293;
	Wed,  8 May 2024 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfK55lXI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C295228;
	Wed,  8 May 2024 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715177354; cv=none; b=Y4lMY81mzoq1zqlS9d+5JbDHWJbNez+aFUxWurRF1JftTT0uHqo/MtqY66g/KoWjarZqkiuGVUKSr+ogKe9K/V+8F9WsqoO1lWnJvsITX7kfI+eTN1JxU7ZiOtJUThdi61EmLReJXuerDIVlfm8KKWajlporz0gH2S+X+42yUUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715177354; c=relaxed/simple;
	bh=VZyUtgn7CSrqZqD2WXaMMzb6R5zKmx5KV+opHAphR2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1jZev/pUNnUbrBWZki8gY6ACd0v3prXb3Q4yzfAZZ1p0mnVXVinzu/UxNHMFl1BeEBAWSB3KA1YBx3AHAJpmLPKW/5ICvgPC5tvI6FoCheRuUh6ZzUwqHsoqXT47fr2tBaWC82vzqVw1WLlYMrfUT3YqV13e6nvKpEsS7C3AY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfK55lXI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E100C113CC;
	Wed,  8 May 2024 14:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715177353;
	bh=VZyUtgn7CSrqZqD2WXaMMzb6R5zKmx5KV+opHAphR2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FfK55lXIxxm/5TEJWNmw3vYYan6hnJpce8FOxpJnul6TMsmsdOk7CmNCaHYXaOobc
	 pa5rpx0Jd0c5mg/SyIYRivD8ofsnFlUBpyE2Va4NH7ZxymuNaGhwpUxSZYfB2RJ7sI
	 KbvYvutvUYdtmv3zLRpKMUjZ1/X17Sm5tqd9VhkCKU0tiUJF6o8N+yIDi1t8q1a48O
	 51vQYjhGDcswN4zd/4iBPrFuD5lQb/DSm0ULYs9ytwRvV1f7S9cAmunIAilmKkYN3s
	 8/aDsad/YDxVTA4PmV5g3jydDY5244NkvnQdQAeWt2kv+k8lGqmPn5/9E5NPaqdong
	 avbGNizqPHUMQ==
Date: Wed, 8 May 2024 09:09:11 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>, devicetree@vger.kernel.org,
	Kevin Hilman <khilman@baylibre.com>, linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, oxffffaa@gmail.com,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-amlogic@lists.infradead.org, kernel@sberdevices.ru,
	Jerome Brunet <jbrunet@baylibre.com>,
	Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v6 1/3] dt-bindings: mtd: amlogic,meson-nand: support
 fields for boot ROM code
Message-ID: <171517732606.1572649.16193191353725811830.robh@kernel.org>
References: <20240507230903.3399594-1-avkrasnov@salutedevices.com>
 <20240507230903.3399594-2-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507230903.3399594-2-avkrasnov@salutedevices.com>


On Wed, 08 May 2024 02:09:01 +0300, Arseniy Krasnov wrote:
> Boot ROM code on Meson requires that some pages on NAND must be written
> in special mode: "short" ECC mode where each block is 384 bytes and
> scrambling mode is on. Such pages are located on the chip in the
> following way (for example):
> 
> [ p0 ][ p1 ][ p2 ][ p3 ][ p4 ][ p5 ][ p6 ][ p7 ] ... [ pN ]
>   ^           ^           ^           ^
> 
> pX is page number "X". "^" means "special" page used by boot ROM - e.g.
> every 2nd page in the range of [0, 7]. Step (2 in example is set by
> 'amlogic,boot-page-step' field. Last page in range (7 in example) is
> set by 'amlogic,boot-pages' field.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>  .../bindings/mtd/amlogic,meson-nand.yaml       | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>




