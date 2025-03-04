Return-Path: <linux-kernel+bounces-544709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FD2A4E432
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0262819C4A8B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE4F265CB7;
	Tue,  4 Mar 2025 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f0qihsw6"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826FD204C22
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102204; cv=none; b=huIEOZ9XPCE4gquWnfeCjusKHJqurcK5of3U6xt9PLxsONmi/EpubeRxCyU4cmUv6ycdV1fmS9DTOvqV0R6Oj9jcn4Grj6WPSEU67lblMqOrGxUBTtW89N9cCqjqM8tUzxc7HwXOt10cXcW1Dn3arwuwmlttrLpzm4pflpm098Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102204; c=relaxed/simple;
	bh=DvT37mlLylWirMmvziApQyMOyXFz2tPHw47pSw/2Ns0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGJMNk/T12RjIyVSMISzQBAKaiuhCoiU9/WlZIEdgoF6n8CzPTt2+63UjsCnmhz2SOcpVeh1WWAhejS9UsPo01v2nXqn/M+eu9z7P5WgIwn1PwHWkmYW+4Mp0a/O3guedn5d3alExO9s3bcJG58jFkhTClZ6dIPVOWSXu1x3Uqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f0qihsw6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2234bec7192so97299865ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 07:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741102202; x=1741707002; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=66psdEYIrVGR86JKMR8+mqBEFxkGfgmcukM2sBzapxc=;
        b=f0qihsw6h6E1twiuVjL+pwN2kHj+/eIdoqLQS/bM5Pu1Rcst++qQvUyQnyW4fIl3Fw
         XHmrKq6oSDnN+xGBU+RPFbDbngaZY06NTdSdDc8lixsezuXDonsQtMs1DGPVU1+5o06U
         geZyewK6D+0sAxdjsYLg23YV+TA2kHt7sp/cAAWt0tKecJxorvOrQFJpAWJlOX6rGtXT
         aiRCAFZPNplSmEsb20L7Yjy3Oy5aNa4dIG6QvrRILp33DAlP208t+V8sni5oafxqCkrI
         KowpbOlG9gjuYfBw6xi5OHCkdKYAOqnd31j/Smi9wHgI5RTMl4TKXW0BpSlgeTgElKoe
         wKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102202; x=1741707002;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=66psdEYIrVGR86JKMR8+mqBEFxkGfgmcukM2sBzapxc=;
        b=oO5Jsv2TAvFaBkcfwBLTo01uA7LDN9e5YaUXXw+m/YgHMVAIG3H7s1JtMKAdT01nOD
         6or5MCwGQjUQNjv4O59ZDyITnyMaZdtV5xjTtqKW/sWRU75qlGW86hS5N43khyBl+KsL
         ky/ngbbimvBbWPkfdSts2ImgTLdO9huIzRYQABgD7iDkXVmmlWCLM0k1MGj0+Jt0WPYb
         zEWA6LJsvCfZxFxAL1RdoIc7HaXH6iAvS5E7eHoeOFMiQdV+GgoGZPeN9qWi0iZcfA/c
         I9+bn1BkZ8kGxzo06VLpkL0wNfxaOnq4JSAVTJtgN+cIRe5d1pHRdiMt4b5NUWCe9WZe
         WTXw==
X-Forwarded-Encrypted: i=1; AJvYcCWh4+Tsrydq97l+YEO+svc/0Zjue6IWi3A9cyUt+7QJ+pF7zOuiguObU7L0iICjXrGJx9rZLpHE39tooRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzALWIQhXSibNUGpsmkxflcXj+FhzFL27FZbAdz3NTgWiCFBGUV
	38/CEesUWDAP7HZ4cDzm8u2Ivw370ECTchceQo+9//VVWN83ZEVf8yavZwZhlQ==
X-Gm-Gg: ASbGnctpmNlYqtYasQ79Urgd69GAg3TCv5ZY4wCpsVWbUGMWi75HvKHRsOIamcdO88c
	Lll4FazZ+HCZPzTFgEbBj04+6DJ6up8T3v+N7miuhrnvKJhaiI8++zQh04JV6V/D0oUAvta1Gxz
	Ksq6jKjGmPkgxVzPbEGdYf3X3DS+sTIK0sFs23UwKIUbs3ALfFb2i6IUBaUQrkiCJ3nB9Jeq+/j
	FHXz3FRAZrvKkFKjSdZBEwpMnmPjyA5by99yA3OSZJGMJuli92rl8rMMCkoZaLy3kDqPLSzWozR
	X+AANEu8JMI6saZyhjctpARJA3BA7Np33iOfwnkVLbMbDnfgSNusNUs=
X-Google-Smtp-Source: AGHT+IHDLoudvsE8ThGCBDtv8xpmDC4PMrV1KRLn9yaD488OmdYvS42vvygcsTzqkS+txl9sTFzPNQ==
X-Received: by 2002:a05:6a20:7348:b0:1ee:be88:f5cf with SMTP id adf61e73a8af0-1f2f4e00bfbmr34435609637.32.1741102202650;
        Tue, 04 Mar 2025 07:30:02 -0800 (PST)
Received: from thinkpad ([120.60.51.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de38003sm10265993a12.33.2025.03.04.07.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:30:01 -0800 (PST)
Date: Tue, 4 Mar 2025 20:59:52 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Shradha Todi <shradha.t@samsung.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, lpieralisi@kernel.org,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
	nifan.cxl@gmail.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, cassel@kernel.org, 18255117159@163.com,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	will@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v7 4/5] Add debugfs based error injection support in DWC
Message-ID: <20250304152952.pal66goo2dwegevh@thinkpad>
References: <20250221131548.59616-1-shradha.t@samsung.com>
 <CGME20250221132039epcas5p31913eab0acec1eb5e7874897a084c725@epcas5p3.samsung.com>
 <20250221131548.59616-5-shradha.t@samsung.com>
 <20250303095200.GB1065658@rocinante>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250303095200.GB1065658@rocinante>

On Mon, Mar 03, 2025 at 06:52:00PM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> [...]
> > +		29) Generates duplicate TLPs - duplicate_dllp
> > +		30) Generates Nullified TLPs - nullified_tlp
> 
> Would the above field called "duplicate_dllp" for duplicate TLPs be
> a potential typo?  Perhaps this should be called "duplicate_tlp"?
> 

Looks like a typo. As per Synopsys documentation, there is only 'duplicate TLP'
field.

Good catch!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

