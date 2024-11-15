Return-Path: <linux-kernel+bounces-410853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B72579CE771
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3491F21F08
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0901D45E0;
	Fri, 15 Nov 2024 15:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBwBnsvn"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E0F1CEEAA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682917; cv=none; b=C8h3TGWwqCc8Uc45MA4VBDDHq5QNcglOinG9u4axPy8tsI2ugmE3E4wS9Fn+MwdJYODbeparp3pbjl5K855yQq3sZeizGTfz1b/LxdhNi41jSs/DmGaWM5rcsWBk3jWCv0nE2oCG9UtEXMxso0i20as3yIG10Z8mbP2OVfmg1VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682917; c=relaxed/simple;
	bh=vufh+4tsgJbxSwv+RSjkWupMJh6Za2rEmPKDTezdxXs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=daCX4rEq+921QXE+PWlWZwu4DZweb8bZu/4OKyOd/cyNcho9DyrUZZ71tUlgLJyhZNUnHHvVwayfvKr91p5elDv6zGwmAQOHWaMqb9FK5kbrygke0hScoVBHonsw3TVXMUUzYSJVLdlMICk0pYhaKRh6M9clEMjkbhW9ds6/eIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBwBnsvn; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-72483f6e2fbso68217b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731682915; x=1732287715; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D2FKaoiwY2mfiK/eCo1qaJWV79rWuXXZrs0onoCnNZ0=;
        b=nBwBnsvnYsTcrZ7kbatbODFrQi0dq6HsC51NYjqJ4YrQYMwqfCI0JedAFSYAQNlAnP
         hwWsyZjszGBRa/tkBCOP/XhMQdMOHQu3Ic4ayNQwDTCuISqckSxPlQ+0g8BdAXTl4Md2
         7nJ3Vs5F8vNNYAHY5E8JKWHnItF0gxj0zws7+nDzpoRxlOIK2jSgEaJzZ6VZ9mqK1kTQ
         /s+kI1c/PNklrOfX/erkbOyrPTm2IQglpebHfOEHppdeYsXivzR+3PuwV3QhbMrKbKNb
         LLzj9ToW7j7eWsJuV6AJWPFGgYzZk3xYwpA2TMgAghPaE70xuIjUhgC/g1LAqpS6flBP
         xOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731682915; x=1732287715;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D2FKaoiwY2mfiK/eCo1qaJWV79rWuXXZrs0onoCnNZ0=;
        b=bk+EYDXOwkLd+zmRHISvFBDRFy5+k1wAw//mWJLjSfEjfg9zgiEfSy44S0OOROE6sf
         y6lb9nVQE/fxNFIaqJ3YUmgKndef9zDSWM0SQIQBVJtF3JaqSwXeB+AuXjYmOJI7tyR+
         kUT++OumGTEU4MW4qPQtd37RqnlYo4qhSMt4u7bEtNBEFBH406Uo9gOhnld/n/bSq5Ce
         ZMp9UWXWTzPT+lAfs0FHhrDS2fa1OrV2NN/P6fmqCRzSw5AQ6fsPUF0WpXAzR+itm0wc
         H95gTBZRDhaNm/g3FUSORc4Ddn9EaTfwfr3YX9M5S2VQwOk0EEtnCMogupzroKF0+GuS
         S+Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUJg4Th3AWevjObygEcuuBG8s8T9iREQGScDkAgS2RFCqUv2PkWLGhszYC31A2w6BcVEB4x9zcalv42vxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQx3rf5m1by1204t49LSBuRj1maReZN1Xf9BK3uoWuUkLS7KR5
	sDUTTtDT1uLiqAQNtc62Em1DRECcW/sWogbQAlJG6ncDGUt3gRba
