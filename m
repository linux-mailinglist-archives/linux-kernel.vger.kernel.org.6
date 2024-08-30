Return-Path: <linux-kernel+bounces-309347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C00B966935
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F0731C23715
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017B71BC9F6;
	Fri, 30 Aug 2024 18:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="S2iJPtbD"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7088314F135;
	Fri, 30 Aug 2024 18:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725044155; cv=none; b=t4LbpIEEZWkpzP/7sVupBc3gzN2oWfbPDYrf4SuYJBLKyjRCZHIRjO0wBm/OUMN6oOHj9bejGK2yIBBC/eacQX1yAPZKjwwWFtgrf5OD1N+roGdmI6/nsNyl7dX7YiB0ihp6dCHRg49L1ZUMBIhJ8cHS9xykZHQO6c24292NuY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725044155; c=relaxed/simple;
	bh=IHK+Ntd8fM5v8Ld8ghChA+2WvtW78d2VyJV67u5VSsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTeI8PLhMn1BLaW+nzqDy6KVcK+21BAj+AZH5HVLc6ymXQw+KX8gLOzrrJ++5uUE5O2pbc1UTyPqz4jmBzfpcHctgtae2PUmbN31+rlFAC4UKC4QldjlKcotFuaV9nqxs80ub9/1vmq/BiB7BlJwaQAGBEwhxtjtMrj7BYbh3TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=S2iJPtbD; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725044151;
	bh=IHK+Ntd8fM5v8Ld8ghChA+2WvtW78d2VyJV67u5VSsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S2iJPtbDNO7YHcg1+4daBeQVQMv0AHjjYygS1s7EJCHZP8HXJy9iWQzl+gl/7ICmP
	 ZCx4p66CN5fsbWJ6ga4UV42jcVG9s7mym1irLmgg2f9Hu0uywysYwiemK93yXuHq8J
	 njuK0n/zdgQWbBr0EBXW6F8h0AB5ALMltYrbOFBcWzojfwgtldTmf79tzj4alBJ9DB
	 t/Q2XYxBg6gALtFnmw7PlotW3LuKXQ68LhHncJk12IpuUgUOpxMEXZ9KYR4VhZRRuN
	 vb0mtQgFZgTupyBz3pvIwMp0UWlKlJyOQjqNQqHECLbfjOBvkLxpqp71rafgpvzwTC
	 MsXkvd7Il56MQ==
Received: from notapiano (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4A06E17E10DB;
	Fri, 30 Aug 2024 20:55:49 +0200 (CEST)
Date: Fri, 30 Aug 2024 14:55:47 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Rohit Agarwal <rohiagar@chromium.org>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
	daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, ck.hu@mediatek.com,
	jitao.shi@mediatek.com, dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/3] arm64: dts: mediatek: mt8186: Add svs node
Message-ID: <ccc4f1cd-c57c-417b-8f34-6b1e45cec6e2@notapiano>
References: <20240830084544.2898512-1-rohiagar@chromium.org>
 <20240830084544.2898512-4-rohiagar@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240830084544.2898512-4-rohiagar@chromium.org>

On Fri, Aug 30, 2024 at 08:45:44AM +0000, Rohit Agarwal wrote:
> Add clock/irq/efuse setting in svs nodes for mt8186 SoC.
> 
> Signed-off-by: Rohit Agarwal <rohiagar@chromium.org>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Although FWIW the SVS driver fails to probe as is, as for MT8186 it expects
"cpu-big", "cpu-little" and "cci" thermal zones, which are not present in DT
currently. The first two seem to be a matter of renaming (eg there's cpu-little0
and cpu-little1), while cci is completely missing in DT.

Thanks,
Nícolas

