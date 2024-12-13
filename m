Return-Path: <linux-kernel+bounces-445299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9AA9F1457
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12E93188D759
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0849B1E8823;
	Fri, 13 Dec 2024 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="nC9VfrgA"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30C71E5726
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734112233; cv=none; b=ievCwLQlQ3p28II6+1tq96s1KS6dGm0oPHKbUcDpl696ml4iase2IbslH0Q9eZ2UBaevy+KtnIosdfcdVD8z4tOkjkc/lYDJRf3YAdFLw8uHNfNWy5cYzowPeAR5JVDa/ynK/r+HLbqPfh5Op4TmTZQKyv4lnwB3Gqm0kYqaJZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734112233; c=relaxed/simple;
	bh=Y3Lw72vZuT13nlVwqizEU4xTOq9iG+Ko8FT1M6jDu4U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HKLTo6NJiuseiSAmZyA/LDnNUiIV7KjfuUxkzNMrRuMpjMSWp9X+4l+LR/KngaG6/APXwN3+vEpAM6AC0wQQ1ArihPxeBqxh++fEzyVdOnbsrF6YlqoSP8PSA4InYlP8Wj+5gp/OEup+xVw6+fCydR9LIsc5KXL8TzU9WHcq+a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=nC9VfrgA; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-728f1525565so2465732b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1734112231; x=1734717031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TowrwHHo+Z/Rbfx8dYSOWZVrv2+F8jb+aOKcTufy/9s=;
        b=nC9VfrgAQG5fNQwOWI0kYm08Xf85UI8noMzCM1xDhnuiWEWUNB0kgdRtRzK6YOWS/9
         wrWuDW+ouj2j1Nb6+hGSh8vHlq9L+9qQDhOW5vjo9l4HS5aOPEuIUzXeAiKoOWsgTydp
         pNx5EK9mKlHqu2NKseCpH4N1wVgXgHpZJINEwtWonotZbPyK+WvwoQMyx2w+V71dHbOb
         ourFCPwEaJM4/HLw4NYk4n0809g4jBSuTxDLoh6xCVLtXqJ4EXrofi+9uKpuIUVeYdVh
         g1/tEaTudrbzvJ+yZVd0S1pzuMF0FgKvAT8+MzsmCVvZXRnvqiwZgIFkKFaMvh+YT0tA
         QZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734112231; x=1734717031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TowrwHHo+Z/Rbfx8dYSOWZVrv2+F8jb+aOKcTufy/9s=;
        b=xLOw1KRz0Ug9CA0s28bsXzXEBD8/NKu2kSA7Y0+Vj/cPY+0c6k15tRm9RtCCGsbiju
         696uclLib8wKcbcwbbiqfNsECUkTYWRzImUEkBEzjndZW+d5KOG1bbNaTQxopa8m9NOe
         vjAl6dWA64jrWsjWOT+CGtjCRI/hSGKUMdiyvT5tHtX9D9Y0gh0NotidBjrp2EjEcE/f
         WPBxWHHJUpDlEoVDkSJdBDL23UxdvpIAsqcvc6z6wAsitG38m9flAtRvII/UFM3++xRR
         VXk9yiJoWAfma+56KiTJrqrNBnHAi+OJC/Q7LbcopCCujQxHCIN6CXmRwK1JmJztZXjR
         cHZw==
X-Forwarded-Encrypted: i=1; AJvYcCUmHVHt1pG2qguXJjEX0dxeuNoJmr1BW3uVm9/ArtA7JFYrXO65GVmPMZnLr7g1ov6zJv9YbV55+f09GV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVbqwgsWy4uhv4sLbRtPLfGh7r25kQAyjMSW6zU+YnvixBSweY
	3HWn1OVFezA4M5hTSfSP/Z9VUiB0ahlA+xdl8uf5WmInexGPj0Om5phELKQvqjcAwc/Z8IgQpBy
	o
