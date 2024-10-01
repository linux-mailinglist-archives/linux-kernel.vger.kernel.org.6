Return-Path: <linux-kernel+bounces-346416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A8298C489
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E6B21F242B3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE261CCEE2;
	Tue,  1 Oct 2024 17:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b="mcMKs5zs"
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.129.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3101CC8B4
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 17:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727803934; cv=none; b=KKVXXfA4FCMbd6tCOK21JzJ1ShtyWQz9AqxeZr7JPS8pUeTYrpEYOr+KRQOzBqh6pue03TCPgcHvgur68rY1YDNfYz02LXYDNzEP5RmCM3Lrg9f/fVikH0CS42GsawKDR0e3b25XrrDrOVH36SF3Oac11R5DQJ1kwIbuvCbop88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727803934; c=relaxed/simple;
	bh=mtqObfXgLYJ048H8y2GtYJDqsZj6puboQCx0Bpj5QOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hc7NdnqxzeWwMbfPPkddZZbrhfBEvNIukilYPclC2J/4u0+BlrfSyfZDvesOXlyp9RsnK+rrZsdMyaGCMRG65HLgWE/1kJaO7WHpmYUldNdC/xENNb6tFvHPWdTcy7I58wEl+Z/IrCUrYikOVgwsFkX3KjPsWiHHcyFhKR1PAVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com; spf=pass smtp.mailfrom=hp.com; dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b=mcMKs5zs; arc=none smtp.client-ip=170.10.129.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
	t=1727803930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mtqObfXgLYJ048H8y2GtYJDqsZj6puboQCx0Bpj5QOQ=;
	b=mcMKs5zskf99NgpqAElZz0BHd4yVUggDM+LOprxoJCshygaj3WeB/Rc6IkyAVJk9d4JsqO
	dhUbSHZzEQI1oP57UooAsD2QG7fOAIUiRMpw1yIszjjOwaCXB4+gucBLdKxp3b86I9TO7c
	Np8Sk8206J/FtuAKKg7AQZlmHBS4f+E=
Received: from g8t13017g.inc.hp.com (hpi-bastion.austin2.mail.core.hp.com
 [15.72.64.135]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-zKK06PPyPqWyIvY9Rx75Gg-1; Tue, 01 Oct 2024 13:32:09 -0400
X-MC-Unique: zKK06PPyPqWyIvY9Rx75Gg-1
Received: from g7t14407g.inc.hpicorp.net (g7t14407g.inc.hpicorp.net [15.63.19.131])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by g8t13017g.inc.hp.com (Postfix) with ESMTPS id 3E51E60008BE;
	Tue,  1 Oct 2024 17:32:08 +0000 (UTC)
Received: from localhost.localdomain (unknown [15.53.255.151])
	by g7t14407g.inc.hpicorp.net (Postfix) with ESMTP id 76B2718;
	Tue,  1 Oct 2024 17:32:06 +0000 (UTC)
From: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: qin.wan@hp.com,
	andreas.noever@gmail.com,
	michael.jamet@intel.com,
	mika.westerberg@linux.intel.com,
	YehezkelShB@gmail.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gil Fine <gil.fine@linux.intel.com>,
	Alexandru Gagniuc <alexandru.gagniuc@hp.com>
Subject: [PATCH 6.6 04/14] thunderbolt: Create multiple DisplayPort tunnels if there are more DP IN/OUT pairs
Date: Tue,  1 Oct 2024 17:30:59 +0000
Message-Id: <20241001173109.1513-5-alexandru.gagniuc@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001173109.1513-1-alexandru.gagniuc@hp.com>
References: <20241001173109.1513-1-alexandru.gagniuc@hp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true

From: Gil Fine <gil.fine@linux.intel.com>

[ Upstream commit 8648c6465c025c488e2855c209c0dea1a1a15184 ]

Currently we only create one DisplayPort tunnel even if there would be
more DP IN/OUT pairs available. Specifically this happens when a router
is unplugged and we check if a new DisplayPort tunnel can be created. To
cover this create tunnels as long as we find suitable DP IN/OUT pairs.

Signed-off-by: Gil Fine <gil.fine@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Qin Wan <qin.wan@hp.com>
Signed-off-by: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
---
 drivers/thunderbolt/tb.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 6fc300edad68..e37fb1081420 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -1282,18 +1282,13 @@ static struct tb_port *tb_find_dp_out(struct tb *tb=
, struct tb_port *in)
 =09return NULL;
 }
=20
-static void tb_tunnel_dp(struct tb *tb)
+static bool tb_tunnel_one_dp(struct tb *tb)
 {
 =09int available_up, available_down, ret, link_nr;
 =09struct tb_cm *tcm =3D tb_priv(tb);
 =09struct tb_port *port, *in, *out;
 =09struct tb_tunnel *tunnel;
=20
-=09if (!tb_acpi_may_tunnel_dp()) {
-=09=09tb_dbg(tb, "DP tunneling disabled, not creating tunnel\n");
-=09=09return;
-=09}
-
 =09/*
 =09 * Find pair of inactive DP IN and DP OUT adapters and then
 =09 * establish a DP tunnel between them.
@@ -1321,11 +1316,11 @@ static void tb_tunnel_dp(struct tb *tb)
=20
 =09if (!in) {
 =09=09tb_dbg(tb, "no suitable DP IN adapter available, not tunneling\n");
-=09=09return;
+=09=09return false;
 =09}
 =09if (!out) {
 =09=09tb_dbg(tb, "no suitable DP OUT adapter available, not tunneling\n");
-=09=09return;
+=09=09return false;
 =09}
=20
 =09/*
@@ -1398,7 +1393,7 @@ static void tb_tunnel_dp(struct tb *tb)
 =09 * TMU mode to HiFi for CL0s to work.
 =09 */
 =09tb_increase_tmu_accuracy(tunnel);
-=09return;
+=09return true;
=20
 err_free:
 =09tb_tunnel_free(tunnel);
@@ -1413,6 +1408,19 @@ static void tb_tunnel_dp(struct tb *tb)
 =09pm_runtime_put_autosuspend(&out->sw->dev);
 =09pm_runtime_mark_last_busy(&in->sw->dev);
 =09pm_runtime_put_autosuspend(&in->sw->dev);
+
+=09return false;
+}
+
+static void tb_tunnel_dp(struct tb *tb)
+{
+=09if (!tb_acpi_may_tunnel_dp()) {
+=09=09tb_dbg(tb, "DP tunneling disabled, not creating tunnel\n");
+=09=09return;
+=09}
+
+=09while (tb_tunnel_one_dp(tb))
+=09=09;
 }
=20
 static void tb_enter_redrive(struct tb_port *port)
--=20
2.45.1


