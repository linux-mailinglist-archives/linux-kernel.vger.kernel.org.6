Return-Path: <linux-kernel+bounces-309737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E84966FE3
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 08:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91131F22841
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 06:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C3C16C852;
	Sat, 31 Aug 2024 06:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ipA2EL28"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D613F16BE01
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 06:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725087418; cv=none; b=lopKXMBdT0910pV6mhKCIKIu1VCgYBujRdu2AOU3HYWtvnOnH7AyjhPCDbPIA79jhlbDY7+8rL+GXva2p0Q+fNRSc5t03AwzI3wws8mTmAESG9Dr0L9+LXuSaNOL6wB94BPph+MgELIWe9b1g7otubVgHE+fm6zY8qxYzVALwGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725087418; c=relaxed/simple;
	bh=8+xb/c5q8Te81bywgznH7epprrs+vus2sJDb/zrAqlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DmG1T2N9h4TaMZWjujoXs5GxIagH9fEsdH7cmgEgkzB6nEWxz8To0dQ6Hkux3OaRbDk0AtE5pG5dIOAf5yrs7cmsbXtWXOFSnGah4d31425dyX3ZHEQz78L0hEi2KpTrmx9j5E42LXiD44pN2B2FIWFYaaAfoylGh0b15idk37A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ipA2EL28; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e13e11b23faso2584874276.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 23:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725087416; x=1725692216; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=35/Cpco2p2doBWBoqkU/4WZL7A9fRuozoOMEP5DhBlM=;
        b=ipA2EL28NfkHMF7Bu1AE1NRHUWJcX3Jg1VVzfgrd6xD/g/xekeEJULFMdm5ZNaVbnw
         spp67cqXt7EZZrUaj8yk80QL6M5R2lzkRRRtdg4/F5NH2gh/kCu3E2NdOTQwube2J6NI
         cDvDsZa1cemjGvwLj2MOgrk1/kFlE+IJq6LVi5vwqRn0iXio46lFvKKBR+AXTv862xdj
         1/zeYScrc/34ICH/mWL9lEJogDtZ5TjTqG7oWmdzGuLmh2EkE5m39wAB/IFQUJ1ipCVu
         IrkqFE2FuG+/gO7R6IiKnfQCbATqLRq3xLy2pZyk9GzkN/MsMCFmQ5XfAgML4RJfp47N
         trIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725087416; x=1725692216;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=35/Cpco2p2doBWBoqkU/4WZL7A9fRuozoOMEP5DhBlM=;
        b=tjIx5DGhzQ03wNIEtJqNPYNizF/6TAnH7KwlyT761BxL1SiUbsEgo30+z3F5mBS9Bg
         vlt9JhzHgwqIT/om8zbQBtDX3boXRT4Riytd3XHWXVExVD4uJjGzy9od3WzeX7xbyhzN
         XId0RwkIEWPocnn4n4kjtqy7TJ6OcnmH4/a+o2fX7NQuXEATHLfoFY58My+qAJBlHX/T
         TSV9bmCBDgnxriz1aOUJfMHfcrXacHONCJljRB+G9D9cLAUU2mTaWf6WF7eMAk4kozq2
         s5tF8+S3SXOkhkaoBz3CIIcts+ijfNYVxBRszBmBY0/zWhTm7ld7157YUka3cUwZjpei
         kATw==
X-Forwarded-Encrypted: i=1; AJvYcCVU8Ej+MA81v9v6eldW00tJuICU9Xe7agRl7z0nr/82t7HcRtH1AETTm62OJw15ylTTs2OArrU1npVu65o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzp5Gxgz1JTHvWOadcWz+o2gUCp4/wWcctxhdKrCM6/WyTRZcc
	6tEIge01YB99R5WJULl1zJhgzTVUw1/O3C3PUsYH6AppGi4D6C8zvmpgslAfWhwkDP3R/LcFUQJ
	NH3N3+3h+FrL7Adaf9bF0Wl1jzjN6qK0NrqOtyg==
X-Google-Smtp-Source: AGHT+IFWbLWA4IjXvF5bKeQh1lJtnNOkDsN8Sdtsfq95rr64K/eYP6o6HPpIf8dFbQYhHTulhF5MoAz7eON8AeOpAgw=
X-Received: by 2002:a05:690c:d81:b0:6cf:8d6f:2bef with SMTP id
 00721157ae682-6d40eb67be1mr51383017b3.7.1725087415578; Fri, 30 Aug 2024
 23:56:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829082830.56959-1-quic_varada@quicinc.com>
 <20240829082830.56959-4-quic_varada@quicinc.com> <gomm5yozebwfuhmgziajmkflbj6knmbwae4mls5kuwl5ngcbrx@mndpiktfken2>
In-Reply-To: <gomm5yozebwfuhmgziajmkflbj6knmbwae4mls5kuwl5ngcbrx@mndpiktfken2>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 31 Aug 2024 09:56:44 +0300
Message-ID: <CAA8EJpoSZwqw7_UVVXzwOd77Xh6j5LzKus-ZfuL_f5yrc8AYkg@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] dt-bindings: clock: add Qualcomm IPQ5332 NSSCC
 clock and reset definitions
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org, mturquette@baylibre.com, 
	sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	konradybcio@kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	djakov@kernel.org, richardcochran@gmail.com, geert+renesas@glider.be, 
	neil.armstrong@linaro.org, arnd@arndb.de, nfraprado@collabora.com, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	netdev@vger.kernel.org, Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 31 Aug 2024 at 09:11, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Thu, Aug 29, 2024 at 01:58:25PM +0530, Varadarajan Narayanan wrote:
> > From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> >
> > Add NSSCC clock and reset definitions for Qualcomm IPQ5332.
> > Enable interconnect provider ability for use by the ethernet
> > driver.
> >
> > Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> > v5: Marked #power-domain-cells as false
> >     Included #interconnect-cells
>
> Then this might not be GCC-like clock controller or gcc.yaml
> should not include power-domain-cells.

qcom,gcc.yaml already doesn't mark #power-domain-cells as required, so
it should be fine. See qcom,gcc-apq8064.yaml or qcom,gcc-ipq4019.yaml.

-- 
With best wishes
Dmitry

