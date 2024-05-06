Return-Path: <linux-kernel+bounces-169950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A24D8BCFC2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF16D1F229AE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A3B13BC23;
	Mon,  6 May 2024 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fk7zn5N3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D617FBCF
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 14:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715004701; cv=none; b=DwU5fp8O62MlCnHblC5ol2d5+GupNVESpQhw1kE5CiV0vzmwV5ZJ9O+4lkiiSxEucg6eX/3s/mEgPqyfzabZ64hUMg+BKONzw0qzvZMGUqjwfqXJSdGhBlFcaAriUPgal5pwWDishrDHRl9Jwakvk99YOKm8Bro1DbQNi45CdJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715004701; c=relaxed/simple;
	bh=297vEo8nyC1s/ltFlb73Hmw1Xp0B0/3D3O9My7miovA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HtHlL+qIJUDIKvc4TjwGkMgtNz8E0bazBdllfmmt3ogTdLic2fBHT/mNnf2twCkkD+urYW+OS/TptN9Uvupq0yLVDLHawqS2utBBDtiS3y71IwjiZsnjy2UmzpxsJN38D7mwERaTNH67nHj7VNmb4EyNNcM6pi5wHyDM9YsXjJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fk7zn5N3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715004699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qK13xhGx+xh+kDbLKKe1iKuSXlAdZD7q6eOoabHwsw4=;
	b=fk7zn5N3SU59PlCvpXom1WypG+mTxYJxZKjrl4fdQu/F3bpUv3t9k2dnJNWVXnk3hRfFdL
	ZzTRhAv+SwyX68yuGR1wjWo3ktRhLBOE3JVzjs0BMbMws4cdewOMEO+oRiXUTfUr8080nK
	2t6Pebi4vd6p80dt1siYoB9DZESCJZc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-EjTpGxs1PNiQpHQhvu4Kfg-1; Mon, 06 May 2024 10:11:37 -0400
X-MC-Unique: EjTpGxs1PNiQpHQhvu4Kfg-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1ec3e871624so22994645ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 07:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715004696; x=1715609496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qK13xhGx+xh+kDbLKKe1iKuSXlAdZD7q6eOoabHwsw4=;
        b=BuCWCNMYKECxZmDfaIE68ADueVu1iUsPkzEABWiz53d6fkWV9D5ID4Hs1nQndK8TzI
         gC4CsvfNaIAgKWp8dWy+1HkTMvsf9awL2Kb7TRFirdO6y5rIiTunEgeutvuZQAKANp70
         1GB+Fr9Kdh/TzwkVHObbw0BihBdahtwl7IcnfCsoyERpn9x29lss0JiRxNSvJhvlkLL6
         lKh0w86V8j3+4urBrclYVoFPsyhAU4JEiZ0772xMfIjNIpLqzeDzDOjNfJ9q+nkIb9JA
         nnie1RUSmZtAAakJumYnHFuPJAFkjjaFaSctLKBlxHIA0EhZBlFtKhV2n2oAT1lVIGaY
         1DlA==
X-Forwarded-Encrypted: i=1; AJvYcCWX7FTPP8hApgvnZXJ05RiC6cXyjVDOGseTBOpBTNo3wklLm/VUhshXpP83+Ev4sChaa1TcjvmNqJGX9ObfddepbJ0STz5SFFEMhPWR
X-Gm-Message-State: AOJu0YyeMLhJavLg21BUMNPPnsF/VMzDuuLdWZEWrgqpBztDJJZeHUj6
	MCVlIHxeAbF1Zp/p7Q8dvjtWOqOReyIZQ7OPCiLWT+hhsGbj8ad5OyAOZfynCDmx+23+mAhWCam
	OrAIwz46OMBXhdw3+HAsg3tSxF9kHH1FfZblTrsHXeBD0fxHPG35gKLm6Xewxwg==
X-Received: by 2002:a17:903:40c2:b0:1eb:3df4:c31d with SMTP id t2-20020a17090340c200b001eb3df4c31dmr11946811pld.42.1715004696166;
        Mon, 06 May 2024 07:11:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH57Xka6hZHeOhrbJPj5cOqPBmd/uf5rYBBniQCsXw95IuMnWV2Gj4zSFUlXjb8VQo5dpsWjw==
X-Received: by 2002:a17:903:40c2:b0:1eb:3df4:c31d with SMTP id t2-20020a17090340c200b001eb3df4c31dmr11946755pld.42.1715004695399;
        Mon, 06 May 2024 07:11:35 -0700 (PDT)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:6883:65ff:fe1c:cf69])
        by smtp.gmail.com with ESMTPSA id p2-20020a1709027ec200b001ed9fed6f61sm4398721plb.268.2024.05.06.07.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 07:11:35 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH net] ipv6: Fix potential uninit-value access in __ip6_make_skb()
Date: Mon,  6 May 2024 23:11:29 +0900
Message-ID: <20240506141129.2434319-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As it was done in commit fc1092f51567 ("ipv4: Fix uninit-value access in
__ip_make_skb()") for IPv4, check FLOWI_FLAG_KNOWN_NH on fl6->flowi6_flags
instead of testing HDRINCL on the socket to avoid a race condition which
causes uninit-value access.

Fixes: ea30388baebc ("ipv6: Fix an uninit variable access bug in __ip6_make_skb()")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/ipv6/ip6_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index b9dd3a66e423..fa2937732665 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1933,7 +1933,7 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 		u8 icmp6_type;
 
 		if (sk->sk_socket->type == SOCK_RAW &&
-		   !inet_test_bit(HDRINCL, sk))
+		   !(fl6->flowi6_flags & FLOWI_FLAG_KNOWN_NH))
 			icmp6_type = fl6->fl6_icmp_type;
 		else
 			icmp6_type = icmp6_hdr(skb)->icmp6_type;
-- 
2.44.0


