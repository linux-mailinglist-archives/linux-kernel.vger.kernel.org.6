Return-Path: <linux-kernel+bounces-237706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73FE923CF5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0419A1C209DC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67CA15B12A;
	Tue,  2 Jul 2024 11:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1uHxzXA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9691DFD8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 11:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719921250; cv=none; b=rG3uIr+zd+7LNvIiXwN9gjymOdGNni/Xpexoyi8Syza1/71sTQlutvodww/LGQRuVzBn2R7+kXphnedZgpnrIOhBQAxxu0fxcxQAkEF+m52l8uuITKJzR23cIkO2KfD4Go29wfIBtrQaKfU1XIn8cjUrXOYjf0WZzuCsmJbCHOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719921250; c=relaxed/simple;
	bh=ty1qZLwFA4LCJPhQ5+oQL+NTqlr44hCXTZWfi9VlxiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PjdewpU4+oGz0hQsXTlirNWcSgkJdIG181MFG2dlG1oR0pwSB+8CDL3ZiCEh8NgcZ7DcBNYD4JtfQTilC3IFXll2d3HcMf9dsbE2Nxu0PGMtnIILR+9SAckZ5PIk2R341aW4jgYrEwbGFmKRlzKJjm0nqW3ddl90CR4mkoGoUlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1uHxzXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E612C116B1;
	Tue,  2 Jul 2024 11:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719921249;
	bh=ty1qZLwFA4LCJPhQ5+oQL+NTqlr44hCXTZWfi9VlxiE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D1uHxzXASDrj0Xo4U53R9izLeGl/NaX6UFUGzneXoKA1L+NyquI/9cX26qXyeVHDY
	 jYQGC2o4CLhPiMuym5mKkOtr7Fn/H2r9bk0Pmf4UUYK+y3vOleFlOfniF30u6pimN2
	 96iSO5DhMUY8HbZkdgOoHZMOSugn/ITGxfmtDSEEfxQuZ8vXhfFKj+0r71r0gONbQJ
	 +/6HhoaRQWM2FmvEVvq6K+fQtvOONZP+2dBqhtjg2wIFEtmCLBh+EWhaGRhvKiAkNT
	 BcbAVirTjccDd1i6idZswa9vAcJqPkozOp8vdbSr7PnWm+dtz50AsR0CGjeXZk6gpW
	 nmP8hC1ctbotg==
Message-ID: <b73fa427-9b55-4ca5-8edd-530ad26c7df4@kernel.org>
Date: Tue, 2 Jul 2024 14:54:04 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: cadence-torrent: Check return value on register read
To: Ma Ke <make24@iscas.ac.cn>, vkoul@kernel.org, kishon@kernel.org,
 sjakhade@cadence.com, sergio.paracuellos@gmail.com, robh@kernel.org
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240702032042.3993031-1-make24@iscas.ac.cn>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240702032042.3993031-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 02/07/2024 06:20, Ma Ke wrote:
> cdns_torrent_dp_set_power_state() does not consider that ret might be
> overwritten. Add return value check of regmap_read_poll_timeout() after
> register read in cdns_torrent_dp_set_power_state().
> 
> Fixes: 5b16a790f18d ("phy: cadence-torrent: Reorder few functions to remove function declarations")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

