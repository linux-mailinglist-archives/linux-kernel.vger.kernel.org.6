Return-Path: <linux-kernel+bounces-249776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F51492EFA8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04254B212ED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF77C15CD74;
	Thu, 11 Jul 2024 19:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Feq61t24"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A168E2F43
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 19:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720726238; cv=none; b=DJEbC7AmAsyCgw+xaVZGrtCtz1SSiJG/JezEpA59K+uhH8c6D4qKRZX+MkVKnnrSGbaJYeqQXrJtGYmkwXwtzuwE8ry5blt4pEv9k99c+vy060TS670FeyHdXibsbRgG30XMaG0ISGsMnEMuefrZSqRm1Tf2P/lEfXdjK9v7HKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720726238; c=relaxed/simple;
	bh=jIq9DB4+HfVVvk3niKjex6l7F/Vrr+uaMChFa8uTTmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BeSHXjBrx0tL8GPHSfMsuuf63ubnb7pRGyeRQub+D3dhVs2BN9ysezwGuP9hV7SpIzFAT1MEh94jc+PaGvIXueGrODaiM+hNLLuTUnGrTI6gcPOIXsPhsC2P0VPitGO4UqOtcelGyFZFWH3+xsGWbLHaw/GDlB755kT6V2TEdVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Feq61t24; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-380f2c58838so710365ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 12:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720726235; x=1721331035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jIq9DB4+HfVVvk3niKjex6l7F/Vrr+uaMChFa8uTTmA=;
        b=Feq61t24WTab4I8n5jOVQA6xUi/85OMzabYwywzU+El922r++Bi85Hy+g0ko9Dt9Zd
         ICrGVxt1yuFK7kqDldNGOWgKrFHGyNYxgDIrZiJwhIfRGIdtf+4p+Y0DnZ6P1R7DlZi4
         mJoUD52LiK5yj+cgZ2lY9b4TQ4bBqOlUL8vQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720726235; x=1721331035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jIq9DB4+HfVVvk3niKjex6l7F/Vrr+uaMChFa8uTTmA=;
        b=Z1dGvApI3NxhwVrWKA3nMOqFzIvHWpQwCD36pNon1TvFpJH9WFHEvRJ6wC7mrbEDBd
         dKCRZu36cvDb+hfxl9KLUW2l1CyR/mw9l4PZPsC/m3LJoS3FDfhq98z/0eHFwFsXQlnf
         8y1ZRyFliowNIvcYHvr8BoWBjuLK3nBBrK7jjTFEuYePuqK/SodxZQ3kwftptVLSShFA
         5U42IrRAhKhSol0gT+fxXCxQuqRWd1jspw6cDJHTaUT/ZwPd29D1RDDjZ28JMvCCdL79
         Kel2u4GNyjR5o/fMxERB3ST03ZpWxT5Zg+roKpIjiJQpel6Wb5k2rwaOO7I25K+zjT3n
         EU2g==
X-Gm-Message-State: AOJu0YwKvhixyBz0SAdQpRGJSDwf6TtIUfQawXNSRN2BJZUNIUeK1VFC
	AL7gPzQ5q+Br7z2pgGatMgacHwD2Lj+Pfu5bZLr2nudt02iDw5aUJVArXwG4icA=
X-Google-Smtp-Source: AGHT+IEuugBUOtbPCwdOAl0sTv1M6tMnWa1RAQa6RETYXBN+nLRRupftab2+A8OSzisRPDSDiUOOgg==
X-Received: by 2002:a05:6602:8d1:b0:7f9:90c5:4107 with SMTP id ca18e2360f4ac-806e190589dmr373773739f.1.1720726235641;
        Thu, 11 Jul 2024 12:30:35 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7ffea7571cdsm204809539f.32.2024.07.11.12.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 12:30:35 -0700 (PDT)
Message-ID: <fffc4793-e2ff-4e90-96b0-b37e02848bec@linuxfoundation.org>
Date: Thu, 11 Jul 2024 13:30:34 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] add tests to verify IFS (In Field Scan) driver
 functionality
To: "Joseph, Jithu" <jithu.joseph@intel.com>,
 Pengfei Xu <pengfei.xu@intel.com>, shuah@kernel.org,
 linux-kselftest <linux-kselftest@vger.kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ashok.raj@intel.com,
 sathyanarayanan.kuppuswamy@intel.com, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1717137348.git.pengfei.xu@intel.com>
 <097e26f1-bf30-43ab-a65b-25a3062f92d5@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <097e26f1-bf30-43ab-a65b-25a3062f92d5@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/24 19:42, Joseph, Jithu wrote:
> Acked-by: Jithu Joseph<jithu.joseph@intel.com>

Applied to linux-kselftest next for Linux 6.11-rc1.

thanks,
-- Shuah

