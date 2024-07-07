Return-Path: <linux-kernel+bounces-243762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D68A929A49
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 01:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A22EB20B26
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 23:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5752F6F307;
	Sun,  7 Jul 2024 23:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b="aYhVuAxJ"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60ABEDC;
	Sun,  7 Jul 2024 23:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720396000; cv=none; b=cb9gJ7WtSkZxpYIxp+JH/ghSFtnR3ObgBimi+reGIC9k5f2eAGLYA0PSUK8r+f6aItmz0oA3ibRo4qef/V7B/IqUh2qhyg5X0B61d+6qVpfgOAjhChwAQ00/gwff0hOp6Uixy2UkcGYfSqwi/EGHQlxuzyEB95VpaTXhwUJt5fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720396000; c=relaxed/simple;
	bh=YBIknbPmP/gC3iEdT9TtGHjy8Ez01enWUTUdlcya8ZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JOgXWNycjQ7ECUgRScHgehX8Hv5n4IKOokdlziZABDI6aHSnU90q+TrbANDEHiKfsNhFQqX/PR1XgCDq5e57hH9dRp/jWl1A6hj+Xs07dYmtgpKJvp2oPAlN/plQ91z1fdkJaT6BzMAF9GMJC4FASiANB36wXhVbn+YZDuQVvEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b=aYhVuAxJ; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1720395977; x=1721000777; i=j.neuschaefer@gmx.net;
	bh=7DTL/8LaJiIPam54pK6YxSure4JmYjjvwTs/TySvgjc=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aYhVuAxJi2aGA+/w2adtjfvzwkUxcVYh9mMyk5pd023lcey5Pavcn0NVldYlf8j/
	 qmFhwhKaES5gXoZ+04jN1YRheQ+oUAH3rUalx8s3otpEzop2BRD1VGQO4TGzwpLgy
	 9daGq9YEs/WvvDw7VGWiPFGTTADjTWlBwOuQgxaiauv0f/P+X/oPBnBvwqSpf636x
	 NBvVppZ9yAsbas/l9wbah39N8iv4H6eGp+zA1QB44QlToHbBJ6TZbVYqOtrSAu8G3
	 LvoVoWlpNNEosXc8s1ZWJuCnvt6SzjeNcB+l9+Hs4+4HGXlOqC8KegR+Z6mzlJ8Kb
	 mzxwtA1alkYHdx9UwQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([89.0.46.161]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlw7V-1rzUJG0anr-00jUpI; Mon, 08
 Jul 2024 01:46:17 +0200
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Date: Mon, 08 Jul 2024 01:46:15 +0200
Subject: [PATCH] clk: hisilicon: Improve deallocation in error path
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20240708-hisi-error-v1-1-727bc7399b63@gmx.net>
X-B4-Tracking: v=1; b=H4sIAMYoi2YC/x2MQQqAIBAAvxJ7TrAtsPpKdBBdcy8aK0Qg/j3pO
 DAzFQoJU4F9qCD0cOGcOkzjAC7adJFi3xlQ46Jn3FTsiiKRLMppbb0Jq/cGoQe3UOD3nx1nax/
 7VrXpXAAAAA==
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: Tao Lan <taolan@huawei.com>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720395975; l=1226;
 i=j.neuschaefer@gmx.net; s=20240329; h=from:subject:message-id;
 bh=+2q4hljr86DryOi9DmowpLjNvXSlGfZoQsGX4Ck3nOU=;
 b=2HeqUHRiU7B6ynV0+1CJPO9RQ5VL5o9eFZadal0z76UiZh08ZsQvMmN2jhN1lvptBS0nSQCXO
 0oD+Bz+jYtvCtRRZJWKIPEQ4dF+qTrYPrNjxGkxwjlbFGTTGp5Lg/hp
X-Developer-Key: i=j.neuschaefer@gmx.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Provags-ID: V03:K1:2p68eadT7F/khkW992uUbnqxY1bcr2o0E7OL55ETl98+TI5rq8Z
 kuc1OBxz8RUoriXx/V9+2Oux2UKci+MviLmJpjjexpbK5StXyP16xq95CfimROg1mu5ohcL
 0Twi9DDYF7Lttq8AXa3SbAKftp8St+BJdBSU6U57NxMb3RvDkXgi8BcglxLQsSsXUkQU+SJ
 NDdA40glZI4hIVbkGPvvA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H+QpUP3iP3k=;2NzKkuvbOl4KFY7zOr8ETv8R/wk
 oWLtZnAUAbF2KpTf+q524ZzjYKC/5TYtuCwF2GKggjJW12tgVxlv8G7bv3s1Y2H5iImLhXsRS
 Cr8ZKj8lhz87JGGakK1spAOsZM/8f5OAvpeyuyGusn4XI6nNVdjrr/mSNAsjuVmR49iGPTu0K
 J64kdGalN8CTxD3R4tVuUvKat27lb7mU1T3GE424GFbNyvGK1/ib0Dlwj4EaqjrBhya3HOYWN
 tjo5MPglIkX+kAPtR7k+7ePK0Rkn8qw2DUy8fOKUJaYsx/SXNBYXOzhq4kbF5dOL1h4oIbO6X
 kzcfRhQJ+BEhI6oFR8jMwarTNoF7MiJ5irLd4hVZlhzs2UdJJ4Da+ZMQBFrkbT0VEgHaD8NtW
 YTQl4bKXsEXlyb4CUA+WTw6MKZr4tAnCKv2h7U25hfIpOgbDV7bX9QJq8Q9KSeHr0pt0b3ByA
 rmgr/ndmUc6JSbJEtL7BVFmdTw1bx2sumC8mlnMWveAQ5aVZaDR64MNkr5jjJmNzUiwNCVBNi
 6N2WmJiA4y8n6viNNDmjjQegNTTi0dTSUXLeqy0Po8hO3exW82qg2u0YxgpQoZI/ckHiQBOay
 kOr/4G6HmBznrE2D1P5ieqfOpkixkkgG8SS856/gaV2lLX35aeIPPf7jztMGmBY1aCkqoKNxV
 ht+mHRxwJqXARl1lSI27F9Ds5eHng1Ks+0IZ+u11Lyr/L1kRWWPA1A1dsvntU6a/DESQ/2dJ1
 p6JF990RTXzgsLt2xSEJ5+PTry+BWTaiXtC7rqcHztLDCVgFQ6ebJgPQu9r7OcN7/tcOMMGqG
 Dym8XlOpJNtznJEbGjt7hPgy9PJkfNRFKrI4KL0tQmel8=

The error handling in hisi_clk_init doesn't deallocate (unmap) the
'base' mapping if an error happens later in the function.

Reported-by: Tao Lan <taolan@huawei.com>
Closes: https://lore.kernel.org/lkml/ZNlSH+eWV8Sk3FYn@probook/
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/clk/hisilicon/clk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/hisilicon/clk.c b/drivers/clk/hisilicon/clk.c
index 09368fd32befb3..72aad24a5ebb26 100644
=2D-- a/drivers/clk/hisilicon/clk.c
+++ b/drivers/clk/hisilicon/clk.c
@@ -70,7 +70,7 @@ struct hisi_clock_data *hisi_clk_init(struct device_node=
 *np,

 	clk_data =3D kzalloc(sizeof(*clk_data), GFP_KERNEL);
 	if (!clk_data)
-		goto err;
+		goto err_base;

 	clk_data->base =3D base;
 	clk_table =3D kcalloc(nr_clks, sizeof(*clk_table), GFP_KERNEL);
@@ -83,6 +83,8 @@ struct hisi_clock_data *hisi_clk_init(struct device_node=
 *np,
 	return clk_data;
 err_data:
 	kfree(clk_data);
+err_base:
+	iounmap(base);
 err:
 	return NULL;
 }

=2D--
base-commit: 22a40d14b572deb80c0648557f4bd502d7e83826
change-id: 20240329-hisi-error-c00ad7f8dd72

Best regards,
=2D-
Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>


