Return-Path: <linux-kernel+bounces-540488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1032EA4B144
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 12:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BEFC1891503
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 11:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676D21DB546;
	Sun,  2 Mar 2025 11:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQTkyj6A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF94623F362;
	Sun,  2 Mar 2025 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740916165; cv=none; b=syIhjAoWZ8W+XWmSkF5DUMAtcuzjjWIKuzJib2peodtuqy9s3q7SPIqtCdwh1UGRddh1Ch9/1lgDnLbG9JWo8c3ibLKWC9A22SlxraPXxjEvkv+Ta+i0aD6aUx/pnUS8JuEhVf4fRsIv8v6j1CshRNC8kYKV84+i1lD2r1pf4YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740916165; c=relaxed/simple;
	bh=tOA7UkWgE/HpLjkfMK/pcYmUp71y+y7mDNeweYm+vKg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bsIlP0X4gdD5RF5gCwPfzmQTkn5ElZPcYetNtSvGXB+ZHXdUEz29Ua/PguhezkGjR7WcAIXNF70do+C4EM1xCoV3nnpUvGPkcmQOK2j83+Dvu9P7rOqd2i8o37Zck2OrfkBTThL42u21xJJVkZLLeFRhyx+2BnGNpY8BZ5sQs1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQTkyj6A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF463C4CED6;
	Sun,  2 Mar 2025 11:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740916165;
	bh=tOA7UkWgE/HpLjkfMK/pcYmUp71y+y7mDNeweYm+vKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aQTkyj6ApngetJe5LWg7XIf6EFrlLzQSDJ4a1HvAA+RJt+tGBx89cvyke7bNdbu06
	 VkiiNvzvZTQMZYNFix4KBG72G5yQZYryeOjzMrVMSUbETMfgeEMDyin3DrHWYxxGnV
	 +2cW1tNAqVvZiGSelJcP02/5syTxSdqy0holXJvDc/HnF3ZkkYMLJ3EzIHtcjh3nhS
	 02VhWwvUIE5IB8nsx8u66exihT0D/T7gdcJgaeeaAdjI61j5jnBfqL6a4SzoEhgXHU
	 k3mrhXYy+MDnvdlUDafCesGUPhuqd6jfQYZL/xYQQjDEXCJAKRgu+MKqf29f1yaM4y
	 lPx1jZ8QqgQUw==
Date: Sun, 2 Mar 2025 11:49:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v3 05/15] iio: accel: adxl345: move INT enable to regmap
 cache
Message-ID: <20250302114913.21f2a92c@jic23-huawei>
In-Reply-To: <20250220104234.40958-6-l.rubusch@gmail.com>
References: <20250220104234.40958-1-l.rubusch@gmail.com>
	<20250220104234.40958-6-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 10:42:24 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Replace the interrupt enable member variable to the regmap cache. This
> makes the function set_interrupts() obsolete. The interrupt enable
> register is written when the driver is probed. Thus it is perfectly
> cacheable.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Applied.

