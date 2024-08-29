Return-Path: <linux-kernel+bounces-306832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A285096444E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E851C228E8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A451957F4;
	Thu, 29 Aug 2024 12:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJMTgdGN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30962191484;
	Thu, 29 Aug 2024 12:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934211; cv=none; b=V7XqgPgXGCIDDZpDC392KlcPOlUTwZkhHrhZF64XdnjwkrO6vI2jwKHpnm5Vto/2oMMNwheqxhPprBA+eKGUKPHmq0A2UVEm1vR2Xnsme6Y4DWdQyiti/A0bw37k5YGQNmo0R0mVWgIRZldXnEPhawLh++S69wKtqMGXlaK8+Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934211; c=relaxed/simple;
	bh=SaTxDfr+N8/M+HNWYckZpUPbBT0m10R2mHvbrVVu3T8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=oA0S6nPgKUpuCQObYR0bB/I9hNq2nswMxmxJe5D1WA43l8LG7RYVqfAukrynp93FUP+tDLPYck+sguUnGaKqac+W4BkPweXu8LOnLdzbm5zWYPUN7LIiDqZwVdsgcmCHXOiDmn0P67K9xvvfTgT3sqVn7NkFUhqrilsBvvXyi90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJMTgdGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626C5C4CEC1;
	Thu, 29 Aug 2024 12:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724934210;
	bh=SaTxDfr+N8/M+HNWYckZpUPbBT0m10R2mHvbrVVu3T8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=OJMTgdGNKTmuxDu+4lBJpiii00ILGvzgR+IPwcr3Umrb3dO7qGEiFi+4MGFkcYwD5
	 YTbCBc4Cja0kSnN5VS0LfK5R1SwO6yt4KBWTOla8dA1I/o1GI7RaGgxP3yCRAiF6ZY
	 14WrhkCR8HlE+sPD1rwzoR7oYe7dLJChlhfqEYKBXpG6qN82G8gy/YaBNjs+okIAbX
	 sxWTrmGKhicz3Leuiupeok5alTJuOOvfV/NXah5dNUHchHLgn4TNtG4EhIOFx5ueKD
	 bA6vMCQYxcJaPFrLECr6+f6+ZEmdWMPGoFedjeXP73omTN56CQv6gRPOVhYUOh90I9
	 yUGM7VYHDnLSw==
From: Kalle Valo <kvalo@kernel.org>
To: Yuesong Li <liyuesong@vivo.com>
Cc: kees@kernel.org,  johannes.berg@intel.com,  neal@gompa.dev,
  a@bayrepo.ru,  justinstitt@google.com,  marcan@marcan.st,  j@jannau.net,
  wsa+renesas@sang-engineering.com,  brcm80211@lists.linux.dev,
  brcm80211-dev-list.pdl@broadcom.com,  linux-kernel@vger.kernel.org,
  opensource.kernel@vivo.com
Subject: Re: [PATCH net-next v1] brcmfmac: Convert to use ERR_CAST()
References: <20240829112844.3193582-1-liyuesong@vivo.com>
Date: Thu, 29 Aug 2024 15:23:25 +0300
In-Reply-To: <20240829112844.3193582-1-liyuesong@vivo.com> (Yuesong Li's
	message of "Thu, 29 Aug 2024 19:28:44 +0800")
Message-ID: <87ed67ecw2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yuesong Li <liyuesong@vivo.com> writes:

> Use ERR_CAST() as it is designed for casting an error pointer to
> another type.
>
> This macro utilizes the __force and __must_check modifiers, which instruct
> the compiler to verify for errors at the locations where it is employed.
>
> Signed-off-by: Yuesong Li <liyuesong@vivo.com>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Several problems:

* wireless patches go to wireless-next, not net-next

* "wifi:" missing from title

* you forgot to cc linux-wireless

Please fix these and submit v2. And please read the wiki link below.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

