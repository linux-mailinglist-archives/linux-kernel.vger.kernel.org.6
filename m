Return-Path: <linux-kernel+bounces-277437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7106E94A170
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18FCA1F26186
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BF21B86DF;
	Wed,  7 Aug 2024 07:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfAaDdpm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFAA18D63E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 07:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723014935; cv=none; b=I/NgekwV4SnRVXKwMvUXTrKcxjGDwbJTQdoH3MJnuzfUIsFsBDG2hXorEhWeMwczIFJd/kJR6pHZpkPVmyGwfrJEVxLTTPYXQdVpmneJS+KxFHy79gfIq8KJN+nj6vmS0KRpzBmsT6XoTASPtT8ARl0Na8TiZWjVgm7kGPkdacA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723014935; c=relaxed/simple;
	bh=pK22yhBmwEV9vfaShFs7JJ+yRCbOTFQ+OLTOdkiD5lY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IzNm0BekZjPmeA3OFHZpvQVG5urwCmsE+chefQkCMSlpsuBxuJvFQdxcsWGjYjyf6BUzeejtw+BhbnGXDVHGWgNnf5onRvmLot8rXvR6cyqgB2zHq0QrEP+SkbIbl3bSziosRJ2AdNa1DlsDLJgRdYK1dQ+00/O9Ysn+mwQKG0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfAaDdpm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC95DC32782;
	Wed,  7 Aug 2024 07:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723014934;
	bh=pK22yhBmwEV9vfaShFs7JJ+yRCbOTFQ+OLTOdkiD5lY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pfAaDdpmjdfduul89ysQ0l2f7W4ME41opDHpPYg7cQztfIoMJJsv5sdsDI2yZak8v
	 hdoE8Gc6JjAlyi2rzWDXtBEzviiQ8JbVL+rBzzTvnVsNQrUjFeVC7olTq62TZCMAEz
	 8qknts1dyduj0MKngXzluxZX9X0W7ZVj5LJXLGSEf3qTu3ehT+WWRGc2e8wdAFA32E
	 3IHB71874NY5pNRk8dRHrxID7MClNff+mtzvWn0RwdSrKZCeX7YhxRScLcd+L2i41Q
	 KFTv0fgFzs3Tf7jY68jnTNnMjUdgiIQuqlCbOgP+334HGzpLTp2pAS4fy76kEGgVeE
	 s7UfExgWzznCA==
Date: Wed, 7 Aug 2024 09:15:29 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 4/7] acpi/ghes: Support GPIO error source
Message-ID: <20240807091529.0991b939@foz.lan>
In-Reply-To: <20240806113219.02ba0fdd@imammedo.users.ipa.redhat.com>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
	<5d53042ebc5bc73bbc71f600e1ec1dea41f346b9.1722634602.git.mchehab+huawei@kernel.org>
	<20240806113219.02ba0fdd@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 6 Aug 2024 11:32:19 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> > @@ -327,6 +330,9 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
> >           */
> >          build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_SEA);
> >          break;
> > +    case ACPI_HEST_SRC_ID_GPIO:
> > +        build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_GPIO);  
> 
> perhaps ACPI_GHES_NOTIFY_EXTERNAL fits better here?

Symbol already used to map the 12 possible notification types from ACPI spec.
I did a:

	sed s,ACPI_HEST_SRC_ID_GED_INT,ACPI_HEST_NOTIFY_EXTERNAL,

instead.

Thanks,
Mauro

