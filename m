Return-Path: <linux-kernel+bounces-185334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F858CB39C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23CD9B216EB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54F7148FED;
	Tue, 21 May 2024 18:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ee87fqVb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0085114884F
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716316773; cv=none; b=gwq//aqyoxnKb+a6iYD+RZ+ySVVwqNEiHmypPBmFFpnsIY2HirRz9sRe+rQFAcjFgk+d1rT4oi/IQr6NrWTqiE3voC4cxh+qI/AVaAbBqSsNYoB6/OEq04WRQ6haXNesqWriHQjdhjeoyfJDEi8zT5C2J3zTBRUuw8dLC7tnyME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716316773; c=relaxed/simple;
	bh=ZwNeusr0bjuZXFwILV4/yWqrQt/2j+I7WZxp2xgt54s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D2a5a0uXViUYaqUIUiZU5Bn19TLcDKfld1BHHg4UTj/rY8mHjnBTkslcMepWHieab1g//FaKxW9GFC+GOHBPl2C0Khbov6K29ZzKXQZHdPriNDMWSCz83aSH034GIt6bVqbvjU7dillLgRi6bFsmirLlpHLTP48SeAu46DH0QnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ee87fqVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D38C2BD11;
	Tue, 21 May 2024 18:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716316772;
	bh=ZwNeusr0bjuZXFwILV4/yWqrQt/2j+I7WZxp2xgt54s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ee87fqVbudv9E2QJx9Gu6ChM52QHTOhc1AQOzeWG/slc82aNt4smDnEKE6wOfs7Vk
	 oKyO/UkKcDqlrXUPf5sl3xSwpqrZzvLTweYJAeUy6C8xafD4CVHp80QxGAgpix1yDq
	 JWhi968ZkmTUts/GGHT06sjzpwoH9o/mk5mDq5yM+C3DtJe1HSHZgZeYMCjBKt2ww/
	 rNPOnEJexkrwlz//7hX37Q02T6m9dy+Pcm7cs8trrK894EG6XCckfnq3DpwTRxKAxi
	 Sv4mgG4sbo/Fc+4apgPRvRYthZIJsxN6pNiCIvYLB4NTSTRC8vKgx6i+LY4C3vBGRo
	 bLSHhAcXLTXgA==
From: Will Deacon <will@kernel.org>
To: mark.rutland@arm.com,
	catalin.marinas@arm.com,
	Dave.Martin@arm.com,
	xieyuanbin1@huawei.com,
	Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	nixiaoming@huawei.com,
	wangbing6@huawei.com,
	douzhaolei@huawei.com,
	liaohua4@huawei.com,
	lijiahuan5@huawei.com,
	wangfangpeng1@huawei.com
Subject: Re: [PATCH v2] arm64: asm-bug: Add .align 2 to the end of __BUG_ENTRY
Date: Tue, 21 May 2024 19:39:24 +0100
Message-Id: <171631490546.211397.14650733448270838075.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1716212077-43826-1-git-send-email-xiaojiangfeng@huawei.com>
References: <1715955208-17109-1-git-send-email-xiaojiangfeng@huawei.com> <1716212077-43826-1-git-send-email-xiaojiangfeng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 20 May 2024 21:34:37 +0800, Jiangfeng Xiao wrote:
> When CONFIG_DEBUG_BUGVERBOSE=n, we fail to add necessary padding bytes
> to bug_table entries, and as a result the last entry in a bug table will
> be ignored, potentially leading to an unexpected panic(). All prior
> entries in the table will be handled correctly.
> 
> The arm64 ABI requires that struct fields of up to 8 bytes are
> naturally-aligned, with padding added within a struct such that struct
> are suitably aligned within arrays.
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/1] arm64: asm-bug: Add .align 2 to the end of __BUG_ENTRY
      https://git.kernel.org/arm64/c/ffbf4fb9b5c1

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

