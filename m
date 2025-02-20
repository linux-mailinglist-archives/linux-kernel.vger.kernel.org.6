Return-Path: <linux-kernel+bounces-524037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A224A3DE51
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1517F18861E4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954611FCF45;
	Thu, 20 Feb 2025 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="FD+/nqgJ"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CF41D61A3
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064882; cv=none; b=WlJ6uu+1zWPND8IWztZgxom7CzOM0CyZ0kx+pB3D7gPb8vefYHVJc3v7dv6FsQzDDtH1lIXc6tiNP/la3DfcZqj49HJaIaffAFRumKGfSmAOTBFjGw4S/Pt7hN1T+WhpcFzlXqZgbRAr9hId/Ppn5z8EjD65p6Mqd1KyFov1mw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064882; c=relaxed/simple;
	bh=lc33ASecIyHOG/Bouzl84JzYnOwb0Ap4Hk7ODwMwDpg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=a6eyiGXlqaSRY7bbdHkXuwJnG7cPbbqQjj1tCKouWDVboewxK3wBQlPYzf1dnqskdDv3TMXIlubKMNUin01U2cxvnlV9RVWINMK5P82y+sdcfrngHLeWEFqFbduTuz7T/vmW17PcS3uAjPkLtYY3c9a753Q0xaRbOLOXNhWG+NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=FD+/nqgJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so7376915e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1740064878; x=1740669678; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9c6akN4U6N1j5lHvxO5m+AhJP87KfyoW4nGzGcG9XVw=;
        b=FD+/nqgJXe55oHJ5nBylF0J1vOTOInARFVgzM3BrRF9YJzd43K7An6kkAVhKSl+Txt
         i+tjZ1eqDPHAOQG1Jkp3px6wxRfG4xjuOQYQNIPw8lWWaXjH8R+Dvox5qvEiUxEY+K3T
         n0nOKKzrFItBDR+bT9Mj43Arc7aQbsEzQb0rxfcmY3GQqgUmv2QOKm1a19svbYmxRus2
         0d2s5O84dL4Eo6ORwzCV1lDe5M/5CBF6mIoJofAHmuEOLu1QawD9cRFK8JKkH6RQKQpd
         BFkPWJ4QyEfn+o/nSUrorB9cW/49CQWQoSkPN7DhtsIfd6verqSbtzdu+rSdWKNfGOQ+
         Q+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740064878; x=1740669678;
        h=content-transfer-encoding:organization:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9c6akN4U6N1j5lHvxO5m+AhJP87KfyoW4nGzGcG9XVw=;
        b=Dicv8ranGi49OH5ZQSEW5RdT05ZT8IsSnE1JSMTc55TOOjQ9FXvb1bU6VhfpoFOzOn
         nOwMOvT1nLlNDos7dJV3/qponfjMrMfYjS1oYf6/aF6YGw0JgGdpPISH2Kaf0WCDczKO
         qRP8ws0a/JfznHnBi97zSfZ4eaGZlvRBBqQi74YFMFNuL/2WgLY3rqEgudYhZpPfL59Z
         SzBaTyMGdvV8NId8jH/g1tNktN1h+ifBtXSa/CgodQXfOiV/Ouml6i6WZ6emldiI7m5p
         vyo97vVOvh2Zbhffa9Oq/OVECihWJG6St10+t79mV03K8T83yp7mtpoFKqJKKdYH7gN3
         pc1A==
X-Gm-Message-State: AOJu0Yx0ZiFy8eU5aF6PGcqk1erZJ+CARnGeIM1IxXW4dKUQUTl/y9HZ
	KtBegIdWw/MfCfFVmHWlo9RNBnWakLH+wW85tVYKhWgEF/JQOv1rIS9cWNIlUlk=
X-Gm-Gg: ASbGncu7TImOtnY+9WcjcVnP6VBuVlEetoGRXdcx4tvpxdNna5SE4dSmi/n9t7KDpIf
	pAVyme4EGi39iHljAP/B2Msz0WUDH/AQbB+ubtwxI0Lyif4jk33vytdnyhpMlYjs0c7xlLZTFSm
	QTQXH7b863Fr2RaCEUbSKf0fUYuKfMQDXyaXiyl9dDCGsJTqhOlHh/SMORmfmlgi5l+nhK6372O
	z/e5CQGZ2uH0WAU9NPCPtcHJyrO0tHaHOl/bmcH4PGKz1IY3ih11AX9iflmjaS8qZ5+22tluTp8
	W2faRTqnPEWx+3ACXuQKGC/L25HLI2fKkugdF1Ii267NQG8yGQHeNJdN
X-Google-Smtp-Source: AGHT+IF72B8PeU55Z3sgL3tW6dfxk/MwISwqpinGcc+knKt0qvcvgeetMqZ5K54wjAsMBACSydwSkQ==
X-Received: by 2002:a5d:47a3:0:b0:38f:37bd:1707 with SMTP id ffacd0b85a97d-38f37bd18f8mr18940578f8f.0.1740064878244;
        Thu, 20 Feb 2025 07:21:18 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:7ff5:51b6:ef4f:eaf9? ([2001:67c:2fbc:1:7ff5:51b6:ef4f:eaf9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4399c41022csm49752735e9.40.2025.02.20.07.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 07:21:17 -0800 (PST)
Message-ID: <85894bbd-05ef-4e40-acf9-98a079c9e2ee@mandelbit.com>
Date: Thu, 20 Feb 2025 16:21:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>
Cc: open list <linux-kernel@vger.kernel.org>
From: Antonio Quartulli <antonio@mandelbit.com>
Subject: scripts_gdb: Python Exception <class 'gdb.error'>: There is no member
 named nsections.
Autocrypt: addr=antonio@mandelbit.com; keydata=
 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
Organization: Mandelbit SRL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I have been working on the new ovpn linux kernel module since a while 
and your gdb kernel debugging helper scripts have been of great help.

However, recently I have started hitting an issue I could not explain.
When my qemu instance loads the ovpn.ko module, I get the following 
output in gdb:

scanning for modules in /home/ordex/exp/openvpn_dev/linux-ovpn-dco
loading @0xffffffffa0000000: 
/home/ordex/exp/openvpn_dev/linux-ovpn-dco/drivers/net/ovpn/ovpn.ko
Python Exception <class 'gdb.error'>: There is no member named nsections.

and the load of the symbols fails.

Does it ring any bell?
Any help debugging further?

I am running the latest net-next.

Thanks a lot.
Best Regards,

-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com


