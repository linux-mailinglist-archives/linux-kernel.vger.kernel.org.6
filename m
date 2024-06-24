Return-Path: <linux-kernel+bounces-227252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4249F914E0B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39691F23A0C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F76A13D624;
	Mon, 24 Jun 2024 13:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3unLo7N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AF013D531
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 13:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234668; cv=none; b=NkGUZvF8U75Uaz3NjegTKMsLqOi7/cWzpXZdV+IpckbUimUbFy2dHTn3CP5SGjdrdqIGOUKOkr/ZmQA6YTIYwoN4SvLSpnCh0xOTdADI7cTObMz4p2yVhuBwsvkz1c9E0TpoJeC59gCKPMyQbd+TZRiA8JV4fQprgBwUkmtMu8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234668; c=relaxed/simple;
	bh=MYd17wTp/revoHlxrf/GAvPo4otkD29yASyqI0PkG2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2c86UwhMa/jHpB3cyqm7fsL9DiiEK+oDUHg8X9443Ag9zj/T+45DdKeErvdXiREYZYM1hOy5i8C0uBqfiPZlIH6PSdTc6XoO0horEdunviO5NF1xpm9Ws0JsKvqBw2erqSJz4EYrV4kiHyq7cE2j3+dVdjYKuXg8Ozg7cstwWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3unLo7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B49C32789;
	Mon, 24 Jun 2024 13:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719234667;
	bh=MYd17wTp/revoHlxrf/GAvPo4otkD29yASyqI0PkG2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i3unLo7N+yzZDbeKO3iflU6PY6eE2WvI5fV3H9b0cNCn6fDa2kl2wmjsPx7Rr3+yH
	 sdeVwznPscBOBDwL0bhH1JXgJzVMnMxKdaKxTCpCTF4dhWrogD94KeZ+vFpp1cxOE5
	 HYeKwCwM7OTCnM5kzQpIPUtjBmfR+zC0Hk1s20jA5aIueFVIy/mPgRTF+mVBiNpS5a
	 gQ7OS4vHGlb5GhKzX8AqDpDJp5neT/2DymXDJwF/arMG1pof2f2Qqn7mxP/JV4T3f3
	 CiUpttHYNQj7JDfmBDTj5YiCcwFWbl/yxw5LzR5qQVWxfbefxW6wxgr/GXG+Ri+Zg5
	 5yXRIC2tzSmAA==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zenghui Yu <yuzenghui@huawei.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	ardb@kernel.org,
	wanghaibin.wang@huawei.com
Subject: Re: [PATCH] arm64: Clear the initial ID map correctly before remapping
Date: Mon, 24 Jun 2024 14:11:01 +0100
Message-Id: <171922906695.2505459.7761242991798953710.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240621092809.162-1-yuzenghui@huawei.com>
References: <20240621092809.162-1-yuzenghui@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 21 Jun 2024 17:28:09 +0800, Zenghui Yu wrote:
> In the attempt to clear and recreate the initial ID map for LPA2, we
> wrongly use 'start - end' as the map size and make the memset() almost a
> nop.
> 
> Fix it by passing the correct map size.
> 
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: Clear the initial ID map correctly before remapping
      https://git.kernel.org/arm64/c/ecc54006f158

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

