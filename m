Return-Path: <linux-kernel+bounces-574810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A93FA6EA60
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0177D3B57AC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B002528E3;
	Tue, 25 Mar 2025 07:20:14 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B94234969
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742887214; cv=none; b=mRocRgnEzx82A7lFCQqCT89X0lrxBhq5kmR/6vuntoU9jrB/o2mCbE/pz9Rn7cNNsOEnSYmxpvGhaU4sMZAgYjVeZi0TcMYUT4huxwDOz4XDcvpIgLnZnp3bd8SJ5eG8IOsz2xBNkX6is8U6JQ7MqKlhWCB1ueuYesEPemE/xS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742887214; c=relaxed/simple;
	bh=FBKgAl0dls+V54M/y6/NImGIXa8V8XrwxDn2mtWskRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oC4Z3gf63Oub6vNBI70YGwyULzjEDRrJFD21we+ZEKpx0DuIQgRh4yM7sKsgVc6eUx/KhvZ4+HhvB1ZVkOpqDpaOygyeYGss20w3w21WhulGXAh6fruFwPssgHsN56JZ7Oy/35/m2epxPMVqZl988i5BzK6N9ZDY2oJh5uE4RTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4ZMLYK5Gt4z9sSh;
	Tue, 25 Mar 2025 08:05:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FJ4bAikuKLHX; Tue, 25 Mar 2025 08:05:57 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4ZMLYK4VFHz9sSg;
	Tue, 25 Mar 2025 08:05:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 851568B765;
	Tue, 25 Mar 2025 08:05:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 1R3S4luMUOar; Tue, 25 Mar 2025 08:05:57 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 565FA8B763;
	Tue, 25 Mar 2025 08:05:57 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
	by PO20335.IDSI0.si.c-s.fr (8.18.1/8.17.1) with ESMTPS id 52P75npS009415
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 08:05:49 +0100
Received: (from chleroy@localhost)
	by PO20335.IDSI0.si.c-s.fr (8.18.1/8.18.1/Submit) id 52P75mFm009410;
	Tue, 25 Mar 2025 08:05:48 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: ioana.ciornei@nxp.com, stuyoder@gmail.com, linux@treblig.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: fsl-mc: Remove deadcode
Date: Tue, 25 Mar 2025 08:03:29 +0100
Message-ID: <174288553818.2234438.11007216946587143383.b4-ty@csgroup.eu>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115152055.279732-1-linux@treblig.org>
References: <20241115152055.279732-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742886214; l=584; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=VhmgXn8UTNWepu/WKdG9W0WStpBu+2fR6BBNfwNb5Vo=; b=OOvXAJey8QbW05uaPC1iND6tTU4jLioJLk4ni3WxNp8YZL9IeOycvAmyn8xVebICfDxO/xZ2T ZW88LyzkL67DtjvUgJNVQ4IKPHgyaY28eIKUhtLCD0xCKdaYppLQQbT
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit


On Fri, 15 Nov 2024 15:20:55 +0000, linux@treblig.org wrote:
> fsl_mc_allocator_driver_exit() was added explicitly by
> commit 1e8ac83b6caf ("bus: fsl-mc: add fsl_mc_allocator cleanup function")
> but was never used.
> 
> Remove it.
> 
> fsl_mc_portal_reset() was added in 2015 by
> commit 197f4d6a4a00 ("staging: fsl-mc: fsl-mc object allocator driver")
> but was never used.
> 
> [...]

Applied, thanks!

[1/1] bus: fsl-mc: Remove deadcode
      commit: c25951eb7518844fcb7fc9ec58e888731e8c46d0

Best regards,
-- 
Christophe Leroy <christophe.leroy@csgroup.eu>

