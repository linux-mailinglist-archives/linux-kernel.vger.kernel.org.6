Return-Path: <linux-kernel+bounces-308516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3D6965DF7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5FE71F26325
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6729B17C22B;
	Fri, 30 Aug 2024 10:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alatek.krakow.pl header.i=@alatek.krakow.pl header.b="ZTZBHVrZ"
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C01917BB0C
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.14.123.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012315; cv=none; b=sTJj4svCfcgc7lIhuS4IUqtVikUA3wQ+77v165w/2L1WD1m9/t4nLUg/PGlzHW2TjjFNlV6/xuG2jWj0VvVL1GmiIBycKJaKxXlSYLwjQ0GAGxSTUOrZ1JWWFC8nS7rghf13A9uPmu7ZHRZwSUHKVQegaPLVx6avRPlNSRzoXEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012315; c=relaxed/simple;
	bh=Vrlvqslj4JlmYnw7Az+air7vL4zf7kGGzLKBvQTJ4zA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fTzhmp5yQ//ZlAA6dMuEd6gHgjNnOz9JuLsGy35ubE1wGu81rmZQTe+xh94gZCwnrjNV7LNEMCcJELrffFUw/NfYHCvDLDW05iRYyXU1W7lWFUL2QdfMkVqI454Z3feKPx71zYuNz4Bi6VZvep5tAMRlaM7SyQ/uBwyJCMMyqfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alatek.krakow.pl; spf=pass smtp.mailfrom=alatek.krakow.pl; dkim=pass (2048-bit key) header.d=alatek.krakow.pl header.i=@alatek.krakow.pl header.b=ZTZBHVrZ; arc=none smtp.client-ip=85.14.123.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alatek.krakow.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alatek.krakow.pl
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 06F072CC156A;
	Fri, 30 Aug 2024 11:57:20 +0200 (CEST)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id ff_wDXhiaJ06; Fri, 30 Aug 2024 11:57:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id C67B42CC1569;
	Fri, 30 Aug 2024 11:57:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl C67B42CC1569
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
	s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1725011835;
	bh=Vrlvqslj4JlmYnw7Az+air7vL4zf7kGGzLKBvQTJ4zA=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=ZTZBHVrZVQ0eIyhTho7cThY0qnbOQUFxXG7qdJIODT87Wq9Pd+x9sV5KCOK/lNLzo
	 mnuaVgKU45GHKL8whtGXDppSWZaaGGfn9C7AfDECkl/GiDlDozIdb+bd6vy/PRLe4V
	 1txkHC8AlZdn9ye5CiZzQHUHXzG1L+pvgFCSMhXUY7HOgXq6Ug+mMSGHezFSRt/gjE
	 PJti2d+OGDpIK1j/r6v1LLaOJbRkcSttdupoVA1Lrj/dVQGSrXwLkKjQwGokoZlICm
	 6PvYXuNhdubiATaBnDRgAQXV/qT1N9Cd+pJNGNn5tRd4AlGRFst0t2+AxszfcpWTMO
	 poSHHCKVwOM6g==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id UiVY3mNwyErH; Fri, 30 Aug 2024 11:57:15 +0200 (CEST)
Received: from ideapad.. (unknown [10.0.2.2])
	by helios.alatek.com.pl (Postfix) with ESMTPSA id 88D122CC1562;
	Fri, 30 Aug 2024 11:57:15 +0200 (CEST)
From: Jan Kuliga <jankul@alatek.krakow.pl>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	matttbe@kernel.org,
	davem@davemloft.net,
	jtkuliga.kdev@gmail.com,
	jankul@alatek.krakow.pl
Subject: [PATCH] mailmap: update entry for Jan Kuliga
Date: Fri, 30 Aug 2024 11:56:58 +0200
Message-Id: <20240830095658.1203198-1-jankul@alatek.krakow.pl>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Soon I won't be able to use my current email address.

Signed-off-by: Jan Kuliga <jankul@alatek.krakow.pl>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 8ee01d9d7046..5e27294d8343 100644
--- a/.mailmap
+++ b/.mailmap
@@ -269,6 +269,7 @@ James Ketrenos <jketreno@io.(none)>
 Jan Glauber <jan.glauber@gmail.com> <jang@de.ibm.com>
 Jan Glauber <jan.glauber@gmail.com> <jang@linux.vnet.ibm.com>
 Jan Glauber <jan.glauber@gmail.com> <jglauber@cavium.com>
+Jan Kuliga <jtkuliga.kdev@gmail.com> <jankul@alatek.krakow.pl>
 Jarkko Sakkinen <jarkko@kernel.org> <jarkko.sakkinen@linux.intel.com>
 Jarkko Sakkinen <jarkko@kernel.org> <jarkko@profian.com>
 Jarkko Sakkinen <jarkko@kernel.org> <jarkko.sakkinen@tuni.fi>
--=20
2.34.1


