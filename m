Return-Path: <linux-kernel+bounces-338167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D2D985437
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A214285912
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528DA15667B;
	Wed, 25 Sep 2024 07:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quR6G069"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D8614B950
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727249578; cv=none; b=DdA2tt0ZN1CrHQlRG8nq3pJgAuIrS+hPiebsBhGNrgTPIN1deX2z8uMWAp1KhUzpKGrD/Zud73g79JV3o8yuK2dGjlkKVf/yJ5mEXq/p1fL5rcLV6X6CB3l/tY8UQZ5VzZuY0rom/lYUN8i//h8juhlm2i/8Ek980CiFIqHrDbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727249578; c=relaxed/simple;
	bh=AtqSt6iODFs/wkU/c1FCnNaPM9X0N32dQ/Eiwhzqvb4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DwIZbEvT44wFUl237wtcPzYoNkXjrNdGwZPxwV4KyIkTD7kIQKnmyuckCLPTG8AxbOBZSS7PRogrWJ6yAnAW8iDX5lFlsumEafEmSUSgr2IihoVXwLb0RxS/fi1YpkhvdBgSrEQet5IWMkXnSjj6i4XRkrVKoKMt4KUO3k0Oo/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quR6G069; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39B2C4CEC3;
	Wed, 25 Sep 2024 07:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727249578;
	bh=AtqSt6iODFs/wkU/c1FCnNaPM9X0N32dQ/Eiwhzqvb4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=quR6G069Xt6tN2WI9D20M4Dt6UMDedqLTUIGYgI6MZEJtnBX4OoIDg6A37Ty7p6gf
	 Mt3mg7v4ynWhYkRmIO4bsMQjywI51z14nkNbHa+Ggee/ym7A297qovlKb29ImjkY5Z
	 pU1w/p2xdpG5mLNfYAKVpPrfmTEV0o1Wz/iFy5eK0x+lKedSzb8Z1E55wAPh2qNwrs
	 xrNYXYgxZeaiZRyjvJoz/yTrgP3WIi6xJt/AU3M8givXrgg6d35hUtmRjq/SuzhoOq
	 2ft3SiJdoTBUazOjKNVPqC5rwGDykozRdoxZMyBnm8Ism4JwEZIxhnY5+yL5qtzQgQ
	 2gofeVQQULncA==
Date: Wed, 25 Sep 2024 09:32:53 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v10 02/21] acpi/generic_event_device: Update GHES
 migration to cover hest addr
Message-ID: <20240925093253.758d4064@foz.lan>
In-Reply-To: <20240917140146.56c9d581@imammedo.users.ipa.redhat.com>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
	<bed4b2da51e0c894cc255f712b67e2e57295d826.1726293808.git.mchehab+huawei@kernel.org>
	<20240917140146.56c9d581@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 17 Sep 2024 14:01:46 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> > @@ -354,13 +355,13 @@ static const VMStateDescription vmstate_ghes = {
> >  static bool ghes_needed(void *opaque)
> >  {
> >      AcpiGedState *s = opaque;
> > -    return s->ghes_state.ghes_addr_le;  
>                             ^^^^^^^^^^^^
> another thing, perhaps we should rename it to 'hardware_errors_addr'
> to make it less confusing 

At the cleanups, I added a rename patch. I opted to a shorter name:
	hw_error_le.

Thanks,
Mauro

