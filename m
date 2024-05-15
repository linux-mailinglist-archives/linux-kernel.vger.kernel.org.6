Return-Path: <linux-kernel+bounces-179608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0429B8C6219
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CC5D1F225C3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BCC481DF;
	Wed, 15 May 2024 07:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YeHTprxI"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F154654B
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 07:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715759411; cv=none; b=MO9QUEQCh9A4LdgVbHcQFyI08iXxeEcEShkrni8TVddxJT8+xg4aKChNET4TR6gi3Ab57Obs2wh23EvXMVCPMyMv/yN3R85KzQcx1V+k+EeE+LCaAT4lJwaWNLo7uTovR6GsEiUe2B7h8yyL1kr8iiBWNIIGeK7Ca5TZ3a7ObFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715759411; c=relaxed/simple;
	bh=LoG+7gtU1o+7XCSOkjSuVQBBEuxkH1SzsEnGyxuBS14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tO/b3Qz0BZgqztXr/T05xA8hBsOTHHoc6opfl3/w18PHPzeoUdbYvlDZYP0OHqSRxbT14T7XxMzFS8k6nGRaBcxtSWwA7oplQ5xExAmEpxRSHM8lWmtqCAr2/kDXDwMZ4klkpLR/GyrPfMZ4FJ0BAxORH1yXzsfwnGhYEbxuMvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YeHTprxI; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42017f8de7aso19258735e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 00:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715759408; x=1716364208; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2luu+TEKGzGGESWKjsQ/mAq5vIhVWQJ0g42DRjIbMDs=;
        b=YeHTprxIS/XNGwwPGNwBIs9B/yQ3IhS9vR/Dej9YdzzbaNBrVxK3+BdmVMFF5Dfdqg
         sOkSunh+8M4cB4X7RyxWwysdo0TP2b8D0Ug1bSLRo4QgMTFOC6BNRWJBFeccGAaT1xCo
         IjW87YZ02WyIHDXevVAslAzNO1h5epm+kGQLbx3xx413k4e3F+2sMOBO+blrHV32Bvm7
         frRRnRcPsT2hWfzW0u2gTEoQ1BNa/X6wGgna/D9VRYHGfUQDmOd/Hd2KufA6bGvHdQ0U
         C2JpMC5F23p+F347nCJUgNl5k7nQqpbO9rqwlDf/pOoUrYoMP4bkhokO3KyoQwH9+PyP
         pRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715759408; x=1716364208;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2luu+TEKGzGGESWKjsQ/mAq5vIhVWQJ0g42DRjIbMDs=;
        b=TwMcF6honvBBM3BzKHN1T2EqyrXWXDp1BCQMfud/IS8lsEGiacTWP3WTD5hsX58D/7
         vnL5CK8nQQtMFW2aQjLSE7ohUkSoewb5vaLLJlQl3+WRjNSlu4AFhARn7dlaCznW/ucc
         iN2c/CVCsAiXxZrEIYLr5Doxv5m7Z4JRLDX7GDA2+YANi7cnLvLr9Tw/q9ww/xj9drTI
         2Lxh4BW2b+qsYjJjx4k309FR/7h+4e0Bq4kON6msIFmH8M7Ms1TSUZRE/IGc7soVnjKz
         howe26t1jJb3ktOD21HG7bDVRVwSlNd3u5qQuwMQkeOgJdaPisi36Ylu1OKPRKQXi5i2
         2qdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9mzvV/bEUTaIN0SVF9xw/AwZf5mJISvl3f1lOq7gtxFVKZXV4QS1re5J0MkZNXmS3ygXH/wnlVplOldLToHyrdAokLP0UtAfRcxB4
X-Gm-Message-State: AOJu0YyvE8XFXSsKrHCkJ2TZ2j9+84wKbuGiv0HpIgESU4dVGU1kCYlU
	PT/KOHDhu62zNh6VChnQ06R8uDbQMY536jNkzXuFXAnERtXwFOMRBqmMfFTdwA==
X-Google-Smtp-Source: AGHT+IEwnw88k+dpNWTBc/h+G+M5vpa6Q0JqTHL3W0/n2a9dKdx0i4MEuejJLaApdV2aAiJ/HxYQGg==
X-Received: by 2002:a05:600c:450e:b0:418:dbad:c57d with SMTP id 5b1f17b1804b1-41feac5ba78mr111020505e9.28.1715759407711;
        Wed, 15 May 2024 00:50:07 -0700 (PDT)
Received: from thinkpad ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42011d91edfsm129656185e9.44.2024.05.15.00.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:50:07 -0700 (PDT)
Date: Wed, 15 May 2024 09:50:05 +0200
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Conor Dooley <conor@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
	linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: ufs: qcom: Use 'ufshc' as the node name
 for UFS controller nodes
Message-ID: <20240515075005.GC2445@thinkpad>
References: <20240514-ufs-nodename-fix-v1-0-4c55483ac401@linaro.org>
 <20240514-ufs-nodename-fix-v1-1-4c55483ac401@linaro.org>
 <20240514-buggy-sighing-1573000e3f52@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240514-buggy-sighing-1573000e3f52@spud>

On Tue, May 14, 2024 at 07:50:15PM +0100, Conor Dooley wrote:
> On Tue, May 14, 2024 at 03:08:40PM +0200, Manivannan Sadhasivam wrote:
> > Devicetree binding has documented the node name for UFS controllers as
> > 'ufshc'. So let's use it instead of 'ufs' which is for the UFS devices.
> 
> Can you point out where that's been documented?

Typo here. s/Devicetree binding/Devicetree spec

https://github.com/devicetree-org/devicetree-specification/blob/main/source/chapter2-devicetree-basics.rst#generic-names-recommendation

- Mani

> Thanks,
> Conor.
> 
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> > index 10c146424baa..37112e17e474 100644
> > --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> > +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> > @@ -273,7 +273,7 @@ examples:
> >          #address-cells = <2>;
> >          #size-cells = <2>;
> >  
> > -        ufs@1d84000 {
> > +        ufshc@1d84000 {
> >              compatible = "qcom,sm8450-ufshc", "qcom,ufshc",
> >                           "jedec,ufs-2.0";
> >              reg = <0 0x01d84000 0 0x3000>;
> > 
> > -- 
> > 2.25.1
> > 



-- 
மணிவண்ணன் சதாசிவம்

