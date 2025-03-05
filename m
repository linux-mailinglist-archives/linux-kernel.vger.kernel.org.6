Return-Path: <linux-kernel+bounces-545920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2C8A4F3A7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3C18188DD9E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 01:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4021422D8;
	Wed,  5 Mar 2025 01:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzR2eGLn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E22286324
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 01:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741138090; cv=none; b=sn5My2BNP/po1HKEq1Cp8AWQI7itoAcaxNP+kaaABFHlKu056Mt9c2B2G9zyRdJifAfCFN20Bx8neQI/lwYk3QCk9hRIBgRuW8g4HvZEItf/jfOUWlSiGZBDy2gyWH/EXtjv/GBuIfvmVka+yXUBDHnGII1bMzxBRuoH/NZYNtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741138090; c=relaxed/simple;
	bh=mcZze2u74MXu/QKPWzlCV749STbpGtWemD1JsiX7HZc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CZ7/JRQCgUXxiy3BvuUT8RY5wxzvaeN4YGbZEG/IYZLioJbN5bG+mYOP1S+Qup/vnht0To/drX+8EG6xmNMOijuEKUPmEDKymFZmtFt47NkFZ/ISdzMFIFVDp7WBVuIoqYSaV199GXDz70vUEZdiPh90vBJugPRu8vL7muTwAW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzR2eGLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FAAC4CEE5;
	Wed,  5 Mar 2025 01:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741138089;
	bh=mcZze2u74MXu/QKPWzlCV749STbpGtWemD1JsiX7HZc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=gzR2eGLnohYIbPa5fIjXgemiz/mLR54rOkagkqljQsJc6ezXs6ZRqXFiHO+VpnMrw
	 83LRq13BksbfT2tisnQJBolenDhgSlf/ij5yaP9UnAJkojmgQV7CjCdxL+BEzUBZQh
	 1z/2Le1jaUL9eDeb86omEh3Tiw9LOnnJk+CutVh/i8siDwhqK4dccDc9vUVXnp+6cz
	 GEIAp+8rpevZd8OegOzvR4wW1L2EsOkxuK+9mncdbS4+Qt+gn9d8//T2bBbCAUkhk+
	 Dfqxs7lNNO58LMlsYgOYV2+vY1PhXM1ps4Ez2v9OeVm64sm1Ijf2u2nRzRiem/lyAB
	 ji+okoSYtD6ig==
Message-ID: <ae938b41-f417-4152-b2d4-e66936767dd5@kernel.org>
Date: Wed, 5 Mar 2025 09:28:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: set highest IO priority for checkpoint
 thread
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20250303221730.1284822-1-jaegeuk@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250303221730.1284822-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/25 06:17, Jaegeuk Kim via Linux-f2fs-devel wrote:
> The checkpoint is the top priority thread which can stop all the filesystem
> operations. Let's make it RT priority.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

