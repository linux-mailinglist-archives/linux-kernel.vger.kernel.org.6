Return-Path: <linux-kernel+bounces-271391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39301944D8E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BF67B209E7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B2B1A38F9;
	Thu,  1 Aug 2024 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IDDe0iUy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAD661FF2
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 14:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722520881; cv=none; b=SJ7zIeBfJdccQ0P5TuwCFg15W873jxmxKNXxAKYQnZTshMxqx7jJO4m2b9APcIJcYgFZ14kzIYLUqXwL7IfTmdKlTAPh9rHRm/Xdfer4lJH2Akr90I7TaojLBdPeatWrMGqBgo4bhVHLHfKhHBrZOu52GKGpCeQseuPRg6N5pWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722520881; c=relaxed/simple;
	bh=8bMRJX5Wva0XdUpS4bnRq3LDkoZbYGfLBZUwOtB3FFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YfOfSH6D56obls4bWu0d2gvtoYn4b8RMRANv3QGbGeN0eY5eAAqSZveBeQygxnCeFAVhURJWc0TT/Ym2y1o8OmQc+Sz62R9nmxiT2ekWpRt4k10U7PSRBMsNBbWaRmw7+cCv6XEEFQlkaZe2NhzQlXuk7mm99Jvl85cKtBXCTLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IDDe0iUy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722520878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=85tqexyUb9G9xesjtDuJjUBYMhn4OYlFpDKqijS2vtE=;
	b=IDDe0iUyRbi0gHQEac/G8H77LRruvyM8PI3KOxU+FmxhReHn9YAbifm3bAuAst1AddYXi0
	V//2dnJLBnHJSDAjduEvUIP5DOptXx+ZqwLX3V9R7842DHQwpZ3+sjBx63dfmPeU3ixm/f
	4qEevJbw8NSQ74DWydhAWLQL5b/zSV0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-EEEzRvTpOJ6JZgexQufFsw-1; Thu, 01 Aug 2024 10:01:17 -0400
X-MC-Unique: EEEzRvTpOJ6JZgexQufFsw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5a5db6234d6so5811961a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 07:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722520876; x=1723125676;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85tqexyUb9G9xesjtDuJjUBYMhn4OYlFpDKqijS2vtE=;
        b=fuUnFVcbp5xyhbL17PxVFcAe5seJ8xHcVB1fAVNA8dsdqcNGXoqRpIqiAhkZOWINyO
         Uxu4QoAwp6McTmEaIjClWZY3CfPtKW8l9PHclX57+TZS8Dlj+jV9NvL40Pr2TUeI8RG/
         LXYlz40PDP+8Yl0WOFte5vCBvGB26nnvCZvCSge0d62UDzmuItADgweVEROXN3LSsScf
         fXhEU8WCkNXoynDrhBcrpLG4/t1YBmgI8vIVLoJYhvOoWjJ1ECQKecIzBjhw46Y/1rkO
         dyXVWOPcJnfy5RI/SWfb3FJPsGfNEVr4dT6B0wK+tX12rUzJtROy2VpeIag+RSay3B0L
         Ouww==
X-Forwarded-Encrypted: i=1; AJvYcCXEQUvLsvlhF6NpRe4N44RcbwWuYwCTZ38AYNc0QaWZTb2F/gSJ4Yj2fKyZ4Yj3NFwgfWy+hlc0vmjXstbrAwpHxtD8PQQrAdVA/tAm
X-Gm-Message-State: AOJu0YynHPxN6eaxY+sDK57bkoT8EZMvL8EIilibbTXd9cNJstjRZul7
	jh6xdTrTOKPnvzsYJWm/t6oXzbjJjb+mNPKN0F846bNrAKTe3qjsed1Ln/wpnr8tV1eEFNk7xfp
	UW1gj14R7FLeYtrIQT8zKhvsH0ufyb/k1hzCCURQJ/O16dUMKBO6guUtnFn5ZT6HHSdkPXg==
