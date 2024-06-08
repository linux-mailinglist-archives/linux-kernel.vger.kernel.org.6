Return-Path: <linux-kernel+bounces-206960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B03901093
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 10:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53C42834CE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 08:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA93D177982;
	Sat,  8 Jun 2024 08:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/CD+ZK/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B41176FC0
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 08:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717836766; cv=none; b=oPfqznKCjgSKhIh3vsDSYAQkcAizhd+hZnISUcxI9iXH8ipYtVVgn70THTy1CXfeYsIOOPnY/RTJc2GkEAVaB1DDru+LdJnsuGTWkjHHIIOOPeP9i/r933syICy/J/I1Vb2PQq8vgwinvhg5Ovnzk7xdNvGYp8Yfh2LMvkBwySc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717836766; c=relaxed/simple;
	bh=j/pc0aDSaoMD5Z4FefrtiCAvHYjnJdayUYaFlXoI2g8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J7DWNJaDO2XcIUugRRwa6Z43vVaADYe+Fh/29tCLIWHoPMY09KJbao+biTiAS8Vm8WOYC4f0bQYNqnZHK3pcWmfoNJP2psUqHR5zvEKm0nOpupCoMJAF37IvmJQVBWdSDPhrpqNnTe2OKmV3SW7kkWVq4BaeXCkNLaC+sucqMwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q/CD+ZK/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717836763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JE0Afv2+MSIgjGY50KIS26TxZdTfOBnblGzJXPbJMP0=;
	b=Q/CD+ZK/h4wRgq+cJFWnjjkbKd+E59YBkzXbj1OXGO9BDigD2XmKm5MBTcu7bP8zXb64Ll
	GOEkF9p2wAbLogbAmHmAYMSuV/gxkAWST1GhwCl7HTOxsNStDbIjXkPFot6IJpOtewok+6
	RRsqkg9gtVuE1BTNEDNehN+iow7OGOs=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-3KvID8H7Mx6mGYPfS0L-8g-1; Sat, 08 Jun 2024 04:52:39 -0400
X-MC-Unique: 3KvID8H7Mx6mGYPfS0L-8g-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5e4df21f22dso2277754a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 01:52:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717836758; x=1718441558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JE0Afv2+MSIgjGY50KIS26TxZdTfOBnblGzJXPbJMP0=;
        b=u+TK2uxMy+1z5g9/RMTxNRIC6lVifEf9i03b9w2dEpNysjqGbxt1aBqaHghqRJdk8k
         MUrtAIR3S7MoRFh5iLPMJUliTJw+I3769AysG1WOONWuMEdOmHaUlLdf8iyZmV0PKZ38
         dP7FCKAV5jLfFYtIfddeWvmma6XyRJ4oTticd/dAyMGrLVkPaIFhofFldOxUvLz8KHWa
         GPSFsnfZ+YEqU/pCoMiCgs0MpOXRxvnONY2CJuvIe9ZPi/gVq4WmNcRvwJ4kLnNPKZr6
         EoliXClpuha9Wdg8PP9IrvPIn/bblcknTQz7awD0VuleL92G+DqzZ+ePBHamAXmYx0Qv
         z2gQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6i5Ptsvxhrc8+X4Iq33gezqHJN4Ibl6HpuNFewzAjktG/pO6iBACj4o4oeAsq5n0J3CfqaSeb2H/2Xpz66vPNKJZ6LPZZHgz/BJS3
X-Gm-Message-State: AOJu0Yx5CLKo1yCj8oMn6N9bj/0UAtxQV4CmgEb2BDEFUyHduoEmU6qZ
	XHGgkGvybfpbre2Zk+cLTKi8PlKgU4rR1prdhaGyT1hm/aaDqqx7nF7XZ1f/DDfqTwsjw9LicUI
	ICDD1kxPpdf9If6Gs+VRg6QZVEE/G0RCQXwIBQ91TBZsFJXBtmApLmtnoTc/mKn6bP8vSXTWiL7
	WGS9zD7qKtWPU7uJwhq9ZEgFdl5dbXfwFxZ/8W
X-Received: by 2002:a17:90a:528e:b0:2c0:d4d:837 with SMTP id 98e67ed59e1d1-2c2b89aadbemr6759884a91.12.1717836758294;
        Sat, 08 Jun 2024 01:52:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvKkEGPHZgVnVRswnvyZIOkK63ksDBuLzbYBh/cydVgzI1vSizf/xTfkrdJb3on2BinrUqcswJtL+NkIA7mUs=
X-Received: by 2002:a17:90a:528e:b0:2c0:d4d:837 with SMTP id
 98e67ed59e1d1-2c2b89aadbemr6759862a91.12.1717836757895; Sat, 08 Jun 2024
 01:52:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530210714.364118-1-rick.p.edgecombe@intel.com>
 <20240530210714.364118-7-rick.p.edgecombe@intel.com> <CABgObfZuv45Bphz=VLCO4AF=W+iQbmMbNVk4Q0CAsVd+sqfJLw@mail.gmail.com>
 <9423e6b83523c0a3828a88f38ffc3275a08e11dd.camel@intel.com>
In-Reply-To: <9423e6b83523c0a3828a88f38ffc3275a08e11dd.camel@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 8 Jun 2024 10:52:24 +0200
Message-ID: <CABgObfYmt+U5O4eawBqFudSCz8PBZMYs4vv=qRQzOc7+Htnr7w@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] KVM: x86/mmu: Support GFN direct mask
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "seanjc@google.com" <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, 
	"sagis@google.com" <sagis@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Aktas, Erdem" <erdemaktas@google.com>, 
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "dmatlack@google.com" <dmatlack@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Yamahata, Isaku" <isaku.yamahata@intel.com>, 
	"isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 8:39=E2=80=AFPM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
> > > +       return kvm_gfn_direct_mask(kvm);
> >
> > Ok, please excuse me again for being fussy on the naming. Typically I
> > think of a "mask" as something that you check against, or something
> > that you do x &~ mask, not as something that you add. Maybe
> > kvm_gfn_root_offset and gfn_direct_offset?
>
> As for the name, I guess I'd be less keen on "offset" because it's not cl=
ear
> that it is a power-of-two value that can be used with bitwise operations.
>
> I'm not sure what the "fixed" adds and it makes it longer. Also, many PTE=
 bits
> cannot be moved and they are not referred to as fixed, where the shared b=
it
> actually *can* be moved via GPAW (not that the MMU code cares about that
> though).
>
> Just "bits" sounds better to me, so maybe I'll try?
> kvm_gfn_direct_bits()
> kvm_gfn_root_bits()

Yep, kvm_gfn_direct_bits and kvm_gfn_root_bits are good.

Paolo


