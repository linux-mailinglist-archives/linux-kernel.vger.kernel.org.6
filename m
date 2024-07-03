Return-Path: <linux-kernel+bounces-238765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0034E924FAF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 05:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02B41F2712A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 03:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EB21BDDF;
	Wed,  3 Jul 2024 03:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJaV9SuR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AA3179A7;
	Wed,  3 Jul 2024 03:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719977859; cv=none; b=Xr6sROEgTDDkRdQPhQpHIK/oxZ4WG24vZtVB2NDfXChqZ44IwIx5MmaobSUZLfIpmQcnJcoudN/qAXmizOUTpWOYOF3GEmLkLxw56s7tJPAOnp5PRuqNcgeSRJmk3zN/Y5exKxgtK6tHYuUaSHkhT8EFvosBm8dddBeGVzTfxSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719977859; c=relaxed/simple;
	bh=TKNuj3s5hgjlAKUYrhAtrnYowCoo5S2rLYMKN/O8nP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l6BrdeG8Ff3Leh2KpmtwRsleTpnTqVi2w1VJvzZ4PtYqHOOGGpHO75E15kfBgQKj/zCf6PH7U9m1O2rQIeE+8VMBIyVz9t6me288QoZvoYaBa9BrjAMLhTRdJ/DogUaVh9cfMeG7N1ytAdc5wfM2BZFypO86YpBGagBP926IVdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJaV9SuR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A353BC116B1;
	Wed,  3 Jul 2024 03:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719977858;
	bh=TKNuj3s5hgjlAKUYrhAtrnYowCoo5S2rLYMKN/O8nP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bJaV9SuRgeNpiehsAnxoLXyxfug+GqhmmUlIqarCyv72LiY5YdjhQK40rwIvtNpUA
	 /f/M1RD9I9PRaEnmTz/yk2KJfmHIcB2AYekIyVUFh6PKqfEdvxeDUrtiO5iLa+h06g
	 adjhV5HJrQ2NzVnjHEFKKPGya2JpfEi44vTc9x9jEpotrNQEFSlD4JILqY/Ny5s0KW
	 fjWaL6aCPcN4I8bx8rQakSK12292lUSl+3SUsT5AgmIn3UdsPRauRyR1MVbv/OmzFv
	 B5PXPqQC9IBV01Qnqv2O6eC5pfd+1W41tusnimkHDX/BZMnnie6103Y1ElX1k5Lecu
	 ASmWMbxYbcMSg==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Abel Vesa <abel.vesa@linaro.org>
Cc: Johan Hovold <johan@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100: Fix USB HS PHY 0.8V supply
Date: Tue,  2 Jul 2024 22:37:21 -0500
Message-ID: <171997785349.348959.8911660847944738029.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240629-x1e80100-dts-fix-hsphy-0-8v-supplies-v1-1-de99ee030b27@linaro.org>
References: <20240629-x1e80100-dts-fix-hsphy-0-8v-supplies-v1-1-de99ee030b27@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 29 Jun 2024 09:29:43 +0300, Abel Vesa wrote:
> According to the power grid documentation, the 0.8v HS PHY shared
> regulator is actually LDO3 from PM8550ve id J. Fix both CRD and QCP
> boards.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: x1e80100: Fix USB HS PHY 0.8V supply
      commit: 9c99c33a904c86d95ecf4e2690de6a826b88671c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

