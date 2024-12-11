Return-Path: <linux-kernel+bounces-441535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 760BD9ECFEE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33D8C163984
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7531D5ACE;
	Wed, 11 Dec 2024 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c/wjrEaD"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC551A4F22
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931495; cv=none; b=QdXW1+YFQbKReVvzq/ObXQ3Q7NwhLXsnSxoEQhT9z0GzqlCZ9v2VaWtH91uYkaL6xYZgYxS+K9whvQxUL8TaAzakjeb6h+Pa9cjrhEM6p6ppYuNNAwMKI7ycUrB5dKmgrFSH/EUpmnegSGUeLQt2iYSCJBHGQ6JfR2IJim8UUdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931495; c=relaxed/simple;
	bh=9s0N/sC2onGljsBGBckykPqI3PZYxylUdQrBTFxK9CE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OyMIG3lOF6wUatLZeVts6MPfYxoxD7cliJX1mf3GpJ1RRFN39rmXCKlng2JxkhTp4aJ4BnBwu7kUUX2tR9P1gnyn5YA2lZLlHPeZEMZdgXYuZbLdttWYVZUYnGTswX8lmuN3SMXLiDcRy9TMtZJdkipY8s8Kznema35QPKSxcQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c/wjrEaD; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d414b8af7bso5222897a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 07:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733931491; x=1734536291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dZL+QjDd50ix4QcrkrbPUTc5iKTneISn5uygpbVvMxE=;
        b=c/wjrEaDykD/k1KrNFoia+blJ2VdlB/+Oetb3X/R65JNWE+PgoY+DJbVOWaDFDBtX3
         dYJqQIvctkQzhw0M5sXyznOFO8lXjgEgy1zCNgrVZdRuJlchz2CRq0nUPdrpmkOCIhOC
         CY9bNlJDAtJp1Xg6u2VbIYmisDU5jhF7byPAJF6XSqSVZDrQu9CoO/uyha4ehPCiuaQj
         9Af0ivuKN11/+a+gqlH0+Myf9nIixpMiUgJbzfpMrcBwoj0NdeBadBnXW+VubmhDxnCY
         3NYFC1CmR+XdpVE+HX/1j63/Xx2HQ2wgAuKtGIm8Du+pkHVJhU567lG8hlQ/1bP+519b
         /RbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733931491; x=1734536291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dZL+QjDd50ix4QcrkrbPUTc5iKTneISn5uygpbVvMxE=;
        b=T8y1uG0BWCRhvtnluJrkO7/7WpTsI8i0JA93vsQHuXKEC+x2BftHi2SJCeFN+xvPXm
         pUJRb8KyY6f8UutDsQOdzRs7C3SU9q4FGF1aMwd8KD7+WWxD/cJKj4FXYp4bfXFmF8ek
         S91tMVlHN5t6eWfPdvGCUKh7BoXDiWJI7ttQYE86xvW/FdVAczFKYIb+51UpCq3fiwxm
         OT2RRadW3B4hL5X3oC1PldAPyJHdkDyEjwsz8pBML68Dun0AueNRybgyHqH/NLqZUw3r
         wexmv+QtWyNA3eOBzs52qxCipCNvM1f5opPprn85bLKj3I0p4FanSiv8mFwR/q7iVn8X
         ZdvA==
X-Forwarded-Encrypted: i=1; AJvYcCU+7tCADea5KqSh60s8xnnENM1f5mtuDSht18GRaECkPk8+0ncb+jpXhoDrcC5jKYHIZ0ndjgqiUVK4PLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGmK3hzr0AeR+C9vj0TUWB5KILUI87eZkJ8TZQjhFnSV7r70Mx
	+T7Hy4oRxgMJe7BTWqjlMKnFSbsW8PiMhxN7iZ2J8mEhd9IXaukMljDH55jIj3s=
X-Gm-Gg: ASbGnct5c8TdxaFS94Dg3W9SMp3/HP1s6O6FuyaouPmiXQBofR3OVTaJKdWZFT1CSf/
	xWzN54cOxBClsq6SItWxQkW4ORegN/fDU+ogru7i26p73a3QMRQUm2POaycXSQ6pebJpAYMbLPv
	vggXObhOsXSLPEJjwz4a3QK9c5VGcpSssstQC9lSs5UQQ/1ktemkztQtAvIw+wn2lOXDfzj52uK
	M0AcNQ4e594JMnqAtUCpJQFfsEpgJpRvTkKX+ZkAWtICnLW8r7Iubzmz30UYx6SqUI=
X-Google-Smtp-Source: AGHT+IGOtavSVi2ZpcjL+dW0dFdaXE7oxFgtmAh3UdBELTKBJeoCykev5SGGl/1KKB6JGd1rlD2VFQ==
X-Received: by 2002:a05:6402:35d5:b0:5d0:d1e0:8fb2 with SMTP id 4fb4d7f45d1cf-5d445b3cf63mr41326a12.11.1733931490622;
        Wed, 11 Dec 2024 07:38:10 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3c4a42052sm7861107a12.55.2024.12.11.07.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 07:38:10 -0800 (PST)
Message-ID: <37523d35-c569-4bef-97aa-46b71236b1eb@linaro.org>
Date: Wed, 11 Dec 2024 15:38:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] media: qcom: camss: csiphy-3ph: Remove redundant
 PHY init sequence control loop
To: Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, vladimir.zapolskiy@linaro.org
Cc: quic_eberman@quicinc.com, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20241211140738.3835588-1-quic_depengs@quicinc.com>
 <20241211140738.3835588-3-quic_depengs@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241211140738.3835588-3-quic_depengs@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/2024 14:07, Depeng Shao wrote:
> From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> 
> Adding a new CSIPHY init sequence using downstream as a reference prompted
> me to look at why we are splitting up the init sequence into chunks.
> 
> Right now we declare CSI PHY init sequences as an array of five equally
> sized writes with a hard-coded control loop to iterate through each of the
> five indexes. One bug in this model is that if you don't have an even
> number of writes, you can't init the PHY as you wish.
> 
> In downstream the original code has something of the character
> phy_init_seq[MAX_LANES][MAX_PARAMS] which in upstream we have translated
> into phy_init_seq[5][SOME_NUMBER_OF_EQUAL_WRITES];
> 
> What the code does is take a pointer to the first index of the
> r = &phy_init_seq[0][0]; and then literally does write(r, value); r++;
> 
> The controlling loop that hard-codes '5' in-lieu of MAX_LANES does no
> special sleep, fabric-coherence sync or even a printk() to justify its
> existence. Our compilers are optimising all of this away anyway so lets
> drop.
> 
> Reduce the array declaration down to one flat aggregate init and let the
> code just step through. As a happy side-effect we can then also handle
> odd-number writes as the number of elements in the init sequence will no
> longer have to be evenly divisible.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Depeng Shao <quic_depengs@quicinc.com>
> Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
> Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> ---

A new version of this patch is required to ensure 7280 is handled

https://git.codelinaro.org/bryan.odonoghue/kernel/-/commit/4c831fd58aa7629f994b5f4d8533b154a74d35cc

---
bod

