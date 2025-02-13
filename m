Return-Path: <linux-kernel+bounces-512185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 910B4A3355D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 03:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40120167D41
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8051482F5;
	Thu, 13 Feb 2025 02:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6f4BGoR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA07778F37
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 02:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739412851; cv=none; b=Fbnd8zFh8diiAowx9wkPnhujUMYHrF8tyHmqCsn8PcvAT7PEnpGa9GQKhmqe843c6KnDR0g05OTO1Z4PhxJ0j1y69LHcnwcVcvBvkkT/OaMb3moKWiXJfSEJYsirAt7+LV6RloNjM1QfmtYevURO73Kf7nkCIm6agzBc6O+2Kko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739412851; c=relaxed/simple;
	bh=ohLSi/xTAB57E3Fe+Ym33qoPhEUA1qI0MT8j52SHnIM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hvcEks92aZEPPnnCp1cLxQJo/oywBFCIlO/l73ZdK0VuVAmHPcv98ltjbZUiJECWI5vMXqoQvk5sh59r/GjaPMor+JeL6+vlKQoiDpyVqI0WSXg27ZZjOyj65HOL5D+Wd7oWRPPb1lrK+LmmFrCFlk6JR2iRPPzaYXkZBX7+eYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6f4BGoR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D1FC4CEDF;
	Thu, 13 Feb 2025 02:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739412851;
	bh=ohLSi/xTAB57E3Fe+Ym33qoPhEUA1qI0MT8j52SHnIM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=O6f4BGoRxNTIhto9J2pYBNgD5ggA8E76VUga00kIRJF+em9Gdf6UPM/0clrlXyNna
	 7iyunY8Wjd+aVzn1FEIWokaGWkaS4Id8JHCWh5lXHx/1RmPkp/ldvXjLgjs/HyrrNZ
	 J+jiyuTLdwEtwxcJ3f0juc/0AcKBlj+AQdhVm8h/yidjPBBYJYZZ9lZdBRRG174Z0f
	 SM1Nl+u6/f//7IdNPQY9CCtcf2TgZZxiqnchWzUB20iNH1U9mGT5zXyQmdF6OGxEPI
	 Br/L1bXbE70qY0agcP97In5XuetUpn8AfH+yACGfXqoWUnSvPoFmPuQtFnHSlKSSAk
	 yc9kKgM9RF1VQ==
Message-ID: <38967011-91d2-44f6-92e8-350dcdbc59c0@kernel.org>
Date: Thu, 13 Feb 2025 10:14:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: keep POSIX_FADV_NOREUSE ranges
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20250212023518.897942-1-jaegeuk@kernel.org>
 <20250212023518.897942-2-jaegeuk@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250212023518.897942-2-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/25 10:31, Jaegeuk Kim via Linux-f2fs-devel wrote:
> This patch records POSIX_FADV_NOREUSE ranges for users to reclaim the caches
> instantly off from LRU.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

