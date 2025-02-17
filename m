Return-Path: <linux-kernel+bounces-517405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5BBA38053
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B77E07A05DB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C775B216E08;
	Mon, 17 Feb 2025 10:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mz1MrXcL"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C6B2135AF
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788607; cv=none; b=Tm5D6ptx1ymYoKoGmTuhPQxdpxPvzaLwrAcFE/I1eMJs33DFvNLWOUEQZPTUfvMo1Wl5JACx6taRHjbETL7KGBI9rQ7YzwOC0Q4gQDWADVt4s4aWYHm10yi1kRnQXebWKBBsLm+wXy1TL85sP8whnT98tB6H6NhqfFkvKr5IZlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788607; c=relaxed/simple;
	bh=HnkP/kpNRRh3mtnxaRpe1uO4+q+YSsKHfwC2hyaD4NY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IvKPjR2rQi5rz6+FvCllECoh6MsMPL1+VX+Nm57sWnRrFpAUCXInAi6NT6gNFGA+EHuE6i8yNk/FLSqqwAhSoSrw8txNVlGFnAW2eLLw09n0iHaBbo2Q8mXVJNUZVHPsyOrpn5RipeW6a6X4bQCAhkfoKCaDFTOfmROoVUKbelw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mz1MrXcL; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5dbf5fb2c39so586147a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739788604; x=1740393404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/PEWwDl9MB7g9G1AMh/oGEgtW4u5T+aVOkhOdQ40XU=;
        b=Mz1MrXcLPjiPCNcIYWdn/LvHvX/2Y+rNc9XD6k+xc29gLNdnU9hmpqLZPaDQ8QXpvI
         ITdW1tj06LuO+hVBWO6Eb6L1F7kFEJVqY+KXBNv3M3hCBAy7C8XDe+d5dQFlVSTDGQC+
         P85q4IjM0XYwlwfrMDAthc0k3Qyn5lfiJ2eUajLGttzAf5es5Hg8sXUEWiAntpp8hYbg
         7PTN8xSAV2nQQCQWpFz2RKeWqVn856m68tFDwlRtjmhqvwDXJ6WlI3c2YU/dnVabKJPz
         1wjbh3Y8+VRz7viP+1x5oW4az7TTc/CVrloRnPyVymkDlbv4TNs0xJ0NmLXZdqaFZecB
         rCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739788604; x=1740393404;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/PEWwDl9MB7g9G1AMh/oGEgtW4u5T+aVOkhOdQ40XU=;
        b=Iw1bAbCkKHR6W9qEsUT/t65SWwRzlCvOkjj2cH4P3JFQNRZcBtc8gm4O9hQgZCq4w9
         2HCvAwdKUcsmzlHvZhwVgBj4MKINQDjQT8pxHrPoYIKwju6WtDWL1nl8SRpyn+b1oCgm
         mfQsVR9t0Mj7WmonkKh/6xsxaU3lU8ylPT+qgwbsTtkhLa/qtcO0ioPBVynsOgQ2HJhM
         m/crwgafcKbfoWne2zwtMHikcelqjs/D3m0axWaSz5QpZIRFnGSfvGRleU01/2hKQIZK
         SWomt64EFE6yc/75lXjaoVcWX1iHZhgSfpvYfaDqzjOi0XJLQiyBt0fSyHLvr3Wi28RD
         mRtw==
X-Forwarded-Encrypted: i=1; AJvYcCVgnmSUMcAm/A0oi1ltNoNlmZNWYdSFMl7OzdNktd6ihPmNt0Q92A3PELc+ojtef40oG2pRgnU2g4QXSik=@vger.kernel.org
X-Gm-Message-State: AOJu0YymsS1jfKbsk036oTaodnvrD+iFKrPpdBGWNya5TXqmvk3ZybhF
	hhVwtgWNTt6SB2xmcCdoN/7ur4w5pbwCbLtE4kcTBYXTgGUvKui97VfIKCude+8=
X-Gm-Gg: ASbGncu/dkT0ANO8tgaIbRTuRnw2V0HqHm0okn4B3pB1PV1EgT7hu+jkUP7s1DmzIV4
	QwG6B7sC0H4CqB9nfPGqaxW2MhgyL4zSIVmWEgxSqxHqHOb24Cc3dI7Mh8dO5Y3lDlRt4YvlE6E
	Cnv6wbxchbqZk2u9aciY1rozlD02yipoMftMWhwHjFwPWhdJDvIEZFsdh7JV65u30YSmWRZk5Gr
	6+Qvm7DfNAj0dBZT0Gt69YgGdmyrPnhGVwgiQYCIzQIm6/IAFOaedJIb6ylqP1RTzkbABJgqldJ
	TITKGltLJen0jab2Dr+AZv+WSMzExhs=
X-Google-Smtp-Source: AGHT+IGmMJF4ViTaqLqJAPAEqki9C4gvYmwTm6OvO86oLDWZLtgcjDXJ1cUh7+WEg2+muDpD9D2hyg==
X-Received: by 2002:a17:907:94d6:b0:ab7:c28f:de59 with SMTP id a640c23a62f3a-abb70e5eca0mr311989366b.13.1739788603832;
        Mon, 17 Feb 2025 02:36:43 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb961594absm230383566b.111.2025.02.17.02.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:36:42 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: alim.akhtar@samsung.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, Devang Tailor <dev.tailor@samsung.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 faraz.ata@samsung.com
In-Reply-To: <20250108055012.1938530-1-dev.tailor@samsung.com>
References: <CGME20250108054224epcas5p399f3d734f8d9f82e5ae75d183d1a5344@epcas5p3.samsung.com>
 <20250108055012.1938530-1-dev.tailor@samsung.com>
Subject: Re: [PATCH v2] arm64: dts: add cpu cache information to
 ExynosAuto-v920
Message-Id: <173978860144.144850.3570517854379450471.b4-ty@linaro.org>
Date: Mon, 17 Feb 2025 11:36:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 08 Jan 2025 11:20:12 +0530, Devang Tailor wrote:
> Add CPU caches information to its dt nodes so that the same is
> available to userspace via sysfs. This SoC has 64/64 KB I/D cache and
> 256KB of L2 cache for each core, 2 MB of shared L3 cache for each quad
> cpu cluster and 1 MB of shared L3 cache for the dual cpu cluster.
> 
> 

Applied, thanks!

[1/1] arm64: dts: add cpu cache information to ExynosAuto-v920
      https://git.kernel.org/krzk/linux/c/bbfc70ca7fd26ee3e7eb16872cf7b1f1be5907e3

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


