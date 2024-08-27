Return-Path: <linux-kernel+bounces-303963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D959617B4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 21:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3C3D284461
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCE11D2F59;
	Tue, 27 Aug 2024 19:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E77juzqs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A551A01C8
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 19:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724785597; cv=none; b=SsIJO5Hk/AQ1NkfbA5hYzh1iLEMJWB3CzzKgkYBO2VSLlHype98YngNK28KZuriajFHl8xZbHstHrZmkFepGnEfgTYYhhxuzk9PiKxlB+CXljH+So7J6D0LoOj2NOxQ3APZK7r2gjtqnfcrzjUF0yA44RzA2WtQJpndRjsbeoY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724785597; c=relaxed/simple;
	bh=GjwL/TztTTTJZS7egkf+4b2C1QhowBjdFFPiIAq5wEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3uvf7NcbuZoUuzme7cmlybfce1zwMCiae63KTAKP1NVYZ24jJBDsSauKtKbnv2N33fsbAEuDxq+V84XP4Ps66pEZ89c62MIEy3wO11VTRwCk5Pnnbrc3vqVwyGawtINqN6GSIHIIZLvHTYvVioG/hfdHEgc6dom+R0tAdPtfrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E77juzqs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29462C4AF1C;
	Tue, 27 Aug 2024 19:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724785596;
	bh=GjwL/TztTTTJZS7egkf+4b2C1QhowBjdFFPiIAq5wEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E77juzqsKJVRDrgt8clNMouCxiWITMIfP+9wjFM3yT/dqEQGqcKgPIP/gqaGSHZuQ
	 RLZW2R1EQZ3tRZ0VQRWsbo4fzwIkVCyZY8H3YlY5sAXTMfoIBf8FiUHcg0+sIbzuCi
	 EGcg+pGlAo1Ai9QwoLoJdutsQ68GXJ4TG+Z7B1VFnjXcg5515EsTe9nstEQ2NIE7qa
	 G5g6cPJzGd5IMhohQ/lDj0oYhaK74EV1eMHxcKtC3FOTjIF11LkLGBZk0N/ibsEMN1
	 YBSP8H5vNy3sce6RnOvYjAHxEgBwqiPJQcpKm6eLzCmz5SDgiyzGthunILJLIbhGAc
	 6NoawmWwD2K/A==
Date: Tue, 27 Aug 2024 13:06:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Georg Gottleuber <ggo@tuxedocomputers.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme-pci: Add sleep quirk for Samsung 990 Evo
Message-ID: <Zs4juYi-kkO9_NAy@kbusch-mbp.dhcp.thefacebook.com>
References: <20240827104134.11697-1-wse@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827104134.11697-1-wse@tuxedocomputers.com>

On Tue, Aug 27, 2024 at 12:41:33PM +0200, Werner Sembach wrote:
> From: Georg Gottleuber <ggo@tuxedocomputers.com>
> 
> On some TUXEDO platforms, a Samsung 990 Evo NVMe leads to a high
> power consumption in s2idle sleep (2-3 watts).
> 
> This patch applies 'Force No Simple Suspend' quirk to achieve a
> sleep with a lower power consumption, typically around 0.5 watts.

Thanks, queued up for nvme-6.11.

