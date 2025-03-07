Return-Path: <linux-kernel+bounces-552073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2737AA5750E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17AE77A71CF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED648258CFC;
	Fri,  7 Mar 2025 22:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cw+7BQBe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D7B258CD7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741387327; cv=none; b=RzL4csPDV4E/O5VX3QGX4kzI2SgZqwnZSRRxTDurjZZs7ZeJuOliVt5URaySyqpxGWbArvuJQz5dSV5eauGvTQbSz8TF7cOfqe4nIhbR33n6gkcKSH+0BvzVH8q4Co2b9trfPi98Wh0pKzhPMRkUAbdd3jx/+LrlvWejbIZ8eUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741387327; c=relaxed/simple;
	bh=QbJVwK7yIplBFiKYa4/igotSC0EWBBnFNF1lNEacZeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhXoKo2VWa/qreJ4iJdhv1YTudvNmWA98ezcadRIC51leUKOIhYexXbGda5dF0rK7ScpNhyzwlhcC04BHIyaeV8easiC3+Wt4jVAF7vngL6RqXfPepSY2p+coECj0Rh+v3UYdrU+sRJHob+w/8kVgUOM8WjsTS1tuN4Agz+HfRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cw+7BQBe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741387324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lDGwdwGPb9qTBerw8cjE5pk2Lbp1bTzvxl+acBBp6AM=;
	b=Cw+7BQBeIRV6hSU9SJNp3frQqIp9mToKd4KCasYHetCaBzKvLDigFzTTHXKCB1NSBWmQXR
	qZuNJON8Ly4vHfEJfWFWkWOj2wyJXRsz1TDDUtp3tUrO7zUDyeZaxCJbiNl1WVavEMIrEe
	K0jVHnd+3JA1DD0oBbdFr0aZA0SLDQk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-gLg_K2pMNe22Ulk216Kckg-1; Fri, 07 Mar 2025 17:42:03 -0500
X-MC-Unique: gLg_K2pMNe22Ulk216Kckg-1
X-Mimecast-MFC-AGG-ID: gLg_K2pMNe22Ulk216Kckg_1741387323
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4751b401c37so43841681cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 14:42:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741387323; x=1741992123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDGwdwGPb9qTBerw8cjE5pk2Lbp1bTzvxl+acBBp6AM=;
        b=q7HC8exnIPnm/kJUY41QELs1NqBGyuMt4MvTRtOefanNJHm/vs8UF9SuFMOWXmFFcq
         E1Kz3BcbWMgQaRubmSbKWVegws0LaURgamd8JoubiFuB5BxwTuM0bWUhOlQj8z+RvBxB
         RRsJY0yVr+aN3KB6bsvOc+akHdA7Ny0JuBzGrRwmgDiVaUILrj7FvKD0luP31E7jyZll
         aUJKxCC5CuDyd6w1p2TpMJaOBjTJ9SztZI8Uk6KmM/9lxmkfknhDoiZ/1n8HzDec/pC3
         B0Z7Zc79IWNGCZJz4rZmbGz/O/0bDlUihmLdEfYmYI7mBM+tPC+sIknhXpgMzk8xOxP+
         WYjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXs261IBP1cUYTZLDC6TXMVfJmPEYedglbwl8tZJrYUrsYGdAcoQIiBr+Atv4HEQvaC3mkY8krenK1+5pw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4TIWbO9zS7TSwIQt0+0slUwLZb1sK1daovFbbUlNvWBtvHgrS
	m6zA/b4dWqCHpG4hL3yloKGpnh1tuuFUwg6MIJMIyTvZZBO+9340uPkXFT/BHbrWmcaJU2bRpQ5
	/SUaQCVawQbrm87Wj3O+VA/CCyznrEYQnn2GaxL/5hOV2sZc/DxVVViSnMVq9pg==
X-Gm-Gg: ASbGncszFBSpLucd+S3qhxO2sVuHZg36T3laO7Umk1hXO6ky+SBiaRiQpZAwVzyWjKk
	ddykIkPUPJudb8sY9qt5VhBUfoH3yCssL6iSNJiE+HBYoh+LPZ8PpJWAG2fx3cJjiqdAuIJWpcL
	cgSr0Czf/3lF71LYxJ2a1zo/TYOoGCAGHEKervwNNefQ669NdI2YF/0SlmCaHXDO304KNv6lH0I
	FVBekFs71w2wlFmaPRnZ0LJB5wiVheJ+w+3Bu/Q45/ISpt08VEgbxN3ucZbqEG0zmXQl0tDCKoZ
	71GdyV0=
X-Received: by 2002:a05:622a:5e8b:b0:476:6215:eafc with SMTP id d75a77b69052e-476621612ecmr15952151cf.22.1741387322982;
        Fri, 07 Mar 2025 14:42:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGR8lVl/s+4EWWT/wvvD3qNU2PvGL5/xU3ZWoqR1iKynkdv5g8/8qA4/93Pss+bseIKro2zWw==
X-Received: by 2002:a05:622a:5e8b:b0:476:6215:eafc with SMTP id d75a77b69052e-476621612ecmr15952001cf.22.1741387322707;
        Fri, 07 Mar 2025 14:42:02 -0800 (PST)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4751d96f525sm25205451cf.21.2025.03.07.14.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 14:42:01 -0800 (PST)
Date: Fri, 7 Mar 2025 17:41:58 -0500
From: Peter Xu <peterx@redhat.com>
To: jimsiak <jimsiak@cslab.ece.ntua.gr>
Cc: Jinjiang Tu <tujinjiang@huawei.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
	linux-mm@kvack.org, wangkefeng.wang@huawei.com
Subject: Re: Using userfaultfd with KVM's async page fault handling causes
 processes to hung waiting for mmap_lock to be released
Message-ID: <Z8t2Np8fOM9jWmuu@x1.local>
References: <79375b71-db2e-3e66-346b-254c90d915e2@cslab.ece.ntua.gr>
 <20250307072133.3522652-1-tujinjiang@huawei.com>
 <46ac83f7-d3e0-b667-7352-d853938c9fc9@huawei.com>
 <dee238e365f3727ab16d6685e186c53c@cslab.ece.ntua.gr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dee238e365f3727ab16d6685e186c53c@cslab.ece.ntua.gr>

On Fri, Mar 07, 2025 at 03:11:09PM +0200, jimsiak wrote:
> Hi,
> 
> From my side, I managed to avoid the freezing of processes with the
> following change in function userfaultfd_release() in file fs/userfaultfd.c
> (https://elixir.bootlin.com/linux/v5.13/source/fs/userfaultfd.c#L842):
> 
> I moved the following command from line 851:
> WRITE_ONCE(ctx->released, true);
> (https://elixir.bootlin.com/linux/v5.13/source/fs/userfaultfd.c#L851)
> 
> to line 905, that is exactly before the functions returns 0.
> 
> That simple workaround worked for my use case but I am far from sure that is
> a correct/sufficient fix for the problem at hand.

Updating the field after userfaultfd_ctx_put() might mean UAF, afaict.

Maybe it's possible to remove ctx->released but only rely on the mmap write
lock.  However that'll need some closer look and more thoughts.

To me, the more straightforward way to fix it is to use the patch I
mentioned in the other email:

https://lore.kernel.org/all/ZLmT3BfcmltfFvbq@x1n/

Or does it mean it didn't work at all?

Thanks,

-- 
Peter Xu


