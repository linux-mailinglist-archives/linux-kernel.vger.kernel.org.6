Return-Path: <linux-kernel+bounces-449375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B79389F4DF5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5292189119B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697CD1F5411;
	Tue, 17 Dec 2024 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUO10q79"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38FD1F4E36;
	Tue, 17 Dec 2024 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734446234; cv=none; b=i3ym8xu9awoxU5mV7SbNs4GFZg/wqR/Sz2555Oe4ySLqylVrN35kZfShPriQMpanW5BDWDAQ5n/IKFbL423UedfdCDzF5MRHVW35jf9ta7tqotlF0L5a6N5oagIERQoTbRmmJ4p62Yr9crOQJkLagqjb6U1AXmFdSqqSKN5cqEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734446234; c=relaxed/simple;
	bh=GywTV2qAgcFhXk8IHQVEsqe5xeo0ohrZrzfDWYXgVLc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PxN8qQHEFOrfvO/eFtX7JMFMZiB4WShzMhia1dpuvh0Cxa3lDK8oetbzFrcE/b6CIXBogdg3d0JpJZqLJs/uOM/2X/I77ZBmyGQOrT/9EiJv3NjR2Q+N/FwbOcrGdZ0S1E1qmOiD0EYwL5pKBTocCDFEXYv2lGGmp6/r2VPaL1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUO10q79; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6CAC4CED3;
	Tue, 17 Dec 2024 14:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734446234;
	bh=GywTV2qAgcFhXk8IHQVEsqe5xeo0ohrZrzfDWYXgVLc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YUO10q79gCZTcc2EJQ94GASBJF9DPpaRA599I8dbdr294Yw9KHs6n5iTkXiutdgaS
	 FHSQSwg/JmDWBe0ohckQvMbD/UAu0/beGqnLaBf3y5mfIcCBThc0bGbyjGd7dVLwGX
	 bAYanSx+s8j9TXjK6H4nunikfKpH9QluAWiViBqEaHySjVWCMFpj34Zbt8yQEJnUw+
	 IqZlq0kdDsQ6bZfHS9tpABlYn6T+edw8mbp1g2WnzROyoIHpW1vXczBUTrlKhjupt8
	 HnyVEGbrv7BHKjN2dzvR4QW4AUn29ijPXGCcy7FtOBp8aYkZQ9ZZ2ImEebIOqySkrs
	 pPc3F32LCR1kA==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 zhenwei pi <pizhenwei@bytedance.com>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca
In-Reply-To: <20241216121953.765331-1-pizhenwei@bytedance.com>
References: <20241216121953.765331-1-pizhenwei@bytedance.com>
Subject: Re: [PATCH] RDMA/rxe: Fix mismatched max_msg_sz
Message-Id: <173444623177.282433.16423484582962298298.b4-ty@kernel.org>
Date: Tue, 17 Dec 2024 09:37:11 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 16 Dec 2024 20:19:53 +0800, zhenwei pi wrote:
> User mode queries max_msg_sz as 0x800000 by command 'ibv_devinfo -v',
> however ibv_post_send/ibv_post_recv has a limit of 2^31. Fix this
> mismatched information.
> 
> 

Applied, thanks!

[1/1] RDMA/rxe: Fix mismatched max_msg_sz
      https://git.kernel.org/rdma/rdma/c/db03b70969aab4

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


