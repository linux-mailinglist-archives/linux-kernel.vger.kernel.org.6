Return-Path: <linux-kernel+bounces-519382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C90A39C40
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 982BF3B5272
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAB024633C;
	Tue, 18 Feb 2025 12:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8MP29FK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFEF246320
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739881906; cv=none; b=rSxoGlrAdahiz2D7EA9InQbiaRfG9qfd3gmN+a+QLkc/3rNldwN3dJ+eocSQC7Hsv3iXPDOS3y0rlghy5hOTqoZ8WaFZr++FAMuznLU3uLN8dGbG2aJXIoq9PEthjsrG9NXrKrq13sDq3gIu4JGaI5R6tTuUsAIMJ/tNR6I3vpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739881906; c=relaxed/simple;
	bh=mo8Lero/PMWKh6/jJes2kVTOcUZSoBd2IMLZN9mT3kM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZL9JdIB4hJnbsSHzfXfrR7AlMeYJZajmvLQmuCXxQcNnogu/Xn233PV7H2SP+3GyqXyRbK9PAtdApv8ijm+wKC/iwWYF4rP6gbPxCei59U+BfpOM9Yui59Jj7mg8MdoNjzDSKP5LUyE6y727j9770PKf5V72mByvAlH1b50clY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A8MP29FK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739881903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vpbns3ed9kgVrptgMa++JNWIuHOqPUJv9ijZsvk+Wfs=;
	b=A8MP29FKw0DIdB6v5M8w5MsIvc7yk2+0XPKCFiNjNa8FZhguB2ptSYR72Sjo4R4Y8E0fBL
	Hq1XSXqro89lVz4vE4uOcK7A2UOVTd/4+/ROe87oXC8K0uqzALcmZVITaDoulvTs1cqrcU
	k8Uqfguj6XUoWbbHQ4C2+MGglTLDD8s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-jKoxacS1Nf6PZkKpDK2dJQ-1; Tue, 18 Feb 2025 07:31:42 -0500
X-MC-Unique: jKoxacS1Nf6PZkKpDK2dJQ-1
X-Mimecast-MFC-AGG-ID: jKoxacS1Nf6PZkKpDK2dJQ_1739881901
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43935bcec79so32353425e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 04:31:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739881901; x=1740486701;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vpbns3ed9kgVrptgMa++JNWIuHOqPUJv9ijZsvk+Wfs=;
        b=cERwq9Z5q5XpbmZgV+fV8YgFShEeg6EKzpNFlSJ876gk2MpPn32843fc4KK4r7nLs+
         NBGuHq30N1IrXPnTATVjvyELSiEwt0o7n6m+Epl3Z2vT2O4so0skE/QTRsFih83IrhsC
         OKrFnN2b777wv5ODKMGy8cWZzhBxHRu2obvtHWFEYddkVNf21Q6+KU1wgT6n51JoUAyw
         R9TAjZ9Kcy4DdPi6xqzxFk9VgI0EzLaUzyI3/4DsuoQM/jNheAPeKlsE+fp7mw3jDGJi
         HIkRpu6y8WJ+drOc18HVhinK9KtGVPc0SGs+1yzvny++dT5knaV2kQDEdHH0etGJiLZI
         bcfA==
X-Forwarded-Encrypted: i=1; AJvYcCXlc5Yl+GKHd2zgPmxt5iuzOwnPoTpjfJkhWvsOnJhX3fNye4mpFf7fc//42J3EcHyuwp2GSMhlrRshGKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfxlrrJPGOoQOD24EI+4lmf4ha56KBFtz04w3wX2piiOpHlCNS
	mlzQwANX7XCjA32GVd99k9QQ5KXEt6A+DvmEIIigOnwjj90Iwn6GwlMI+zVcBhT6NfhAFh8++mr
	KQyDlHZTg/bsH3PM447XCUXHV9a8Oj7q4dx6jc/I6Ksw5fozN6OSfGvdlvfu4Bw==
