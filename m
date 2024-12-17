Return-Path: <linux-kernel+bounces-450029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE4F9F59AE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 23:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5833C188FD52
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 22:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A301E2858;
	Tue, 17 Dec 2024 22:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EHk+UU5x"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870EDEEB2
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 22:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734475412; cv=none; b=Xei+LM1akCO+0ILJ3b3jJJzlRRpyU0j1aPvL8ZcEu2+gZnW458HVYVE/nG6EaRuH5iNUA5rMZh9nexYOS6Z907IN9Kn2Ix7xetrYMqu01GWzbGmJhRCCCcGE+CrhvICNhpTTSH2kRmACG5UkBzBDyUDFEfOE+4c7KwfkFV0jZIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734475412; c=relaxed/simple;
	bh=994MJ09Sr4Z/5FzEqZGcBH3QrWNCbzBKYIcesCa2bcg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uOq7HBA3vuBMrqlbgPhhEwwKZ+LnWAd78tWvaRx/jJr2IpshYznNE6rcClBumYpI27TX7GPPjZpdUzleDHOiGgSuzyO5g5PTm+Sup7fbd97IKwEbDNxg8r26bfbRWWzYGKJklmbu3d9Tprs3WOJNzVI7uZT/0H5PN3bNQ6BGGoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EHk+UU5x; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-725e6fe074eso8408318b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 14:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734475411; x=1735080211; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vCq9Ztj9U6pXHxYqVLTYw1eodyLSiro285ZqKow+kW8=;
        b=EHk+UU5xEWKDlXF03/JQK7Df0pwOecKeaXof0/hd23jn7eDGq8XoJrdghyQYiR9ALI
         MAezM70bkBlj4Zvm8La8fw7MUoaESs0bT4ZapPQKJ5pNW6zucFSLtilAmiawZ3/WxvFA
         fOreup89NZRouilbrpiUZMeaqObb6AsaveVJCSSeMJN4cgCuQzLs9f5ULpLdEdNzAwCf
         VIc5nfwp1OvIVTbqNrL8MuyzFaYhHPqrgo3be0ccYzI6AEca0y5Bzt1AUPGtkEn3bnMh
         W0/sCTR9nGrPm7834BVGHy/viGtiIdqnATApQkBg7GX52u3xvz6bPNdvq2rvwwB50PVQ
         UF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734475411; x=1735080211;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vCq9Ztj9U6pXHxYqVLTYw1eodyLSiro285ZqKow+kW8=;
        b=SbB+eTmeYt2oTqrZZ+p8TTlh0fyr1VPvKkd4dN7rkJBSEPOwz6L4VDTA9umhOCm9jC
         MortS1XL62NHK1ETs9ZasObzm3IypKwfHBZqImqV5etGrKWhFvouKqADMBTgBl8PVrHj
         jpPgRt8SDoQFMfmGbwbBuEpNwA7Nlb6PObyrbGYy/Mv/ns+MNtL4hzV8VwuCASjQ4ABT
         EciCo+ejBHLxaz8RAtPBOWB+eZvulkQ5Cn4qIfX5NmWbL7eqkGoE2xW2BxTmjBq3iaAH
         9D4E2RUtFl8Lywk5oFrIh4v03YykPAKbOlqVcY+3TaEq9X+ZBNcODWn5MVC0OGrfXdYE
         tefQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU6S63UmghMD4wmfNTX8LJnLIpGciU+DuSExziXkCaw+lT3qG5e1cola4iA9wPIF+gwMZnBMLoBs6bDMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdbSPtE3bWR2cnWLcQlSwopm6DcD5yP4wFAfMu5F6s5Nqlyb07
	Qv3PwgOEHYqB4c2SXu2OuVLl6F4G9QVBuSiycjlDBe36dIFDiX8OZvoE3yq77MntevVnzgAqd4B
	A0g==
X-Google-Smtp-Source: AGHT+IEzJo3ccDiLC0PMTGOM9MiGewOZoohaKjl+HxNVFnLs6ZJ9mtf9uo+4FnrFnhMMpqDcltj/MuzMtoA=
X-Received: from pfbbu13.prod.google.com ([2002:a05:6a00:410d:b0:72a:8b98:3f48])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e14:b0:725:ef4b:de33
 with SMTP id d2e1a72fcca58-72a8ce3be4dmr1013485b3a.0.1734475410888; Tue, 17
 Dec 2024 14:43:30 -0800 (PST)
Date: Tue, 17 Dec 2024 14:43:29 -0800
In-Reply-To: <bbda7d0d-48c0-4c05-a107-85a30b5c2987@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206221257.7167-1-huibo.wang@amd.com> <20241206221257.7167-2-huibo.wang@amd.com>
 <Z2DIrxpwg1dUdm3y@google.com> <bbda7d0d-48c0-4c05-a107-85a30b5c2987@amd.com>
Message-ID: <Z2H-Y5eskBqeYo9Z@google.com>
Subject: Re: [PATCH 1/2] KVM: SVM: Convert plain error code numbers to defines
From: Sean Christopherson <seanjc@google.com>
To: PavanKumar Paluri <papaluri@amd.com>
Cc: Melody Wang <huibo.wang@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dhaval Giani <dhaval.giani@amd.com>, Pavan Kumar <pavankumar.paluri@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Dec 17, 2024, PavanKumar Paluri wrote:
> >> +#define GHCB_HV_RESP_ISSUE_EXCEPTION	1
> >> +#define GHCB_HV_RESP_MALFORMED_INPUT	2
> > 
> > Where is '2' actually documented?  I looked all over the GHCB and the only ones
> > I can find are '0' and '1'.
> > 
> >   0x0000
> >     o No action requested by the hypervisor.
> >   0x0001
> >     o The hypervisor has requested an exception be issued
> > 
> 
> GHCB spec (Pub# 56421, Rev:2.03), section 4.1 Invoking VMGEXIT documents

Ah, I only had Rev 2.00.  Found it in 2.03.

Thanks!

> 0x0002 as well.
> 
> 0x0002
>  o The hypervisor encountered malformed input for the VMGEXIT.

