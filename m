Return-Path: <linux-kernel+bounces-399570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DC69C00E6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FB031F22EA2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576171DFDB9;
	Thu,  7 Nov 2024 09:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmxDtRpw"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B509194ACF;
	Thu,  7 Nov 2024 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730970848; cv=none; b=SgvIAZH57fK4AXEPbRFPsFm3/kUfSSKVCWW1Zccy59JIoRYGmv2IuFa++tajxpFaHJlODDm7uG0KTNP5uUm1V1+cmUdnDvasVc+d5rICIOaYqxyeFkE0AkxZed6Pm4EkXK7wt57cn2sJqsM+6kNMS2WqxT1M2Mtf9YS/6kjYK8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730970848; c=relaxed/simple;
	bh=6tAAux1lly/TI0vCOujAeTNBXuv3W0q6Y48vNZZo7PE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Df6MAD7HFExZjGkzK3Cl/cNQ1TOEMqIyNiJFlvfTQWKAtVNEJKkrJjJ03C/0OCWjjwkRJJXypev3t64qBEPerBlheQcAdtZZedQSEPKVPToI08MnYlrWgIBaJf+HR7TyiCLSlViY52gt+iH10+FSFkhnDxLDgoVvPWwIQFcBAOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmxDtRpw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43169902057so6010045e9.0;
        Thu, 07 Nov 2024 01:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730970845; x=1731575645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dZJoYWgKwwmsJWfb2QT5nT8hw1PQ+BpTzyZIvvtju0M=;
        b=WmxDtRpwCw36SYYIqFsIkh9MR79ZAbr3twlZtpoMp7B+D6EsWJCTZsul8IFbJ+zNr0
         Mk9gt+suZ9R7a7ICliFaEAOdW+Z4QRGISUcWHGTOXpBgyFADNtP893ZvdFwV+bn/taiC
         vhEdu5pmKV/OUDnLmf4ukCqXPIK2ED3+L8gvtCZHl3OU+qw+gWDr7OMmP1ZO2scz+IuL
         bTmjnlwltDlulUYv9HFTCiKX0X6vV2F9FbqdktgQfKBogKXeW+vMX95gPc03RMXhVFfo
         AHJilx4m7gU0txFxpPoZdyB85/kiwsQ6vYECGjadtnt3oeE+gtptf6H9mD5cXT1D7knL
         Yq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730970845; x=1731575645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dZJoYWgKwwmsJWfb2QT5nT8hw1PQ+BpTzyZIvvtju0M=;
        b=o+cDUXtaPYXZDZ6xeAxfSsIN209VGoXu15VhEH+fb13sXlPQIWk883DZT0Vn2kwZTr
         D2xeWIJV5ZIA5h5aLjOWa+jM94qebggKgdfcpRJ0o1wDEsUIq+Cm5fAm23XhkE6NhFi0
         l2lx+OT/jo9hcG64X+7zyyuKTYLCUMbz3rjaUXg2SaPhcSEXTF4RzSYS3UuNvFSW1i7y
         nSG3DTxI3Zx+dNh1xV/XZai51YB4QgdlNMP+fXcTPSeK8cV857J5t7zyPJiu+CXSbrUS
         cDFdFiIimCPiNnFnP8sZiJZHOqIVkcuiMW+prL/sbam9bXfU2YnjzIJ4h77uTIljBHnU
         gu9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpGDZ7MVgPxYgkaWBk/RxJFUanY+74DSvSplwGDgBbMQJpIMinPqO2JlJaQS/p+1B9LTLtOm8V6h7LQ5qYc4Q=@vger.kernel.org, AJvYcCWUyswMmWBoyWx1LXiixrlZr+QEIMCLoHS2M+ucN8Yv+hjeFuehkIeXaUoSQrgEoiQhDJuJzguZ9L4Zy9lS@vger.kernel.org
X-Gm-Message-State: AOJu0YwDHgEQNPCcPZ5sTAouLCTjoGxvlEVt89kmkB3jz7JE4zbRZx41
	KCnr/ZUfrBBfdzzDdLc3FumvvQ03NBhScxCAPZQqwf7IP4EPLSbl
X-Google-Smtp-Source: AGHT+IFIm9AGuKcLross5xfua6rDaxLhOzo2CvrTnh1BEbODgP6JuCFF8fGOgbf6qFgkkCVJPvePpg==
X-Received: by 2002:a05:600c:35c7:b0:431:5459:33c2 with SMTP id 5b1f17b1804b1-432b301e8e3mr5531435e9.17.1730970845467;
        Thu, 07 Nov 2024 01:14:05 -0800 (PST)
Received: from [192.168.1.248] ([194.120.133.65])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-381ed97f544sm1171452f8f.40.2024.11.07.01.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 01:14:05 -0800 (PST)
Message-ID: <f8fa71b8-05c9-4f1a-92fd-e72a8a2d34eb@gmail.com>
Date: Thu, 7 Nov 2024 09:14:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] fs/9p: remove redundant variable ret
To: Dominique Martinet <asmadeus@codewreck.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241106152209.1626630-1-colin.i.king@gmail.com>
 <23a44a2f-2a99-47a7-a446-d96b5adf62ec@suswa.mountain>
 <ZyvzuHBSyfI63CT0@codewreck.org>
Content-Language: en-US
From: "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <ZyvzuHBSyfI63CT0@codewreck.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/11/2024 22:54, Dominique Martinet wrote:
> Dan Carpenter wrote on Thu, Nov 07, 2024 at 12:45:33AM +0300:
>> On Wed, Nov 06, 2024 at 03:22:09PM +0000, Colin Ian King wrote:
>>> The assignments and return checks on ret are redundant. Clean up
>>> the code by just returning the return value from the call to
>>> v9fs_init_inode_cache.
>> [...]
>>
>> Better to delete the whole function and call v9fs_init_inode_cache()
>> directly.
> 
> Makes sense, and if we go there delete v9fs_cache_unregister as well so
> the init/destroy pair properly; that also is a single function call.
> 
> Thanks!
OK, will do.

Colin

