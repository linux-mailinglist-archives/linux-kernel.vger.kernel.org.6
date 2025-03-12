Return-Path: <linux-kernel+bounces-557630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E668EA5DBB7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FCBB3ADE37
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAEF23F362;
	Wed, 12 Mar 2025 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HwJvAkD0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05071A256B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 11:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741779435; cv=none; b=Tr6yMG/TRSozY7x5eQEde+jke7UXOFIK4P30Z0acizBJuySa6n9PLWExVB6sET68huFgWNtmEUlr5Pc7TSexcLBBeZeIaqfodWM53spP9nRX3TsWHdPS4OGq1j65c+sQn/gX1Wo8AIquD/5u6QeNIAe9zEhXUbuOFrgBmIQ82Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741779435; c=relaxed/simple;
	bh=7Z26bGllpYXu8uBHNuMML/I4jSffsSVsXJKQG3g7s9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fsnzl/bOQGGYE+GNca/hTegSExcC/WBlrRjyTOqECmcP43eel9Dr8yIjLYbe8X2e6rHbRPQULzWK4im4dqlO5VV8ls14zEzMJ3PJyzjSFCiIX7tjA0JVme0zOpvZkXu9UPnFS3nSYExVY68RWhvD8+M4bz6/phRTn0DRYGddMhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HwJvAkD0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741779432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v39mmJ/ZoF+dw+zjNgOr5RkZMHs7oG2cf+OVSp6s3sM=;
	b=HwJvAkD0cnKPxz+/hkAmilNPE8BBGyFV/ArWs2Pr4N1NtPOPZZU7/TrNijNq1d/xYT73Gl
	g3/P5MCWi+KsM8oGdvA7oU6ADC1dkaIUY/7BbT9nugT7iR1JnyQB6PuO/TbI7OenVJ047b
	2GYkNK1lRCRJ9txfndiM3XmQAa0gGwI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-2hX1PTfDPNyCyCWh9Rh1Vw-1; Wed, 12 Mar 2025 07:37:11 -0400
X-MC-Unique: 2hX1PTfDPNyCyCWh9Rh1Vw-1
X-Mimecast-MFC-AGG-ID: 2hX1PTfDPNyCyCWh9Rh1Vw_1741779430
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3912539665cso354055f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 04:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741779430; x=1742384230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v39mmJ/ZoF+dw+zjNgOr5RkZMHs7oG2cf+OVSp6s3sM=;
        b=Sz1nPx80tASsuHmDVEAsSszedPYnAUsCSGsdFezXTm/JalIvvH7btaVSQ72OcaA3Bt
         ou/84AnTEobtMc/uMkBrQYe1DQMvH0Vu4mjLD2sOAWzLNa+/iZOALFzp/sU56VnSPIH4
         3lFsGU9fTRR4FNJpBY1c2u53qKc2tTcOthYKH/rHE8OXx2RWfRLhrVTLnm/ewUmhpLEY
         PrJSIjiGGzucABjLFkglc/3ql7mkRoV/OJViZcqaQwN5QkEO5SdK0R9qoqlPd4Qb+p8a
         Z6uUyWyD8JuFe6SZ8rPPsEfoJVbuGqsrFsXzhWcGACR1u/AQvNkhTX5d4CizXfo7NYTv
         eZKw==
X-Gm-Message-State: AOJu0YziR1qdhXWfYCTfySzwlVJPTqZgHuQDuXGVGvhutQYVqc89Lt6R
	XBTxSP9UirD3AkCXRTRPTJeSNyc+uEW5vis4GEYw8aei/rlphifaP8NgLNsoJLtyhnGKWuPKHSU
	E0+rVFwvg1jz0nJskO9M97JDpLRAr/hGnO+ZBOqXQ6FHrnoqrSJ0iMlOl2y4nT5N57csVORiElK
	j+EQtqRr/wwVIrb4UkoxkKg4kex8rRapGl0rmQ
X-Gm-Gg: ASbGncs8S2/Y8Of8Q2VmrxQHeJU5ZNMNko0PZVgMN4o1kiNDWVdq4yLV5j642sHTbJV
	DZIehXUGGZy113sLVuiPBUVcPGk0yzft4SuHPLkwe7UvpSq4oPdgR6pr5pCwVz44XDz8b7WAksZ
	I=
X-Received: by 2002:a5d:6c65:0:b0:391:98b:e5b3 with SMTP id ffacd0b85a97d-3926cb6442fmr6993445f8f.14.1741779430055;
        Wed, 12 Mar 2025 04:37:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7hIva+qqfbAEoA76LRf9FvRMmtz4KNW3wTSXaAkTtMnkEd0MmL7x1VFb9AhRfs/15MSWdNi4TGmI00qsBok8=
X-Received: by 2002:a5d:6c65:0:b0:391:98b:e5b3 with SMTP id
 ffacd0b85a97d-3926cb6442fmr6993432f8f.14.1741779429767; Wed, 12 Mar 2025
 04:37:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307212053.2948340-1-pbonzini@redhat.com> <20250307212053.2948340-6-pbonzini@redhat.com>
 <405c30e9-73be-4812-86dc-6791b08ba43c@intel.com>
In-Reply-To: <405c30e9-73be-4812-86dc-6791b08ba43c@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Mar 2025 12:36:58 +0100
X-Gm-Features: AQ5f1Jr4qB7EzSh_KRS3HvUL2rvLWxmR_egbZcCrsJItfsIes2DzNlQGEhnpkNw
Message-ID: <CABgObfZOhNtk0DKq+nB2UC+FFhsEkyiysngZoovoJP-vF43bYA@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] KVM: TDX: restore host xsave state when exit
 from the guest TD
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, adrian.hunter@intel.com, 
	seanjc@google.com, rick.p.edgecombe@intel.com, 
	Isaku Yamahata <isaku.yamahata@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 8:24=E2=80=AFAM Xiaoyao Li <xiaoyao.li@intel.com> w=
rote:
>
> On 3/8/2025 5:20 AM, Paolo Bonzini wrote:
> > From: Isaku Yamahata <isaku.yamahata@intel.com>
> >
> > On exiting from the guest TD, xsave state is clobbered; restore it.
>
> I prefer the implementation as this patch, which is straightforward.
> (I would be much better if the changelog can describe more)

Ok:

Do not use kvm_load_host_xsave_state(), as it relies on vcpu->arch
to find out whether other KVM_RUN code has loaded guest state into
XCR0/PKRU/XSS or not.  In the case of TDX, the exit values are known
independent of the guest CR0 and CR4, and in fact the latter are not
available.

Thanks!

Paolo


