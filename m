Return-Path: <linux-kernel+bounces-323739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C459742C1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 505F0B21297
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B17A1A3BCA;
	Tue, 10 Sep 2024 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Lgc4XTgF"
Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437B21755C
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994403; cv=none; b=K87AF5Lca5MQJDjMrZdry11alLqJMt49HVLp+II4utFlD+sPe2THcSfS2bJA02jGuCd8f40DQBDuMiTLRXvVwSzGeXGurS+0LNEkAoWkETOaC1uZJdya8gYe4MHRP8uMTKoSfXFedxJ2/CmKML5QRHx7CvRckYUMDE0b60onhLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994403; c=relaxed/simple;
	bh=O1e6CxiQWsxzIs5u1fUQ5DgKXDjgs0NeAacNWiPIWIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nK08/KlFHBmd4uifzYz4QxUdZq7kMpLI3yQdgVcTwXa7ezSydpwwcc9dUjPRMlUBIByvGKY/iGvalkp9N4z0myghc6S0RGUq4uEWdJZMLl+SEP5s808ZDMwM55gxYKIcWBrVB2IMNwq5lCYXM2gfWFq0og72LdKhuG1EZxC4YSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Lgc4XTgF; arc=none smtp.client-ip=66.163.185.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725994401; bh=QKTsziIRFsRzMH5ovaK8Q7qXH6nN4F+gv9JsbGYKPkY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Lgc4XTgFfcA0ichUpfcAP8Etvc4Zrk0OGquhuCkzNYCGWYegK6x9ZvpMf4FzgV6FE8zmTlnhin/3axX3FqKCrwh3Yr9afQQ/WoyP7+cC987lVPdAoaE9kJDDZyfS7ggexoUAs3tqQb6qu0Ys22HhsVxcgG/WVHMA9FbP8Jh1fdFK0PTH4yotcqPrMAkNjziss4B7IdE/P4NR55PUFbWbzoXhd2Wd4nca+uT4HfLx4MdmIM49NMtYyGJiaJhdfry/FnkWqEdfAowF6gaYFYg1BVccIVqy7q6JL05KHPE+iPYzinWKk4d9Usghvf7C1gYDzbmSbocpOVO+Tp1W10JlKQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725994401; bh=l++SA9X0cOh5Ys5awvLVOq4dto7odlcKD4tLMFRYL4F=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=FTsnUvuDAFQ77OM13yV6beFu7girtutzj1WT6b4yM8JMDcxHcTrPEPILHjFltU6Vsy6BRCorDwgyO5NSZoLUFin4M4E7m9fmQ4tpyELHqvLyvTCsVnml8C6UZ+A+oeyP2Mn2zs/CfLeB7EzdGSnXJ414p/eXJbGMUN0cPXngcpjTGCCwuzsQ3EQiTDukwoDYsNGDNx/IH88h4qJmIpxftm8+V2BP2U2muuzfG6r8RlCprpZzynSb7LrIXSzUhdwdt1ld0TmyDBnxDEZVcYJKoEmbzQzOg86P2bswS8SHQgB7os+Ver3glnzJHclvoifpmS/z7ty2mwt5BI7MoakcmQ==
