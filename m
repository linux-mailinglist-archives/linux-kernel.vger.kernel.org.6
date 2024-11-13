Return-Path: <linux-kernel+bounces-408133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BA89C7B0F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4072B33A76
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26677205AC6;
	Wed, 13 Nov 2024 18:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvEgU1c4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6822C13CFBD;
	Wed, 13 Nov 2024 18:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731521502; cv=none; b=kbg2ORf0/A8q4jmC/xR2dI7qM5+rJZtg4OMnA2VJPX2QVlMB5tA+Mf54oTMoX6C+D4MPwFfivCpGQL0h4xH1VLvERtiLYGy/v3UdGvDid2EE6SSNoMcPWx3qI6g4fOfFUiFSAMTFLxCjB9T326agaeEvqkFF2jTbTPnvWH5fw18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731521502; c=relaxed/simple;
	bh=fujGutBZp/9h60ZjqyqAyU+r1u3fFTWP8gNIzYxYXF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+fsr03Ce08v2yQrrXVE2LX0SEvIXGOAbqLeJ8KpEJQsKRn4Exas8EQmWUdHFGVR7Cb5RWjXEovSNtGXPrSrnHMBR/8Vv1+av0oiqyTCvPqOJoMFpScwhP/6Q1mzc9ZNsKGVWQ5boRnnInnM+Xxd85T617ev4Y0rkzXVmRKWGuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvEgU1c4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2694C4CEC3;
	Wed, 13 Nov 2024 18:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731521500;
	bh=fujGutBZp/9h60ZjqyqAyU+r1u3fFTWP8gNIzYxYXF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EvEgU1c4XeLEl4tM1nBnAJKfew+cCYyosddh3FVACqg1LvKag0LOQNC6wrJWurQdN
	 OtqRufZ0Ii3nSM7M/7CTJXf+O3LPP1CUc2ciI2QQ2ELw2TkgUEw530Zbc2ZOWDmeQd
	 nuFgV2I2jxOVN1yad45n2NwOhKG1EmCZvP+oM90uhbqz5dYfVFF5VwdXuqtbA/6/rK
	 mvQsxzwCX3oduGiMERauuj47XlLN4iRjQExcPUCSS3VehlrBRKVjJPjD5xxRzy7IeT
	 X+wPkphC0cymvvG4UNhUJijEnKly14hRP3TXoJh61De8RlmIwOLleWapkVYRE9aq5s
	 BN+YYj3Mi2CoQ==
Date: Wed, 13 Nov 2024 12:11:38 -0600
From: Rob Herring <robh@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>, vkoul@kernel.org,
	kishon@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	gregkh@linuxfoundation.org, andersson@kernel.org,
	konradybcio@kernel.org, dmitry.baryshkov@linaro.org,
	mantas@8devices.com, quic_rohiagar@quicinc.com,
	quic_kriskura@quicinc.com, manivannan.sadhasivam@linaro.org,
	abel.vesa@linaro.org, quic_kbajaj@quicinc.com,
	quic_wcheng@quicinc.com, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: Add USB controller and phy
 nodes for IPQ5424
Message-ID: <20241113181138.GA1011553-robh@kernel.org>
References: <20241113072316.2829050-1-quic_varada@quicinc.com>
 <20241113072316.2829050-7-quic_varada@quicinc.com>
 <ZzSYU61pmFTcPf5_@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzSYU61pmFTcPf5_@hovoldconsulting.com>

On Wed, Nov 13, 2024 at 01:15:15PM +0100, Johan Hovold wrote:
> On Wed, Nov 13, 2024 at 12:53:16PM +0530, Varadarajan Narayanan wrote:
> 
> > --- a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> > +++ b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> > @@ -16,12 +16,71 @@ / {
> >  	aliases {
> >  		serial0 = &uart1;
> >  	};
> > +
> > +	regulator_fixed_3p3: s3300 {
> 
> Fixed regulator nodes should have a "regulator-" prefix in their name.

Specifically, regulator-<voltage> is preferred. So "regulator-3300000"

Not enforced because there are some exceptions.

Rob