X-Gm-Gg: ASbGncsjg4oLUP1h3rHg19eYmAON5GUhqYOFqKyjIBjtmFixgveHK44NkXW81A3cnbH
	ueCHTUyWFQoTcrSCUDnC4mi4c2PpOiW3wZJv74ziUazSbZd3Ah9GRYkkd156sZy5Zq4RoMImXy+
	OZO5NnwNtsqzs2yUek2YAJKXVmOGWDtELl1za/rGEshl2YqJTLzlPNIiyfKyB+Z9K+DYa5/4xGh
	RVA0MZ91WpYXH05O7hrZ9FAkn/hIzRWgZCtWzPHO8o1FfZTgIf2os6RKMJWL3q/xkydb1vb2Ft0
	aEx0wKwLlG5Uki6F72uvdNJvZtERv9Fw+m8=
X-Received: by 2002:a05:600c:470e:b0:439:6741:ed98 with SMTP id 5b1f17b1804b1-4396e5bbc88mr148435735e9.0.1739881900655;
        Tue, 18 Feb 2025 04:31:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDFKLpx8JwArBLTq7YvuKzHM9reL5OjH0AnpIyarnMelJJVplspL1UkuPUExc/hTNjjyvEUA==
X-Received: by 2002:a05:600c:470e:b0:439:6741:ed98 with SMTP id 5b1f17b1804b1-4396e5bbc88mr148435275e9.0.1739881900273;
        Tue, 18 Feb 2025 04:31:40 -0800 (PST)
Received: from [192.168.88.253] (146-241-89-107.dyn.eolo.it. [146.241.89.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43984dd042fsm56283195e9.12.2025.02.18.04.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 04:31:39 -0800 (PST)
Message-ID: <6fb9612f-b049-427f-a643-e1123a7478c7@redhat.com>
Date: Tue, 18 Feb 2025 13:31:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hexdump: Implement macro for converting large buffers
To: Nick Child <nnac123@linux.ibm.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, haren@linux.ibm.com, ricklind@us.ibm.com,
 nick.child@ibm.com, jacob.e.keller@intel.com,
 David Laight <david.laight.linux@gmail.com>
References: <20250214162436.241359-1-nnac123@linux.ibm.com>
 <20250214162436.241359-2-nnac123@linux.ibm.com>
 <20250215163612.GR1615191@kernel.org> <20250215174039.20fbbc42@pumpkin>
 <20250215174635.3640fb28@pumpkin> <20250216093204.GZ1615191@kernel.org>
 <20250216112430.29c725c5@pumpkin>
 <Z7NRLmcWJFNkyHGN@li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Z7NRLmcWJFNkyHGN@li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/17/25 4:09 PM, Nick Child wrote:
> Thank you David and Simon for testing and review!
> 
> On Sun, Feb 16, 2025 at 11:24:30AM +0000, David Laight wrote:
>>
>> I just changed the prototypes (include/linux/printk.h) to make both
>> rowsize and groupsize 'unsigned int'.
>> The same change in lib/hexdump.c + changing the local 'i, linelen, remaining'
>> to unsigned int and it all compiled.
>>
>> FWIW that hexdump code is pretty horrid (especially if groupsize != 1).
>>
> 
> Given this discussion and my own head-scratching, I think I will take a
> closer look at hex_dump_to_buffer.
> 
> I was trying to avoid editing this function due the number of callers it
> has across the kernel. But I think we can get away with keeping the
> API (but change args to uint's) and editing the body of the function
> to always iterate byte-by-byte, addding space chars where necessary. At the
> cost of a few more cycles, this will allow for more dynamic values
> for rowsize and groupsize and shorten the code up a bit. This would also
> address the "Side question" in my cover letter. Will send a v3
> regardless if I can figure that out or not.
> 
> The return value of hex_dump_to_buffer on error still irks me a bit but
> I don't think that can easily be changed.

For the new versions, please:

- respect the 24h grace period:

https://elixir.bootlin.com/linux/v6.11.8/source/Documentation/process/maintainer-netdev.rst#L15

- add the target tree in the subj prefix (in this case 'net-next')

- ensure all the patches in the series have consistent subj prefix,
otherwise patchwork will be fooled.

I think it would be better to avoid modifying hex_dump_to_buffer(), if
not necessary, and I think you could do so either changing the type used
in patch 2 or even dropping such patch.

/P


