Return-Path: <linux-kernel+bounces-213455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E67A390758D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3D21F23CC3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5B61448ED;
	Thu, 13 Jun 2024 14:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="BrZ4uC1S"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AE07E76D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290021; cv=none; b=CPWf7d6nFOh9WRZyfPS1ap9DAwcACYMpAfXQg+Li8RkJMS6aTy+epqD1z3pYmtcwtndkaKgQPKbDeelfTgdHkIEX/MP/NMFDxd2dXG4kJzGUUdr0c+KqBXBg3jhjfO8/jzQN9yrCiFXww6MeFirjq9GKzFRLyfrUohsBn1V5+1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290021; c=relaxed/simple;
	bh=1MArYuP6I1dClO6hSyL6b2nGGuXkYlYntxPoE89mMzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQhmPx1UNHZ5Ao1Ois8THtYH0khnqs7EqMRi0yIaLgk3GwqMq6K8QQcyoSwB7T5TkKyFmzTtarnXqTVlUcYV2OJ+BIkV6v9ZYFNK4q0pCPVvh8mBPS2UnhJaGmcrkA0QOz0zBknntLgH+qxMNS75068Hlt4ykiRFGSshZ89G6zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=BrZ4uC1S; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-35dc9cef36dso1139425f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 07:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718290018; x=1718894818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tEhA82aLo515aHuKOusFSDP7HypmZDcV4M3zBsA32mk=;
        b=BrZ4uC1SdEomPnkod9VXyxyPPX+d0RLpk8uoPh3lqBl+lE/gS7Q+gz/mFVzOk/YLcD
         kNTdduTZmqtYpKR/wLRMH8c0P0hBSgWyqJvutXSuy2p3hzVYLJ0GuX2gmzE2onPviAKF
         ac+iRHg+2rSEnt2k/OUXGDkBj3Ji1ovUHymrR3Csv0sY9CnT2gwWbwdNpblTa35A8zWh
         VDxdJNxWPoV6T02Yhe2vGaokPVWJ9LZZKmpSu+dA9ZR0px+XWnil9dxNikjqKVLj8CCU
         kZBNbNKJPgFKHUf9PbDV8UtZwAuQMRZQnTfBZthKA/ekbMysrf5SvFEJjLs0zKwU7cxm
         yvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718290018; x=1718894818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEhA82aLo515aHuKOusFSDP7HypmZDcV4M3zBsA32mk=;
        b=Q8CZqwbTMYqErHp3m+hkXq+Y6CTQwTZbXcLmXargBrfwCXQ1mH9O/26K42yiWMh+qS
         AGAzNWZ9D0y5coCoscYoqmC/ZQ99V1l0cfW/ka2xLVirFtQzCUrkxdtIdWWyKkXpwvZE
         H5L1e8RuP0SbCDq1XdoRDdmGKb+i7YwdandsbBUkMm8GK1/XxBmOJrheNmMvR/5S3GuY
         D7vRgDo1sqAZI1ft41nvomzem8lqjWqut5oZtIBYcqJiQaY6Xg6uCXtVAK/c2EuX0dUr
         0GtOYtmBOwqUPT5cAP5T3Z9VXv9hfNPLRoY5OvOI8lgPH0dr831UNLjc4Qdu/z2QITNp
         xDCg==
X-Forwarded-Encrypted: i=1; AJvYcCXvqie+x9xYMSf2d4xhbV4/bKCchovqf4wHDzGwOC92RTCR9QtetLN34etWSoSLPt57xKfNtNa0/ph8gDM/c2TENYjsqnD558xsgyE9
X-Gm-Message-State: AOJu0YxBxP+HpUwZGtVUBuWu5pWBmNNSo0MMmk2Vxj4//55xsw2XzxvS
	L0ma0aDtyrQV9JSeAflvWJ2RWB3a2H9ARQEs+gcynU6D/fdQHTl57/8en2+/v0c=
X-Google-Smtp-Source: AGHT+IFslhxHNDMgZ32+cIy2OchmE6E7iuuKQlnGpNTfS9dQJEFOYr+dynThX3TNYtBBkCIb1pwd6g==
X-Received: by 2002:a5d:648f:0:b0:35f:2550:e276 with SMTP id ffacd0b85a97d-35fdf779d20mr5238834f8f.5.1718290017479;
        Thu, 13 Jun 2024 07:46:57 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750ad10esm1888491f8f.64.2024.06.13.07.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 07:46:56 -0700 (PDT)
Date: Thu, 13 Jun 2024 16:46:53 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Cindy Lu <lulu@redhat.com>,
	dtatulea@nvidia.com, jasowang@redhat.com,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <ZmsGXRrSgUbccoHp@nanopsycho.orion>
References: <20240611053239.516996-1-lulu@redhat.com>
 <20240611185810.14b63d7d@kernel.org>
 <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
 <20240612031356-mutt-send-email-mst@kernel.org>
 <ZmlMuGGY2po6LLCY@nanopsycho.orion>
 <20240613024756-mutt-send-email-mst@kernel.org>
 <Zmqd45TnVVZYPwp8@nanopsycho.orion>
 <20240613034647-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613034647-mutt-send-email-mst@kernel.org>

Thu, Jun 13, 2024 at 09:50:54AM CEST, mst@redhat.com wrote:
>On Thu, Jun 13, 2024 at 09:21:07AM +0200, Jiri Pirko wrote:
>> Thu, Jun 13, 2024 at 08:49:25AM CEST, mst@redhat.com wrote:
>> >On Wed, Jun 12, 2024 at 09:22:32AM +0200, Jiri Pirko wrote:
>> >> Wed, Jun 12, 2024 at 09:15:44AM CEST, mst@redhat.com wrote:
>> >> >On Wed, Jun 12, 2024 at 08:29:53AM +0200, Jiri Pirko wrote:
>> >> >> Wed, Jun 12, 2024 at 03:58:10AM CEST, kuba@kernel.org wrote:
>> >> >> >On Tue, 11 Jun 2024 13:32:32 +0800 Cindy Lu wrote:
>> >> >> >> Add new UAPI to support the mac address from vdpa tool
>> >> >> >> Function vdpa_nl_cmd_dev_config_set_doit() will get the
>> >> >> >> MAC address from the vdpa tool and then set it to the device.
>> >> >> >> 
>> >> >> >> The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
>> >> >> >
>> >> >> >Why don't you use devlink?
>> >> >> 
>> >> >> Fair question. Why does vdpa-specific uapi even exist? To have
>> >> >> driver-specific uapi Does not make any sense to me :/
>> >> >
>> >> >I am not sure which uapi do you refer to? The one this patch proposes or
>> >> >the existing one?
>> >> 
>> >> Sure, I'm sure pointing out, that devlink should have been the answer
>> >> instead of vdpa netlink introduction. That ship is sailed,
>> >
>> >> now we have
>> >> unfortunate api duplication which leads to questions like Jakub's one.
>> >> That's all :/
>> >
>> >
>> >
>> >Yea there's no point to argue now, there were arguments this and that
>> >way.  I don't think we currently have a lot
>> >of duplication, do we?
>> 
>> True. I think it would be good to establish guidelines for api
>> extensions in this area.
>> 
>> >
>> >-- 
>> >MST
>> >
>
>
>Guidelines are good, are there existing examples of such guidelines in
>Linux to follow though? Specifically after reviewing this some more, I

Documentation directory in general.


>think what Cindy is trying to do is actually provisioning as opposed to
>programming.
>
>-- 
>MST
>