X-Received: by 2002:a05:6402:457:b0:5a2:350d:dfb9 with SMTP id 4fb4d7f45d1cf-5b7f36f56f8mr291465a12.2.1722520875753;
        Thu, 01 Aug 2024 07:01:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9oZedRaBpD4yRHIOSqQmwf9AUGq1ILfzXuz8c08wd3DL7M8+kU29GMpYyUDMMmaBdEgKdFA==
X-Received: by 2002:a05:6402:457:b0:5a2:350d:dfb9 with SMTP id 4fb4d7f45d1cf-5b7f36f56f8mr291409a12.2.1722520875045;
        Thu, 01 Aug 2024 07:01:15 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5afb9422c41sm8608972a12.82.2024.08.01.07.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 07:01:14 -0700 (PDT)
Message-ID: <c3be1b7f-8a4c-42d8-9a5d-6a341c5beb33@redhat.com>
Date: Thu, 1 Aug 2024 16:01:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] platform/x86: asus-wmi: add support for vivobook
 fan profiles
To: Luke Jones <luke@ljones.dev>, Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
Cc: corentin.chary@gmail.com, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240609144849.2532-1-mohamed.ghanmi@supcom.tn>
 <20240609144849.2532-2-mohamed.ghanmi@supcom.tn>
 <9daef2c6-6df4-4f61-966c-239450de7b4e@app.fastmail.com>
 <ZnlEuiP4Dgqpf51C@laptop>
 <ebad3eec-576b-46ef-887b-6d3ce31bd5f8@app.fastmail.com>
 <ZqopEfPCuU7-7mUR@meddabeast>
 <d21a1be5-7589-49e4-a96b-cddf9b6c15eb@app.fastmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <d21a1be5-7589-49e4-a96b-cddf9b6c15eb@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/31/24 11:06 PM, Luke Jones wrote:

...

>>>>> If Hans and Ilpo don't have any requirements then:
>>>>>
>>>>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> 
> I have no issues with this patch and it needs to be merged before I submit a stream of work. My signed-off tag is above.

Reading back the comments about the function names I believe that
the asus_wmi_platform_profile_mode_[to|from]_vivo() names are fine.

And the rest of the patch looks good to me to:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

I have merged this into my review-hans branch now with one small change,
both asus_wmi_platform_profile_mode_[to|from]_vivo() ended in:

       return mode;

}

I have dropped the empty line after the return mode; statement
(in both functions) while merging this.

I've also dropped a spurious whitespace change (extra empty line)
added to asus_wmi_platform_profile_get().

Luke, please base your coming work on top of pdx86/review-hans.

Regards,

Hans


p.s.

One thing which I noticed while reviewing is this:

static int fan_curve_get_factory_default(struct asus_wmi *asus, u32 fan_dev)
{
        struct fan_curve_data *curves;
        u8 buf[FAN_CURVE_BUF_LEN];
        int err, fan_idx;
        u8 mode = 0;

        if (asus->throttle_thermal_policy_dev)
                mode = asus->throttle_thermal_policy_mode;
        /* DEVID_<C/G>PU_FAN_CURVE is switched for OVERBOOST vs SILENT */
        if (mode == 2)
                mode = 1;
        else if (mode == 1)
                mode = 2;

        err = asus_wmi_evaluate_method_buf(asus->dsts_id, fan_dev, mode, buf,
                                           FAN_CURVE_BUF_LEN);


Since asus->throttle_thermal_policy_mode stores the raw mode, which has
silent/overboost swapped for vivo notebooks I wonder if we should still
do the mode 1/2 swapping here when on a vivo notebook ?

I have a feeling the swapping here should not be done when one a vivo
notebook but I'm not sure.

If the swapping here should be skipped on Vivobooks please submit
a separate follow-up patch for that.

Regards,

Hans



