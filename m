Return-Path: <linux-kernel+bounces-560229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F639A5FFE9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863CA421B52
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEA21F0E44;
	Thu, 13 Mar 2025 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PhVICmjH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CEF1EFFAE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 18:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741891638; cv=none; b=XRPwjoxehwdfPd68XF2y8LbNwkJM5x32A+4170KAEkx6mt5cZUPubI0ywkEI5Jx7HvYotRNaIfvaFSARVpIWw4zzJZusM4j27il5N7GIid3hmC+4hayZOiJFX/3qDKSaSFndK0N+dIpPeB6oiD+9A5gF8DZVKARR18D+imcVi4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741891638; c=relaxed/simple;
	bh=1Wj0bufZ7EjYi7U/RFgZ/s0fjo6rJSEGTvGZw1CTU4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r140GXX20ehOU4tjMhtRK9wUeDgfyrDDd5rM4iNnlTjK31Y/5UAwqASv/Vfgn/X/bn7kEpvI0hBi7iUoWkdpvS4NTwduS5T+DQxYBtTzmTx20yYGm/MVNrDRbGei9l1GyWzVXiB4cZczJBaFKVddcRPpbpdpw1YxNkdqxo8lOZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PhVICmjH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741891635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1GojteExoK1LwIk/yNQWtkCvbvibA9jZBZEt4xD5tPU=;
	b=PhVICmjHiAkzwUUZdyoL4osWwKgGaaM7zdk9P/YL2vpeRn968IH5uCqAgL1omOKL45FhDR
	+m3xVx+6k+obwDjZfpkW9Wx+bEUuujV22U3tA7c8MaV/EfBBXAu9IBqsI9PTrr7v9SugSr
	P1I2cPT3l16UWaPUfBr8mgPhsd6EZSM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-GysSEMq8NdmGV4r1WkAtoA-1; Thu, 13 Mar 2025 14:47:14 -0400
X-MC-Unique: GysSEMq8NdmGV4r1WkAtoA-1
X-Mimecast-MFC-AGG-ID: GysSEMq8NdmGV4r1WkAtoA_1741891633
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac28a2c7c48so134220666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741891633; x=1742496433;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1GojteExoK1LwIk/yNQWtkCvbvibA9jZBZEt4xD5tPU=;
        b=uOKe3Ln/kGOzp6A/DKBTH+ESw4rhd6rKUZahtfsuNX2X/0WFO3SZUQVX306TwiOiTr
         J+Lr8S1uUcgrGHXJm81RvcR0V8zcpap3b0CE1q9LTLMP8TmJ7zNxfm8t0oSOAdXMCDqZ
         Gll9RCpACcrggHlxjgo9x3n0xfh9vc7haYooXn3b9S6dHnAkMEyk9nKVd6LXCyrzC/IA
         k2UMrVEzB9/HvtXpbEXmimGcYgJrWrd/F0cSMyRGCpKze+NMXrPXUrSkw4kfbqdwb480
         umkxQOnzKQ2eYgv74XbDW500e3DuZt6hOPWq1QPvw1SfNnfQPvF0vmzcHZhThEmi6aFy
         6eqA==
X-Forwarded-Encrypted: i=1; AJvYcCUnoMnICNHu/myBYQSRioCRH+nnkb1aJx+yLTqsgMFt4d73IdPXIEMti1k/pC3x15Sc1t+Q8vz9DlQtFhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvhb6sVYZ/YlzDLCJlVbKSRvP5dMLAjRedGDV34HHH1dejLiHs
	NrwERKRbJgi2/tarIUn03NOkv45ZvjSDfFiTMrNJ2VHS4JKdBNV6nwn6DlqoVWUBrno2v0/9fgn
	c1ivIKjCMKBPLqVAQvkSJn8zxj/ApElNPsFCWB98rKa/gXc19kV9PspApbD4K6A==
X-Gm-Gg: ASbGncvjAjXRf/J4/9lYVjKGzlwxcE/1PSmTLWrPUw56M/Lt7eVi3wijrFknIw4sl5L
	OjOXKmPOuBT+jpHdafvLb85fOdoKHpSkw9j8cD/GS/ETXeqj//Tj6wUXPiWYcG1QQyrKTcrv6gR
	3ZpCLbQd/jHWjMlfrScSRT6XjYXu7plVkoS+loKLXrx5YQSJOhBtItg0DxalFC3AOtzS2hMVdee
	n7bsMr4SYDXGyFk2hiwKiqusZ8EdzTtnfh+sT4NKdVpq6mgyCNAS0zNF+4qfKJgpeU+Nc8IqCjv
	BpS7mbI746/yziw6FVAb4NO6Mk1aRjLpzqciiGqkTQa1nNn+lQoOz5ei+sLlv/e4Otwc3R/Xnjp
	TLqaY1F+HWVjosocwbh0xhgJFEV0Ee3fEOrriu1InYHOBEJZJPlY+u06Nsp+RB3x0WA==
