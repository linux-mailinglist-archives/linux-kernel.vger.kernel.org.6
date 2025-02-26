Return-Path: <linux-kernel+bounces-534774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358FDA46B00
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4D4C16EA0F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC17239584;
	Wed, 26 Feb 2025 19:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pzm/OXZ+"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3504F239561
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 19:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598108; cv=none; b=QMAbYZ/rSCkejxLMqyoUj4iD+At4yofuyRYT0k/oarKGJy3cQh20me+CTgNaruDeXSSRsoVIC7oy8kU3hiihOQ63B1UeqUKT0q47cyaFvH+VfmvXiBkNkie2q9697YcByv2P2WKX4T4caoYg804j8eUj0/VeYU0DnuG9OuFSqrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598108; c=relaxed/simple;
	bh=tmN5JwTaZ421JUVQTXr4tJNOy/0VgsWNPYovSN2FDSU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Om7GHe/Kp/iRTQDlPQh8qV1GS7k/wQ6wPEEEv1Gpoyr8M0ppnF7Zwbd7zLzKgtDcSraDv0gkfFiof/hN84W5QL2difINv+dGW19QoVn2X7pyg9XNZCH/EvGvCv6icYMbn2Ea82zav8+Ak4q0kHKUojwgFeId+yqZ3tVHzyH/kZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--krakauer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pzm/OXZ+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--krakauer.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fe8fa38f6eso377609a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 11:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740598106; x=1741202906; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bfKyFrAiD8h/LnMC+tGogS6xsvZrTTIIDx60NZVpyZE=;
        b=Pzm/OXZ+TgUygYunrr38Ff4cgRZlJiJiNBJm79oEzx/i9MN5qv0SyOepDmYspAIIWV
         DFkLy2p9aKgT2LaFlnVpwOaUCbLWO5BpwFQj0mnHjQmalnKuk0+ECQiHFx6jlSV0nEvK
         0WlOxUAKfJQFoYxY3KYtTreUK0Nb+D+xqO4HvAjPCrhq/nUMziPUUn1gks6AwU3d2RGY
         eIFtLF/GXT/yYeGzTTwjXnoLcoP+0hpYlJMPcaEjAz/DDTJYA0RVRVDHbk1tnDOTiDcg
         AT7o1vx1+0V35NKKGp4RQR7jyLF8+NBuz4e1bu0yor8wHTUuqxHHdJcbvb0P/68hDArA
         WEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740598106; x=1741202906;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bfKyFrAiD8h/LnMC+tGogS6xsvZrTTIIDx60NZVpyZE=;
        b=ElJ6r2n+oHcidgVYqVWDVbmIDnycYd6+8POvgWEe8rHUGsowwOdjOpOvHJuL64vQfb
         pk7Kkt8bRMI2r2UhjFcBGgBwn4hsZPJ/RK0Mnk1k/6yrlF1rliYxUndv+NE21ZLxIfn3
         GnjDrpNsnNuEDkKOHokBk+MxbA5cGtMojlY3+p9u5ZycTm47ayqukEPaOL25rgErDfT1
         lDI2iglhH/2B0YcK2PM0z4fKzr9KgSRWkBSf2eY0QgPiFDwHxhytC3rCP3T84PqqVBAC
         SBZRxPvGTgARoleapb1AJV+v9m2RclR+CNnRHA/Cbp171QH4How0WfZgvsmyAEfDWkwB
         5exw==
X-Forwarded-Encrypted: i=1; AJvYcCV5f8gVMMu0khZFMCDH9k1Cnbr9/9f7frYgtj7KWbu4sHfRJJz1WMJZ6AibZVMTV/g/KTlSOqJg3HGxBKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx89ZdDldDBBWX9InQfi4D2vzfCrhmIc+0WwvpCBvXsvk+/MnHP
	3xmtp1t59U8H5SGchTc0v+z4mFo6iU3N7c02shtbeXWnls7eCThBconMHMdD8BdHqrHol3FD0kS
	+3fYb4LBf
X-Google-Smtp-Source: AGHT+IH6eAP4Cyst+V85LJmLhx2Rg1bDfnJ+WmNbTdbRluW4pkEzVr68R+e3txlLoA5Mp3lBArRubTvC02kHFg==
X-Received: from pjbtc16.prod.google.com ([2002:a17:90b:5410:b0:2f7:d453:e587])
 (user=krakauer job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5243:b0:2f4:434d:c7f0 with SMTP id 98e67ed59e1d1-2fe68ada3e8mr15762000a91.12.1740598106543;
 Wed, 26 Feb 2025 11:28:26 -0800 (PST)
Date: Wed, 26 Feb 2025 11:27:23 -0800
In-Reply-To: <20250226192725.621969-1-krakauer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250226192725.621969-1-krakauer@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250226192725.621969-2-krakauer@google.com>
Subject: [PATCH v2 1/3] selftests/net: have `gro.sh -t` return a correct exit code
From: Kevin Krakauer <krakauer@google.com>
To: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	Kevin Krakauer <krakauer@google.com>
Content-Type: text/plain; charset="UTF-8"

Modify gro.sh to return a useful exit code when the -t flag is used. It
formerly returned 0 no matter what.

Tested: Ran `gro.sh -t large` and verified that test failures return 1.
Signed-off-by: Kevin Krakauer <krakauer@google.com>
---
 tools/testing/selftests/net/gro.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/gro.sh b/tools/testing/selftests/net/gro.sh
index 02c21ff4ca81..aabd6e5480b8 100755
--- a/tools/testing/selftests/net/gro.sh
+++ b/tools/testing/selftests/net/gro.sh
@@ -100,5 +100,6 @@ trap cleanup EXIT
 if [[ "${test}" == "all" ]]; then
   run_all_tests
 else
-  run_test "${proto}" "${test}"
+  exit_code=$(run_test "${proto}" "${test}")
+  exit $exit_code
 fi;
-- 
2.48.1.658.g4767266eb4-goog


