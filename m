Return-Path: <linux-kernel+bounces-283949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 134B494FAF9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 03:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64821F22A88
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 01:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192486AAD;
	Tue, 13 Aug 2024 01:16:35 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4CBED8
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 01:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723511794; cv=none; b=M+h+CtyzVZWh8RUt8owBYdMckkOauq5WBv6mG2Q8GVDI1H+9+JRbUzvNhoAngGNNJstka8d1K2qLZMtaXfYNLg9JRDbJx/Fm/JMtKBEbseAPo6cd1A0deCmVOt+cBcdZK++6uDc2hCCZ+pJ8y8ohjVkPd9LTKOiBXHxv6GTqR0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723511794; c=relaxed/simple;
	bh=vg4e1qlxPcyrFtLE/lIzbF4TmkT/NgEeTvSWMaQ00oQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=h4/KMmCNQG4aSvYoWcVLuhNpt6Auwldt72ACJucSleZDnjNKQ8OIkhz26EP2BD9BWGHQi7diEBp+t6jZmr1e7N7TTaATglalXNF8qYH0LqhI4fSKltyEbWGZwfmbQXX3kQagthplOmkfEmYEpDfqAhda/fgYR4Qw37jYyxfM5gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39b3a9f9f5bso59683785ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 18:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723511792; x=1724116592;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SSU5E8vunfXqm7aZcMeBcFQaELDnaHs9YAAg3IhSG0I=;
        b=P9/lRIAKbAxHKX7nmvsOAZbfsCI4Y9PxlUS+QTjjGV1suXnOZfnBH7w/oPkMg6FJQn
         oND/0/2ya/sTD1OPoIcKF/8KxtZCtLtJbwt0nUbULicDCQoFt9Uk5S+BAZLLYpGhBj/B
         bz6pOUu3Qeb2OvxHQrWXlJfyvuzfC8MAYgIemxKVoZZm2Gb6GciIR0zf68mmGzRnlPop
         jA3K2m7td18M9DdS5iOFDxqLxM5Zft5eaYOz1H1setrIEcHQ5JH/MRFtmgwXBlQ/hbO0
         D7C5t+3/wqj6uQ56uTY19t6bwuYeZZvYpki7QFM+iGWUmsTPZlebhCsur/Hr93KUUA4K
         glAA==
X-Gm-Message-State: AOJu0YxQAkqtaikZuRgy3j6kaRyodpt1o4ZrioF6W/Suw5E1bfcjSSOy
	aS0fkTzlO3/5WGeSuQ2G++gx012nRVvRFyCPXBJOgHsayCViFRgLk2BOlZ+3CwjenckG9irEAnv
	In83tnasaJyC3DM8GG8TAOJ3N3TXC4Aq4QpToB4hT6llyrtBs3yElQhA=
X-Google-Smtp-Source: AGHT+IHqGLVBfFRluyoSwHwJO7hkb+QV8OvpNPKCiCNXzSXnHxaWsWVPbM3UmmByqCIOXDUu6I72S8c2mmcJ/sitquuVJsLsJnne
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ee:b0:396:ec3b:df69 with SMTP id
 e9e14a558f8ab-39c478cc985mr1213365ab.3.1723511792236; Mon, 12 Aug 2024
 18:16:32 -0700 (PDT)
Date: Mon, 12 Aug 2024 18:16:32 -0700
In-Reply-To: <000000000000fabef5061f429db7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002488c5061f865c65@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] [s390?] general protection fault in smc_diag_dump_proto
From: syzbot <syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [net?] [s390?] general protection fault in smc_diag_dump_proto
Author: aha310510@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
net/smc/smc.h      | 19 ++++++++++---------
net/smc/smc_inet.c | 24 +++++++++++++++---------
2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/net/smc/smc.h b/net/smc/smc.h
index 34b781e463c4..f4d9338b5ed5 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -284,15 +284,6 @@ struct smc_connection {

struct smc_sock {                /* smc sock container */
   struct sock        sk;
-    struct socket        *clcsock;    /* internal tcp socket */
-    void            (*clcsk_state_change)(struct sock *sk);
-                        /* original stat_change fct. */
-    void            (*clcsk_data_ready)(struct sock *sk);
-                        /* original data_ready fct. */
-    void            (*clcsk_write_space)(struct sock *sk);
-                        /* original write_space fct. */
-    void            (*clcsk_error_report)(struct sock *sk);
-                        /* original error_report fct. */
   struct smc_connection    conn;        /* smc connection */
   struct smc_sock        *listen_smc;    /* listen parent */
   struct work_struct    connect_work;    /* handle non-blocking connect*/
@@ -325,6 +316,16 @@ struct smc_sock {                /* smc sock container */
                       /* protects clcsock of a listen
                        * socket
                        * */
+    struct socket        *clcsock;    /* internal tcp socket */
+    void            (*clcsk_state_change)(struct sock *sk);
+                        /* original stat_change fct. */
+    void            (*clcsk_data_ready)(struct sock *sk);
+                        /* original data_ready fct. */
+    void            (*clcsk_write_space)(struct sock *sk);
+                        /* original write_space fct. */
+    void            (*clcsk_error_report)(struct sock *sk);
+                        /* original error_report fct. */
+
};

#define smc_sk(ptr) container_of_const(ptr, struct smc_sock, sk)
diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
index bece346dd8e9..3c54faef6042 100644
--- a/net/smc/smc_inet.c
+++ b/net/smc/smc_inet.c
@@ -60,16 +60,22 @@ static struct inet_protosw smc_inet_protosw = {
};

#if IS_ENABLED(CONFIG_IPV6)
+struct smc6_sock {
+    struct smc_sock smc;
+    struct ipv6_pinfo np;
+};
+
static struct proto smc_inet6_prot = {
-    .name        = "INET6_SMC",
-    .owner        = THIS_MODULE,
-    .init        = smc_inet_init_sock,
-    .hash        = smc_hash_sk,
-    .unhash        = smc_unhash_sk,
-    .release_cb    = smc_release_cb,
-    .obj_size    = sizeof(struct smc_sock),
-    .h.smc_hash    = &smc_v6_hashinfo,
-    .slab_flags    = SLAB_TYPESAFE_BY_RCU,
+    .name               = "INET6_SMC",
+    .owner               = THIS_MODULE,
+    .init               = smc_inet_init_sock,
+    .hash               = smc_hash_sk,
+    .unhash               = smc_unhash_sk,
+    .release_cb           = smc_release_cb,
+    .obj_size           = sizeof(struct smc6_sock),
+    .h.smc_hash           = &smc_v6_hashinfo,
+    .slab_flags           = SLAB_TYPESAFE_BY_RCU,
+    .ipv6_pinfo_offset = offsetof(struct smc6_sock, np),
};

static const struct proto_ops smc_inet6_stream_ops = {
--

