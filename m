Return-Path: <linux-kernel+bounces-218172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275C690BA19
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1749A1C24781
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C204216191B;
	Mon, 17 Jun 2024 18:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQHHHvNf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8A3198833
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 18:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718650128; cv=none; b=t4DGidM2OPvPJtFKgS5AWbq2tryLIAJ6YYHpPVPRVw+0wlZPAP+Xw+5tiTcWSFkLeB1K/GtPNHpqrxgCr3eAmeFoU0iMk7CqedIZr8+zb01/GVV/xz0sKVmnUJZxS9+SaWyNCt/H4FdafaVM1AJc1nS1swWt283NJGiJM03+9fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718650128; c=relaxed/simple;
	bh=2pW5K756b3vnOMMzbNNarIqr13h/Yp4f80y1nx+hSeA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RuvHEpsuJ0+WH3dIWC6JhRKTTjDoNeNHL+eBwNqt6LIHaAt75LxBCamNz+VgSgIKzDCmAs42ZgxvVmf34skQqX+AkZVnZ3Fu6AiaRAaaz7QKNf4lPsaEcJJ1hi/UoGA41Ri8b/LIH3uJuHUstvmcTcqeQeOH6Lo6FJPApEVgZCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QQHHHvNf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718650124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZaXnpTdtezaPILoSmIEc1ZZ9gp2RX1pMrPgPH0P1ko=;
	b=QQHHHvNfVyQOhnbnt1++JzugD5pRY884A6Y3GMiPWK4Ipa4lXJsqG8Dp7nxu3lCuiXdkWG
	6Xx32+lMeNUJMAxT5yoQCIDH8jD4BRgcP4f5EYQ0moqYg5JB5Ln6GS+kasWz0Oq49uu2wP
	hVMlVc3UVqq1+k//Ud1UZuSk7byLtk8=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-_TewlSTNOtiPAy6dvGuQuw-1; Mon, 17 Jun 2024 14:48:43 -0400
X-MC-Unique: _TewlSTNOtiPAy6dvGuQuw-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-62f8a1b2969so94609097b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718650123; x=1719254923;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZZaXnpTdtezaPILoSmIEc1ZZ9gp2RX1pMrPgPH0P1ko=;
        b=QcxBsDDbJ2bYm5R9R/lGIZWI/UZSGmRW5fST1MHAP0Gq5pxZr6+gGu2U0R+lRcEOtN
         HcKiowDmdVB0JB+NCMUFUI6pwL+ToBA3mYrBHwQEYovxP7NYyAiOmyDjocCHq7SJUuPd
         UjTsFrxTtjF90p1tVN+cyGDeHxm+BwVrJqOdMfbKETInHhutJGMar0GzuBQMZlSUA8ib
         lOc64bd674bvYJfIGS8qv5zVm5f8AVMV6FqLUPXb+MxwHIVjOpq80bavhJtdVm/2849x
         gmsQai2fbuI7UWVx+3mOSpdaz6MFd8wTpF/ZvW/XtEz1BpILUc+RFddqyGnu0dHkqRU3
         eGhA==
X-Forwarded-Encrypted: i=1; AJvYcCVOGKSMFhDgkkyik951PRBdcUl3OpfS0IGVU+PLaK45rHaoMHlISCI5KFi8c+lALi977MQNtjMx61KmoNxxUfMcWF9n/d7ni+/ZbGrW
X-Gm-Message-State: AOJu0YwWJ84rivc49pKH9t7JesPKrfNP9S65u7awBA4e26Um/mN9t4C/
	RG0DxqI0D0CxIr+XgqdT/EAaS11h+jY3kIiYnTr0aEbZvUn8T21gf9XuL6tMJHhx4Rox7P8eaan
	n+75XyE8Ry6t7t90Sb4kyACuau0z+k7ylRIovmiHwv7pqdNiXFQmsenZmvkzfaQ==
X-Received: by 2002:a81:9245:0:b0:617:d8a7:df60 with SMTP id 00721157ae682-6394a6c537dmr4984517b3.40.1718650122509;
        Mon, 17 Jun 2024 11:48:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD/nY/QKBHmtUF5IvBSZOGzxA0YnpE8P+v9PhV468bowcK1HtPww2hkYffchrQU0zOplnI7Q==
X-Received: by 2002:a81:9245:0:b0:617:d8a7:df60 with SMTP id 00721157ae682-6394a6c537dmr4984307b3.40.1718650121979;
        Mon, 17 Jun 2024 11:48:41 -0700 (PDT)
Received: from maya.cloud.tilaa.com (maya.cloud.tilaa.com. [164.138.29.33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5f10739sm57649316d6.146.2024.06.17.11.48.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2024 11:48:41 -0700 (PDT)
Date: Mon, 17 Jun 2024 20:48:04 +0200
From: Stefano Brivio <sbrivio@redhat.com>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Pravin B
 Shelar <pshelar@ovn.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, =?UTF-8?B?QWRy?=
 =?UTF-8?B?acOhbg==?= Moreno <amorenoz@redhat.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next 6/7] selftests: net: Use the provided dpctl
 rather than the vswitchd for tests.
Message-ID: <20240617204804.680a1254@elisabeth>
In-Reply-To: <20240617180218.1154326-7-aconole@redhat.com>
References: <20240617180218.1154326-1-aconole@redhat.com>
	<20240617180218.1154326-7-aconole@redhat.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jun 2024 14:02:17 -0400
Aaron Conole <aconole@redhat.com> wrote:

> The current pmtu test infrastucture requires an installed copy of the
> ovs-vswitchd userspace.  This means that any automated or constrained
> environments may not have the requisite tools to run the tests.  However,
> the pmtu tests don't require any special classifier processing.  Indeed
> they are only using the vswitchd in the most basic mode - as a NORMAL
> switch.
> 
> However, the ovs-dpctl kernel utility can now program all the needed basic
> flows to allow traffic to traverse the tunnels and provide support for at
> least testing some basic pmtu scenarios.  More complicated flow pipelines
> can be added to the internal ovs test infrastructure, but that is work for
> the future.  For now, enable the most common cases - wide mega flows with
> no other prerequisites.
> 
> Enhance the pmtu testing to try testing using the internal utility, first.
> As a fallback, if the internal utility isn't running, then try with the
> ovs-vswitchd userspace tools.

Oh, nice, it looks saner than I thought. :)

> Signed-off-by: Aaron Conole <aconole@redhat.com>
> ---
>  tools/testing/selftests/net/pmtu.sh | 145 +++++++++++++++++++++++-----
>  1 file changed, 123 insertions(+), 22 deletions(-)

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>

-- 
Stefano


