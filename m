Return-Path: <linux-kernel+bounces-516625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 653CEA374EE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 16:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57F4F18902A5
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 15:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38D81991DD;
	Sun, 16 Feb 2025 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="ThQddU+R"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11252192589
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739718681; cv=none; b=kWu9Hv8YeL254c+YLZOTEeZrUXWi9J3UIQYSR8LhSD6b8UwPA0jr/vVk7W14yyE6Elolm00VZYgdZ6nGusK4n4tdGeXnrGThaaRFbAm4SOVecRpE10yAO3pvh23phhEsJo9po7wdwJ14voFjvYqDmtO070vCppAeMIu4kAjZlKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739718681; c=relaxed/simple;
	bh=4IQ0g5KvyuNbmI4QCx+VPX0qeUVxl+rCSR4p41A6Qs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cTR3aiYTr1sb9Pw7sziJMu4AJsrAElMOzI3WSSPCbWuyD8V/w4xGxSKLuDNKbmyI01C4Sr++skwVFaAUaf1/xzhL1mQMIDilUhJ7WExXEtdF3HZpeVDf9up7EFyuCPDq1CgkxuI7I3h/U3e1sXVXJ20ahfZAMdO5Zl2gHe5du/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=ThQddU+R; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaec111762bso814908366b.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 07:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1739718677; x=1740323477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XxEs174tgEejEhOGBs+mL3V6fq9DUU/u2mDzbjv/spw=;
        b=ThQddU+RMy7z0OSUJzzrS1h5g8C+aFHJEUpCeFTZIJjxuUuZtdmKhMSIQC4n94wsMA
         pDafPzHJ9SHhih0K2pNSaOECzLZF2sw4Sflu7Qp9Vp/gSgbYl4P5wPj+NSMhOmlVag/O
         q5meUpCfPzJgianjuaexCNE60Mhx7lfj6eiEJssnoi6ar4ubQDGV7uOkoD2r/g+JPqtM
         IEGNyUMPGTvd3GsvqA2z/npDltepLpNt/hTdYtVUtJ8bezynKDFcwYf7dPxWYQcun3N5
         uyEk8WG+9L3ZE3iHT6G7jtFsOEKGOGhAwvBnTkk4SdNdvPB779Th13jhGSsyKHpPBeBN
         xLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739718677; x=1740323477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XxEs174tgEejEhOGBs+mL3V6fq9DUU/u2mDzbjv/spw=;
        b=ihmVJSA/cdqy0ZiEmeyTVf/xHcBZz2hCGblf/c/uzC7/MwOaWcXQmKolgIGRwalhn9
         HJS9xmc10MRBsavbAOOOtuFMbaBhIjPX8nRnBo12HTdein3xqMj776EdC25m0Tqh0/Wx
         TH0P+mfvtmN2zm6jdMYII9Scnma6W/wWfSTsAreyn6afPXk2Cc7HDaMHg5bmInCZWqLE
         0Yv9ibt7KQJWiu8DZs/f73TvFWA0ZIT3Sih+nr4Nhvzv9SdKywdbaQw07dOJK+SbACSl
         7EOOzwIdauN09nyJVenJb+AXI1PWXrtuiTH5gMT9D8oiYVl1mDdL8KYRdb3mqMu1USe1
         o3Yw==
X-Forwarded-Encrypted: i=1; AJvYcCV4wiCiNtg06BE68wIduumjIvc/UZp6QvrtDwbQG3KGF9168QOmrQf4qF+ul3UwhssHgZSzwFFiZxjhxlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoMbi3hpuCXZKCaccHKBr0ePviBonZ4LLDxSYVfvPEYvhO0k4o
	AvGgQku8cSGm8R9xM4Q182eQxuDq5y+SF0B0wfPzgjcaj6PSQ561BeqHf7NJP3w=
X-Gm-Gg: ASbGncvOkLodgl348aVMlhJYNybuXHY0c5lDUoBDI5pBhWz3AmqZsGhlgtLfeB+iKx8
	POi6DR6dU6zgfLxi78iuCiLvQtIgw64bNkVUXuX5E4Ce/4g0pVB/9nR+B8cAjI0TQWmjxrWOCSb
	JZCcT//aWqGoZLGhSau4i2vtaB6i3OxK7IZm3TG3H0sEaR6vf7A/FDEhVfOF3LZf/ZR339MEK8w
	o76+9UGNIKdP0DAc+x7F4kJeEwqO2MGHLHnxv4Ws+AURI+oy8royR5g94wMTX/VHQWkaQSNQ0iI
	PIQuLgMUdmu6iCItdR9SnZVWEq+ylcZ6BpQ0nBCTMR3ksz8=
X-Google-Smtp-Source: AGHT+IFJErHfiwjq8OuATuDMBXLWRjnh3cAPDyG+uN8XMo+VzOnpfp01aY9p8urTKh5hiaXOlWw+3w==
X-Received: by 2002:a17:907:7f27:b0:ab2:da92:d0bc with SMTP id a640c23a62f3a-abb70c01ecemr672451566b.3.1739718677216;
        Sun, 16 Feb 2025 07:11:17 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece270967sm5963200a12.55.2025.02.16.07.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 07:11:16 -0800 (PST)
Message-ID: <684bc34c-ae15-4cff-9e44-945294ee233b@blackwall.org>
Date: Sun, 16 Feb 2025 17:11:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net 0/2] bonding: fix incorrect mac address setting
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jianbo Liu <jianbol@nvidia.com>,
 Boris Pismenny <borisp@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250207092920.543458-1-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250207092920.543458-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/25 11:29, Hangbin Liu wrote:
> The mac address on backup slave should be convert from Solicited-Node
> Multicast address, not from bonding unicast target address.
> 
> v3: also fix the mac setting for slave_set_ns_maddr. (Jay)
>     Add function description for slave_set_ns_maddr/slave_set_ns_maddrs (Jay)
> v2: fix patch 01's subject
> 
> Hangbin Liu (2):
>   bonding: fix incorrect MAC address setting to receive NS messages
>   selftests: bonding: fix incorrect mac address
> 
>  drivers/net/bonding/bond_options.c            | 55 ++++++++++++++++---
>  .../drivers/net/bonding/bond_options.sh       |  4 +-
>  2 files changed, 49 insertions(+), 10 deletions(-)
> 

For the set:
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


