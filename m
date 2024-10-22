Return-Path: <linux-kernel+bounces-376067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 427559A9F84
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56C461C237C9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219761991B9;
	Tue, 22 Oct 2024 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LfLthD2z"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3326F145B24
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729591413; cv=none; b=pXthc6NkHcHylxT1Zm0508oDkNcMEG6ZytB3BReL/clqVRlDa97tjAjMyJ/DenRuPYirYQxhMzwD2YMrX1GVbcHADilcOC1vpqtHWLYhDJv4/JuGC5ew4QpzfsNPf4qC8K4p+L72jjMI6UkGztPmdxxiLzca8B6stN3weAksd0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729591413; c=relaxed/simple;
	bh=IGILfBDE0CezQVcLjxVcRJDLFwM0+yfsxlRm5nnZnzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mj3wklP/v1C92N5wva7PeUS9FgB0q4GQoqEBkMt7PotJddecI1OCVkBY1FqWCyicL0PEB8qcVyrE9zSYPzjKjMJg2pG3WsK5MhPXoSNsgloHAzCWep/YUkSnT3PWlgGhoIJTFcD3/5JlKcYRS4iMbn3nrnBytxSOhHEO202WFSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LfLthD2z; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539e7e73740so4848144e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 03:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729591409; x=1730196209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GI4/LkGxcsUK9/hDOFEhANPseX87tbNMgbhU6aHNzkA=;
        b=LfLthD2zh+64GGsTwGC/9A505b3xzcG5x106VhyKRNXBakJYbx2dyE8qGtCOngpiwg
         PZ8ymKdPUjoXIbjmlzFJy4vlxY/Cpon0maLVVSzLm4dXviYL3BK/Bx2P22QcO2RHW9EP
         fxfqJeDytsqYCYPmScm7Ti+IzlVZbpKXVLixkjRVTbCVktie0+PtCR1UBhw8IFwkggsn
         mte13wng9Kf6n6zaF1WTunDg1F7bKHGTSVM9r1+fYWOXYrZCn9P/D055/yDe8zmp29Jv
         UIY/EtUx4d0Tyl87s6WwF/e5EMUcb7RT8vuMQo1zwx7lKOCOwUIjfdyRJf0DKGqYCVvp
         msIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729591409; x=1730196209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GI4/LkGxcsUK9/hDOFEhANPseX87tbNMgbhU6aHNzkA=;
        b=DbmxeSElArqAZf1OqET78xslmbsV1LHJZLZz32AqvAJBYsoVmSkUo7QucgZtAXHwls
         pLB968cSuNQLpWb/va0SXk/sdXIR/6SHRrW2acmcqPDomqVs0V5CsOAjqhYxCOjUcr47
         eugTX/zU98lRLwIJ5JMM8wnS0OuuLDwIcWpyO4SUDf9f5l61LbrjKrBmAdW9gXNSDWdq
         RHqHbmtc7mR0BstUvxpuUESdwKi99R5K7x1kPESkH9d5RU/JlE4HbeKGEZabZbazMchB
         AwyKH8GZ+/TNDxqzcysjG7WbLjOdET/POPwzo/vFR0o7qUCbQXRzlkuw1Kju37NtalU2
         R6KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZbG/7fPTl9nlV5NkKEckreu2sMHz8RB5j1OhKS/8uuW+Gsocv/PNwgwCWd2YCjn98YZq7WFs5/hnpfdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJfcVh+hp0W7Qfs3kkNSFK/gtMxTkn+bnAhXK27fxA87hWwAsr
	acnyLOugbqRzzEOziafKcI0an974gPXUA+ZaYkYvkbcQi9Kwsb+x2mKcJPTZuM0=
X-Google-Smtp-Source: AGHT+IFz3rZOvoE9ylpsIjgCKYyYmWJxRMIY7UD0EDD55zi55LEeWZR7eNB+ipF5qamEN5rH4o2eMg==
X-Received: by 2002:a05:6512:308a:b0:539:f8cb:f5e3 with SMTP id 2adb3069b0e04-53b12c36b16mr1626839e87.48.1729591409337;
        Tue, 22 Oct 2024 03:03:29 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223e58aesm720962e87.28.2024.10.22.03.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 03:03:28 -0700 (PDT)
Date: Tue, 22 Oct 2024 13:03:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Taniya Das <quic_tdas@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org, 
	Ajit Pandey <quic_ajipan@quicinc.com>, Imran Shaik <quic_imrashai@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: Enable sa8775p clock controllers
Message-ID: <glhmky5r3rd44hmnxgtgeelqp426fdsh7w2fqpuusz2ek6eauw@sfptftzsilix>
References: <20241022-defconfig_sa8775p_clock_controllers-v1-1-cb399b0342c8@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022-defconfig_sa8775p_clock_controllers-v1-1-cb399b0342c8@quicinc.com>

On Tue, Oct 22, 2024 at 01:36:38PM +0530, Taniya Das wrote:
> Enable the SA8775P video, camera and display clock controllers to enable
> the video, camera and display functionalities on Qualcomm QCS9100.

Please mention the board / device rather than a platform.

> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  arch/arm64/configs/defconfig | 3 +++
>  1 file changed, 3 insertions(+)

-- 
With best wishes
Dmitry

