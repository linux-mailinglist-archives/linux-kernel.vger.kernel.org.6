Return-Path: <linux-kernel+bounces-254509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23988933410
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 00:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80EE52823A1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67FE13B2B1;
	Tue, 16 Jul 2024 22:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HQdn3nir"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851CE1860
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 22:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721167283; cv=none; b=lvgFKbVMJO2cKF23EsyYAaHuly9YboDaqA73H2t8+jdQBgITw5+/MEIm3bzwsWUNp66tF0WGeLSE9J5+Wx5W32+f+AfKuajC6kFnaucCR0Ai2qtyv3/bLDAFURRA+DfPAqQUazYO23Z+XAd4eq9NJmEIm//aFuiIDSTcR3ZmCfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721167283; c=relaxed/simple;
	bh=HLsso6sPpwAqcJD+ovzh5+MRcgBp2g+CSGjySevHyUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mLg537SuBAlBfU2RmXjE/WmlpnSMy5AW+NopEFAvYX4qqfGOBMZKBUHe6hfzNtL3Bj6w5SsujoL3/UcibXFEmbCZd+Q9WHI/wU5H0h1YVfm06DLWJr7jKM4mt+ybQ+BDdZ+s5m59AGJbrFe376doXmJIBVUinvsCfJtyxj7ta5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HQdn3nir; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-804bc63afe2so660939f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 15:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721167281; x=1721772081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x5PSRoU/ZGPblxfU6VHJxaVA+2xtD5DSTjqNF2ZXUTU=;
        b=HQdn3nirBSjN4dma3Uhtk5G4O6gEFR/HHrolN1wM7M+AuqqXrVBVhmIZtys3bRGBN6
         TitX0qWAyPYsC/laPb9Mw4nORHaF2XanmblZ26O4LVyvHGxoYq+hNg8x9+KQlyjKYtEM
         ccMrl+QbWPuqYCeiltqAtM/LlgIokphiJMEkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721167281; x=1721772081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5PSRoU/ZGPblxfU6VHJxaVA+2xtD5DSTjqNF2ZXUTU=;
        b=YELuPwtvdQYaYDxOcUXE4gcbz30XhdcwMdcfR5B1ggi4aeNdqxMdf9NmKyoVodE1Z6
         ANl93Cp+j6878EZRqubH+j9m1L9Z2bsHdfQqMIzEe44USbXmrA7yQ0H2NieFyimeR1Rw
         1Xk839qKaj/Nh6Mb2rLJmHgWGzmoWi0+W2UQz2vfpNod7+U7r4Uga0Lt0t2zyc5+gMq7
         xXJ3WwdR/dCBhfuhtWzBKEifQa8rGdO6jhAFj+OrbGLW280r+IBHVk0VD7uFzLNtEVQd
         OVZpxB1VfK3gnkIFtCEnpC3pDSgJyv9oEcTJLFcjxA7sx/NzIFXacwUHmXmIcJgTcLVT
         n5vg==
X-Forwarded-Encrypted: i=1; AJvYcCXMPnQHIKgdG1zPNYSHIZ9xCIVFsecnghHYh4+e7ucUsAjChXe3KrnJRm2uYGi+T1hEaEsISps7t/rUJmB03l/KU52LI0ChaeGsQ0pp
X-Gm-Message-State: AOJu0Yyh4cPl9UpJGuA9YF5bHVS+F+U5JSTXAqodrzKij4ibVMIeL/xa
	6w3ptDapDPZl32lrbrlRX28CLKBDBHVGdWqemyBQfMSxCqvWItMio9ZqpWqXmJ8=
X-Google-Smtp-Source: AGHT+IHcHBUREm0r2e2Ncbofi5LeKrZTXUCyGAPYMl85VtPnN8mq+O9egmVzjIyLGJqKAfAKB1BY9A==
X-Received: by 2002:a5e:c916:0:b0:80a:4582:be31 with SMTP id ca18e2360f4ac-816c5698730mr48773639f.3.1721167280736;
        Tue, 16 Jul 2024 15:01:20 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-816c18b9397sm18021739f.17.2024.07.16.15.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 15:01:20 -0700 (PDT)
Message-ID: <11c8d108-8635-4c57-b76a-8dc4a9c908af@linuxfoundation.org>
Date: Tue, 16 Jul 2024 16:01:19 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests: x86: vdso_restorer: Return correct exit
 statuses
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, "Chang S . Bae" <chang.seok.bae@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240712073045.110014-1-usama.anjum@collabora.com>
 <20240712073045.110014-2-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240712073045.110014-2-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/12/24 01:30, Muhammad Usama Anjum wrote:
> Return correct exit status, KSFT_SKIP if the pre-conditions aren't met.
> Return KSFT_FAIL if error occurs. Use ksft_finished() which will
> compmare the total planned tests with passed tests to return the exit
> value.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Same comment - here. Include before and after output to show
how this change improves the report.

thanks,
-- Shuah


