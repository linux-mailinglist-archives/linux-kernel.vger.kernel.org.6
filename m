Return-Path: <linux-kernel+bounces-314672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AD696B70A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 927D2B2ADB4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F071CCED1;
	Wed,  4 Sep 2024 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k51qikJc"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027A01CCED0
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 09:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725442120; cv=none; b=sf7HSDtUWhQ/31teW+w0yfXlMN6jXx7gJPPSmjxTeeviP+IBb7qaboQF8EnNcAt8KpYWcVGuAqxwY93UNAVe0VBUMct9bOkOFooCubhLTeWczEbpb/oqIUKVqcjeioW4rfFXiCo5/Vq6HtfgqOfNy8/uq3G3ZWWogJ4wDMLje/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725442120; c=relaxed/simple;
	bh=SGrjCCtQW4ZdmFMOR4QedGcj3VyM4JSDKs1/b25Au6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QCQUlBy+ZTjwe/1AhKJ/fC7XVcPr08vh8bJ79IU8j4PZhIVSQpY0o/pyZSiHYC8YXYCovupCJNJVN9ktjS5lM8DG+nJngktCRWJvF7sceOxuDf2NYs39z1ErrtZUALshuH3G126o/hPLLjGbLgFsLJiyYe+G6OrYsn2m4HM70GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k51qikJc; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5334879ba28so8725449e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 02:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725442117; x=1726046917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xuq/cYf8+71Qm9h4676C8ljwN2DXNbLAaqL8sBoWxfU=;
        b=k51qikJcjws5Iq+l6qAAxieFZvVepH8HYv+or2seaBH40ji5kdyQ6HJF6u4nJZqa7P
         UCTxj2FndujwC5UVwL9dRdHTHIHBWRhvYDSA8S2Qe5Ko3/sc8nTbPDFoP4L90AHfYCq9
         MjqqiGr9tKGYqyOT0VQbXGTWArHXmKMyeeirZFbwAnS989FejUL8tcwkjRE68w1kqL8j
         2zsvi6cODN3g2VOPdI2GN4VyI3hpgBJZAb7DZU+M1JsFxArTO+Rh3ezzR+xiMPnd5CXh
         rBQPN3zo4GrLk54yKCENUIIE6xsLrcuRWSWrQNFwfy85QJojV9/GGB1aFyEHJelFSxD5
         LYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725442117; x=1726046917;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xuq/cYf8+71Qm9h4676C8ljwN2DXNbLAaqL8sBoWxfU=;
        b=UIFAFaBIkazFvrDUDTzI8FswTCAQSA4hkBQDwPksCBtdJTzjLhiA7cawv4hOfpxb/R
         S1iLuS0yvAcihAYtCxkoUtmPVJC+E0MVb+5EgOPyW1Vfe1AKjm0dzQOLEmtex8BzPOFj
         MpycN8j2DtyqhGKHuUOBY21Oyz0shVakx2+v3xsGuDVLYU3n09g54OWmCaqXtepYPeYd
         7wndQOalFo5klOdsc026vckPrAngy9nygy6gx+SBA/JCD7hV8mYWZgKNxPau1XQwr0hW
         sph47VZoG6WUo60wbiSEB+vRK6eBOzt3b63hwDlNANKpqEzUekphvD+MdqIIEopWCI+p
         3qgQ==
X-Gm-Message-State: AOJu0YwjpsPnWUKkH4D0UwTdPf168VEAZngkxtLu976jWwAeeG5sjDzq
	OZ26T37AC5DP3m3qmK6w+FsrP414qsXjhQFu/V1yY/n9CMcfqK1mx+S2ORTpKYA=
X-Google-Smtp-Source: AGHT+IE2duZdsTgB5bwxuXGiYe/YCnbsFxat+800LtjisZGn1xrJhdX8Dw8rX1FIpkF/8bCDA2G5Kw==
X-Received: by 2002:a05:6512:3352:b0:535:6992:f2cb with SMTP id 2adb3069b0e04-5356992f407mr628693e87.42.1725442116986;
        Wed, 04 Sep 2024 02:28:36 -0700 (PDT)
Received: from [192.168.68.116] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a898919670asm794444066b.140.2024.09.04.02.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 02:28:36 -0700 (PDT)
Message-ID: <679cfd5b-42fb-49c5-833d-05cca34b4ecb@linaro.org>
Date: Wed, 4 Sep 2024 10:28:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: duplicate patch in the fastrpc tree
To: Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>,
 Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240904153713.4dc28982@canb.auug.org.au>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20240904153713.4dc28982@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Stephen,

On 04/09/2024 06:37, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in the char-misc.current tree as a different
> commit (but the same patch):
> 
>    b056e4e23acb ("misc: fastrpc: Fix double free of 'buf' in error path")
> 
> This is commit
> 
>    e8c276d4dc0e ("misc: fastrpc: Fix double free of 'buf' in error path")
> 
> in the char-misc.current tree.

This is fixed now along with slimbus and nvmem tree.

--srini
> 

