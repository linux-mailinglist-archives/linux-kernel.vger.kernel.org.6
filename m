Return-Path: <linux-kernel+bounces-569190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10B7A69FB8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E9877ADF6D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 06:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460E91E231D;
	Thu, 20 Mar 2025 06:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="trrMSK4A"
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDAE1805A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 06:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742451447; cv=none; b=XXMO3GjkJDZpp48hOOT3xldBoe/Kt/r49Ce4p++a8mIYFlkB4kD1q+9O+21umJytqHWoMXsFcruFrw2j/ZtSxtzRrRcu8C5b2jkToiWKwXtWu/RLLzU7seQlvQO3F5ah7xTu1IWHa3FBUyA3XXQ5RlBKopTuAfLBdHI0cQfZ33A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742451447; c=relaxed/simple;
	bh=u0U9bVg2lTqsZtEo43vyK265DyxWNPo+6MP9a1qN1ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c2TKtzlEOrjYp8TeEZWeWxmPDMbC0sNBf7V0974aijZoEBElzCeiq8RfDsk0M1Hoi859IGXIzeb+5WgGwpUB35ZsvlMdptd5pX9Vz6yHjL0jNRMuVMTnpU7KfXnAeJeiMF79+VQmrLlnIPOHxMOrmdBI0marYpH7wzHZ5kcWzQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=trrMSK4A; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so3608385e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 23:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1742451444; x=1743056244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Df7/nJm6vBgqBIBBRK3eHSwVNX23gpqGbDFzSsS2AQ=;
        b=trrMSK4AvddFzbFgSN4FqY1NjPigR15ik+udqyRYhxt/ugMvuBxi8KW1Qrxnzugz5L
         CubTgW+JixVYA/DOOBNbKZoAeMYsiy1wzDRc4yvxtKoDtcKKnsS/wBiM+WtrKfV4p6Sy
         IHDWSq1MKmOfwK0GJgdlQJgNZzFsASEye7wHm8aBk821tO9Onp2ajQPjc431qsiO0qN9
         NE3QTY6Otv1HGxXr5v/xvzukk4G8hXEXot7/T6Xmp5IvBWgCxMJuIMP5rZlcpWdCVqUL
         9u02hCsBqHx8xuYEgkamJuBnd6FkPBRqMhvfXmvkWdPkhGCnYXLpQcdv7U+EMYh4HF9F
         /Png==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742451444; x=1743056244;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Df7/nJm6vBgqBIBBRK3eHSwVNX23gpqGbDFzSsS2AQ=;
        b=ioUF7IjYkXTDiN/wGFeQT/UUBzL4sCh1249xsNrqZmXlI6GiosNzZH9d73AEng0hnM
         BCsmJIf977AFhpXIVe6yIJDBghtIdbgxnSv+xZcuSd2MeKTuEslJXxCNOLwF6Lfp2zJB
         cNVUrXGJuNWOjToAlbmHphEAdsx4y8ccdy3fJ6HC8fgCG/VIcC+mScS+ZKmc15ZMnHJt
         12vJvrJl8zRfMxBBWNudq2mIPwzirm6M1dl+NhzOZpdowPhFznd/1nMohuDDVtkhTgdf
         ShbF9WS3bTJt4R0/1OuFMpPKUNvM0FZ20zsIyv5D7+VuLGgbZsYcp/9/rcbeD/Um5bhK
         i1dg==
X-Forwarded-Encrypted: i=1; AJvYcCUjivVQ0B4YhNcla2XlgunePqKpq+n0wbhAQA7a2IvNXSFadles33JideWuxbWRBrivKmqYQ9kYjXvd5Hw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Q3sJKwfiThXu1t0LT5ppOr0qUNxEPlSjNjJbt0KgKXjL/LHQ
	kxzUlxhKQdY3cwQ3vPjPXonelkovuutgF3YDo9/7HSrIYLcnSXa4R3oHm0Cado0=
