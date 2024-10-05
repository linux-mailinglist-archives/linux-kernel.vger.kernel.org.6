Return-Path: <linux-kernel+bounces-351899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 423BD991765
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 16:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D267728324E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 14:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E544A1547C9;
	Sat,  5 Oct 2024 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJau59Xr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64DE81ACA
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728139033; cv=none; b=ALXZlDQwvan8muHJOJvtgRsQg1bBWTnTOvM0o9lA2IXf6PACkfDMmUQVPb9oHAHBXQUr1eF44/2X5w/ebHjFGVD+W0eXtQb9Dixg4qVRmuaja50jVghOYVYl+HZ/kScNyFfdLNJ8XMBww94oBn5chiyGyic5iBClbklN7YG7h0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728139033; c=relaxed/simple;
	bh=pm0nO5gSYVQPSBv5vxH/7O3yH4pDPUiLd9fwZFNojy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KUiGy48+1ykUcnBghHB/ufJGM/oprNsNizdtrxh8TBPyNuKqdzRGmXz2ui2NQa0KhXSEBIQXBfXZn+euiNRT4tK+C5Qzwn91PiHBzIQO7g8QAY9Lzza2p0+dZLVI4wI/vqPx6BpY4l6kWPsi8wy9epamVMJltft2206kjxw0BA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jJau59Xr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728139030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d+/qdPj0tJdAhJxSaH3N78ZRfthbF1lDVZ24T3uEt+I=;
	b=jJau59XrsY/UB6sDauqusETfkgAM1u8fnYeeJIubJjsepJ1UNqZROP+4f7T2VfyeMgEMw4
	1G4M0dqgpxV4xiqsECQNDnR1ZQ0J18YcvNevyj7osUKxsv0ADqZsAZ3RM5hprS2cc3SsCN
	X2J61FH8DabcQ1Uqua3Um8NUIcqZLzs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-lDVFkzI5M0S6npU6WdTUCw-1; Sat, 05 Oct 2024 10:37:09 -0400
X-MC-Unique: lDVFkzI5M0S6npU6WdTUCw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a8a92ab4dd0so222737466b.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 07:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728139028; x=1728743828;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d+/qdPj0tJdAhJxSaH3N78ZRfthbF1lDVZ24T3uEt+I=;
        b=ZsXzf77m4yy7+lrxtdl6rVA9yOIj1qDTxsLiaaWU79zmIQCqb47+H/JkwZrLFzW9dv
         egiuK+aK8y7XeYjnpxZ2Qyt/CgIm64yy9b8Rabq2LBm8rUWNVLTGpmJzIMj3Q7pJzMiX
         ckniLqcrPSIjBO2c3uIMuU4Cgi87CRAvhiswux76X0SHDFNx1Ssq2pWMAQiw4jPqrD7k
         EQZhr53gtT42SDQFyD4ofanazciTYP15h/qrtFDVc49DTk6gRR2RKXiUJR2mW3fh4rxj
         M0mXeFRg3RaSDEx1DxjPWsZBoV2yBF2RD/sufS44+dt8HmJefRsRjmEpmRjwoJu07fjc
         pQkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVrpnjthKromvw7hpEznXn5YD6hov8Fom/uQLXB9MwJT35evJgGti1Yh7kG8Reep3Gq7FAN+gdy6wYC4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9tTY32iFVRzkpfp7GVPvoIhXSfNk7MJi5Rd7OB3hii5og599q
	Y8yD87jN+MZUTb1JcEsW44N1ZWWZZaFT+WW2hi/J0/zOjLx94VVmHU/Elna/gzIiLGUbSlC74cO
	+etRKxJKAcNyrEGPLw5zt00kGo9+nPAeCK0TyBp3iVcdyBrr7kcYRc+B0PrH46w==
X-Received: by 2002:a17:907:3ea8:b0:a8a:71d5:1094 with SMTP id a640c23a62f3a-a991bff2c2emr645144566b.46.1728139028044;
        Sat, 05 Oct 2024 07:37:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtM30Gg20ozchjzie9R1RgjO/pyO0CcJBqzfnWbYE7kKmmom21lhcOKqhxUGWS2PbiAmpXeQ==
X-Received: by 2002:a17:907:3ea8:b0:a8a:71d5:1094 with SMTP id a640c23a62f3a-a991bff2c2emr645142666b.46.1728139027646;
        Sat, 05 Oct 2024 07:37:07 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e7b1d25sm138827566b.150.2024.10.05.07.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 07:37:06 -0700 (PDT)
Message-ID: <5c21455c-c688-4287-a4ad-d047efa180eb@redhat.com>
Date: Sat, 5 Oct 2024 16:37:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] platfom/x86: asus-wmi: revert ROG Ally quirks
To: "Luke D. Jones" <luke@ljones.dev>, linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
 corentin.chary@gmail.com, superm1@kernel.org
References: <20240926095344.1291013-1-luke@ljones.dev>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240926095344.1291013-1-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Luke,

On 26-Sep-24 11:53 AM, Luke D. Jones wrote:
> The ASUS ROG Ally (and Ally X) quirks that I added over the last year
> are not required. I worked with ASUS to pinpoint the exact cause of
> the original issue (MCU USB dev missing every second resume) and the
> result is a new MCU firmware which will be released on approx 16/10/24.

First of all let me say that it is great that you have gotten Asus
to come up with a fixed firmware, thank you.

With that said I believe that it is way too early to revert these quirks,
users are usually not great at installing BIOS updates and that assumes
this will be handled as part of a BIOS update, if it requires running
a separate tool then the chances of users not installing the update
will likely be even worse.

So IMHO for now we should keep these quirks around to avoid regressions
for users who don't have the MCU update.

Related, have you seen this series:

https://lore.kernel.org/platform-driver-x86/20240922172258.48435-1-lkml@antheas.dev/

that seems to fix the same issue ?

And it does so in another, arguably better way.

Although unfortunately as patch 3/5 shows just calling the global
"display off" callback before suspending devices is not enough
fixing things still requires inserting a sleep using a DMI quirk :|

Still that series including the DMI quirk might be a cleaner way
to deal with this and if that is merged then dropping the quirks
from asus-wmi makes sense.

Regards,

Hans




> All users should update to MCU FW as soon as released to:
> - Ally 1: v319
> - Ally X: v313
> 
> Luke D. Jones (3):
>   Revert "platform/x86: asus-wmi: ROG Ally increase wait time, allow MCU
>     powersave"
>   Revert "platform/x86: asus-wmi: disable USB0 hub on ROG Ally before
>     suspend"
>   platfom/x86: asus-wmi: cleanup after Ally quirk reverts
> 
>  drivers/platform/x86/asus-wmi.c | 39 +--------------------------------
>  1 file changed, 1 insertion(+), 38 deletions(-)
> 


