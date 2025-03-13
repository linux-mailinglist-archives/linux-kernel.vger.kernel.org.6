Return-Path: <linux-kernel+bounces-559088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA76EA5EF67
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90A1E19C1166
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9F32641EA;
	Thu, 13 Mar 2025 09:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpT60Q5v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBC71FA14E;
	Thu, 13 Mar 2025 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741857492; cv=none; b=LX4wy+Se2EjnVpWtoSCAVVN4OeBEj+zwuPyXJT0+H1qoXIyndJYVK8imyRP3sgmkACBcfZ/lVMsOOlhx7/kp+AN2llTpjDyPvpOXjLDLVSJkDXo/eAqb0iPGG7Re6I0NZmsp/6tzkkuxqzAQMmQAwU88XY+x5EjtKf7WzNJCBjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741857492; c=relaxed/simple;
	bh=jVDomjMBnInaKjiE+S8O3q0/G9g8FyXhVtfxKw22KpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cx6uCSg50cMcnUE3bCxyUv7iyJjDv7A1caj43kjYfBF+GpMN/NGGl8PR3bOQg/0hTyR88frMC5WYBgLLvBKmjCHPW7MzsWmP4qJjxNpDmZ+wENFKAf9k6QZ59M0xCb/rJ8GcPd5KzrGnJBNQDdZPtc/Nq/hMzU6hkyMlZm0mpHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpT60Q5v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B24C4CEDD;
	Thu, 13 Mar 2025 09:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741857490;
	bh=jVDomjMBnInaKjiE+S8O3q0/G9g8FyXhVtfxKw22KpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OpT60Q5vqAO47nrGiXqfBtPRoVds+J4VyaWDOFbWjnZVPe8UZrvVS49M2oWEt8t1x
	 i8Fin+P3gCNGvjRS776K0LoKaDCuSolR1vJwRNL7af30bETjPZnbgZMlwicAElAN+S
	 B+qtMgGKRFH4x5Ro47870EV96wPER696f/BiemG41tPbuHiw/g1sFMi4hIEtZHGgAr
	 UQuaGqpWtVhUHbrC2DNuNInJDcLCW+j4h6YYufhb7F8huHFy5wDnuB57Im0dQbxS9n
	 x1HfyZwLbyrpY19PdUlEHWRsOOJdQbRrCCuDj85fdInp+nzltMxYKsfBf3pCCIF9qx
	 zaRcCEwOAzHEA==
Date: Thu, 13 Mar 2025 10:18:06 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Imran Shaik <quic_imrashai@quicinc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Taniya Das <quic_tdas@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: cpufreq: cpufreq-qcom-hw: Add QCS8300
 compatible
Message-ID: <20250313-sticky-glorious-dormouse-9dcfae@krzk-bin>
References: <20250313-qcs8300-cpufreq-scaling-v1-0-d4cd3bd9c018@quicinc.com>
 <20250313-qcs8300-cpufreq-scaling-v1-1-d4cd3bd9c018@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250313-qcs8300-cpufreq-scaling-v1-1-d4cd3bd9c018@quicinc.com>

On Thu, Mar 13, 2025 at 11:33:39AM +0530, Imran Shaik wrote:
> Document compatible for cpufreq hardware on Qualcomm QCS8300 platform.
> 
> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


