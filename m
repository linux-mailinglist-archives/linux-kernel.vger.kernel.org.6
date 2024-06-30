Return-Path: <linux-kernel+bounces-235375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C13B391D483
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771D71F20418
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB73158DBF;
	Sun, 30 Jun 2024 22:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="3SkPbDyS"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23DA7BAF7
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786683; cv=none; b=CpFPofwd/+2G/b/AJdoXt2SOsmryK+D7lBas7ZU9D6PwYuP9Iv9Y8MVy3+qOoCAgRffKiUwNgdNmjQ3cIBgmOtRZXzuPWUg3fx9JFht22EnSRLxRcBmlLOrzdU2UzXy8Tx/n3VwyB30k9vvxtPWwwJYImtq50Uf1Bb56OQVJsvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786683; c=relaxed/simple;
	bh=asA9zyHzeyAnHk88aGk0o/KHi+AtvRM+fM2tnIOltm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M19BwCkOetHtogRux5OqM2B69aPzoS6+MkdMliYAfrbFAsJpSM7w8/WJulZnrR5vcSrTKSnB0+2GBA2iazmmQW3DwbaOijZrGPXulqLk2dpA3jKzrMjLvMjekFXZ2g46a9wwTBPbsPd+QMo5nQLfwA21aeGgpfuYnhwb4Aduxj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=3SkPbDyS; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3mn1zVkzll9f8;
	Sun, 30 Jun 2024 22:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786672; x=1722378673; bh=tL0d7
	b4N9gLC1d6ulOeQ9qM2veIR+f6qkRnvep+H2u4=; b=3SkPbDySE+Bo8pdkMJKEN
	Biy/UJMs15XLQ5YgkPupvWH95hEtcO5GwnrDd2cPik3Y5qwjnQK4zGtlXjcuAd28
	Co9/SphEdqTEjjYus2ruxINdpA9gyynU73FDFi5dYeA33aOi/KwpH0Mhi0dKwqYI
	MkW3dkVSH9xqu8Bo/EOu6n2jR95jcYBqyYgvrEYbfmdnie8o5olfXesgciyEEvdI
	gpo+drcrm0vCURK4khwv9ZhwGAiQzCRuh8rXcsEB8YcfzdB52Ae7y6tEMu80+s5b
	GqGLSq1Kc66NQqVZnr22HrODgxOg5qlnoH6wdPNrv1icNAOpgNIl5fV5fikP69rI
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id mXFpjmj_DJq1; Sun, 30 Jun 2024 22:31:12 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3mX3qDCzll9fB;
	Sun, 30 Jun 2024 22:31:08 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Wei Zhang <weizhang@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Shay Drory <shayd@nvidia.com>
Subject: [PATCH 25/53] net/mlx5: Simplify the create*_workqueue() calls
Date: Sun, 30 Jun 2024 15:26:43 -0700
Message-ID: <20240630222904.627462-26-bvanassche@acm.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240630222904.627462-1-bvanassche@acm.org>
References: <20240630222904.627462-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Pass a format string to create*_workqueue2() instead of formatting the
workqueue name before create*_workqueue() is called.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c        | 12 ++----------
 drivers/net/ethernet/mellanox/mlx5/core/health.c     | 10 ++--------
 .../net/ethernet/mellanox/mlx5/core/sf/vhca_event.c  |  5 ++---
 include/linux/mlx5/driver.h                          |  5 -----
 4 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/=
ethernet/mellanox/mlx5/core/cmd.c
index 20768ef2e9d2..bbc7d0f2fd40 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -1560,14 +1560,6 @@ static const struct file_operations olfops =3D {
 	.read	=3D outlen_read,
 };
