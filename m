Return-Path: <linux-kernel+bounces-440871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD019EC5AC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA9D4188A9E4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 07:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033581C5F1A;
	Wed, 11 Dec 2024 07:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PixP3Ysa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF971C3021
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 07:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733902655; cv=none; b=J/M63/qM3ZcBwiI1A2RKPWUUHztedyufRsocA+tlY2petskuiVQI7Hsu9cyqAXWraL88Uflz6E2er+0RbwxvqEwq2z/MYh6YZ7A8BKSBDlX6mvQ5RvVdfSPR38KEKwxrxjnPEEVHMz4Zkts4SITUrfSXdDTMZnUSvACG0jH1nkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733902655; c=relaxed/simple;
	bh=4TY0TZPhw8Lntvd28gNy1939flgrlkTK8UhqQenx/QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWBw/lRcSpv24QKjXVgHx5PSaTuuz9TLnxPO4XY7Z1qIYe7Hd4LC2COx+JTNwEtHvH1npKG6/33VQQ3TBI0wiXV4FQBS+D8NWZNNDG8C2KmK30QDxYYwXov62oj/7oVHEvSwDZVJfvBfX7mOqwvA1ybIlstmv1tVOeTNN4w12Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PixP3Ysa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FAFC4CED2;
	Wed, 11 Dec 2024 07:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733902653;
	bh=4TY0TZPhw8Lntvd28gNy1939flgrlkTK8UhqQenx/QA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PixP3Ysab7RGjHROR3SuGeerMPY+ZJy2bPUKSHf7y6EVkQFZVpGPlOckEHNwS3ew8
	 c7Pw0+dhS+OSKXvrYp3lJCvosJIu70u4xV+mZKLb4aqa4Pjh8MU66i5HUp/DK7EI1T
	 C++HJvHeAT40np65Ik0W2GkjLEk7VQkh5deTfyUrAhxyBkOFAeyfc0ImHwpX2LuBSz
	 yro8pEJG4xMan/hF1dgrqIbuOf217aCBE/a2Ht+g1Ai+UONb4UBkMz/06tNjP22DpZ
	 Eng/DHCyeKaBSfxJUqla1JRCPjzu7cIaN6tRFD1awqqkm6oHQ/Pno9SO42GrLq0ltO
	 +RsuElKO5ANcQ==
Date: Tue, 10 Dec 2024 21:37:32 -1000
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <multics69@gmail.com>
Cc: void@manifault.com, mingo@redhat.com, peterz@infradead.org,
	changwoo@igalia.com, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] sched_ext: Relocate scx_enabled() related code
Message-ID: <Z1lBPNCxbAyvjWMx@slm.duckdns.org>
References: <20241209061531.257531-1-changwoo@igalia.com>
 <20241209061531.257531-2-changwoo@igalia.com>
 <Z1k--b0f1RLARJ65@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1k--b0f1RLARJ65@slm.duckdns.org>

On Tue, Dec 10, 2024 at 09:27:53PM -1000, Tejun Heo wrote:
> I wonder whether a better place for the above is include/linux/sched/ext.

Please ignore. Stuff added by the later patches would be weird to expose
there. Might as well keep them together.

Thanks.

-- 
tejun

