Return-Path: <linux-kernel+bounces-417244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 448FE9D512D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97AD7B2AD20
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097AF1CD1EE;
	Thu, 21 Nov 2024 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KVE8F+V/"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA401AA1D4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732208401; cv=none; b=TYYplngE/LqmvwSt/OdOwwcz5K1Yck1xlJNUJHDwJlL6by3YKuft9SJRmnWtdB/n0Wq8VZeU5YDgd6kRBx+vky7/cxV4r3n0UAAZCgdd16r5RwR69N39WbtXeXbV7PN08BAgHHLAT9Snd3DY3ypb0uct1mZh4IFM+zSsYSVHKgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732208401; c=relaxed/simple;
	bh=qJI7JAC0Ed2camEWXFgqiWsh+z80E3RdsXM70TPSvcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9ybevPm1w+JX8qkRkZ6ewKpUa+qTPdKs2SltzI5AXoPT4ADjej0P7MXktCSbXMs77Tem63ml6YIHsTRAmVIPxoWIHUmT2nD9Y1Oa+wJNToUCJsru6uFMhRofCRvW45IdH3zWoz2LkYatCAzUsFg8uRlLoc76Zn9ckcnpo4tUSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KVE8F+V/; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539f53973fdso1033329e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 08:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732208397; x=1732813197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4kWmOlhAyvLltjxgfGITPOMja876WfWZzWl3k645acc=;
        b=KVE8F+V/cdPKTlWryJdccPU8fok3PgAhRHpyvS/S6nxWDqXL5I4d4eKXFWuas79cDa
         VWgTVDWZxy2vo83zWJcueTyC+ZRHlEyM1uLJI68FCDR7PbX87z4ZH9amUkREb8wSeFEJ
         ut6D/h8npNnC4Ai1J5jBxSoQQ7XY8uQqAOjWGFUamv3eLY7RIn9iVrG76TrAquvVSEKF
         OaHSO1eJ7eo3iUqdZ4h+KJRjlrpmZPhbVqDGktDGM3WmCQSDrKAoUiTxfzFr6SdjPIZV
         atdR6EuFDJwQjLN3ufyy/P3t+s/MyCk3BgsO9nygxoIwM44wISfdm2pbHXkpiYkS0XTk
         5ilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732208397; x=1732813197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kWmOlhAyvLltjxgfGITPOMja876WfWZzWl3k645acc=;
        b=GZdseng44ZCRn2vgrIZGH0mJjF1xESurhtWdmBRWqUZEH1LOUthkOBvVznDRPaQOi3
         DBJXcZuU+Vm6IJBvbEkYfrzbvvCpFjY62vf4cvB2wLrHQ9nw7QmqSeHQqog8+3HouXIv
         zJK+JjPH+ZWfk0sQhKFE84IoEUXgS2MjiWAFex7YUcyNvtHLJoi+re/IgOgT9Vsqc7u9
         Gz8C7mTRe9XSpwlDsQBpw2BXV8C9eP/tw7PXT0+/J31ONsyegNyqoOaHh452FTLXfLTJ
         i221PZ+CuOqN8mWZRqT1YdvUITTfXDj5wumV5YpKwdWpEAOY5lt/L5gLXx4yKIoVMZGN
         cbew==
X-Forwarded-Encrypted: i=1; AJvYcCW3Xu2iCoU9d7PmO0QFcHLxgMSLsEhC05uAcU82RITlCFhJQ3p7f/DsFjoE3QgQ3koKsXc0DZRdkwPTWJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrKbKfgGZCXGmr+iwkfsni2nXprCcYATRqmRBOsW6rTbmXr5B/
	etKD28UaDWuveL9ufdIEGbZvEb0/z8LsZua8PuYQOSBXRC5E5VF8UvBGVPBJaS0=
X-Gm-Gg: ASbGncvXKzHeBYX02NqJi+0d4e5wNc9nDx7dCqiPVY3IBhV5qyo/wS9AVQy2vgg06sJ
	yN5m0U6p32A+KZa8TRTJ1LbxXC0CizQFKWLgTgNEVlCeW0hI1qGku/2wlihlSkrJpAlKkIkj0xG
	nWjZKuZSlpQNKI7KGqDTOO6vfn629NZCq1BipTp3gbqcN+vQoZu1cZ4RBVih7aOulWVMoXDXUDV
	JrWcKd1efW2hkQjEVGQtagL/0Sz5ZtGjtRvANvszdskQJwT1wUJAQObxglKCX3yjJsxXSMHsxk3
	NgaJx/867Oh8UaI3pYxUFF5uvvLQjQ==
X-Google-Smtp-Source: AGHT+IGL3c3ho7r8sF8Xcr9a+4/C/Ler4BcrWhP6ykFH/IDRrpCDlTkssOTbniD/Y/so77ORXxYebA==
X-Received: by 2002:a05:6512:3d18:b0:53d:c861:38a3 with SMTP id 2adb3069b0e04-53dc86138f5mr1426353e87.27.1732208396862;
        Thu, 21 Nov 2024 08:59:56 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd245186dsm16381e87.100.2024.11.21.08.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 08:59:56 -0800 (PST)
Date: Thu, 21 Nov 2024 18:59:54 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Xin Liu <quic_liuxin@quicinc.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
	Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	quic_jiegan@quicinc.com, quic_aiquny@quicinc.com, quic_tingweiz@quicinc.com, 
	quic_sayalil@quicinc.com
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: qcs615: add UFS node
Message-ID: <oikbuo3anhiifydvzdsjazbdwqqwt5ssi64sxopjrdiryr5r3y@igj3gzan4ks5>
References: <20241119022050.2995511-1-quic_liuxin@quicinc.com>
 <20241119022050.2995511-3-quic_liuxin@quicinc.com>
 <4bf9ea1f-4a45-4536-82c0-032f72b28807@kernel.org>
 <f5b40d0c-defc-4b91-9313-9e454af22fb8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5b40d0c-defc-4b91-9313-9e454af22fb8@kernel.org>

On Thu, Nov 21, 2024 at 08:41:53AM +0100, Krzysztof Kozlowski wrote:
> On 20/11/2024 17:58, Krzysztof Kozlowski wrote:
> > On 19/11/2024 03:20, Xin Liu wrote:
> >> From: Sayali Lokhande <quic_sayalil@quicinc.com>
> >>
> >> Add the UFS Host Controller node and its PHY for QCS615 SoC.
> >>
> >> Signed-off-by: Sayali Lokhande <quic_sayalil@quicinc.com>
> >> Co-developed-by: Xin Liu <quic_liuxin@quicinc.com>
> >> Signed-off-by: Xin Liu <quic_liuxin@quicinc.com>
> > 
> > Confusing. Who is the FIRST author? Please carefully read submitting
> > patches.
> I retract my comment: It is actually correct here.

Yes, I was also confused first.


-- 
With best wishes
Dmitry

