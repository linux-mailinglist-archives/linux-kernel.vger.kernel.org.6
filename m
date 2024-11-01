Return-Path: <linux-kernel+bounces-392644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BA99B96A0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64B7E1F2200A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967191CC8AE;
	Fri,  1 Nov 2024 17:36:21 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF9D84E1C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 17:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730482581; cv=none; b=gUpU344keQPZvE+rRYXew2ofQ4kpjNHTFlv/LMxJrBJ8MYOvlb9rKWsVJG/LTcG8J50xd1pPCjmcTCwtXY3yQeWxgYBFktUq6Q67ZGjZdt1/fArCqIE7rNfl2/MR4RTDbAbdlYCtnqchAzZ1gCu/+tdqRWZlIs3UpUteip0FFC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730482581; c=relaxed/simple;
	bh=8l8cSy51ZMz3ft7ILFlvjVdwl9KZbX5UQAkCKvOhZuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ByDrsJBIrbv1+W4jwKvXEssGxySIyB6z9pcfFhN1qMggu7jtjeJX+g8F2jRfmYxyW08+jWcg7SMdpetPFqFPo+bziUHXAOmU/uQa7snaqGn+i1ogqwC0hBZlqE+YIHChYIDTijPWWBPlVXyC8icKoC17jSmXoGNtHPQDUoCkqPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C98CC4CECD;
	Fri,  1 Nov 2024 17:36:19 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: mark.rutland@arm.com,
	will@kernel.org,
	oliver.upton@linux.dev,
	kristina.martsenko@arm.com,
	ptosi@google.com,
	Liao Chang <liaochang1@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: Return early when break handler is found on linked-list
Date: Fri,  1 Nov 2024 17:36:16 +0000
Message-Id: <173048223688.1108539.1091476619283409059.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241024034120.3814224-1-liaochang1@huawei.com>
References: <20241024034120.3814224-1-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 24 Oct 2024 03:41:20 +0000, Liao Chang wrote:
> The search for breakpoint handlers iterate through the entire
> linked list. Given that all registered hook has a valid fn field, and no
> registered hooks share the same mask and imm. This commit optimize the
> efficiency slightly by returning early as a matching handler is found.
> 
> v2->v1:
> Remove all WARN_ON(!hook->fn) in v1 as Will suggested.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: Return early when break handler is found on linked-list
      https://git.kernel.org/arm64/c/9a0e3b92b02e

-- 
Catalin


