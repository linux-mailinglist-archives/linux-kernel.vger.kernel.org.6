Return-Path: <linux-kernel+bounces-375981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FF99A9E2B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04879282F1C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2319D198846;
	Tue, 22 Oct 2024 09:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="3IEzWBcP";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="lRkHk3X7"
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F33194C96
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588555; cv=none; b=DiRaDVcfRM8aINGNGZwn4sY+XZ3N5B4QlShVAmMnj7jcaNzBRY3SifiD1uf3hPeCiO44EsmjTqhPaFEOxWveBGsSYRMsCQDNmy+mhCa0fHAJfkmKuAV+dO7zU2wzIFxk0MdJ3dVGRvnfqAkESDIun9BBEZVFPvAFC9oncY+fE2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588555; c=relaxed/simple;
	bh=7eFcQEIvBRhl18swlptD4ddj7Zc4ehZzReoGa/gH0zA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gGbSMIdwcf7kfMgdnTkPxmpi9u3+pTHZ9pfc4E6ftrfSF85kV+NhogLM+uzllixhqhaDI9EzuR5ItGp5V04209knw44uMGDlzQECyhmRacZR+zqAoMH8OuiCM6TbQwEY2lZizQduEGR2ZrUaznWXnpv2r1YkwEo7rOxVCTZnglk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=3IEzWBcP reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=lRkHk3X7; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1729589453; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=YfS8lecAdepFQaM/ZpxsCooHN0CCYe5nh7n3SVBoO7Q=; b=3IEzWBcPCrP2IGoQNkDphsgX6C
	JEiDkof/7N8/366ltm4GOmcL5JSs9POu2MeOkBzRD+BfgrG0L6GeVcMH6GkZoFKYOHbI85ajD5yMn
	PJF2/ZQFSIro2XvOP+ud4EeKSDhdABi4z4uqDzH80KpKxevEgW1ONuZ+LqdslQqAsj5FWyQjRfUhR
	eoMgZhBhWnXKgIQnEs/jLGBT8Sct0Oudo4IG8faj7UZbovfYt6iDI41gN0r2m4x0SgQyKmhIFtgig
	Xf1W0kVk2tGzXBfTueBA3ZzpIS5MMEPOgZTT1JV7hCHpXGgxnihxi4lZ7d5xw0NUPW2/U88UIo4G3
	sDW+QqLg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1729588553; h=from : subject
 : to : message-id : date;
 bh=YfS8lecAdepFQaM/ZpxsCooHN0CCYe5nh7n3SVBoO7Q=;
 b=lRkHk3X718zwUh3NtBtme2CGc/jmf38ccw+rLroW9o5aaqU0su0xpcOB6sZlkeH34GDxx
 QUITgFNWC3HmeAJyDz3K8bL/BulkdyWG32OGPVhZZGgtl1rTwDp4X55V/QNZwixVRxJ+A6I
 P0PiPg86O/TUn+Y3hLzxe/3dqog0JLR2o4SB5nIDv07qC0xPnFL9xkop3w2qNO4haS6o55X
 3h2924IRFLokFIxzRdWoSQVWum31HFkQjw869WBp7c5giOJUoPeT3XIfYQz9T4n7W8cyVtm
 zC87+nd/0mq4ytl7MMOF428+mgjvf7SOcklmtYzLIjh/CDDCy7HSFjiT4QWw==
Received: from [10.172.233.58] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1t3Ayq-TRk3tB-2w; Tue, 22 Oct 2024 09:15:08 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1t3Ayp-FnQW0hPkkwx-nGXk; Tue, 22 Oct 2024 09:15:07 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Cedric Veilleux <veilleux.cedric@gmail.com>,
 Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v2 1/2] wifi: ath10k: Implement ieee80211 flush_sta callback
Date: Tue, 22 Oct 2024 11:14:57 +0200
Message-Id: <cecfe1de13d74c59e3e6428ee4a9c99bd1572884.1729586267.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1729586267.git.repk@triplefau.lt>
References: <cover.1729586267.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: zKufZaB8Cfqc.Lq8Z4DGP_HOr.Tu3UhgWw7To
Feedback-ID: 510616m:510616apGKSTK:510616s5MvkDfj2Z
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

When a STA reassociates, mac80211's _sta_info_move_state() waits for all
pending frame to be flushed before removing the key (so that no frame
get sent unencrypted after key removable [0]). When a driver does not
implement the flush_sta callback, ieee80211_flush_queues() is called
instead which effectively stops the whole queue until it is completely
drained.

The ath10k driver configure all STAs of one vdev to share the same
queue. So when flushing one STA this is the whole vdev queue that is
blocked until completely drained causing Tx to other STA to also stall
this whole time.