X-Google-Smtp-Source: AGHT+IFF2Q7DDqTNLmh5BnAWYLBYmDo5Jo3WT8cy7DmLwoCWZ86DI74hImRwZEDcl86A8cSxwL7Pww==
X-Received: by 2002:a17:90a:e70c:b0:2e0:ab57:51ec with SMTP id 98e67ed59e1d1-2ea1557e7aemr3544553a91.30.1731682913530;
        Fri, 15 Nov 2024 07:01:53 -0800 (PST)
Received: from dw-tp ([171.76.87.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea02495969sm3016300a91.19.2024.11.15.07.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:01:52 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com> 
To: Narayana Murty N <nnmlinux@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, linux-kernel@vger.kernel.org
Cc: mahesh@linux.ibm.com, oohall@gmail.com, npiggin@gmail.com, christophe.leroy@csgroup.eu, maddy@linux.ibm.com, naveen@kernel.org, vaibhav@linux.ibm.com, ganeshgr@linux.ibm.com, sbhat@linux.ibm.com
Subject: Re: [PATCH] powerpc/pseries/eeh: Fix get PE state translation
In-Reply-To: <20241107042027.338065-1-nnmlinux@linux.ibm.com>
Date: Fri, 15 Nov 2024 20:01:48 +0530
Message-ID: <87ttc8d0vf.fsf@gmail.com>
References: <20241107042027.338065-1-nnmlinux@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Narayana Murty N <nnmlinux@linux.ibm.com> writes:

> The PE Reset State "0" obtained from RTAS calls
> ibm_read_slot_reset_[state|state2] indicates that
> the Reset is deactivated and the PE is not in the MMIO
> Stopped or DMA Stopped state.
>
> With PE Reset State "0", the MMIO and DMA is allowed for
> the PE.

Looking at the PAPR spec - I do agree that it states the same. i.e.
The "0" Initial PE state means the "Not Reset", "Load/Store allowed" &
"DMA allowed" (Normal Operations). 

> The function pseries_eeh_get_state() is currently
> not indicating that to the caller because of  which the
> drivers are unable to resume the MMIO and DMA activity.

It's new to me, but could you help explain the user visible effect
of what gets broken. Since this looks like pseries_eeh_get_state() has
always been like this when it got first implemented.
Is there also a unit test somewhere which you are testing?

IIUC eeh_pe_get_state() was implemented[1] for supporting EEH for VFIO PCI
devices. i.e. the VFIO_EEH_PE_GET_STATE operation of VFIO EEH PE ioctl op
uses pseries_eeh_get_state() helper to query PE state on pseries LPAR.
So are you suggesting that EEH functionality for VFIO PCI device was
never enabled/tested before on pseries?  

[1]: https://lore.kernel.org/all/1402364517-28561-3-git-send-email-gwshan@linux.vnet.ibm.com/

Checking the powernv side of implementation I do see that it does
enables the EEH_STATE_[MMIO|DMA]_ENABLED flags in the result mask for
the callers. So doing the same for pseries eeh get state implementation
does look like the right thing to do here IMO.

> The patch fixes that by reflecting what is actually allowed.

You say this is "fixes" so I am also assuming you are also looking for
stable backports of this? If yes - could you please also add the "Fixes"
tag and cc stable? 

-ritesh

>
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/eeh_pseries.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
> index 1893f66371fa..b12ef382fec7 100644
> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
> @@ -580,8 +580,10 @@ static int pseries_eeh_get_state(struct eeh_pe *pe, int *delay)
>  
>  	switch(rets[0]) {
>  	case 0:
> -		result = EEH_STATE_MMIO_ACTIVE |
> -			 EEH_STATE_DMA_ACTIVE;
> +		result = EEH_STATE_MMIO_ACTIVE	|
> +			 EEH_STATE_DMA_ACTIVE	|
> +			 EEH_STATE_MMIO_ENABLED	|
> +			 EEH_STATE_DMA_ENABLED;
>  		break;
>  	case 1:
>  		result = EEH_STATE_RESET_ACTIVE |
> -- 
> 2.45.2

