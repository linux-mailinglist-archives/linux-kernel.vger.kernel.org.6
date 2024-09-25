Return-Path: <linux-kernel+bounces-339644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DC698685D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 23:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7856FB2356B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 21:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B862156F23;
	Wed, 25 Sep 2024 21:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vpHxw83B"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312EA1411E0
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 21:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727299905; cv=none; b=WNklOXH8548HvgCJEkJwQJ/EnuLncGKBpCNg7zXyYIL5azXt+YVOU5Cl+K9iNgvEposo1QSrcDBDOvhZB2irsjPpkq37V9cRxcH9QYrGwI2liuD/3sgle1IibMVuEfcmRQmnIBCDT5ZHZJjI5eCkUpwm0vCDLyzdgwf0XVO45/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727299905; c=relaxed/simple;
	bh=q1hnfW/UYENj/VV96bgSolK/g/2vdQSz2wVyhQteCPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sb7AJoe0k60T2qv3giRnnzlhDtLk79+x8VtmeefzM6a6tw0EJVwGZcnmHG6PKaoSUyrqq1+pt/iBZTEYfFyFQGisNhgqwFbxvS00B/b4KX8Dr2LMGeOU+WhCLqPahX/kcFgm4bAGv73h+7JVynEiLggDSAXMdJu09b0+SGebQAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vpHxw83B; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5365c060f47so366977e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727299902; x=1727904702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g2gRWXk6um8ssZG0dTYz3h8O6sPux+vtNyTeziNQM+4=;
        b=vpHxw83BEcxXUiXAHcwannMowZ5Cp/Zm0//e9txywTNF+VvbYNu8F1jTKNov+mH/Ns
         5hHQflIjhKUl5G/IPTQ1QlYBoyLU+pl1Qt4Mx572kqq6ImpdtT9nvn7R1iEEZdIHMOxB
         SzftUfPVRDvh/dh4iGooNg+6fQdfSwKqC2XOKsnIbMuGDmC0MWWgUrNTgHl0q+YB/QjH
         E6TDD2eqeFktH3aKA7aTMaEBEEEm2Bnp4OTeVI5cdWgWqIyT1MrP4YYAq9UO8Q2phjMl
         Cl+YWdmPf1FQZtaE2nhr2VGc1ZXKepGxtu0tMXMKlhUgIh3yLSandXdoVQjX1kgBeB6r
         TSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727299902; x=1727904702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2gRWXk6um8ssZG0dTYz3h8O6sPux+vtNyTeziNQM+4=;
        b=OO6P2tX8v+X46F8ozAvBfL3KzL6J9NQBb5o/yWHF9sRZHiAsOT0Y46VjbmVP//vlGK
         retMXFEzWTha3NlnRxTM7cUsBPGt23HQvDYy7O203PNFx2NftmsmPM6M5QJhcHin+dA4
         Xk5nCzexJpxm0x1159ESDl+f6wrTDlvx05ZVFKzVjns484FJ8VogMyrA0oCuDy17e8hJ
         WUbMaKER6h9TRU/ty3KbtgIaGnuSPPPd+IxP3W5jdtkpqhTzp+YvRn48TpykqfkK6vLG
         5VxZdHirWQxhFs1AvE6y2HU4ZW4pWLFGEC1xF0fum3GMQVgiDT2oLVcqO+E6i5tRU1cC
         9mig==
X-Forwarded-Encrypted: i=1; AJvYcCWZ1SyYBIyjlDPVOd4VT5pKAt7AexJj3/tI1GDkuGC/w0AkSKh6wNvu9V7mVlq9b3i6KjpMBeQscMLfjSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYokftAumW9PLX2bSbh+8elttFHVPRxuUMm5mjU7BMnRyNYHUB
	tUxh9ORa0zHpqtwdEeMzpgjeuFOIQJJ2XNgRJA8DWiwcp9/3lKJmd534PuO11vI=
X-Google-Smtp-Source: AGHT+IGRtxkMp3x13jBkNmqIgOxnVIpZ0WovylKJsjpSzFGlmQuJwR6WMxOTZoa6v7kxp+tzwKvB6Q==
X-Received: by 2002:a05:6512:3a8f:b0:536:536f:c663 with SMTP id 2adb3069b0e04-538704986fcmr2778800e87.22.1727299902152;
        Wed, 25 Sep 2024 14:31:42 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a86408dasm623111e87.144.2024.09.25.14.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 14:31:41 -0700 (PDT)
Date: Thu, 26 Sep 2024 00:31:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	ulf.hansson@linaro.org, linus.walleij@linaro.org, catalin.marinas@arm.com, 
	p.zabel@pengutronix.de, geert+renesas@glider.be, neil.armstrong@linaro.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, quic_varada@quicinc.com
Subject: Re: [PATCH 8/8] arm64: defconfig: Enable IPQ5424 SoC base configs
Message-ID: <h6ajhgv5rqabxupove4ge4253ywzbjyxoqq75c7ojmauudd3z5@hhhkbbzfmved>
References: <20240913121250.2995351-1-quic_srichara@quicinc.com>
 <20240913121250.2995351-9-quic_srichara@quicinc.com>
 <4dxqbm4uuuuht5db7kt6faz2pdeodn224hd34np322divs22ba@dzmjveze3b4f>
 <2a16d5a2-17a5-4988-8a25-34ac10ff3d08@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a16d5a2-17a5-4988-8a25-34ac10ff3d08@quicinc.com>

On Thu, Sep 26, 2024 at 12:34:56AM GMT, Sricharan Ramabadhran wrote:
> 
> 
> On 9/13/2024 6:23 PM, Dmitry Baryshkov wrote:
> > On Fri, Sep 13, 2024 at 05:42:50PM GMT, Sricharan R wrote:
> > > From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> > > 
> > > Enable the clock and pinctrl configs for Qualcomm IPQ5332 SoC
> > 
> > Please name the device rather than the platform. The defconfig affects
> > all users, so it should be justified.
> > 
> Sorry, to understand correctly, you mean to use the board name here ?

Yes, the board which is generally accessible, if possible. You are
increasing kernel size for everybody using defconfig, so at least it
should be obvious, who is benefiting from that.

> 
> > > 
> > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> > 
> > Usual comment.
> ok, will fix.
> 
> Regards,
>  Sricharan

-- 
With best wishes
Dmitry

