Return-Path: <linux-kernel+bounces-398491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8536A9BF1E2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70981C23725
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23522040B7;
	Wed,  6 Nov 2024 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="i7q170w1"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8562036E2
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907602; cv=none; b=UkjWM8XLuzEM7RBJ7+Hmq56p3rDTCRBUS3qO/KUJBteraA8S1UNPd5oHjFsKksItLaF6hdUzbbXs29KSijPBKi9n0AJRIIGqe/yIIl0TXM3RWj6qZw/HeRnI7p4x9WeMFQcsi37R7/efph+8sBrUbua9q7Cf4pecgHA+I4VGGL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907602; c=relaxed/simple;
	bh=PLn+HGkBBwpOW7CICc2SyOy0BDrPR4BmKQAFCYmIWqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVKgOM3iP5ZlSiC+C1o8E4KVpkYyT4znOOizH6ZU8DMu2+jIGcdylMQ28r73/OmT9LA52hADnedJRrzr04+Syk7CqtdI6kntD/tNleL2M/dhODs3KB2KiJqj5aBOndXkEg/qyKbzjVhHHPKRuquW76uUhMrKXRQMfVGtPtZ5yuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=i7q170w1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4314b316495so59382775e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 07:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1730907599; x=1731512399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T+lke+kSJ/sHNhBrjG2QR3DbhnvDmE7dM4quD4X0oVI=;
        b=i7q170w1oBFFo2ijcUpH0lB3v2ORF8xyY6czqMAPtMNiOz+YQ7T9BxfwERp1rZF5Yv
         tLlEs98O1nQGDewYLnxBxZfbz6bEfavoBMlAoty7XVruSOEWKQYUmdqgF/X4iXfUlmCG
         jWRUk5gAjZ0ydnut8JrbiGsIMxsnTEI2TMVr/qjX9KDjb8R4Iu1tge4speLCNG+6/ATl
         ZInyIlapWbtEI/9qPHP1aJUexYoLS4Lbg943F4TUB9q7frR3IB4WkZzaU2O6PgZPOpYu
         AHzCkKSw5EMOgtYA5fDfrQ0FVlq8xgoeSM9oRWzgF195VIBZcP34OznPUUjpWduRuZYh
         nZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730907599; x=1731512399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+lke+kSJ/sHNhBrjG2QR3DbhnvDmE7dM4quD4X0oVI=;
        b=HHT6XGMD0y5SsoyC7T6gavQkjoKi+MmzQrot16zmgazc6XlTp8x+iwL9e2+7LL2ZWw
         5wPe3VfXgU6rSCQN27a4WZOxeTYtBty9DJy3MMeVGL9v/INNi1F4tApPnv1OdHnr6WJb
         4zy+/H+ZkP9o9h8iP3RGS83n3pYcUKK6aYQlu/vPqydQQcAvjUSJls+m+rchfB7CDmwp
         gzLg044lz6Pu9YyFV1jGpDT6z0gpXcGrVRIT0CIN+9dOMREG4LLmyMXFYoJOXedv09em
         v3rrroS+zaRKrNM5IlJNJpRRO7FECeXAEnMMdYiWdcnmu2cx4ndszXmSKNIIda6dQpeP
         WfdA==
X-Forwarded-Encrypted: i=1; AJvYcCV6mm7JOPHRgErrhlOhdVwehvK7b+pt0MV4ctBXI3dVpBFVvjS07dDJ2HTyFgWvTr7zyYOiQD4319IL2Bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YySoytyTcAogacrKIc0Bw4OYiMA7Dk6uxy8H8yP7mAHI59g1rPt
	sqoyDP3x3voLhoqDz92YKCpiDuncaaGogw+XKt8/iUTfCVQzEDb03I9cMkgKqMk=
X-Google-Smtp-Source: AGHT+IHaXpKkIZTp98WaTVKW8arf8yLJ6KlxXz0Ga7zfB6YCb98iODL5Q30kaHjC536zM+O/RrwHzA==
X-Received: by 2002:a05:6000:4711:b0:37c:cc67:8b1f with SMTP id ffacd0b85a97d-381bea0ee17mr17133942f8f.48.1730907598706;
        Wed, 06 Nov 2024 07:39:58 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7b32sm19556510f8f.18.2024.11.06.07.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 07:39:58 -0800 (PST)
Date: Wed, 6 Nov 2024 16:39:55 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: geliang@kernel.org, liuhangbin@gmail.com, w-kwok2@ti.com,
	aleksander.lobakin@intel.com, lukma@denx.de, jan.kiszka@siemens.com,
	diogo.ivo@siemens.com, shuah@kernel.org, horms@kernel.org,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, andrew+netdev@lunn.ch,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next v3 0/4] Introduce VLAN support in HSR
Message-ID: <ZyuNyzu0kv1_pemU@nanopsycho.orion>
References: <20241106091710.3308519-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106091710.3308519-1-danishanwar@ti.com>

Wed, Nov 06, 2024 at 10:17:06AM CET, danishanwar@ti.com wrote:
>This series adds VLAN support to HSR framework.
>This series also adds VLAN support to HSR mode of ICSSG Ethernet driver.
>
>Changes from v2 to v3:
>*) Modified hsr_ndo_vlan_rx_add_vid() to handle arbitrary HSR_PT_SLAVE_A,
>HSR_PT_SLAVE_B order and skip INTERLINK port in patch 2/4 as suggested by
>Paolo Abeni <pabeni@redhat.com>
>*) Removed handling of HSR_PT_MASTER in hsr_ndo_vlan_rx_kill_vid() as MASTER
>and INTERLINK port will be ignored anyway in the default switch case as
>suggested by Paolo Abeni <pabeni@redhat.com>
>*) Modified the selftest in patch 4/4 to use vlan by default. The test will
>check the exposed feature `vlan-challenged` and if vlan is not supported, skip
>the vlan test as suggested by Paolo Abeni <pabeni@redhat.com>. Test logs can be
>found at [1]
>
>Changes from v1 to v2:
>*) Added patch 4/4 to add test script related to VLAN in HSR as asked by
>Lukasz Majewski <lukma@denx.de>
>
>[1] https://gist.githubusercontent.com/danish-ti/d309f92c640134ccc4f2c0c442de5be1/raw/9cfb5f8bd12b374ae591f4bd9ba3e91ae509ed4f/hsr_vlan_logs
>v1 https://lore.kernel.org/all/20241004074715.791191-1-danishanwar@ti.com/
>v2 https://lore.kernel.org/all/20241024103056.3201071-1-danishanwar@ti.com/
>
>MD Danish Anwar (1):
>  selftests: hsr: Add test for VLAN
>
>Murali Karicheri (1):
>  net: hsr: Add VLAN CTAG filter support
>
>Ravi Gunasekaran (1):
>  net: ti: icssg-prueth: Add VLAN support for HSR mode
>
>WingMan Kwok (1):
>  net: hsr: Add VLAN support
>
> drivers/net/ethernet/ti/icssg/icssg_prueth.c | 45 ++++++++-
> net/hsr/hsr_device.c                         | 85 +++++++++++++++--
> net/hsr/hsr_forward.c                        | 19 +++-
> tools/testing/selftests/net/hsr/config       |  1 +
> tools/testing/selftests/net/hsr/hsr_ping.sh  | 98 ++++++++++++++++++++
> 5 files changed, 236 insertions(+), 12 deletions(-)


Looks fine to me.
set-
Reviewed-by: Jiri Pirko <jiri@nvidia.com>

