Return-Path: <linux-kernel+bounces-275734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDCB94892C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D6E91C22717
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 06:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C35A1BC9F5;
	Tue,  6 Aug 2024 06:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSzKUNwy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509E91BC9ED
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 06:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722924574; cv=none; b=gkl61hHB/JvjZoEyXOGRRJAy1WM/ifXAfCD7N0YYKlkncekfm6a4+KwWskk2Z63x08Uf6hLBvim+c8qajBz+vv4L1ehS1ASYVBBAzjIvZO+u+z2Ak0Y0ogxf4la/j2U7W0ka/MRBnPZZu/1qyYDv4yxW6QXigzOtu6eivJTUT5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722924574; c=relaxed/simple;
	bh=WdUQXtCTwgFQAc0kxtSdRM0UmI9ZDfDvqTso1AuHq4I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JdXteDFBvAQRpYE7AakaekUK+XahqMM+QJ6o3az8UnLvat69WMt9lg5bv4v9O/4flnjNh5cXS6eWj6iCyIv991Ab3f7qdaIG6wqacL3iZ8aG1Sp90Wc9vIMmEyh2lY7cOH3MeU3UKNVQguXQajQHt3ANdXcNfgcNBUT9N4vSNSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSzKUNwy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38BAC32786;
	Tue,  6 Aug 2024 06:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722924573;
	bh=WdUQXtCTwgFQAc0kxtSdRM0UmI9ZDfDvqTso1AuHq4I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OSzKUNwynmDwBT77gK1GM8p0fXbTxR0IULEdL5T9b0U6fy5Wg7cEisPBWbUQfnU96
	 5cBgNyFVd2YfbHFKQKNyGXnCvPSiwpUGha9dg8wKTayJIr6v/8PbISV7TTWc28u/Nz
	 shI24RkQqr/yU+uwSlSu08flS36BB4zVcjohiOkj+uW3HaL0tsle4I1HE3sBMkZ2oK
	 sUPd5MdB0/YWgDOBmyXnVWuaLq1BqV2lPAUJS08OekqOPsH7uvBKNx3dkXqn5IoZ58
	 hGEmH/2+RRIXH2/03lY8o05eNxSLar7nC6ds2cLA82CsSLf4xjPlv3FbvercrK/bls
	 8BuzLx9GZb2bQ==
Date: Tue, 6 Aug 2024 08:09:28 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Shiju Jose <shiju.jose@huawei.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 <linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 4/7] acpi/ghes: Support GPIO error source
Message-ID: <20240806080928.5a04c550@foz.lan>
In-Reply-To: <20240805175617.000036ce@Huawei.com>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
	<5d53042ebc5bc73bbc71f600e1ec1dea41f346b9.1722634602.git.mchehab+huawei@kernel.org>
	<20240805175617.000036ce@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 5 Aug 2024 17:56:17 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:

> On Fri,  2 Aug 2024 23:43:59 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Add error notification to GHES v2 using the GPIO source.  
> 
> The gpio / external interrupt follows through.

True. As session 18.3.2.7 of the spec says:

	The OSPM evaluates the control method associated with this event 
	as indicated in The Event Method for Handling GPIO Signaled Events 
	and The Event Method for Handling Interrupt Signaled Events.

E. g. defining two methods:
	- GED GPIO;
	- GED interrupt

I'm doing this rename:

	ACPI_HEST_SRC_ID_GPIO -> ACPI_HEST_SRC_ID_GED_INT

To clearly state what it is implemented there.

I'm also changing patch description to:

    acpi/ghes: Add support for General Purpose Event
    
    As a GED error device is now defined, add another type
    of notification.
    
    Add error notification to GHES v2 using the GPIO source.
    
    [mchehab: do some cleanups at ACPI_HEST_SRC_ID_* checks and
     rename HEST event to better identify GED interrupt OSPM]

    Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Regards,
Mauro

