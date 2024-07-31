Return-Path: <linux-kernel+bounces-268438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A32989424A1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 04:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B07C1F244AD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 02:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951F017BCC;
	Wed, 31 Jul 2024 02:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QVj3EDRw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44535175A1
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 02:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722394714; cv=none; b=gxQCph8/dsyYLf5JVrUN7cKPrd826hK75YU0bd1laF0Utv6B+HKu/0d3mETU1SPidPIdShR/Ozo/h0s2pbObmuBkv+QA+6m4m61OXynQON7z7cq9/cDASyBrtrW5y+Qou0Edy5qM+HZqdT3VHTfXXxrkCbKpSxdTrHwWQdRrA1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722394714; c=relaxed/simple;
	bh=EwBv2StcNSf/Rz3u7BSJf7l4r5c93SgtKpkBSMd+yMY=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=omDcYc/y6/KHVIaI+QNRsZgULdDWBT2ruG3SLpyauw25HnFVNYb2bHDEnuInmy5El+wxgr4wyTOss4ozUt+FcnsK5PHLrBmKBBBGRV18S6U27/jGBxDSyAFjKYLZsrL80saOzDxTAbYJbOn1w2QjgKY95wirfjAf07R8CTqPoR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QVj3EDRw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722394712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B5TF78e2joUCV8HZIMrssZz8VPTF6yS4YCT2ozCAwgs=;
	b=QVj3EDRwBTl1IZ74IUixGS4Mi/JyaWlVXQpnOJbkPq+qNaub7Qod+Gi4A0/NWfK4ODAEgj
	9WqEkVpbyIG2JbTJ/5U/8hwXKejy8BgqnezIgmhn1GCkmMCjLmqe2ZoPjU4QS8dOFNnGRu
	ZTtU+/yFBvgsmGq3J/X1Fk+jTVAfqek=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-x7j096chPXi7oQPeFiKpUg-1; Tue, 30 Jul 2024 22:58:29 -0400
X-MC-Unique: x7j096chPXi7oQPeFiKpUg-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3db2f0e5afaso3831417b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 19:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722394708; x=1722999508;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B5TF78e2joUCV8HZIMrssZz8VPTF6yS4YCT2ozCAwgs=;
        b=PNVbIZQ5yNOWtj6Y/LA76wYx+TO3HrvDn22xXXeJW9WYFzlXMYeztageLYE/euqEuX
         5IRU5/O8nbwPNjVHfW4dktnQ3/Pd3Gsc53/B6GJ9jGbfkJxZLtttWKW9uMYOHbCCNFTM
         7T4/1+fIgnoz/JlxMFFIDvKBH2TqLJct/GbjOPDDD3ickBxGmASNGq6q0OKW7udis6Ct
         2pe9/y50MqAeeOzup5U5FaHCVuVczJqT8vIMP6uJlRaUQkkeBhj1zXHloKTq03HzpOEV
         oVT8MSXtSRSWG9q3Aua28pdKA5PmiXCQmqhBtd5YWeomRjTIjHdNYOaRRz8vAEWrvMRh
         G3ww==
X-Forwarded-Encrypted: i=1; AJvYcCWOIFwkecoWksQCTlSpbCfhV7M/l1CfwIrhhDLDZ6ZOoJsDLwDuoxwlyiyCjIb01GTQ1uVRXnmHT1yf+GZnB5g6clNepDYDizcT/gV9
X-Gm-Message-State: AOJu0YwRIH12Wb+facsZrfaMsusTH6RYxqmOc5P9M6HZn3VEBnrIhQaH
	t67KsIBwmcqpW1nDBUFGdobPPs7Te2E97Ce20TduFdSO8UlUrcAP7KFGcauAbqMIWqpmB3VyP12
	oMHhFS9uJKxuZuFgJzPR+UnVkmk/y7VrUaSy4wmVZFtr2lm27mSQ2Nmv1zoTURg==
X-Received: by 2002:a05:6870:5594:b0:254:7f9f:3f21 with SMTP id 586e51a60fabf-267d4d95176mr15291700fac.27.1722394708154;
        Tue, 30 Jul 2024 19:58:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAfv2Zenk2qDo5iyGwlG9ufxDeml4fO20bgR7n08mh3s42dw3PcV718uCuwlLypD1psNuM+w==
