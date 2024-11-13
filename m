Return-Path: <linux-kernel+bounces-407492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6439C6E32
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1881F23D17
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A80D1FF035;
	Wed, 13 Nov 2024 11:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HI5k9OkE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5066E20013C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 11:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731498767; cv=none; b=qU3etlsnxDv2eT/XehicTNQxwyavcjqjYB07ie9MWCUi+QBCkjpC7eGzn/3CAZ3iNxAzqc3cPNFxdmHXFvdHku+UI9VMrEAnWIL7gfg0xb+Pg90h+FsPhubRkfXl5ZZ9/AI5woNfpwVZi1ZaKq2ABKrZnEL6g25TMlMX4kYF+AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731498767; c=relaxed/simple;
	bh=KoA7aneSXx3ZKIU7Ayorly39vcdZxYjy3Uy8mUAR7DA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQ6yyZ8YQDjmgrQLlA2tqGZxsmmjjZ+Udut7kHEVpXk+6U/5uN3vBjD+sFl/ntlZ3FuvBoEYl67W5oRafJXCaVBZnJgLWLoN+UE/K+r+LkI8QONNjljpAwWrFkVXXtNUD3e0kj+TkRgqKt+307K3WlCjoYnVLWSga0oNU4GbcTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HI5k9OkE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731498765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H8GG3bgFV940PzUISamo/3voobg8H2uooMahXAdxS9M=;
	b=HI5k9OkED8iRMz4QCE6XLrCCyz/4vcsfm7+hVZLDrO/BMs75vAKvz062NlzDH61mVI+7Bl
	/krOxao7CAbtduR7PvOrbOQ8fnp98hlG3byx6n+BdSEA/0EyWzhTcNb5oxwmV4M1IdxcN7
	s/ArXG1Y3jftSxe+Kls55yNOSZl/pA8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-bFMEqLolNeKCe4BSMrOOqA-1; Wed, 13 Nov 2024 06:52:44 -0500
X-MC-Unique: bFMEqLolNeKCe4BSMrOOqA-1
X-Mimecast-MFC-AGG-ID: bFMEqLolNeKCe4BSMrOOqA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4315cefda02so52248715e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 03:52:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731498763; x=1732103563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8GG3bgFV940PzUISamo/3voobg8H2uooMahXAdxS9M=;
        b=j0v3C8GkEKjweH5Fn84TiPVpd08l8B7XE0mEB4SguOugeiXzoq7EvL+xLmz9kC1tc+
         +sb05nU4Akco0DS51YT5lhMJrxTwXiqOtEzifcaQLoGf/d323PJ+oeTJgvtZrqjQJpUe
         eAKQgdUhKpSVvnn9RUnjveguBO9NchQeP3f31Bci62brAG/XBMFjhq3hx/lR/QandPHp
         KrGUZzJr5evkC25B7k3tLj+5Jw5b16T4mbDTxwibalkZ4akvUkCYoG7ksr0MjNMKW2LZ
         zT6n8p0N08IpA4zLqUYhfw124WW0YgDeTnXx5aDrTkg2CorYvHV3tnrNpS05qJhl521x
         rHZA==
X-Forwarded-Encrypted: i=1; AJvYcCWducoti/8rRq1b3hGBQswA/XWNHDroqsEFKSufYg0SxOH4zvl7FjEMb/5bGombzr1BSchd7Agt1Lu9aeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2AGQhAJ0luJfzSLT2ezRzOpCxBMbkbVMsCLP4dpeOf05pDVoQ
	BbNBGlEobC2MM9PNXW61hS4ik7oToLgj9chFEfOLTpqF+P+jDvAZukylIybr1fdjo+ql8e4wj88
	HLJx2scq2PlCLusLs+OlYssb+7s3D0pNTODq8nJFq4sTd/Q9wdmxg1rHubtbv4URKCvV39AyBAL
	1GmjzYE//0jnkS30Rz+QsMy4AId6nOTLMwfgSb
X-Received: by 2002:a05:6000:2a1:b0:381:b1b4:8ba1 with SMTP id ffacd0b85a97d-3820df886a5mr2194430f8f.39.1731498762736;
        Wed, 13 Nov 2024 03:52:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHInjjzc0odTC4+ABONcZUhIrP/Zbe+sjnc1EcFafsE/fBoawG4vrSRffP0crV4iPGugIA1AbuHWmrXbW/5lHw=
X-Received: by 2002:a05:6000:2a1:b0:381:b1b4:8ba1 with SMTP id
 ffacd0b85a97d-3820df886a5mr2194417f8f.39.1731498762454; Wed, 13 Nov 2024
 03:52:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112193335.597514-1-seanjc@google.com> <20241112193335.597514-3-seanjc@google.com>
In-Reply-To: <20241112193335.597514-3-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 13 Nov 2024 12:52:31 +0100
Message-ID: <CABgObfbxwac1kpECfFp0MA9Fmtje4ddFR7W=psCGjx=Trra7PA@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: Misc changes for 6.13
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 8:40=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Please pull a variety of misc x86 changes.  The highlight is Maxim's
> overhaul of the non-canonical logic to (try to) better follow hardware
> behavior when LA57 is supported.
>
> The STUFF_FEATURE_MSRS quirk might also be worth a second glance?

Yeah, it looks good but MSR_PLATFORM_INFO should be exposed as a
feature MSR (otherwise userspace has no clue what are the valid
values).  I'll send a patch.

Can I ask you for a review of the prepared bitmap series
(https://lore.kernel.org/kvm/20241108155056.332412-1-pbonzini@redhat.com/)
and possibly https://lore.kernel.org/kvm/20241108130737.126567-1-pbonzini@r=
edhat.com/
(this one is not a huge deal though, as it's mostly deleting code)?

Paolo


