Return-Path: <linux-kernel+bounces-543393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A20DA4D50B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865E9174A85
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4B81F9F64;
	Tue,  4 Mar 2025 07:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtec.com header.i=@qtec.com header.b="U+O6BEn/"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF9B1FAC5A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 07:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741073984; cv=none; b=YgZiPixhVC3il1hbfJEXbONYOf2Qurb6+TCVhKo51GEyHPfwcDvx85+NARjdXjjeon1hoKvYPLg1n0+VP4RzX7Nog7LKVyrrds25plVuqy9QD2XDhr/a3/X66/KPj8v3Cc4gqk8ahTTI6iX6f9Jfs2uMlQrGHubLzhZMi4JlkyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741073984; c=relaxed/simple;
	bh=CPnzM1fw74lR2iJtYGUJoxG2I//OQLR4COigFE65VMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WOcPBfOFVFl/ok19mdXIshgDJ7qkqaMI51UKSP+7Fb2haLMBXg9x3CaV/AIBFrk7Y5AODasoAd7QYIxq0IiRL+XM3zoK+PalatiBBvr+9gXPA8ItoyZB2h6GUs40cDvwlrVca66gUnAqDw0H47qaaphlrKmQB9xkXTe8c5hugpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtec.com; spf=pass smtp.mailfrom=qtec.com; dkim=pass (2048-bit key) header.d=qtec.com header.i=@qtec.com header.b=U+O6BEn/; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtec.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-86112ab1ad4so2144862241.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 23:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google; t=1741073980; x=1741678780; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CPnzM1fw74lR2iJtYGUJoxG2I//OQLR4COigFE65VMM=;
        b=U+O6BEn/WqQwLh4b5qjanKK6ULHW72iRRSe/bXTKMtwbFUpgaEZXbyqGB9AiBdo2hQ
         NIVh+/GUz0AjOFDatDluewSBLAFfB4eFna0fLVHukFxY9FVjfjQ3TKnJLNsphy6fKBD4
         MSGCGmibUBGgFC8oaSNgXOxU4EipBK4q0HiuWAn8pi2+XgSUXBzZm+i0cthcJ75X648f
         p8lmfhKSs+i+aS7R84J9QxPmtdfsUnh9pdYDkrtYWvehg0X66K+qU3Bb7yD7GKkxEsuf
         KtQEOrU1d3RL8b+abIPNF97yNkauYepRH6LJUR7syUcIFeT0hkQIsAm639lBZ9WGbRTN
         t4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741073980; x=1741678780;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPnzM1fw74lR2iJtYGUJoxG2I//OQLR4COigFE65VMM=;
        b=clnt5JDfm0pHa8h+hnl2NNFrpzScD12LOlIIybX1e2a6aSzeQvn5nFsuSh7CCKemqz
         qr4vIZp17bfWeA62/15biGvkCnTB2dUWY01oRsCU2gGsqWV2sFmbm1nfL67/PGRYiYhx
         6Wa3ck44rBymitscLrpnhWB7R6PLEC8S27XxgJWc3pQJAwp3CUv7ewdNN9yQFERT8JOt
         Cr9arMToeIkmjnotOpKrLZfj2gflt3HS0jJEcij8qf8aF/ukzful7Wt4YCUhlmlXzJ9W
         sVfONq4MfbA9qBSNaqtOSlNTM7dNVm95rtv5vWkXq9zrDyRCCV1HJlIHw4mX8Hb2fPxy
         +png==
X-Forwarded-Encrypted: i=1; AJvYcCXbQeVGr3KKUnfUWjk7rIiehzoQbT1faD4hOkHAUavml22wR0dP3AcjEL1q0qn+5pzaJA+qyp9f6kSYKxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYDgurDfMuC7Uh/t+/1Cqd2VzPy/jOhvFi9iPOWAne1lJzg6ZE
	lx+mWQru0A1uSEIfKmoqv1Fqmu+9waYE4yBl9MRgNE3zMjJXqPoxpi1fCNHmLF4CUUqNqtWr6ro
	o/iXgwsRPwePhIWF4axhmvzlz53KHez7fKt2dMg==
X-Gm-Gg: ASbGnctVcYQJqie0PE+aZQpTqzsMwMDi9czAYHJ7iiTxFWXGvfpRu9b7W71nleVBQXm
	69W4OetMZYEyP/XrUSAvIEz1/RJhFiFTL2NrangEytoMKZNFyp8Axa0ZPMTVffL1Tt67byELbM3
	WO6+XTXRoUWg4pO87w+ACg7SKn
X-Google-Smtp-Source: AGHT+IHBTquF9MMdpA9ujTlISPqC+SGfvhVpdyIpNp2XJLqCK3NGLsT+uSlBNoyMtDFz+YtnQ61PW04FxbJj1JrvxVM=
X-Received: by 2002:a05:6102:568a:b0:4ba:95f1:cc83 with SMTP id
 ada2fe7eead31-4c044ed8255mr8739901137.16.1741073980287; Mon, 03 Mar 2025
 23:39:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJDH93s25fD+iaPJ1By=HFOs_M4Hc8LawPDy3n_-VFy04X4N5w@mail.gmail.com>
 <20241219112125.GAZ2QBteug3I1Sb46q@fat_crate.local> <20241219164408.GA1454146@yaz-khff2.amd.com>
 <CAJDH93vm0buJn5vZEz9k9GRC3Kr6H7=0MSJpFtdpy_dSsUMDCQ@mail.gmail.com>
 <Z78uOaPESGXWN46M@gmail.com> <CAJDH93uE+foFfRAXVJ48-PYvEUsbpEu_-BVoG-5HsDG66yY7AQ@mail.gmail.com>
 <Z8WTON2K77Q567Kg@gmail.com> <CAJDH93vwqiiNgiUQrw0kqDkHvaUNUcrOfHJW7PGezDHSOb-5Hg@mail.gmail.com>
 <20250303184208.GB1520489@yaz-khff2.amd.com>
In-Reply-To: <20250303184208.GB1520489@yaz-khff2.amd.com>
From: Rostyslav Khudolii <ros@qtec.com>
Date: Tue, 4 Mar 2025 08:39:29 +0100
X-Gm-Features: AQ5f1JpHqszI2Fm3lvlQuFDw_o2qX63ihfzLeXdQyT7L_4E9WZBCEpsmQxne4Q8
Message-ID: <CAJDH93u+9KLBVSrFnQm3==9E4VaVohavq+FZT+UqWdRs9FHn-g@mail.gmail.com>
Subject: Re: PCI IO ECS access is no longer possible for AMD family 17h
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "tglx@linutronix.de" <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Hi Yazen,

>
> Ros,
> Is/was there a reason why you didn't have the MCFG/MMCONFIG options
> enabled in your kernel?
>
> Was this a side effect of trying to build a minimal kernel or similar?
>
> Thanks,
> Yazen
>
> P.S. Sorry for the late reply. My mailbox is missing Ros's reply to me.

I inherited a kernel config used here from a previous custom,
V1000-based solution. Most likely originally
it came from the x86_64_defconfig. Maybe MMCONFIG wasn't enabled by
default at that time.
We never had problems with this because our BIOS keeps the IO ECS
enabled (that's against the spec recommendation).
The kernel default for PCI_MMCONFIG is 'y' now, so it's unlikely that
people will run into this issue unless
they explicitly disable it.

Regards,
Rostyslav

