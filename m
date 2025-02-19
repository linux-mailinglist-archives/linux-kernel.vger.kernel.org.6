Return-Path: <linux-kernel+bounces-521284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73274A3BAF5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30572188C2AB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FC91D5AC0;
	Wed, 19 Feb 2025 09:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BpO64UFb"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A431CEAC2
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739959158; cv=none; b=OJegAeKJRYnBFwTaq0INpXVuPX0uWZ3/pslyuwSht735GVHmXlya803SnPbcb4eRPp1TbcyU3G+F/VVl+YtBLiyrYamWI0sbHylKZW/SOCUHRAiwgMaKgP4eszgJglvLISPawTykxTaWsZaepd0H/+KcJ3T2pJEwomLAK6EGpSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739959158; c=relaxed/simple;
	bh=FhaKrLYYFvH6JlBWj6iAfNEu2nFL5Z0xJ5LSfPsqzcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJtGYhS8dQJT8v8OH/oiLISbANDXN19xNXDQkztxirlfc202GdN04yvUpBEBZyBHlyVzbScm4M50PCRIoLv6NgLi1TsfmtGw206ZzZ/FmIXoNanknfBMVVkmRLTyn0fSSwgDW0XIk/xBQdc+usEJO/tgmdt6V2KULVdWAEhRZIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BpO64UFb; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5fc13355a5bso2905713eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 01:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739959155; x=1740563955; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D4ZmBE3k4+dA0yLJE7EIrqUujBLBu3hVMfqxrFcWbfY=;
        b=BpO64UFbnjMRx/6L+nVqHYe3AfCiBG/5l4cnEQnM4+m5xCL36iZhaHtesV0BFFcRZE
         eSe8BnKRU6XwSQn1RGrRP99GXHUFDTrtFctEWeXKrgg+z3OTX63/eyiW6QxdUom9BSbe
         crXNgu7biaetcx+KlOGV9D9REfl0kqBqB+t+f5FbsjtzTt0VBfYr2XSeMeSSEMBknPG1
         WGVrFaDcezkQZcZ04I4APN2LJNiRTM7jbM7xc02VJnD8fExC3JenpQsVRcP2JWEZskbA
         QcGMinX9JXpkibAlP4S4JNM+vM/GlRpKbkqdAIVq2J2S29vo99zjS2AbRkhWkfH9M44f
         4JMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739959155; x=1740563955;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D4ZmBE3k4+dA0yLJE7EIrqUujBLBu3hVMfqxrFcWbfY=;
        b=Ii23wRDQEC1PSUlJWD2ST6D/jM7JOYPHH0vRcUANTQAgb5qcwXR4fw3mafVo27txpE
         UvMGNuQGKoPwcDiUTPYD1Uj6lxxmM896rusXdTjBkdcFSWtvjf+rADfBE69xX2k6bzO/
         55veenUIVDRZ2W96jA1bMs/wY2fmDpOxxrjH8yJFN4LAHYI7sRsvsR6zFSw9iIgVYcnL
         jAd1Vrenn/ZWFbuKy4T0gC1ziCIUmPGHUHOX2J9Qxg5cLJ/XDu23PlfIWL1jLqaPU+GU
         IsKutLY2dQEpxZ8AxFcdgBp3TGu1+aCj2ucObpz/8pjjmjHN0+Wx7SIozH4thZ3CipzJ
         zoPw==
X-Forwarded-Encrypted: i=1; AJvYcCUxSXGW/KUgSx9AYZsaMO7J7SH8DPyvaBTA/Y4jd7akn9NWI7h03u2XdE0LZTNbHj6slcpiz/JgVgm5TvM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+KLuHNrAxyl/B7H9GO0Ky4464TFCQ+vKqtt875cwb1QVd8UqQ
	oP6v9ATXyjkfCanvL1a7Z4ckvGJ8BEy82IurrVTMJ4nDEVLOo+c7ZMs5hRMsxwQvkTZVkcptlE4
	QRjqFLf8VMzZnp+LdVeqpTIRcFubbwG3GvzTUDg==
X-Gm-Gg: ASbGncuVVQma8wWu89o79Krnlx5NZPALfX+Emas6BwNb+KSwqLdIyxxWDQH+0reqd22
	A0CRWTx1HJoi69yfN/LudOuEOyyL3Vsa1BoYSLcUrHBbSdyrIMgrx/PG/m3oRMExth5tEGBao+3
	k=
X-Google-Smtp-Source: AGHT+IFxGDj5iXV1hVx+bDjQHTZUVRM73dPTifEk8a7TEg/x0Tcm1arIcMDlwwFyHGQfiRO96zZV23RSVt9oTTe+p/Y=
X-Received: by 2002:a4a:ee1a:0:b0:5fc:dd26:a087 with SMTP id
 006d021491bc7-5fcdd26a30cmr8214839eaf.5.1739959154922; Wed, 19 Feb 2025
 01:59:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219085726.70824-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250219085726.70824-1-krzysztof.kozlowski@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 19 Feb 2025 09:59:02 +0000
X-Gm-Features: AWEUYZny13PhyIgLlHGS6LqU655W9VTKBSuguA9ge6dMXGv73qgyazJplG-xt5w
Message-ID: <CADrjBPrg4eV+fT9XsuMTwG3WprPq5Qqre9+XTwYURCp_==6diw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: exynos: gs101: Change labels to lower-case
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Feb 2025 at 08:57, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> DTS coding style expects labels to be lowercase.  No functional impact.
> Verified with comparing decompiled DTB (dtx_diff and fdtdump+diff).
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

