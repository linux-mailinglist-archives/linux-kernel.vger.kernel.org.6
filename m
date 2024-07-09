Return-Path: <linux-kernel+bounces-246533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 629D592C32F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92E2E1C22ADB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 18:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE788180020;
	Tue,  9 Jul 2024 18:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="Hk+Qoq1t"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4DC1B86ED
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 18:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720548873; cv=none; b=LY9GphAKUJnZfHPX0XTvZByuTqroGm2efbwIs1SzI/SIZT4rhHLbKLsiKeSsU+65YXWIfEzZ/RYWc6T+0KY0ugoORVnnDqcOVo+2c+KolGRHl8pG5+uDVAq5G6D5eg+LmMkCFOXGHmEamObbvCA3EirWVU8+BNHj/n/1J8twbW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720548873; c=relaxed/simple;
	bh=tGlEB/dnTClRP7UDoH1r1P9/dFHzQWGqsn6e/IiGyP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uTx23hftXE7dUxRptI6TQ4Xc3GFw0VJU3f5Yaixs5yNBjgRErDComy1vfuvBbG7OHAO2Ni31cf2FVIF3sSZaO1MvjW0JZA/b11q/NtCgtj9Ck+vK9AMsEdwQVn7lpi9NCnTcesi/gaXNmh7taZE/UFYNwQY/eL2DM/Xk8Z1FjGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=Hk+Qoq1t; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720548863; x=1721153663; i=spasswolf@web.de;
	bh=pvfZx7y8E1TdfIy/gTPyRA7rGV6JmvVgIfemiIGeorc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=Hk+Qoq1teXyvhOERlOy2Io7jjJygRF5ZK2EZ8puz8BJis8MJUSrIlfnoZUtYpxJC
	 pTSKTwmkOwaS1gEX4gXgaCQDTTqWml1yt2QetyrPTEA6UCYCAtQBtRQhwOC3MbGPf
	 Wg5TEjH+xZg/eC66f4sYVkZamhczIjetuUmO4Mel8ZnJTNVIkyubg8H7BRpC6H3dZ
	 OEHJQuibzHhvS5xDn9VOsxUKU8bJ/qlcD/RIhrbDSnN0gPGWgk5Qsxw+kvlqW50gT
	 hjGdZM2pqhr+D240lb6NjARbX5utHawGBKYKmOuNJKY9PDwn2ezlEmOnZTiaRqRPh
	 M9HSlg8FrVXVAAIKuw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1M6HG8-1sTQ8t35o0-008DnM; Tue, 09 Jul 2024 20:14:23 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-kernel@vger.kernel.org
Subject: commit 8ef052389f7f breaks make bindeb-pkg
Date: Tue,  9 Jul 2024 20:14:20 +0200
Message-ID: <20240709181422.156829-1-spasswolf@web.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:cfDGUEfJL2Lb5vFFfmh0OyALjxZGkwKhNk+JsZFsyrZqBLaNLgH
 Ug6MIMpSA5Lvo6xXQkmutDo4oviaEoXal90Fp1Wi7PDzCLOHkdO8qI4qrfOlsin5O7aPHcG
 VaHnImC9eDuJvE63bUyxntdGpC9sGjgMnCxiu1/WL/oGV0MaVff+E6lcavnQI+FKT21um+e
 XK8O39hPnBaUx8gRKdF2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oaX4wWO4By8=;DskN+o/pKGYy2cgF0wpcCXgtYvW
 rhLD+KWCdnPWvhcwvUrl4d8ct4iW6VhySqUwfnr8VgfdIj0WmQ5tgx9V4+b0fOapCYAYwOR6z
 v2OnW1MMHLxUoRW7NhqqYM0KHi/d/FtmLt3BQdx10RkZUzH+QRslwkW52s4mj5pL59HaaJUL0
 XEy7AAtjGKwhqxckcEey3fMLuo+VxuCyWCg4HLE8bdPvQE16Nqm1MMsJV0fDD5VKqCYZkqt/R
 9nvCGFCswthoASqlI0WFMWh1gNALVrXO3qaIxvn43Jh9pCQ1yVou869DcSmrCsFfO6VrwBEmV
 Xpe44TYfq7p0EAfnaHKuqGfK4P8Bu3kXmBUjryEcPmnwyNsie0nhKXfk786/ZCedQn5A8Wj1a
 PiMiLaB9YvTalPsc4Dd+K/y1Rz9Dzb8u1vXMh0b173JGYHRK6XnmhOdyvHVLg2snz6LYxompl
 5PrZaDB/YF4cC1Nqg7N87YavsxLXL1rZMDHmec7SSjZAUF66pLLVFDLZon+WbLHoPZkbcEAhz
 oZEybbvhozPSE0AwF852WUa9QAl6kfR3/A4vZA6Eq7LawGb+4OcfRlh+PRRpJ7VNkk6n+l6Nr
 Jfxy9n1hjyLGLMsc2z6rW4QjWPCppw739HsaiFbBywsKawrEGHBxt5eSY/ILS4gbABVp2Qrqw
 cDD/Grf8NY4Lb8YKnJ8WRBp+j0pLuKbLMnWZIAd42MW/tWZA2fazVe6oZNzU0taihUSpFKKMu
 uJUWwQdjJJVV/jGyjIl96OJtmYyFnzUaE7NKrQ0BBudONWBtv5CBZHqzfQEhcFfU08MZRsQ/P
 ahvE45ZAsmnP7J8nQi7qxznw==

Since linux-next-20240709 "make bindeb-pkg" fails with this error message:

$ make bindeb-pkg
   GEN     debian
 ./scripts/package/mkdebian: 138: 1: parameter not set
 make[2]: *** [scripts/Makefile.package:98: debian] Error 2
 make[1]: *** [/mnt/data/linux-forest/linux-next/Makefile:1538: bindeb-pkg] Error 2
 make: *** [Makefile:224: __sub-make] Error 2

Reverting commit 8ef052389f7f fixes the issue. make deb-pkg is not affected and
works as usual.

Bert Karwatzki