X-Gm-Gg: ASbGncsTp3AF/c8aWlK9UWKEVKM712q0AJye8FfDys3+4zn2yhE6eiUpkrxXtONvJdh
	RduPJXNdlGnV29Xk4iPi5QBSx+H8RX0n+iRMP5EChEZ358RECj2GolulNwaoOqk7UhyB/so1/HW
	wsXYCuKscLfo3SDAi4gUjeaOfdeExu5D0om0EoXMmKYrbVwjP15K9mGFbAAvLo70lBLHtqXd6US
	PXk+8QYFYPQoNx7oIuauJEh4fIp8JVGt1tueEINprHhmUMQJlmQ/r9TR+26ySVb2PrkHctgxmAz
	Q69/AMxlJPQxMimLyas3YV+GLoJv1SjJOw==
X-Google-Smtp-Source: AGHT+IHkiY7danHaI2/4tVyIk19f+i6/bLjvhn/gEfEFpMSrj8uqnFboP56GlYXHaxZWng9GURQDkQ==
X-Received: by 2002:a05:6a00:419a:b0:725:b1df:2daa with SMTP id d2e1a72fcca58-7290c248bebmr5836996b3a.20.1734112230993;
        Fri, 13 Dec 2024 09:50:30 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ac52bfsm58567b3a.26.2024.12.13.09.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 09:50:30 -0800 (PST)
Date: Fri, 13 Dec 2024 09:50:28 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: longli@linuxonhyperv.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Shradha Gupta
 <shradhagupta@linux.microsoft.com>, Simon Horman <horms@kernel.org>,
 Konstantin Taranov <kotaranov@microsoft.com>, Souradeep Chakrabarti
 <schakrabarti@linux.microsoft.com>, Erick Archer
 <erick.archer@outlook.com>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, Long Li <longli@microsoft.com>
Subject: Re: [PATCH] hv_netvsc: Set device flags for properly indicating
 bonding
Message-ID: <20241213095028.502bbeae@hermes.local>
In-Reply-To: <1732736570-19700-1-git-send-email-longli@linuxonhyperv.com>
References: <1732736570-19700-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Nov 2024 11:42:50 -0800
longli@linuxonhyperv.com wrote:

> hv_netvsc uses a subset of bonding features in that the master always
> has only one active slave. But it never properly setup those flags.
> 
> Other kernel APIs (e.g those in "include/linux/netdevice.h") check for
> IFF_MASTER, IFF_SLAVE and IFF_BONDING for determing if those are used
> in a master/slave setup. RDMA uses those APIs extensively when looking
> for master/slave devices.
> 
> Make hv_netvsc properly setup those flags.
> 
> Signed-off-by: Long Li <longli@microsoft.com>

Linux networking has evolved a patch work of flags to network devices
but never really standardized on a way to express linked relationships
between network devices. There are several drivers do this in slighlty
different and overlapping ways: bonding, team, failover, hyperv, bridge
and others.

The current convention is to mark the primary device as IFF_MASTER
and each secondary device with IFF_SLAVE.  But not clear what the
right combination is if stacked more than one level.  Also, not clear
if userspace and other addressing should use or not use nested devices.

It would be ideal to deprecate and use different terms than
the non-inclusive terms master/slave
but probably that would have to have been done years ago (like 2.5).

For now, it makes sense for all the nested devices to use IFF_MASTER
and IFF_SLAVE consistently. It is not a good idea to set the priv_flag
for IFF_BONDING (or any of the other bits) which should be reserved
for one driver. 

If hyperv driver needs to it could add its own flag in netdev_priv_flags,
but it looks like that is running out of bits. May need to grow to 64 bits
or do some more work to add a new field for device type. I.e. there
are combinations of flags that are impossible and having one bit per
type leads to a problem. Fixing that is non trivial but not impossible
level of effort.

My thoughts, but I don't use or work on Hyper-v anymore.


