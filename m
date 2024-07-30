Return-Path: <linux-kernel+bounces-266890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 031BA940913
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A094A1F2167C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0F218EFD5;
	Tue, 30 Jul 2024 07:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q+oyKM7U"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6083C54774
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 07:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722323352; cv=none; b=iJ3jxpr1Qm14F09wjAxHD2ez0rjxPXEAMIVtLYTytz1XMacQhXmEOHP5sHfVfatg66d4v2XPpIrZQ7w9dZZEbFRZoeFyqWK54CLqGl30XT0C/TNwyivdQ/Crjr7d2EWGnnNBZ58YUjy+uMt7Pu665ekqGPpIYP+C+Yy2+2NIWXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722323352; c=relaxed/simple;
	bh=aUXBVwEuXvr8ZvqtozeYi9Lu0ovEhgcBBeJw/0xKvnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aazTixN+zL9CgLjP6LLMo1Vp1Vl4HwfIe1wBnP8pFtB5I3V7fVzcDXsWQPC1/ZbxW8Aym+8+IRQ1rk4kU4itOM6PoyT2yDojvhM6OrnO8J7UaXCOsQurx9c1aoImoHK56LfEOUTgePE6E9RmVjtPhKPhmgzdhI+IfHuOCjtjZ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q+oyKM7U; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f0407330a3so7580871fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 00:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722323347; x=1722928147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lVMhYxj4qNnzwO4iqD+18Ai3QfZ1Axvw0kbd5FN9fVs=;
        b=Q+oyKM7U4B/GrfxqheftuquRC7eUPVm9NHH3PdgulVBGsCmyzMDGKbT27jSVQ0yQwx
         7SsQ5YNwu2sgkJhD/POc8jWqcgX5GvexiYukMMS9hCLMRHMOo5inb1UqOgId2Z/AA0UZ
         tek+LTDQ6IRYmYlxe37SwAKVpBXuPrbaaz+mK5hS1eyel5ppDkCuxuNoyhEg7q43gGnm
         N1jVRipxXr6z2nQlueOh6B6ZDU2mCZojCCz+UnHBs05UC4rfl2c3Z6c6G7dxtXzr93Cn
         by2XzwjtJPyt0LnRhZkowzZbmyP9X0TEQo5zIAJokHVmDrDXvMIMRzr3m1YMPGRQvprj
         Ocxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722323347; x=1722928147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lVMhYxj4qNnzwO4iqD+18Ai3QfZ1Axvw0kbd5FN9fVs=;
        b=unt/hTfZRmYIZtOmitCWOyKA5EWjYq15km1ifITOsCQx+LYzdlKbCdp2Dfxf52JGAM
         uAu+CONypSBX7bp5P4Rsd1i953Cfh0C38AtEbxlAEoQFjr1tJoSNhSZC7oS5hZh1qevk
         SliGEXtyofNeBkBCuK4clMD6GbpjIvFM3xdte6rdJchicY7bBA0ixQBFtb7Prk4Tc3Yz
         tqoJj9/jJ1mLki+/zhZLBsugU5OptIFgyjoAt+Q2TsbNA2A+a0D1gv1RlellZuqOofnO
         uuoPH9DDQ2WDACiaAf8Edn6rzRgmCWUq/xLPR/RskHaEBVhBPn2QZdfaDiSgdypPM3jv
         1HoA==
X-Forwarded-Encrypted: i=1; AJvYcCVm4xWoshYryx7WYegFB3sGIfv62jJetNRj6IwQ2SxnHOXuwaSuojEovhW/uWVfWuD3ndK2kvZLFwcxXCE2pq/4/mWNYrC9ZLfzjyYD
X-Gm-Message-State: AOJu0YyAVbzp+Yt4UT1bfXpOAAtbjZxOsS/RUAQmPqy1Wm/JmBfJA9n8
	D/GudfTS0/wCfleoy1/VxeRWmAjgE4+tXw0DKU0aP6HzHNbZQuUlWcath3VAKIs=
X-Google-Smtp-Source: AGHT+IFeNNsOEIsAWFdV4yWL2SghnTx8Z1eLwgdOiT5AgajQW3bsdyzMbPjzTwMNqrHkz03C42ZeVg==
X-Received: by 2002:a2e:7c02:0:b0:2ef:2e8f:73e9 with SMTP id 38308e7fff4ca-2f12ee1bd2dmr64461041fa.37.1722323346904;
        Tue, 30 Jul 2024 00:09:06 -0700 (PDT)
Received: from ?IPV6:2001:a61:137b:5001:be5a:c750:b487:ff1b? ([2001:a61:137b:5001:be5a:c750:b487:ff1b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5afb9422c41sm5153828a12.82.2024.07.30.00.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 00:09:06 -0700 (PDT)
Message-ID: <e72cc56a-3066-4cb8-848d-bfe27a48c095@suse.com>
Date: Tue, 30 Jul 2024 09:09:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: storage: ene_ub6250: Fix right shift warnings
To: Abhishek Tamboli <abhishektamboli9@gmail.com>, stern@rowland.harvard.edu
Cc: gregkh@linuxfoundation.org, usb-storage@lists.one-eyed-alien.net,
 linux-usb@vger.kernel.org, skhan@linuxfoundation.org,
 dan.carpenter@linaro.org, rbmarliere@gmail.com,
 linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20240729182348.451436-1-abhishektamboli9@gmail.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20240729182348.451436-1-abhishektamboli9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29.07.24 20:23, Abhishek Tamboli wrote:
> Change bl_len from u16 to u32 to accommodate the necessary bit shifts.

Hi,

while this patch is technically correct, it papers over the issue.
Could you please

1. use a constant, where a constant is used
2. use the macros for converting endianness

	Regards
		Oliver


