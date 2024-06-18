Return-Path: <linux-kernel+bounces-218503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AED1290C0E3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693871F22910
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 01:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1975815E9B;
	Tue, 18 Jun 2024 01:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLDqtAXs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E875134AB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 01:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718672627; cv=none; b=t4cpCCnmXcm9UcT4+8T801N14e7NCAWkpaqVtU1aVc5/mPLoqtJNhC2XMDvHfLO61/hTF9Ig0nPIYL5auukyu4cG0hijSnCmRqqpaj6Qln4TKiGfzkAv3y49nwsn3SWsZxcsvFk+1S7a/VYS+9HmYZIRiUywy+qKtCDSgrGgdQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718672627; c=relaxed/simple;
	bh=/swPX5W6fAnNAGqwBtdSnQTYwnfC0j2x33mqYPjbDds=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mdo0RKUhC7uXQWd+IELDvzEbf9eJTKxhsjU5jKrbJNWOV7K4Z9+pdoHGIMScYvMdePpa9gQPZFQ6z7oN2QwiwJRO4iy/xM1dOXHhfSLEAp8U7evvSEkzPQZtQmjAR61JEUwjRQUHaOgKwQIYPEOm5sfrb830PQ9XeJ3riAWvY9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLDqtAXs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1030C2BD10;
	Tue, 18 Jun 2024 01:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718672625;
	bh=/swPX5W6fAnNAGqwBtdSnQTYwnfC0j2x33mqYPjbDds=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=qLDqtAXspqkGVmptyAuy0Wvklru0L2/sDTEmv0HEJcKNB8dIQvYjs61GwyTnb6RfJ
	 tGrRGkqbWNjCWckIWxLCcnITqUkj2pPC+uNDKrPpvi2yvf8N6Q21b3g2i2Nzno3vvS
	 FV8wFFvO28yXvLVqMuG/V+kXSoqlEAhk207GYX5ASTpRwWF5U9Mlj2pKvv9e5vJ/V7
	 rO+gmYvZbk3TfYbufBaxJd8rlDC5ROhbpZkuZk58C8dulwrOUf3rHTAZw/iXq0+fpK
	 JvTD3b0chM71gWwA5w3wbCpznMtcg3nMafOBgdv2ymgmt0S27wddJM49FIVG3DQLPo
	 bEMrK/Zhs8VaA==
Message-ID: <8547fb4d-e046-4b7e-b3f9-b52ed09fd645@kernel.org>
Date: Tue, 18 Jun 2024 09:03:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH] f2fs: clean up set REQ_RAHEAD given rac
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240612193831.106524-1-jaegeuk@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240612193831.106524-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/6/13 3:38, Jaegeuk Kim wrote:
> Let's set REQ_RAHEAD per rac by single source.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

