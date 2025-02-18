Return-Path: <linux-kernel+bounces-519024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7712CA3973B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90AF63A73AC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF082309B5;
	Tue, 18 Feb 2025 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dkhD9sbM"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD18C22FDE0
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739871063; cv=none; b=CVWaB5PdVmHtFSA30GpxIEtO3PVan6GHeuRSrr7a2+on4kaJPpDjO5BCuD/DphCQ/cSqpH2tpTGf+n47F+TdmwNkONgF0lp+xS5bLksD51hVUCRjvTRl2V/BE7E/BVvha2LPyHHNrUETaDhaDnyQhR5QfZEt/4SeXeuaYs+ld4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739871063; c=relaxed/simple;
	bh=gdM5DQcxZBS/e8r37Ipv9sL8iSC/Cab8RRfz0hlJYAY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Gxw/B5icEnWSeUkZuUEpAoZw9w9TiatDOEHmmS+FleXLXvxgOHtvwd11kBBEBNRUAw0O112auuT7zY2sldK4qQe40QsU2AcGnjE6HBlXpW/Am5bNkTcAQGtiCnz6uEv2bmE9fZpMaUSuvYFXnhijRRPKCF2lRtE7J7m9vOpTvwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dkhD9sbM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739871060;
	bh=gdM5DQcxZBS/e8r37Ipv9sL8iSC/Cab8RRfz0hlJYAY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dkhD9sbMIGpKOvtK1xiPaRYQQPKmOIj1E8sweMdEoEgwWkrGCtXDBDXUrR//2WNbM
	 0hTENgdFwnXyj+N3ShBPi+KjWrLpo9MmMzOUBZV36NH7PYaX5bWIBL9WPn/PRdMsrx
	 x4AjWsbD54frLEFmDNM8jjWCFIVN9BQm4AakKVRa7Hb8WScedjh8oHjFWLBGf/fzs6
	 ZcJwIyQfiqC34Mh4PfKbTYwdmXZ8GSH6pcrE9Pk0Jh/Plbx3puKKsp6E0k9XeTP2Me
	 Y/2/V/K1WiKdsDdl5A7ioXbfNqEuuMEe3ijyBMXr/CSssfXrHcB6Mo57crE072bnw9
	 2fFkNEwGRrbkw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B758B17E0391;
	Tue, 18 Feb 2025 10:30:59 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, kernel@collabora.com
In-Reply-To: <20250113-mtk-socinfo_genio-510-700-v1-0-cf5112b325b7@collabora.com>
References: <20250113-mtk-socinfo_genio-510-700-v1-0-cf5112b325b7@collabora.com>
Subject: Re: [PATCH 0/2] Add entries for Mediatek MT8370 and MT8390 SoC in
 mtk-socinfo
Message-Id: <173987105966.25011.5338688567610435549.b4-ty@collabora.com>
Date: Tue, 18 Feb 2025 10:30:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Mon, 13 Jan 2025 17:13:22 +0100, Louis-Alexis Eyraud wrote:
> This patchset adds two new entries in the mtk-socinfo driver:
> - MT8370AV/AZA (also known as Genio 510)
> - MT8390AV/AZA (also known as Genio 700)
> 
> 

Applied to v6.14-next/soc, thanks!

[1/2] soc: mediatek: mtk-socinfo: Add entry for MT8370AV/AZA Genio 510
      commit: ef09daffcb9b40277de6738941b1812454fbfd74
[2/2] soc: mediatek: mtk-socinfo: Add entry for MT8390AV/AZA Genio 700
      commit: 6b4506d01ad5db5a157ec34a9f3e0a07d6efe578

Cheers,
Angelo



