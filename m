Return-Path: <linux-kernel+bounces-392506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4028B9B94F8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0412E28338E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 16:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0AB1C9B65;
	Fri,  1 Nov 2024 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIeplz/F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B512AE74
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730477389; cv=none; b=cvPSCAEtoST/sHceu6sgYrlILT2PwL8q2heERsTFhc9gz5ubi09BG9JnpPo97WRf5ytCPSntpfQZJKyIFpWLr5Y07DKtppLvcwv80Vxp05FRNbFH50Vy5UjbZrLz3P5BZKER8gikFV76jfKb206wsRd/6BCc9Z/52wp1bkq7Gw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730477389; c=relaxed/simple;
	bh=Wha7XVzYkZ1o/HJ7CNBN11dacfmWqh6V73cbRHPxbto=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rQtEuI08lxbT5L6qcCAmbrPpU8QfhP+TVz6Jg7uUw4+P60L2tENNxbQHk0F3jXZlYWCTht38hAMB6+1zgaAU9wXzvn8XYUjDXRLTZK8B086/9yDblDG4Jn2iF8cqWmnRCYXngk3yTduQ/Md6QlUpvaRpt8PQPgZZlcpmM8fL8wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIeplz/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9186C4CECD;
	Fri,  1 Nov 2024 16:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730477389;
	bh=Wha7XVzYkZ1o/HJ7CNBN11dacfmWqh6V73cbRHPxbto=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=vIeplz/FIhwiX+zqURS5r+XMOAjE+2F8A9LABsCIDekaGDsP0Csb/rot2TkYEY2fa
	 qWbTU9b2fgyfJILKRCKBp05rpXQ4UCMzL4YTUnW35FtDjrRdem72IqZb44SxlsfCWK
	 gmieh51aN2LBYXETIqFe6mqZ6BPed+IYuXxESWFOeVqonbtX2CKGnkpxwyIX+q0d+m
	 qv/OGjdMTKkmOhAFkyDgbLccy57VzcsKnSYTYLS2IQE7lrJShrI9IJkQojhafzJknh
	 LLXriDLA7LBYwk7neymPhGllCT2qmFPWRpOv3EDon5tSoZ93col0WXegzTQVGfynNK
	 LC+GCACL5AnkA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20241025102943.250184-2-u.kleine-koenig@baylibre.com>
References: <20241025102943.250184-2-u.kleine-koenig@baylibre.com>
Subject: Re: (subset) [PATCH] mfd: Switch back to struct
 platform_driver::remove()
Message-Id: <173047738842.1928892.13765403140149562754.b4-ty@kernel.org>
Date: Fri, 01 Nov 2024 16:09:48 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Fri, 25 Oct 2024 12:29:44 +0200, Uwe Kleine-König wrote:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
> 
> Convert all platform drivers below drivers/mfd to use .remove(), with
> the eventual goal to drop struct platform_driver::remove_new(). As
> .remove() and .remove_new() have the same prototypes, conversion is done
> by just changing the structure member name in the driver initializer.
> 
> [...]

Applied, thanks!

[1/1] mfd: Switch back to struct platform_driver::remove()
      commit: 10821a061321f1f8ea1f2aadd28c148f8254976a

--
Lee Jones [李琼斯]


