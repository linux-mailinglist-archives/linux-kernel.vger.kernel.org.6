Return-Path: <linux-kernel+bounces-214305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E80CD908286
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8DA81C2125E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32FC1465B3;
	Fri, 14 Jun 2024 03:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKPG0LnB"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8326450FA;
	Fri, 14 Jun 2024 03:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718336333; cv=none; b=SkTVIRA2BrmEZXjo49OrSFVqXwJjI6i4z9JGNYMzGvZNNtXuceWsKyd4YSbKwb7tHsFRdkhVPwvrD8ILfrx/xFWcupTyui7d4VlUYMu5Qd+N/V6jxd68gdF/5EsMM24VVXbP5cCOU414tD449rG9ehXya025QTRNwp3PP01GRfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718336333; c=relaxed/simple;
	bh=H9pLEW+jcSqO4qvx420Ox7cEgWTk69u1drhQYBQxEBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dOgePoq7sP1kbiOU8ZHDOOs/YWtrcLLX/SRn5KluigtRhPGkHATy5fWidyQ1gko2SCF71ERcGei+qO/sDhfocxM7JAgXynABgzaCC356bOrxHmhV6IOzpYkrl/k5k3sGpVs2t9yMFP+gQlZB4Y0km7RrJBIrcD5mq9HBn9OEEOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKPG0LnB; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f32a3b9491so16581825ad.0;
        Thu, 13 Jun 2024 20:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718336331; x=1718941131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8EIOafHu2tfF0pQDUe3ifhj3+Hgh42ogyK3g0fhBvgo=;
        b=gKPG0LnBl097IjR961ZXNJrO/JpkAskr/BdBSoPW372Vsm2al8GQAJNkUwFYY733I4
         bZmiV5xjje7d70JG1t7fKtE/yiHd4Y2U1XF026LZcSzDtPimkL7Syx2bgkvh+rBPKYOB
         9wOs11l6U7Ne6YUHop66+G9ff61cUOSCEo4qy8bJaRwBZAuWip9ION/6W5ppMKIYqIVh
         ynuQSdaOBCTM+FljEXXwWGGDDKZK9psQlwLR8hLLtJRAIdwJGRZ9NrjRDaFKhyPUlWRi
         w/ZJnk55zoP5VioLSvkIPPyh3kFw6WRLcwln7ifGTVwRDaIfoEAKyu/wfDmlvcN2JvvV
         KfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718336331; x=1718941131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8EIOafHu2tfF0pQDUe3ifhj3+Hgh42ogyK3g0fhBvgo=;
        b=nVsuD3j9oTQlRkQVsZND4rn6BtsBh/5XcByUgpuiZ9Np85vOGt06h6VNUPXW5CoGhz
         vHExkFiLWNr3dieTVfk0exGZdg3oWM87pYq2J5XcPGatg1EObNIFH9r0nG7GDBUA+7pG
         ioo6sue0c6SIFG5n2f7n1CgLnKObwuzYZoHaQrztu8VoTuovaqRHgSTSqrbJ27ILxrx4
         aXUNj5eWN2OXINJQBCf4qFOFtcIUkFnY9PBNFG3Ln37AgjjRyQKPm6krvIxwpXGMBHT1
         t4dTAi35WbWsPRKQsfu+asgu+qpePGhg+cJOzX8IJCrxL22n9lBAXvM9mahV/Ib/5p99
         EZ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUT0mqzmPQ+/2Vny586JXS1kMuO9tMQ3FftSmgc/sji/+1VzG1tPh+pHzwChkA/D4SkFcEMQabThzZMDkP1QDmEZB7/17xlHa7KuWoo9Ogjd8z+5W3BZmHdCyW/r95YM+NKJ/B1TkIf79gMvJt4ZcmueocY37aeGP0MSwaysYiPiH16xHeE
X-Gm-Message-State: AOJu0Yx6ehWA7fsC6glOmtY2pwPpdIb9BBkx8ShkkJpZqxGIITagA/P5
	fP7FdqUgidBcyZ1jNMz8crxguc0Tw8iW9Szxxzlfs2ZmOjTSoRB4
X-Google-Smtp-Source: AGHT+IFl9IiAnWaC4LbnaHoK3cGZHAQDQaDYlbvq/bF64TWtSKo+qRJPYIwuhsSpMin2YrLMhW79qQ==
X-Received: by 2002:a17:902:d4c1:b0:1f6:7f8f:65c7 with SMTP id d9443c01a7336-1f8625d4645mr19917805ad.26.1718336330903;
        Thu, 13 Jun 2024 20:38:50 -0700 (PDT)
Received: from fedora.one.one.one.one ([2405:201:6013:c0b2:ea4b:30e0:4e3a:ab56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f002b0sm21824085ad.192.2024.06.13.20.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 20:38:50 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: Animesh Agarwal <animeshagarwal28@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ASoC: dt-bindings: Convert realtek CODEC bindings to DT schema
Date: Fri, 14 Jun 2024 09:08:05 +0530
Message-ID: <20240614033812.51312-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey all,
This patch series converts two of the thirteen realtek audio codec
bindings which are still in txt format to DT schema. I have chosen
these bindings as they have in tree DTS files.

Thanks,
Animesh

Animesh Agarwal (2):
  ASoC: dt-bindings: realtek,rt5514: Convert to dtschema
  ASoC: dt-bindings: realtek,rt5631: Convert to dtschema

 .../bindings/sound/realtek,rt5514.yaml        | 60 ++++++++++++++++++
 .../bindings/sound/realtek,rt5631.yaml        | 63 +++++++++++++++++++
 .../devicetree/bindings/sound/rt5514.txt      | 37 -----------
 .../devicetree/bindings/sound/rt5631.txt      | 48 --------------
 4 files changed, 123 insertions(+), 85 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5514.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5631.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/rt5514.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/rt5631.txt

-- 
2.45.2


