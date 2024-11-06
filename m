Return-Path: <linux-kernel+bounces-398781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C869BF603
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74A6E1C2213F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C41207A16;
	Wed,  6 Nov 2024 19:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSG0tQD3"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF735190678;
	Wed,  6 Nov 2024 19:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730919925; cv=none; b=aGcD7aksZ/YuLAKB89Ir7dU8HXSMbVoZhc6w3oKpQwEZ6rR+W63oAU8C9BUNa8Q8qaGE9aKKP1nP6E/lbAflTR7d1OPaG/Uj+exCFNF59mUBjY5PZorv3o4ZDqdjOGDssPU9ShKTLjgAbA1e0t+8gTdXhbdbh3VJfRR9t+JLK4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730919925; c=relaxed/simple;
	bh=VfUQbcHeTqx1CU3myiQvEq+RQs1gzVpxtuheYp3105U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FLLkA8Ad1N14DxZ6PQtBciut8taOkJVOdBDjPQjo7f3LB5t2frzxeDr4+bK7EGkJE1IKfpMo9owZIb5CembhTnhsIsdPkHVv3Oeh3P2Murb4C+GXgnWgmM4ShePuk16PA4Ncc9a9aYBGWi9ti5q6SpvoDfZZCTlsgJr0r3js83c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSG0tQD3; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c941623a5aso2225616a12.0;
        Wed, 06 Nov 2024 11:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730919922; x=1731524722; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=git7RwFThytpqBRPQPjG3NYoVolRMqPNPDVZ2KDiULc=;
        b=CSG0tQD3yP7tG3SCqnH/dXFpqppNjS77VTDRdWbTKyOqwCV6OFAyvtvzZNw2pixbjT
         o0up17ugPeTRg/fVQ4qKrtZPbtUq4kodp1OqMB1YMI4iQywYzx9Qsc89xJMoH4V9/kCG
         S9HidKN8MvI/VNNEfag1MegwlbyDzI/iMcFobwVtidIrGvJwUMYmhxCnAJ9Kz46mh2bY
         t38FQlS9d6aRXDC1C42hI7QHHwDFvZflABmQoZjCmlz0+ZWuLQNtKxZC/DGWrMPHEYV0
         /zMlb/5DzGmLNssRutEaTtxgCcHCtn7vZhw73vAk8Cvu1sexKghNVSng5DttyT/P2qo1
         8xrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730919922; x=1731524722;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=git7RwFThytpqBRPQPjG3NYoVolRMqPNPDVZ2KDiULc=;
        b=G9n/8uo0BkQFFVsPRIvMs5u7I0QLD/1WOy/XTahDBYivZzgWautfaKR+ghKBDcs7Wn
         QbUfmYU1B5RQH2scGFGsjGzNhdhVa+zDxUtvJIokbTZi0xO/xPJIXMi8Dz5VPYO2gQq+
         e11KpLlI7dF0wY8B0keaYngQ/fLVUMkjpVGEG6INxcjJT3TX2vAKK36rW7cirynYN0hT
         shRiGlhUxugsQiA16CupqJCltmw6KGVRWpM/CYxU8PIjeITxul5guT1CYFkz7pEylBcS
         /FTbs3itvJaCvosrz3cFohCNABNMaApxi+BYvmuNpLNUisKSBuDnZk9FnU7wsjdCzCRF
         t4PA==
X-Forwarded-Encrypted: i=1; AJvYcCVvZY/qJk2XW+5lJu5208OunZ91E6cdaHzOqcLx0MdWNhXgujOu0cZKCPeR/7vcljtFO5pLHE0f/PJ/FMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWinIIyIkjBwwHlAjeLAMppBj7DiRflnL+C1NBmxfalbN9lyan
	dh9c1HD3IhaaC/ZXjhTHmKHL83nyQw0wlBt1Lm2H5PMNnjwPr3eU
X-Google-Smtp-Source: AGHT+IGLfWHfvOwk4Ib9st26djdKrupvyFqM40x8jybcV9FDbvsNfHRBmNjr49ZmGYpdWJR61X1euA==
X-Received: by 2002:a17:907:a4b:b0:a9a:babb:b916 with SMTP id a640c23a62f3a-a9ed50fb64emr23526166b.15.1730919921834;
        Wed, 06 Nov 2024 11:05:21 -0800 (PST)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb16aecbasm319207266b.32.2024.11.06.11.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 11:05:21 -0800 (PST)
Date: Wed, 6 Nov 2024 20:05:19 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Cleanup Spreadtrum/Unisoc ARM64 DT (part 2)
Message-ID: <cover.1730918663.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This series continues cleaning up various issues with the Spreadtrum/Unisoc
ARM64 DeviceTrees.

Changes in V2:
- dropped original patch 2, as it was split off into its own series [1]
- new patches 2, 4 and 5 which fix some issues found by Rob's bot
  and/or CHECK_DTBS=y
- rebase on next-20241106

[1] https://lore.kernel.org/lkml/cover.1730720720.git.stano.jakubek@gmail.com/

Link to V1: https://lore.kernel.org/lkml/cover.1723716331.git.stano.jakubek@gmail.com/

Stanislav Jakubek (5):
  arm64: dts: sprd: sp9860g-1h10: fix
    constant-charge-voltage-max-microvolt property
  arm64: dts: sprd: sp9860g-1h10: fix
    factory-internal-resistance-micro-ohms property
  arm64: dts: sprd: sc2731: move fuel-gauge monitored-battery to device
    DTS
  arm64: dts: sprd: sc9863a: fix in-ports property
  arm64: dts: sprd: sc9863a: reorder clocks, clock-names per bindings

 arch/arm64/boot/dts/sprd/sc2731.dtsi      |  4 ++--
 arch/arm64/boot/dts/sprd/sc9863a.dtsi     | 14 +++++++-------
 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts |  9 +++++++--
 3 files changed, 16 insertions(+), 11 deletions(-)

-- 
2.43.0


