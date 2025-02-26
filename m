Return-Path: <linux-kernel+bounces-533087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A66A45597
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A6C17528B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417A71DED6D;
	Wed, 26 Feb 2025 06:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H//yTQ/U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEE21E868
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740551459; cv=none; b=tuN3ufGfKL8HeQeACEXJmiHIiJsrbuvVOhHBrFpd2wWoErgzpelmnaq8hehlrGXxmWR6xzdRHVYv180VhpHPb4wkkbRV190WfqkHhri9H3iptERDm+zbRA5xIjn2N7AzNCP/yZWZqQJnpiYsJ0TTJSi+xZcnt+JjrHxYFFcviVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740551459; c=relaxed/simple;
	bh=PNzJDRck8w9k2W5MK20RtwHYW1hgZkDx496p2FYd7RI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bgt8KryaCjzl6dXZ1IleaomN1e3z6yxvQ2afWJM9xP2vZ6u6a+lxcz7Kqo3hSRaiDC5tmzkAcrA236wBmsYFY71X51srIOe+LG5j2D0SoyLwaEz4cEus/r4/bVZ3UpgEAkyjeAKN/D1rXICR8JDTYK9rVNJ5gjkkt6RXaUdd+bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H//yTQ/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0EBC4CED6;
	Wed, 26 Feb 2025 06:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740551458;
	bh=PNzJDRck8w9k2W5MK20RtwHYW1hgZkDx496p2FYd7RI=;
	h=From:To:Cc:Subject:Date:From;
	b=H//yTQ/UVZz1NjkvheJJZciemEiygaznll41MItPtrY3Dte0Y7xBpDtGA9QDPwsBK
	 gLbVQZXdOv1uiXjxoMI05uPA/qMzIvNwiwjzVwPyN9MAZVhn1CS92JVifPd8eG3tFQ
	 Zk4hvqcUEE6IRA9N4OYBIOY4UeunYVFNhkvjL0jPt3h/A3WLJ/s4ijLuC4ZWeCwS1c
	 DHTyEVZ48kjeEiUQtuvnB6j9kmPORUfaNPtyoqRNXtVV1W1pXhq2FmQGLwYhBFCFq3
	 8wUFC+EJquwQ7u2KR9lzeuAC82QZItmlm2DWuQorHCioHBrchsSum5zX6vzRr62S/+
	 vz4Co8/hsetdg==
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] nvmet-tcp: switch to using the crc32c library
Date: Tue, 25 Feb 2025 22:28:40 -0800
Message-ID: <20250226062841.60688-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Now that the crc32c() library function directly takes advantage of
architecture-specific optimizations, it is unnecessary to go through the
crypto API.  Just use crc32c().  This is much simpler, and it improves
performance due to eliminating the crypto API overhead.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/nvme/target/tcp.c | 92 +++++++++++----------------------------
 1 file changed, 26 insertions(+), 66 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 7c51c2a8c109a..b1da98481c186 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -5,10 +5,11 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/crc32c.h>
 #include <linux/err.h>
 #include <linux/key.h>
 #include <linux/nvme-tcp.h>
 #include <linux/nvme-keyring.h>
 #include <net/sock.h>
@@ -16,11 +17,10 @@
 #include <net/tls.h>
 #include <net/tls_prot.h>
 #include <net/handshake.h>
 #include <linux/inet.h>
 #include <linux/llist.h>
-#include <crypto/hash.h>
 #include <trace/events/sock.h>
 
 #include "nvmet.h"
 
 #define NVMET_TCP_DEF_INLINE_DATA_SIZE	(4 * PAGE_SIZE)
