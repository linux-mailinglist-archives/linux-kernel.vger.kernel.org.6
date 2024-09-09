Return-Path: <linux-kernel+bounces-321546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D59971BE1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2921F233E9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD161BA26F;
	Mon,  9 Sep 2024 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UpmeDKDD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C8B1B9B45
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725890148; cv=none; b=h6CaQpuybqaca3QpB4YoVvMildPzRmIGAsPua3BpRYQYswvJd4RyrFxW7HFI77hJUFUUy8l9CVwpkLFvMTzj2chQaa4sK7XWwXwT3FSaVh0N2jvWdX/t6Lxo9EgZ/TF0HEcKwZg3R+ACvo6aJqCCstVSeGfy0RGTwflu/r0QJu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725890148; c=relaxed/simple;
	bh=DBSqSKKZCT86Ns+OwHm8+kGgzIhmdP3PE7fnwZ2cnSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjMGZe8A7UeP+EGtSf8KBItRlFxn/PnRFCHJ0N7uFzU6IlKv7WczxRcHxFWDiBtP8DdM3jhGL+1YQARI9wqmwmYu0iRcvZc4JlF5FSeU8lZR6dAaXLY3V8+O7mRhFCHqJtf6jNaiTrL92ioILu1nMm57BOPLnzEOc3Iut4qzld4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UpmeDKDD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725890146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=phI90hKtthNRNf98RPRiQsc1bPNjYM/u78Q8gnoGCn8=;
	b=UpmeDKDDlprjtQyy1a1fYdvIWuW7FEbNlwGrcs11Dn7BGfybkfnJn31Q25Ltl+i4JBKYDm
	x2etvEh/QyfpjQB74KEF5P5Z/ulguUVs4yuHYn2SHcDebYbpd7Y7UOm9rVpRE5+kBBciik
	PAe+fUpVPiDY+v++BI03MwV+iXuX1w4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-uYpqIaFfNsiVcbXIuW_tTA-1; Mon, 09 Sep 2024 09:55:45 -0400
X-MC-Unique: uYpqIaFfNsiVcbXIuW_tTA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6c36e60b5f9so59540126d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 06:55:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725890145; x=1726494945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phI90hKtthNRNf98RPRiQsc1bPNjYM/u78Q8gnoGCn8=;
        b=BzkkDHg6Bm6li6o5HvCsQf0OIBE+PYQSxFHljecQpk1QLOwKHLbGj6xRfe0dcNDqC2
         rU4PN/a5KMBvpXnhRHxZTZ6RAMTt5bGJjsVl+pochfSd6zALzUT8Sb9ok25H1fyVU/ev
         dGIq1OrWX2I/jXHFHsBUQZN7nARsAt+CQ9kMI2WmKm2dTq6KL4hp5762qiBRFu+1xoeP
         pFWifYmU0DUJbR9Mf/X+THMVfetAltfsSosn3wch31eicJXwHhrngFBoYsU9ucE+8hjR
         xaQi0HzlK1lo/FbysEXXck2o2mEwbx0JS6St2rm/JMW3Lq4AG9AP1QqquFfwnNkFQZf0
         kqzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC+5vMXV7SDfxtVjOdXmrsheIabRNw7SGUIuaPJliYUgR/uwsasRDw39XA3qHR6mmhPtolOPRGAz7nS+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA+SBaZ4hhpv9YJRN1oEeQgREXQ+WaciVADJLDhNO2aSMo4ogq
	oX+dyR0AlsGjQ16/rZaN6jOf1Kl5tjuQv6mQJ3MVt6KYMYVpooWZDzr3wk2wUOZ++uxTbWJQT/h
	C0XoLVAv1o2toVHhDfrulZrttsVpgkRzUunDZCoOMMOQ2DteHeCjQVSTx+fsI3A==
X-Received: by 2002:a05:6214:1843:b0:6c5:2a13:b8e1 with SMTP id 6a1803df08f44-6c52a13b9c5mr96954356d6.43.1725890145004;
        Mon, 09 Sep 2024 06:55:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQcseXYtQRpNWe4UC31AKTYj4V8OS7K7G0X+aaWgh8qtUW96w7rIdRupRfllbFa2yALO/OQg==
X-Received: by 2002:a05:6214:1843:b0:6c5:2a13:b8e1 with SMTP id 6a1803df08f44-6c52a13b9c5mr96954066d6.43.1725890144589;
        Mon, 09 Sep 2024 06:55:44 -0700 (PDT)
Received: from fedora (193-248-58-176.ftth.fr.orangecustomers.net. [193.248.58.176])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c553803dd6sm940686d6.14.2024.09.09.06.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:55:44 -0700 (PDT)
Date: Mon, 9 Sep 2024 15:55:39 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Steven Price <steven.price@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	James Morse <james.morse@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Joey Gouly <joey.gouly@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Christoffer Dall <christoffer.dall@arm.com>,
	Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev,
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
	Gavin Shan <gshan@redhat.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	Alper Gun <alpergun@google.com>
Subject: Re: [PATCH v5 12/19] efi: arm64: Map Device with Prot Shared
Message-ID: <Zt7+W56+dKhQl7GG@fedora>
References: <20240819131924.372366-1-steven.price@arm.com>
 <20240819131924.372366-13-steven.price@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819131924.372366-13-steven.price@arm.com>

On Mon, Aug 19, 2024 at 02:19:17PM +0100, Steven Price wrote:
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Device mappings need to be emualted by the VMM so must be mapped shared
> with the host.
> 
Typo. s/emualted/emulated 

Matias


