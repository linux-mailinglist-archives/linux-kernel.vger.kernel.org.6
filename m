Return-Path: <linux-kernel+bounces-300243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B79A95E0F7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 05:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33DFA1F21C97
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 03:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5152222301;
	Sun, 25 Aug 2024 03:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cU9m02+Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E4022F11
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 03:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724557711; cv=none; b=oSe/I9pXbvsezmNqwPFalhV+EmkXq6LqfTCIYu5EBn2uBZpWL78HQaTXaRnso5USsvtBbJIHlxANdQypGGjLu0VdaqG6gDr8Oea2nqInbCJ0p1/prOHXIwlAhEu/k1zo5+f7LVxa8Ujm6W3kOZsrGqSFv19K97cBoRkTPSpB2gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724557711; c=relaxed/simple;
	bh=wYgVuEohUFvuJR7BKrYMXwPNC/z0NyGx+4ELX1Susf4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iWlSdTZ6Vj2toQ3EwNrDM1R8jOR3W4bx7jg9H/trz6gArdfBjp2ukGul0SQeK+EVGPWBUSWoVTTGVrNGjMV3tRPonu66jbdkcUbBn9Lsi3hJa1Mx8cA2N1dTMdasZzq8ld0RZ+xJJtatLVTkUPslGxGoipaZ3vO4neSrixTAtaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cU9m02+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D72EC32782;
	Sun, 25 Aug 2024 03:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724557711;
	bh=wYgVuEohUFvuJR7BKrYMXwPNC/z0NyGx+4ELX1Susf4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cU9m02+Q+n9ZugrlSKrJO3kJq9i/EDGjwYHvvSXjDN6St7fDBdNzFeg2kTNP7eXpQ
	 PaGvOKE+ladpOqXrfG1yDUHWw3b/gTnwP7jdSfWHYJIuVNT9i2Z+UvXJYryyssTTu8
	 5IWGzqjwlqwOcuWlyZhUWkjf3Pp2lkDm+YqSCfIzY7FmObj3yqzWQg/HCV1Gy0vfkq
	 clvSWadtyQVDElaXntxw9pKuf8CKX90GGAmyUythIk23qoVVLs9r/TPwE0cX34BJah
	 3eS/YVBl9QgTknLHBPVfifvJ1KwPLbaBDynVKuJAU9/ZsD82V8JkJNd6ndSqkHPvdG
	 3LrgZ6IPU/L0A==
Date: Sun, 25 Aug 2024 05:48:12 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v8 13/13] acpi/ghes: check if the BIOS pointers for HEST
 are correct
Message-ID: <20240825054812.32f780e5@sal.lan>
In-Reply-To: <20240824021510.71451b57@sal.lan>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
	<52e6058feba318d01f54da6dca427b40ea5c9435.1723793768.git.mchehab+huawei@kernel.org>
	<20240819160733.464ccebf@imammedo.users.ipa.redhat.com>
	<20240824021510.71451b57@sal.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Sat, 24 Aug 2024 02:15:10 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Ok, we could still do something like this pseudo-code to get the
> error source offset:
> 
> 	#define ACPI_HEST_TYPE_GHESV2	11
> 
> 	err_struct_offset = 0;
> 	for (i = 0; i < source_id_count; i++) {
> 		/* NOTE: Other types may have different sizes */
> 		assert(ghes[i].type == ACPI_HEST_TYPE_GHESV2);
> 		if (ghes[i].source_id == source_id)
> 			break;
> 		err_struct_offset += HEST_GHES_V2_TABLE_SIZE;
> 	}
> 	assert (i < source_id_count);

This is what I ended implementing on v9.

Regards,
Mauro

