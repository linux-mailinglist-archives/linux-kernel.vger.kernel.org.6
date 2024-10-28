Return-Path: <linux-kernel+bounces-384482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0B59B2AB9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC2F1F22645
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB928199247;
	Mon, 28 Oct 2024 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yRgY1ReU"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCB3193067
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730105342; cv=none; b=OVfSSCaeYB3yJS3p5xjrdTvQ/afo65NBin++tR5c4C2tAhaIytQ4ubVbrTPP5NHXmkttL/lWFffPJXU5fUmulbeTNkD432VDIflpVCLmIB/Cgs4zuIpoxCmwskvOSDhXX2+JZqXcMp2j+Dn83oA5m9XcUOqP1bnnPltncrpktGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730105342; c=relaxed/simple;
	bh=YmzdiVli4lYby9EUWBotCYouDofIO5rwoTrrfgeeQ2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJjg9TFbJ17tFsa12JXlu8hjw0ZGjUF+WOSMbGnXENivowoByrkcyE23U6b6F7GVVMQqZl66G1DQIq+uCn+xKgEvuuTxYxYiptxQsO8+XcwJAs5xNtK2xeIhv2+gUp1JGwpZrqCYst6k3i1VtrckyD9DFgQjBnTr8LgDH1klKAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yRgY1ReU; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43158625112so41407505e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 01:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730105338; x=1730710138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NZHqE5FIZcWpwQkY/RrgB0YFJ0n6wWMGAIU6ebDFpm4=;
        b=yRgY1ReUAeABQ6NWrAOmhmC1uv1dRMA+lxwSwKaHLvIoUg4dRF372oBxiFdOauRUWQ
         EsbJmum+E+Rx7EVzPPBYpCWBVmXyaH5AsJYCa/7nkHl9deIgHo3O7XgaieE/BuvQgTfS
         0XpLR1BOg1iLbPO0NFuQQmigC5gEdkYWGrbtja4Vs/yRWm+5pGpi/slJnc3sR08xhyJN
         gJuCAuCO7qVhhdkzf4d+G8zhKExMxzXgrlFmVu5CQ+6PqjGPi0VkwCdw0flaLNvRrJrh
         TF8Xy2zuempPj8E/NPjJa+0T5mG6EsJkpWzquacsOiWiAFjeUDdPIeGrXWK7chmgKt8A
         LrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730105338; x=1730710138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZHqE5FIZcWpwQkY/RrgB0YFJ0n6wWMGAIU6ebDFpm4=;
        b=wORUtlRLw7YUzSmLxk6g2porAhXPBAZHkJMkanus41oj+O236QuxR/1g0py5PEOtSq
         DThFR5UK55m4JYOiA0+35SZBoMLZ4cTVMjYx7fXaOYXiInxvhpSAU6zeCGNYn1e97J+/
         CnKSdXqn8XQUu2FCfFkyfc0clcUvL15Xg5msr2LoG+/Ag7AzBDjsFS+BGthCI9osWVjZ
         uyQ9r7NYkJ0g1Q/J13+ZdtlcVEXdCksF9RGEe+To4Xwj1Y1JZBTs526GXjJM7KtNeeAX
         TK/aBcj4sX7i9v9ailssXNcyy+7ASd5NKlKTYpFuFCbfUN1SG/P+RWF5RDM35sizy2xk
         wsWg==
X-Forwarded-Encrypted: i=1; AJvYcCUukrKYDfweZkXFDUkiqpXZO5h/9+HoSeP4kW74BeHn/W4wqu3z4CygVDHZAn+goiTtoL288wnfJaN+jNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxg/3831Q5cvMfCZYacxdP5scQHjSgF5PxbZuoGTspiytYeN+j
	C1GItbWh/YmddMBEtRNsLEFSWZxlTCMqIry7EqddfpD3vCzCCYDBc8cqm93aJV4=
X-Google-Smtp-Source: AGHT+IEFxQSc2bqcOE6ZMtPaTM9U6ny4QVIlaUduSs6ZEGDMn5VQh1w848qM/SJNHxs0ooF44YbSVQ==
X-Received: by 2002:a05:600c:458f:b0:42b:a7c7:5667 with SMTP id 5b1f17b1804b1-4319ad02659mr61662165e9.25.1730105338472;
        Mon, 28 Oct 2024 01:48:58 -0700 (PDT)
Received: from linaro.org ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b5430b6sm132596245e9.3.2024.10.28.01.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 01:48:58 -0700 (PDT)
Date: Mon, 28 Oct 2024 10:48:56 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: x1e80100: Describe TLMM pins
 for SDC2
Message-ID: <Zx9P+HQMOkJsJGcj@linaro.org>
References: <20241022-x1e80100-qcp-sdhc-v3-0-46c401e32cbf@linaro.org>
 <20241022-x1e80100-qcp-sdhc-v3-2-46c401e32cbf@linaro.org>
 <a282021f-5e61-480c-84c4-272049e28244@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a282021f-5e61-480c-84c4-272049e28244@oss.qualcomm.com>

On 24-10-25 20:34:19, Konrad Dybcio wrote:
> On 22.10.2024 12:46 PM, Abel Vesa wrote:
> > Describe the SDC2 default and sleep state pins configuration
> > in TLMM. Do this in SoC dtsi file since they will be shared
> > across multiple boards.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> 
> Not very useful on its own but okay..

Fair enough. For some reason, I'm not able to get sdc4 pinconf
to work. And there is no board that has a slot populated for it.
So I split the pinconf for sdc2 into a separate patch to make it more
obvious that sdc4 one is missing.

Let me know if you still want to me to squash this into the patch that
adds the controller nodes.

> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Konrad

Thanks for reviewing.

Abel

