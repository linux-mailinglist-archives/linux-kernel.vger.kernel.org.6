Return-Path: <linux-kernel+bounces-303497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51648960D1D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDF47B25204
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EB31C3F24;
	Tue, 27 Aug 2024 14:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RCvrLB02"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CE81E487
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767506; cv=none; b=cqiFU8Gs3BoCk5ileCTMD22dgWLgKi5eyxzuoLBBDq+O+wD5mTj0v2MUi+ZwBQcbRQKvoeRjF2QdSl11/AsUeaZg5QfSXldk4CIoD3MMAO61RrFA374MHiBwCXlzco8J5aQJMILhsW9drJ6oEFXGHWkVqLvpaJdMFh8jdpeFAa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767506; c=relaxed/simple;
	bh=bM4fxNbrY/+xVU8fyQSBkQzkgoPZsh5qN3u1v0lkPNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uVX4zAJ3dVXOpZZeeTpoIZwCbx/cPpqB+DZhDDoJNNzHYZYaCzhbE0/Xb27DX/kR59ydZJ+CT34EIn4gw3NpFMOfpP1OXEgmf2KsXuX9HYFBZafvn+z2mMsUiKba+FyFKCcplPzk3IWZRq/jF5Z/6TA6qp3T14ijikRgxDUcxUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RCvrLB02; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724767504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o/+4z3eCYQ3ifiWxh2Mo64fSEyLTY0srxIMSGlgXIu0=;
	b=RCvrLB02miXAzHsvPV4RIlvMwKHejFSNlYMCPkmQ4xdhmTC3J6ggZgfTi7ZzIx8Lw/jmuL
	AfkSSGz0lc+imyDV1RI+2fzsLAbVJuh70ODnHt4KUsYs+2RBhk6IYDLcT6YMEp7MLF3B7D
	he8dQAzk8MQCEwz4Cp5zjTEIzCXrdHU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-uyXxc3u_Nayldg5YBDVEqQ-1; Tue, 27 Aug 2024 10:05:03 -0400
X-MC-Unique: uyXxc3u_Nayldg5YBDVEqQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a8680b74416so833586966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724767502; x=1725372302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o/+4z3eCYQ3ifiWxh2Mo64fSEyLTY0srxIMSGlgXIu0=;
        b=Os5fSWpg5OXZHHz9YxlSfE+QP44aie+x3aOkLHu4UvgRYO2iMgEw2mMJPDVMVW6VS+
         E84/t2ggUvxdvMn/YNGtaj9lFUXiZ9U92WetfjkHOC4rkfBr5PGQVUFq5ew1uGp2Ti61
         CB6r15aK4akMKNMXTbHYY+m4EYjmoRb0vH7ri7iBXKfYEC2EfiPRDBByullXgxw2GQH/
         FdPowPCd14y2vdziNrpvhNaLro38Lfc7rlsxQuSHFCejY+b271+n6LkH1xQCbs9kwD40
         1KUxmKdW0O6qCeZVE5bgg3chq2xMaLCaRtyydW0GPKH/KaS/mZ566HDjpWJI/h8LXG/Y
         Ro6A==
X-Forwarded-Encrypted: i=1; AJvYcCVzWN7zqXA5pKd+I5ss1HNxR/qMnhqVKzxqY5R+h2gHtltXsCCZ2/AASCf/XoJmrDe0785RPija72yk6Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbmH263IJeFU5CIZxzogTMchn5ff+kWQNqI21Dcf99FjNAo3YD
	XUK1oH83ylTPM3jPaJscac9WQbCZrsFh7VFHP5dYlGktW2VnMPEomJgXYznUo9IJssp8TKwLYqR
	T32XMUxKYneRv5vwKMw1D1ah7In3VCPWPaNUBmVmY0Awwa8c/BYHX524cCcUEAQ==
X-Received: by 2002:a17:906:fe46:b0:a7a:130e:fb6e with SMTP id a640c23a62f3a-a86e297a558mr332227566b.15.1724767501499;
        Tue, 27 Aug 2024 07:05:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPFM6fsuNqAoz9t1ZCb79CqPD0sS5dxWyKrPwS3nP6u25sZDYw8Fpsre6BrGY9O9j4ICI+Jw==
X-Received: by 2002:a17:906:fe46:b0:a7a:130e:fb6e with SMTP id a640c23a62f3a-a86e297a558mr332217866b.15.1724767500740;
        Tue, 27 Aug 2024 07:05:00 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e582d54dsm112656866b.129.2024.08.27.07.04.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 07:05:00 -0700 (PDT)
Message-ID: <56292842-2071-4c26-a380-c6ae1488361a@redhat.com>
Date: Tue, 27 Aug 2024 16:04:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] platform/surface: Add OF support
To: Konrad Dybcio <konradybcio@kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Maximilian Luz <luzmaximilian@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <quic_kdybcio@quicinc.com>
References: <20240814-topic-sam-v3-0-a84588aad233@quicinc.com>
 <20240814-topic-sam-v3-3-a84588aad233@quicinc.com>
 <ZszrjQChQ2aS5YjV@surfacebook.localdomain>
 <4dab4f36-309d-4b95-8b01-84963ca08d16@redhat.com>
 <cdd77270-3189-4fa9-9b4e-e443db5fb583@kernel.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <cdd77270-3189-4fa9-9b4e-e443db5fb583@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/27/24 3:52 PM, Konrad Dybcio wrote:
> On 27.08.2024 11:07 AM, Hans de Goede wrote:
>> Hi Andy,
>>
>> Thank you for the review.
>>
>> Note this has already been merged though.
>>
>> Still there are some good suggestions here for a follow-up
>> cleanup patch.
> 
> Andy, Hans
> 
> Is it fine if I submit a fat "address review comments" patch, or should
> I split it up per issue?

I would say use your best judgement / something in the middle.

IOW start with a fat "address review comments" patch and if
specific parts turn out to be somewhat involved do 1 patch
with smaller clean-ups and split out the involved parts in
a separate patch.

Thanks & Regards,

Hans