X-Received: by 2002:a05:6870:5594:b0:254:7f9f:3f21 with SMTP id 586e51a60fabf-267d4d95176mr15291688fac.27.1722394707765;
        Tue, 30 Jul 2024 19:58:27 -0700 (PDT)
Received: from localhost ([126.143.164.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f8655dffsm8220732a12.39.2024.07.30.19.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 19:58:27 -0700 (PDT)
Date: Wed, 31 Jul 2024 11:58:21 +0900 (JST)
Message-Id: <20240731.115821.543321690580381692.syoshida@redhat.com>
To: jamie.bainbridge@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, decot@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net-sysfs: check device is present when showing
 duplex
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <85228e43f4771609b290964a8983e8c567e22509.1722211917.git.jamie.bainbridge@gmail.com>
References: <85228e43f4771609b290964a8983e8c567e22509.1722211917.git.jamie.bainbridge@gmail.com>
X-Mailer: Mew version 6.9 on Emacs 29.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Jamie,

On Mon, 29 Jul 2024 10:12:10 +1000, Jamie Bainbridge wrote:
> A sysfs reader can race with a device reset or removal, attempting to
> read device state when the device is not actuall present.
> 
> This is the same sort of panic as observed in commit 4224cfd7fb65
> ("net-sysfs: add check for netdevice being present to speed_show"):
> 
>      [exception RIP: qed_get_current_link+17]
>   #8 [ffffb9e4f2907c48] qede_get_link_ksettings at ffffffffc07a994a [qede]
>   #9 [ffffb9e4f2907cd8] __rh_call_get_link_ksettings at ffffffff992b01a3
>  #10 [ffffb9e4f2907d38] __ethtool_get_link_ksettings at ffffffff992b04e4
>  #11 [ffffb9e4f2907d90] duplex_show at ffffffff99260300
>  #12 [ffffb9e4f2907e38] dev_attr_show at ffffffff9905a01c
>  #13 [ffffb9e4f2907e50] sysfs_kf_seq_show at ffffffff98e0145b
>  #14 [ffffb9e4f2907e68] seq_read at ffffffff98d902e3
>  #15 [ffffb9e4f2907ec8] vfs_read at ffffffff98d657d1
>  #16 [ffffb9e4f2907f00] ksys_read at ffffffff98d65c3f
>  #17 [ffffb9e4f2907f38] do_syscall_64 at ffffffff98a052fb
> 
>  crash> struct net_device.state ffff9a9d21336000
>    state = 5,
> 
> state 5 is __LINK_STATE_START (0b1) and __LINK_STATE_NOCARRIER (0b100).
> The device is not present, note lack of __LINK_STATE_PRESENT (0b10).
> 
> Resolve by adding the same netif_device_present() check to duplex_show.
> 
> Fixes: 8ae6daca85c8 ("ethtool: Call ethtool's get/set_settings callbacks with cleaned data")
> Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
> ---
> v2: Restrict patch to just required path and describe problem in more
>     detail as suggested by Johannes Berg. Improve commit message format
>     as suggested by Shigeru Yoshida.
> ---
>  net/core/net-sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 0e2084ce7b7572bff458ed7e02358d9258c74628..22801d165d852a6578ca625b9674090519937be5 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -261,7 +261,7 @@ static ssize_t duplex_show(struct device *dev,
>  	if (!rtnl_trylock())
>  		return restart_syscall();
>  
> -	if (netif_running(netdev)) {
> +	if (netif_running(netdev) && netif_device_present(netdev)) {
>  		struct ethtool_link_ksettings cmd;
>  
>  		if (!__ethtool_get_link_ksettings(netdev, &cmd)) {

As for the qede driver mentioned in the commit log, I assume the race
was caused between duplex_show() and qede_recovery_handler().
qede_recovery_handler() clears __LINK_STATE_PRESENT on recovery
failure and it is called with rtnl lock, so I think the patch works
correctly.

As Paolo mentioned, I think the issue was introduced when
duplex_show()/show_duplex() was first introduced.

Anyway,

Reviewed-by: Shigeru Yoshida <syoshida@redhat.com>

> -- 
> 2.39.2
> 
> 


