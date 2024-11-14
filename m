Return-Path: <linux-kernel+bounces-409876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35DD9C92CC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FC11B29B58
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6571ABED8;
	Thu, 14 Nov 2024 19:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2WSrssaB"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CC41ABEBF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 19:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731614387; cv=none; b=Rff9q53RpSW64aopD1AhU4zfc9EN53Fp4lS+Pdho+7R1u4uUao2sZejU+kerLpNy6ARGv6lGicyX061RjwlUdulftkEok6ncDLM8bnWcrmr94ONZgBMSFb0y+8iqA5HDOruRPNaAmHmKlt9u+zJVZtW/+U1EVuJCIDlh/ImFFmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731614387; c=relaxed/simple;
	bh=tQgeVzgK4wXv3E2C5SqSBRL12zBuZISzX9XDpKDRNsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aXv6U7qbA9qCNkmLuKBGm8HNj3Skxk/wpXU0AzzE4tn5VSZfUg1yLb44vAtUIJXmaLQxKx32L5s/Zls3GDRRq8KwkYYWrRQFpevA9cJovdJnCkfgLvRMd5A6XSXLzZWxjEn+azDtZsHaEKhYLfMmSzv5GTNNmxZGrlGCkxT4WG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2WSrssaB; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e9ff76facaso941673a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731614385; x=1732219185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EZi7Lj1ZcBfcvykwJTKWnHyRvusqrexqvy+c3ZLzfX8=;
        b=2WSrssaBRYP1rOM/lW7gfnRBj+yV5/cxODLGGlCUMVPOVN8ErvErd4rXwYQc9No0+k
         ze/Vs0vsTRP1bT7RAWHe7J7j0a6Q4I9+hH1ICXV2dTiInSdul7C8kqBeqjVdPDXK8NI2
         71hjCO0/rbVoTUBpGyLS9uDqlRivoCUDJtJ6tM9lnZOHWpioy8bpDzeT/Oq7GwuHBVts
         ZWQhcKbcloPeWZtNqJMINGsH2J39XFscwz0KIq/wYQsvMI8Yv/hp0xZjPkNTIpAP17x8
         vBONqVs2XkYXxvGrLr+fT55+yzPJyocIG3YD54WWGtjczz/Y3xEeYZHfSLvWOkt7EQqP
         1SHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731614385; x=1732219185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EZi7Lj1ZcBfcvykwJTKWnHyRvusqrexqvy+c3ZLzfX8=;
        b=GSxoV2ncppmt2XAR20PbURL0JBEu6/MUijj/ibTR9UK1sumBtiNcY8ZfYxuOvaYtxF
         kmrye+UE2N6Zkj/YEZfvZs/J/Wt59n7cLHDrLcDSgM+DROvtLZl8YNaYVPfvQecRxSge
         CazgS81QyZME792bIzmCYGVnu61nSeY+dbSXlH/O5KtjT3IpSSOc3s9faGYNeK4U3Q63
         S1d2fmUwPU2WhP9nF6d2rX16hw81jj+kZoPdp3Ju+EZb+lU7a1qt3L1luuurT5hLhlt4
         YGm6yRPntHrA3qivjkNupcLdcDpRfEYHS9wUyYe9k1PLtOy8fv91We+wMDfp8L6lMmgs
         bFgA==
X-Forwarded-Encrypted: i=1; AJvYcCUsPlGpgCzE1nXBJlyhwD+nG/nuQ/PfLR3aoJb7QQ76n/rCK4CMQCMbxwDHMaGFqy52sEBVfjlNF1h1vBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPCLo44fmAenMpVjs1q7WXbceZTD1P2kXH9kvQLElFUn6qa+M5
	rOVs0bE0wFogRY+4BB28y6y/5y/voYP1eMO+C3uDzM0gg2DjC5F9lcYgzlFBBg==
