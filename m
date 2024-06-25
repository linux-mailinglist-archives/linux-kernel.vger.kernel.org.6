Return-Path: <linux-kernel+bounces-228426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E00915FC4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D10491F22442
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D4D1465BF;
	Tue, 25 Jun 2024 07:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vXmifm8q"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1F91465B3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719299638; cv=none; b=fKz0oxbPlb/32WxOmjwmCPXZ5fO1l1hlGId1B7TDUQ5DICntmB/zXF3C3/+Jtek1PwPOfLMbmh9OyyGhMepTsaiYpGjMvE5Sq6aeYXZRBzswzU2k5bGg3fZ623JTL534RgEMojpDEqpjuDgYHUTfpjB0fzjpPdHLAbJ4Qvi1C4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719299638; c=relaxed/simple;
	bh=M0PusBwUOnvIKi4gdlLdWjip9P0B6wyISd2JaNhue0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxSEcYkBZ8MTv61HNvjbCH/4uNvqje2Otlk4mwzSpP7EzuX/XOy/I2iy2D5W/DRVHK4IGDJWowsc9/uDCVWKHBTTSnZT1Y7S3ejmNhWsn2qphM4djxhRzYvYKYGKEbGubI4eAa1iPUXHJFeoiaI/VqLLpDv7YKDsvLM41onBfR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vXmifm8q; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52cd80e55efso6158666e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 00:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719299635; x=1719904435; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dzKPriaP/94IulqToxJJrPFAwt2XeR1A21mNIKltOqQ=;
        b=vXmifm8q/8E5agcvZoJRFXS/zmOUa5QSFcvCZpOm3ZkFXx2PCkHMiAyn2BFChQP5Pu
         BKSM3cUytxBEtk0/eMNWWvh20Yp8vEEBqVbXiAW2DZNTyneXlG5PBoUDZS6fdfUqylkR
         aUwnPjqLNcPaN9Sva7E5zEpbGaoJTTXspyhdNedhwpjnE0Ag7i76kvLoP+7OYsU04IgA
         qP9eaIYz0MslDR4eQhHs+Jmlg4TyBNm52LPYVyFBu+Eo2x1B9VU/yCsFIg1P5zCELiIC
         eEK9ocgXWDclrGO/QAu1biEYJ0Fe3q+MFa8y8tEVlctxqzD59LFXGICjn5vOZfujkMr0
         zHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719299635; x=1719904435;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dzKPriaP/94IulqToxJJrPFAwt2XeR1A21mNIKltOqQ=;
        b=Bhq+t/JpoYk/0wKCUk5J0fAOVHh/I/PP7/UI42R+wFMte6pxybVo8a583VZBEuRbte
         t6BtWlR6xSKYX74fCPB7MGq85DY+dt2y51TmbnCyXvE0Vauv3x8wCjGChvRQ6/OFyHnb
         I6e73w8meqg1kp9hNHBqhDoGY51Lcyk3tny6zMjFPv2SkBvaaijCmRaIlU0HZ1YW4ZDh
         Mw7Wk3+Ss5lggpNqOQRnbkNw4q1ppasBeIP2oRlglIgw7s3xcYkDWniz1ypvTScdMGQL
         Bt0OKRyTjSl1s/f7y2WkA7Mt5F8X0kcdBU1YPQzQeXkmlffDv0H87tfxOGGaSR3HBXHc
         SNuA==
X-Forwarded-Encrypted: i=1; AJvYcCWeOUdeVIYL1Zol3eTpVxMjk56rUERJDzVteW50veECPaIqT4HSs9Oqngqw+SO0EjIz/xRd6q4+QXpVZvgnWw6TxAfEdBEXUZ10AbS3
X-Gm-Message-State: AOJu0YwkOPQJ9GYHhvXecaXTZgprA4PRjEKaNyQGkUwrEvbCzt1muCV8
	sBgFilBb/h4rISf5/ShkHaRr9yt/AFjheXOrH/rUWGFZnIXhpxMaTLtY6I7H7zA=
X-Google-Smtp-Source: AGHT+IG64J5RDl5yaNGvIky6EGoSsPTbRPhzUi9sDW1lxe4MxCOfYS/ESUmKFf0+XtJh628T1VqfDg==
X-Received: by 2002:a05:6512:308c:b0:52c:c9e4:3291 with SMTP id 2adb3069b0e04-52ce185ce9amr6238633e87.60.1719299634940;
        Tue, 25 Jun 2024 00:13:54 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cdeafa562sm820431e87.154.2024.06.25.00.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:13:54 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:13:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Gokul Sriram P <quic_gokulsri@quicinc.com>, sboyd@kernel.org, 
	andersson@kernel.org, bjorn.andersson@linaro.org, david.brown@linaro.org, 
	devicetree@vger.kernel.org, jassisinghbrar@gmail.com, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	mark.rutland@arm.com, mturquette@baylibre.com, ohad@wizery.com, robh@kernel.org, 
	sricharan@codeaurora.org, gokulsri@codeaurora.org
Subject: Re: [PATCH v9 4/8] remoteproc: qcom: Add ssr subdevice identifier
Message-ID: <76mrajqeteocstj2akjtyk7rhfnqvksqw3fqsntlm6n3mqqaff@z343xmmunnzj>
References: <20240621114659.2958170-1-quic_gokulsri@quicinc.com>
 <20240621114659.2958170-5-quic_gokulsri@quicinc.com>
 <d7923435-ba13-4aad-b3f1-67e3469ec7fc@kernel.org>
 <8adae0a7-d496-4c9f-ab0c-f162c06e90c4@quicinc.com>
 <87353911-b108-4b87-aa40-862acfc95aca@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87353911-b108-4b87-aa40-862acfc95aca@kernel.org>

On Tue, Jun 25, 2024 at 09:04:17AM GMT, Krzysztof Kozlowski wrote:
> On 25/06/2024 08:28, Gokul Sriram P wrote:
> > 
> > On 6/21/2024 8:40 PM, Krzysztof Kozlowski wrote:
> >> On 21/06/2024 13:46, Gokul Sriram Palanisamy wrote:
> >>> Add name for ssr subdevice on IPQ8074 SoC.
> >> Why?
> >  � Oops! Missed the change. Will add and update.
> >>> Signed-off-by: Nikhil Prakash V<quic_nprakash@quicinc.com>
> >>> Signed-off-by: Sricharan R<quic_srichara@quicinc.com>
> >>> Signed-off-by: Gokul Sriram Palanisamy<quic_gokulsri@quicinc.com>
> >> Three people developed that single line?
> >>
> >> Something is really odd with your DCO chain.
> >  �The change was originally authored by Nikhil and reviewed by 
> > Sricharan. I'm just submitting the change to upstream so retained their 
> > names.
> >>
> 
> Then your DCO chain is not correct. Please carefully read submitting
> patches, especially documents about authorship, DCO, reviewed tags.

Also there should be From: Nikhil header before the patch.

-- 
With best wishes
Dmitry

