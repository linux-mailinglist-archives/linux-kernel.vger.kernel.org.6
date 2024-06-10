Return-Path: <linux-kernel+bounces-207934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C11901E17
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F258C1C210A7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2237476026;
	Mon, 10 Jun 2024 09:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddhqNHm4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56D574BE4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 09:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011444; cv=none; b=fDP/TIDBRdcfJ8JyHpPkTv1QLxB3lwWCGlw0qrEC34TR1VhOn+3/Iy5wENT2wkSPAKONenkQFn2CVVjqieAy+YihykCcoykGKwOnd2/xpvfud1mu4PqLvmuN93zwKZ9zEK/QXoypVp7ppEmPR+a0DUobAH6eSU0re6J2AByYiQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011444; c=relaxed/simple;
	bh=nBZ9dF+0OABWdV1iqoE6bc8ju4Dqou9rPp9kvXoJsYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ownz06VabQy+CEX9e++rWD+JVRe40KvAyEKL75QPaI/NX+rUGlMTmrM2RaI7AhkV8eUB+JLsL0W27RamxHUAwLEfoTdsnAhjaVQLGQeDenqPzwlX6xJhVQFt85bAMT7FbCtXNBLxgOcFiWoNxF8BU7n1laB8Tsa+gSIwribsRvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ddhqNHm4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718011441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nBZ9dF+0OABWdV1iqoE6bc8ju4Dqou9rPp9kvXoJsYU=;
	b=ddhqNHm4DzoXp4zniIsBzeb3YgFTjXrRpMZKP7RJzOW8nDiChYOQQC/QsLjEQu0R3Jn/1T
	l/5vg58LmF3ys6ojwdE+fu1v/+/v80oOEoH600q/tBjZbCoLR8TmS1q0wdhYYQp3Jz5keB
	wlyfw5ZkMIefyzozUbKLz/+VBKfBJ4g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-KbwgnETxNFy_nZDJzeXV9w-1; Mon, 10 Jun 2024 05:23:58 -0400
X-MC-Unique: KbwgnETxNFy_nZDJzeXV9w-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-35f0b9c5bd4so1114466f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 02:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718011437; x=1718616237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nBZ9dF+0OABWdV1iqoE6bc8ju4Dqou9rPp9kvXoJsYU=;
        b=h+/Lr5aWM8NCADJO8vpWwP/wiw0QTmXWPFTtH+++bqt9LeWh1q3xvB3h0JJDlBueJ3
         9Hsrb4AdVdj0yUo58SJw2fzAaifJ9lVowDI3wMLmiJpNmNEIQrKvUYiEpIiUJbe5w14Q
         Aoo+2vFdHxMGZ8rq7BwqR9pEuVMOoAnW0nQjuVfCGYD03gOa0O31i8fOAwtw7j9Z/WsU
         RX/G8pN3vJX8pZya1jMz5gdl5erdWpYmXV9nCCtZo1Ody42MM5lyWMvuA8gcBrV8TtC9
         G5aTdrc4BpLnwCZ3L3yRSaic1ZH7CKkadXGX77KaaRuAktQzTfqdoWbIu+NexP6b7gcN
         aMYw==
X-Forwarded-Encrypted: i=1; AJvYcCUWOibtrMvqMUtDibYCtn5iOD5W75O35FwuQlE1tGvBCi74oW4MRPzHrnTOdN0tZ+9izxNYIBm+ItWWSZjSE5KrimWMFo/dNhu2Nmx3
X-Gm-Message-State: AOJu0YzUnabV9fC1jtkT/j+4XUaREbZfc0e1RsM9aBh6hbXxiUeJusIl
	rHUxPa46Zl/EtVmj8CvqoHxRS8isVjfLW2wPPfexvS7nMA+Stx6Ui0uxBFi0yEB4AZG5W2KOoFu
	zJSoq3Lh/Xnev/a12xmwccbQxUZ5x3XSr0rJx7sP5FsqcuYo2yX38KgGcvLXFgEJbX6yaA1zFvA
	TMOWnN5qQZi9wYGPERYgCiOLFrE5C3rxdgkLB7
X-Received: by 2002:a05:6000:b0b:b0:35f:20e6:43b7 with SMTP id ffacd0b85a97d-35f20e64490mr3111350f8f.46.1718011437382;
        Mon, 10 Jun 2024 02:23:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnD4OricjHIzeZrQUhiUfQSyNi2612qbHoQWqNdACOC0oufkWPT8VkmnBnvIprzUGJFTPIyjwrWV8EUkAWz2I=
X-Received: by 2002:a05:6000:b0b:b0:35f:20e6:43b7 with SMTP id
 ffacd0b85a97d-35f20e64490mr3111338f8f.46.1718011437042; Mon, 10 Jun 2024
 02:23:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530210714.364118-1-rick.p.edgecombe@intel.com>
 <20240530210714.364118-10-rick.p.edgecombe@intel.com> <CABgObfbzjLtzFX9wC_FU2GKGF_Wq8og+O=pSnG_yD8j1Dn3jAg@mail.gmail.com>
 <b1306914ee4ca844f9963fcd77b8bf9a30d05249.camel@intel.com>
 <CABgObfb1L4SLGLOPwUKTBusN9bVKACJp7cyvgL8LPhGz0QTNAA@mail.gmail.com> <9c5f7aae312325c0e880baf411f956d4cce3c6d1.camel@intel.com>
In-Reply-To: <9c5f7aae312325c0e880baf411f956d4cce3c6d1.camel@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 10 Jun 2024 11:23:43 +0200
Message-ID: <CABgObfYd4TWq4ObUzkDruj_e111cTniWtXckzB_Ft7SOdv7YMQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/15] KVM: x86/tdp_mmu: Support mirror root for TDP MMU
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "seanjc@google.com" <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, 
	"sagis@google.com" <sagis@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhao, Yan Y" <yan.y.zhao@intel.com>, 
	"Aktas, Erdem" <erdemaktas@google.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"dmatlack@google.com" <dmatlack@google.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>, 
	"isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 2:09=E2=80=AFAM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
> Agreed that this is less TDX specific and it means that this part of the =
generic
> MMU code doesn't need to know that the mirror/direct matches to private v=
s
> shared. I don't love that it has such a complicated conditional for the n=
ormal
> VM case, though. Just for readability.
>
> The previous versions checked kvm_gfn_shared_mask() more readily in vario=
us open
> coded spots. In this v2 we tried to reduce this and instead always rely o=
n
> the "private" concept to switch between the roots in the generic code. I =
think
> it's arguably a little easier to understand if we stick to a single way o=
f
> deciding which root to use.

But there isn't any other place that relies on is_private, right? So...

> But I don't feel like any of these solutions discussed is perfectly clean=
. So
> I'm ok taking the benefits you prefer. I guess doing bitwise operations w=
hen
> possible is kind of the KVM way, haha. :)

... while I'm definitely guilty of that, :) it does seem the cleanest
option to use fault->addr to go from struct kvm_page_fault to the kind
of root.

If you prefer, you can introduce a bool kvm_is_addr_direct(struct kvm
*kvm, gpa_t gpa), and use it here as kvm_is_addr_direct(kvm,
fault->addr). Maybe that's the best of both worlds.

Paolo


