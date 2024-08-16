Return-Path: <linux-kernel+bounces-288798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA298953EE5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 03:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A5381F264AC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 01:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFE91E4A2;
	Fri, 16 Aug 2024 01:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGFgFba2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5968472
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 01:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723771488; cv=none; b=FqSc93yrq0E8uZI/W+KeSEmpl5iGqZUX+pzhbqLXDUtSatsvlCGjpFN33c5TUC9OrN1Vtgdm+SQfV5bw0E0D9BICdsebgVsNZK9C9pW62Kutcw01NhwyEWDRknJj82eCQ3ahO+EUc9Vf8a/YA4+/L4dU5S/w3eLSQKkjEnl6jfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723771488; c=relaxed/simple;
	bh=YH1iFlaj7TZ8p7fNpGbv6sSN1+ULedKoFhzJIl3cZbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t50GBtE6FTnFo+NH+99q/MnVkxQXp/n4DhIoeCqR7Cu/CjuRQ9g521GWvvq5bkWFlSUQQetv8AaAq3itOi2oZ0j3kxsqizaeHQ4aOl46lxstF8qK9DT8n+nSg8kNnsRahEe0boLQiSG0YDRVRFwkr0JOUB2zV1ugoiVJc0SNs14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FGFgFba2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723771485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fwaojnf9E3UluBzU+MZkkrEKEZcYZi4FcKEhRi/CrDs=;
	b=FGFgFba24N469n/BpEazqIH6HjwgqYyZyApQxoZntmErfFcZ+2w/IH9ZSEQ20XC3BoDn+3
	KVMc82TO1wF1y0MbZS+50yEyUUiOfMByGrfolWW3SOjtN9XMbnyX1B+sRn5eLwti+R6Del
	kGX25R18gOyzcVM658QWWIXGHdGcmOQ=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-hJsYEPE0P-ewfPwSjNYTOQ-1; Thu, 15 Aug 2024 21:24:43 -0400
X-MC-Unique: hJsYEPE0P-ewfPwSjNYTOQ-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-70d2ab42082so2282660b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 18:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723771483; x=1724376283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwaojnf9E3UluBzU+MZkkrEKEZcYZi4FcKEhRi/CrDs=;
        b=whWjzhfvZDgSDXG3Jh237plGSJYCIMJtcnfr4Hwi4lP1MylQie7M5ZjGkctnq5/h3w
         PekY5n9KZgk1fR8doOvOyAyS1sCkWN9Vklk7cUoGegWgZ3AO/Fnwb3PWej4LJe4SETfT
         PH8K0Jmh3UqpUe2A53oJsgxnGyq4LqpPPp+w8EMH7VJFMTG0nPsNc8oDw4KXxtx8tr74
         SpYakiLrCdzsvEsZQ+PnnHE2ly51fIWahye+Zd0ZU1TvDDkz8jlIKoLXxlXwUONCUT6Q
         xobmvNbhWnMhOKIl9MAiX3+rSPQlRlA+rLKihHJQZZxOmD6UvaeRmMqCr1xBxBMnNsig
         mphQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO5NnssoygIUtUn69K7MT6vPCCTL5TTb0zDFVRyq9xKT0fMKi9gyYQ3b2Bi71s27gyG26aShO9X99bjuRTunw4H2O3432BXQQMvhDe
X-Gm-Message-State: AOJu0YzhyWvBJx1MqOOS5OfGvHl2Gf4WJXkjORVpFKnJ6s91+Cft7+vY
	CX8P4r4TomKEZF5HBo3HQw6LuyKMD0PqvVERz7bC2WeReuyLzhufKedZkzP+8ua4YfxbcYxsDsH
	t43WGfzkmqsc8F43v8Ty4oMLA2iA6aAh0gaKfx0+cS7UNslms5opv+1FDHIrbz1EggbXAV8oTcP
	p0xTkwoMuxUhBYN393SpsXK+G9c8bxcNHOtA+u
X-Received: by 2002:a05:6a20:6d07:b0:1ca:991:5ab0 with SMTP id adf61e73a8af0-1ca09915bf6mr907570637.1.1723771482683;
        Thu, 15 Aug 2024 18:24:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2W7if9lwjRG2kNQheYzxy8p06RPF3Sab4WD0l36KTQ1ZsM5FA1pamFcIyhy7TLUbIgdVTJyTESC9lRMpJDaQ=
X-Received: by 2002:a05:6a20:6d07:b0:1ca:991:5ab0 with SMTP id
 adf61e73a8af0-1ca09915bf6mr907554637.1.1723771482281; Thu, 15 Aug 2024
 18:24:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809191020.1142142-1-pasha.tatashin@soleen.com>
 <20240809191020.1142142-4-pasha.tatashin@soleen.com> <d28059a0-25af-6d0c-3f6d-7e7bc208a0da@google.com>
