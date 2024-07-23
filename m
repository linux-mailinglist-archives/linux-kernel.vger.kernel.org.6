Return-Path: <linux-kernel+bounces-259754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EE0939C9C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A0C281EEF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0791A14BF87;
	Tue, 23 Jul 2024 08:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sgvw9gay"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8620B14B07A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721723236; cv=none; b=gusaNYJ2MdoC0XS8GX2uKFK5usmZRU0JydxIvLRVl54pwXlZ5KXl71vgDg5b7g8785tRKdRs06ea9b2UXTHHiAYcdQC2r4FGNZ5PRSao6P5QJ/v9FvJn2M8D9iYooLkgSX6g4LvSm0WM4Kei7Q34//Ecba06m9XFiXJs9kOBbl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721723236; c=relaxed/simple;
	bh=GWxwNNUUchgR/mEv8fXJVXJ9+NszEjBE2JW5a21cBiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BWDWc78IwGSBG5cz2mT/loks1QXgzFNmqfop16OkxDq0kbn6mmUoeWDIVsZ44fIOfMFWggt6y+n8idrxd4XL6rDEhGS755N4Y+O8vD4uPz1P+rN2heE74bp16T/B481EFO3JCapgQ91ieoSxI66k6OVGUGXYXmOyw0c/Ho42Tk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sgvw9gay; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721723232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M8oot5yLF5sFfwOhcYmVL7lhOnl7mwaITw/QHpWL3yY=;
	b=Sgvw9gayo1vZSbBw4VQ/Z25wswtNDKlYLcUrxAsk9VMTtDGRE116JWHlBeULZsg2TIDlEF
	9hmDuUKTIj9vH+B5scHYKN7EPDDC+FTC543MM05QhPwxZcrUOsPBrZb4f9MHoo8L3dvDhI
	WUMcRTs8lLBcbZRX1N6Li23a9n4A+20=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-gfVYoRlVPQGFBY6BK9OXWA-1; Tue, 23 Jul 2024 04:27:11 -0400
X-MC-Unique: gfVYoRlVPQGFBY6BK9OXWA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42669213f26so3143865e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 01:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721723230; x=1722328030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M8oot5yLF5sFfwOhcYmVL7lhOnl7mwaITw/QHpWL3yY=;
        b=C9bZqumwaheCIlq+xZBHENMU+mBwdI7qfZxDcxvvslfuaKj9lgBZDxGSC2pgMUlzqF
         28oaBxOkzfZOll4T+uWmxoTppPIwnIlAEkCLZ2cZFMzrPxfU9XQPTDuUMgY39cFrpOFa
         H4xRX8Hnk3on6HdWoQLGmLDs+ICl9QpkDRLpOXc1FMNBvNZmiEHxLX1WdGZZnvRSR3nV
         oQIRbuGTFv+Sf8YLCc7X32cm9W37tzRpJdkUBKXDmas9bDbNPx9jgdn5yJJFkPuf8IIe
         a92fmTf/nizSccj7h9UodWwmwxEvaO8ETxUiK6BiaLy/YARgJoSkXhI7jk1H+JSdi0ls
         bY4Q==
X-Gm-Message-State: AOJu0YxCSwLlbKIF0W6vG4o9xHe5XUas1CcOY/tlGMEMTJ/y5DX7K7/k
	r3ogJdndE4oZvdSIum5F8CkEJVxRDkA/dzaure/jIWCm1vsTCQYPkTtNO2kuQ7kOLAZnHwcurnS
	eAT4TRyvEGeth28p8NHg2nRjCYkBZq4hMVmkWNnS1IvgG/ZjlhHARSoj75EDQVg==
X-Received: by 2002:a05:600c:310b:b0:426:6ecc:e5c4 with SMTP id 5b1f17b1804b1-427daa713abmr42159405e9.4.1721723229847;
        Tue, 23 Jul 2024 01:27:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyB35vHUyy7xn9TnmLleBJi8gLs2mzDoXRcT5qHjLuUf9xNuul01VsC7irrgvs/KrKyAUdGg==
X-Received: by 2002:a05:600c:310b:b0:426:6ecc:e5c4 with SMTP id 5b1f17b1804b1-427daa713abmr42159325e9.4.1721723229417;
        Tue, 23 Jul 2024 01:27:09 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:173f:4f10::f71? ([2a0d:3344:173f:4f10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a63b70sm188462035e9.19.2024.07.23.01.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 01:27:08 -0700 (PDT)
Message-ID: <afdb7011-5098-47dd-89af-5ed0096294d8@redhat.com>
Date: Tue, 23 Jul 2024 10:27:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] igb: cope with large MAX_SKB_FRAGS.
To: Corinna Vinschen <vinschen@redhat.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Nikolay Aleksandrov <razor@blackwall.org>,
 Jason Xing <kerneljasonxing@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>
References: <20240718085633.1285322-1-vinschen@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240718085633.1285322-1-vinschen@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/18/24 10:56, Corinna Vinschen wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> Sabrina reports that the igb driver does not cope well with large
> MAX_SKB_FRAG values: setting MAX_SKB_FRAG to 45 causes payload
> corruption on TX.
> 
> An easy reproducer is to run ssh to connect to the machine.  With
> MAX_SKB_FRAGS=17 it works, with MAX_SKB_FRAGS=45 it fails.
> 
> The root cause of the issue is that the driver does not take into
> account properly the (possibly large) shared info size when selecting
> the ring layout, and will try to fit two packets inside the same 4K
> page even when the 1st fraglist will trump over the 2nd head.
> 
> Address the issue forcing the driver to fit a single packet per page,
> leaving there enough room to store the (currently) largest possible
> skb_shared_info.
> 
> Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRAGS")
> Reported-by: Jan Tluka <jtluka@redhat.com>
> Reported-by: Jirka Hladky <jhladky@redhat.com>
> Reported-by: Sabrina Dubroca <sd@queasysnail.net>
> Tested-by: Sabrina Dubroca <sd@queasysnail.net>
> Tested-by: Corinna Vinschen <vinschen@redhat.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

@Tony: would you like to take this one in your tree first, or we can 
merge it directly?

Thanks!

Paolo


