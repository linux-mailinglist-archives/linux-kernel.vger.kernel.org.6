Return-Path: <linux-kernel+bounces-218983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BE090C861
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB131F21706
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81587158A05;
	Tue, 18 Jun 2024 09:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAfCJI6z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A2518036
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 09:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704017; cv=none; b=VLV+ImVF9odySjBfb4KIn+vADuS1X6Xauwy171yTQjQSjG/8Tnh4ZTsI1NmCHQx2JNH/1o9PNL6AfyhhtYAkRJ5fQ9qw3ph9LBgoJ+oX8d462dMdMOydOSGlLnq2DhXLcT9OhP5tJ6A48qo9MusyjEUJV2pGhGUdUjQUmASzPjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704017; c=relaxed/simple;
	bh=6O3sFl1pZpZZR7SQOG6oCoyieI6o9fo/6vwo1TZ8Wb4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ISwr4iJxP+2Mz3SfVLgQOL0Jyvwt11rnAhpgqtwDGdRNVOJhifjipEzP79zWN1szedReA3X/4yQM3+SSL5i4PuAFdR5wOmsVpufE9UolMCa5FeNm/3xIHQRpLvOCoKcAwKST1RcDbxzbDuqvEVkJaTpfqKOGLXvMQkjoGsMxUD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAfCJI6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E279C3277B;
	Tue, 18 Jun 2024 09:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718704017;
	bh=6O3sFl1pZpZZR7SQOG6oCoyieI6o9fo/6vwo1TZ8Wb4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oAfCJI6zKvN7RB+joh5rZyjUoh4d23/H3rCgGKBpWs4veguDH+mFphpXI7pvF+POm
	 EJDR19dfgBNWF0/2i65g5jVapyL7RV1074+9f9L0cJD3uUVrcnT87z3q5nUgZ7YPxw
	 bfDxqGyN4E9c0GOC9uebMe3zXuD0kYPeUqJj5X/bu5fyt5/UDCj6YofaCgrVS2i8Kl
	 womM3dkhiZl9/LU41MRac6EVfofsTQUicVsKBSup1T0RHBR7Gfhg9T3tFjIZuGqdMW
	 EX/npAuHyM0JkbMMQzyn021AB5dQ6Aw3nL8RnumkxVVZZic4/l6nIoB2UiWG/RBnEz
	 ASW5KyZKgGR7w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Michael Walle <mwalle@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Miquel Raynal <miquel.raynal@bootlin.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mtd: spi-nor: simplify spi_nor_get_flash_info()
In-Reply-To: <20240603134055.1859863-1-mwalle@kernel.org> (Michael Walle's
	message of "Mon, 3 Jun 2024 15:40:55 +0200")
References: <20240603134055.1859863-1-mwalle@kernel.org>
Date: Tue, 18 Jun 2024 11:46:54 +0200
Message-ID: <mafs08qz2fur5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Michael,

On Mon, Jun 03 2024, Michael Walle wrote:

> Rework spi_nor_get_flash_info() to make it look more straight forward
> and esp. don't return early. The latter is a preparation to check for
> deprecated flashes.
>
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

Applied to spi-nor/next. Thanks.

> ---
> v3:
>  - rework the handling quite a bit, thanks Tudor.
>  - drop the spurious comment about the partitions, it goes way back
>    until the initial support. I don't think it's accurate anymore.
>    If the flash has the same size, the partitions can be trusted. If
>    not, anything can happen.. We don't know.
>
> v2/v1:
>  - none, this is a remaining patch of my spring cleanup series.

Do you also plan to re-roll the deprecation patch some time in the
future?

-- 
Regards,
Pratyush Yadav

