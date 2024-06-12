Return-Path: <linux-kernel+bounces-211868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C6A905878
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78EEDB2629B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA64180A91;
	Wed, 12 Jun 2024 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KJ6DJ6kM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE9316D4F6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208385; cv=none; b=syre7/O9JX33oTagmz9RXCAvXZIFjhuOgEz2DiZ5kP9rHJIbLPHI9bXleld4xfjNgpe2xr1522RgXKTJjjJswCoZbABxZLjlQlAZNiyeSVafSn1Z68kzRqVtxeXJ16BXeWisG38nTMpVxAj+iOkLbNAkU2Jkugb7Fhvwy8LyiiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208385; c=relaxed/simple;
	bh=NHtYjSmTMtNed9N2wRZmQj/KeFSv++nlwQX6y2LLOZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qi+8WWpUH7+EcH2kqbMdTon8F5aqg0n/tF5fWm83vlqukFMwMGcsYJX4eBIh3ZftkZYDjassxDhaOx/Ph60D9lh09H3EtkC6/UFRPPQyGq6ZOiB+/jZReAIUrrcOkHS+jVktRfZQ1n67xfpr7uIpYg61ga4Z+o5DW8ukiujtk2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KJ6DJ6kM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718208382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NHtYjSmTMtNed9N2wRZmQj/KeFSv++nlwQX6y2LLOZw=;
	b=KJ6DJ6kMAqyfbkcRIIPrmLF0eaAp5eTIbIRJRV5Jsmksm6NmQjGxDeLGl8XeTCZGJxGTtA
	AIc90Fe19obCqA4OG7I6UPbqQ6RlwzPqWMM/oXh2D5l0nsR1Ce1MtUUXwkm6ns6V6hZ2lj
	HrMHCi4IvaYTS0yryheS96QFC9+0YyQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156--_enJGe7PWijzfjGTDn1uA-1; Wed, 12 Jun 2024 12:06:21 -0400
X-MC-Unique: -_enJGe7PWijzfjGTDn1uA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35f29246a35so20302f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718208380; x=1718813180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHtYjSmTMtNed9N2wRZmQj/KeFSv++nlwQX6y2LLOZw=;
        b=WcsFxf/wkChThs4Oc4xL/TlQnKzZBuHVya8Onplz9M+hfnlQJ+o0vPjHPAUEXL6E+a
         RooFJxnPyJEiYmUw4yxDFQKR76GQMxBIPeKyXGy9h8zwjpbzBSXXYSOIdfU1rmKcDUv4
         2LbEk8Bs9bnQJfRGoAO0gkO/+A52R/48mLbVfRRLhRwPP+BgsJ7+JOb+qEGe1XWmlbDJ
         thg2K7iOeBctldPsnLvbGFC7VrNPJ6H95mUlVxbQzCpX2cip4T6XL0sN8xMko5kyQJEG
         cQEsKpTVhL7g6Lxu1D1VROLITNaVZ4dlXGX1ixOY3x81OXkx6xACpG9J/vKqs9KPFc5j
         kZTA==
X-Forwarded-Encrypted: i=1; AJvYcCXCi8RxLV7tcD5GKVdEho1ITFc5PseCoFAhLeBxuGVXLb8xLr8s/p2QdujC5ApqCe530ZfYHM5JHQ8PDdxc4YyYKHlHRqAhEVpm1O5C
X-Gm-Message-State: AOJu0YyH3UWQdQxvxfcZxhXbtb1gO6PCTtNvRCtN4IEgkiz+4uPmgZbP
	CZ35Rc4FlWpRgk96qTHG15Ac/f7M95UjtB5lycEYAWGLw+XWjrdGNEndJIMSHlv8nbwapFJo2dP
	O1iJKqD//Jo9IdHfLZz1+pnAJ3oaHxztd5R40eLr8N7OycLvtrNRQsThnme++liQvwPiK4GEIMH
	uxQrwRHmALYT9k41sLUOBtCaQvaGlBSOladl65
X-Received: by 2002:a05:6000:bd0:b0:35f:1522:10b1 with SMTP id ffacd0b85a97d-35fe8910281mr1694733f8f.52.1718208380032;
        Wed, 12 Jun 2024 09:06:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkRfD7FvnoG5vFiDBFq1+esQSuEl5w50A3ZLaNfGGB3jdeoZnUnL8EYolRcw3lA91SzLS5T7kDSZg7qE2+M94=
X-Received: by 2002:a05:6000:bd0:b0:35f:1522:10b1 with SMTP id
 ffacd0b85a97d-35fe8910281mr1694710f8f.52.1718208379663; Wed, 12 Jun 2024
 09:06:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708933498.git.isaku.yamahata@intel.com>
 <9c4547ea234a2ba09ebe05219f180f08ac6fc2e3.1708933498.git.isaku.yamahata@intel.com>
 <ZiJ3Krs_HoqdfyWN@google.com> <aefee0c0-6931-4677-932e-e61db73b63a2@linux.intel.com>
 <CABgObfb9DC744cQeaDeP5hbKhgVisCvxBew=pCP5JB6U1=oz-A@mail.gmail.com> <f4029895-01c2-453a-9104-71475cd821ab@linux.intel.com>
In-Reply-To: <f4029895-01c2-453a-9104-71475cd821ab@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Jun 2024 18:06:08 +0200
Message-ID: <CABgObfZ+Xvh1+ewJiCB4uqzPSYo2JvTz0aEUzT-CNruf35_D+A@mail.gmail.com>
Subject: Re: [PATCH v19 116/130] KVM: TDX: Silently discard SMI request
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>, isaku.yamahata@intel.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, isaku.yamahata@gmail.com, erdemaktas@google.com, 
	Sagi Shahar <sagis@google.com>, Kai Huang <kai.huang@intel.com>, chen.bo@intel.com, 
	hang.yuan@intel.com, tina.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 3:06=E2=80=AFPM Binbin Wu <binbin.wu@linux.intel.co=
m> wrote:
> On 6/11/2024 10:11 PM, Paolo Bonzini wrote:
> > On Tue, Jun 11, 2024 at 3:18=E2=80=AFPM Binbin Wu <binbin.wu@linux.inte=
l.com> wrote:
> > > is_td_vcpu() is defined in tdx.h.
> > > Do you mind using open code to check whether the VM is TD in vmx.c?
> > > "vcpu->kvm->arch.vm_type =3D=3D KVM_X86_TDX_VM"
> > I'd move it to some place that main.c can see.
>
> is_td_vcpu() can be seen in main.c

Ok.

> > Or vmx.c as Sean says
> > below, but I am not sure I like the idea too much.
>
> Which you may not like? Remove the vt_* wrapper or use KVM_BUG_ON()?

Removing the vt_* wrapper.

Paolo


