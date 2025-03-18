Return-Path: <linux-kernel+bounces-566120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05018A67376
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563CF42301E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229FE20B7E7;
	Tue, 18 Mar 2025 12:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="xAfzF9yx"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061EE2080E3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299463; cv=none; b=Fl/qd8NmKK/5IvTXRv9IXCnwtAYQw11LCHhJ4xIyMarPID7jbBdf3PShQ62raamtpzam3Wgq7sb1AmR6pnLktq4GKPj4C73A61zyGzmHw02GImcGKbkTAOA/U+Qg4KAQ49B7W/kwPUdMoYdLdhhfNQQwfDglwcWQ9zvGTTgSrW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299463; c=relaxed/simple;
	bh=Q4mZtFR/Tt7/i4AsUspqof7CvawdukYJTvPRyJptRhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XxVfP5J6OsWcjfEOCf2LoDtw7f1epucxawwKlctL51/N34QK3kW+MoNsIezO4ohdj7OV2FiRiZ//PHrL+lgf0FV5kBqDL478KN1wgcOz6PMJxnB5uH89/uRwqkkWmcMfrbfvyeVrURYbd78RDBt9CSXgybsdeXULKE8S+zXxWeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=xAfzF9yx; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3ce87d31480so30133465ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 05:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1742299461; x=1742904261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8CJnOafkcvrR/l5VXbCtNpeHL6EGqqxqILSUHXldXfI=;
        b=xAfzF9yxDV/Yjhk23XMpBGHkYWyY2FZsfUjrpefD3isTK3ZQeMNscwqXLohnTg243w
         QKQ+I3hSNVrz6rnmM5xivHBHVCCxEyOgdJ3ETw0sF2EgYbrP0tZMX9ya0VMdEvbxS8gz
         B9dv0jbRcsaU4qIUtX3SN8/T9RXnpwWBBaGEj93EyU0HINi7fDlU8I766KfDMIuf/l9R
         DdVcrgaPZkmcxCBFHaE9d0JBiII7jd+X9pXATyxf9qN28byGFLqOJ7AuxBGH1p6hFmiq
         bXTjOUM+pNtb6uUsRJ4oBu0Dw9NpCqLUjF2z3eXANwl/8idOKRjn9cMYKsKcBssvPCIu
         HOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742299461; x=1742904261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8CJnOafkcvrR/l5VXbCtNpeHL6EGqqxqILSUHXldXfI=;
        b=Y9mkX0L9ZjNiH9yKsmBDl11KsbCEoxelzVdvkq8xPCDpLn4H/OobGVTkOVaUuUtAvk
         s8o57yt0MWwJuvnEEjS8FqTY4C+GzaMtFyWBP+B0yFq4UPEmAJ6AcN7nriFW8X2i9MBU
         mDWNhyjMU4ZN4j5aeIm3UMTnB2doyWlDVuJYG0+AfzWilejSTrrwz1qdyZx5pQLPWsZ4
         FFV5CG8vF0iMrjP0TRTDlZlILaiB9JVtk0FyWzikWbR0dS6FNz9MBGosxT/ovSidZpCH
         d7P7CiPa3j3NC3NB81zTynp23EDO+esxphPTq2Bgcwv/4a+bc6j1VYZO3N2BtVY1zK1Y
         10Gw==
X-Forwarded-Encrypted: i=1; AJvYcCXig/A1QUZSljJJiNqFwUhyVkjWVHD3bbYWPBkfLIto5hfJEqKTJNx3iyh4x9QgF7yMYf2ei2rFVejL3zA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKm9VDiArBPdgSLAUgP8nZVPWOQoM3NcRbrQ5yN2VX6mo2SY+H
	hlSMAFVrvUY1MI6rVq6pfO3vSob+N5kRElL/+6Nhch7nvzVdy2a5VwHF0PcE0zE=
X-Gm-Gg: ASbGncsrinewCoy5ykYA8it2lK5lgHS9+QBT/DwQyKcMS/eDu81nHbDGvavISEzGYnc
	MW1/aUBOkvSnb2W35pPRM6A2H9SN1emZvMyBSPFc5bju0RWvf463Khny4JQ+i+DGVo0Uf1jidSR
	fNEO3Hz+SkTpmNxDIFrbuvmeefm+7rCxu/R98kQrfMMUD601xIi/lsLAsjaMt2jGELWCUxn9mnw
	ZNYwITS+mNEdLh9nU95MrIZlKZYzScgX/P8fwnCFuRLzlz7jeBTHP3ODplwLuN8eREG0BgeiR7x
	3ocEGAARDGv5AdGr+TT8+8kZfPg9W14d9gF4F7m8uUgaVUAZR0/zxQ/B6b6dq7nTlcJtTO7DfpN
	XkMBIpAGH
X-Google-Smtp-Source: AGHT+IFS/pxfjNPDqJhNcLq/lECG72AhDNrlffrBV2L3kxYV1244Sdx32ia+HQiIA8St61CQNBlH4A==
X-Received: by 2002:a05:6e02:b46:b0:3d3:dfc2:912c with SMTP id e9e14a558f8ab-3d483a75837mr164324675ab.17.1742299460874;
        Tue, 18 Mar 2025 05:04:20 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d47a6683e1sm31287795ab.19.2025.03.18.05.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 05:04:20 -0700 (PDT)
Message-ID: <a7862a8b-4d81-4b1b-90d9-3cedde0699a5@riscstar.com>
Date: Tue, 18 Mar 2025 07:04:19 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] i2c: spacemit: add support for SpacemiT K1 SoC
To: Troy Mitchell <troymitchell988@gmail.com>, Alex Elder <elder@ieee.org>,
 Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>
Cc: linux-riscv@lists.infradead.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 spacemit@lists.linux.dev
References: <20250316-k1-i2c-master-v7-0-f2d5c43e2f40@gmail.com>
 <20250316-k1-i2c-master-v7-2-f2d5c43e2f40@gmail.com>
 <401059d0-6b2c-4c40-8c4d-51749dca27f3@ieee.org>
 <c7dc26a0-7cbc-4909-b2ac-582d108fc5e7@gmail.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <c7dc26a0-7cbc-4909-b2ac-582d108fc5e7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/18/25 12:44 AM, Troy Mitchell wrote:
>> I'll leave it up to the maintainer to decide whether these
>> comments can just be ignored--my Reviewed-by is fine, even
>> if you don't change these.
>>
>>                      -Alex
> I know it's right what you said.
> But I don't know if it's worth to send v8?
> Maybe I can fix it when I add FIFO function?
> If I'm wrong, let me know.

Unless the maintainer wants you do do v8, please just
address these suggestions later.  Thank you.

					-Alex

