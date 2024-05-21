Return-Path: <linux-kernel+bounces-185526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE418CB648
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D5B01C21AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 23:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C23149C75;
	Tue, 21 May 2024 23:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghEbiT1C"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A1B6BFD5;
	Tue, 21 May 2024 23:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716333001; cv=none; b=KCqxDP7QarhTHQSy+SHw/BjQLoxXn0U1TeI83Z2/MpKVi5BgV1AckqokJfsFM92hAXbs3lWr0dxWaqJXK1TCoCSPPPyOU5ZVaKdZGN5XVYm3DpZetDucI5vfzIFWTziIT429QB4pgPmsYN9PxVOF71DwgsQYsRfP+LqHWepv1z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716333001; c=relaxed/simple;
	bh=+C7gsf8/DDUlWKuGaYzLxwz3xDgCyKhla7uqE1E7D8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OUE90lNWrlXPBK89EPzwLZ/I+ckvPPHfdw1V/R+u3LSCpQgVqsI38PbLTflzajxI7ujAnP51k2w8C/F3Mi1HTnkDpiCC4cZN14lq0EmyXfREjqc3c/QAq9Q/nOiUFfZM1YgI/Pf+qamS+CabuyvYMhx9YQKShWaHvVvREgIcihE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghEbiT1C; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1eecc71311eso5850125ad.3;
        Tue, 21 May 2024 16:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716332999; x=1716937799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WVlapK7IICqNZRk9AkY2koCiGjAfMcvjxFmJh5c+ZKA=;
        b=ghEbiT1CZedTHrP9WS1xxYepuO7+3UUlf3L/Kn/pBb5Hza5JQn7bTmMSvHJh/lq10F
         O0vlojDiwwAgeeO33Zg3uSAwMVkR73D4vjgeUFGQUTyozVXqc+3AG3BZpBBN33/D1wdp
         tkBXn8x47lxyNm2ZVbNPxqg967PWVwzsBvwlPdy791KQ8+evxmAgeIwvW3D1osjBBEWN
         bCNCjihH2NNb4vwPLktjCuOo5VsobDmqLq9bT3YSeW1f8IuV0TN2ckv1GXj5R2T72wHo
         MJh23bCWYpVUpL/DzD3yg46twxTDfRoD0uCEEH3NNmfXVqwdbzNWr3zK6vhx1LBaXAXt
         WfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716332999; x=1716937799;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WVlapK7IICqNZRk9AkY2koCiGjAfMcvjxFmJh5c+ZKA=;
        b=F4f3e8cf5lxMd8IqlhciIG/piZFSeZtr5YjfM50Tx0DUpjTQhJd9kES0nUYwbWUrnk
         5ZVssvwyntO9iSxOjohQhNCYkbqak+qiYR9nl9NDh3bMv9rBZwFTfwfBHbqpYL/+zzEJ
         XjW65IsbcOiwYZ+oAgn62p7dalZZ8BM0U0B6/Zq6zO9i5Gbl1HbAop6jAXA34U0b6Ubx
         tyBXtfNA6jqo2rHTOoiAd9/zSdcQ6DVRE9Ku2sWwbCDJXyGdB+//8kois7EXk73yWe7y
         ZdJd9i7bocKNb/wTBR/xeFcKqgvRwokpT8IvGH3Iss5/4EXmjuJM1ruZlUBfd39BgNnE
         64qg==
X-Forwarded-Encrypted: i=1; AJvYcCWvMqWEth87is1PRvDEHs0zlKYHOdXsClgL0WJvh8P+fwkf42xr8Lvz2tvN/YZL2w0+vGQrEk8CpTT/S4vTs2F69OwzqvYAGCaWc9Y=
X-Gm-Message-State: AOJu0Yx3CaL4+b9UbxE0N1NxOXOQmyXdh8qtB3KHzniFidL1KNIrSHva
	Re22Br5ntsePNAO/94wmkwYz1JMnZzazUNwA9VZTnzhVgB+4ggWC
X-Google-Smtp-Source: AGHT+IEUSJRxNrS6yUKVErdzlXWzg1sH39tRKWgKSQHqMOwe8nC/k5w4dzEH8hp/XPLGR9/bKnntHA==
X-Received: by 2002:a17:902:7d82:b0:1e3:e1d5:c680 with SMTP id d9443c01a7336-1f31c9f8a37mr4576725ad.63.1716332999363;
        Tue, 21 May 2024 16:09:59 -0700 (PDT)
Received: from [192.168.0.107] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f679902e57sm10876926b3a.110.2024.05.21.16.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 16:09:58 -0700 (PDT)
Message-ID: <32775b1a-7bc3-491f-bcab-af48d2d82d79@gmail.com>
Date: Wed, 22 May 2024 06:09:49 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Garbled sound at start of a playback after some inactivity
 on said channel with DP/HDMI on RDNA devices
To: Mark Brown <broonie@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Sound System <linux-sound@vger.kernel.org>,
 sound-open-firmware@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Mete <yurnerolinux@yandex.com>
References: <ZkHKYocpP-abFwLB@archie.me>
 <03d0fd01-278d-40ff-afcb-7107394b89eb@sirena.org.uk>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <03d0fd01-278d-40ff-afcb-7107394b89eb@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/24 01:36, Mark Brown wrote:
> On Mon, May 13, 2024 at 03:08:02PM +0700, Bagas Sanjaya wrote:
> 
>>>   Device-1: AMD Navi 31 [Radeon RX 7900 XT/7900 XTX/7900M]
>>>     vendor: Sapphire PULSE driver: amdgpu v: kernel arch: RDNA-3 bus-ID: 03:00.0
>>>   Device-2: AMD Raphael vendor: Gigabyte driver: amdgpu v: kernel
>>>     arch: RDNA-2 bus-ID: 12:00.0 temp: 39.0 C
> 
> You've CCed a bunch of Intel and NXP people for some reason but whatever
> this is it seems to be an AMD issue?

Yep, I found these addresses by `scripts/get_maintainer.pl 
sound/soc/sof/amd/rembrandt.c` since I thought it was rembrandt
driver issue.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara


