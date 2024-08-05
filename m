Return-Path: <linux-kernel+bounces-275014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A23947F8F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5A7A1F2356A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C384A15F3E0;
	Mon,  5 Aug 2024 16:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XdBs8+ro"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C3915B12F
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 16:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722876355; cv=none; b=JVAxalPPOJ62nTr7mQe9SO5+zrImDbmJcZ3h5nA5T7D1UXGdCCzJLZabHf+QGme/XzxOrJbaDZ2kllLYtpx+aY+wDWCmhdaUg9C/7IiU67jkcd66eWsR1up9e1DLKI5Tt5z/lG33CG+lT5s3XpyolO3DPSFZsHMyuILpurtz2L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722876355; c=relaxed/simple;
	bh=/VBbVlmTnVxwdhVNe4IkYQj6hCVgPsTCNZKm5KommQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hiT04gRnhyNLojcwrRGaU9pJGJLw9umIKFTkiFewUhkaQl2Bt6q8N5i3lX6LseQMecHHThbEAviY5tTZ0YRlDT0BPOI4cm3a2gUxWliGI+gR5DNf2/qOv7Bf0KIR849bYS3m5OvoRgBU8vt90I7TLd0lP0+ceEeCednFOvJxAeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XdBs8+ro; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-36868fcb919so5768103f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 09:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722876352; x=1723481152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6yVSUrGgXw/wlz/1NwkFGiV5TPvOyi6VfHlHGsXoAI=;
        b=XdBs8+roWWoM0TE+dkYpIiy44miTOLAocD7a3cgLNlOmOp/1WnG+rJFz9y3Msybm9K
         IKMoQTMkKElGJhIgWIvPhbZNdA1dnEo46NSAAcf9W15AcoghBv0pTUJS2k8rV9oIcKJ/
         EpwE6ohamdIdU1VAmpjyzU8JRoy/zpgp3tyUqCeTgvGXhzTAzfL9BTV2KUV7kCqFfOsC
         ZajiJfAiocYpUqQH6kRS8QTayh0JvNR/JARdLff0O5O5OHAnZjZirPrk3l3+IFCQQnPg
         RvATiEKYrRgFkGkkw4NVS2y76FmvreMDru3Y023MxQcitl0bXDGhuMAc03xsbSpy7FYj
         ePfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722876352; x=1723481152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6yVSUrGgXw/wlz/1NwkFGiV5TPvOyi6VfHlHGsXoAI=;
        b=wVFYMFPa0Vmmj5meq5BhrgQFI2f+vN+yesyCB4rED6FIpL/Io48QORjLuXpDVUYB20
         g5PAXPFEiDnHP3LrXSVsIb5wQwxg1awQx0XvvCWM4gyw8jXN8ACOo2rT0g39FsWDsdO3
         R4CuuoLBXbpCNc7O8/ILGJ6vblGCjMt9Q2D110TgUJBrgvReitAPlFN3Dg2Up1oZAlUD
         J397Y/zIPrWSIzbSb0vTebQsa1UXk28moUqVCav6XustTKUmep4oyoYJJhaJLRmCSIHB
         DxtenLPNrHNCLMAGGAHl8AmEPLCS5KLuT1SVyYC61rk8pRvfxAXoqISwOuT0H3jX/NLy
         rKmg==
X-Forwarded-Encrypted: i=1; AJvYcCUW4R7/19P8PFE0DGPS59si8L3OSoktM7sKLJ+VAqwndb03g5dbbUW0lClw8Js+FTi8xtTT7RtmZSHt2KRYZvBVtKldrEy0QQGoeb6C
X-Gm-Message-State: AOJu0Yxttl7OLlEvaveQ7ie+duIaMfCiI/lfaSkG0dQlb6K9w8Xc2h2D
	zga4RfeoHq+znuD63a++OrxdsZwlxZK311S6GwfxjOs2DiUe4P0qe8UVj3+evd6B37Xe7VzNHMg
	BCRLJyQrKE7QN09yJtFc/xMrWiefEvAroP6ot
X-Google-Smtp-Source: AGHT+IHmqog28WAFrnaokq40fDy52AoR8UNilS+pnfHvTEhN2Ra32PFNq7u1rB5zCTm7gzUJ7GQSz6iT9QTw3f0IKAc=
X-Received: by 2002:a5d:54ca:0:b0:367:96d2:5756 with SMTP id
 ffacd0b85a97d-36bbc1d7a5fmr6926373f8f.62.1722876351843; Mon, 05 Aug 2024
 09:45:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801183453.57199-1-seanjc@google.com>
In-Reply-To: <20240801183453.57199-1-seanjc@google.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 5 Aug 2024 09:45:27 -0700
Message-ID: <CALzav=few=dq5_9QC=ivRWxEtRvQR47BWh5j5-Sgg3Zy7_Rx0Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] KVM: x86/mmu: Preserve Accessed bits on PROT changes
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 11:35=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> This applies on top of the massive "follow pfn" rework[*].  The gist is t=
o
> avoid losing accessed information, e.g. because NUMA balancing mucks with
> PTEs,

What do you mean by "NUMA balancing mucks with PTEs"?

