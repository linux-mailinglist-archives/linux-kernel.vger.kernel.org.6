Return-Path: <linux-kernel+bounces-357654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC919973D4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0178128524F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4316C1E1321;
	Wed,  9 Oct 2024 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="vRop6XzL"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFED1A2630
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496520; cv=none; b=jPje5xiZIIjNjq9M+2fCYjWoRS22XBHxl/8tZjPsrhEhHdT2Eb6x6EMWAYNcGichx1LjI/iVpyqSB608FPiNACdGM1ipILIYAN1kflAjRb1WTK3CDh5lIo7nB+X0o/zNLsXaR7FwPORFCcj6Adxj9BaoHaeK26l6wtc+44+o1JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496520; c=relaxed/simple;
	bh=vGJLzVn6ACBjNyAxufJAhPEnZGXpgNZxXi22jQsdtlA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J53x5Z8YAVjIdrn5RwNKcbzcpcmIdFavu9yGfQ44PJUrik5LUeE1gW8ujSEGi4wwt4ZCUfR3vNdI2pSe0xUmjRx6sq160YCE8TUO+n2QPHm5Uqx1DfxsOvKHgyEpxnchpL8oakVmk37klKCpNcsCDi8j7tQlcVhhsQsdNx7NNOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=vRop6XzL; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7e9f998e1e4so36460a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 10:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728496518; x=1729101318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HH/gzvG8N4NA1DWdDdAxFZw2FZEGnZKbz4/QrTFxK6c=;
        b=vRop6XzLw+DIvMoZstYNqph1NMPof2mEt4lrfLHx9VdT5kotLm7QXyQna1xIqcahg8
         VAGE7fpZPVKzRlc7FPazwFsOUxXc+RpBQstQTAuPFcth1TsoEG3cZARs89Z8DqEbYoJX
         8/CKrEEjYRjwHc8TtDF6CveAZFy70/veN9er0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728496518; x=1729101318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HH/gzvG8N4NA1DWdDdAxFZw2FZEGnZKbz4/QrTFxK6c=;
        b=hhFDGmcQZEcUwBI4VhSyrTUuqH91TnBte6Bq1YbLuoqgmwFTF+9GcI6WUNqhdZ9pLt
         HeU+X1eMOSGoqTOXX3buSpq5jAjaOGahfNZK+M39/oR2O076uTlRH/SqhrNYDNl3aNFT
         UwrT2vHZZ3ALHpY+9rWWzVIjYiBBs10evcTcj8+aIym20LdssbIaFwzOJYIfR+5RNu5j
         XMmhEWCU+gV8MRRhHSDghAjhddTMoZqO12eQeVT86m8WbcyOPaK74Rgf6UeHFG0DSs8j
         LqdF0HMSERhG749jFHB4MiA3u+f52A5qvA6P2Fiy6v1rvcDDA9wbl7ELU9kMkWLjlSDc
         Li4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbUOgrYQV3o6In0piXx3b8Zfnhf8jlUWmpzlXBZiiRJ58le5FbeXFWpchUe0xux8hij6YyMb1sOXHZAa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKuETI8wqpPcTvuI8nk4ZwfUo+Z+LSLd/awgBmWhl+hqhtqGN2
	/E7RJcvfba3Rco5pkvSUj3/MfCCXrLNIzCHmAs9iRM5Tyj5g/ML3antLSWZKxHU=
X-Google-Smtp-Source: AGHT+IGn4oqdTz2c/4KgQ/JCXeWAlimaFO1vIWCBGOUjzPUnpUWNpMDvCnm/bUqgZsWrH4Un5kvs+Q==
X-Received: by 2002:a05:6a20:d494:b0:1cf:6953:2872 with SMTP id adf61e73a8af0-1d8a3c4e2b9mr4667261637.48.1728496518543;
        Wed, 09 Oct 2024 10:55:18 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbc86csm8044685b3a.27.2024.10.09.10.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:55:18 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	Michael Chan <mchan@broadcom.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [net-next v4 0/2] tg3: Link IRQs, NAPIs, and queues
Date: Wed,  9 Oct 2024 17:55:07 +0000
Message-Id: <20241009175509.31753-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v4, now an actual submission instead of an RFC.

This follows from a previous RFC (wherein I botched the subject lines of
all the messages) [1].

I've taken Michael Chan's suggestion on modifying patch 2 and I've
updated the commit messages of both patches to test and show the output
for the default 1 TX 4 RX queues and the 4 TX and 4 RX queues cases.

Reviewers: please check the commit messages carefully to ensure the
output is correct (or on your own systems to verify, if you like). I am
not a tg3 expert and it's possible that I got something wrong.

Thanks,
Joe

[1]: https://lore.kernel.org/all/20241005145717.302575-3-jdamato@fastly.com/T/

v4:
  - Upgraded from RFC to official submission
  - Patch 1:
    - Updated commit message to test more cases, no code or functional
      changes, so I retained the Reviewed-by
  - Patch 2:
    - Switched the if ... else if ... to two ifs as per Michael Chan's
      suggestion when tg3 uses combined tx and rx queues
    - Updated commit message to test more cases, including combined tx
      and rx queues

rfcv3:
  - Patch 1:
    - Line wrap to 80 characters, no functional changes
    - Added Pavan Chebbi's Reviewed-by
  - Patch 2:
    - changed tg3_napi_enable and tg3_napi_disable to use running
      counters to number the queues as there is no explicit queue index
      assigned in tg3

Joe Damato (2):
  tg3: Link IRQs to NAPI instances
  tg3: Link queues to NAPIs

 drivers/net/ethernet/broadcom/tg3.c | 47 ++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 7 deletions(-)

-- 
2.25.1


