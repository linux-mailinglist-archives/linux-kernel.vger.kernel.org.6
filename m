Return-Path: <linux-kernel+bounces-332535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C410E97BAEF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 521621F22171
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219851836D9;
	Wed, 18 Sep 2024 10:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O41byaSe"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D8317C9B8
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 10:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726655667; cv=none; b=a65aXBKLcpLi07eWBBRlv8uJ5JSY4EJqy+1FZ+ePZK3KkjN0CEJxPLJ3P4knPa4OAnb1hEBtvtWzlwdcRsBM5RCf0dVGWkWkRjGibVTIZgvvohwY8wtWqbc0ihTkKV5kYaPoKinFozLWs4Uq0xtfSt+MZLeJ7+x1HMqAjCZrQxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726655667; c=relaxed/simple;
	bh=/O6DlyybLlXWfSWwnwV5RQBtFaKboK8lm6EQb8R2/cw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=V3Okexu7JW3ttPD1YihT6HgMcTH2dCh5EKbfGCkN6iJMuzGnsTiW8fMffh9hCNgSD2D3WzoMh7On6htq/9lC+evs9paOdRQ4KfL1SS9/Ia0umAZeT4f5qg/MINM0toSYSou4XWrmu20S3E+O+wV6U8A+Vigx1XfSlnXpsS9D8T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O41byaSe; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37747c1d928so3468292f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 03:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726655664; x=1727260464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yhv6au6+BMMuSCn4gH7YR+GWvforwWtmSXKV5oKbYG0=;
        b=O41byaSecUsiaNmh5Lato3q25FnUHC1gNM5C0IEB5qXKr4NZ4nxmczscpUGWfcTnkT
         0vdvc+FfrhiJrqqrAvpQH6xwalBxeM9dPHKbLxtpOvsu4CisOESi0gCIZhm85INbx+O1
         dscw4FOWEeZ23qjwHTgebEENpEoiWk5YHLqQu7bru+ZBVqWRZQn0i7Tu96lzK92WPwWy
         1cuzUTCYA8gPoC5SnS5m+A7jhF8x/vGUAri+YsIAh1eDiKZBYEQArSIv/CYFPSzeSIP4
         LtEExLlh5LFt9P4VhH3OZ9c8PUF1JokTIJYCljHh/VQJOwKqxPNjqvI1dJPTYRaa9dz6
         qXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726655664; x=1727260464;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yhv6au6+BMMuSCn4gH7YR+GWvforwWtmSXKV5oKbYG0=;
        b=ZljPAHylbP/YI+R97CIlcBMbxST3QuIFinMj2jPcZYhc44CLWZGFERBnrzZkzP5T2z
         yqkKv7RE2THwDTxMJ1ogSRHV/NWh9VI29WOzpRXBRBPCLPdWpBREssYqLhWnUEcNfTM5
         i/AgAleKRwFHeXfg/Nw63lq1sKsugDCNEW+FBHF8NMvKkyMIodWFwrq0rrV88bX1bG/U
         ri3QMdsTN82pwXL7BchfBhx7IHQmWp56Ccel5l671/Sfs1c25Z6j2e0UlYwh7o+nrlZy
         q2v7YrjjlcYtBFoLyTae+rFwAQcAtndAgRFcGkuFWdif4bGB5MO4o+t8mDEU5Yy214Zc
         jmmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL4Srn+4Stf6WdrOd7ZKtPrdCZb2hVU0KZFSWsdwAmR4itFHknqoJl0yr8IYFDXojbJc/WFVinqdX5+30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8axJVBwoYE+fOt02ltym/yWUQKEnwsXbmzF5PxCuAXqQ4stJU
	fAY+/FtE+ySm7TK8mDHkvLDFzio4UWJPXWynDsv8RvqXZ7zvWXuQUw1l0cwy7pI=
