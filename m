Return-Path: <linux-kernel+bounces-252288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C949310FC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA561F22B5D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328F31862B2;
	Mon, 15 Jul 2024 09:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XTrmNhqt"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29E113B59B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 09:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721034927; cv=none; b=OYTB28z9GqdDIRs20D+EA0+n5khQfMZ2JDl/ZoVGb9bmim/UAwmNi0jo6RaqWtH5lIrFzZew8zrPTzKNhKdko2JEMmWQAvldi2QXJZMEBrQ8SkOj24hIjJVa6fNztbg4U76mXGcfTIiZ19vhfIkP/iXDf8vvrKdFBhXG6F/jtws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721034927; c=relaxed/simple;
	bh=54CaZIk+oyVZNemcEVgJd0qRF1wknBrK+U8TDQZbLdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pI93hF3MtBci81P/vpn/7Rsi44TcsLXaTqEUcRFfXRH0rHqATXmZR9jWSBkc9Wsfb8NNRSCyTtP6kZTdQp6C3PezkVsT2KzSjLum4BK4dVRIfDxIT++Nwpdu6ZC/828SlbiP3Ux3oTAhlxpVXK99YRrJI1dIqZRvULPmrO1niV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XTrmNhqt; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52ea1a69624so4162012e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 02:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721034924; x=1721639724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2m3lT+8e+fZ61YPDTuybNJRn/xGhJoX2Iin5K3yz8Os=;
        b=XTrmNhqtv8JbycqN4GFEqc5HDkLW4Abn0d/MjDlDfY1IFNLniVMKsDMvvbX1jNKIx5
         0+BboSI+7d5G3VFzIEdiEFR+WB9+Ck5IXuldI1wP7o5rqrk5/w2RHvq95ng9pOmas+Bf
         gKjdpxXyfR5c7JNytGlKFsjC+pPOW3s+5fVbDOikohUF0OEnXccFTuEXvs/npKzedswQ
         xMcThA76ekTLcnZzl1sIKSlQ9DRatWBm7xVoxCB67Tr/h1OLOF1RTa2zR4VnVCIVUYKl
         zhw4EL72HxZwXa26yoHAA8BuBXFyfZVSUZGSHTDEEPYyKjK2uhw+xNEKRE4tjssFXmEf
         hvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721034924; x=1721639724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2m3lT+8e+fZ61YPDTuybNJRn/xGhJoX2Iin5K3yz8Os=;
        b=b+POrQgdJ7LouBXZFshTg4Kq9UVi0byupSiiTuM1jrhcwe4YCjsbq5HgCF+fEtbLef
         bNZPtIIYe5piFOOVMkmmuc6ibbsV3Jt6VHFAQI8Aq4P0j6ueyWkzMs3D9OOb4yyYVBzk
         e8MNA7ivZTHcejH8I/P88bRxpAn/xXs6v7HhNZ2L3+m/smaXQ/tX7oAElLuKCBABb7B7
         ec1MXYcNfx0L1S7e7abDsRUH6AR+a67nbgiV+4vAxPfBz5QntdUATfBNzaGp5vxbb335
         J2XIjz2Tb14zYyoKLihM6HZJsMDKCWRzcYfxuf46zm9YLxt7AkXTh08yMDXbdtn6AwWk
         wG9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPEUTuQupC2NsoTsrdaRVlggpZTQEpqd57Fnxg0wx2TKiKFebGtdL0zFgBWb+XaM0VmYDsLjMGNfoO8GUGW44tZy00IlpJtPHARl6f
X-Gm-Message-State: AOJu0Yw3z+yplgbdkNN18827doCOunC2P393qx4aRN/TiIoBtT7irqz9
	lZZmLudbqzBeLT0neNYETtHHmijxWCRMUVYnYvmSp4t/yM8cKAN2bF4cPALVen0=
X-Google-Smtp-Source: AGHT+IG2OrcKLpQ2/wzPtelwlPnXXPL9jsLWPAZnUb7Shn707tdEIIbppLam6Qk3sPRqZImLVUVo6Q==
X-Received: by 2002:a05:6512:158f:b0:52e:6d6e:5770 with SMTP id 2adb3069b0e04-52eb998fc71mr10153863e87.14.1721034921945;
        Mon, 15 Jul 2024 02:15:21 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff1f:b280:82fb:4328:f644:289a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a63449fcsm76838685e9.29.2024.07.15.02.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 02:15:21 -0700 (PDT)
Date: Mon, 15 Jul 2024 11:15:16 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>, Johan Hovold <johan@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] power: supply: qcom_battmgr: Ignore extra __le32 in info
 payload
Message-ID: <ZpTopJi7GJSLaF99@linaro.org>
References: <20240712-x1e80100-battmgr-v1-1-a253d767f493@linaro.org>
 <mz6h625ecs4ozmjxoozjdnunfmr3vsdw5yyo6il5vyzknyzqsz@pun3t27zhiv4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mz6h625ecs4ozmjxoozjdnunfmr3vsdw5yyo6il5vyzknyzqsz@pun3t27zhiv4>

On Sat, Jul 13, 2024 at 07:17:51PM +0300, Dmitry Baryshkov wrote:
> On Fri, Jul 12, 2024 at 12:00:03PM GMT, Stephan Gerhold wrote:
> > Some newer ADSP firmware versions on X1E80100 report an extra __le32 at the
> > end of the battery information request payload, causing qcom_battmgr to
> > fail to initialize. Adjust the check to ignore the extra field in the info
> > payload so we can support both old and newer firmware versions.
> > 
> > Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> > ---
> >  drivers/power/supply/qcom_battmgr.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
> > index 46f36dcb185c..a5b5f1251af1 100644
> > --- a/drivers/power/supply/qcom_battmgr.c
> > +++ b/drivers/power/supply/qcom_battmgr.c
> > @@ -1007,7 +1007,9 @@ static void qcom_battmgr_sc8280xp_callback(struct qcom_battmgr *battmgr,
> >  		battmgr->error = 0;
> >  		break;
> >  	case BATTMGR_BAT_INFO:
> > -		if (payload_len != sizeof(resp->info)) {
> > +		/* some firmware versions report an extra __le32 at the end of the payload */
> 
> Any useful information in that extra?
> 

No, I don't think so. I think we can just ignore it.

Thanks,
Stephan