X-Received: by 2002:a17:906:f59d:b0:ac2:8428:c5c2 with SMTP id a640c23a62f3a-ac328fbd7a2mr59817966b.20.1741891633358;
        Thu, 13 Mar 2025 11:47:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF200838Q9PH//rlXMgJcC7gCBuHjGntLC+HFTNJDzLV0/czimB9kN73ACIsQRgz1KoSS/F/Q==
X-Received: by 2002:a17:906:f59d:b0:ac2:8428:c5c2 with SMTP id a640c23a62f3a-ac328fbd7a2mr59815866b.20.1741891633001;
        Thu, 13 Mar 2025 11:47:13 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a48b51sm112898266b.149.2025.03.13.11.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 11:47:12 -0700 (PDT)
Message-ID: <6d125c69-35b2-45b5-9790-33f3ea06f171@redhat.com>
Date: Thu, 13 Mar 2025 19:47:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression from 7627a0edef54 ("ata: ahci: Drop low power policy
 board type") on reboot (but not cold boot)
To: Niklas Cassel <cassel@kernel.org>
Cc: Eric <eric.4.debian@grabatoulnz.fr>,
 Salvatore Bonaccorso <carnil@debian.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Christoph Hellwig <hch@infradead.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Damien Le Moal <dlemoal@kernel.org>, Jian-Hong Pan <jhp@endlessos.org>,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-ide@vger.kernel.org,
 Dieter Mummenschanz <dmummenschanz@web.de>
References: <Z8l7paeRL9szo0C0@ryzen>
 <689f8224-f118-47f0-8ae0-a7377c6ff386@grabatoulnz.fr>
 <Z8rCF39n5GjTwfjP@ryzen> <9c4a635a-ce9f-4ed9-9605-002947490c61@redhat.com>
 <Z88rtGH39C-S8phk@ryzen> <383d5740-7740-4051-b39a-b8c74b035ec2@redhat.com>
 <Z9BFSM059Wj2cYX5@ryzen> <9ac6e1ab-f2af-4bff-9d50-24df68ca1bb9@redhat.com>
 <Z9LUH2IkwoMElSDg@ryzen> <d5470665-4fee-432a-9cb7-fff9813b3e97@redhat.com>
 <Z9L5p6hTp6MATJ80@ryzen>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Z9L5p6hTp6MATJ80@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 13-Mar-25 4:28 PM, Niklas Cassel wrote:
> Hello Hans,
> 
> On Thu, Mar 13, 2025 at 04:13:24PM +0100, Hans de Goede wrote:
>>>
>>> Considering that DIPM seems to work fine on the Maxtor drive, I guess your
>>> initial suggestion of a Samsung only quirk which only disables LPM on ATI
>>> is the best way?
>>
>> I have no objections against going that route, except that I guess this
>> should then be something like ATA_QUIRK_NO_DIPM_ON_ATI to not loose the
>> other LPM modes / savings? AFAIK/IIRC there still is quite some powersaving
>> to be had without DIPM.
> 
> I was thinking like your original suggestion, i.e. setting:
> ATA_QUIRK_NO_LPM_ON_ATI
> 
> for all the Samsung devices that currently have:
> ATA_QUIRK_NO_NCQ_ON_ATI
> 
> Considering that this Samsung device only supports DIPM
> (and not HIPM), I'm guessing the same is true for the other
> Samsung devices as well.

Ah I see ...

> So we might as well just do:
> ATA_QUIRK_NO_LPM_ON_ATI

Yes I agree and that will nicely work as a combination of
ATA_QUIRK_NO_LPM + ATA_QUIRK_NO_NCQ_ON_ATI functionality
so using tested code-paths in a slightly new way.

Regards,

Hans




> to disable both HIPM and DIPM
> (since only DIPM would have been enabled without this quirk anyway).
> 
> 
>> Yes the most severe problems do seem to come from that specific mix,
>> although the long list of other ATI controller quirks also shows those
>> controllers are somewhat finicky.
> 
> Definitely!
> 
> 
> Kind regards,
> Niklas
> 


