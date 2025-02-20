Return-Path: <linux-kernel+bounces-524705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F7DA3E611
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A13D6189F768
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE83B262D39;
	Thu, 20 Feb 2025 20:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="b4iQDpzK";
	dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b="NHwMntY1"
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1311E9B3C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 20:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740084399; cv=none; b=FFnOFUWQn2UWm82b1IDYlZCCD+coTtrEl4lwa1pnttSxNTUbXTJ8nW2L5OAIXGQ/PDKa5GUOE41Zf/2TuZarUoLGCszdWeonAVatdzD4bCkJiO/zj12teWvolipxvj+RGoviQ92OSJZZzCFBPO9+bKM0QWmDLDwDzRIlqQFwnUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740084399; c=relaxed/simple;
	bh=EXXbsELd4TnDhPR+oLxmC6mb4dDV4YYCWuYKmzQgrW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hlGBLPYkxEMvTcWZ9oOlvHmk0Q/eQKce/vEwPAr/mXhUgP9IqBq1y57fybDJ6cSv5CfxRWSmqj2I6NuODZC7xjYnyxZMp9joCdSkhs27NxPNN63Et0vD8U3HUXWxIMHO9xHso7ii0/vJJ08Zh0wcTggLFMMexWHugl5mu1ECRPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=b4iQDpzK; dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b=NHwMntY1; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sladewatkins.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=selector-1739986532; bh=MWhuwPKRWHuBZzoHcb+oOoXnrhWEnQoYXYXKtP6logA=;
 b=b4iQDpzK7Qt0irFVVmnSEieIo7FsIkqKYnOUsZi2ej5L2FXEEULlgE5U2bExNSOVRIBTGIyhaeUlYzDAbMTgAgwWmcf5sKckOezpRyYoFBBAeNxTtJLVi3OO+S0/ZwnXwE5Z6R1gq0bBYw1bu8CyCTuIvTGk4SQJURoU1+u2YI8N3fEajr/8pniN93JOO+ovNcTjS25adgOC7p5ZHzIpBxfkSRclJc1i95Lx/pBFd5TDcpXlhq1W5ViBLk5EzjrD2+2GmnxEtrXofR7Wh/u/hPFzbxzDpbWCEt9NRv46dVKrZnHmCG4Cz8JaYok4Se01uYCY8Kp48xAaajf8WnoTcw==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 144A36000FA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 20:46:33 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-472107c4b5eso25686291cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=google; t=1740084392; x=1740689192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MWhuwPKRWHuBZzoHcb+oOoXnrhWEnQoYXYXKtP6logA=;
        b=NHwMntY1o3tbflOqqZeLVQShutpfocudVOLx/eQhwBaZeFepdPIPBHX/G8fEqbB/rJ
         bqaZPqxfl19LLVfMO/+Mpjgspb9V2T/guSe5aUb+/YSzkXsCgl7/lsX5MdSYKLwOHKi5
         DoAVtdkoFr/gXVwspdVY2ZeC+PXaesmri6AHxKnW0z3/eHs7CpJBXA1Izc0iUDD6CsLp
         USYpJBvPMtj5wpShbM0dB9trU8jrl3fgg6m+CR9YWJWMz81P/M3wEdR521I5X4+oNdcn
         caGY6B6lFX2zIz/QBY1/rRW/nF/q+dF9qvLjsFWQqXTVZtavh/fL8Mtw5JUQ/2cpZW+a
         hLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740084392; x=1740689192;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MWhuwPKRWHuBZzoHcb+oOoXnrhWEnQoYXYXKtP6logA=;
        b=d097ZYieZAjKWq2absVPUd2VDkHKL2OrEcwnAZMFFKbTG8eYvrC7diPZqfu7IQBnWp
         R5yn2SSnswlNXd2VrAgx6r8HY4hMC2I1C6DFXDkx1uMU9qyfnyyRPSOB9BCxRcQNJgcu
         Qz9pR5ud7Nbwe1Uj2caTdz6z8SFYgFg3c1fJPjRoVDGc+O391WxO084Q4mqV+mdd6nK/
         MP9Eh3q8JznOMxuWLgSqyDdFBME9smhKTM35jBFGAK6oNHnjbBO4hAG+dDfmo+yktY6T
         e4yiUPFnZ0S4nmzrUDiS6JoW5IvFxrfCEU0OIT21YgQ9gWHFEDV6kwibjLOCsFZlfqho
         6g4A==
X-Forwarded-Encrypted: i=1; AJvYcCVubnZ6K+o9eL6scCf+iYGPztnLDJXbAPdPKlzsHVvVb2EX0BcqUlVFB82WhwvC4sT8eP2rHRefr4Q6pk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIW4fRTVxSA02/uB/oNNEb6dURbmCGhnBASFmgVT5BbCDehuQf
	Lkw87Q6HoBvS9YM7WuKsGrO4F+nykzYzPxZZ9RkPfm660iNXCuNMltUhXTSLHEZbxw7mnvfmGjm
	pXbq2/DUNRsMEkR2HojnV/WXc79Zeg54c/I1dwIRzCtNv0IXz1KrNzb1SeS4SpmDN/GYEUZ26gM
	/vWL18QFw=
X-Gm-Gg: ASbGncuUYKwA4ngAM1vcOWkAg85hnhhGu2gOl3oEajVNgTc7DyEK5MphxD0MAgOiOm8
	6VYhmE7XKuMt7oMikqM6kAD8cTfiU/cyCAEFmiKTkT58c7CW1EDmntNVFY1eFL5u8bEKB3J0rCg
	/SzusI37gq5qnG8u3jzhzuqU/oNOVvyL8xlKy1wCBnGYrXUyrD3uiJT72LV0W5PMulgxNUyQli4
	IoacrzqzBgSsm1E5bNSf11kgPQd6+6fZYyOlNhkff2M5CPBVI3IkOttyVUoyfAsTMu9lDka6/hN
	by/yO1JF0B6yACFRWcWPm2syn4cxvtUJ6klIh8rszS/BYI7OcrKVgo5oEt7FJs9FqgrS
X-Received: by 2002:ac8:5d8a:0:b0:471:fa00:fb9b with SMTP id d75a77b69052e-47215028ef8mr70119431cf.7.1740084392170;
        Thu, 20 Feb 2025 12:46:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwIrdDUc97c/BKbB21dPMuIBxKNLN7eS9xsTKAR4FBChuikeOlqXnwO7mamsv7/7FKtD0kyg==
X-Received: by 2002:ac8:5d8a:0:b0:471:fa00:fb9b with SMTP id d75a77b69052e-47215028ef8mr70119061cf.7.1740084391862;
        Thu, 20 Feb 2025 12:46:31 -0800 (PST)
Received: from [192.168.86.34] (syn-076-037-141-128.res.spectrum.com. [76.37.141.128])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471f0eba93dsm49479581cf.80.2025.02.20.12.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 12:46:31 -0800 (PST)
Message-ID: <7e94a24d-d2dc-4f77-b2ac-dc900552ec90@sladewatkins.net>
Date: Thu, 20 Feb 2025 15:46:28 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 000/258] 6.13.4-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250220104500.178420129@linuxfoundation.org>
Content-Language: en-US
From: Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <20250220104500.178420129@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1740084393-ws5Vp_rMC2QP
X-MDID-O:
 us5;ut7;1740084393;ws5Vp_rMC2QP;<slade@sladewatkins.com>;c71d53d8b4bf163c84f4470b0e4d7294
X-PPE-TRUSTED: V=1;DIR=OUT;



On 2/20/2025 5:58 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.4 release. 
> There are 258 patches in this series, all will be posted as a response 
> to this one. If anyone has any issues with these being applied, please 
> let me know.

Hi Greg,
No regressions or any sort of issues to speak of. Builds fine on my 
x86_64 test machine.

Tested-by: Slade Watkins <srw@sladewatkins.net>

All the best,
Slade

