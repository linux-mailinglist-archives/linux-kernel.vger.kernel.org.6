Return-Path: <linux-kernel+bounces-277677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D12E94A4A9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4115B23CD3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885891CCB55;
	Wed,  7 Aug 2024 09:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l03lpOE2"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317841C9DF6
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 09:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723024062; cv=none; b=POfvwUnsZAe4MbWNNMiXoPoWoDfPzAzCkHXT9QXotQjzRkxCxrLMGCwMb7Ca1lvOSyns2lkonXj8+dNTxvn5H0VVAdJMQir1I5J7VmfB5PYF9oJC9y5G//xBHFeYqCQ431XjMOaDCGW606oLjRQIZUDw34F2fVjaZ4KXi5yO+VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723024062; c=relaxed/simple;
	bh=6x+6CNfz/QRmD89Wo+qlPjABVXpMon1ANdDhhrDMjQQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DGyEuRu6Ixx6e2XejXsRHul+EVbRrPZ5UM1Asff8/xD6cEV0RLNVp4DcrB3B5kK/8PUFSSb1UDqDvYBrh1u5riyKLiUuRTKVyjE1aB7prD16SvIlTkOtLi15Jtc3vFUd42qKPSRbZqr3f9rXGyoG4N1NDUHtgDoKmP6o/R6UfxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l03lpOE2; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-368f92df172so909222f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 02:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723024059; x=1723628859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJQHsbfoE7TFW1nk5Vz1y5TQhi7f866NwaqHk3t7uII=;
        b=l03lpOE2ipvuioRhHuD7qdVpknQ+UldzsSKLo7HNnJei2AjgP/bdo+zFe7YIS5oAUZ
         Zo4O/yhF1aT7Fo8aflmBNGppRKKmN0UTjCGwGmlrojASOm1TQtGeZ6DxUV5ncRuSc6lY
         zRBxZWqYaDC9Qs+RSrJJBh7bcaUVZpvlFwS+PUXIQxBqukpKNvEy3n9nj8zf0DCO70xw
         vTgSBAfG6cjDi80mmw61q3qmhF5oI0w1kqHJm3f2dZlr86M8tfXLGqh6I+V/mPFBW7mv
         OhfiukO2i7PeP0n88kQStT3jFQu3ybQtU/16meCQNPEoUncCjTlvweajWXRKw8OufxKM
         5wfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723024059; x=1723628859;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJQHsbfoE7TFW1nk5Vz1y5TQhi7f866NwaqHk3t7uII=;
        b=cltJqGq+PsPQ2qfLSZymTtnipE80Gpc5gOAN4Ox5UgJfoj/ffW2rJkJpG+FrXVwB/e
         xgRPK3IhfxxribCp826lXR/LLw8BEJ74ETysnwSslvEzYPLCX2gHLc9mWpx0AGSFnAvM
         Q90Tlwp/CA6tFDxuMOBmGBmW05TPO+TwkpRDzS4oRZ2SqklG+Dtieo7Ury8LXQJk4Jf7
         4nL7J9bo5C737oMJwSUwNO1i/SOhQbTcUcLkbRbwq2hZNufwcLFxt8ko/gk7OBizLjXg
         75wzqq76NgcTltuFS6ABrBeFeWljLzwspIhtR21MVvV/PCeRCLHns1NQBVyI4uZD5dPL
         5Rig==
X-Gm-Message-State: AOJu0YxPhXR+0iV1PtFhKEuBcaH7WF00UKQl++mbL8c3n85ziz2z6mCt
	EsASvHZKz5DS2zuMIsC4RqTq4TLzjY0JEK/UItUVVmqbLzUhJeH8RTA/MqMU9yA=
X-Google-Smtp-Source: AGHT+IFBtj9Dr4+asYh2JrcgIRkmKZzgumtHsO0v56LqeHKjzeBYOvDsAtsQ+HR7b0iDb/7ewj5FOg==
X-Received: by 2002:adf:f08c:0:b0:367:f054:7aba with SMTP id ffacd0b85a97d-36bbc14aabcmr11073921f8f.41.1723024059373;
        Wed, 07 Aug 2024 02:47:39 -0700 (PDT)
Received: from [192.168.68.116] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd0269ffsm15444437f8f.58.2024.08.07.02.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 02:47:38 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com, 
 robh@kernel.org, Michal Simek <michal.simek@amd.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Kalyani Akula <kalyani.akula@amd.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>, 
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
 "moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <5eeb68b920d1ef186c4f623698eaa0557e0fadc7.1722325870.git.michal.simek@amd.com>
References: <5eeb68b920d1ef186c4f623698eaa0557e0fadc7.1722325870.git.michal.simek@amd.com>
Subject: Re: [RESEND PATCH] dt-bindings: nvmem: Use soc-nvmem node name
 instead of nvmem
Message-Id: <172302405770.381779.17877643051844659651.b4-ty@linaro.org>
Date: Wed, 07 Aug 2024 10:47:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Tue, 30 Jul 2024 09:51:12 +0200, Michal Simek wrote:
> Based on commit d8764d347bd7 ("dt-bindings: firmware: xilinx: Describe
> soc-nvmem subnode") soc-nvmem should be used instead of simple nvmem that's
> why also update example to have it described correctly everywhere.
> 
> 

Applied, thanks!

[1/1] dt-bindings: nvmem: Use soc-nvmem node name instead of nvmem
      commit: c258adca4fb41965473fee30e1821040f925da8c

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


