Return-Path: <linux-kernel+bounces-320169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA74C9706F8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 13:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E75201C20E5A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E49158203;
	Sun,  8 Sep 2024 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="mJqZFoWE"
Received: from msa.smtpout.orange.fr (msa-217.smtpout.orange.fr [193.252.23.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA8E4503C
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725795661; cv=none; b=IvGIDWMqRYqBCB4va7k9sja9GdBR37PGU5XSG5+kMHMuoewGdtKv/j0hsH50btojptL8WF0M13FnMF1+zfo6g040kzuKyues3tcxPnpHbk38vY8BJk4LtVUKAuu7h2lckO/aY3HP9/xh3oYEgHDuctjaqDZNfB6gWSaGVdaoLxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725795661; c=relaxed/simple;
	bh=KbKh2FVELoj3kuLJ9cKpEqvKQqfPVt/zOcMMrPzjzDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LjV3B+nAn+k1gqkmj5X6twUUAzSW/bAV4NcbCkauTw9unJ3pGx2BRkxovSw2hv2hD26lC18agGFeBfiTQT45RLl3uLwHmNVhwv/uROcnL9LBu5yvc+KxboLgQL8jpHDHHm5IEu4DgnCHwPW+jG6qK0qWtxfIW/wfpcahQ/NwkOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=mJqZFoWE; arc=none smtp.client-ip=193.252.23.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id nGHgsexU2GrBenGHgswgj8; Sun, 08 Sep 2024 13:40:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1725795648;
	bh=VhSkXI3EnkqnwlJ/f665rfBPl1jI/zqhPe1XKWN080M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=mJqZFoWEvLTLsmHgQ6N/AetnOHTIqCYi22cTzawW3fz0qKy/xv8+Ts9W+UL9cW0UU
	 12wvKCPwwL+wk5Xd1YiggdmytY40cYdpD0PbAUl5MykMXwDZKz99aGZz/CbK9yL5s5
	 jTYnBkZ0BrWdqGE96zaQVNRGsPDF/BCxee7UTjTkiON8UADptwbowm1Cth6dCGeYaA
	 YDxMJ5nDaTMICRZepPP0p1PJnOu3GBEqeBacSyZcgsvq1Q3ndGAzDkBqno6mzAc3o1
	 WgSiFR7p99tXnKKo7y7Htt3ZgBEo1NY5Qb5pFPkW2NvosCpp1w/rEJ2pHC4u00xuft
	 YghkVDbJZkJwA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 08 Sep 2024 13:40:48 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: lgirdwood@gmail.com,
	iskren.chernev@gmail.com
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/2] regulator: max77826: Constify and simplify
Date: Sun,  8 Sep 2024 13:40:43 +0200
Message-ID: <cover.1725791361.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 is just a constification path. It should be straighforward.


Patch 2 is COMPLETELY SPECULATIVE. Some code and memory allocation
*LOOK* useless. So review with care!
Looking are lore does not give any information about this code to me.
v1: https://lore.kernel.org/all/20200413164440.1138178-1-iskren.chernev@gmail.com/
v2: https://lore.kernel.org/all/20200414172250.2363235-1-iskren.chernev@gmail.com/

It *looks* like code written to release some resources in a .remove()
function, maybe used before switchwing to devm_ function.

Christophe JAILLET (2):
  regulator: max77826: Constify struct regulator_desc
  regulator: max77826: Simplify max77826_i2c_probe()

 drivers/regulator/max77826-regulator.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

-- 
2.46.0


