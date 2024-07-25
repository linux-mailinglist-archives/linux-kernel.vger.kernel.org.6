Return-Path: <linux-kernel+bounces-261897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DAB93BD8E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A13211F2145A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423C5171661;
	Thu, 25 Jul 2024 08:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L9e3my2b"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8495249ED
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721894569; cv=none; b=gfZ1T+37vCN3QG3CEdTZHKqjubxrzFT/eJ+Y38bgfPufVH1vw3ag+qVfbBqQF+mChNUVO/+6MVBmhyNHrZAPREmQZAGKSo1R3zBwambDPWLfE8cfjwJaIw+RHTZunV0sojUTWDhfENdr4gg37Zzzn3PbwS/i6fKvr9s2X9Dc9EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721894569; c=relaxed/simple;
	bh=FXcbSU+NO5jzjvmG5c78eyWsBVW8+q+UKaAuNzAvKGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WQIx5ik3olIwN1tgnM6brezchjpajGvus5ZH1jz4RILRwAbHtoMLwX3vWZNllrlBggEiczwOLgcsJ/MV1jWBNyF64z2e1KRhrdPsQNZbWW2mCD3IixF5qwWIPYDJC8X+6cIpET0umXB7sCGoBaAf6QdQm1xCZaHB7hvu0OARU8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L9e3my2b; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7aa212c1c9so29707966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 01:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721894566; x=1722499366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AP47ysTrD1B/0czQGo5UjPtQ30JzUCGh6ScFen3bgnQ=;
        b=L9e3my2bSTSWvs5McjwIoAjvGGk5s1Fmo9Cu+XaEZ6giZdH0Qh5WF5COjuV3a1Unqb
         oFK44qKZUBRZgGr7DfsxfpkaPejKQYrQrO918qrjxJDtDs3K7llXFiRP0zrbODEJ6GtL
         hh0UYbBKSn1RP4S8It5r+yvqb73o8BEjX7fh4LOLXrDLi0hHL0sZEziHPL9orSD4l/et
         UpHbUzstYL5BtrqJ7KnY3h6crAqXH5nS8rEsZd2OBDZ1ncL6a4nJA/SYnNkW0yJ9VoKt
         ZYHWrAqpICgXjCRXfG/9RK2gA3Dz/4B0GipqUvle1ct3N2BTiQO73016YmKmjMUmcnAg
         u3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721894566; x=1722499366;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AP47ysTrD1B/0czQGo5UjPtQ30JzUCGh6ScFen3bgnQ=;
        b=g1k0ObimmOOqKzfB6PUxDNsH+CAlXZBetvOigCvAxXbHPJ49pPeL15XVGIsU20ByUl
         E99IIrUaOdGHi97LD5K+wYiwZBOaaOATfFrQPd+Qo7hfu/KLm0pexqymc6I4JVJRwJer
         tE+n6QMgZPy2gEthiDyjrkRTTTkV3laH5TlFOVv3Lm3nzWNq39r7i4VmuymTUl2hRNRq
         ubXdHIEWUNf/X9CE2bxYa5iudC0kBxJpIInoHLTBS40mEustQlyXVcPL6WoB5plhKoNA
         nDW69Nvd/jduCBR1fgAdDQ+XyHbOLq8q3J/BUSCI2oK8MzS8OhPtjiUCktKf32wOkG/a
         iK8w==
X-Forwarded-Encrypted: i=1; AJvYcCUhTCcOGWDO+YvduwX6gnjekLG20LL2beZ2BNv8WPh2MiVKd+jjVNpOIIWqtMgMpto9SOSRh/FVdpXApY/mSrVBT5T3sIFQqy3a1GZ8
X-Gm-Message-State: AOJu0YxaX+Q4MWCXISaMTGvYYOYF3v/0wowTBIPuO2ny8IDWWG33+2NI
	ulx288w2oWzypDjaKIyD5/FA6+cSDJ19swXiM4uk3+S/L02uEOD0LRRCpVyliQw=
X-Google-Smtp-Source: AGHT+IEVJJ3nESMvDj3qZN35DsT4AR4wlpLYi6EzQNKrYOMLzABEAXbto0MdLywaTjjGWg0Y6EzVuw==
X-Received: by 2002:a17:907:9694:b0:a7a:b385:37c8 with SMTP id a640c23a62f3a-a7ac4d9f44amr153068366b.5.1721894566083;
        Thu, 25 Jul 2024 01:02:46 -0700 (PDT)
Received: from ?IPV6:2003:e5:8729:4000:29eb:6d9d:3214:39d2? (p200300e58729400029eb6d9d321439d2.dip0.t-ipconnect.de. [2003:e5:8729:4000:29eb:6d9d:3214:39d2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb021asm44214166b.188.2024.07.25.01.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 01:02:45 -0700 (PDT)
Message-ID: <a2edee01-b895-4d0f-b435-9a92bcc5c411@suse.com>
Date: Thu, 25 Jul 2024 10:02:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/xen: move xen_reserve_extra_memory()
To: Roger Pau Monne <roger.pau@citrix.com>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20240725073116.14626-1-roger.pau@citrix.com>
 <20240725073116.14626-2-roger.pau@citrix.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <20240725073116.14626-2-roger.pau@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25.07.24 09:31, Roger Pau Monne wrote:
> In preparation for making the function static.
> 
> No functional change.
> 
> Fixes: 38620fc4e893 ('x86/xen: attempt to inflate the memory balloon on PVH')
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>

Without the Fixes: tag (can be dropped while committing):

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen


