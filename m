Return-Path: <linux-kernel+bounces-329016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF0A978C19
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 02:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02CFD1C2505C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 00:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316631FB4;
	Sat, 14 Sep 2024 00:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="vBjau/Iu"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0F320E6
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 00:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726273412; cv=none; b=oGJIdih3yXzZQ8ftSveTcn1qxOncyA6lmKHFCEUyPLTG3NWrfvBmLPJv6qTflc6Xle37fJYY+efYRIC7wY76ASeLnvYVoVyMhBbNGkYOmlspCxupP+EIDezWgbzKhpgCcP8LjT6TOYRsbAUBtXHNrNCrebEToV5p78UeC00wxK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726273412; c=relaxed/simple;
	bh=AxVG7RUK2kMrkxSkKPsXEsHSN3IPGF3HMxZVEFbkgvs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LeI1MKmppGzbH5NUmHygv3fIzCla8V2HLra7xzfaNvluW6JcdxsJ7/01+yk7hn4XgekOOCVrfFjY+85vkV4dX7GLbFicUSA2WYe2k4s3ATEl7yGSx2ibLjpbTGSefVr3aGukjHeeB5lrcYvGJ7+JgFIqit2FQ5I4ZfjLH8WW6rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=vBjau/Iu; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8a92e8c840so31913466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 17:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1726273409; x=1726878209; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWRpDEvf1ffrH3KJKnl7mhymuRwMfVVLoo/Ecw4leuQ=;
        b=vBjau/IuEtAiESABVwsfrFkvjVa/31ASSKjMqsKRyiwq8OhVbdQrJRM5zq0EF99htr
         cubFSj1acFJSJkg6X/VqDz46TJ7HLAAqb6L4J6Z4RUF+bN/CWdpHcgypY+TaXyVVFuhL
         G8O2Aetb9T9NjqQg7H0DgelLHf15AbRoNYRcSsQKYwCWfBdsyqOrb4wiATqxUnkiYXqC
         dto8WRsQ/XrsqCqxUAOcCg/5CpUflKbBN8S0rTxVHvxzvKMh8GSg+S2NibDmA2dV4A2L
         HTphhDw1ao2jmuPcmUZzXTmFju1Xa6YS31kWZ6zULb95quJDaBES0aKKO4NBZ3Ao9B1F
         MoRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726273409; x=1726878209;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWRpDEvf1ffrH3KJKnl7mhymuRwMfVVLoo/Ecw4leuQ=;
        b=SLfdE1tMO6NuZahw8LPMAd0kOctKKnhXDF8/u/XWQHIX1MZQsRszQL/y7hqaw7BMkh
         BTQj0F4qJU7vo7RIQ4sBTn1kPs0Vb+qrMoz8SZMQo2jPQQ0vXm6edowiRcxTn+75Ln1L
         Bid1hyAWRo+SlQaWiHwbuzYuLZASx4zu234CboTroORPhvbYhUKjMDZC0elwvl67mKcD
         IcVXzaa21T+KpieurWR7UjDtLYt4c5Cj/bOuZd9ktgGVjg0q9goUFpM+qlxDS6Lwpczo
         cMuC97KYbopLGNv1hh7tpxU4PeNudRILW1TUNA/e9Bb0+2FMVXhfWwPlVmTVnc1eJX6C
         WlYg==
X-Forwarded-Encrypted: i=1; AJvYcCVOArW+QgvxpPGg5IoTdF463BPuB0d4FFaafWxgMGmS8u9hsBIqzVXou8140TErZF8k5xi/NhaeNYgWA5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdHA0+MQWMTE9eua3IFWJ9aKVPYWVlAFVThNU+onXjp+dP1qSV
	NAzsmCr3ZqxDRjQH3I8NbToprdpUaTKuhD4wYOV+qds4Z89cI87DLkOUrJXbz4M=
X-Google-Smtp-Source: AGHT+IF1OGipcMGwWA2sIIBq/L+WNET7lcZnCMksx7OWbrLoqL0oCoYV1qzB98m0pWgOBpBPVReK4Q==
X-Received: by 2002:a17:906:4a58:b0:a90:34ba:506e with SMTP id a640c23a62f3a-a9034ba512dmr259352066b.8.1726273409210;
        Fri, 13 Sep 2024 17:23:29 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:a4f:301:c80a:ca57:56fa:ebff])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612e573csm14118366b.180.2024.09.13.17.23.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2024 17:23:28 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [RESEND PATCH v2] params: Annotate struct module_param_attrs with
 __counted_by()
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <20240913234455.GA1842841@thelio-3990X>
Date: Sat, 14 Sep 2024 02:23:17 +0200
Cc: kees@kernel.org,
 gustavoars@kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 mcgrof@kernel.org,
 linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Bill Wendling <morbo@google.com>
Content-Transfer-Encoding: 7bit
Message-Id: <FF37A337-32B0-4951-B13F-2EFB1734B6DE@toblux.com>
References: <20240909162725.1805-2-thorsten.blum@toblux.com>
 <20240913164630.GA4091534@thelio-3990X>
 <60B48C52-12A6-4810-8C8C-9CC1C1E77E68@toblux.com>
 <20240913234455.GA1842841@thelio-3990X>
To: Nathan Chancellor <nathan@kernel.org>
X-Mailer: Apple Mail (2.3776.700.51)

On 14. Sep 2024, at 01:44, Nathan Chancellor <nathan@kernel.org> wrote:
> On Sat, Sep 14, 2024 at 01:32:19AM +0200, Thorsten Blum wrote:
>> Thanks for reporting this.
>> 
>> Changing
>> 
>> memset(&mk->mp->attrs[mk->mp->num - 1], 0, sizeof(mk->mp->attrs[0]));
>> 
>> to
>> 
>> memset(mk->mp->attrs + mk->mp->num - 1, 0, sizeof(mk->mp->attrs[0]));
>> 
>> fixes the false-positive warning
>> 
>> memset: detected buffer overflow: 32 byte write of buffer size 0
>> 
>> even though the pointers have the same value. Does anyone know why?
> 
> Might be a good question for Bill? The full context is available
> starting at:
> 
> https://lore.kernel.org/all/20240913164630.GA4091534@thelio-3990X/
> 
> I wonder if the krealloc() has something to do with it? I should try GCC
> but I don't have a tip of tree copy handy at the moment and I am also
> rushing at the end of my day to pack for my travels to LPC :)

I think the problem is with __builtin_dynamic_object_size().

memset(p,,) calls __struct_size(p), which calls
__builtin_dynamic_object_size(p, 0) and this behaves weirdly:

 __builtin_dynamic_object_size(&mk->mp->attrs[mk->mp->num - 1], 0);

evaluates to 0, but

 __builtin_dynamic_object_size(mk->mp->attrs + mk->mp->num - 1, 0);

evaluates to 4294967295.

Both values are wrong, but the latter doesn't trigger the
false-positive warning.

