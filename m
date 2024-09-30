Return-Path: <linux-kernel+bounces-344726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EE198AD84
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28D9B1C21A97
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3780119DF4F;
	Mon, 30 Sep 2024 19:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L7bf/H+c"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7DC14F9D9
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 19:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727726130; cv=none; b=QFk+DpSFTwINF8aYUFThhZI8ZbKpImONjzgSAtrIeq0GmXYN0KFQ8iW6FnnKnYi2uezQU0LCeD9zBkHDy+jTFr6VF2Io3ErQFq462icKLxXmQ7vbmr083lv1BfhGcK+0PNAHenJglz/fn4XgVPHZxyIKTaKR8RG/7k2eSHBUgC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727726130; c=relaxed/simple;
	bh=g5fMr9ssjRNO3v4PW6U1/SqvJs8wYDgf8jrXLBynUBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KIfs8eQxEitYj8k+uZtABPDhv/fTBFOSL2OTU6wWNsO9J6Zpl77EJNKvCgX3fFJznA9PGeNzYBAw7RJDd+hw/h8ljYMSW0FPmIMcF9Nl5lqYRKnWnusMmNPLtzjccNFGQLH9nLfbF+BQogn2X49jRylPikF3rNobjSUfL8Crces=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L7bf/H+c; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-82aab679b7bso182287039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 12:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727726128; x=1728330928; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ltFBB9pTQWA0tvRjbV8xqc5b7dISTnlzZOqkmzWgOeA=;
        b=L7bf/H+cnfdk+4K6/EsvfkrEMIm4Ud+caUT3llgkEor+Lw7D3F+J8HqTmu0iXiakkH
         uvM3YyiUOVCPMxUYzSe7CWqQ8funhzHS552auzDZspr8m0cyffG6GouPvne75DUu9gRH
         Wns1hSVrL9nmPWHDq6nV/BNRLR5yC/S/Xe2K8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727726128; x=1728330928;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ltFBB9pTQWA0tvRjbV8xqc5b7dISTnlzZOqkmzWgOeA=;
        b=gBu30u4dNjZVNUOQMmrxl3upIKEUzI3aypEpQG8nVm4vcpy8Pees9z64YzybUMejd7
         S5Nla7vNZmAWswW3Gr1UuCLGQn09L9qaCl2LNHZdR+URu9tTRMv4CwJYbfUGurhgSzk0
         K89P0Vea2L3/y5crG8uwcIOPfn6B6ezbcoLBFCaFOLD3g4AJiMWypUbfVvWxTT/V9QFa
         y3ZzB3dkeJCk5yljJVJui4cZhgLYEyLeD7LSgfJ3bePy/MSD/RMK0zIv65PKlnmCI/rK
         r51u6B8oAPwkIAfGURcxTsbEDpkY2k0TEzB0qz8/04ZR4du55NdqEyXgYn0/aoYvNOcl
         WKkQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4LlAJAXwfmiigaj4uaNKGrgHnL8PImZ2Ftg2pTDrhb398vtvu/lyYuPl+f4H5YzJ2VBJXV1lISEM/wj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ79zGcWnVzjHHOQbHZ7wiawhLMTeuEHotkvRmIzxCbWmbVKUh
	Ef8ZDyRKdgq8EtOoEzB1s5txVitifTm7/mvaQ8lVK4jumOWuO3d9AwXonqujC/o=
X-Google-Smtp-Source: AGHT+IFYanqJoCX2mOrtZ7bd/mpFJL6rX1n+AeppJU6W9Dg27ZEkQzm2qaOUtIaZ7th7s6PqkKZWKw==
X-Received: by 2002:a05:6602:340d:b0:82b:c70f:5061 with SMTP id ca18e2360f4ac-834931e636bmr999571739f.7.1727726128170;
        Mon, 30 Sep 2024 12:55:28 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d8888f9b30sm2268228173.171.2024.09.30.12.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 12:55:27 -0700 (PDT)
Message-ID: <ad442d07-4c04-4be5-9273-3970e7f41a55@linuxfoundation.org>
Date: Mon, 30 Sep 2024 13:55:27 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pm: cpupower: gitignore: Add compile_commands.json
To: "John B. Wyatt IV" <jwyatt@redhat.com>, Thomas Renninger <trenn@suse.com>
Cc: linux-pm@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 John Kacur <jkacur@redhat.com>, "John B. Wyatt IV"
 <sageofredondo@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20240930172330.7076-1-jwyatt@redhat.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240930172330.7076-1-jwyatt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/24 11:22, John B. Wyatt IV wrote:
> A compile_commands.json file is used by the LSP in tools like VSCode and
> Neovim to look up function and type information. The file is specific to
> the state of the current system; add it to the gitignore.
> 
> Note: the kernel root's gitignore has a similar entry:
> 
> /compile_commands.json
> 
> I am not sure why they use '/' for a file as it is used for directories.
> 
> Signed-off-by: "John B. Wyatt IV" <jwyatt@redhat.com>
> Signed-off-by: "John B. Wyatt IV" <sageofredondo@gmail.com>
> ---
>   tools/power/cpupower/.gitignore | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tools/power/cpupower/.gitignore b/tools/power/cpupower/.gitignore
> index 7677329c42a6..5113d5a7aee0 100644
> --- a/tools/power/cpupower/.gitignore
> +++ b/tools/power/cpupower/.gitignore
> @@ -27,3 +27,6 @@ debug/i386/intel_gsic
>   debug/i386/powernow-k8-decode
>   debug/x86_64/centrino-decode
>   debug/x86_64/powernow-k8-decode
> +
> +# Clang's compilation database file
> +compile_commands.json

Thank you. Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

It will be included in my next pull request to PM maintainer.

thanks,
-- Shuah

