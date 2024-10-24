Return-Path: <linux-kernel+bounces-379122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2689ADA4D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 05:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86346B22670
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B6815B96E;
	Thu, 24 Oct 2024 03:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jc/YBuLg"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B0F155308
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 03:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729739624; cv=none; b=ljmUSzfbvzxstPKUCuJLkgxjE6uABS8NcqWrAKrOQEiH8oCdinnVB0dbyBNEZdn/QtVgCafZTw0YlSWQxFParkofU5tooA9otak/o+kr0GBy1d+JIjkXfvez49fbWefo5oZsHh/m+O9vXVw3tC3O1e/14wuuUKkHTzLROyTBgfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729739624; c=relaxed/simple;
	bh=iOPoDKzK2AmC1N0sgZTuwXPqY49UuLCsftKjWpgz5i8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ba4+RuiBbxiWzk9NfBhJElA1PH/OhYwmvd3ojDqL59nvl6z5Kai0HZUt2ux1p/X1D/kvsmfJ+n9ozXcfAaLg+G89lPXvEA40RQDyMMO08YXm6vr2nMOhqRWFpqkHVVwgvfOhMfxlJxqTY94tPc7X1zMCaozn/VEdditxt+5HIpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jc/YBuLg; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2b9480617so390143a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 20:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729739620; x=1730344420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xP6sdeYNg4L9xmeUb5AgsCXs2olbhdVL7zaGRhsZ/a8=;
        b=jc/YBuLg1KucMS5dKMdObSu9y0DkVo+Qu670IFDkdR1LOp1QectXBL6ifgo7rQxuCs
         dS7BwYYYB2JVzAEXFBWmLRHmccJFBcOlQU7zyZoSVJ6AK/b3/WUXjvPr1HMX0Qd+H6Wc
         EsUj/p/D5+zZ3ve2Mqhn3MZCO/6KBMJeb+KHqVZM3iIrYza3KUUqc17KwxzC8+6EpCVT
         Z9H8KHmAdFEJf5x8jWCo4u42SYJJBYxLcS7svwC1xPZWWUmz3dYM20vn55c1ECO/0fOg
         D0lbebo5sp/HFRQ4imWf22kEDPMbw5F9mpWLznBOQkiE9BLeibqDloV7uvqN7M3BpGKF
         Ah2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729739620; x=1730344420;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xP6sdeYNg4L9xmeUb5AgsCXs2olbhdVL7zaGRhsZ/a8=;
        b=j21hLeQ4IXrrgQcCSaRHNE9n5PIpfG4JhABeGIB7q2LBGAVbpJEiN43d8z3BRJPoRY
         X3R7nn82BXxLhjxWpZebk7a0U/ulY/y8UXwy/RZ/B/ICFyG7jYCVsM8tSAN2u7Kskczc
         6oY9oLQHoJrVzXwWv5A5M4TNwuzxTFZviipESdPXqtZTExtwqLZMKwSIr47SPKiQMj5u
         Q0Y3EMWu/Zv1bzT42ZwV0HYYWsdF+dhw5bsmmDWFMH7Jy5dJCZ9M3o+2pwTsPboMh3XA
         bDDhznUhf7U202l88YRlWpL1EexHJmCfWS8Y0R+KZ7euFBMW+bDF6jqx9w7+rg9hapbW
         mBAw==
X-Forwarded-Encrypted: i=1; AJvYcCWU8fTZjClY95/EOT363CUkEFZ8b8W/+4jcYMnURQQGFH2Y01DFCTdipjy3zFYQzdVkbz0VRG9Gs02S68o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqBi4Y/AiicWBmvFKLddzNCpHa6thZ5kkpnnwKVbxl7xl+P5Za
	61KEBw/Jtd7uz+rFqjVFP4aX05jG8IhoN63agEBBZNryGsIZQhilKsBf6Qemyw==
