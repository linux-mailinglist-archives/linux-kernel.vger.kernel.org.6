Return-Path: <linux-kernel+bounces-558238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BA6A5E337
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B67D3B3165
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32B5254B02;
	Wed, 12 Mar 2025 17:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEXS6+/f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E62820ED
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741802272; cv=none; b=f4EjwmGBtHrY0JP4MUHdBU3ynvKj95IUxNFVLSDqKHvVgNRlQRnZrKx4JGAzHFsBiFRs7+wSpSx6H6FMFf9sAjkTWnIwbXgWFmC/19F3P/PBC7VFw3EiS70bY/Tu3ebJq19DBSAkS3IJSJGzqqwx2K1T0TpoZDH0pZbeEOTVchI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741802272; c=relaxed/simple;
	bh=uDUiE+/yp8r2k4rZuqZa/OaVgNzl8I5iP3BEroop3Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8m8oetT4hYfZS9/fZqDhZFmrEu37+D081aoKGzgByVK6r38CLlGc7dEuTi5fRXXjsjIks/DQos2fwrU2ZUjkZTTVSwoILAAhMVxvcuCHsIZW4rI8w0ZD+8lMlPu9vcdFivBegkftg4sMf2dBEJbWv6zRq+CHVoY7rEWIz9J4eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEXS6+/f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA1DC4CEDD;
	Wed, 12 Mar 2025 17:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741802271;
	bh=uDUiE+/yp8r2k4rZuqZa/OaVgNzl8I5iP3BEroop3Uk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WEXS6+/f9QzmcumVO2J/iKyttAupTIFwPauJ+sQ78K9XxXXooMpY4CMKgndSlygvn
	 fR2SnRCvRiGTTvJ19NS7H7RZajnPwAfNTx1fuSVFqC/lhuzr+avZxwgjoKBSlOZE3W
	 3pLB/SjdbGq/GSllSewVdLlzzQdwtArBvCLMZi2+mLAgseKD/NIpno79F/Bu6lTrRG
	 6rFgV7lvwLFCNBJRaPkMueID/1oZM7weIIHIIiXMoVaNItR15+JrX11pUSzbLsqCZr
	 IlUOhepp/PhgVuznsJi/NMXis2q/GVUJMYofKpbrVO3fE2YdcNc9eZLA2s1UO2E6uM
	 Sd4KpUYE0Ae6w==
Date: Wed, 12 Mar 2025 11:57:48 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: pci-epf: Remove redundant 'flush_workqueue()'
 calls
Message-ID: <Z9HLHHpdbDUgEhb2@kbusch-mbp>
References: <20250312085625.1624394-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312085625.1624394-1-nichen@iscas.ac.cn>

On Wed, Mar 12, 2025 at 04:56:25PM +0800, Chen Ni wrote:
> 'destroy_workqueue()' already drains the queue before destroying it, so
> there is no need to flush it explicitly.
> 
> Remove the redundant 'flush_workqueue()' calls.

Thanks, applied to nvme-6.15.