In-Reply-To: <d28059a0-25af-6d0c-3f6d-7e7bc208a0da@google.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 16 Aug 2024 09:24:30 +0800
Message-ID: <CAHj4cs_-Qh2O9dUrcdVSPSZas-YYcfMYSpAWbm8C3Z=G3FZWsQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] mm: don't account memmap per-node
To: David Rientjes <rientjes@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-cxl@vger.kernel.org, 
	cerasuolodomenico@gmail.com, hannes@cmpxchg.org, j.granados@samsung.com, 
	lizhijian@fujitsu.com, muchun.song@linux.dev, nphamcs@gmail.com, 
	rppt@kernel.org, souravpanda@google.com, vbabka@suse.cz, willy@infradead.org, 
	dan.j.williams@intel.com, alison.schofield@intel.com, david@redhat.com, 
	yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the fix.
Tested-by: Yi Zhang <yi.zhang@redhat.com>

On Mon, Aug 12, 2024 at 4:26=E2=80=AFAM David Rientjes <rientjes@google.com=
> wrote:
>
> On Fri, 9 Aug 2024, Pasha Tatashin wrote:
>
> > Fix invalid access to pgdat during hot-remove operation:
> > ndctl users reported a GPF when trying to destroy a namespace:
> > $ ndctl destroy-namespace all -r all -f
> >  Segmentation fault
> >  dmesg:
> >  Oops: general protection fault, probably for
> >  non-canonical address 0xdffffc0000005650: 0000 [#1] PREEMPT SMP KASAN
> >  PTI
> >  KASAN: probably user-memory-access in range
> >  [0x000000000002b280-0x000000000002b287]
> >  CPU: 26 UID: 0 PID: 1868 Comm: ndctl Not tainted 6.11.0-rc1 #1
> >  Hardware name: Dell Inc. PowerEdge R640/08HT8T, BIOS
> >  2.20.1 09/13/2023
> >  RIP: 0010:mod_node_page_state+0x2a/0x110
> >
> > cxl-test users report a GPF when trying to unload the test module:
> > $ modrpobe -r cxl-test
> >  dmesg
> >  BUG: unable to handle page fault for address: 0000000000004200
> >  #PF: supervisor read access in kernel mode
> >  #PF: error_code(0x0000) - not-present page
> >  PGD 0 P4D 0
> >  Oops: Oops: 0000 [#1] PREEMPT SMP PTI
> >  CPU: 0 UID: 0 PID: 1076 Comm: modprobe Tainted: G O N 6.11.0-rc1 #197
> >  Tainted: [O]=3DOOT_MODULE, [N]=3DTEST
> >  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/1=
5
> >  RIP: 0010:mod_node_page_state+0x6/0x90
> >
> > Currently, when memory is hot-plugged or hot-removed the accounting is
> > done based on the assumption that memmap is allocated from the same nod=
e
> > as the hot-plugged/hot-removed memory, which is not always the case.
> >
> > In addition, there are challenges with keeping the node id of the memor=
y
> > that is being remove to the time when memmap accounting is actually
> > performed: since this is done after remove_pfn_range_from_zone(), and
> > also after remove_memory_block_devices(). Meaning that we cannot use
> > pgdat nor walking though memblocks to get the nid.
> >
> > Given all of that, account the memmap overhead system wide instead.
> >
> > For this we are going to be using global atomic counters, but given tha=
t
> > memmap size is rarely modified, and normally is only modified either
> > during early boot when there is only one CPU, or under a hotplug global
> > mutex lock, therefore there is no need for per-cpu optimizations.
> >
> > Also, while we are here rename nr_memmap to nr_memmap_pages, and
> > nr_memmap_boot to nr_memmap_boot_pages to be self explanatory that the
> > units are in page count.
> >
> > Reported-by: Yi Zhang <yi.zhang@redhat.com>
> > Closes: https://lore.kernel.org/linux-cxl/CAHj4cs9Ax1=3DCoJkgBGP_+sNu6-=
6=3D6v=3D_L-ZBZY0bVLD3wUWZQg@mail.gmail.com
> > Reported-by: Alison Schofield <alison.schofield@intel.com>
> > Closes: https://lore.kernel.org/linux-mm/Zq0tPd2h6alFz8XF@aschofie-mobl=
2/#t
> >
> > Fixes: 15995a352474 ("mm: report per-page metadata information")
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Tested-by: Dan Williams <dan.j.williams@intel.com>
> > Tested-by: Alison Schofield <alison.schofield@intel.com>
> > Acked-by: David Hildenbrand <david@redhat.com>
>
> Acked-by: David Rientjes <rientjes@google.com>
>


--=20
Best Regards,
  Yi Zhang