X-Google-Smtp-Source: AGHT+IEqcaOy41a74/QJo1V0+sa8hEK4p1INoNXDBNPsxy2R+DE6joNBtePQTdENvYDN9mC4D5lLsA==
X-Received: by 2002:a17:90a:3ec7:b0:2e2:bd7a:71ea with SMTP id 98e67ed59e1d1-2e76b5b56cdmr4882107a91.8.1729739619929;
        Wed, 23 Oct 2024 20:13:39 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2e14:7:d115:de66:80f:f3f7? ([2a00:79e0:2e14:7:d115:de66:80f:f3f7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e4e4008sm273121a91.24.2024.10.23.20.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 20:13:39 -0700 (PDT)
Message-ID: <d6bbd32a-6de4-492a-8965-c0bc3dbddcff@google.com>
Date: Wed, 23 Oct 2024 20:13:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: tcpm: Prevent Hard_Reset if Vbus was never
 low
To: Yanik Fuchs <Yanik.fuchs@mbv.ch>,
 "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "rdbabiera@google.com" <rdbabiera@google.com>,
 "linux@roeck-us.net" <linux@roeck-us.net>,
 "kyletso@google.com" <kyletso@google.com>,
 "badhri@google.com" <badhri@google.com>,
 "xu.yang_2@nxp.com" <xu.yang_2@nxp.com>, sebastian.reichel@collabora.com
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <GVAP278MB0662F98EAAFAD95645E7010A974C2@GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <GVAP278MB0662F98EAAFAD95645E7010A974C2@GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Yanik,

On 10/22/24 10:28 AM, Yanik Fuchs wrote:
> Good Evening
>
> Here is a Patch to resolve an issue with TCPM if Vbus was never low.
> Please consider that this is one of my first kernel pull requests, I may have missunderstood the process.
>
> Freundliche Grüsse
> Best regards
>
>
> Yanik Fuchs
>
> ---
>
>  From 604b97b6394b5643394bc63d4ac691c098c99c40 Mon Sep 17 00:00:00 2001
> From: yfu <yanikfuchs@me.com>
> Date: Tue, 22 Oct 2024 18:23:18 +0200
> Subject: [PATCH] usb: typec: tcpm: Prevent Hard_Reset if Vbus was never low
>
> Before this patch, tcpm went into SOFT_RESET state, if Vbus was never low
> resulting in Hard_Reset, if power supply does not support USB_PD Soft_Reset.
>
> In order to prevent this, I remove the Vbus check completely, so that
> we go as well into the SNK_WAIT_CAPABILITIES_TIMEOUT state. There, we send
> PD_CTRL_GET_SOURCE_CAP which many power supply do support.
> (122968f8dda8 usb: typec: tcpm: avoid resets for missing source capability messages)

Please refer to 
https://lore.kernel.org/all/20241024022233.3276995-1-amitsd@google.com/ as
122968f8dda8 is causing USB Type-C PD compliance failures.

>
> Additionally, I added SOFT_RESET (instead of Hard_Reset) as Fallback solution
> if we still not have gotten any capabilities. Hard_Reset is now only done,
> if PD_CTRL_GET_SOURCE_CAP and SOFT_RESET fail to get capabilities.
> ---
>   drivers/usb/typec/tcpm/tcpm.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index fc619478200f..c7a59c9f78ee 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -5038,14 +5038,8 @@ static void run_state_machine(struct tcpm_port *port)
>   		 * were already in a stable contract before this boot.
>   		 * Do this only once.
>   		 */
> -		if (port->vbus_never_low) {
> -			port->vbus_never_low = false;
> -			tcpm_set_state(port, SNK_SOFT_RESET,
> +		tcpm_set_state(port, SNK_WAIT_CAPABILITIES_TIMEOUT,
>   				       PD_T_SINK_WAIT_CAP);
> -		} else {
> -			tcpm_set_state(port, SNK_WAIT_CAPABILITIES_TIMEOUT,
> -				       PD_T_SINK_WAIT_CAP);
> -		}

Instead of deleting code, please restrict this behavior to non self 
powered battery case as this most likely break compliance and

may break actual use-cases for other users as a result. If you want you 
can move stuff around after

https://lore.kernel.org/all/20241024022233.3276995-1-amitsd@google.com/

gets accepted in the following way:

```

if (!port->self_powered) {

         tcpm_set_state(port, SNK_WAIT_CAPABILITIES_TIMEOUT, 
PD_T_SINK_WAIT_CAP);

         break;

}


if (port->vbus_never_low) {

         tcpm_set_state(port, SNK_SOFT_RESET, PD_T_SINK_WAIT_CAP);

} else {

         tcpm_set_state(port, hard_reset_state(..), PD_T_SINK_WAIT_CAP);

}

```

This way you don't have to execute the SNK_SOFT_RESET flow for non self 
powered use-case.

Thanks,

Amit

>   		break;
>   	case SNK_WAIT_CAPABILITIES_TIMEOUT:
>   		/*
> @@ -5064,7 +5058,7 @@ static void run_state_machine(struct tcpm_port *port)
>   		 * according to the specification.
>   		 */
>   		if (tcpm_pd_send_control(port, PD_CTRL_GET_SOURCE_CAP, TCPC_TX_SOP))
> -			tcpm_set_state_cond(port, hard_reset_state(port), 0);
> +			tcpm_set_state_cond(port, SNK_SOFT_RESET, 0);
>   		else
>   			tcpm_set_state(port, hard_reset_state(port), PD_T_SINK_WAIT_CAP);
>   		break;

