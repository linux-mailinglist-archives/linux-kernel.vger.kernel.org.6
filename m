Return-Path: <linux-kernel+bounces-340716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9869876FD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CECFAB25A15
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A17157A7C;
	Thu, 26 Sep 2024 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="qWphXtT2"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FED15667E
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727365995; cv=none; b=gd2vJsctIs/nF6Ono/oWeC6X3FeoyIU7krd3OmCTKhOSM+b91owt6NvNWOYvv+fvh3GeURkJjd4Z3taQECg1qd0uKOI2rinBzMitlPqATC0Q9d0cOSnC4I2NNIpMQ2CTGBWGgpboioRTaoV74vnZcvv9lMLM50tMMe095E67veY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727365995; c=relaxed/simple;
	bh=dMkpt3eJfshJ/927PNu29sfSE/TnyIpXyBbs/vFoz/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qALqYohsSIpo4s4hTY+G8tvvV9V3Dhmj4B0f0cspkQlcQu5nQ2ukqOenwJEhBisWXkCcNsye/r4HNcVjMfrgzGjWW+7R2PCYpxw65tabLM+64gJBb7Av3jPl5cT1z31P74w3zOJbJNJ18C2/vEQAJwf4RvTMInnevDho507FqZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=qWphXtT2; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7e6bb2aa758so494967a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727365993; x=1727970793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YSXHdMGosuovMCQyR6u3gKuLGqLw3gw6SLdNY5+OFI=;
        b=qWphXtT2Xuq84Y8KI34CDJdmpHtQAvrNUlyh2ayC/7HGiMjvaE0fAZRfIGdtCnaj03
         HT7KxeQIrHuykZay451hOIsduJ0j6Jska904LGkYtYAcBCLqMQuQ2Xq7JRNBHr/cVXrw
         S/KHsLlMfMgHtZKyngNG/MrK/kMw5qU5BTBcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727365993; x=1727970793;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9YSXHdMGosuovMCQyR6u3gKuLGqLw3gw6SLdNY5+OFI=;
        b=pXEcnu14Dqsk+DEvxe1lrjyZzOCHXpWZUFEdanaINRFFbX5SM1ruBv2rZrU6exJ7zr
         4vdwd+0sOm1qyyuPMJc5XLZwGFhvKNuhtvHP5awpV2cTLTZtIh0ZUQ6gdwtgm2mLGV6D
         gjTr9FiyV0R9sBLdR+cCo+1Lwc+QySGApaKNw3tvP1FE7gLq0WgBbf/H5//9IfxY8TD5
         KjX2/lU/Fe0Thin8bEnfOw5OOvYt9CP9X0puIS0du9DkwP5JcKmkELSXzZ/443UkFzWT
         r9vcJ5ziZj5LqEwB6Vs6V2IJRQGAWFOqibUGxPDs3CsWnYRxyI3uimA1uFYQ295EVFuC
         Ymxw==
X-Forwarded-Encrypted: i=1; AJvYcCVlQUHbMdpifwsgmY8FIsTzjCFTQ6kRUbj4h4M9l/OkE9olSlUALlEwOyQw++J6XyCmwxm4L2D2ruK+MnY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8WjpxenPc898Jb6weu8uoC/lmunY+5GCTIfc4oJbWttSYIsr/
	izKzuzR2QG/V/CsZLZBVdPl2VTxLOOnAPQrwgv+H5X0H6NxqX99hAZqBBxUaeRM=
X-Google-Smtp-Source: AGHT+IGsskeA8ViXBBxKNXvuM85G0Ha7WsrLD4rwvuV3CvlzQZ99huxiVBpyqbfRaYE7mkNV/t3QCQ==
X-Received: by 2002:a05:6a21:3189:b0:1cf:4ea4:17c with SMTP id adf61e73a8af0-1d4fa69ed5fmr271341637.15.1727365992613;
        Thu, 26 Sep 2024 08:53:12 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264b5e78sm54289b3a.45.2024.09.26.08.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 08:53:11 -0700 (PDT)
Date: Thu, 26 Sep 2024 08:53:08 -0700
From: Joe Damato <jdamato@fastly.com>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Shradha Gupta <shradhagupta@microsoft.com>,
	Erni Sri Satya Vennela <ernis@microsoft.com>,
	KY Srinivasan <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 1/1] hv_netvsc: Link queues to NAPIs
Message-ID: <ZvWDZBHdiKLE8S29@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Shradha Gupta <shradhagupta@microsoft.com>,
	Erni Sri Satya Vennela <ernis@microsoft.com>,
	KY Srinivasan <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20240924234851.42348-1-jdamato@fastly.com>
 <20240924234851.42348-2-jdamato@fastly.com>
 <MW4PR21MB18590C4C1EDFF656E4600D62CA692@MW4PR21MB1859.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR21MB18590C4C1EDFF656E4600D62CA692@MW4PR21MB1859.namprd21.prod.outlook.com>

On Wed, Sep 25, 2024 at 07:39:03PM +0000, Haiyang Zhang wrote:
> 

[...]

> The code change looks fine to me.
> @Shradha Gupta or @Erni Sri Satya Vennela, Do you have time to test this?

Haiyang, would you like me to include an acked-by or reviewed-by
from you for this patch when I send it when net-next reopens?

I've added Shradha's Tested-by.