X-Google-Smtp-Source: AGHT+IEyqcWtBSDcanJ0r21CbblfIqL9+DPRLgNJ8aBlTro3Q2HnHsyj9xJ3yRk7ecOioh7AK4K7rQ==
X-Received: by 2002:adf:e891:0:b0:366:f8e7:d898 with SMTP id ffacd0b85a97d-378d625a40dmr9932285f8f.50.1726655663507;
        Wed, 18 Sep 2024 03:34:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:2782:e782:f1c:dcad? ([2a01:e0a:982:cbb0:2782:e782:f1c:dcad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780007dsm11989799f8f.82.2024.09.18.03.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 03:34:23 -0700 (PDT)
Message-ID: <d9e0ade6-8a7e-4ba4-974f-142ad246ce5d@linaro.org>
Date: Wed, 18 Sep 2024 12:34:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: drivers/spmi/spmi-pmic-arb.c:1782 spmi_pmic_arb_register_buses()
 error: uninitialized symbol 'ret'.
To: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev,
 Abel Vesa <abel.vesa@linaro.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
References: <67cf80cf-d96d-4249-ac34-6085d4b32948@suswa.mountain>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <67cf80cf-d96d-4249-ac34-6085d4b32948@suswa.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/09/2024 12:29, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   adfc3ded5c33d67e822525f95404ef0becb099b8
> commit: 9799873717398e8fa1727482e578b9d777da645e spmi: pmic-arb: Add multi bus support
> config: mips-randconfig-r072-20240916 (https://download.01.org/0day-ci/archive/20240916/202409162313.TnpH4qKB-lkp@intel.com/config)
> compiler: mips64-linux-gcc (GCC) 14.1.0
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202409162313.TnpH4qKB-lkp@intel.com/
> 
> smatch warnings:
> drivers/spmi/spmi-pmic-arb.c:1782 spmi_pmic_arb_register_buses() error: uninitialized symbol 'ret'.
> 
> vim +/ret +1782 drivers/spmi/spmi-pmic-arb.c
> 
> 9799873717398e8 Abel Vesa 2024-05-07  1762  static int spmi_pmic_arb_register_buses(struct spmi_pmic_arb *pmic_arb,
> 9799873717398e8 Abel Vesa 2024-05-07  1763  					struct platform_device *pdev)
> 9799873717398e8 Abel Vesa 2024-05-07  1764  {
> 9799873717398e8 Abel Vesa 2024-05-07  1765  	struct device *dev = &pdev->dev;
> 9799873717398e8 Abel Vesa 2024-05-07  1766  	struct device_node *node = dev->of_node;
> 9799873717398e8 Abel Vesa 2024-05-07  1767  	struct device_node *child;
> 9799873717398e8 Abel Vesa 2024-05-07  1768  	int ret;
> 9799873717398e8 Abel Vesa 2024-05-07  1769
> 9799873717398e8 Abel Vesa 2024-05-07  1770  	/* legacy mode doesn't provide child node for the bus */
> 9799873717398e8 Abel Vesa 2024-05-07  1771  	if (of_device_is_compatible(node, "qcom,spmi-pmic-arb"))
> 9799873717398e8 Abel Vesa 2024-05-07  1772  		return spmi_pmic_arb_bus_init(pdev, node, pmic_arb);
> 9799873717398e8 Abel Vesa 2024-05-07  1773
> 9799873717398e8 Abel Vesa 2024-05-07  1774  	for_each_available_child_of_node(node, child) {
> 9799873717398e8 Abel Vesa 2024-05-07  1775  		if (of_node_name_eq(child, "spmi")) {
> 9799873717398e8 Abel Vesa 2024-05-07  1776  			ret = spmi_pmic_arb_bus_init(pdev, child, pmic_arb);
> 9799873717398e8 Abel Vesa 2024-05-07  1777  			if (ret)
> 9799873717398e8 Abel Vesa 2024-05-07  1778  				return ret;
> 9799873717398e8 Abel Vesa 2024-05-07  1779  		}
> 9799873717398e8 Abel Vesa 2024-05-07  1780  	}
> 9799873717398e8 Abel Vesa 2024-05-07  1781
> 9799873717398e8 Abel Vesa 2024-05-07 @1782  	return ret;
> 
> Is it possible to not have an spmi node?

It's possible but not allowed per the bindings.

Neil

> 
> 9799873717398e8 Abel Vesa 2024-05-07  1783  }
> 


