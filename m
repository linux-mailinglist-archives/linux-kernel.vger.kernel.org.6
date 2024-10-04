Return-Path: <linux-kernel+bounces-350049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A5198FF1E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A4B81F22161
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDF814265F;
	Fri,  4 Oct 2024 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=timo.grautstueck@web.de header.b="UkSpj0pg"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7195B12D75C;
	Fri,  4 Oct 2024 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728032174; cv=none; b=VyRqHRUYyr1Eo2jys8CM8UCOqT1MXjCtwZNhk98atFi41Ix0J2q+dikq7OtX3LLE7luefMdsw9892sPO+77bOQY+ixrfTETnBjcNFM1SFULS7Dd+ou3xZ1K49yPtj1mTaQACT0g5fBFhvcb1Wj4k0J5Ro139S4iVj7fFQtWp5zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728032174; c=relaxed/simple;
	bh=nrVrmqZTOz0jFICZVZXoeoi9T43rXBdnSsToU18xjdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VEtYQsCOmGcBNiHyr1KkqDbXKvn8wyWalYWN6OsS00zgZxEJG4Zoym5bN74+YU+IQehqqGUScn8WwHLR3MCPivzeOl64j3br50IoPHhkLp1mWRd/JXpsdAo4ggPD3m3F0u3KCNfUVOeTiRxVYY7M7znGaVtque4O3bGFFcwOvRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=timo.grautstueck@web.de header.b=UkSpj0pg; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728032164; x=1728636964; i=timo.grautstueck@web.de;
	bh=MZyv53s6FpMMt8ec7IEvvcKJ0aOKA10mDd3SOuvjVlU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UkSpj0pg1Dzv10NqsMhLlinrFDHbg5y+hSCVN8JRkm19HCv0i3dgek3TVSitih29
	 +SmsPOcpfwp5DjtZf0bpXdNi19iptweDCmWssdLIqyxo1lwrPoYkVNxayzvhiAH36
	 141epEdOjQV9x6X9SadC2h5FACTHJhZ3SIVN1B7OiwXadkz7kSGfyh2iulU/tUqff
	 gfRtBCUM7LbrZd9WwNNvrX4u40OnpNf+vedLr3WXG8x0PagjEhMI9c1BQ+m1hleJb
	 SWE3F6Fnwkz/woJp1pNPpJCeuGLCvx7sBAnT5bsaakEElGiKkYef3Zr7C18ZyYpis
	 lWuOR7c5a3Ikv2jG2Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([95.223.78.106]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MovnY-1s6EWL45mg-00nzff; Fri, 04 Oct 2024 10:56:04 +0200
From: =?UTF-8?q?Timo=20Grautst=C3=BCck?= <timo.grautstueck@web.de>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: =?UTF-8?q?Timo=20Grautst=C3=BCck?= <timo.grautstueck@web.de>,
	Miguel Ojeda <ojeda@kernel.org>,
	=?UTF-8?q?Timo=20Grautst=C3=BCck?= <timo.grautsautstueck@web.de>
Subject: [PATCH v2] lib/Kconfig.debug: fix grammar in RUST_BUILD_ASSERT_ALLOW
Date: Fri,  4 Oct 2024 10:55:33 +0200
Message-ID: <20241004085534.14407-1-timo.grautstueck@web.de>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <CANiq72kxOEt2Kb_rxY0+WD6uu=NXy+6PGMvGjTHfNFVXucgH7w@mail.gmail.com>
References: <CANiq72kxOEt2Kb_rxY0+WD6uu=NXy+6PGMvGjTHfNFVXucgH7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vozpf40kYbTVjN/CZ2Ehulgjvujj1wQVtUHWpAcKLnNC99z5con
 uc8umorfxPUp2kUiAds0eGaQGWP67aOsD4drsDAXxhS3gCV4/xCBT4hJkPTkbEw1E5Fktnt
 UA1KGjW+SI5c7+enrD07FlTp4hmhJnJ2QB7/Ai1TZD74rXY7YiwPRqP5KSg7LOWItToO+Ri
 esh1LairPU/BnISPhoP5w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CbyZVP5LGpo=;Myq/II5VuqPKJTQr619/NzsH0UR
 XudQypzeudY7TyNIiqPMbYc4Wminf5+D+B8Ahrz2W5Rw1nSI5n7E5LAzjFhWY5fz3lPg628zH
 37rruJ4mFo+HK+Ty/yKPeFqx3T2qlN7/bpc+glKJYETrp0eK7rYSv6aXmhgXjYZAKs1JowhOq
 nkgk02uu1RwKDw5UuhjBT1iwsxvF4rdL+FLeco0TDyZyP1nl7cXKQ8GXouv1wmwMIlAEWubYc
 T+mEcs997qI7cdG+5kSuoy80hIR2wlwirXiv9Gsztj1mYW7c6Je7zF3h9tmy7pTm74kSLs3VN
 rm/77IzgBRxWK5CUliPcu1nxHXbIJN4LuArK28cjTOkGsEYNaUZOuIEdaF6iLKwzsOaKpBAL/
 IpzxJSqOZTcd77cStlUWEncTxcmbAdMk8UM0nkD0UG3tonpWiISui3pBHEM9LDM/CHQ/lbz04
 JEs8OMmkbPLS1HEaUI8f6JHMgrr1WUToQmVb23TXBf091unox59bz/XflwFDHJKC+PJkE+mGR
 VFRYYnMTPnL39fNz7QkZxT96ZeKItxz4nCgECImkJHE+30RsEGsBMuO853YfEp/LJ3BgVB7h3
 upWMj5D3iWljv701LCbRzuNQ6zWIrGZb8hs94YMOKyBLEogwJFFa5z0+zcK8nsVL3ooRMKrp/
 zjw64mTbtQ9ooj6zlZ4CUMNlEd2vEF1kcdVdgBc1luGWi9iqbnMrUg4B0DmRtcpzdjdG1lX6u
 iA3AgFV9T9p2NpzhnuFq1d4zptNxKyDaxMSgYzUecuFN+IJgmZm+ecYXpB6dIAgTDe55SyWzs
 XHwkAAVerhuWqB5NiHM7/Xj3O0A+pDJvZFqm3RGqZQb4o=

Just a grammar fix in lib/Kconfig.debug, under the config option RUST_BUIL=
D_ASSERT_ALLOW.

Reported-by: Miguel Ojeda <ojeda@kernel.org>
Closes: https://github.com/Rust-for-Linux/linux/issues/1006
Fixes: ecaa6ddff2fd ("rust: add `build_error` crate")
Signed-off-by: Timo Grautst=C3=BCck <timo.grautsautstueck@web.de>
=2D--
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7315f643817a..7312ae7c3cc5 100644
=2D-- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -3060,7 +3060,7 @@ config RUST_BUILD_ASSERT_ALLOW
 	bool "Allow unoptimized build-time assertions"
 	depends on RUST
 	help
-	  Controls how are `build_error!` and `build_assert!` handled during bui=
ld.
+	  Controls how `build_error!` and `build_assert!` are handled during the=
 build.

 	  If calls to them exist in the binary, it may indicate a violated invar=
iant
 	  or that the optimizer failed to verify the invariant during compilatio=
n.
=2D-
2.44.0


