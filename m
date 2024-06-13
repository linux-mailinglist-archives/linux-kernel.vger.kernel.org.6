Return-Path: <linux-kernel+bounces-212653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E857906463
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E892B23C38
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 06:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3542137C3C;
	Thu, 13 Jun 2024 06:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMYMssjn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BFB13792E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 06:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718261384; cv=none; b=KwNHQ/zNOY5u7i62fVw0Ll6/EKmoPG2KCrSueF0fhPlwym1zKsTYc6nB0EOXLb5+hrqJQzAB7MRwOffFrzzNCe8tW+DPbYS2h5zvbNl+rmswvVLApFE1U+zc0+VG/NHfevWCUpjN9rfKU1GBEF/gCM3CeXwGtzqVLzfGgBZLeH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718261384; c=relaxed/simple;
	bh=nOI9j21ZgI3I0MQ5EhathzuyzKyOMxQisKyvdWlhhdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAhkiCuGVw2GAUYb0zVdaTWMhsCmMUiv8FuLJeT7D/aPJEu0dxPcJ9RZ5jBEQP0rdltNkDWY37/HLGWAC6rOjZT2zKCVYImVz2kjgLFOj5JcCQAenivDIXCFO7Hy6ssVtv/RVuURdcb9jzCDRgPoEO7tLTr2zV97VXBsKxEIpG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JMYMssjn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718261378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/CbSxasg15SB+kyQXKy/dPIg+1PKI2NcVPeH5mNpLbA=;
	b=JMYMssjnw54cl08AA/j3AqU2lEZL49EF+zuvW5Eawj+qiNagZyXZgPnaFIY6tTTUTNc7Oi
	S30LHlD1HCEH3tSTkLhJjkmvEotV8zLM444qN5mx63nf4uZHiYiExGciD6Um45gHJ4oCrV
	IgjBoefUAwJP+Dliw1YeYFbtQ+GlZ6s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-eepw8bKZNpafk_0kh1ABHA-1; Thu, 13 Jun 2024 02:49:34 -0400
X-MC-Unique: eepw8bKZNpafk_0kh1ABHA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35f1fcd3bbcso352105f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 23:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718261371; x=1718866171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CbSxasg15SB+kyQXKy/dPIg+1PKI2NcVPeH5mNpLbA=;
        b=KKiiFWsT+oZAVZ1jOKWWdURxwwP93gDIsgN3mraXkE4N6lOg2OuXGNxoogeZs8Nz/0
         Mq/PfGTsk2+OUJGuyJ4AfNBW9PfruQbuJ4Z8CqTDeKpAO3VTzLFUjk/we7SzdN4WxYBU
         f/byxTVW6ZPcDfJ7ed2VPNH1IGvXVxuzaytiBnChw6wGJkPLSDvCWi4ORiIE3+HOhvC9
         cjfNkOawhK+FRXmjVUeQvY5NfyJ6vfOBMUrN8TSZjADGrSu/V3RFWLwpFQecZ44y567e
         iWqFL23B6/I6qIGfrXdZxJOs1mU6RLj7XZPj+EVWMb0bMwu7ZbLJVVkRG6wApRAD0rkX
         Ev8A==
X-Forwarded-Encrypted: i=1; AJvYcCX3Iaqw/1jEOO6/G2tNGN0592oFlnSAXfxkVhmmMfeVNWoB4nVufTEfbZHOGlxAeuRrxtZLFuVlqr854n6GZh+vabMu0gVHX8dpGawB
X-Gm-Message-State: AOJu0YxZyZFDkyNN9A6ldBbIRMbgIGwsiWbzuTRVeGawMJWkoFf2vDvl
	v7WbEPN5NbToXNYz+851qogqw//ipXgfXVlf5PJKGUPcYGhY2T1jQm186XeFqDTsJJwjFnjCr28
	7GEq3rjfiMfw8ant/GJITJlJ3w0pY2uK6LOcfAF3JTYInvOomATQZuzFVAqONOw==
X-Received: by 2002:a5d:4ac3:0:b0:355:161:b7e6 with SMTP id ffacd0b85a97d-35fdf7ae574mr2690496f8f.41.1718261371371;
        Wed, 12 Jun 2024 23:49:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2zc9YTuq67HAYl0S1ZCAGfDX9FHmtCsB3op2ROZqV+XTOIEDmRzmfD9lHK2sqlkU4bC7xmQ==
X-Received: by 2002:a5d:4ac3:0:b0:355:161:b7e6 with SMTP id ffacd0b85a97d-35fdf7ae574mr2690467f8f.41.1718261370362;
        Wed, 12 Jun 2024 23:49:30 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:341:5539:9b1a:2e49:4aac:204e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c89dsm764954f8f.25.2024.06.12.23.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 23:49:29 -0700 (PDT)
Date: Thu, 13 Jun 2024 02:49:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, Cindy Lu <lulu@redhat.com>,
	dtatulea@nvidia.com, jasowang@redhat.com,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <20240613024756-mutt-send-email-mst@kernel.org>
References: <20240611053239.516996-1-lulu@redhat.com>
 <20240611185810.14b63d7d@kernel.org>
 <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
 <20240612031356-mutt-send-email-mst@kernel.org>
 <ZmlMuGGY2po6LLCY@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmlMuGGY2po6LLCY@nanopsycho.orion>

On Wed, Jun 12, 2024 at 09:22:32AM +0200, Jiri Pirko wrote:
> Wed, Jun 12, 2024 at 09:15:44AM CEST, mst@redhat.com wrote:
> >On Wed, Jun 12, 2024 at 08:29:53AM +0200, Jiri Pirko wrote:
> >> Wed, Jun 12, 2024 at 03:58:10AM CEST, kuba@kernel.org wrote:
> >> >On Tue, 11 Jun 2024 13:32:32 +0800 Cindy Lu wrote:
> >> >> Add new UAPI to support the mac address from vdpa tool
> >> >> Function vdpa_nl_cmd_dev_config_set_doit() will get the
> >> >> MAC address from the vdpa tool and then set it to the device.
> >> >> 
> >> >> The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
> >> >
> >> >Why don't you use devlink?
> >> 
> >> Fair question. Why does vdpa-specific uapi even exist? To have
> >> driver-specific uapi Does not make any sense to me :/
> >
> >I am not sure which uapi do you refer to? The one this patch proposes or
> >the existing one?
> 
> Sure, I'm sure pointing out, that devlink should have been the answer
> instead of vdpa netlink introduction. That ship is sailed,

> now we have
> unfortunate api duplication which leads to questions like Jakub's one.
> That's all :/



Yea there's no point to argue now, there were arguments this and that
way.  I don't think we currently have a lot
of duplication, do we?

-- 
MST


