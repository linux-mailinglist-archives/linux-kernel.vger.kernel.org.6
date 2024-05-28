Return-Path: <linux-kernel+bounces-192824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 684F38D22C3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EADAE1F249EC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490F545945;
	Tue, 28 May 2024 17:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MOGYGVjV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA8B376E1
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 17:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716918476; cv=none; b=QUGnXhhI12KvTZJ3qR2riqbi74DrqGlkZ6FALHBtWs80PD7M0G1BDfwt25jy+xb+TUrNIqO6xapepBAeMZZvKhHZVErEWKlj9DNIUp38zYNJ1xtGnQ2Jh3gBReoMWksh4HobzjLOG9STnNDx/rmBDv/yLWSMw+gCH2mGnRGbGK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716918476; c=relaxed/simple;
	bh=IpaDiea+XrcitC1S3q3JbjCh6STq1vLCHmAgsLFtB9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4EJk2AC0mdlLeOzLI8AjA020W+x4nBko2t3hLiyZX+8qAmGatrREVT7U+tKXnY4ta8PVMOCYFOB+qTxJuuPg2VdSYvPPmDEOWmvBYlPAkvFCZDn+hAcZJDJX++3uN+IssY/etb03A9GIZWCP7WRQOuwCffa0oJNeL9S96WenUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MOGYGVjV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716918474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IpaDiea+XrcitC1S3q3JbjCh6STq1vLCHmAgsLFtB9w=;
	b=MOGYGVjVfQTBkO8TkNzaWSTEF8UKGIal5QMgKrvQow4UWYvIF1180OcURMIFNQ2r+FVSnB
	1ORy6vfKfFt7hIr0KV1nw3yS8KTlDtIHVlFsAXUIr7GmGCaNckPkzyAzZmqZdjRcvPhuHv
	zkejIe1As+agBgvRFSNa2yyTeUgNYYY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-WAt8p3GBPm-SgWYFHu7MgA-1; Tue, 28 May 2024 13:47:52 -0400
X-MC-Unique: WAt8p3GBPm-SgWYFHu7MgA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4211043b5easo6318145e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 10:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716918471; x=1717523271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IpaDiea+XrcitC1S3q3JbjCh6STq1vLCHmAgsLFtB9w=;
        b=Ot/jjibHFGHbMrgiOpthMpZGBYLN0x7xkON3C0u9paDiVfjlCHtQ9+mJUHjnn669qK
         KjK5tRjIO2cbE1GbnVt6IOmWGyoeSgbpBMSVutLXsBU+zKV+329zSe0jORqfXsJ4jYXK
         Va+2rJ23V+s/AOzVM6GmEdZdnm/e4zR/zlZjZzN8mIQS7cBWkQDA8AZRYWOR5VX7OgKL
         b9U+r39EGCAmrvfQDA22CjhMZjiisjvkQW90HLl7jRHtk4ZauAFX2L2WnljwkTQzc0N9
         lY5BlPQtHc668cge6LGfptEuUjF7mCt2pae+Ymgo99B5gM54eZIUCquhAh87AYqzYb4b
         fGPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSW641WV3Xn1mwVYCKcPw+zGHdI8t+SWApWhthW/o26QQySfOWzoJ26YRqxDHlc0Lydz4a6qetSKRUVSQxo/Uoprwzow21eZyWY5cn
X-Gm-Message-State: AOJu0YxtwXb8hVyX4GVEGY3ooaOkWbwsmRW7fW9fssnamPvq6u80nhMc
	zY1ljA2OzkHcdgro/+VCUbIsMiR55P2TVtXshwCdZ0CrJgKn2oNSDN8qE/bMJXQ5WbgPI44B+u1
	zX0g2CPm/GKOp4Nt5iO+lQRtxmFAdYm6U1lJq719+a1VO48uP4eeRhmoANyG+SNXRbAt5AbB5hL
	eLkJ5cSNL9GC47oTS+UrPVPEpPrMCgxX7Asklx
X-Received: by 2002:adf:fe88:0:b0:34d:e252:b57d with SMTP id ffacd0b85a97d-35526c27436mr10419518f8f.17.1716918471325;
        Tue, 28 May 2024 10:47:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaR5+xzvDJoxCZiUbtkXASxV59eIdH4br7ui/grcMLd6yTvO1MxQYSlArcsFBKf6TIUWptXdTnzqIM+RUJS3A=
X-Received: by 2002:adf:fe88:0:b0:34d:e252:b57d with SMTP id
 ffacd0b85a97d-35526c27436mr10419499f8f.17.1716918470964; Tue, 28 May 2024
 10:47:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517191630.GC412700@ls.amr.corp.intel.com>
 <20240520233227.GA29916@ls.amr.corp.intel.com> <a071748328e5c0a85d91ea89bb57c4d23cd79025.camel@intel.com>
 <20240521161520.GB212599@ls.amr.corp.intel.com> <20240522223413.GC212599@ls.amr.corp.intel.com>
 <9bc661643e3ce11f32f0bac78a2dbfd62d9cd283.camel@intel.com>
 <20240522234754.GD212599@ls.amr.corp.intel.com> <4a6e393c6a1f99ee45b9020fbd2ac70f48c980b4.camel@intel.com>
 <20240523000100.GE212599@ls.amr.corp.intel.com> <35b63d56fe6ebd98c61b7c7ca1680da91c28a4d0.camel@intel.com>
 <20240524075519.GF212599@ls.amr.corp.intel.com> <31a2b098797b3837597880d5827a727fee9be11e.camel@intel.com>
In-Reply-To: <31a2b098797b3837597880d5827a727fee9be11e.camel@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 28 May 2024 19:47:39 +0200
Message-ID: <CABgObfa+vx3euEXwopBBzt7BEVT8MV7HuuLayRKxURnopO3f=w@mail.gmail.com>
Subject: Re: [PATCH 10/16] KVM: x86/tdp_mmu: Support TDX private mapping for
 TDP MMU
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Yamahata, Isaku" <isaku.yamahata@intel.com>, "dmatlack@google.com" <dmatlack@google.com>, 
	"seanjc@google.com" <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, 
	"sagis@google.com" <sagis@google.com>, 
	"isaku.yamahata@linux.intel.com" <isaku.yamahata@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhao, Yan Y" <yan.y.zhao@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>, 
	"Aktas, Erdem" <erdemaktas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 6:27=E2=80=AFPM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
> > I don't see benefit of x86_ops.max_gfn() compared to kvm->arch.max_gfn.
> > But I don't have strong preference. Either way will work.
>
> The non-TDX VM's won't need per-VM data, right? So it's just unneeded ext=
ra
> state per-vm.

It's just a cached value like there are many in the MMU. It's easier
for me to read code without the mental overhead of a function call.

> For TDX it will be based on the shared bit, so we actually already have t=
he per-
> vm data we need. So we don't even need both gfn_shared_mask and max_gfn f=
or TDX.

But they are independent, for example AMD placed the encryption bit
highest, then the reduced physical address space bits, then finally
the rest of the gfn. I think it's consistent with the kvm_has_*
approach, to not assume much and just store separate data.

Paolo


