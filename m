Return-Path: <linux-kernel+bounces-232248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A5891A5B9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56B31F269B3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 11:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4EE14F9E8;
	Thu, 27 Jun 2024 11:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbfVoKv5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF4E13AA4C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 11:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719489222; cv=none; b=RIM1AEunGhmO3Foruw4TbjfYqdFXwmcsVuyjiNT50PrrYY8Km4HVkkxzj8mSmJqPfIpp1VN1eE0Qnj66SgGJd44ITNAO0qlUmvfUaFFJXKbStUvBVeGao9s9CaJSb+LwmJuyhGqN5FrPMGZwZZJCkqak9sM2pBnJVT/XbqJzTWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719489222; c=relaxed/simple;
	bh=WpnKLjyFgPP+Ets9M+udfSNPE/YG1Fx4YKF8lUJWlY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aq4FRBHAnZC4LhE6Yy0hEPc842Hu+JcYst8E9/NcFxGP11GahfEKwcJEWYzeQ45Hv/Jdfpj9sMus0/Jt5J+GhDxVDlK3adKGRCYwVVewoWfBg9WgbSCutRGWeqHBOF4PL+SsNrnoVn7QUHsxe5Cc+gCWLHjkVuS3ebEl54TNS7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IbfVoKv5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719489220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WpnKLjyFgPP+Ets9M+udfSNPE/YG1Fx4YKF8lUJWlY4=;
	b=IbfVoKv5v8OVGaYOvyDTOvSkRIxYkezon5TUapUit8B5eJVqRP67B9qcuc8a3CQHLsU+J8
	pDcZ7sr1jsUn5yHELSxHaLc2s2Zt3P5qCcvSx73+6vSBZtYo2ijXt2JChG2NGkD3GAN39G
	EfxI+X6V3CZVB5nkDS5MXz81R8zM+Qs=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-yUBmZapMPCaWERr_w5fysw-1; Thu, 27 Jun 2024 07:53:38 -0400
X-MC-Unique: yUBmZapMPCaWERr_w5fysw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52ce324c204so4560822e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 04:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719489217; x=1720094017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpnKLjyFgPP+Ets9M+udfSNPE/YG1Fx4YKF8lUJWlY4=;
        b=PMi9z5+afZsPBiQZWbyIZyg7EJkcXaOol/NxtAKnQTB+movlB1SKBtQohBA1izrJSD
         UzWIwOo9B2g8N7NkfhabZ4xgg+VqMGRMWOTbjMrFtK+gdOlWz2nNDb5viyJuDagjx08Q
         6eccSkBS919mGFQO10SM91C4ynED6ixhgQiZY0isM366BmCzG9XlevvoBo3SFdQgJ3iw
         X3RhEfCzmqEdy11WpdoHdk6a2Zrxdz2+4cBiTNR/gqrOvh8QmIX5P5QvGRY2xImI4zWI
         nBkz4dG5geu7Ke6MxyVpRuDDKexLOn46ZIbu3XNMMJci7vt2ehq//gGITtzluQy0edzz
         NOpA==
X-Forwarded-Encrypted: i=1; AJvYcCXJR7kLqZzNnHH7rM6XDVzQWthFoIb0d7HCSODjJ5TW/YqDYYwi6++0M6w6SK/jEkkpL0RUTm/MutT3cvwJVRHWGsy6CzgucUNKertW
X-Gm-Message-State: AOJu0YwRJPdkb8D/oXxOFd9DrESmKVDj1IeUtBsIsOcVRt/yepC14ulm
	9j3G5AthpIwOcuBxVCwXzMX2AwYAZf3u4hV6YYnrgXCa8OP5gcx3HiSqBrrXx/7iFvvehBq8QLh
	dxCnNHp67vYN8mg2QvLpIOF29aFGz9bxxseH4dJtsQWoRetfGf0WwP2q/noQqcAniV7tQu4alRb
	vXiKt4sSvKaaY5EVMZCekMmhWDJKoW+m42QqHl
X-Received: by 2002:a05:6512:3e24:b0:52c:dff5:8087 with SMTP id 2adb3069b0e04-52ce185f998mr10037870e87.51.1719489217129;
        Thu, 27 Jun 2024 04:53:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVZkch36jx3t2rXBnTt/tJtT34J4upClKCoBSCjCIfxSyDf5KG5q2i5WyOx4vaWFRZaf6v+qOWumAAXaDaRXM=
X-Received: by 2002:a05:6512:3e24:b0:52c:dff5:8087 with SMTP id
 2adb3069b0e04-52ce185f998mr10037850e87.51.1719489216776; Thu, 27 Jun 2024
 04:53:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624095902.29375-1-schlameuss@linux.ibm.com>
In-Reply-To: <20240624095902.29375-1-schlameuss@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 27 Jun 2024 13:53:24 +0200
Message-ID: <CABgObfYxZZdwe94u7OvHPUx+u4fDEJLnBEQbk1hdYs_Zy0D2hA@mail.gmail.com>
Subject: Re: [PATCH] s390/kvm: Reject memory region operations for ucontrol VMs
To: Christoph Schlameuss <schlameuss@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 11:59=E2=80=AFAM Christoph Schlameuss
<schlameuss@linux.ibm.com> wrote:
>
> This change rejects the KVM_SET_USER_MEMORY_REGION and
> KVM_SET_USER_MEMORY_REGION2 ioctls when called on a ucontrol VM.
> This is neccessary since ucontrol VMs have kvm->arch.gmap set to 0 and
> would thus result in a null pointer dereference further in.
> Memory management needs to be performed in userspace and using the
> ioctls KVM_S390_UCAS_MAP and KVM_S390_UCAS_UNMAP.
>
> Also improve s390 specific documentation for KVM_SET_USER_MEMORY_REGION
> and KVM_SET_USER_MEMORY_REGION2.

Would be nice to have a selftest for ucontrol VMs, too... just saying :)

Paolo


