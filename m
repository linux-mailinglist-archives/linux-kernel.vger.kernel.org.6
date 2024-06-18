Return-Path: <linux-kernel+bounces-219233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9780990CBB4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D633A2838CA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AC313A896;
	Tue, 18 Jun 2024 12:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MB5lAJvf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AFC136658
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 12:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718713734; cv=none; b=UzwIngcsx5bQrp90I0fRNC7i97CWeuNqvW71uN/UgCmI5gCM2MZhG1NmwxmqDAG4a9iauAkzXNfUHOBXR7InVB+Gmb8g1KRzWsm+aYV6pnPdIL85W1b9t96Hfu0RC2v/jcyxIpan6Ktu8UDY5rXxDTXPvHyzLWd/BBrnZymNFYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718713734; c=relaxed/simple;
	bh=59k1eVPPNbUMHgUvagtmlcypZxF8T5i8OLolmJA2xfI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SH+0CcvZNjOYw3cp/Fvozf5DxGs+FoCN42bzM4g51t2UHZ8l7aRHMfv4docKDOG35c0aqmLq5fZE7sEPggS8VdDyV1Gr4x4PdbIQ2EITPG+7BgyYffUCBfJIUExQxYwaM3J+ZU4d0HRtzNM06JP+8djeWs6cdpANYlQtE19r6pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MB5lAJvf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718713731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=utFm1SB1+eNq6POAWEcWhhC7RWyydhXQ88o1CCnb7PM=;
	b=MB5lAJvfOUQTZKdtVcVa0YDEYA+32HXZs0Y/y92ncROcPYF3mL3eyUj5fwGMPoJPKDRgV0
	s7Vq7co7/EXRQ2n1yg8FutClTmAKyiAKYFvJRyYme2dYCOdhzJE2nJM0+aEn21xC1zhlz8
	LnKXawikuN4E8EMH/zeJNXfLn9U7AG0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-O1mZ8eShPCWigNMhv7jmMQ-1; Tue, 18 Jun 2024 08:28:49 -0400
X-MC-Unique: O1mZ8eShPCWigNMhv7jmMQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3625503233eso265594f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 05:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718713727; x=1719318527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utFm1SB1+eNq6POAWEcWhhC7RWyydhXQ88o1CCnb7PM=;
        b=kWhNqoDDFdZlnvdUJ+f+2H6dUs7zo8nHGCULAMLlh+ecJa+PXQpvdJ2C0AcOme1dwk
         slDD4vYWoFZV+bRgk3ScD6Xy1T8cAgpt9vfjwh8ON5FY29s8z94GEA8LKbUBULRcs7it
         ofe0d3LdjDPjH42823a9q2QR2HtflFI9wlgc2uzYTpktusOfCGIBa+N9ezVya0YnhVXe
         9qicchUmx2y5RjWF283/wsldOe8xuFxN3Op5agAXUz3KKkX/Z12n3/gGpmkn9mBaKnFB
         /BERAJEA3HUndcDcuza7yljy4TNJ8hjsyVT6mpDr6Uy7fsOv4tj1fAnV+RGMc4Y/fEeO
         pDsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8zvC95mtEVELXaB1pmvIEjjCAPIZCPXYOPR8AGZsoOZ8S942i9NtiXnmGX/PM/5dhTbiIXCjCns61ajWkskf4oqjumsLOsh5cKc7g
X-Gm-Message-State: AOJu0YyQcR1PlCdKDU76hwMy4DLLNG/bKrgF5GIk4ZKNIYOvFEC9Gm5s
	UqC35XGdoALg9XyZQCCAy5p7UG+32Eac6+EnKMuGFQ8QDeK8a+HVdxo8IRI8yDKE1KuQ+Oi0U1y
	baR4HTj2Q9ZVuoAub5TbuCA0BwXu7tBkDJM6MwKBOr7NngkBl5PpRhxNEjBZk5FLSOv0YXA==
X-Received: by 2002:a5d:4412:0:b0:35f:105c:50dd with SMTP id ffacd0b85a97d-3609ea6155fmr2275333f8f.12.1718713727748;
        Tue, 18 Jun 2024 05:28:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsgRr1Yq8bIeFVs1TcoHGfRbVOTFjV7hrI8nHmrT2KhJ3GpaAJCryVzg/OrwKZri4CQIFYkg==
X-Received: by 2002:a5d:4412:0:b0:35f:105c:50dd with SMTP id ffacd0b85a97d-3609ea6155fmr2275319f8f.12.1718713727414;
        Tue, 18 Jun 2024 05:28:47 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075104b8bsm14062230f8f.105.2024.06.18.05.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 05:28:47 -0700 (PDT)
Date: Tue, 18 Jun 2024 14:28:46 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, yc-core@yandex-team.ru, Sean Christopherson
 <seanjc@google.com>
Subject: Re: [PATCH] kvm_host: bump KVM_MAX_IRQ_ROUTE to 128k
Message-ID: <20240618142846.4138b349@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240321082442.195631-1-d-tatianin@yandex-team.ru>
References: <20240321082442.195631-1-d-tatianin@yandex-team.ru>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Mar 2024 11:24:42 +0300
Daniil Tatianin <d-tatianin@yandex-team.ru> wrote:

> We would like to be able to create large VMs (up to 224 vCPUs atm) with
> up to 128 virtio-net cards, where each card needs a TX+RX queue per vCPU
> for optimal performance (as well as config & control interrupts per
> card). Adding in extra virtio-blk controllers with a queue per vCPU (up
> to 192 disks) yields a total of about ~100k IRQ routes, rounded up to
> 128k for extra headroom and flexibility.
> 
> The current limit of 4096 was set in 2018 and is too low for modern
> demands. It also seems to be there for no good reason as routes are
> allocated lazily by the kernel anyway (depending on the largest GSI
> requested by the VM).
> 
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>

LGTM

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/linux/kvm_host.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 48f31dcd318a..10a141add2a8 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2093,7 +2093,7 @@ static inline bool mmu_invalidate_retry_gfn_unsafe(struct kvm *kvm,
>  
>  #ifdef CONFIG_HAVE_KVM_IRQ_ROUTING
>  
> -#define KVM_MAX_IRQ_ROUTES 4096 /* might need extension/rework in the future */
> +#define KVM_MAX_IRQ_ROUTES 131072 /* might need extension/rework in the future */
>  
>  bool kvm_arch_can_set_irq_routing(struct kvm *kvm);
>  int kvm_set_irq_routing(struct kvm *kvm,


