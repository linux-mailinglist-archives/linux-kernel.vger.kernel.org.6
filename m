Return-Path: <linux-kernel+bounces-430370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CD49E3009
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 00:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5F662837E9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 23:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1108B20A5E0;
	Tue,  3 Dec 2024 23:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mb694BkN"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF8C205E1C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 23:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733269428; cv=none; b=qACw4OPkMnwZC8YjdEstryohKtF5etxBcBc09nIcFzxMybue8vlaLf5/IEKGLMVbftkN8oUmoDrHIhTYSnAw+tI//k3wM2jhYhdPNyNVsGB+ee8da1rP83x8WyNyhM2IALNPJm7YUdKbWRm8ur3dSI5sD88OB+i8COpxgosA7XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733269428; c=relaxed/simple;
	bh=CgfkE9ZMiNTqFfMldGWs3WMrKUI+2eSx4fz+V4++VO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roWQKULsUtdq5U8B9zH1TW11ZobXJWI70ZSCYf2YMe2qbHJHjzzH/y/ulL7E27J0T8l9y6zMplSpY7A3SMvSyafgg7AbwXwFWFp/7QYsOdxMy6PjWCDIaDkYVLYKRt9xCHvY8IfgNRLI5wKPV4Z07cljsmz2T1JW/dXrlR7DFtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mb694BkN; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ffa3e8e917so68153471fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 15:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733269425; x=1733874225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=paiXFVPVWPRPDu6nA3C0qg4bqDQAprC3oW4RjPZivj8=;
        b=Mb694BkNg3B68uVi4FG2n98I6hQF7P7Iu7wEMOubwlnHbKGt7cmRSsqC1n5qoAmzuz
         d1vuYqvEZsOcbiKb1us7LmzmW1fqtDoH2OHUEkp2u9H3Wkp9ln4+4j4zSx9kH8WYp7mi
         0hkQTm9lqnBVIv4VZ/WpivTHKur109SUdObd5mW17MRsDCqawYXsJzXF+/AlydMC4Rut
         m6FIqs9uFzpb9syu7spdmaN0xcLjmq4cT2l9ygAzY9cwfEnDMBYsP2HLyZRmfQ19UXfD
         DLYduyLElR15NiyiOApFb+X0DEZgTwKeClpFp4GoE1ay/6Uiso8w7EPrspMnnvzhuwKI
         8bfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733269425; x=1733874225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=paiXFVPVWPRPDu6nA3C0qg4bqDQAprC3oW4RjPZivj8=;
        b=Rl2n2tEMMf1tL9fiIpiZoRJ8JNH+w0TCMWQa6MgTaEb/do2bu3xsTBAKwLeh9reCth
         zyH4pBG5Op1hZT0ROVwAIsb2ctbn6Z1dWOQaniXzWPdevBbAbIzdlg8kqBnp4rAjSY3L
         haK7hRDyOLyUhGggIre5qt9suyi8jfe5bpv5g1P/0hVwSf25a0A4WphRArCjBPq4DD2t
         ZtfAQGw1SO9nt0QBhRq16J9sMX03MbcmWJS2r3qIyS9z+Q7mydHg0Q5AOKxNXQpOKNXJ
         Vf6qjt7NYy/ZhiFdZRunpbqFP2bnH+hmoQbmaMeDJYxtzMpCZco+GgJ+l18/Oo58+CR8
         Tmyw==
X-Forwarded-Encrypted: i=1; AJvYcCXaiDlErELDNFPTf8U0uaZPrGeGry8QjeFly4sU1HX1zx/Yh1oIBG2t7RDoTNECr6iakHSyFVEr7MgLyt8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5DA0zOueQWDA8cwKefJuloR1AyBIEjwXQYHwsTrHaDDaD2hzG
	a911Uhmwl1LVx4y/O7vcuF3TrPXHUpYyzFEMnlnAdrIwSdMMwPJgTlp3mPGjblI=
X-Gm-Gg: ASbGncudZMLwAcHlC0aKqdZHO/8jrztWi/c2XlyWzKqCYCUWsNP9yZhb4R5ADVOl3k1
	rlG63SPTgF/y+qXhsO0xDL+2yxIAAIz4Zx2/A9e7QdjA67xQoszsEWezYkJHkwIjGj15p2OvAQ4
	5T/rLAqNLqtExK5ajbTOxp31yJoj3boIg7PsdrJP8wGFeeuARpDl/A6Rc+l3xPHZLRNcOhN7zXU
	kRpMLYdrJuijkgNOwWa3mZaORE43EfV/jrVP+oostZmVvLVgMLLYkvhQYrd/pak/Z/w4grwJ29c
	Wgi82icRYPG1adVN0oJQ+tfwRA7WlA==
X-Google-Smtp-Source: AGHT+IFDGrQkvLlyXqBklk96Y14J26ba8zuOIKYwTXl6pLPFPM98U/mamBI+7HHZilK1jeWt/fSX4g==
X-Received: by 2002:a05:6512:6c9:b0:53d:e52d:3373 with SMTP id 2adb3069b0e04-53e12a2c9c4mr2062386e87.41.1733269424835;
        Tue, 03 Dec 2024 15:43:44 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df646f2a2sm1986127e87.167.2024.12.03.15.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 15:43:43 -0800 (PST)
Date: Wed, 4 Dec 2024 01:43:40 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
Cc: Trilok Soni <quic_tsoni@quicinc.com>, 
	Jens Wiklander <jens.wiklander@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 00/10] Trusted Execution Environment (TEE) driver for
 Qualcomm TEE (QTEE)
Message-ID: <gtfm7paylpcobucmwmapgdxva2wnvn5skkakaalzpx4ip7x2h2@lphbinkzaw7k>
References: <20241202-qcom-tee-using-tee-ss-without-mem-obj-v1-0-f502ef01e016@quicinc.com>
 <518ee3f1-b871-4349-ba85-3b3fc835a4ca@quicinc.com>
 <0df58435-94e7-4b81-b688-ec0e1c49c0e0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0df58435-94e7-4b81-b688-ec0e1c49c0e0@quicinc.com>

On Wed, Dec 04, 2024 at 09:13:43AM +1100, Amirreza Zarrabi wrote:
> Based on our discussions, we implemented significant changes. We essentially
> rewrote most of the files and altered the overall direction, except for a
> couple of files. The changelog entry would have been extensive.

At least some changelog should be provided, even if tells "reworked to
use TEE framework, made it jump over the head and tie the shoelaces".

Also please don't top-post, this style is frowned upon in the mailing
list discussions, it breaks the logic of reading.

> 
> - Amir
> 
> On 12/3/2024 5:06 PM, Trilok Soni wrote:
> > On 12/2/2024 8:19 PM, Amirreza Zarrabi wrote:
> >> This patch series introduces a Trusted Execution Environment (TEE)
> >> driver for Qualcomm TEE (QTEE). QTEE enables Trusted Applications (TAs)
> >> and services to run securely. It uses an object-based interface, where
> >> each service is an object with sets of operations. Clients can invoke
> >> these operations on objects, which can generate results, including other
> >> objects. For example, an object can load a TA and return another object
> >> that represents the loaded TA, allowing access to its services.
> > 
> > The first patch series was RFC and now you had removed the RFC. Can you please
> > provide the reasons?
> > 
> > https://lwn.net/ml/all/20240702-qcom-tee-object-and-ioctls-v1-0-633c3ddf57ee@quicinc.com/
> > 
> > I understand that you have now changed to tee framework but I want to check
> > if we should continue with the version and increment here or start from [00]?
> > 

-- 
With best wishes
Dmitry

