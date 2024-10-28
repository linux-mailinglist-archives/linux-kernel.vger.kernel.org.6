Return-Path: <linux-kernel+bounces-385326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9389B35A2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5020F1C2074D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352651D9324;
	Mon, 28 Oct 2024 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z0bneDBl"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857951891A9
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131326; cv=none; b=RFDGYT/II8FaW2Z6hmuksPZlzMAmReQm2UwAS20t32okHbidI5ZS4JK/iTeYp2PvxEvmN3M2DXfLznyPzzEFlQEDEbcJN+J5AbqaZRUIsI1thNrzGyIeKXVUF7Qvuj4SWKPAx/zCM/e5G2KvCuKtRCYc7TNrxDmmEiuSYXfj7M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131326; c=relaxed/simple;
	bh=Ja+nztUw8OHVMpGwlTFOEkyEgHREGqCIwKgRmk4ByUs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uejZBX/YGj1RDkUSlVejwCzvfGUjf9szEjaZMPTGZsS3kWdKArNHDoTq3/CuwdgyWzqrZ1VXp3tBqjgm+xjGXjFOXLGtbFhXiO8u+iTx/t/OwzIgyPUKu4Ru192BTSaf0qLP2FPyeN2GeEo7kCb0y1+/3trQsY0Dj0Ug4aS3S6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z0bneDBl; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539e7e73740so3760827e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730131323; x=1730736123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVgI1AZPmSCTdx25fOhCvnKk8USN7BfMDJrb3FGOE1A=;
        b=Z0bneDBlGfkkuqti/Nw0/pTooPx+9+RdOLQn0PK39MLCFsI7i0CaqoQhW51F6+75cj
         A5Kh7HzjElcien44BpJTQqtgSZAs2X/qMkr+3rqFaTnGYdS7tzj6Kkmnu6nQ4WbbskTU
         LP0Lbmhlw11bUQZoCjWHn3xtz1WqEgoinI/hcy5Tq/vSUT/sXr17p21K9bBSSD91ILz3
         PN363OqMNfLjAkZzBxeeSp28OxO23353L1/y893FZalw6Twx6/PE32bsXMGVMdLT8jB9
         yLsmSEaadcX5yzcCV1w5aILTPFB3AWNTbyCgvmBZJQLcoBKfO3gkD4b9tjtQanqa/CMh
         sHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730131323; x=1730736123;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVgI1AZPmSCTdx25fOhCvnKk8USN7BfMDJrb3FGOE1A=;
        b=phqg1AsEvoqynxSpgkGgedXVom0pNgd7AGwxR0F9qd8zq015GYe2Mb/aZgbcxXYNdA
         umlZO5D5CcbJ+di8FxahAQnvOfnCC5Qxe+mq+bebpUaE5o2Ds8hubkAcAnSM6Qe2m2iz
         wsxnGFVUQ2gWbATFb7mQyYLV8Dlz+EZtSNiYMon/voBngKvamNlDOLQPtvmL5W/W86+b
         iqrq+vIHVn8FYYOh3WWKQIQ9abxtEK0IE/p6St8iEqR91tqU8EPQUn0zCoovMxP/3mzp
         0b5vbj/Td0BtPsn00VPwyPU1EuD1YPRbN6GNCqwVSlv0vA2//AsdO0SiwQiXQeFKq5oP
         a8lg==
X-Forwarded-Encrypted: i=1; AJvYcCUPUCmgcSkh5Ar7QiX6rhw+NqLS0a/jrqHl8NUc74HgQYDFlJUZszofBPZ/UWHhS+VWkvK/X/dJ8rhKZHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4/h1g7apidc/NWH76I6c2HiCpebglPGEbftFV2zo0upYP4Xbv
	EmvhZa6Lv32N5BkcBplcnYdIjZz73SgcOolWD0I9KqmhO+ng1QdFlmyzWTbq9fY=
X-Google-Smtp-Source: AGHT+IHUdHgbCbryOriMuf4RJqVJqghNeLBvZJVumcq7AKcBSYtQ1e4J3BwijcR++iMPq2zZfGvWiQ==
X-Received: by 2002:a05:6512:e88:b0:539:f37f:7d5b with SMTP id 2adb3069b0e04-53b34c43009mr2853707e87.60.1730131320232;
        Mon, 28 Oct 2024 09:02:00 -0700 (PDT)
Received: from [192.168.68.111] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935f7213sm114084545e9.32.2024.10.28.09.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 09:01:59 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 Yanxin Huang <yanxin.huang@unisoc.com>, 
 huang yanxin <yanxin.huang07@gmail.com>, Wenming Wu <wenming.wu@unisoc.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <c487bff193db7a06b846976a80c02c37509943ac.1722841057.git.stano.jakubek@gmail.com>
References: <c487bff193db7a06b846976a80c02c37509943ac.1722841057.git.stano.jakubek@gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: nvmem: sprd,sc2731-efuse: convert
 to YAML
Message-Id: <173013131920.328405.6378963521136172479.b4-ty@linaro.org>
Date: Mon, 28 Oct 2024 16:01:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Mon, 05 Aug 2024 09:03:02 +0200, Stanislav Jakubek wrote:
> Convert the Spreadtrum SC27XX eFuse bindings to DT schema.
> Rename the file after the only in-tree user, SC2731.
> 
> 

Applied, thanks!

[1/2] dt-bindings: nvmem: sprd,sc2731-efuse: convert to YAML
      commit: 786700e267b0ebe89d72eaa18146f1cc602461a4
[2/2] dt-bindings: nvmem: sprd,ums312-efuse: convert to YAML
      commit: 24c50e7003bf699194f223711f06c1a5fb3eca29

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


