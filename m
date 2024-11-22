Return-Path: <linux-kernel+bounces-418142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D3B9D5DAF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C807A2853A1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270F71DE8B3;
	Fri, 22 Nov 2024 11:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OKm/vIOg"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8591DE8A9
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273254; cv=none; b=tHrNgrSmF43aO5PkQC++ITaE2/eGN0UKI1+mSoIEkWfkWVQt36MWol4TX7NrCckxrGGCJAEvf/twm5c05b4ihBSvGKh1VAsrJMLx5agKu5qXwBsmE9zK3fkKXtEVeNJQUW/+1IMfh68+WoyqAgwPgh5YFriT979zuY9vICYUT5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273254; c=relaxed/simple;
	bh=esQkEv+bJkBiPxQO0jmazrQSqkgqrNZcKbFEDiYk7rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASjduHH+HXoU7dag+XgGTayi85VZQznerIW975qP6YV7y+9U7Muw/3lG29m5XwyclAX/N8mNk+ItDreTnTQ/NZDnMEZVfr9HeeCE1MKezoZnvU5wbguiqrfKPTDqWn2uugAx/Rt/j9fpoyNLwJ0a5DBLQ+QYWXWIV6Ph80R+7tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OKm/vIOg; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539d9fffea1so1949711e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 03:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732273251; x=1732878051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AlkHc4CfnQoPn1A5gJ9s0BPlf2Z29rGqNglkoIekDGw=;
        b=OKm/vIOg4BlzkqHDJHW+9yr7BCvKPt0Ylt1uUzMiL/bhnc26chJvvppOWUsyh4+3gl
         sfH8MBJhxk68a0UaqKnJkcpDC6WP7yEXq6z1RbMW45rhydHKciv0mUitCVB50CI5ni0w
         xnBVLHa1BMVqB9BVpt9lJ+jIEptgQoFrEXNvx/6X1waZp1E3wT9BhwWhBX+gq/QXU+oi
         XLy9qSxnFu641XBIMGN1G04ijor5fTWF588mz9cFSGruCvd1qOc08YEIPNDVtTXXKKfk
         daHOypB7GjS9UVTUJLoB7l/aGTXUa3cJPV9zK8RCm++W0IDOI5fU3cxHLnMTyEehU0VM
         abEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732273251; x=1732878051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlkHc4CfnQoPn1A5gJ9s0BPlf2Z29rGqNglkoIekDGw=;
        b=LcpBhlg5XUC5oyx5msiRtqfJbIqW6cmXLLw/yZlN3uvnTRjHOyRIH1tyDLRRyaPoxA
         JPpNPQEVQ8PRJZhY/HiU4bWwJxmbO4LZEHMp2ImSh/wTtYQrpQSZeGZU9huGUNGg/Bj0
         QSButmhLsx66unbMpOzO7fm93BpxYnn3LncpjzdjQ/7P1Xe7hasrzV/rz1ziNrdA7L5g
         YoPve3EJVQ1a0DhtjyYin7do9cNYPlfg2xg4KbMLXC6Pq58SFmSAynGXEQmoK9tDuMQ3
         Z5JdkME6Wq5QGDUAMryW2Q2tTIgbf2UEB6duRRBKIJAxEaf+2aY5XOKmWrTv5VTUPMK1
         niHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6JTkfb73ZNAFbbbqq0wlR2zaRxU457GamCfQJhhr80h9aX9l61MTIYRHHZcXwWMPZNCylDDaAX1GOEXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCJDIv1LRkBLB5CfoNHmNziFgXvF3wULno+z7xTgUiYdAhibF0
	05LT6xebwkwYkWeEgNB1yxWVSnFrFwWNIYvGUz8/8aEC4IALE5oMjZ6E1u/3Rkk=
X-Gm-Gg: ASbGnctYnpjlIRESXmJ5lzilBrBYJAPIgTmrQJpEt4t9gxJkRsFjK4YTOWzef1U43rA
	Vz68NEAANNWUl3XZ4ivVCMBA8l2ej1tdyWSVW6HR/sTLjhFil6sTP+b3Py5TLAHUCvRw4cijAe+
	hsGrsfw0irSugbvW+4hqWk2ykgGPYGcHMNibdLtoLlSWT70G0b6gKSR9TVEcTWaH2vB+Y9QY5bf
	AP65YfPWtN52F7re7hnp/8k4chXX517U4QR8i1nCJZrfOxJOIS9iGFpNTa7ndYh1NK5AjMweiVX
	vUMcRUwQjTwbX5qBp+DBFgotmFGZUg==
X-Google-Smtp-Source: AGHT+IHRcfY0IeVLi53bK8dwcq3XFuy2uo8jqF7yK68qsQJ+2p/GgmOCR9UBE7JD6UnJ50+els3Mjw==
X-Received: by 2002:a05:6512:3b8e:b0:53d:d0c5:4ca9 with SMTP id 2adb3069b0e04-53dd389cd1bmr937303e87.26.1732273250848;
        Fri, 22 Nov 2024 03:00:50 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd24456b2sm327282e87.56.2024.11.22.03.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 03:00:49 -0800 (PST)
Date: Fri, 22 Nov 2024 13:00:47 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tingguo Cheng <quic_tingguoc@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@quicinc.com, 
	quic_kotarake@quicinc.com, quic_kamalw@quicinc.com, quic_skakitap@quicinc.com, 
	quic_fenglinw@quicinc.com
Subject: Re: [PATCH] arm64: dts: qcom: sa8775p: pmic: enable rtc
Message-ID: <4gwmrfnzqqlawgkgjd4fj3t4nkpulnxuzsc756v6uxz4dlq6mm@dhv2aqkdx7du>
References: <20240902104302.3959670-1-quic_tingguoc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902104302.3959670-1-quic_tingguoc@quicinc.com>

On Mon, Sep 02, 2024 at 06:43:02PM +0800, Tingguo Cheng wrote:
> Add RTC node, the RTC is controlled by PMIC device via spmi bus.
> 
> Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

