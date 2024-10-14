Return-Path: <linux-kernel+bounces-364568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104FF99D63A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C585B2837D1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBB01BFE10;
	Mon, 14 Oct 2024 18:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m4dau21N"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD751FAA
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 18:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728929738; cv=none; b=YeDpI/HZU2+wBfx7EoscNOtXH9HJ7jG2NFEzjqflL/zOQCyxe62u85aW+BDRAcOi187LJx5wv6/s+tWjVc5uFpOrCUCZlhVoTs+WBRviA5y+QBlgOOQ/ch4nYaoG8qEptyrF/YzHw0Ey0fnZpVgeHSDav20MaT6dEQJllDl5qMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728929738; c=relaxed/simple;
	bh=tawDe/qMib6Os9HlJWLzs0aXSDeZTKKfyVNAQDqiuzs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q9GXhyMEciacy7K+dmQuZMhJfUah/ee4/QDn1VbblIoa9ugIBTbTurC/Hf2D9LUKTuGG8cXf1yAqRg/aHo/ur3lrP1Dyz8dgJrtayckiCk3h5qfy6HfIXWt+XIczA+u3tsLKirU9/3iLY3gv13DUAIL6Xa8McTxmLE3rSmDoNSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m4dau21N; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d4dbb4a89so363418f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728929735; x=1729534535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyI6QU0sEQSUgQx8t01Q2w+9b49AL4RDi5tUs3mTrEg=;
        b=m4dau21NoK2NcL2q/5ZX93hRw23wbLXVYV3eY+vu7AnfkJOKeLVJeU9/qHpQWHoekY
         I2D3f15J0bZi1RW0uYNpPDbWrdP3VWVcoNl4oadpUQx6JvBrkLcu043ma+W0xuQO3Vpb
         dFs0TfnnfVpclvSDXv2bcDUqRohhbaDHEjjJohq/MUJ6YNByF09/aYD4s+q00+5ZMTCN
         kWEqH/9P58SQkNkHuYiebRdAkywKbv/jEKIj6ybC6+smBytWXenuAif/xpIwL6ymizdz
         /RrWrAJ6MoRjSs/mQYESAT9e9hJ/Vd1Psihw9BxorrZ7Un26ewA4SBd/oCRDNxAFWMee
         1fFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728929735; x=1729534535;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyI6QU0sEQSUgQx8t01Q2w+9b49AL4RDi5tUs3mTrEg=;
        b=llgiUSWmEG2kTY+LkJFK0HggsL43eRB7+o3D63Rsd19kt8UWwFEV0xYVrjqvfPufZN
         CVRKNVBzja9FDt4WjwS9rzH9TNpl3XC2uqeK1cRZhQXpH2/Hjr/dDohjfR8ryk10tY0c
         oXNgwA9FZ8U88oLgiRV65oJqsOlqpKbqE75PwhyypSPbcw4qXtgt2uDKW4SAVD5HA7oK
         RoR83P8JNMrjOgTsHk9wcmMZG72Lz3OdiA1nvYQ3qXK2Slv6F/j9XHiknfOd/czcBaB5
         85/NmT2wsiwGxY/kOqKRDglWmYlgGeLSYAm22rOYxHzluULvTiUrQCVleTgY+ooHFoiD
         mAbA==
X-Forwarded-Encrypted: i=1; AJvYcCVmK/NoWE/BdQDxlVDXkDK56+f/1r8cPxX+cHcQRcnuFFB89MmDF9r2suOwPVLMAFKH2bLPZhkS56uYCd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBU6j2vS8ZMbeFq4XD3jDu0DZks1K++g/mYSg0u4VaKx/OYafA
	/kLEOPngcEcRG+EhHuLycbo9uGR2ykaJXvyoBUP8Pzf1UE9Et1msXWFOXNgESAw=
X-Google-Smtp-Source: AGHT+IHlBz6hKnnQoHQGH4XDSGgKi1fFso9iF2cyVIW1C0buU2/RjXy9iYdZPwGAexx52W0HdcJ0hw==
X-Received: by 2002:a5d:64aa:0:b0:37d:4aa2:5cfe with SMTP id ffacd0b85a97d-37d551dd618mr4358751f8f.6.1728929734694;
        Mon, 14 Oct 2024 11:15:34 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6cffa5sm12065947f8f.53.2024.10.14.11.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 11:15:33 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Esben Haabendal <esben@geanix.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240913-fsl-ifc-config-v4-1-ae4b012fc402@geanix.com>
References: <20240913-fsl-ifc-config-v4-1-ae4b012fc402@geanix.com>
Subject: Re: [PATCH v4] arm64/configs: Update defconfig with now
 user-visible CONFIG_FSL_IFC
Message-Id: <172892973241.360345.9958529372232338977.b4-ty@linaro.org>
Date: Mon, 14 Oct 2024 20:15:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 13 Sep 2024 10:13:12 +0200, Esben Haabendal wrote:
> With CONFIG_FSL_IFC now being user-visible, and thus changed from a select
> to depends in CONFIG_MTD_NAND_FSL_IFC, the dependencies needs to be
> selected in defconfig.
> 
> 

Applied, thanks!

[1/1] arm64/configs: Update defconfig with now user-visible CONFIG_FSL_IFC
      https://git.kernel.org/krzk/linux-mem-ctrl/c/1f1d847a657523e182df87f88158b607afe7d559

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


