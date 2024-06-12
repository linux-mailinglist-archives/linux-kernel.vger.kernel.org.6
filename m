Return-Path: <linux-kernel+bounces-210984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537E2904B9D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58E531C20DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 06:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A761416936E;
	Wed, 12 Jun 2024 06:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="0hYGDPhT"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9773F9D9
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 06:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718173802; cv=none; b=WnMyFQxa3Yd0p+9vLluVzXnvx9EEKeOkJjTneXbILWjrEYey0Lqu9O+oIkLC4vMbpiXke1F8BjuErkSSsDLjeI/+J5+WRka+l5sz8KHGfkHtD30Z9BzkcoKZVI67jlzGi0/aEtVEA/fMhDNzgLTUq/yGxC3NA3CBIa33gB/UsaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718173802; c=relaxed/simple;
	bh=Dw8KIMMn+F28OFpTAhQjzDCM2P9ytOTncCAHmd6nIHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/hN5dJYCM2la5dznflhQ2LTUTeGse0CM0NogtRwuJdtQacsCL9cZo40wqTj48kpRg97NmEap/oqnDkJOapLvdIYrLIQaPr96OLo57gWBG/YMNxBI0e3/bxc6epMU9ygp6+f5wGgJZjZLJI8Bzbs6+OL32bmt9/NAD7GHmo85aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=0hYGDPhT; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5295e488248so7118752e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 23:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718173798; x=1718778598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5LH8e3qpcjluJss2hNPudK/MPhEV4gW+gLGQ/ZThC0k=;
        b=0hYGDPhTrP5DabeRqTvEnFuUoZWnORKBU8CLTKH0A0qO0Ih0BcoPlOczkFx2/EGhLk
         iO6lpFy/tSpQ/FuiRlomrdjp84kvZbiEiMVifwfvCwNjKCZesboHLSNzJcZXdietSsiO
         8sHKS/1DkGxaIr3F4fAu2pmNrgUd5t6bDHPC/itLJ66ic43hvsgu8HsEuJGsS9RYLN+R
         +1d67dHVs/HdTq2EODGcogUJK5j/i9EqCVWcsjbXwvMO4hbuwBOsnokLIZXVHNjk5BJD
         oX5xppbcuN6Dw7RWcryH3SPhqk4hMTz7+Pz4l2pJdYRlhYL24xx14pSpQnt/ZqOUAvIT
         IkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718173798; x=1718778598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LH8e3qpcjluJss2hNPudK/MPhEV4gW+gLGQ/ZThC0k=;
        b=p+QJOPJkdAgV0aAjZ2PVf1gxtkgBJL/C5VEZ5CO/3jMsga0HLScL5YvI4pNN+7ehbe
         MGhCeZPDu/Ih08OyOhsTkx9tA5UGdifjId19q7UXivz+hzxADEy3oSnqtx159arrWlnb
         f18uUrbq+SQSRmmOMeURGG2l/WBSokVp33sXT0NZB67pDQoXS3DOr5WXSge968ICPCEr
         BJ9zR003DY/z6fyUMgY8WM8qJC843REYriuYoHluhn82y1ByUFQFgOSnz2oFZVQkltWy
         9ZVNJSEOm9AI4wfVj9or5YzyvyfsmQS3uHgzV0fpVpzWB5lkYXArAMZrGSbWMeUcVuv4
         9PfA==
X-Forwarded-Encrypted: i=1; AJvYcCWV6m+nLegf4Zk2W3eCZiQZf0KOsVhn2s36+97arhRPNj9SUKgEUto61XwOB+gwoCYLPGBdS+XzmmHvn67951aJhestp39n8V0I6bZ9
X-Gm-Message-State: AOJu0Yzr4hFXFg0kjKR31fQosEvFQ6R6U9K+YChQ6N9mhuyc83HDGZWH
	wmaxZpqa8P3UYoZUcCnI/kSar/WPYAE18ZDe6WtN7B4rk7G32sfuRlIYpU6qJ2U=
X-Google-Smtp-Source: AGHT+IFp/68HMGdtt+tnnGcItdNkBhSFo46K5V4Iw0bDMZtwLsT4wVHxdkIyBopwMlohpTWvO6o3cQ==
X-Received: by 2002:a05:6512:1313:b0:52c:8abe:5204 with SMTP id 2adb3069b0e04-52c9a3dbeffmr624591e87.32.1718173797669;
        Tue, 11 Jun 2024 23:29:57 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286fe75ebsm12495135e9.9.2024.06.11.23.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 23:29:56 -0700 (PDT)
Date: Wed, 12 Jun 2024 08:29:53 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Cindy Lu <lulu@redhat.com>, dtatulea@nvidia.com, mst@redhat.com,
	jasowang@redhat.com, virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
References: <20240611053239.516996-1-lulu@redhat.com>
 <20240611185810.14b63d7d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611185810.14b63d7d@kernel.org>

Wed, Jun 12, 2024 at 03:58:10AM CEST, kuba@kernel.org wrote:
>On Tue, 11 Jun 2024 13:32:32 +0800 Cindy Lu wrote:
>> Add new UAPI to support the mac address from vdpa tool
>> Function vdpa_nl_cmd_dev_config_set_doit() will get the
>> MAC address from the vdpa tool and then set it to the device.
>> 
>> The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
>
>Why don't you use devlink?

Fair question. Why does vdpa-specific uapi even exist? To have
driver-specific uapi Does not make any sense to me :/

