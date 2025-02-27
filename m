Return-Path: <linux-kernel+bounces-537215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9E6A4893B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 218A53B4B9B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E22826B2D1;
	Thu, 27 Feb 2025 19:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HJjr0WjZ"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF4D21D3EB
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 19:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740685878; cv=none; b=q8eljpjO634sIHDPVKIkd7P3T8pOjs8SxzEr7NeI8UQ8NPtB/WHtAMDY5u7ws1QjBagS7xAHj46Io4N2aIYF54q3uipNfOAjzpPCDCL0Jc9Fq8B7BLCiVDVVctUzSP5Kw3q4o6gYjfCoxMFIxEBfAMURE6KN4PD3RPvRvwKEVLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740685878; c=relaxed/simple;
	bh=BirTm64MjOA2cmJHC1SBCSVIJHdY1tfvoF7jA3DNzA8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dfvgTjL2t4E/93PCysnd6datxyG+NTti8gJ+xPvEyvVgoizSD1TIFkcrqwOk6c32MXuUpeWGAVEycSh6zUI704LJKezipQbr56kX/a+F+OUiTu0eIVogo0f2mFanE1aFKt++i5Xx0+JlxuttkKxOMQMp6+uCIXLdUZtcXRm584c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HJjr0WjZ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220cd43c75aso49852045ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 11:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740685875; x=1741290675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U7s37NdRt1FlX34JnKymJUCC/VGv/nCbV/kg9VWxXOk=;
        b=HJjr0WjZPX/JnRxFWcJ3OoI5O8ebJhBgUwX+gYYhIBGegSMhGCDhXsDGnxXWqMKPqN
         iF++Ttc/rD24qU/225k2v0LeV2leN1ks8yTXfP1qw1IGXWJT8LD+d7kgdwAefL4ZBfUX
         RLz2UtAtt9XzIWAJVT2lhiErDOe4Zi1v4pYk9m5+qgI6qcdHzBDiuPNHqLJrhIb+dgxD
         PnrUeay7SmZPqFJggjlpij52jsQPX9NjceKrR0Qtl8JDk8YcpP+M2I6rInLbp/IeI6jR
         uRZOY3GgJduRT9ajiih4r3+Mo9xO9JI7Z1vFqytt/UVkk9GlQmMn6Hb0UVUnghD312H0
         CwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740685875; x=1741290675;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U7s37NdRt1FlX34JnKymJUCC/VGv/nCbV/kg9VWxXOk=;
        b=c4Nz5h3lv3s8QsSBPDl16OJlToONnwm1ECYNR84qTvloxXeb3gaMv+2GB8CFI/S8TC
         BrcE/yS9fFxr+lhqLqK2xHYrqnH+8hzmGoE3epy9VF35kRe9FUf4oNbnMTidCJUj262R
         /yrGADRkXo2tXuRhdbD1bHZrX93+x7Y1CDJ2IEWPsM3quCRRcxgqfhZpFXlE6dGdc69H
         JogUkWQKcyGUEpTzvuHVIjnVJCkd+gpuD/i2oQE2waafKdwUP0SPiPtXYUAd3uS7YkOk
         uUO3v53B0cktxYt2AP0dufUtm3YWhqgnBGVdfLUSwl3rTQEU1b+ew2rKbhVvaEK+ZoGG
         C5dw==
X-Forwarded-Encrypted: i=1; AJvYcCXNBGAqVDnpqv5Z3HDMc+fyJkIEXXL0g1WutwuPTwF1JZhf8ufY9M8kohqUlEoydZASsPhHXYU95GQsYHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6V/QrZIPztzDKm/ivv1mhICNAXEON4O4zrthXcxUsAKpNN5g0
	AFVj5FNroZYG49A7teSGVMdp/kbiXepkMQ4vTYlUcUS10LlpG9hDsqR9dsF8PJm4hNGmw2R8Hp3
	Ofw==
X-Google-Smtp-Source: AGHT+IGHfEwLM3h8sPwwS0B40IkejWBgy8pAbzqEOfOdhpqf7pOnl/QM4A57CBOa53+9j7ZReRb6zN9cbkw=
X-Received: from pfbfv10.prod.google.com ([2002:a05:6a00:618a:b0:734:a25c:8951])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:99c:b0:732:6480:2bed
 with SMTP id d2e1a72fcca58-734ac36feccmr960157b3a.13.1740685875558; Thu, 27
 Feb 2025 11:51:15 -0800 (PST)
Date: Thu, 27 Feb 2025 19:51:14 +0000
In-Reply-To: <4A1B24BB-E351-4F98-8A55-F2FB9F45BBF8@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227000705.3199706-1-seanjc@google.com> <20250227000705.3199706-3-seanjc@google.com>
 <73f00589-7d6d-489a-ae40-fefdf674ea42@suse.com> <88E181D6-323E-4352-8E4C-7B7191707611@nutanix.com>
 <Z8C-PRStaoikVlGx@google.com> <4A1B24BB-E351-4F98-8A55-F2FB9F45BBF8@nutanix.com>
Message-ID: <Z8DCMpSD8kNzNPky@google.com>
Subject: Re: [PATCH v2 2/2] KVM: nVMX: Decouple EPT RWX bits from EPT
 Violation protection bits
From: Sean Christopherson <seanjc@google.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025, Jon Kohler wrote:
> > On Feb 27, 2025, at 2:34=E2=80=AFPM, Sean Christopherson <seanjc@google=
.com> wrote:
> >> LGTM, but any chance we could hold this until I get the MBEC RFC out?
> >=20
> > No?  It's definitely landing before the MBEC support, and IOM it works =
quite nicely
> > with the MBEC support (my diff at the bottom).  I don't see any reason =
to delay
> > or change this cleanup.
>=20
> Ok no problem at all, happy to rebase on top of this when it lands.

FWIW, you don't have to wait for this to land to send your RFC.  You could =
send
your RFC as-is; obviously I'd point out the conflict, but (a) it's an RFC a=
nd
(b) generally it's not your responsibility to anticipate conflicts.

Alternatively, and probably better in this case, would be include these pat=
ches
in your RFC, with a short message in the cover letter explaining their exis=
tence.

That said, I'm guessing I'll beat you to the punch and get this landed in
kvm-x86 next before you send the RFC :-)

