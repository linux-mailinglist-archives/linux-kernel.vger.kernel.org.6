Return-Path: <linux-kernel+bounces-334074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E29B97D254
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D622F28693B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B7F7DA71;
	Fri, 20 Sep 2024 08:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rznLJj3/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA4E2B9B7;
	Fri, 20 Sep 2024 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820176; cv=none; b=G+U5zvW4frGveaMFO7YaLIaXqEgwOXCo48/7L3++Vm6UQb4ixWKeKroxt3iMmYSqnn3VhVBzTq3jH9w+Wf5642HqJyl+e5YF6AEvIfK/COT8isOe0Of8S8RmMQlB9O0cldVRiddSVelMEQFLPJdG8bXW1jXyPu0niFUSABh8SHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820176; c=relaxed/simple;
	bh=RY6C6fgg/u2FQqsycCMOcuCyZ6IO+mQm4xQLZhTAfLU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=S+pNuPDTeECds7HBPo8dFdzz//D+0YuS2zcH/NYeLy/lnhH5/P/UUglgrsCwPY2Y4SEbbCSsTk37LOepdLXiPgPHTOOFOxj6Ur3zRd8syZP70fxI3YJh/Ej4i3842BcN49Cy9IE8N47CImb688oFIbkd70tAu9x3alxY38Xfhng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rznLJj3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8AFE9C4CEC3;
	Fri, 20 Sep 2024 08:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726820175;
	bh=RY6C6fgg/u2FQqsycCMOcuCyZ6IO+mQm4xQLZhTAfLU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=rznLJj3/j4Y33sCWx4vMGgJbObJootBWRDxFOVas4+uMuqz+pMCu6KqTPMbQFo2JE
	 u1xTbuwdZUZEaq/TUxV5vU4kLP+OMqVdoWxBsP23g4A6ychrD0O8Mu80xFx/EV6uxn
	 gSe1g5tc0/a5lmmRHdv8HyHCwzLJBwGEjGBGw4WPrGzQ3yK/Jv7PnCxBXDJD1gaP55
	 q1kk4QJSQcxJ1sLjuOYc+E65UwIPyLQzrdWH3esYxxd8igJP/DjOug4HmetJ9786ZP
	 9xMBrq2iP+jOb77FgOPW8jZo63QkVDQp9GBvwI2Oj4o0GaZEbW+RwIUAD7WRTjDQZ3
	 brCiVJeuMz1GQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F15FCF58E5;
	Fri, 20 Sep 2024 08:16:15 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Subject: [PATCH 0/6] clk: meson: Delete a meaningless spinlock from the
 MPLL
Date: Fri, 20 Sep 2024 16:16:10 +0800
Message-Id: <20240920-mpll_spinlock-v1-0-5249a9a7e2b7@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEov7WYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDS0ML3dyCnJz44oLMvJz85GxdkyTLJFPTZBOTtBRTJaCegqLUtMwKsHn
 RsbW1ACypo2ZfAAAA
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726820173; l=1441;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=RY6C6fgg/u2FQqsycCMOcuCyZ6IO+mQm4xQLZhTAfLU=;
 b=Bel3Jh1Lzlk031mBbSqUOf1Dk86SKnJakYDwJxNS3ho8IG5uNcg8mx+X7/EfDSiy6iKQyUMhu
 3KqlnI81BLTAVgJmOjGOvofYkUdDus+QNqhGaVI3qnas/eAXOOemQf7
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

The existing locking mechanism of CCF can effectively avoid concurrent
register access. struct meson_clk_mpll_data has no meaning in defining
a spinlock repeatedly.

In addition, the register corresponding to MPLL does not share the same
register with other module drivers, so there is no concurrent access to
the register with other modules drivers.

Every driver file with mpll defines a spinlock with the same name (even
if defined as "static"), giving the illusion of repeated definitions?

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
Chuan Liu (6):
      clk: meson: mpll: Delete a meaningless spinlock from the MPLL
      clk: meson: axg: Delete the spinlock from the MPLL
      clk: meson: meson8b: Delete the spinlock from the MPLL
      clk: meson: gxbb: Delete the spinlock from the MPLL
      clk: meson: g12a: Delete the spinlock from the MPLL
      clk: meson: s4: Delete the spinlock from the MPLL

 drivers/clk/meson/axg.c      |  6 ------
 drivers/clk/meson/clk-mpll.c | 11 -----------
 drivers/clk/meson/clk-mpll.h |  1 -
 drivers/clk/meson/g12a.c     |  6 ------
 drivers/clk/meson/gxbb.c     |  6 ------
 drivers/clk/meson/meson8b.c  |  3 ---
 drivers/clk/meson/s4-pll.c   |  6 ------
 7 files changed, 39 deletions(-)
---
base-commit: 0ef513560b53d499c824b77220c537eafe1df90d
change-id: 20240918-mpll_spinlock-4b9b55c44fd5

Best regards,
-- 
Chuan Liu <chuan.liu@amlogic.com>



