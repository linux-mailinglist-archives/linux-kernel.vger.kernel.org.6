Return-Path: <linux-kernel+bounces-395687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1C89BC1AC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 00:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBA13B21869
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 23:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78BA1FE0F1;
	Mon,  4 Nov 2024 23:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="PAupFm0e"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0695139CFF
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 23:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730764233; cv=none; b=NC8BwWfkenVgp6kWXo+uj6evHU+jIXKFIi+d/AHwivfuZtJNzstZSwsw/cbCR+Qc1H2Z4H4NaK7o9KdTz0A54R7Pd2WqgsNIQfrahQR67lccMlurjeBoCyzXqCzbEKeJ30zJvEq86Jmk9LAtAYgxRzkUemVnnl9+S+ZrVtonmg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730764233; c=relaxed/simple;
	bh=XHPVifGKXEqy8LE0q970p31W+sJjEWNZsP8R4d+Uo/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFQQb2mKD9sDwqBJqMHR/Y/JZGzH2y1zEsCeV9RKeIgpu+xwbvoDgBNDSo93G1oyn3RZPyLGZmTmkDbdK6xeVzDbvwIqipQqiXuYcP3cttpoQMK51RE0jxDwOjk5Kco794cutbq2pM6zWUsdPWsrJ/dcMWxPDsGBOhxhnS39bo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=PAupFm0e; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e49ad46b1so4200522b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 15:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730764231; x=1731369031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDd2iS+HO9f2ODni7moor8fgiPBiv84xu1qF5aO0f1E=;
        b=PAupFm0eJU7oNszuHR2EeZK4hapGIJPeBS8WlM8xPtypTNhw2aO46E27q2yuXrq6Bk
         DT7nizFxDqRWYe1NkbBl0n0JIAton2M8UXAPc+DOL/7Dt/3IWsvtk5Ff5ZZvVm0M3MTh
         aSMAKyfnTALzmerGhwNuWMGXyxqf560gmpK1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730764231; x=1731369031;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xDd2iS+HO9f2ODni7moor8fgiPBiv84xu1qF5aO0f1E=;
        b=U4+UUvFZRCgvQxmIxDXLnE4a4QYnEzN4G12iUUQpV0Vb7cSQPiOH/CcVnzPDVeF7X7
         aAHBdIGf606QcPLsw7t7+G7MSLwpVRfiBPre8KTFn9+CYb81EqOqQK4Sg2rR5CImY1Wp
         8BFjNjvWzazILYv9zMztpx0qgWkjoNS63lTSM+RHoIheHnCJw58GI1G9dTIyGQ9rgCMB
         /ztqGXcBg9Xur7Tbxesrcbn2U4tLVAFglXHsnxKGxQNRNxio2W9vZG/uA6D+z1xVWu/2
         TtEPhUlPHwokT4K/9r4FFNrTY4KXX73uPPkWy4Opos4BU0fTNSa2RDCTfcVKokvLSq/G
         SDFA==
X-Forwarded-Encrypted: i=1; AJvYcCWrtHsiFtISXWAlH8ehiisGf7/IrUjVWm16BFqgdTOf8k3dZVp+0uJeYsp8aP7lxsL5A8K38i3Xwa0d4gk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn0o0eDuYPX9l74YFDQUJ1fvY0qlm75XWWJG/dmkiqjCa6rIwp
	u46sfGdTV+UyUk50tuIQHVwugO2KOpQMhpV6oDriMkuhK14L/0rM82Y2ktxpHaRm+NCv+r60ZZ0
	0
X-Google-Smtp-Source: AGHT+IHWzRXiGYvo8KNQLD4r4zmqsgkH7TShcEy59N1FdgKJ1Bm2tsdY9K3y3uV5t2Tk3W5BdjOUug==
X-Received: by 2002:a05:6a00:14c9:b0:71e:cf8:d6fa with SMTP id d2e1a72fcca58-72062fdad1bmr45801290b3a.15.1730764231110;
        Mon, 04 Nov 2024 15:50:31 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1ef8adsm8276729b3a.84.2024.11.04.15.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 15:50:30 -0800 (PST)
Date: Mon, 4 Nov 2024 15:50:27 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v7 05/12] selftests: ncdevmem: Remove default
 arguments
Message-ID: <Zyldw-Ozq7PqbicM@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
References: <20241104181430.228682-1-sdf@fomichev.me>
 <20241104181430.228682-6-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104181430.228682-6-sdf@fomichev.me>

On Mon, Nov 04, 2024 at 10:14:23AM -0800, Stanislav Fomichev wrote:
> To make it clear what's required and what's not. Also, some of the
> values don't seem like a good defaults; for example eth1.
> 
> Move the invocation comment to the top, add missing -s to the client
> and cleanup the client invocation a bit to make more readable.
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/net/ncdevmem.c | 61 ++++++++++++++++----------
>  1 file changed, 39 insertions(+), 22 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

