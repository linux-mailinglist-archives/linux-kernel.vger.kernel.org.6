Return-Path: <linux-kernel+bounces-174199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CD68C0B8F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914251F239AC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 06:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317C66BFBA;
	Thu,  9 May 2024 06:36:35 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3245A2F4A
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 06:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715236594; cv=none; b=IFrAafth6w8a8MUSje/NtyhyxiyR60oddR6JhFJP+HZjOKimqjbkiD4u/gG7SoIFpA4iuhs3f4cq8EMiOuxhf8FMc2v7yC3vHVJmZb5ERteGNmBDj3jJcRrC6bfIM47r2RRRcMkT4J23XkCTSUXOVRfM64pq2kkF3nyaq9XNAR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715236594; c=relaxed/simple;
	bh=MjYmBO9afpQj+9jUWhNoJdbhCX/SbbQ7XGR0s6/VFko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YcruPWSZjbG/Yw8na7Ut2LwK+AiiKTRgQtDpEQSEt6JxnAGl4Q5EmkxT5xUcA26y2K5kQ4R3epfh68hgPvxA6wdP+V5cOcc4LhRmC5ln2eblx6hyBOhITojI4hUHbuKcJJvCljxephZ4ZGWwUcvlJPlMLa6xvlV7yfazBjjUmSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34e6aaa4f51so70082f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 23:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715236591; x=1715841391;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v0fyvv/t4JLmnq2/x7aVOO7zCJex8zcGo6nWWr1z490=;
        b=ZfdX+pXzvTZygJ9yiz9nFPQcbW+5u9L3qjjHsrodPOLiHcwMm5PKMwnaRgT92pfxx5
         dwIzVjNooA/h2iPUqZapmFJjk646s3Sw56XURbCwJ3H0u/un7+dymDeaZ353ipsMgSZc
         vk6g0TRYku2W6qbEl+dqJcGnWc7ryBz9qD6XnZnIBHuhtEkyE+Nt+pn3NfVX42ZBn9GQ
         7GN64B8RUXRNU/WR3Z/WJZOxNpaSmNk7xMOmKJxCvcG+GFv470FqMFAl+dE1hMrtJQ6s
         Ifk//e8GsGWRPuUnKaC3K4X2pAePh365490gFN+UwG2xDO2J+tdbBiHzZfyWvmXRZW6Y
         IGJA==
X-Forwarded-Encrypted: i=1; AJvYcCVcpj2Q0EvP+tcWVrwrgIQfu16NisqSNtXrcPjGtpdHQU+m1rRJ8os/E95iUwuyhA++JSeNMata3oe16C7Z2nXH359xBCVPTbYYTvCm
X-Gm-Message-State: AOJu0Ywjvuahq2IoVPR9R+5dkScXL0IL9lZ3Hd25izQjVn77P7QHqG9y
	KfgrSjlzQge8g2bn+oLd0t0T99Ad2jp7lnho8eI1vvNIhj9hAwT7sjQykA==
X-Google-Smtp-Source: AGHT+IF+4UI1V/bvMXBYMRBn6YUXeHc3GcJhO0EB/9GeAyfPEvkVJoEfqcj1J8TbQs+Yit81vwgcGg==
X-Received: by 2002:a05:600c:1c93:b0:41a:bb50:92bb with SMTP id 5b1f17b1804b1-41f7093ca92mr34421685e9.0.1715236591237;
        Wed, 08 May 2024 23:36:31 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87c25459sm48317745e9.18.2024.05.08.23.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 23:36:30 -0700 (PDT)
Message-ID: <dfb9074c-d019-4a19-83eb-00d93da8dada@grimberg.me>
Date: Thu, 9 May 2024 09:36:28 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WQ_UNBOUND workqueue warnings from multiple drivers
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <BYAPR04MB41513F04DB2ECDC3601CC36ABC2D2@BYAPR04MB4151.namprd04.prod.outlook.com>
 <c4057654-97bd-4721-9bed-9dd5ef8b3f8d@grimberg.me>
 <6d3af8dd-30c3-48d4-9083-7f00ea21ff8c@nvidia.com>
 <BYAPR04MB415196EC84756BA1876463DABC3E2@BYAPR04MB4151.namprd04.prod.outlook.com>
 <f5d57e3b-8168-41af-8e36-c7a21ef3a475@grimberg.me>
 <BYAPR04MB415180536421C9B8326D6A30BCE52@BYAPR04MB4151.namprd04.prod.outlook.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <BYAPR04MB415180536421C9B8326D6A30BCE52@BYAPR04MB4151.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 09/05/2024 2:16, Kamaljit Singh wrote:
> Sagi,
>
>> Does this happen with a 90-%100% read workload?
> Yes, we’ve now seen it with 100% reads as well. Here’s the Medusa cmd we used. I’ve removed the devices for brevity.
> sudo /opt/medusa_labs/test_tools/bin/maim 20g -b8K -Q128 -Y1 -M30 --full-device -B3 -r -d900000 <device_list>
>   
> We saw the original issue with the upstream kernel v6.6.21. But now we’re also seeing it with Ubuntu 24.04 (kernel 6.8.0-31-generic), where IOs are timing out and forcing connection drops.

Thanks for the info.

>   
>   
>> Question, are you working with a Linux controller?
> No, with our ASIC (NVMe Fabrics bridge).
>   
>> what is the ctrl ioccsz?
> ioccsz    : 4

I see, what is the mdts? and what are the r2t lengths the controller is 
sending to the host?

