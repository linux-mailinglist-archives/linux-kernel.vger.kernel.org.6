Return-Path: <linux-kernel+bounces-430212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78279E2E40
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D433B28D2F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9004204F89;
	Tue,  3 Dec 2024 21:20:14 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6217F1D7E21
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 21:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733260814; cv=none; b=lxx6rat1uNYdv1Axu9EgTwwSyLSIV46Q+Pk1Jxgi3CJFHEO+YSPpURZdj+vKe//PcY6w1HEkoeYdHH7g9f1IlrS0HrYb/tilKjmowefR0sus5/+GmVg4ar6UuroHw7D3cvAH4yKRUtCBhIVgW0HnO2Gk6s5fu0CFeWUUrTTD0Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733260814; c=relaxed/simple;
	bh=FJhwudT54Ai6NTPLTGj42Eq6yg+Kq1QI4Bi8QCJzTGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xs0zdrEs8Gi5E+s3Tr1zF+bkAaGhrodtguUTVQHpFOjmCe1QnK2I1stQl9KnQEyQ0naBVl47HXNHz3ehT1cTnzBhi1bfNW74FlCP1ux8qjCJTwGcMqzNo9DEn+KssfVG9+M8kEniwyg43iJKYNFi2it70/Wf+eU/CaAvoweMc+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC51C4CECF;
	Tue,  3 Dec 2024 21:20:12 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: will@kernel.org,
	baruch@tkos.co.il,
	ptesarik@suse.com,
	hch@lst.de,
	Yang Shi <yang@os.amperecomputing.com>
Cc: jiangyutang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: fix zone_dma_limit calculation
Date: Tue,  3 Dec 2024 21:20:10 +0000
Message-Id: <173326077457.517002.14427872059455527771.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241125171650.77424-1-yang@os.amperecomputing.com>
References: <20241125171650.77424-1-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 25 Nov 2024 09:16:50 -0800, Yang Shi wrote:
> The commit ba0fb44aed47 ("dma-mapping: replace zone_dma_bits by
> zone_dma_limit") changed how zone_dma_limit was calculated.  Now it
> returns the memsize limit in IORT or device tree instead of U32_MAX if
> the memsize limit is greater than U32_MAX.
> 
> This resulted in DMA allocations may use GFP_DMA even though the devices
> don't require it.  It caused regression on our two sockets systems due
> to excessive remote memory access.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: mm: fix zone_dma_limit calculation
      https://git.kernel.org/arm64/c/56a708742a8b

-- 
Catalin