X-Gm-Gg: ASbGncv9t92l7yxiDZIi4+n2EdaU4WIzlvFOzwrvK1+T1ty7OxChYS0FrDV6cTztv3C
	n2JS0EjUx1Il0M6msrZKAy2+9r4f3/KvYZOlZIovRU/CXS4vl2W2lKhFdys7gRd7aHvhhNpUwAx
	YPiCoLw0B84FR08Tq6gOIl43IufSFdK5HK66ktyVaXja/9ee8gKEU8O25hRbhfv0ozb5vHuWW8u
	1v2fyR0SWD7OPoGT7ek2ougeSM7ZHGdKOnCULep++nkUsLR9NM7DMWJDSTYshCAoiEZTmbVTDcq
	XLjks95Zzjxmi+Zki9XGaPf8L1MuXqsfDemARMAhRB93YSjS01tcGotF67MWyGGiNXeK7nVmPXv
	S
X-Google-Smtp-Source: AGHT+IFwempKLPIhGnUTH6lwknWETQgWZuRBG0LDbF84yzf+Q+5WGmrF5EoT6BHx9aMLp2qTRB+XVQ==
X-Received: by 2002:a05:600c:4503:b0:43c:fffc:7855 with SMTP id 5b1f17b1804b1-43d437c3327mr58255665e9.15.1742451443872;
        Wed, 19 Mar 2025 23:17:23 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43d803f6sm39439615e9.0.2025.03.19.23.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 23:17:23 -0700 (PDT)
Message-ID: <039a0673-6254-45a0-b511-69d2a15aa96d@blackwall.org>
Date: Thu, 20 Mar 2025 08:17:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net-next 0/3] Add support for mdb offload failure
 notification
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Joseph Huang <joseph.huang.2024@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250318224255.143683-1-Joseph.Huang@garmin.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250318224255.143683-1-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 00:42, Joseph Huang wrote:
> Currently the bridge does not provide real-time feedback to user space
> on whether or not an attempt to offload an mdb entry was successful.
> 
> This patch set adds support to notify user space about successful and
> failed offload attempts, and the behavior is controlled by a new knob
> mdb_notify_on_flag_change:
> 
> 0 - the bridge will not notify user space about MDB flag change
> 1 - the bridge will notify user space about flag change if either
>     MDB_PG_FLAGS_OFFLOAD or MDB_PG_FLAGS_OFFLOAD_FAILED has changed
> 2 - the bridge will notify user space about flag change only if
>     MDB_PG_FLAGS_OFFLOAD_FAILED has changed
> 
> The default value is 0.
> 
> A break-down of the patches in the series:
> 
> Patch 1 adds offload failed flag to indicate that the offload attempt
> has failed. The flag is reflected in netlink mdb entry flags.
> 
> Patch 2 adds the knob mdb_notify_on_flag_change, and notify user space
> accordingly in br_switchdev_mdb_complete() when the result is known.
> 
> Patch 3 adds netlink interface to manipulate mdb_notify_on_flag_change
> knob.
> 
> This patch set was inspired by the patch series "Add support for route
> offload failure notifications" discussed here:
> https://lore.kernel.org/all/20210207082258.3872086-1-idosch@idosch.org/
> 
> Joseph Huang (3):
>   net: bridge: mcast: Add offload failed mdb flag
>   net: bridge: mcast: Notify on offload flag change
>   net: bridge: Add notify on flag change netlink i/f
> 
>  include/uapi/linux/if_bridge.h |  9 +++++----
>  include/uapi/linux/if_link.h   | 14 ++++++++++++++
>  net/bridge/br_mdb.c            | 30 +++++++++++++++++++++++++-----
>  net/bridge/br_multicast.c      | 25 +++++++++++++++++++++++++
>  net/bridge/br_netlink.c        | 21 +++++++++++++++++++++
>  net/bridge/br_private.h        | 26 +++++++++++++++++++++-----
>  net/bridge/br_switchdev.c      | 31 ++++++++++++++++++++++++++-----
>  7 files changed, 137 insertions(+), 19 deletions(-)
> 

Hi,
Could you please share more about the motivation - why do you need this and
what will be using it? Also why do you need an option with 3 different modes
instead of just an on/off switch for these notifications?

Thanks,
 Nik


