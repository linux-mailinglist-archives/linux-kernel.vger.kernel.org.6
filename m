Return-Path: <linux-kernel+bounces-289929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B44954D70
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30AF8286AE6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E3E1BD4F7;
	Fri, 16 Aug 2024 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpKiCjHx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C605A0F5;
	Fri, 16 Aug 2024 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723821372; cv=none; b=J8h5f75yaXKobRHrjONtIaMsiTLdVHpwpTH5W8Hc85SZxQ2/9BwfNOHsd1whctgL7YCL0w/g46QeURewbkKupmbiS8gX6nypwQ8fznuSEXm/Rx5G01mjsJ8znf553LuZpJul53eSy9Ux63mNu/wks9gg5dFJuqenIyF2/7sBNM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723821372; c=relaxed/simple;
	bh=ijY7DtR+EGmbIx+sh77hG4AFDUp2oE9cYY70Ns0KpUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cN4iRFTWB17OSW4jPZMuPLIlRJmtNRY/C3x0MV23skD6dEYgiGTAJ/ySqlqBIo07iTloEbmHEZ56uPMIONY6+F1RKhxZ0SOnbZB7zOoKBHy1cqrRMPkM0gfdM7gol8oStf8kgHoSrLFe17nH9E9Bf88qFi5nyXfNlF3YSHqqB20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpKiCjHx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4B8C32782;
	Fri, 16 Aug 2024 15:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723821371;
	bh=ijY7DtR+EGmbIx+sh77hG4AFDUp2oE9cYY70Ns0KpUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MpKiCjHx/pha+73ceLMNQ3+Ch71kgbyHgcjIBougbEO81H/3AKQROBENqN1vZF8AQ
	 NeRN13EYGhln+xYsqrRwPhUIfD6VVXizZfDkvBiMtYH4PR97HxY5IMWBhcKDT80IqR
	 UE4s0zrjAPlCTXbXVzcNM+FsqU7xtDl/Ja2rZCA336/SI6wAIWElRIauW1ra4ZU6In
	 Ev4+DEruatVAY0uxeI1KnLkeFPTfnUrzyLpFtOPny+tvPirB6yqJZ8SOqsor5LW5Zi
	 V+DcdPgURDADQZflrEKaEJp7KsY3Mq6KxKF4WT1XlujhsqkM+l49r8fzwHjne4v0m2
	 pXW0RA4M1QY8A==
From: Will Deacon <will@kernel.org>
To: linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 1/1] ACPI/IORT: Switch to use kmemdup_array()
Date: Fri, 16 Aug 2024 16:15:50 +0100
Message-Id: <172380439581.1161472.5676200182467142150.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240606165005.3031490-1-andriy.shevchenko@linux.intel.com>
References: <20240606165005.3031490-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 06 Jun 2024 19:50:05 +0300, Andy Shevchenko wrote:
> Let the kememdup_array() take care about multiplication and possible
> overflows.
> 
> 

Applied to arm64 (for-next/acpi), thanks!

[1/1] ACPI/IORT: Switch to use kmemdup_array()
      https://git.kernel.org/arm64/c/9cd8062b38e6

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

