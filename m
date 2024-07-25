Return-Path: <linux-kernel+bounces-261913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFC693BDB8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A42284001
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F2B172BD9;
	Thu, 25 Jul 2024 08:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Ys/vVCfX"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEE6249ED
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721895046; cv=none; b=DzyPJpichqHOAJIW2HfwLAICubqmfDpcd4DXDFcKcCu1JKomW16ugZdZVvLsl/ZjFBxeFagrdmy8+Qt5XDPvPepg8QpqrlvvipnwxiHFq4XTJY1v1H1zZVFR5o/Hp+dCY6RQYPX9Bmors00JBYT0Lx0NnmrkBey/3GuFSRmmsLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721895046; c=relaxed/simple;
	bh=avaHHLqrruRJHnJ3sejke+cxPsyQxs2OILDIe6zMrpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8cNojoxlvarOanrylkex6UjT7Aebxiv/UX8rTO0okLo8cnrn/wIo4NSvudvyfl2LBL0b0JJyuHNWNqVTqP4/HHRyy/hVBLYMts/iV4aJ6KUHF5swEGT3aYqmntJ8i+85NHyKcbLCNrL0Imf+ZjyEQT3ZIw3EpFSI3su6MXaCsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=Ys/vVCfX; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a1d7bc07b7so21514985a.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 01:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1721895044; x=1722499844; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BRzauhp029bfNwoz4LI5DK7BUaVkg/wkvBoPwQYFbbI=;
        b=Ys/vVCfXAm5quuPXLeiKL+vFL5kqEC0jsakmZMt7yNtXjVEAxK3L75r1x8j6U58+Dn
         IqYqYx3ulZWUFNSJ0F1gyDHeRIts9CoynGcBBcFqLIIJ02qPQe3mforfcw1fPXQvlyhC
         695HkEqob6bZixarKyVlXtshRO0+kYc5PzGNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721895044; x=1722499844;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRzauhp029bfNwoz4LI5DK7BUaVkg/wkvBoPwQYFbbI=;
        b=O3NqRPAXCHi1wo06Edbb3hYhbPbWHtaLkpDP6QzSzl5r6kSAWu43rFVBqY1MfGPh30
         eEDf++diiBbPXWbxH8IiUG5ghEf7Ua0ISAPSa009WHIKcvcW8lj6He3axsaeKrj/bk1y
         72dJBIb3PzlhfBmMwB6oBNA8BHdJUoyd9ybAyw+IxOH7Ho/AKKCGTNgVqAzeTwRG42x5
         pHldozm8yQGoBzV3HE+gy9kuZExrUlIqHEvteA1v7fXpGQ+2z2KY7MfnUwqUt30LlHBb
         v/SSpDTTUF7nAYtItgCIppHSC8CpDqrarWA6h7xoZTrxOswPeXAoKFDjzMKTnF6HGMIb
         OLug==
X-Forwarded-Encrypted: i=1; AJvYcCU8SyztGWVN3io4hn64luH8NFJU6qiaLndNHRtnbu3GQ1lMXZCpN2ffQlBt+F9FxFHoTY2A8vt/DdWH/ojMnBqbmPFXE603KVmy6mP1
X-Gm-Message-State: AOJu0YxfjNxiZ1QhP5x3+Ja9uKdmlNgvSqKQf/pMJSOtDKTU8O4hIwgS
	mR26HI59YBwB7ea/bjOMVrHnJmpfn11LA3PDkavvyFqtvxlp40taFlVnFOFxbCU=
X-Google-Smtp-Source: AGHT+IHMP8aNo2avdNrP4jZnmdyG2J4CN5eFB1+b/ecGVBYY0OwBduL2Js6UAhl6Pr/QYhscQPKKzw==
X-Received: by 2002:a05:620a:468f:b0:79e:ffdb:e32d with SMTP id af79cd13be357-7a1d7ef936amr119261485a.51.1721895044134;
        Thu, 25 Jul 2024 01:10:44 -0700 (PDT)
Received: from localhost ([213.195.124.163])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73b5b7bsm54038185a.46.2024.07.25.01.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 01:10:43 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:10:41 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/2] x86/xen: fix memblock_reserve() usage on PVH
Message-ID: <ZqIIgc9xj6wmDJtE@macbook>
References: <20240725073116.14626-1-roger.pau@citrix.com>
 <20240725073116.14626-3-roger.pau@citrix.com>
 <a249e651-a2a1-4ea9-b262-0d04a8abaf0e@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a249e651-a2a1-4ea9-b262-0d04a8abaf0e@suse.com>

On Thu, Jul 25, 2024 at 10:01:17AM +0200, Jürgen Groß wrote:
> On 25.07.24 09:31, Roger Pau Monne wrote:
> > The current usage of memblock_reserve() in init_pvh_bootparams() is done before
> > the .bss is zeroed, and that used to be fine when
> > memblock_reserved_init_regions implicitly ended up in the .meminit.data
> > section.  However after commit 73db3abdca58c memblock_reserved_init_regions
> > ends up in the .bss section, thus breaking it's usage before the .bss is
> > cleared.
> > 
> > Move and rename the call to xen_reserve_extra_memory() so it's done in the
> > x86_init.oem.arch_setup hook, which gets executed after the .bss has been
> > zeroed, but before calling e820__memory_setup().
> > 
> > Fixes: 38620fc4e893 ('x86/xen: attempt to inflate the memory balloon on PVH')
> > Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> > ---
> > While the commit that introduced the user-noticeable regression is
> > 73db3abdca58c, I think 38620fc4e893 should have been more careful to not
> > initialize the memblock ranges ahead of the .bss zeroing.
> 
> Reviewed-by: Juergen Gross <jgross@suse.com>
> 
> I'd prefer using 73db3abdca58c for the fixes tag. Otherwise you'd need to
> add this patch to the stable branches, too, which is technically not really
> needed.
> 
> Additionally I'd like to drop the Fixes: tag from the prereq patch, as this
> one doesn't really fix anything.
> 
> I can do both while committing.

I was unsure myself (as noted in the post-commit notes) about which
"Fixes:" tag to use.

Is there anyway that it can be noted that this commit depends on the
previous change also being present?  For backport reasons, if anyone
ends up backporting 73db3abdca58c it would also need to pick the two
patches here.

Thanks, Roger.

