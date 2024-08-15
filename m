Return-Path: <linux-kernel+bounces-287783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F84952C86
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F1601F22F42
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A081D1F6A;
	Thu, 15 Aug 2024 10:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fd8Acjy2"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879641D1F66;
	Thu, 15 Aug 2024 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723716747; cv=none; b=aN88FQlT0ekJUeDbGoRJJYyq8AYE/JzWVkz4sN3yV0eFBLA8eOdlhMXbdu4WE7O2+sRvLe4UlkfCboO96esykYTAWMDv9QjRadWefSXu1bBqEdesmhTg6DlDpOL1j6Y0iURZPgQf/AJJzoDIXZAIsNZgmD43bcMZUrNrNVPNv48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723716747; c=relaxed/simple;
	bh=biH7O6nTuN8fbXa0zhvTvqes/BVmpfb1NBLLfSf/e0M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mDKGJwDKhgDL38K5+W+xZowkEZPpyljN8RvVqIbJSk7ER26XMeVWcMpSTfLNudwQLwH2Z4A9bSS2SJEWNfJPwbYiUG1RrDJ27gzGbAqRmi4XW7xLmEBk2ewfEdNRGvtE7l0YpScuEinZcfMhbSDLpEAYof3OCY5W5ePwoIaCqjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fd8Acjy2; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ef32fea28dso8641241fa.2;
        Thu, 15 Aug 2024 03:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723716744; x=1724321544; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2HBrJQocQ2NV/H8twGXMjQRcU6pvTs/LLYhmuYjDNFk=;
        b=Fd8Acjy2msRGu90gruTGGSLGOO6qKWd7TlZD+8NTQ7WOE7DQUNbJayBIDRLcIJDs/S
         ZiOKArFSegi/lS4GDbUWduWnbbCV24/OUAbAI2kqws+vSBC4qNkz8zcyxLcORuJvueLc
         wdW+yJYCXDCqfGDHaseqoAogGm9/1CUvGWpKfrjmLliF54d86Xa8ZAI1On1kyYSh2fPq
         8CoF7ZyHg2ET72RvW4Aq30b1jFKsvq4qjpcIwMRxiH9/bppXDdNnPDFJ5DeXGhCVb+E3
         TwDrM5qsUpu3GUli1/tURLLkfeipFv+c3PqA1S71YP2NdZ6w/jJXB7EA5Z0sy65pbHjt
         8lLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723716744; x=1724321544;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2HBrJQocQ2NV/H8twGXMjQRcU6pvTs/LLYhmuYjDNFk=;
        b=gpbQak5Uux5cwHPkSvygKbMLF0Rm/edYW88jdnogtu7ekkQV7gLfXxq5qP6EPrPsF1
         inw0fSHJej8PhQLaeuor3oTh/X29cG9bHDwjxp/u+EYu2hPswT5YfSm0bQN8KeFSl4FZ
         Yi/AXNWgzWivHOGrT9JfyevD5tJMCkrKsxHscDhKSES2ZGMfQR8vwwas6oW4NdgT0+f8
         ibx8dDmHhiZltUNSlEkPEpFglPjvtdyTGXJ0EcJ9jC17fCmOWvp8vI3PhsiKzbIrIpLZ
         uDhR6UmnexaAzCW8vlqVjR48phnTdJMfqp0tXSQX7HmXJ0c8pNxqbvHmJb/vXQjPWIWa
         sd8w==
X-Forwarded-Encrypted: i=1; AJvYcCX9YwC0K9hXp0wX8DL2YmYtzj6MtXhbrs6zb+k9hpw+Zcbb5NlNRIvnkCk/DbuGZLlmpVpL9Jd+Z7fjGoRu0dRFqQBtEMWy24uXiFop
X-Gm-Message-State: AOJu0YzUljd4lwSWXFUwNweUmHmA0p95JlFARDOnuGcjWfIdPweBayr1
	93/XRdl69gHMWcg9H19XFqZB1DZEBdI9DDv9NN4RKIfTiE36yLdF
X-Google-Smtp-Source: AGHT+IHdRRrl2i0bIVEiaYUUmzc8+0VN3rn+S089ZkrIWem/piRbrMSRUbTdoZXALns7+bLKqCAqNA==
X-Received: by 2002:a05:6512:1111:b0:52e:faf0:40c with SMTP id 2adb3069b0e04-532eda6449emr3748691e87.3.1723716743157;
        Thu, 15 Aug 2024 03:12:23 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cf97dsm78167666b.72.2024.08.15.03.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 03:12:22 -0700 (PDT)
Date: Thu, 15 Aug 2024 12:12:21 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Cleanup Spreadtrum/Unisoc ARM64 DT (part 2)
Message-ID: <cover.1723716331.git.stano.jakubek@gmail.com>
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

Stanislav Jakubek (3):
  arm64: dts: sprd: sp9860g-1h10: fix
    constant-charge-voltage-max-microvolt property
  arm64: dts: sprd: sc2731: fix bat-detect-gpios property
  arm64: dts: sprd: sc2731: move fuel-gauge monitored-battery to device
    DTS

 arch/arm64/boot/dts/sprd/sc2731.dtsi      | 6 +++---
 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts | 7 ++++++-
 2 files changed, 9 insertions(+), 4 deletions(-)

-- 
2.34.1


