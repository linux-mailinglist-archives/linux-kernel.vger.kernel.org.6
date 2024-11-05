Return-Path: <linux-kernel+bounces-395699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3154E9BC1CC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 01:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D87471F232E4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 00:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A1D1367;
	Tue,  5 Nov 2024 00:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E9ZjvzUR"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EDB195
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 00:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730765271; cv=none; b=N1JAW59ZsVZ0gGdDVC7XhY8Zo3Y37VcnQWwbkeTvwQEM9A8mADug5xoIskc4sbkubuDqpPHbTb2FdKA4+yZwyH8DAUk0WYxnVOS8OBwRn2v+rIdMDD5d59KSd9clNqymQdlTsd+RzvRS4hiMLYzmTS7ftlFWsjzhdHv3Qw8y4kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730765271; c=relaxed/simple;
	bh=+/hby0KJ3mELyIs66mVASGTlrbviMNwAxD79AxO1uTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qKAO15umgqlmS2VRBnSRhYAlTam6Nec9abxUhYgPQrxShxIMDrcWddzwu6m6fqIE1/bJRGmntys6TonNe6wwZUV//vXyPMlR5aojf4ErUmgRTZySO2w9Wd5THgkgUb3jSxyIIZg4BohzF/zeJVni4HTCPBD2G659FafFI00xytQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E9ZjvzUR; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-83b430a4cfdso232837239f.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 16:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730765269; x=1731370069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v4n3zOONA1XG+FeGWTbMwFbRYJOOknBuCqD+89hTy9Y=;
        b=E9ZjvzURSJozL1AcQjOjJ/j+HeHn4D46joxh2wAmceIZANyLEEhc1n+wVMPILBU9fE
         KssHfXpVAx8S2PpDX/Yn6HTzkTrpLkvqaaIhJ4CwEhjYvLH/CvXlfEf9nyv6HUoGmjEl
         pQuPz04PTGmPE9njMuN4fpZYjZCBZnXLO7Qgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730765269; x=1731370069;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v4n3zOONA1XG+FeGWTbMwFbRYJOOknBuCqD+89hTy9Y=;
        b=Dzu+Ne+nVWWFypIQLTWE5bhZW2EhG05TTKnfMiOCUrolWfom3NHumHTJVes0Sh7ja8
         mBufI37B10MrUws/g+h2hYXt0laQsGzAG34Ew51UYBQ2/4UEgh912ZjIkAltOdbF4/O0
         F9w20CtOQKDz0BlVgTRjxpDM/m6bM1NDj2XcZMCHp+GYDhNWZ6vSS60aSFp6q+vdLwBf
         prfIdzZIgtJgP6McMUIQN9bdA0H2pcVC6zhQvNXNihISDCQjhZJAtqYytFYmQR70U1JJ
         ppz6AzUyM47MOKl7AumU88Zu+dLu5IgQ2/6mYHhvNTY7lVnbp+aTSFrHUP48eAXnsuNz
         Qasg==
X-Forwarded-Encrypted: i=1; AJvYcCWC6cf9R2MNSHRQe9GGm/zGSLKpTD406j7IqIg2e/E5lZTfck6sg1rXnieZFRvpE7wDxIqEYHK7Wp4xBSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLDmL70A1sY2pQH+3NsJb4tNTA79Ev4P/RIjVdwhKWRAU7gqvQ
	ucVjD2+jE9b8PzlhzaRDCwmaUSgHa5GgiW3fKEIbgXUpxrGWlaK9E3Yidkwb5kc=
X-Google-Smtp-Source: AGHT+IGqCTVTX932JUL/uBkEMT98/t8/6DJqYlEVSP6HPj/UjrLQ6NVQLz/bZ5Jija2XbsXkBEeVwQ==
X-Received: by 2002:a05:6602:3fd1:b0:83a:931a:13a0 with SMTP id ca18e2360f4ac-83b1c41289dmr3764682139f.8.1730765268840;
        Mon, 04 Nov 2024 16:07:48 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de048be955sm2161087173.50.2024.11.04.16.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 16:07:48 -0800 (PST)
Message-ID: <c69d23f7-0c50-4f8a-b146-c76bc6f4291c@linuxfoundation.org>
Date: Mon, 4 Nov 2024 17:07:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 00/15] selftests/resctrl: Support diverse platforms
 with MBM and MBA tests
To: Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
 shuah@kernel.org, tony.luck@intel.com, peternewman@google.com,
 babu.moger@amd.com, ilpo.jarvinen@linux.intel.com
Cc: maciej.wieczor-retman@intel.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1729804024.git.reinette.chatre@intel.com>
 <aa643c9b-8ce5-4cb1-98f6-645224aafdf8@linuxfoundation.org>
 <5b2b54b8-77fa-4ef9-aa08-549cab91eb32@intel.com>
 <3ba7cd24-a68b-4996-8b36-dbf3164db8f0@linuxfoundation.org>
 <10d28348-9946-40ef-9e7d-be0adff3ff14@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <10d28348-9946-40ef-9e7d-be0adff3ff14@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/24 16:14, Reinette Chatre wrote:
> 
> 
> On 11/4/24 2:28 PM, Shuah Khan wrote:
>> On 11/4/24 15:16, Reinette Chatre wrote:
>>> Hi Shuah,
>>>
>>> On 10/24/24 3:36 PM, Shuah Khan wrote:
>>>> On 10/24/24 15:18, Reinette Chatre wrote:
>>>>
>>>> Is this patch series ready to be applied?
>>>>
>>>
>>> It is now ready after receiving anticipated tags. Could you please consider it for inclusion?
>>>
>>
>> yes. I will apply the series for the next release.
>>
> 
> Thank you very much Shuah.
> 
> Reinette

Applied to linux-kselftest next for Linux 6.13-rc1.

Tested on my system and worked fine.

thanks,
-- Shuah

