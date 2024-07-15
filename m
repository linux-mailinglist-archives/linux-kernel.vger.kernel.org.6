Return-Path: <linux-kernel+bounces-253082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9301931C3A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 22:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA3F01C217B4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 20:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF2D13BC31;
	Mon, 15 Jul 2024 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBvrGOt6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF034136E09
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 20:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721076632; cv=none; b=FHFPKkhrwRDvD4gP7c/NRCFOckb8DhA4Stz94Q22w0hhfRTYebDd9+qSzabp+PCIqpT96kft2ciKKgx+lJa1avPUumQXFfrwQy4z3j4W+DR6rzu4sC4hs9atGwsrN5yT/1AdJC0+/MS5gdYVkyGzBKm1IzYeYgGdFZ2RlDI7rB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721076632; c=relaxed/simple;
	bh=0PVm1jzoalcMOTWE6B0y7yqmnfUDCUb+u7ztxv/z/FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCXm9j7kjzSSI2ffrONq+fH6iIusm/3DN0qpsqFemxhjRe58sZsuRg3Q4bq5nF8VpxxlwNQQjeHxljJh+HIuDFbto7ztOq072PRYGLFLzA4UVhepqSw6Sg18mqraOrKTcgLIocAJpYSnO+SMiInYLrdVKb5WaYnityogdOyTpyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBvrGOt6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E2FC4AF0B;
	Mon, 15 Jul 2024 20:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721076631;
	bh=0PVm1jzoalcMOTWE6B0y7yqmnfUDCUb+u7ztxv/z/FQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qBvrGOt6hJFyIMre/LuVsWV6M4MbvZopWto0Y6qS7GXQzMdedkgab50aKCCMpc68F
	 pPbq0y1POGHlk7l3VpMWrQAuIVtet1ILHo5fiPPMe3dZZ3Q07YLIZvOYL9ysBcM4u8
	 vVzMNVdSYCtCQRPgzRxvyX8kkFzrh+5t8rIRD9AUnnjaUtwMP2d6GnQEkjDI1IGtPw
	 kngjA3q3C86qhY6BpoMnK7UESzN10a+mbGopspLZ7DGY0K0sw3a0Lk84EXf2LEA94F
	 nKIqfCdE+IyvDdcEhbaPsGpOkdTzx48H6xW7wDSzyXS+kA92eJfw83wqqZUB72FOP+
	 bbEZ96hsmkGHw==
Date: Mon, 15 Jul 2024 14:50:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me, guanwentao@uniontech.com,
	huanglin@uniontech.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] nvme/pci: Add APST quirk for Lenovo N60z laptop
Message-ID: <ZpWLlOgZ69dmT_-t@kbusch-mbp.dhcp.thefacebook.com>
References: <6CDDDB0BA2EAE00D+20240715093144.1548609-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6CDDDB0BA2EAE00D+20240715093144.1548609-1-wangyuli@uniontech.com>

On Mon, Jul 15, 2024 at 05:31:44PM +0800, WangYuli wrote:
> There is a hardware power-saving problem with the Lenovo N60z
> board. When turn it on and leave it for 10 hours, there is a
> 20% chance that a nvme disk will not wake up until reboot.

Thanks, applied to nvme-6.11.

