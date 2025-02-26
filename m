Return-Path: <linux-kernel+bounces-534775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48636A46B04
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A0B416E9C3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5573823C367;
	Wed, 26 Feb 2025 19:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JaYDl7bj"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6812423A98A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 19:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598111; cv=none; b=TC/RdjQWxB+8FtBTJxTl86fNJPI8MRgidMIlARRceI3DNRkCO6iT9mWQPAiRoFL/1WuJAIIdp718WHg11gwWhKKDFiVy+njGvRiHSZ5sLAhQJr88Q5oKBq4PTOJ6wOPn0iqic4a5rlgtWYxymliprz0NTGEk4IrV48MU4Hj3SNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598111; c=relaxed/simple;
	bh=tZ4mEjz0mMBNAvIEKtBrdqpxwP3sR5OVhL8PyV1SRr8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BE7cXZEHJivvJul7FQqQ+cdYxf6kEjs6/Hy8akKzyYzUe1gcVfo174mTUtbqZbM48jXPjeuQadQCiANeokvZk3RqQVaJqG/vT34unOvGAUkFGRqpQIluHJAdLOPCk9g1oDf3joW8em4cxPDty9E6y5xugJo+cWWAtKxjB1ZseXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--krakauer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JaYDl7bj; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--krakauer.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2f2a9f056a8so353449a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 11:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740598110; x=1741202910; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EAHfytQNUsiD5c8K+E1ZBkdfL4DOZcpSAfUWQ+cotG0=;
        b=JaYDl7bjX5h0huLcAR1OIKmxjCo9+3BOJW4FfQeY7V0kDeGvNWRtTCBQ8DUUco/W/3
         0hp+RPfL5nQXwbB78Uzq4ijgG+T6IVGen0M9WNxSzsJnp7f+7YcPjKIND7viHySSwA9G
         SwYG/XklvpZbx25GurISQmV4kfWvKOGUi0Rmhwjcrr5r4fd8vAUdb0K0FqFR+MryYp0f
         ThbuOPbr1Rg2qAmnnanuvDfV+v+y/WwZ71KlOlo7TOOJpQJ0YrQMzPvS3FmrGfWg9WHK
         Y2syXJMs2cGBy6/4gy/sBlMV/Y3uZcXxH7bJsHqfkqlORW17PP2TeLhRIbYAJykYjqjS
         HxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740598110; x=1741202910;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EAHfytQNUsiD5c8K+E1ZBkdfL4DOZcpSAfUWQ+cotG0=;
        b=JbkC4EGTaUwJ4Z3kUtQm8ADxMB32J9fZKYzdYaB03j+5h3VgbMb+6qDcOk+3aiTSZ/
         +vTb9z4f+/8x+DPR+UnbCclqi4rvho1+j7WDHcc1Lvmtm/7xWBwAWTLKRZCMFIL515Gy
         /BNvAwqbargRx43ZLDm98bnK7+wk2lSRrINUQcHv7qL2eogoX4GIVR8WdV94hceki7/4
         LWJhZPp3qnoMgBumANDcLhzchxTm2DJN+OB90KHnSrSX/W2ouC43xnFt6ZT8A0npA3IG
         DCrnFGZaqOky7TbVxdjt3tvCTvhDomhIwIlTcJeXcQShIO0PKECDbhd6+eLS9achHAlw
         x8cQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtKB4Al3wWAs/YQP1XZ7Upgvg6ugLCgUYK6v4GoxnVTBfOyiReGUgNwDLLkZ5G5OckIIpNWGjdAsO/hNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBXBrJ5ERv1O550iM6nws5AVy/41jviYlDwJHwJJZbRzuKC8I+
	wd0gNgqrJV3+wf7nKb3wF9VmjD3YvEcwswp25iFrI7qE5esKmnKf0tuAz3eKD/8PJEz4pY5qrnu
	FuxlgV+BH
X-Google-Smtp-Source: AGHT+IHnpgBcjLWJK3P1K4UEwO48PptHkVPMDaQtRyrbfS1CeCFR9+JXWBlM+SMFre4xrXqt/dk+pNsU4kVPXg==
X-Received: from pjbsg17.prod.google.com ([2002:a17:90b:5211:b0:2fa:2661:76ac])
 (user=krakauer job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2d88:b0:2ea:5dea:eb0a with SMTP id 98e67ed59e1d1-2fe7e2e0f5dmr6628296a91.4.1740598109628;
 Wed, 26 Feb 2025 11:28:29 -0800 (PST)
Date: Wed, 26 Feb 2025 11:27:24 -0800
In-Reply-To: <20250226192725.621969-1-krakauer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250226192725.621969-1-krakauer@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250226192725.621969-3-krakauer@google.com>
Subject: [PATCH v2 2/3] selftests/net: only print passing message in GRO tests
 when tests pass
From: Kevin Krakauer <krakauer@google.com>
To: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	Kevin Krakauer <krakauer@google.com>
Content-Type: text/plain; charset="UTF-8"

gro.c:main no longer erroneously claims a test passes when running as a
sender.

Tested: Ran `gro.sh -t large` to verify the sender no longer prints a
status.

Signed-off-by: Kevin Krakauer <krakauer@google.com>
---
 tools/testing/selftests/net/gro.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
index b2184847e388..d5824eadea10 100644
--- a/tools/testing/selftests/net/gro.c
+++ b/tools/testing/selftests/net/gro.c
@@ -1318,11 +1318,13 @@ int main(int argc, char **argv)
 	read_MAC(src_mac, smac);
 	read_MAC(dst_mac, dmac);
 
-	if (tx_socket)
+	if (tx_socket) {
 		gro_sender();
-	else
+	} else {
+		/* Only the receiver exit status determines test success. */
 		gro_receiver();
+		fprintf(stderr, "Gro::%s test passed.\n", testname);
+	}
 
-	fprintf(stderr, "Gro::%s test passed.\n", testname);
 	return 0;
 }
-- 
2.48.1.658.g4767266eb4-goog