One easy way to reproduce the issue is to connect two STAs (STA0 and
STA1) to an ath10k AP. While Generating a bunch of traffic from AP to
STA0 (e.g. fping -l -p 20 <STA0-IP>) disconnect STA0 from AP without
clean disassociation (e.g. remove power, reboot -f). Then as soon as
STA0 is effectively disconnected from AP (either after inactivity
timeout or forced with iw dev AP station del STA0), its queues get
flushed using ieee80211_flush_queues(). This causes STA1 to suffer a
connectivity stall for about 5 seconds (see ATH10K_FLUSH_TIMEOUT_HZ).

Implement a flush_sta callback in ath10k to wait only for a specific
STA pending frames to be drained (without stopping the whole HW queue)
to fix that.

[0]: commit 0b75a1b1e42e ("wifi: mac80211: flush queues on STA removal")

Reported-by: Cedric Veilleux <veilleux.cedric@gmail.com>
Closes: https://lore.kernel.org/all/CA+Xfe4FjUmzM5mvPxGbpJsF3SvSdE5_wgxvgFJ0bsdrKODVXCQ@mail.gmail.com/
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 drivers/net/wireless/ath/ath10k/core.h   |  2 ++
 drivers/net/wireless/ath/ath10k/htt.h    |  4 +++
 drivers/net/wireless/ath/ath10k/htt_tx.c | 31 ++++++++++++++++++
 drivers/net/wireless/ath/ath10k/mac.c    | 40 +++++++++++++++++++++++-
 drivers/net/wireless/ath/ath10k/txrx.c   |  9 ++++--
 5 files changed, 82 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index 446dca74f06a..4ec2faa055c0 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -558,6 +558,8 @@ struct ath10k_sta {
 	u8 rate_ctrl[ATH10K_TID_MAX];
 	u32 rate_code[ATH10K_TID_MAX];
 	int rtscts[ATH10K_TID_MAX];
+	wait_queue_head_t empty_tx_wq;
+	atomic_t num_fw_queued;
 };
 
 #define ATH10K_VDEV_SETUP_TIMEOUT_HZ	(5 * HZ)
diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/wireless/ath/ath10k/htt.h
index 603f6de62b0a..d150f9330941 100644
--- a/drivers/net/wireless/ath/ath10k/htt.h
+++ b/drivers/net/wireless/ath/ath10k/htt.h
@@ -2452,6 +2452,10 @@ int ath10k_htt_tx_inc_pending(struct ath10k_htt *htt);
 void ath10k_htt_tx_mgmt_dec_pending(struct ath10k_htt *htt);
 int ath10k_htt_tx_mgmt_inc_pending(struct ath10k_htt *htt, bool is_mgmt,
 				   bool is_presp);
+void ath10k_htt_tx_sta_inc_pending(struct ath10k_htt *htt,
+				   struct ieee80211_sta *sta);
+void ath10k_htt_tx_sta_dec_pending(struct ath10k_htt *htt,
+				   struct ieee80211_sta *sta);
 
 int ath10k_htt_tx_alloc_msdu_id(struct ath10k_htt *htt, struct sk_buff *skb);
 void ath10k_htt_tx_free_msdu_id(struct ath10k_htt *htt, u16 msdu_id);
diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
index 9725feecefd6..211752bd0f65 100644
--- a/drivers/net/wireless/ath/ath10k/htt_tx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
@@ -195,6 +195,37 @@ void ath10k_htt_tx_mgmt_dec_pending(struct ath10k_htt *htt)
 	htt->num_pending_mgmt_tx--;
 }
 
