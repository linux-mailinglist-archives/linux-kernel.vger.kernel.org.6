Return-Path: <linux-kernel+bounces-173442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAB68C0082
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98C59B21547
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4FD86657;
	Wed,  8 May 2024 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="Ov6q7lob"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D51184A23
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 14:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715180027; cv=none; b=CiqHXmuUbI3zgYpNOBZKsloLKDYO8LfYhwyx80xZmHyTgvmuzoGdtXXWHYEj4+BwMM+2BiClxilMdVI9cAd5nK1OHp3RSJMuROVxLoDjTr0XjxDrgjRfvbUIp2MR2sYaFazExUklxhkWi8VGVCWlEvF6Wu2K+FbCwG+fRYRGVwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715180027; c=relaxed/simple;
	bh=EJWsUtCPHpVsGcqxCXxyFT8ILSf3nB3QUf5aCnrWjcA=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=Qz+zpCUDao3N8EucUsOmp9sGvulyV0tPByH0lIutJyWoVdAbr1S8rYwJYPYGi4ntYtloFvnz8BrJ46VXFgI2oJdE/l3KTHInmg2DMNCBOF/dkEAEebDB0HPY4Tbq34Rcxws2mstr9ytkq2b0TIIp0OZvR6OPsf4x+YDGk18X9Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=Ov6q7lob; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f44b296e02so2351503b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 07:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1715180025; x=1715784825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jzxebwdo962PuKC2zPMaZjfMWZ4zNd6nkm5wi7u0wk=;
        b=Ov6q7lob5JTtJ+HROPLbLJT7jKk91aqTLwi6rsJn2/IHhP1sx4Vrf8ZBd8YYRakktj
         /wMHB1XKP9xoCFComjwQo7KBCYJAjC6i2Wa+MbIofdk5TOtUcHT0Hz6AQx5CJetVk29u
         SfL8Wb7VN4IIQNI0pdIG50Ne//ukAvYngyKuZgKa6OcHL63b2X7yP0wOF5zVOFRhQsBb
         Sdcv8oo4E+wDhN736kNXpf3mKzLkYZBJlAYHA/lWqMN+SDXd7WFoMEA9aj9nbMRnMV1A
         C4oXshB910fHWngBO/icDf+ETn7Ht24vGiqKWSN4MXODtU7pc3fyZpq0/fyATkFz6S3G
         73Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715180025; x=1715784825;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jzxebwdo962PuKC2zPMaZjfMWZ4zNd6nkm5wi7u0wk=;
        b=oN1nCfr8nEbGlyDePK2EsEfo6ZH4345Vr103UzV39gRa0UwMreT3InWu+y0iA1Exr/
         axBFMiWJUeZgPnx0iOd94LyQ9NCDSRkRJOSErhOv/UHcwXuGyRchjrFKOYDua8r+kHSH
         AGEOAuDliCq4j0CQQxeGlhio2LjCHKTD0MeM3H9hsBU4Zrw32VY3bJtIBa9NIfncGDKD
         rv6xoGybX5C9WqJP+yHUa4BfOo0pUbYIEICqjKG/Yy5xmsriCE4gltMluYO4AElBLTSs
         4bIptuCP9/klLtG0IHyUypdIeUMlHDk0AK3HE978DkLcWdelqTqj6S3AURcxOTRAZK3H
         87IQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQrBnmJ1fABnOVrWyW6g36CCV+jrIxxdbvEfK62Qj1Ff8AJ2lvylOEEp/u8yDa9YhXtmOJInQss/PHybForOqdZEhZUbDOpz2nu9s/
X-Gm-Message-State: AOJu0Yy5KFrWnNQ+spMrQXawecbZGUErzOIp5Jm5BudrWCd8XtkGK6sV
	jEIGJlfTVCPJlfDdYOnibsbhYF18uJY+MPj69Hcg4WsideECfc9ttxGWO4GceUA=
X-Google-Smtp-Source: AGHT+IGZA/j1I+rqQTrHxseqHOH3+r+6RDtsDRR7EHaPNdBztPL/ZrhtBo/3+SHYuBPgSM47WmrRSQ==
X-Received: by 2002:a05:6a21:3995:b0:1af:ccd8:c118 with SMTP id adf61e73a8af0-1afccd8c21emr1558953637.22.1715180025014;
        Wed, 08 May 2024 07:53:45 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id p2-20020a1709027ec200b001ed9fed6f61sm8137490plb.268.2024.05.08.07.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 07:53:44 -0700 (PDT)
Date: Wed, 08 May 2024 07:53:44 -0700 (PDT)
X-Google-Original-Date: Wed, 08 May 2024 07:53:41 PDT (-0700)
Subject:     Re: [External] Re: [PATCH v4 2/3] riscv: cacheinfo: initialize cacheinfo's level and type from ACPI PPTT
In-Reply-To: <CAEEQ3wnthxGbrJ_qLnZUQ9w3E_1UWgMign5P=+rNP2p5xGm4Bg@mail.gmail.com>
CC: Conor Dooley <conor@kernel.org>, rafael@kernel.org, lenb@kernel.org,
  linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
  aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, bhelgaas@google.com, james.morse@arm.com,
  jhugo@codeaurora.org, jeremy.linton@arm.com, john.garry@huawei.com, Jonathan.Cameron@huawei.com,
  pierre.gondois@arm.com, sudeep.holla@arm.com, tiantao6@huawei.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: cuiyunhui@bytedance.com, Sunil V L <sunilvl@ventanamicro.com>
Message-ID: <mhng-c1256305-0281-42c3-8469-29e3a5ee397d@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 08 May 2024 04:19:01 PDT (-0700), cuiyunhui@bytedance.com wrote:
> Hi Palmer,
>
> Gentle ping...

+Sunil, as he's the ACPI/RISC-V maintainer and I generally wait for his 
review on this stuff.

>
> On Fri, May 3, 2024 at 12:37 AM Conor Dooley <conor@kernel.org> wrote:
>>
>> On Thu, Apr 18, 2024 at 11:43:29AM +0800, Yunhui Cui wrote:
>> > Before cacheinfo can be built correctly, we need to initialize level
>> > and type. Since RSIC-V currently does not have a register group that
>> > describes cache-related attributes like ARM64, we cannot obtain them
>> > directly, so now we obtain cache leaves from the ACPI PPTT table
>> > (acpi_get_cache_info()) and set the cache type through split_levels.
>> >
>> > Suggested-by: Jeremy Linton <jeremy.linton@arm.com>
>> > Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
>> : Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>>
>> I'm not an ACPI head, so whether or not the table is valid on RISC-V or
>> w/e I do not know, but the code here looks sane to me, so
>
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>
>> Cheers,
>> Conor.
>
> Thanks,
> Yunhui

