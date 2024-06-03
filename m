Return-Path: <linux-kernel+bounces-199085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 378C98D81F5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92371F2618D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13192128393;
	Mon,  3 Jun 2024 12:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPYbTcsK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5207C8665A;
	Mon,  3 Jun 2024 12:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717416681; cv=none; b=ng28KSm8XGAPPxnJw1o1p75s7r27Yxlh6a41421kZxs09D01E+TktCoXwvpIge9/X0ElXiMLx/IEPQHsS2we4d7sB1XES8QGrUrx1sxHYaM/RgYvL+QY2hhHSZON/dr4qaMrarntV8UowO8cUqPYHjCRzosLS4PQZP/mbg7lD9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717416681; c=relaxed/simple;
	bh=lwXfUIxWMJe9RXmv+TjDhCZ/l7pIOBcTR+FEij0bPLU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=c/hab1znKb3t82/WzJTdmt0VGTjyS3fiBFgiAvpgKzDTjAjrDshdUOZt7bkYDhejL1hb72u2TQjJ5qWVYZKQzHWSQhgntH1vtcIx1krUgImqpOXkRXTzGvob8FXCmrW+Q7/hdYPA6FKD8ArjFWfA3+pbEJGNED2Q5PuhFM3U2jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPYbTcsK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5AAC2BD10;
	Mon,  3 Jun 2024 12:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717416681;
	bh=lwXfUIxWMJe9RXmv+TjDhCZ/l7pIOBcTR+FEij0bPLU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OPYbTcsKnbf60GJbHzK3/e/HwV42HgGtSegoP8sUi3/9O5VlDspxe4A7vFrkf5q4d
	 PIf7RlksvQZgnXY44JTGA8zGQQidLT1qwOVZjlDFvGT88AYxK9WeA5qDbScWm/YfID
	 WSClflZA4KsXqkdZmu2jncUp2btgzYVUKzxVPIFXQB6ZtzNmTFnZovReQRaMSs0pI3
	 bd/mJgtSwpGdWeR+rkDIIt7PlC/GcNNXFLWsnItSEfDewCQ9b5aVpjuaauUvhwpT+M
	 OC0UlFBtrRH6Woec1jSF6epbmiOKMq0Zf9jD0rOLiG8xJPgkPuB4t/xxyQJIZf2ZYe
	 BLWQ6B/u9ba4A==
From: Vinod Koul <vkoul@kernel.org>
To: linux-sound@vger.kernel.org, 
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org, 
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
In-Reply-To: <20240603065841.4860-1-yung-chuan.liao@linux.intel.com>
References: <20240603065841.4860-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH RESEND 1/2] soundwire: debugfs: add interface to
 read/write commands
Message-Id: <171741667913.28073.818443345292581461.b4-ty@kernel.org>
Date: Mon, 03 Jun 2024 17:41:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 03 Jun 2024 14:58:40 +0800, Bard Liao wrote:
> We have an existing debugfs files to read standard registers
> (DP0/SCP/DPn).
> 
> This patch provides a more generic interface to ANY set of read/write
> contiguous registers in a peripheral device. In follow-up patches,
> this interface will be extended to use BRA transfers.
> 
> [...]

Applied, thanks!

[1/2] soundwire: debugfs: add interface to read/write commands
      commit: fe46d2a4301de1299fb32c0317ec316706ceaad6
[2/2] soundwire: bus: add stream refcount
      commit: a5b7365f28c191df6b93f60942d2b9a9fe71746c

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


