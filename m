Return-Path: <linux-kernel+bounces-234605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B4C91C88A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95DC1C22502
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE0A80023;
	Fri, 28 Jun 2024 21:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OUEkaevm"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5A17E56B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719611400; cv=none; b=TPeO5iFQcl7DYmKwTHEvwIz5Ch6y8+4RwU1AjQBfIrORFhRIeqjyIcIz4361HTAjZnGowoCmrj+jzPBs4FAqDPUZjtSXUx6tS44j4fe225n7CScvHxN/USDDVvK5iK1kYioTABeZFrVIR042b8NBJtfVKcPStO9n6IwOZ76Kong=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719611400; c=relaxed/simple;
	bh=Mhcw8dQaw95Pc6+sf7N/ghWDxBkX67de3Yl1cdzhkII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BNLB2/gGYNwa0CaIcy4xg0eP3k0+9CqdlqaTCE+zq/7PRSVOWIrpDo9fst8EMW8qvxfQ6kZae0Vgk/o/dj61Ov2xvhsj2/rgzzjjVfe8ZtMz3Wj+rvj+yKsqHXddq49W8SWKs94JU6hpgiIxe77mvJ0N0kmaqEiE0DItf3p2h5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OUEkaevm; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-375df7da74cso640135ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 14:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719611398; x=1720216198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lOPDDVwK5vwajC7/NBhsDpQNatLDyfxhDEgsEgFJfxk=;
        b=OUEkaevm6VTFx0BxDK1tx7qVP2ZhN8P4YhPr6U7LVCwkt54fDZR1Rdg0QJ/Y6ZG9XO
         EHNmBRl/P/x7GwDGQm/bt7wUn05qGLBDbJO6ouSsCNtJyB++2s32jwAtdBoDPSfKG2dZ
         4F5dxzdVlSroFxeLSacbwpwMJHFtZvAQW4R3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719611398; x=1720216198;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lOPDDVwK5vwajC7/NBhsDpQNatLDyfxhDEgsEgFJfxk=;
        b=sH0MX6IMyM938jIQJHFT9t4uaU4ZfDHtKSUVjyrP3HPoTZsh2V7Z97uDh5/Nu9rFcy
         kdVdGHnVWTqaaevISJLG2VVxXl5P9OV1Jxc3vxQgDctXFbkW/BPBBenhlVP29kGiUawa
         1eimlxc5xO+tivIKSVYguJE9SdoQJ7MkyCQ9IQSisHlw+uYaMz4CKkBCrT8OG+1kCiwo
         ME+ll0Xt3E4RAK7Mtb1dnzxpbKNb3RDFfuqgvsoFcj3V37385Jz13EAmXLm/dha4ArzF
         JpJrRmW+CQFJ0n60LVU/W3Vee6h3LxhuqcNrnh8c88ZjcnoBYwrxlE9pT6S5VeVqJceR
         H9Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXf0WpunJ0F57eJQYykysdqxQI3QV1A0wqgMw2li2sG7twjeHKXygXNSLUSCNpyliRq7vVVS+yL2OENIX05JbOOXZTTWHz0y03yju3O
X-Gm-Message-State: AOJu0YwOA/VB8kPZVqn21gO9UR6nK+qcZDVOhsxNnDSfswXgwXFt6DWn
	vPWDSwhPYM6FeoKVAj3OtgjRwK5YFFhqbQiwDRK4SL12svbZ+kOR2z5XNaku1ZE=
X-Google-Smtp-Source: AGHT+IH1rBy1D6MMXMURrKhLgM/QVCR4/NjWc1GJCR98wa8bc1bw/NyWUMkmgHh/zML+/5LatlTbug==
X-Received: by 2002:a05:6602:81b:b0:7f3:d3ed:1ca3 with SMTP id ca18e2360f4ac-7f3d3ed1dedmr799268339f.1.1719611398619;
        Fri, 28 Jun 2024 14:49:58 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb742f1cdasm731031173.172.2024.06.28.14.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 14:49:57 -0700 (PDT)
Message-ID: <6da74747-ead4-4abc-b732-2cc27f7fce5d@linuxfoundation.org>
Date: Fri, 28 Jun 2024 15:49:57 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] cpupower: Add 'uninstall' targers for arch-related
 debug subprojects
To: Roman Storozhenko <romeusmeister@gmail.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-pm@vger.kernel.org, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240625-add_uninstall-v1-0-ab031bbd98e6@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240625-add_uninstall-v1-0-ab031bbd98e6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/24 12:53, Roman Storozhenko wrote:
> This patch series adds 'uninstall' targets to the makefiles of
> 'debug/i386' and 'debug/x86_64' architecture-specifics debug subprojects
> 
> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> ---
> Roman Storozhenko (2):
>        cpupower: Add 'uninstall' target for 'debug/i386' subproject
>        cpupower: Add 'uninstall' target for 'debug/x86_64' subproject
> 
>   tools/power/cpupower/debug/i386/Makefile   | 8 +++++++-
>   tools/power/cpupower/debug/x86_64/Makefile | 6 +++++-
>   2 files changed, 12 insertions(+), 2 deletions(-)
> ---
> base-commit: 0fc4bfab2cd45f9acb86c4f04b5191e114e901ed
> change-id: 20240625-add_uninstall-14246eeec69a
> 
> Best regards,

I am inclined to not take these as these are special case
debug tools and modules for developers.

thanks,
-- Shuah