X-YMail-OSG: tRIHen4VM1mqjtoG6p13Une9Y.FnWY2s58GHldXl6WcNckBZQ86GermMyasFJiZ
 AJRvBuuEvpMOlFAAcRvtdDXCXhL4bow34DXJuT_fMAD9iUHofS_IH5VL.XENjDNmrMV6yeNonwMf
 .NeZGv61xI2o0qsxIVrmCW1Blb4ndeuPTuXTqA3xtqFEtw5Y9.ig84belsH4phuPs94OHdHf.XfU
 7e8DzivBPnRme5cZV5yNADs6MC6k4WHdQVFJt0vQ8c2N_6_96XLHRMsJYA4KHDAK2SNZFJcA6rE7
 rsXFwdIk0XJIDzjad8kvQvYqmLxVlcMX4KGHUR0CU1hH8bDEGrKle7IRO8e.ozN2rcBGEYdkN2rA
 Xs69G3iO5cTq9ygeTQ8Si1pBu38qeZ6DvRRBHi3iEABdQwXlWNS6pNpVUhY2asG4a40Mp0L4L5om
 8MmiqazIE59ZbBBZRbsCAzI1u4NUKZss26wj5wgwy69aFXeyeK964PIuzdx5eJCXCmf_6KuaLYWD
 6npPT5jYYyP9PNCiot.9avDYANOYjW21axysBvEtIWfdSAC0ucOaJu4c6X_WMnEqFCElbPt6mbWq
 _GNTcYlkPIPwcJ20cSKdVoAkPpX31i09OGfch6GWtskNL3z6sb7JcMN9.yKzk_VFiCIPefiC2UKR
 EYe787uduHcrHX9GRA4XRJmt8hg3WEJPcIIlAVsuXCu_TG0D57dtNPBHDBDZgthpA8dDhNBPN5vy
 iirRy17vZjSekFI3bzN_DpkMi6N7eqZ2xTEoOLhr3flzHj08HmHesN3vXwRzWtq7CZcy8lYJijmP
 ynPBzfUk_o_JLrWJPwqk41g1evdunfjENostVE1gIgJLMXFMNnhss15lHAXPtb.LJ87V3F1QNfdI
 ecvIsjODFXUpgDb31tYjIBwW0qfAd2zJOmYpcAzVwICJnU0DdXM1f3NERvn5_uYzKrlkhP7BjZ8E
 .o1qzBm51egAAemf060ZtJjiZMS5Wzr5B9SXTFbN05eowLn4noWnJvF0pMQZGmmVXmJuwM.J9w7p
 nIdx5o_QK6FV0qyJMqBLCZW7.QOtQSnYAQPvKum6Cn90bj9SZ30EsQnBRgw7X1qutBKWIc66ChFm
 hKaHv0Bi68czDmYDNKzKGNxZ62A6rbHdO2k9u7zbAiM37tps.vGgMD6g9THbj8tmrRCGslAXQ3KN
 XxsozpOoCvuXwgYPmps2tq85fDikA1.jONuLeg2S3yQzi.taHTAcD98mek8OjucEp3EjSS4E7V0y
 6Sb_BgHM4oymd8gCj_ErSCl9HOg.YaSeQiSS0dX8kXIh2futbF3.6d4sQ5BgtJpa1ed4duNihjZt
 IvMw25VUKWeNqdIY9rlsM74oo7fKtahw9ujaQxHSf8uHZLhdjvW2hJ2MdjmYDElMEJDPXFO96Qeu
 7_OR9ISc7iDaaoLYxlgA5IV_lyt4OilKpVaXzfcCMoKlxpSJ.fxdBTwNfLMlBQhcItPm_czO_EBV
 lZXT8LTV17ruXE1DXthHVRkzQBxLQCq6C4rKIsFhIuFy0AVOkpxsXcbOe4VDOdrFK5vamDsUM4ot
 TrKtmZS9AuXnguaqkQ7K6mgvlASmhqfaLwCiN8HHGGD6SWmERmgZcTKzXBRT5NnmLgeCQ4EF1bCq
 1BrofbmmRyZK8Z2hTkDR8NHd.Bi1OZrAnMdYBDJQORlSN0A4m4VM0qopdcqSbVj0IgBhWeqYt6Md
 uGwsxtzHWsQ3WDMWgjeEtbL.4iBGKqJecqcgTcGXd4CxwmVmW.VHxwdhFnMNSCDViRManL7B_d0U
 Oe5bg5YOXtnEE4W3dIyv_vqYmf4sqH0Roq7wgUO0BlMGbxmrn_JCai5RQFe9POpBNZeCm87Xitol
 joXT48w97nDtRtBnFxTTpQ4N5WUt1nI6Do.1yKmPu3f8cUUHSEwg6E9Xo_u2w5.8a6gO.9zpvZiB
 FIMMRzY25_wi.0Y__.Yul5GKPfoWecUq1JqDzv2D5dCowaz6KIig69ukrjYybtDb3vbBVXyVB88r
 DNycx8fIzz.zjlHYgE2vmzWVYGBS3ohW.CN20A4YjaYf6GRf15c_a2Y2OdlLUaiB8PapxglvJ6Ky
 MXCBqY2A76jM5exsIENHU1LVXhzFwlTnuckEIG13NtSo4wIIsADCmJmQlPUuQQurCIPfeQoWue8V
 aT432DafhV4NGW3PGnut_HedWFkMmMMfNZ_fbhZkfwFke4CVMk_6pNIJzYUC084ZcKj2PbUhmUaY
 RvJjwp3EjBv7tVwAeFy8YbY9N250pHC4HpzLr7suj1mKP1Vo.rvDbVQvE3837721dq3n2gultZMN
 CHM.7Bc.9StRELCnOzSr6FxD44BWCnNFcaBRb
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c78cf519-8b4c-4ce3-a490-f15f738434dd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Tue, 10 Sep 2024 18:53:21 +0000
Received: by hermes--production-gq1-5d95dc458-4tw7n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID bfec55394db9c3ecf7e1196118de0a4c;
          Tue, 10 Sep 2024 18:43:12 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org,
	mic@digikod.net
