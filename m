Return-Path: <linux-kernel+bounces-241714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD417927E4C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 22:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 626141F22CA4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8E3142E9D;
	Thu,  4 Jul 2024 20:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="U+3b5vDR"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF1113DB88
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 20:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720124910; cv=none; b=PhcvFD95KD9S1JIz7uer0AadoXrBB+Ip2caaqDsjDTubRHUG4jgONBSkfcG883CNzQy4OSQ2jItoKMxKjrNL7nSbYl2L2cn95bjnFaNygTZGW32b+t5eefrCnKgZLhHa70Qc9GELW5nZ7sTv0JJk1jX0W7fSRSS+UA6xEeSNnl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720124910; c=relaxed/simple;
	bh=fUPBk3zzISzAf3skQXsmHg1VVEQ+VeidBR6394fqi0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R+tDOqQtnJzSGeuorHiYC1pDh0ouyzgdNWHguO2y+2MwS1oVAD8FmLQLaP/DvCG1ePlWaz+VXVed36CJvQBrQ/F2Gjgk0+V3d/YgGnSCNfOFIt32scDdKIOGCw6znWGpSeg/S9NCr5O8P0bxDRVkWQHMTxMD1EgqEXU4szjOrqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=U+3b5vDR; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-701b0b0be38so738084b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 13:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720124907; x=1720729707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f0ZFq4yZrqfjqzGRa4e6FCFvF4vx3j+7fOsbx7TFpEA=;
        b=U+3b5vDRxvPsJFe140KaFUm3kPnx2GogA0TO0sjsA7/rXd9C7BVJ8zU0u28WgEZ306
         XgNm+PxDfLIxZpoNMji6WzxZT3ZX11IaEglWy1H2OXigVU23JkBGdqfmINtqVxziZXV8
         7AW37zW0XdKPZ1Wr6RdEMd8vX0EhpejP7bjmelDJu/C6n/YfqreR40tt+ujN7lUYD1/j
         mysPi9MVhwCg54aaLBctGVhIg6F2MEqETHrJ7FMin0mRlrJ1qfa3DO197Kh9SBJ+L1pc
         ZGwieCgyyzQ9nL0GsLjvIFUhvrkrb9gMfivnvZGjWFCmCKpKYfiyYBU8DAPJHxVfc7BB
         0PrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720124907; x=1720729707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0ZFq4yZrqfjqzGRa4e6FCFvF4vx3j+7fOsbx7TFpEA=;
        b=R66vURSrzj9YNxPrO01nTEqcz4g31RRyykt14upIE8o7HzvKjJdQBcXgtHF42hGLoQ
         5vQBXKEI+64O4hLWEL4G5snvREJLX0DINV3AZ+juyfwHSMW8VOBNVuppn6T1pi37Uhsc
         fcdC+71DUzkRz6hXae1vGqVO/4cOVUsW5w4S2155DJu5l+cVjFiL+kb+HpzD4eZmIRQO
         KjC8s/i8eultMmL8qvbxLHDRp0Z7RMPApMldovWfbElTvLNsiZuZJe+iEVWOPecdTAbi
         dmr33cLV2HNKtEpkUF34OCGyep8WscaeXOvYDV+f6+X0UHgVwf7oBFA/W/dHjy+wtYad
         b4Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVvrETdU1PJbN4rBk9pq2PGclDhL14AaIeSstAv5sg3cQrHgAN+gQCrLgT2Rr/1SpjMApysETiWe3bJh0xn3zz+jrLJmVi6S4zKIHRO
X-Gm-Message-State: AOJu0YxAS0GImwrzDN3bftOkDyAbfZnuiajAAz3G+Bjfa4s8hf+An8lQ
	t8gW/Dotxe3qJsWLb7Gx81LrExRjsMg2+Kf9lrjtvZK5bpkMSi2hJHDvOp3dTz4=
X-Google-Smtp-Source: AGHT+IEWAl6PNGgwoM5iOt5iPlgXU4LmkI72bTkWiRe/ok/Q+VF2wIhTl2HS7Qutfcrht+J1XgIQTg==
X-Received: by 2002:a05:6a21:339a:b0:1bd:260e:be9d with SMTP id adf61e73a8af0-1c0cc90bed5mr3157315637.39.1720124906817;
        Thu, 04 Jul 2024 13:28:26 -0700 (PDT)
Received: from fedora.vc.shawcable.net (S0106c09435b54ab9.vc.shawcable.net. [24.85.107.15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-759b1c426dfsm2942087a12.9.2024.07.04.13.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 13:28:26 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: marcelo.leitner@gmail.com,
	lucien.xin@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH net-next] sctp: Fix typos and improve comments
Date: Thu,  4 Jul 2024 22:25:59 +0200
Message-ID: <20240704202558.62704-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos s/steam/stream/ and spell out Schedule/Unschedule in the
comments.

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 include/net/sctp/stream_sched.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/sctp/stream_sched.h b/include/net/sctp/stream_sched.h
index 572d73fdcd5e..8034bf5febbe 100644
--- a/include/net/sctp/stream_sched.h
+++ b/include/net/sctp/stream_sched.h
@@ -35,10 +35,10 @@ struct sctp_sched_ops {
 	struct sctp_chunk *(*dequeue)(struct sctp_outq *q);
 	/* Called only if the chunk fit the packet */
 	void (*dequeue_done)(struct sctp_outq *q, struct sctp_chunk *chunk);
-	/* Sched all chunks already enqueued */
-	void (*sched_all)(struct sctp_stream *steam);
-	/* Unched all chunks already enqueued */
-	void (*unsched_all)(struct sctp_stream *steam);
+	/* Schedule all chunks already enqueued */
+	void (*sched_all)(struct sctp_stream *stream);
+	/* Unschedule all chunks already enqueued */
+	void (*unsched_all)(struct sctp_stream *stream);
 };
 
 int sctp_sched_set_sched(struct sctp_association *asoc,
-- 
2.45.2


