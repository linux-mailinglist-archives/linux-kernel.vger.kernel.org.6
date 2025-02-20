Return-Path: <linux-kernel+bounces-524376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC6EA3E277
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C52843B65B7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4568E20DD47;
	Thu, 20 Feb 2025 17:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmNt2Hr6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D6A1C0DED
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072197; cv=none; b=tHjayIzzl/ubZdzso5+4mHfgK14kUbCMPrX++yV2BVUgAxj1CzrDPq5En8vH0j+Ona9OJfF1R5iYEn35wfzs1Lvv6u0OslsQQ/Qx1NUTX6w6uwK5xCgzFwkr6RyxVo7fKayhVTdsqieIyI29hZsr4kgstDOTlD1WdIf/HcoCBZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072197; c=relaxed/simple;
	bh=jU0y90Jx2vJo4YxiWr/ZSTzpxkqae/0MM0PkLDWoPho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaBzhO+FJsrl0ZBV8FKOy5hmqBGYd9kElQZ4P00XR717LPzLP2XPKtMW77ywVKJDJ4modU55TOZszXUjJNsAE5qDtTbhAs+Rbmb1TaZkzkdMCKCaCYcmZ80B9fK5aVetK8uSF1tqR6HDzuvT3gx4p719Lyz4PrHW+f/aUv9vjq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmNt2Hr6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1C9C4CED1;
	Thu, 20 Feb 2025 17:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740072197;
	bh=jU0y90Jx2vJo4YxiWr/ZSTzpxkqae/0MM0PkLDWoPho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AmNt2Hr6fYQuZcTQqakiFecbm3l0lopndbswp4ki5JUwKf+onb3o21qZGSl52urNk
	 rx7Rvk2af5dlaZ+Pa9b+Uc1vQMpzhs0LfqUof+BogwIZJ2v7fXrN5yTD02BbpIcr4W
	 4nWOyWQE232XH5GjGJVB8bCP2inFK+FX/H1t9JnGmFU6jQRcMC7LXNBDEn45LX9g22
	 cVUmA2y4Tv8enzZaRCUKhVnc3QxiFaA4xDbEB1jlZ7zWEKYMnXPMtDdnLmLyFXm0nz
	 vV5RiEuvdclSFn+w8KEjowGiKCAhDZEd1DLf6CSZVOG2VqxY/amef8TEDYgWFTycOF
	 ULU8EhLWtHEjQ==
Date: Thu, 20 Feb 2025 10:23:14 -0700
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] nvme-fc: fix schedule in atomic context
Message-ID: <Z7dlAjUXh2XU0HWw@kbusch-mbp>
References: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>

On Fri, Feb 14, 2025 at 09:02:02AM +0100, Daniel Wagner wrote:
> Shinichiro reported [1] the recent change in the nvme-fc setup path [2]
> introduced a bug. I didn't spot the schedule call in
> nvme_change_ctrl_state.

Thanks, applied to nvme-6.14.

