Return-Path: <linux-kernel+bounces-521531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7A9A3BE90
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BE951885B71
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B2C1E1A16;
	Wed, 19 Feb 2025 12:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5r+TtEz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745A71E0DE3
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969339; cv=none; b=LdSYOVi91FJQHbyrx+U8lkqgHQhtCyETMmIxsmhgseXfVRPPw4W9td2pbc73woWzCZhMd32amhwgkvt20Jsvr0QzI/N1DaPNBVJaM7m3AvVSicGHWGgwEkQRn6TWx2mvZVkgyku5zc16aj1S+8/K6LWH/wkZPd5WJrGaaH8Q6x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969339; c=relaxed/simple;
	bh=Thdr1wpqf/QLeTUfSv5bdo7ibZ59exxf85YF/5cIyXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=np5JKk7tAeaI9JyXGA2PjhkSXsHdewkkn3dD3BiWg4dYGl0iJ4E7H0lFtkNK97GI3jUBSBH/Ij2wl8uiBpkphhHwC9thlS7ifISFviiPErjuDduh7imD4yoJ6XOGNbAHQ5p78Ep4lLvEpn10sdMwCo/sSOH+33tINyv+ntXENNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O5r+TtEz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739969336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SMHHlCMcxXYtVaRR1wTwHJJB8CwWA0AX/SUXLDYSpC4=;
	b=O5r+TtEzw9Va9IxM6FlfDZNywSr8IH/B5cy7R/xdW2gEwxudNGM64EJKCHrYBQK7g72w8M
	zrwMuYxA8cfVdZthLEvWAxboxy+ByRmbwOeMReJsKVWAJmWYlTdhARmzjBHJZoEuorP4U8
	4+/zrptkJRtIS9x9mcoJSsH+GEjl+1g=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-8omsqED7MQ-gSpWyQtqmTg-1; Wed, 19 Feb 2025 07:48:55 -0500
X-MC-Unique: 8omsqED7MQ-gSpWyQtqmTg-1
X-Mimecast-MFC-AGG-ID: 8omsqED7MQ-gSpWyQtqmTg_1739969334
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ce843b51c3so126977565ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 04:48:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969334; x=1740574134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SMHHlCMcxXYtVaRR1wTwHJJB8CwWA0AX/SUXLDYSpC4=;
        b=QC0tliyGKZ7oDYfG3YRKisUKHlMQXxO9+656obZ7TnsTKPyqJmybbrtZngJqIlrEkV
         RBx+BHhGizu3ZWJ4bwB3ZEQLy1cXZjfn6nBE/fqEjY+xQ8hQK3ImKyqGAYCvFwfpdNNi
         E6sCbjy+/JU2ixRf//T9Y4HAP0Ao+0saZg1qwN4uBnhDkWUqDhWdVunRklq3u0UPLevK
         IgqH4HgxBfymY0vgr46S4XVvyOhKgn7MG73T4C7p2HPlKMyt82SxR9J6mknOTol1XlLJ
         isvDzccRMNTeNP2qfnV1wxf1IKsXAfHFURP14aNepWIJTZu2pXUfNs4fZskED6LIt1S0
         YdDg==
X-Gm-Message-State: AOJu0Yy4ub4OplClv+z4K0mHFTAD/OSGQOIEOxOt9YviNEym+0VTZIHx
	naqa0KAWrZ1/gaPpp4nNB0lTA7qLN/JNv29tSGxiZN2TFPp0LKIRyA+j7fjgqax47cp/ljuiNHT
	eVRDWYIA+6VKSVdOkLOZmm3Zm7CkFF1my1CCH+MH//0xL992FNr9o2mTq2K+vgV5+Kdk91E+n7N
	0dhTMPZ69xxyIxUBBxM84WqFb0Ct3E4mEf9wD5
X-Gm-Gg: ASbGncudbAXDTMTuUTJ7iq0U7U/sUH/95dscQd1S8AmFVtXvUSAAGdWXrWeajbynElD
	22BKGEARoLnKUp6JqqpQ9sly7vfJrbopBbYvxtwsmiwIvnhCG2tPBI9Izeb4cGEE=
X-Received: by 2002:a05:6e02:184d:b0:3cf:bb3e:884c with SMTP id e9e14a558f8ab-3d280940c90mr162914175ab.16.1739969334542;
        Wed, 19 Feb 2025 04:48:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQzXwQKpyH3rywpGs7BzP6mbj6/B897FEVbfIit3jAtaZt2ga8Vr+6/m/vSCYkDIbGIHSmC6KPV/ULHybcxNs=
X-Received: by 2002:a05:6e02:184d:b0:3cf:bb3e:884c with SMTP id
 e9e14a558f8ab-3d280940c90mr162913745ab.16.1739969334259; Wed, 19 Feb 2025
 04:48:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206132754.2596694-1-rppt@kernel.org> <CALu+AoRMQyRDFS_4L0KQkmrFT_S+yk=uZ-Mqt86JQYKKnj-5Ug@mail.gmail.com>
 <Z7WJD6eBLuIRnLwk@kernel.org>
In-Reply-To: <Z7WJD6eBLuIRnLwk@kernel.org>
From: Dave Young <dyoung@redhat.com>
Date: Wed, 19 Feb 2025 20:49:07 +0800
X-Gm-Features: AWEUYZlzn2-E8ZdtRbfhtM_eLch7RFvZ-yzSIrzOWYzAtm2oUJ9ngWc6Obau8Nc
Message-ID: <CALu+AoSaEthfed1NOYPiQgm_g-dhibVMRAp0+=_+9qTT4_x=tg@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Anthony Yznaga <anthony.yznaga@oracle.com>, Arnd Bergmann <arnd@arndb.de>, 
	Ashish Kalra <ashish.kalra@amd.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
	Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, 
	Eric Biederman <ebiederm@xmission.com>, Ingo Molnar <mingo@redhat.com>, 
	James Gowans <jgowans@amazon.com>, Jonathan Corbet <corbet@lwn.net>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Pratyush Yadav <ptyadav@amazon.de>, 
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, 
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Usama Arif <usama.arif@bytedance.com>, Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Feb 2025 at 15:32, Mike Rapoport <rppt@kernel.org> wrote:
>
> On Mon, Feb 17, 2025 at 11:19:45AM +0800, RuiRui Yang wrote:
> > On Thu, 6 Feb 2025 at 21:34, Mike Rapoport <rppt@kernel.org> wrote:
> > > == Limitations ==
> > >
> > > Currently KHO is only implemented for file based kexec. The kernel
> > > interfaces in the patch set are already in place to support user space
> > > kexec as well, but it is still not implemented it yet inside kexec tools.
> > >
> >
> > What architecture exactly does this KHO work fine?   Device Tree
> > should be ok on arm*, x86 and power*, but how about s390?
>
> KHO does not use device tree as the boot protocol, it uses FDT as a data
> structure and adds architecture specific bits to the boot structures to
> point to that data, very similar to how IMA_KEXEC works.
>
> Currently KHO is implemented on arm64 and x86, but there is no fundamental
> reason why it wouldn't work on any architecture that supports kexec.

Well,  the problem is whether there is a way to  add dtb in the early
boot path,  for X86 it is added via setup_data,  if there is no such
way I'm not sure if it is doable especially for passing some info for
early boot use.  Then the KHO will be only for limited use cases.

>
> > Thanks
> > Dae
> >
>
> --
> Sincerely yours,
> Mike.
>