+void ath10k_htt_tx_sta_inc_pending(struct ath10k_htt *htt,
+				   struct ieee80211_sta *sta)
+{
+	struct ath10k_sta *arsta;
+
+	if (!sta)
+		return;
+
+	arsta = (struct ath10k_sta *)sta->drv_priv;
+
+	atomic_inc(&arsta->num_fw_queued);
+}
+
+void ath10k_htt_tx_sta_dec_pending(struct ath10k_htt *htt,
+				   struct ieee80211_sta *sta)
+{
+	struct ath10k_sta *arsta;
+	int v;
+
+	if (!sta)
+		return;
+
+	arsta = (struct ath10k_sta *)sta->drv_priv;
+
+	v = atomic_dec_if_positive(&arsta->num_fw_queued);
+	if (v < 0)
+		WARN_ON_ONCE(1);
+	if (v == 0)
+		wake_up(&arsta->empty_tx_wq);
+}
+
 int ath10k_htt_tx_alloc_msdu_id(struct ath10k_htt *htt, struct sk_buff *skb)
 {
 	struct ath10k *ar = htt->ar;
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 646e1737d4c4..86386a0af14d 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -4423,6 +4423,8 @@ int ath10k_mac_tx_push_txq(struct ieee80211_hw *hw,
 		spin_unlock_bh(&ar->htt.tx_lock);
 	}
 
+	ath10k_htt_tx_sta_inc_pending(&ar->htt, sta);
+
 	ret = ath10k_mac_tx(ar, vif, txmode, txpath, skb, false);
 	if (unlikely(ret)) {
 		ath10k_warn(ar, "failed to push frame: %d\n", ret);
@@ -4432,6 +4434,7 @@ int ath10k_mac_tx_push_txq(struct ieee80211_hw *hw,
 		if (is_mgmt)
 			ath10k_htt_tx_mgmt_dec_pending(htt);
 		spin_unlock_bh(&ar->htt.tx_lock);
+		ath10k_htt_tx_sta_dec_pending(&ar->htt, sta);
 
 		return ret;
 	}
@@ -7474,7 +7477,7 @@ static int ath10k_sta_state(struct ieee80211_hw *hw,
 		arsta->peer_ps_state = WMI_PEER_PS_STATE_DISABLED;
 		INIT_WORK(&arsta->update_wk, ath10k_sta_rc_update_wk);
 		INIT_WORK(&arsta->tid_config_wk, ath10k_sta_tid_cfg_wk);
-
+		init_waitqueue_head(&arsta->empty_tx_wq);
 		for (i = 0; i < ARRAY_SIZE(sta->txq); i++)
 			ath10k_mac_txq_init(sta->txq[i]);
 	}
@@ -8098,6 +8101,40 @@ static void ath10k_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	mutex_unlock(&ar->conf_mutex);
 }
 
+static void ath10k_flush_sta(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			     struct ieee80211_sta *sta)
+{
+	struct ath10k_sta *arsta = (struct ath10k_sta *)sta->drv_priv;
+	struct ath10k *ar = hw->priv;
+	bool skip;
+	long time_left;
+
+	/* TODO do we need drop implemented here ? */
+
+	mutex_lock(&ar->conf_mutex);
+
+	if (ar->state == ATH10K_STATE_WEDGED)
+		goto out;
+
+	time_left = wait_event_timeout(arsta->empty_tx_wq, ({
+			bool empty;
+
+			empty = atomic_read(&arsta->num_fw_queued) == 0;
+
+			skip = (ar->state == ATH10K_STATE_WEDGED) ||
+			       test_bit(ATH10K_FLAG_CRASH_FLUSH,
+					&ar->dev_flags);
+
+			(empty || skip);
+		}), ATH10K_FLUSH_TIMEOUT_HZ);
+
+	if (time_left == 0 || skip)
+		ath10k_warn(ar, "failed to flush sta txq (sta %pM skip %i ar-state %i): %ld\n",
+			    sta->addr, skip, ar->state, time_left);
+out:
+	mutex_unlock(&ar->conf_mutex);
+}
+
 /* TODO: Implement this function properly
  * For now it is needed to reply to Probe Requests in IBSS mode.
  * Probably we need this information from FW.
@@ -9444,6 +9481,7 @@ static const struct ieee80211_ops ath10k_ops = {
 	.set_rts_threshold		= ath10k_set_rts_threshold,
 	.set_frag_threshold		= ath10k_mac_op_set_frag_threshold,
 	.flush				= ath10k_flush,
+	.flush_sta			= ath10k_flush_sta,
 	.tx_last_beacon			= ath10k_tx_last_beacon,
 	.set_antenna			= ath10k_set_antenna,
 	.get_antenna			= ath10k_get_antenna,
diff --git a/drivers/net/wireless/ath/ath10k/txrx.c b/drivers/net/wireless/ath/ath10k/txrx.c
index da3bc35e41aa..5b6750ef7d19 100644
--- a/drivers/net/wireless/ath/ath10k/txrx.c
+++ b/drivers/net/wireless/ath/ath10k/txrx.c
@@ -86,9 +86,12 @@ int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
 	spin_unlock_bh(&htt->tx_lock);
 
 	rcu_read_lock();
-	if (txq && txq->sta && skb_cb->airtime_est)
-		ieee80211_sta_register_airtime(txq->sta, txq->tid,
-					       skb_cb->airtime_est, 0);
+	if (txq && txq->sta) {
+		if (skb_cb->airtime_est)
+			ieee80211_sta_register_airtime(txq->sta, txq->tid,
+						       skb_cb->airtime_est, 0);
+		ath10k_htt_tx_sta_dec_pending(htt, txq->sta);
+	}
 	rcu_read_unlock();
 
 	if (ar->bus_param.dev_type != ATH10K_DEV_TYPE_HL)
-- 
2.40.0