=20
-static void set_wqname(struct mlx5_core_dev *dev)
-{
-	struct mlx5_cmd *cmd =3D &dev->cmd;
-
-	snprintf(cmd->wq_name, sizeof(cmd->wq_name), "mlx5_cmd_%s",
-		 dev_name(dev->device));
-}
-
 static void clean_debug_files(struct mlx5_core_dev *dev)
 {
 	struct mlx5_cmd_debug *dbg =3D &dev->cmd.dbg;
@@ -2292,8 +2284,8 @@ int mlx5_cmd_init(struct mlx5_core_dev *dev)
 	spin_lock_init(&cmd->alloc_lock);
 	spin_lock_init(&cmd->token_lock);
=20
-	set_wqname(dev);
-	cmd->wq =3D create_singlethread_workqueue(cmd->wq_name);
+	cmd->wq =3D create_singlethread_workqueue2("mlx5_cmd_%s",
+						 dev_name(dev->device));
 	if (!cmd->wq) {
 		mlx5_core_err(dev, "failed to create command workqueue\n");
 		return -ENOMEM;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/health.c
index a6329ca2d9bf..1c46bced73cd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -869,7 +869,6 @@ int mlx5_health_init(struct mlx5_core_dev *dev)
 {
 	struct devlink *devlink =3D priv_to_devlink(dev);
 	struct mlx5_core_health *health;
-	char *name;
=20
 	if (!mlx5_dev_is_lightweight(dev)) {
 		devl_lock(devlink);
@@ -879,14 +878,9 @@ int mlx5_health_init(struct mlx5_core_dev *dev)
 	mlx5_reporter_vnic_create(dev);
=20
 	health =3D &dev->priv.health;
-	name =3D kmalloc(64, GFP_KERNEL);
-	if (!name)
-		goto out_err;
=20
-	strcpy(name, "mlx5_health");
-	strcat(name, dev_name(dev->device));
-	health->wq =3D create_singlethread_workqueue(name);
-	kfree(name);
+	health->wq =3D create_singlethread_workqueue2("mlx5_health%s",
+						    dev_name(dev->device));
 	if (!health->wq)
 		goto out_err;
 	INIT_WORK(&health->fatal_report_work, mlx5_fw_fatal_reporter_err_work);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.c b/dr=
ivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.c
index cda01ba441ae..b761350617df 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.c
@@ -148,7 +148,6 @@ void mlx5_vhca_state_cap_handle(struct mlx5_core_dev =
*dev, void *set_hca_cap)
 int mlx5_vhca_event_init(struct mlx5_core_dev *dev)
 {
 	struct mlx5_vhca_state_notifier *notifier;
-	char wq_name[MLX5_CMD_WQ_MAX_NAME];
 	struct mlx5_vhca_events *events;
 	int err, i;
=20
@@ -162,8 +161,8 @@ int mlx5_vhca_event_init(struct mlx5_core_dev *dev)
 	events->dev =3D dev;
 	dev->priv.vhca_events =3D events;
 	for (i =3D 0; i < MLX5_DEV_MAX_WQS; i++) {
-		snprintf(wq_name, MLX5_CMD_WQ_MAX_NAME, "mlx5_vhca_event%d", i);
-		events->handler[i].wq =3D create_singlethread_workqueue(wq_name);
+		events->handler[i].wq =3D
+			create_singlethread_workqueue2("mlx5_vhca_event%d", i);
 		if (!events->handler[i].wq) {
 			err =3D -ENOMEM;
 			goto err_create_wq;
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 779cfdf2e9d6..835b960b9fdc 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -66,10 +66,6 @@ enum {
 	MLX5_BOARD_ID_LEN =3D 64,
 };
=20
-enum {
-	MLX5_CMD_WQ_MAX_NAME	=3D 32,
-};
-
 enum {
 	CMD_OWNER_SW		=3D 0x0,
 	CMD_OWNER_HW		=3D 0x1,
@@ -317,7 +313,6 @@ struct mlx5_cmd {
 	 */
 	spinlock_t	token_lock;
 	u8		token;
-	char		wq_name[MLX5_CMD_WQ_MAX_NAME];
 	struct workqueue_struct *wq;
 	int	mode;
 	u16     allowed_opcode;

