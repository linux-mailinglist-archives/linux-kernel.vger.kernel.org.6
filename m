Return-Path: <linux-kernel+bounces-318002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB1A96E6F4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 02:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E730D1F23BF9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31E517C77;
	Fri,  6 Sep 2024 00:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wYldyxlu"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B77171CD
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 00:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725583753; cv=none; b=kXTEjs2511JJ8WAttKNoyqjtlh53UDHY4jFdq0mbbdvooTNAyRDUXpr46wKj3mjlm2hKCJ8minZpgPaad3H2ujwXOr4bM/f9hauUhQRRN6TtFL/rxSiKXeKsc4O/0o82PZKhdvyJrKX3j22OiVzHWzjr5ostYay8Hu5wkpURhls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725583753; c=relaxed/simple;
	bh=8b8IYCkGQC/U+G9zPL3oCOJFnnNaMUYOlSPyqHtd5Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sogG7RZIqjZzNwYMoyFjCLM6hHMlWfMYZo8NWnAD4cGWnaPbo+708RMrsjwoU86uYIUiry9Z5efiLWDd5GcKdcDsyIAihjE5Q8+iqwM5UTBFpVUuikL3ryGcW6/U0HKKWqRW1lZi4e1eLvbbv+W4as8WsDh6pmuGaxdoPOeo20Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wYldyxlu; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f74b6e1810so11261061fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 17:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725583750; x=1726188550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AmfjfcKndugulugA7EAwTHkPQhPDlb23XTWYgaDDGF0=;
        b=wYldyxluIZz4Q6tZBlBErG6iuXCZaFxgOROXa4QgeP6yEFWFmg5xPhSV2qCSDJdirI
         FltMs3/WwFNtW4qPSPFm8OZ3/Ot383LRbogmCDEoJRhGeUUxOrZuthuhsG1G4k9jJYjT
         XHoYZ4WPMR+3eI7clM3GoZBUHdbhcCu5svO9hWAadU1JEx3tE1bmcKRvjv0T/B1S0Xby
         I4T8iV9KkfbbPOCTZsjoTDcL1ao64yNYELW0dHSUdFAYZJa8SLoDcb0HLkaWbKFONj1K
         JdXvv0YmBHyKDC7R0twPPIFgizXffb5t+QPlR/IJclUU1sm4sZCeEayCzTdmbzYwbAPd
         NPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725583750; x=1726188550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmfjfcKndugulugA7EAwTHkPQhPDlb23XTWYgaDDGF0=;
        b=vuA6Ul6agtf0hGF5G2u6D1pERQXV8IM6RMRr14Mf6uVu7+xuTTsXYbxdm+dkiDBfBX
         JKSezzjrRBvDuCQHG0miYOTt7PiLSE5QkP09DruovJ+fRDLJxk+fue3DkRPXwO1Cy2+h
         fVdiHB3ImfFuEFGeROkiAdPPbawCqko1h3+Ndbdw3Z6ccoDJh3Zf6WOwiMe+GGJm7mNM
         EI4slYJHXlpuYNUVnrcpubnKSHPuGu1YrXKGPHNb0HjbNcKP3Gc11N3nOkKGUVgVnRdI
         rYycl4584If807UoqghaNVXRXqhMXoBANBEpqA+kEDBVN1NlHK0EjS3Abjbqzb1n9el6
         f22Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQjyeOXK0EhfCOCy8ImrUJG0SJEoZxqFbzrw76BbfSbBB8a1rfq+IjoCC6hq9jQjYFcYXo1jSxVhLinO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJCuJ/7YWRYtlOvEoWcrnr5weACtjnKvR2Crb71YKLhoS9Ol8N
	HTf17yLmA0kDsQ6OKZv9M7TkFAmPfPjAHqOgOxnv2qswuNiWe0Nn2HrpXdg7+DM=
X-Google-Smtp-Source: AGHT+IHIffC63U9mjEj2zVgbFJlFMy6oAWzMOiRekHkT67HeuZh2MpHA/BdRyQn6y5VmaPvlk2BXQg==
X-Received: by 2002:a05:6512:3ba1:b0:530:ae4a:58d0 with SMTP id 2adb3069b0e04-536587a40c6mr385814e87.8.1725583748976;
        Thu, 05 Sep 2024 17:49:08 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53568959814sm544349e87.251.2024.09.05.17.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 17:49:08 -0700 (PDT)
Date: Fri, 6 Sep 2024 03:49:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>, ath11k@lists.infradead.org
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>, linux-arm-msm@vger.kernel.org, 
	linux-media@vger.kernel.org, agross@kernel.org, andersson@kernel.org, 
	linux-kernel@vger.kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org, 
	quic_vgarodia@quicinc.com, stanimir.k.varbanov@gmail.com, Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sa8775p-ride: add WiFi/BT nodes
Message-ID: <6to5p2dgsu6pvebkmkliojv5kfhnairigd46tmbraimxij7ddu@h6ziv7uwjeeq>
References: <20240905064817.3885953-1-quic_miaoqing@quicinc.com>
 <d6mt6i4a6xa3juvn4gzytuhsot2kx7dn4wmm3kmgwywfj2hcau@leecyxx36wql>
 <87a1a50f-f485-4a4f-91fc-34fa19312519@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a1a50f-f485-4a4f-91fc-34fa19312519@quicinc.com>

On Fri, Sep 06, 2024 at 08:19:28AM GMT, Miaoqing Pan wrote:
> 
> 
> On 9/5/2024 8:49 PM, Dmitry Baryshkov wrote:
> > On Thu, Sep 05, 2024 at 02:48:17PM GMT, Miaoqing Pan wrote:
> > > Add a node for the PMU module of the WCN6855 present on the sa8775p-ride
> > > board. Assign its LDO power outputs to the existing WiFi/Bluetooth module.
> > > 
> > > Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi | 119 +++++++++++++++++++++
> > >   arch/arm64/boot/dts/qcom/sa8775p.dtsi      |   2 +-
> > >   2 files changed, 120 insertions(+), 1 deletion(-)
> > > 
> > > @@ -837,3 +939,20 @@ &usb_2_hsphy {
> > >   &xo_board_clk {
> > >   	clock-frequency = <38400000>;
> > >   };
> > > +
> > > +&pcieport0 {
> > > +	wifi@0 {
> > > +		compatible = "pci17cb,1101";
> > > +		reg = <0x10000 0x0 0x0 0x0 0x0>;
> > > +
> > > +		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
> > > +		vddaon-supply = <&vreg_pmu_aon_0p59>;
> > > +		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
> > > +		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
> > > +		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
> > > +		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
> > > +		vddrfa1p7-supply = <&vreg_pmu_rfa_1p7>;
> > > +		vddpcie0p9-supply = <&vreg_pmu_pcie_0p9>;
> > > +		vddpcie1p8-supply = <&vreg_pmu_pcie_1p8>;
> > 
> > Please add
> > 
> > qcom,ath11k-calibration-variant = "name";
> 
> No need, here the WiFi node is for 'drivers/pci/pwrctl', not ath11k driver.

NAK, nodes describe hardware, not drivers. And we have had enough issues
with the WCN wifi having collisions on the board-id / chip-id / etc.

Maybe we should make calibration-data required for the DT-based systems?
Kalle, WDYT?

-- 
With best wishes
Dmitry