@@ -171,12 +171,10 @@ struct nvmet_tcp_queue {
 	union nvme_tcp_pdu	pdu;
 
 	/* digest state */
 	bool			hdr_digest;
 	bool			data_digest;
-	struct ahash_request	*snd_hash;
-	struct ahash_request	*rcv_hash;
 
 	/* TLS state */
 	key_serial_t		tls_pskid;
 	struct delayed_work	tls_handshake_tmo_work;
 
@@ -293,18 +291,13 @@ static inline u8 nvmet_tcp_hdgst_len(struct nvmet_tcp_queue *queue)
 static inline u8 nvmet_tcp_ddgst_len(struct nvmet_tcp_queue *queue)
 {
 	return queue->data_digest ? NVME_TCP_DIGEST_LENGTH : 0;
 }
 
-static inline void nvmet_tcp_hdgst(struct ahash_request *hash,
-		void *pdu, size_t len)
+static inline void nvmet_tcp_hdgst(void *pdu, size_t len)
 {
-	struct scatterlist sg;
-
-	sg_init_one(&sg, pdu, len);
-	ahash_request_set_crypt(hash, &sg, pdu + len, len);
-	crypto_ahash_digest(hash);
+	put_unaligned_le32(~crc32c(~0, pdu, len), pdu + len);
 }
 
 static int nvmet_tcp_verify_hdgst(struct nvmet_tcp_queue *queue,
 	void *pdu, size_t len)
 {
@@ -317,11 +310,11 @@ static int nvmet_tcp_verify_hdgst(struct nvmet_tcp_queue *queue,
 			queue->idx);
 		return -EPROTO;
 	}
 
 	recv_digest = *(__le32 *)(pdu + hdr->hlen);
-	nvmet_tcp_hdgst(queue->rcv_hash, pdu, len);
+	nvmet_tcp_hdgst(pdu, len);
 	exp_digest = *(__le32 *)(pdu + hdr->hlen);
 	if (recv_digest != exp_digest) {
 		pr_err("queue %d: header digest error: recv %#x expected %#x\n",
 			queue->idx, le32_to_cpu(recv_digest),
 			le32_to_cpu(exp_digest));
@@ -440,16 +433,28 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
 err:
 	nvmet_tcp_free_cmd_buffers(cmd);
 	return NVME_SC_INTERNAL;
 }
 
-static void nvmet_tcp_calc_ddgst(struct ahash_request *hash,
-		struct nvmet_tcp_cmd *cmd)
+static void nvmet_tcp_calc_ddgst(struct nvmet_tcp_cmd *cmd)
 {
-	ahash_request_set_crypt(hash, cmd->req.sg,
-		(void *)&cmd->exp_ddgst, cmd->req.transfer_len);
-	crypto_ahash_digest(hash);
+	size_t total_len = cmd->req.transfer_len;
+	struct scatterlist *sg = cmd->req.sg;
+	u32 crc = ~0;
+
+	while (total_len) {
+		size_t len = min_t(size_t, total_len, sg->length);
+
+		/*
+		 * Note that the scatterlist does not contain any highmem pages,
+		 * as it was allocated by sgl_alloc() with GFP_KERNEL.
+		 */
+		crc = crc32c(crc, sg_virt(sg), len);
+		total_len -= len;
+		sg = sg_next(sg);
+	}
+	cmd->exp_ddgst = cpu_to_le32(~crc);
 }
 
 static void nvmet_setup_c2h_data_pdu(struct nvmet_tcp_cmd *cmd)
 {
 	struct nvme_tcp_data_pdu *pdu = cmd->data_pdu;
@@ -472,23 +477,22 @@ static void nvmet_setup_c2h_data_pdu(struct nvmet_tcp_cmd *cmd)
 	pdu->data_length = cpu_to_le32(cmd->req.transfer_len);
 	pdu->data_offset = cpu_to_le32(cmd->wbytes_done);
 
 	if (queue->data_digest) {
 		pdu->hdr.flags |= NVME_TCP_F_DDGST;
-		nvmet_tcp_calc_ddgst(queue->snd_hash, cmd);
+		nvmet_tcp_calc_ddgst(cmd);
 	}
 
 	if (cmd->queue->hdr_digest) {
 		pdu->hdr.flags |= NVME_TCP_F_HDGST;
-		nvmet_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
+		nvmet_tcp_hdgst(pdu, sizeof(*pdu));
 	}
 }
 
 static void nvmet_setup_r2t_pdu(struct nvmet_tcp_cmd *cmd)
 {
 	struct nvme_tcp_r2t_pdu *pdu = cmd->r2t_pdu;
-	struct nvmet_tcp_queue *queue = cmd->queue;
 	u8 hdgst = nvmet_tcp_hdgst_len(cmd->queue);
 
 	cmd->offset = 0;
 	cmd->state = NVMET_TCP_SEND_R2T;
 
@@ -502,18 +506,17 @@ static void nvmet_setup_r2t_pdu(struct nvmet_tcp_cmd *cmd)
 	pdu->ttag = nvmet_tcp_cmd_tag(cmd->queue, cmd);
 	pdu->r2t_length = cpu_to_le32(cmd->req.transfer_len - cmd->rbytes_done);
 	pdu->r2t_offset = cpu_to_le32(cmd->rbytes_done);
 	if (cmd->queue->hdr_digest) {
 		pdu->hdr.flags |= NVME_TCP_F_HDGST;
-		nvmet_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
+		nvmet_tcp_hdgst(pdu, sizeof(*pdu));
 	}
 }
 
 static void nvmet_setup_response_pdu(struct nvmet_tcp_cmd *cmd)
 {
 	struct nvme_tcp_rsp_pdu *pdu = cmd->rsp_pdu;
-	struct nvmet_tcp_queue *queue = cmd->queue;
 	u8 hdgst = nvmet_tcp_hdgst_len(cmd->queue);
 
 	cmd->offset = 0;
 	cmd->state = NVMET_TCP_SEND_RESPONSE;
 
@@ -522,11 +525,11 @@ static void nvmet_setup_response_pdu(struct nvmet_tcp_cmd *cmd)
 	pdu->hdr.hlen = sizeof(*pdu);
 	pdu->hdr.pdo = 0;
 	pdu->hdr.plen = cpu_to_le32(pdu->hdr.hlen + hdgst);
 	if (cmd->queue->hdr_digest) {
 		pdu->hdr.flags |= NVME_TCP_F_HDGST;
-		nvmet_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
+		nvmet_tcp_hdgst(pdu, sizeof(*pdu));
 	}
 }
 
 static void nvmet_tcp_process_resp_list(struct nvmet_tcp_queue *queue)
 {
@@ -849,46 +852,10 @@ static void nvmet_prepare_receive_pdu(struct nvmet_tcp_queue *queue)
 	queue->left = sizeof(struct nvme_tcp_hdr);
 	queue->cmd = NULL;
 	queue->rcv_state = NVMET_TCP_RECV_PDU;
 }
 
-static void nvmet_tcp_free_crypto(struct nvmet_tcp_queue *queue)
-{
-	struct crypto_ahash *tfm = crypto_ahash_reqtfm(queue->rcv_hash);
-
-	ahash_request_free(queue->rcv_hash);
-	ahash_request_free(queue->snd_hash);
-	crypto_free_ahash(tfm);
-}
-
-static int nvmet_tcp_alloc_crypto(struct nvmet_tcp_queue *queue)
-{
-	struct crypto_ahash *tfm;
-
-	tfm = crypto_alloc_ahash("crc32c", 0, CRYPTO_ALG_ASYNC);
-	if (IS_ERR(tfm))
-		return PTR_ERR(tfm);
-
-	queue->snd_hash = ahash_request_alloc(tfm, GFP_KERNEL);
-	if (!queue->snd_hash)
-		goto free_tfm;
-	ahash_request_set_callback(queue->snd_hash, 0, NULL, NULL);
-
-	queue->rcv_hash = ahash_request_alloc(tfm, GFP_KERNEL);
-	if (!queue->rcv_hash)
-		goto free_snd_hash;
-	ahash_request_set_callback(queue->rcv_hash, 0, NULL, NULL);
-
-	return 0;
-free_snd_hash:
-	ahash_request_free(queue->snd_hash);
-free_tfm:
-	crypto_free_ahash(tfm);
-	return -ENOMEM;
-}
-
-
 static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
 {
 	struct nvme_tcp_icreq_pdu *icreq = &queue->pdu.icreq;
 	struct nvme_tcp_icresp_pdu *icresp = &queue->pdu.icresp;
 	struct msghdr msg = {};
@@ -913,15 +880,10 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
 		return -EPROTO;
 	}
 
 	queue->hdr_digest = !!(icreq->digest & NVME_TCP_HDR_DIGEST_ENABLE);
 	queue->data_digest = !!(icreq->digest & NVME_TCP_DATA_DIGEST_ENABLE);
-	if (queue->hdr_digest || queue->data_digest) {
-		ret = nvmet_tcp_alloc_crypto(queue);
-		if (ret)
-			return ret;
-	}
 
 	memset(icresp, 0, sizeof(*icresp));
 	icresp->hdr.type = nvme_tcp_icresp;
 	icresp->hdr.hlen = sizeof(*icresp);
 	icresp->hdr.pdo = 0;
@@ -1238,11 +1200,11 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
 
 static void nvmet_tcp_prep_recv_ddgst(struct nvmet_tcp_cmd *cmd)
 {
 	struct nvmet_tcp_queue *queue = cmd->queue;
 
-	nvmet_tcp_calc_ddgst(queue->rcv_hash, cmd);
+	nvmet_tcp_calc_ddgst(cmd);
 	queue->offset = 0;
 	queue->left = NVME_TCP_DIGEST_LENGTH;
 	queue->rcv_state = NVMET_TCP_RECV_DDGST;
 }
 
@@ -1607,12 +1569,10 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	cancel_work_sync(&queue->io_work);
 	nvmet_tcp_free_cmd_data_in_buffers(queue);
 	/* ->sock will be released by fput() */
 	fput(queue->sock->file);
 	nvmet_tcp_free_cmds(queue);
-	if (queue->hdr_digest || queue->data_digest)
-		nvmet_tcp_free_crypto(queue);
 	ida_free(&nvmet_tcp_queue_ida, queue->idx);
 	page_frag_cache_drain(&queue->pf_cache);
 	kfree(queue);
 }
 

base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
-- 
2.48.1


