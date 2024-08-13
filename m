Return-Path: <linux-kernel+bounces-284027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5B894FC2B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 05:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D32771C22409
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 03:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6B21B7FD;
	Tue, 13 Aug 2024 03:21:47 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6370917588
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 03:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723519306; cv=none; b=O3dasdHRxYAmljyVgglPZIcaTjUFPrWLSZ/s1HSutNLiYAQL4g5HL3J8by4fyaqF3/MifEq/7IltMzE4TlgAiCrTInTyHy36iKEX3I1FafnOMNRei8J56YNhyqkFsnI9OfL8rbsc4N911CrMTj7qMqsl0qKpCD6adTLDDfk3GUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723519306; c=relaxed/simple;
	bh=jaifP1WMz5uLYTTMZUPNkubruCzqSurMSyvVN2fge4k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MMYQMjGVDwwAsP1AG07NJ3VyJ1ZMhxuY35HIzsaqOvXEt8e4hlxlKstkp+ZexBLBHrKkobordW/mWe1o0+JkrhhmprQFYedNbYfERx1fVf4GBVHhyXY9r/Zk4CjVpv8Ejlm3qYdI0ukNSkkJBrcGsD3TTDXJmjWOTfu1Lt9V+/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81faf98703eso668394139f.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723519304; x=1724124104;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9lfUdpJPWTIADxzvXJcxfaCW8wSvem+H+8YjVi6VBpk=;
        b=EMSH0Ic5qIY289+jGSFSZn26OP1PEX5JjUP4I3QyabHusV9RGxMuD4dQK5dLVU9D9k
         1XB5w9tFEZZ9GhXiDc8hmu088o7xfpx8xa/3uBlUoWQNNmNUQOiIOj8TC1rAi4hMBt0o
         iYCJfMG/RZftUy7+o57viJZ/ZW6hcdSu/4U8s5iDN2JlWU/iohab2KFqf3ViZS1wquaM
         XfG7b/WdPm9D/6I0xofRdGFgdpUg23S7VcMQKjci2/EaUzDa/4YHxtsuRGdqUjl6HcsP
         prNDzmAQIEI6uayLK65wBwlGYPyQBnBpgPsT1bcbR7TUCVTw5UK/PNArNluZhqxDi08Q
         GiVQ==
X-Gm-Message-State: AOJu0YxI0nucnbvHTEHBkjNHnDoop27vfNi/MkIdDEKpcXIuSAUA2E5c
	rXGRzTT79kPoDuKOxIMgq1U0kJDxDLbql+1PKm3MOaaow90VlGgFXqsh1wD8q3Ofhhw9/jFWwV5
	XGL4mwb41NBdQ1FY9S0uvn+csNGgqNWewbU4jlsFT9hzYIAA1dwOr3Tc=
X-Google-Smtp-Source: AGHT+IG4PojAjeU5q21hM8KRftoYNqndQvKuKXLBE897Eo1et18fqjz0luPh8hVwE49MtqYv9ws9b3tn9zLVPkTpVSmmKkumA47w
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8405:b0:4c2:7179:ce03 with SMTP id
 8926c6da1cb9f-4ca9f6a67f2mr114584173.2.1723519304408; Mon, 12 Aug 2024
 20:21:44 -0700 (PDT)
Date: Mon, 12 Aug 2024 20:21:44 -0700
In-Reply-To: <000000000000fabef5061f429db7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e734dd061f881b07@google.com>
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
 
 struct smc_sock {				/* smc sock container */
 	struct sock		sk;
-	struct socket		*clcsock;	/* internal tcp socket */
-	void			(*clcsk_state_change)(struct sock *sk);
-						/* original stat_change fct. */
-	void			(*clcsk_data_ready)(struct sock *sk);
-						/* original data_ready fct. */
-	void			(*clcsk_write_space)(struct sock *sk);
-						/* original write_space fct. */
-	void			(*clcsk_error_report)(struct sock *sk);
-						/* original error_report fct. */
 	struct smc_connection	conn;		/* smc connection */
 	struct smc_sock		*listen_smc;	/* listen parent */
 	struct work_struct	connect_work;	/* handle non-blocking connect*/
@@ -325,6 +316,16 @@ struct smc_sock {				/* smc sock container */
 						/* protects clcsock of a listen
 						 * socket
 						 * */
+	struct socket		*clcsock;	/* internal tcp socket */
+	void			(*clcsk_state_change)(struct sock *sk);
+						/* original stat_change fct. */
+	void			(*clcsk_data_ready)(struct sock *sk);
+						/* original data_ready fct. */
+	void			(*clcsk_write_space)(struct sock *sk);
+						/* original write_space fct. */
+	void			(*clcsk_error_report)(struct sock *sk);
+						/* original error_report fct. */
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
+	struct smc_sock smc;
+	struct ipv6_pinfo np;
+};
+
 static struct proto smc_inet6_prot = {
-	.name		= "INET6_SMC",
-	.owner		= THIS_MODULE,
-	.init		= smc_inet_init_sock,
-	.hash		= smc_hash_sk,
-	.unhash		= smc_unhash_sk,
-	.release_cb	= smc_release_cb,
-	.obj_size	= sizeof(struct smc_sock),
-	.h.smc_hash	= &smc_v6_hashinfo,
-	.slab_flags	= SLAB_TYPESAFE_BY_RCU,
+	.name		       = "INET6_SMC",
+	.owner		       = THIS_MODULE,
+	.init		       = smc_inet_init_sock,
+	.hash		       = smc_hash_sk,
+	.unhash		       = smc_unhash_sk,
+	.release_cb	       = smc_release_cb,
+	.obj_size	       = sizeof(struct smc6_sock),
+	.h.smc_hash	       = &smc_v6_hashinfo,
+	.slab_flags	       = SLAB_TYPESAFE_BY_RCU,
+	.ipv6_pinfo_offset = offsetof(struct smc6_sock, np),
 };
 
 static const struct proto_ops smc_inet6_stream_ops = {
--

