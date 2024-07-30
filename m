Return-Path: <linux-kernel+bounces-268225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A08DC9421ED
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D25C61C240FB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB14B18E024;
	Tue, 30 Jul 2024 20:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XOqPEddU"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A7018DF68
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 20:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722373191; cv=none; b=S5zv5kf8n4+DEbHptO3ImJS54DURDzUTd30mpWRFFSm/UHG6lQ719WH5VKuMUT6R/nICVfC7/0w4eALg9BbnjVo203Rg4EMwm92M+9pV21heRIdCsOGjjL/pFAXxmLtL7pnEonqHrJPrRG5ENbInCF+31671/GTxTVP2vsa3gs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722373191; c=relaxed/simple;
	bh=Rpnfp00xfPTWyxn1g/3uIW3ZpbsDnsff7qomylYe5lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KwBeVVyVfz2k1haz+XUEYuAa8jp+hEQ4slL38cX0E5LKxrnVKmVx5AlSdFQB+bl55LoAuMLPk6wVpzu40oFEcryE9NCjIsiy27XH03lkDC7Jv2P7MtOgCiPX2dKcsM3U8FtRAUflgyjrDthF7eGyEIGosavHX9we0r2g6KyBHr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XOqPEddU; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-81f8add99b6so26454439f.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 13:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722373188; x=1722977988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vvfSMGLDwVal7HDi2rHRI6rmGo9DD4NGmTwc2V7ATHM=;
        b=XOqPEddUohUuYUoT4pq2lW5gmAjqui0pjLvLDo1r/W9uRaqx7udpvRtxXgAWAMjesr
         BPZ4C2vD2rFlPmJVwIOl+kN2Orwr5J2ptLIpGogmHkiz8iD2DKqYk/3v/0Z6HPWLGjg5
         c9uQuvS+CubNUmH4LoMPJUJYN2sSU7TtvgF0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722373188; x=1722977988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vvfSMGLDwVal7HDi2rHRI6rmGo9DD4NGmTwc2V7ATHM=;
        b=LcJ+6/L2+AtwMc1FTVVtJIY2Ed2DOjjInuEs6CsojObufqX8xQI9UYCK3jHxi+mCik
         o8clVxcFzKWuhHEjqGXmhzZ+k8d9blQl6lIw8qBgQed0Pz2Ta5PAnkDnme/LrxfZ2AwN
         dnDuepy4jR34g54MFuhAls/o168930ZaCvmPXHvM65ZGiwJmgYvhEUsDa00wfRaYy1O0
         jintxviTOVFMUnzstDZk3iRMutkQLTb/LGvwM33jJ9fY81tB6z7PJqpch4lYuY0QOie4
         q6QU/l+pBucLD5f0E2+JNfOgOULMMzJcL0OTdvfhphozpcDEnsvdQMbHpX2WD+UbYD9E
         Mc/w==
X-Forwarded-Encrypted: i=1; AJvYcCVzzL9TBW8hTfWFEHQAjbC2mRk3hWvtTQg03l92v+zTi7biXvEsFpU+GLFhQrX2BCqK73q44yjehV3tDFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtE/dkFIRZ85ESMisjxia/pY7tHL1bQhOOJbED20Fl0Sbr5Cf1
	kpWuBJI3teDDLM6a4v1PP15QwrOGTV02/nswVYRxxBdMDh60ummme7z8v6AndJQ=
X-Google-Smtp-Source: AGHT+IGU6jaGqNkJim01ZwIH04fmf59qPO2I9OG/k2EjYG9u32i+V2Q3VFZoWqo6SZyZGyMey3G1lw==
X-Received: by 2002:a05:6e02:1fcf:b0:381:c5f0:20d5 with SMTP id e9e14a558f8ab-39a22c4add5mr125507425ab.0.1722373188542;
        Tue, 30 Jul 2024 13:59:48 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39ae9aa98bfsm38112125ab.81.2024.07.30.13.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 13:59:48 -0700 (PDT)
Message-ID: <ab271d7f-f495-4853-813e-10972cbff45d@linuxfoundation.org>
Date: Tue, 30 Jul 2024 14:59:47 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] selftest: drivers: Add support its msi hwirq checking
To: Joseph Jang <jjang@nvidia.com>, shuah@kernel.org, mochs@nvidia.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Bjorn Helgaas <bjorn@helgaas.com>
Cc: linux-tegra@vger.kernel.org,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240530012727.324611-1-jjang@nvidia.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240530012727.324611-1-jjang@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/24 19:27, Joseph Jang wrote:
> In order to validate ITS-MSI hwirq entry in the /proc/interrupts, we
> have created a shell script to check is there any duplicated ITS-MSI
> hwirq entry.
> 
> Joseph Jang (1):
>    selftest: drivers: Add support its msi hwirq checking
> 
>   tools/testing/selftests/drivers/irq/Makefile  |  5 +++++
>   .../selftests/drivers/irq/its-msi-irq-test.sh | 20 +++++++++++++++++++
>   2 files changed, 25 insertions(+)
>   create mode 100644 tools/testing/selftests/drivers/irq/Makefile
>   create mode 100755 tools/testing/selftests/drivers/irq/its-msi-irq-test.sh
> 

Sorry for the delay on this. It has gotten lost in my Inbox.
Since this is related to PCIe and MSI, I would like PCIe
maintainers to review this first.

Adding Bjorn Helgaas and linux-pci@vger.kernel.org list

Bjorn, please review - I can take this through kselftest
tree once I get your okay.

thanks,
-- Shuah