X-Google-Smtp-Source: AGHT+IEG2iyaLo/V32b4gUuWEyznJd83z0AiWpxXK2+DZe0vLiJz7+gT+kehXIba5NtSHrmX+ylR3w==
X-Received: by 2002:a17:90b:1a8c:b0:2d8:85fc:464c with SMTP id 98e67ed59e1d1-2e9fe6a2c12mr6840630a91.11.1731614384455;
        Thu, 14 Nov 2024 11:59:44 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e14:7:68f9:3420:4ab6:673b? ([2a00:79e0:2e14:7:68f9:3420:4ab6:673b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea0248195esm1697912a91.2.2024.11.14.11.59.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 11:59:43 -0800 (PST)
Message-ID: <f244542a-7160-4f05-acaa-0e2574ee289d@google.com>
Date: Thu, 14 Nov 2024 11:59:41 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] usb: typec: tcpm: Add support for
 sink-bc12-completion-time-ms DT property
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com
Cc: dmitry.baryshkov@linaro.org, kyletso@google.com, rdbabiera@google.com,
 badhri@google.com, linux@roeck-us.net, xu.yang_2@nxp.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20241103034402.2460252-1-amitsd@google.com>
 <20241103034402.2460252-4-amitsd@google.com>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <20241103034402.2460252-4-amitsd@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Heikki,

On 11/2/24 8:43 PM, Amit Sunil Dhamne wrote:
> Add support for parsing DT time property "sink-bc12-completion-time-ms".
> This timer is used to relax the PD state machine during Sink attach to
> allow completion of Battery Charging (BC1.2) charger type detection in
> TCPC before PD negotiations. BC1.2 detection is a hardware mechanism to
> detect charger port type that is run by some controllers (such as
> "maxim,max33359") in parallel to Type-C connection state machines.
> This is to ensure that BC1.2 completes before PD is enabled as running
> BC1.2 in parallel with PD negotiation results in delays violating timer
> constraints in PD spec.
>
> This is an optional timer and will not add any delay unless explicitly
> set.
>
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>   drivers/usb/typec/tcpm/tcpm.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index b3d5d1d48937..8b325b93b5a9 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -319,6 +319,7 @@ struct pd_timings {
>   	u32 sink_wait_cap_time;
>   	u32 ps_src_off_time;
>   	u32 cc_debounce_time;
> +	u32 snk_bc12_cmpletion_time;
>   };
>   
>   struct tcpm_port {
> @@ -4978,7 +4979,16 @@ static void run_state_machine(struct tcpm_port *port)
>   		if (ret < 0)
>   			tcpm_set_state(port, SNK_UNATTACHED, 0);
>   		else
> -			tcpm_set_state(port, SNK_STARTUP, 0);
> +			/*
> +			 * For Type C port controllers that use Battery Charging
> +			 * Detection (based on BCv1.2 spec) to detect USB
> +			 * charger type, add a delay of "snk_bc12_cmpletion_time"
> +			 * before transitioning to SNK_STARTUP to allow BC1.2
> +			 * detection to complete before PD is eventually enabled
> +			 * in later states.
> +			 */
> +			tcpm_set_state(port, SNK_STARTUP,
> +				       port->timings.snk_bc12_cmpletion_time);
>   		break;
>   	case SNK_STARTUP:
>   		opmode =  tcpm_get_pwr_opmode(port->polarity ?
> @@ -7090,6 +7100,10 @@ static void tcpm_fw_get_timings(struct tcpm_port *port, struct fwnode_handle *fw
>   		port->timings.cc_debounce_time = val;
>   	else
>   		port->timings.cc_debounce_time = PD_T_CC_DEBOUNCE;
> +
> +	ret = fwnode_property_read_u32(fwnode, "sink-bc12-completion-time-ms", &val);
> +	if (!ret)
> +		port->timings.snk_bc12_cmpletion_time = val;
>   }
>   
>   static int tcpm_fw_get_caps(struct tcpm_port *port, struct fwnode_handle *fwnode)


I wanted to gently follow up with you on this patchset if this looks 
okay to you?


Thanks,

Amit


