Return-Path: <linux-kernel+bounces-212687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 645E69064E1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19BF71F21633
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 07:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CC213C67F;
	Thu, 13 Jun 2024 07:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="bt3BZeXR"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3786E612
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 07:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263275; cv=none; b=nEhFBMLbhldS7dAzZsE5EJzcaSXT6ctQbXFMSPTtFnDYMeoZQhFLmMGTuedo2KwATrQwKdM8HCX5LhgfiSI/KSuX9mKPmnq3G9SwYmL/4uWjyJv1fCEj0m6HNf7yD0ZGXELGfQDZX/f+OWMl4jPV9sBczawmLc0c4ZAsCGWcNJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263275; c=relaxed/simple;
	bh=l80RjXdZw7gxCEOaUJxc6adU9RUoluvmfgHKiXUbHxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xepgb3oLll2MO766M9d7VvI/6ozOyMqU4ykwYuaQTiGijEiKNWyY249FP9hbJDL60NRp5lVvMReWi+z3aIkDt9gXFcizbwZ8e4kthPpWy6RRkg3vM8RBp1lzPPadem+USfyVeyOpWogWJuTEdGZZXUSRPuWGE0ajoV1VZUvBOKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=bt3BZeXR; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-35f223e7691so380850f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 00:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718263272; x=1718868072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nhdTMjtoIXZFugvUtXucLNLZ+wuL3jj/Mf2FujAvEdI=;
        b=bt3BZeXRRVH0aOKqgTVaSP4slhRVfUfIkCGypAJLxA8h2CAbWbuoVB7L5hkHzFFhW+
         LyYJ8+bTXgH/qvbevlwsvRbRn+3B7insaYLbJ9c69g5aL4wx9EsL/Ys19qrML/s653o1
         oh5QXUufs4HJdo8n9oHNhqb1F4k4AuVskcwjXbrDkYPyhpF7hh/4agbZnskqlg9hf2nj
         H2YvhdNI002qCH6r6UGlZGvTRgXpJNAFmJjF83ud6UnfrlpQcdRcI8VPNILMut6JeLMd
         /pcAJwYz88Plctnic5btNCKqtsmYMVMFuwwMcpgUb0i9P6geXItsTg0MWiw2cIC5o1Af
         +QtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718263272; x=1718868072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhdTMjtoIXZFugvUtXucLNLZ+wuL3jj/Mf2FujAvEdI=;
        b=jNGjyGJq01GLlXgWE15f82ZwTz+jMBuZOSf9RArnjKXhDT/HIIYtgGtEwlTvYtXhdJ
         MljDCVo6Dg/ce1RCew8De+WC+YmgbsQNNvyLL9SnRQ1gzlndZMdR2SdoL8S9mhKgcRO4
         yLArWb39TwRVUp0viaHFVP4HUr0KnjD3+rH4gZeFFlWBoPlajPDbw7naS4ssQXA/bUZQ
         9eOHISGW7Mn44oqMjjVnkJA4+v0P9awQTdHkgNImuR4U0WWo2XKkxUSICP9eMVLxqOoG
         ios47xmAXNh0jQRGaRiFVmDQYYJjTWJqFuIk+QduzZj02oaO1MHIdK9qkg6czgri6R3h
         4d5w==
X-Forwarded-Encrypted: i=1; AJvYcCVFd65w8BzBPVHc8lUlz4wW3qrvvbKFvHp5zd0EbEHovowmcQ1xL821CkKLl5OrnWyPXMiEss/7GA4rszyj/S9HE/miX/SGUEx6hwWj
X-Gm-Message-State: AOJu0Yz6T1Yz8zcXVasrzdTCHdi+UcaBDOd+ZSUfcbIPvF749gAejwZP
	6JrFEHNRbHkgI6vu0ojM/5ZHnuX2+//Py2fY6lw27eGyDJfVumeeM2Jwl3v6Ld8=
X-Google-Smtp-Source: AGHT+IEhPIOPdXqAxFfHuuOD1kWxW9YlJJ2QDiJYUAHkDsdB9olUY85yrXKWxCO/8TkZGGaYlxO5Fg==
X-Received: by 2002:a5d:45cc:0:b0:35f:d07:d34 with SMTP id ffacd0b85a97d-360718e5232mr1590625f8f.27.1718263271467;
        Thu, 13 Jun 2024 00:21:11 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750ad20bsm821833f8f.54.2024.06.13.00.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 00:21:10 -0700 (PDT)
Date: Thu, 13 Jun 2024 09:21:07 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Cindy Lu <lulu@redhat.com>,
	dtatulea@nvidia.com, jasowang@redhat.com,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <Zmqd45TnVVZYPwp8@nanopsycho.orion>
References: <20240611053239.516996-1-lulu@redhat.com>
 <20240611185810.14b63d7d@kernel.org>
 <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
 <20240612031356-mutt-send-email-mst@kernel.org>
 <ZmlMuGGY2po6LLCY@nanopsycho.orion>
 <20240613024756-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613024756-mutt-send-email-mst@kernel.org>

Thu, Jun 13, 2024 at 08:49:25AM CEST, mst@redhat.com wrote:
>On Wed, Jun 12, 2024 at 09:22:32AM +0200, Jiri Pirko wrote:
>> Wed, Jun 12, 2024 at 09:15:44AM CEST, mst@redhat.com wrote:
>> >On Wed, Jun 12, 2024 at 08:29:53AM +0200, Jiri Pirko wrote:
>> >> Wed, Jun 12, 2024 at 03:58:10AM CEST, kuba@kernel.org wrote:
>> >> >On Tue, 11 Jun 2024 13:32:32 +0800 Cindy Lu wrote:
>> >> >> Add new UAPI to support the mac address from vdpa tool
>> >> >> Function vdpa_nl_cmd_dev_config_set_doit() will get the
>> >> >> MAC address from the vdpa tool and then set it to the device.
>> >> >> 
>> >> >> The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
>> >> >
>> >> >Why don't you use devlink?
>> >> 
>> >> Fair question. Why does vdpa-specific uapi even exist? To have
>> >> driver-specific uapi Does not make any sense to me :/
>> >
>> >I am not sure which uapi do you refer to? The one this patch proposes or
>> >the existing one?
>> 
>> Sure, I'm sure pointing out, that devlink should have been the answer
>> instead of vdpa netlink introduction. That ship is sailed,
>
>> now we have
>> unfortunate api duplication which leads to questions like Jakub's one.
>> That's all :/
>
>
>
>Yea there's no point to argue now, there were arguments this and that
>way.  I don't think we currently have a lot
>of duplication, do we?

True. I think it would be good to establish guidelines for api
extensions in this area.

>
>-- 
>MST
>

