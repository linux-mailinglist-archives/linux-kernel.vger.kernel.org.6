Return-Path: <linux-kernel+bounces-365591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1090299E4B6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8343FB23008
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150DD1EBFF1;
	Tue, 15 Oct 2024 10:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="FN/6EoI3"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D348C1E9082
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989735; cv=none; b=HG50N+Mg3QSHk7Fui3lxHOetqIzIR0dXYHIvxJF7ltUdB/VchnhylYSslqep/X8+0vIhuVURYxGC7Irhy6v6MEQARh2/n8Yd64Btv5PEpmB9yuXlJ29yYn0NeTgQGL6PGEGyE8JdJ+PIKcukBICRazbKbor6NJag5pRYRNYPnL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989735; c=relaxed/simple;
	bh=dJZxNsHufyVnVkGZ7KBRcyWcePNegdl1XvkyiSwKVwI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=g3lwYdko3IJAoz2/qYjHxTYMd1VGDqdpZP199kkZUBHRHj8g2gig82vO5wEq2czVsM++q3cDPGRhbh75VCWVh7sY6duGZDWMp/CBPvZtlptthikg+fEhgc1hL/ZEJhSIINkTq/iRWuW41BRT9JDEO5SMryjDzc6Ijpn73w0ipCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=FN/6EoI3; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a99cc265e0aso545596766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 03:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1728989732; x=1729594532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qxWaIsUg6giBeZB/qFZgxvxYS8Q3WXg/pwadc9vI6U4=;
        b=FN/6EoI3dCHV7bU1thwTZfY1F7axilseOO6PvuCCFqIViQo7ynHcdA50Q1Veb2YF3e
         2SfW1VxpqGhfEvmUOwxhKlGDZJ/VoHa/hYEHIRvf0hQahpE6EsPY7V6alhxZSByTeucZ
         zuKfbO16bFoc1oIDbkjKRrr+/gFvCGruvI3vWfvDdch9ixAMrY37lozB7gzMzEhpQntI
         NP/0/vgQij5f0nbe6QfbHDa3+kmCnuOg8alnfmuBRKxd0Nkfnh0TWfzUb2xvmPjW9W1+
         4bjUyQsGQzkCUHOrbs3N40LPyGy681QIpXlYG+epZgluLeja4Hbk6yEH5Q1UaZEfBi22
         aXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728989732; x=1729594532;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qxWaIsUg6giBeZB/qFZgxvxYS8Q3WXg/pwadc9vI6U4=;
        b=mauP4voWGcsepiffRDfNHrA0oTKhyHZviCFDDfhQAQBWs0aILNdSGlJYZcKJuNeXSL
         E87EESrk7bfTkTXYT1Px9YLCqmwHisfbmXg3L1Ul0z012Qf05ik7SBQYru9vpleR6abV
         rdI971OHLl2FazFyWiiqoEQ4AYOnXGdFTGn2x/JuVCUT/zzOAq2VSHnVv2WF22xmyeRW
         yruQ0xHJl+EhqwmJ4iDvl6GAxpqoUb2jGhuykocccD32lYFHyj/ORkdhHWAAQ7Dwbrer
         PVsuRsnadVfDuvT1t68I6KuYg2jyLJe7tzT/5DM/868Dsm0BEn9VusnDk8GkexHtmSe2
         aHPA==
X-Forwarded-Encrypted: i=1; AJvYcCWLD8EcK596TY8bp4OeyxP83QM6zKVNqIIHo3Fytqt8ogHIJGgWRwIx+eLh6FRRpL2536TycB5l35RqCAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVtIWr1HA3n/6R2VqJsV1AVsHyfkbrinKWn0x5SDK0Ex3Iqycw
	XK3XOv0Y/LN6oFeNAgiPvBgQF9ZgiEjlvYp6RzHGM0jFed3ICYhYNRdUpcBFchk=
X-Google-Smtp-Source: AGHT+IENngL8kUtvdGqBvfWOeT0HU3Jz0wnco8VTc5j19kviovROQUzgBtOacG8vxlSE5QNA5vJkkA==
X-Received: by 2002:a17:906:f59b:b0:a99:f7df:b20a with SMTP id a640c23a62f3a-a99f7dfb8ecmr782739366b.62.1728989731976;
        Tue, 15 Oct 2024 03:55:31 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a298232f4sm56459066b.117.2024.10.15.03.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 03:55:31 -0700 (PDT)
Message-ID: <7d4c49da-e071-4b74-85d8-f0b5efaa0cf3@blackwall.org>
Date: Tue, 15 Oct 2024 13:55:30 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bpf: xdp: fallback to SKB mode if DRV flag is absent.
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrii Nakryiko <andriin@fb.com>,
 Jussi Maki <joamaki@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Liang Li <liali@redhat.com>
References: <20241015033632.12120-1-liuhangbin@gmail.com>
 <8ef07e79-4812-4e02-a5d1-03a05726dd07@iogearbox.net>
 <2cdcad89-2677-4526-8ab5-3624d0300b7f@blackwall.org>
 <Zw5GNHSjgut12LEV@fedora>
 <8088f2a7-3ab1-4a1e-996d-c15703da13cc@blackwall.org>
Content-Language: en-US
In-Reply-To: <8088f2a7-3ab1-4a1e-996d-c15703da13cc@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/10/2024 13:46, Nikolay Aleksandrov wrote:
> On 15/10/2024 13:38, Hangbin Liu wrote:
>> On Tue, Oct 15, 2024 at 12:53:08PM +0300, Nikolay Aleksandrov wrote:
>>> On 15/10/2024 11:17, Daniel Borkmann wrote:
>>>> On 10/15/24 5:36 AM, Hangbin Liu wrote:
>>>>> After commit c8a36f1945b2 ("bpf: xdp: Fix XDP mode when no mode flags
>>>>> specified"), the mode is automatically set to XDP_MODE_DRV if the driver
>>>>> implements the .ndo_bpf function. However, for drivers like bonding, which
>>>>> only support native XDP for specific modes, this may result in an
>>>>> "unsupported" response.
>>>>>
>>>>> In such cases, let's fall back to SKB mode if the user did not explicitly
>>>>> request DRV mode.
>>>>>
>>>
>>> So behaviour changed once, now it's changing again.. 
>>
>> This should not be a behaviour change, it just follow the fallback rules.
>>
> 
> hm, what fallback rules? I see dev_xdp_attach() exits on many errors
> with proper codes and extack messages, am I missing something, where's the
> fallback?
> 

Oh did you mean dev_xdp_mode()'s ndo_bpf check to decide which mode to use ?

So you'd like to do that for the unsupported bond modes as well, then I'd go
with Daniel's suggestion in that case and keep it in the bonding until
something else needs it.



