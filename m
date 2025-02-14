Return-Path: <linux-kernel+bounces-514987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2FCA35E61
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E3D318991D6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271C826738D;
	Fri, 14 Feb 2025 12:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKJXdcm3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8815B267384
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 12:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537943; cv=none; b=f7d7m2s7y1HJ9lXRlsmFeC8iM4m1QfA15JHsCdWydP4WQRymB/iMf7Et4pQvr9eeq2hRFZEnlFcup0xRHswz+Qk4+LMU7lwiSfTZ3TZ0h3VKXhWeHM8TjK1TxWM+mJOCljrODFnT+j33Xs1Tw8SEi7akKdtzfUV2p3Ef7ibRy4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537943; c=relaxed/simple;
	bh=Ds5kAQiVbq1nu9WS4fotu5kbGElIso5VjAswBWF0k3Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nr2HKXRvZXf6haBUkVwJ3b5rSicK9MCj1SpJb15kZkXDXVFEyAhaUb3N7NGvSikeXR+VIdkE9f47aYBKWxSTECmiZhpJWVOD//NWfzDXGkFm8AeR0jDqBKG39Lnv8Zusp/obatF0TT2b0UT66KLJqAGyAspDCtzkYoU3t6jlnzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKJXdcm3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E9AC4CEE6;
	Fri, 14 Feb 2025 12:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739537943;
	bh=Ds5kAQiVbq1nu9WS4fotu5kbGElIso5VjAswBWF0k3Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PKJXdcm3e1ROD62G7N5o/FdD5ariG/lODTcKpmGjsvUjGIsc4oiiFhdyWWhBPAonC
	 4YmKV3yIXimmp+BNqqz5KMPGpdvZYRq0FxGjMXr1TXx2N25HHrMhY4kPlJUc+3nGS4
	 PSoxt+i34RROCUfsQo04FCpVS4G580aKPsnK6UBlOljK2z4/onCoRJF0xCop+qjDzR
	 Kd0dAeEfCfFOThMUFZ2klOrNxdSAjGd8fZd2ueUhQHA7lXDUUfeLLUu4chs92iQa2L
	 2p4XxbhdFXIQNYiaYr4Rc3EI2qRbHdwBNo1j28Y8faQxlnG83FFv/3Inz2rZ33QIUN
	 x1aW3iqQICfEA==
From: Vinod Koul <vkoul@kernel.org>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Andrew Davis <afd@ti.com>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250123182234.597665-1-afd@ti.com>
References: <20250123182234.597665-1-afd@ti.com>
Subject: Re: [PATCH] phy: ti: gmii-sel: Do not use syscon helper to build
 regmap
Message-Id: <173953794070.323038.8014772310135787183.b4-ty@kernel.org>
Date: Fri, 14 Feb 2025 18:29:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 23 Jan 2025 12:22:34 -0600, Andrew Davis wrote:
> The syscon helper device_node_to_regmap() is used to fetch a regmap
> registered to a device node. It also currently creates this regmap
> if the node did not already have a regmap associated with it. This
> should only be used on "syscon" nodes. This driver is not such a
> device and instead uses device_node_to_regmap() on its own node as
> a hacky way to create a regmap for itself.
> 
> [...]

Applied, thanks!

[1/1] phy: ti: gmii-sel: Do not use syscon helper to build regmap
      commit: 5ab90f40121a9f6a9b368274cd92d0f435dc7cfa

Best regards,
-- 
~Vinod