Subject: [PATCH v3 06/13] Audit: Update shutdown LSM data
Date: Tue, 10 Sep 2024 11:41:18 -0700
Message-ID: <20240910184125.224651-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910184125.224651-1-casey@schaufler-ca.com>
References: <20240910184125.224651-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The audit process LSM information is changed from a secid audit_sig_sid
to an lsm_prop in audit_sig_lsm. Update the users of this data
appropriately. Calls to security_secid_to_secctx() are changed to use
security_lsmprop_to_secctx() instead. security_current_getsecid_subj()
is scaffolded. It will be updated in a subsequent patch.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/audit.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index e7a62ebbf4d1..70f76fed254b 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -123,7 +123,7 @@ static u32	audit_backlog_wait_time = AUDIT_BACKLOG_WAIT_TIME;
 /* The identity of the user shutting down the audit system. */
 static kuid_t		audit_sig_uid = INVALID_UID;
 static pid_t		audit_sig_pid = -1;
-static u32		audit_sig_sid;
+static struct lsm_prop	audit_sig_lsm;
 
 /* Records can be lost in several ways:
    0) [suppressed in audit_alloc]
@@ -1473,20 +1473,21 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 	case AUDIT_SIGNAL_INFO:
 		len = 0;
-		if (audit_sig_sid) {
-			err = security_secid_to_secctx(audit_sig_sid, &ctx, &len);
+		if (lsmprop_is_set(&audit_sig_lsm)) {
+			err = security_lsmprop_to_secctx(&audit_sig_lsm, &ctx,
+							 &len);
 			if (err)
 				return err;
 		}
 		sig_data = kmalloc(struct_size(sig_data, ctx, len), GFP_KERNEL);
 		if (!sig_data) {
-			if (audit_sig_sid)
+			if (lsmprop_is_set(&audit_sig_lsm))
 				security_release_secctx(ctx, len);
 			return -ENOMEM;
 		}
 		sig_data->uid = from_kuid(&init_user_ns, audit_sig_uid);
 		sig_data->pid = audit_sig_pid;
-		if (audit_sig_sid) {
+		if (lsmprop_is_set(&audit_sig_lsm)) {
 			memcpy(sig_data->ctx, ctx, len);
 			security_release_secctx(ctx, len);
 		}
@@ -2404,7 +2405,8 @@ int audit_signal_info(int sig, struct task_struct *t)
 			audit_sig_uid = auid;
 		else
 			audit_sig_uid = uid;
-		security_current_getsecid_subj(&audit_sig_sid);
+		/* scaffolding */
+		security_current_getsecid_subj(&audit_sig_lsm.scaffold.secid);
 	}
 
 	return audit_signal_info_syscall(t);
-- 
2.46.0


