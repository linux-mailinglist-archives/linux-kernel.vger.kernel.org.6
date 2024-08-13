Return-Path: <linux-kernel+bounces-284324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D9D94FFE2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD1D5B24C5A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9444313A244;
	Tue, 13 Aug 2024 08:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ClFhfrOG"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13877134A0
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723537861; cv=none; b=aUaQSCLuSad3+pzKJEWtoNduL2cyKAB2MHOlNtwJgMVLjFS+bhmX12qYfcrj1he7zV0uoRYN+TNNCQqJNAcRte1EM0zvJGeG6XXYz1RJPVgohqYP+rG18JCXDTRdexZRua0bOXe+q4Yg+EfWhNCd0LXBJAG6GJEY1PrRBMbrUd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723537861; c=relaxed/simple;
	bh=mte+8SBXU4fsMgf1dqa+xia4zg6iVcJujhUtX3mlIL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WcElKmXxkjNxNJVkgojc4dLF2/vYT2fekVwW09fxtERF+AR8aJC3HCk6TTJEwAngLoTWujQO/h//8u6RrntWTgtO+wyTYlPFOkJMVkvvgMMcp8UEwFiuT5n5wnzdJHZntp7xQ/U0ztJPeIzq/fI1lb0Ve+pwq3mg4xstZVr7+Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ClFhfrOG; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-75abb359fa5so866618a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 01:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723537859; x=1724142659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mte+8SBXU4fsMgf1dqa+xia4zg6iVcJujhUtX3mlIL4=;
        b=ClFhfrOGtxfkUojYnFEjDctvr1nBjmOEMQ1QwmXmG7NtafZoyA+HDRpwm9XS8+3W1D
         egH2PyycoUkpFtx9k1Ei5pxrjXLxdsZRcwayAf3/TfTu175FnbtyX5Z5t4bqYa6owJ7/
         4n/5ZOHOLeh4YnOfwDovP3ZmdqBUhest8v9sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723537859; x=1724142659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mte+8SBXU4fsMgf1dqa+xia4zg6iVcJujhUtX3mlIL4=;
        b=SWH0qLa5ln6m29AM7mVFEwj2nViZMNjGo3Lc7upg5UclmjA0EyZN23fj+uiQRErsZ8
         xU/dYVaU6evThz3HPKtIrzPdDh3U5qrW+eLy1kmZ5CvNSw3DDTiMD3HmnM3C5ta5g3nL
         gcDMALSH4z3mX7gWBVplFs1bgckV7d68cf45onsCoJ+xBI+Ar7Bs2vEkHGYb3vwWTx9t
         8cn5LRWUvVMfpgPQREqUpf6fMeliHfyYUoileuufbJn+40ju1OZM1TAOqUzpsvooe9du
         M5sFsbfl0DyS1BEIUhcTUNVKSgqydPipWveLi9q361EviseS1aBOhmDkRE00Oxz/mujP
         Jp1w==
X-Forwarded-Encrypted: i=1; AJvYcCXqNEd5mnJ1VLBSFCzR/oGbYJ9L+sf1KIgh0+IMkyXiRWZYnaVh2VQAfUZaZC0wk1Nz+bnU9HpTKoz++q4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz+MwXU3iL5wQfXQ5hSoAHRzUgQcx08uMFDz+lUkVwRHBvbc2l
	smeOUwTkGtCmUGLLFqknXgC+5yKw32paQM1WMaABZxF1WHpBt8+aLGpMsKAReoo=
X-Google-Smtp-Source: AGHT+IH+G4nGhI0UfmV7v12uHGx5Nk07nrbH2qcW0vXTaroCsC8U1dDUEWx60DGbADoAQQeROmNokA==
X-Received: by 2002:a17:90a:6fa5:b0:2cc:fce3:3022 with SMTP id 98e67ed59e1d1-2d3968f829fmr1039667a91.5.1723537859250;
        Tue, 13 Aug 2024 01:30:59 -0700 (PDT)
Received: from [192.168.104.75] ([223.118.51.112])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9c5dbaesm9835229a91.10.2024.08.13.01.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 01:30:58 -0700 (PDT)
Message-ID: <2aabc166-bf34-49b3-b938-bbfb0f85e8bb@linuxfoundation.org>
Date: Tue, 13 Aug 2024 02:30:54 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] gpu: ipu-v3: Add cleanup attribute for prg_node for
 auto cleanup
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 javier.carrasco.cruz@gmail.com, julia.lawall@inria.fr,
 linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240704132142.1003887-1-jain.abhinav177@gmail.com>
 <20240812193714.1094339-1-jain.abhinav177@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240812193714.1094339-1-jain.abhinav177@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/24 13:37, Abhinav Jain wrote:
> Hello,
> Can this be kindly reviewed? Thanks.

You removed all the relevant information for people to be able to review the
patch :)

thanks,
-- Shuah

