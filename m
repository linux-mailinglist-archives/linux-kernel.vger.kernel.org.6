Return-Path: <linux-kernel+bounces-250080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DDE92F405
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 04:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D1128383E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 02:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487CC8C1F;
	Fri, 12 Jul 2024 02:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kcAxDQ5D"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422C9C8C0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 02:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720751397; cv=none; b=bfCXXnrVDBHQIF1riby6XfFxda+CfqWZWKwMGuWEWE+7UcI1lLSLnmqWKqEvET3qr5aVVnNLOz/FkgTHyKm6dyc4fjf1etcpCaePMenqf9v/ZIMwGlpb6snI4FHR+L0F+y8vZz1IYannKBENi6P83VCGqgKSWTZXKNPvI9nQEx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720751397; c=relaxed/simple;
	bh=iGvMHNFrVrtuVJGtAwOd3TSqeeyJS67441wBp4VhuU8=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=HiVoSwTsLkKAbdmQzmod8IfbH0H+3fgZUiLCdiQWcy5ft8lJxtxDZv598SOppdV4Uy/Tq1wQVpjJG+VUOkdr14fH+QUQeMUQuBvv4us1+NDKxgifz7SJPSTBKqL3YDEilVggeyVTbH1Hr++C6PXjEmfh/zmcWp6DWToOjZsZCnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kcAxDQ5D; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: willy@infradead.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720751393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cqGt6wfRotjMw1Rxo2bsfyZM2cjm85hVKvptBJmS+/g=;
	b=kcAxDQ5DOfSEDmTkCsMONeCP8HRjaaAAIreIlMUx3/vu4XwgNFo6v7TVyhcKYnrHoZbKZB
	OlZV1UTILVmPTYDZQABulsGbdLecpFMNFMkLLfPFTZZ5mUccRVM6VqpTUOl0MgqJpi8qH/
	W+jNLuxoaUK7eTSbpAqLatqmI5xB6LY=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: david@redhat.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 12 Jul 2024 02:29:50 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <66e43c92d3b4ecfff50e84bdaeedfad3aa477df6@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] mm: unified folio_test_anon()/folio_anon_vma() and use
 them
To: "Matthew Wilcox" <willy@infradead.org>
Cc: akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <Zo_ZULOseAmEQMIw@casper.infradead.org>
References: <20240711130351.2830-1-yajun.deng@linux.dev>
 <Zo_ZULOseAmEQMIw@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

July 11, 2024 at 9:08 PM, "Matthew Wilcox" <willy@infradead.org> wrote:



>=20
>=20On Thu, Jul 11, 2024 at 09:03:51PM +0800, Yajun Deng wrote:
>=20
>=20>=20
>=20> +++ b/include/linux/page-flags.h
> >=20
>=20>  @@ -691,7 +691,8 @@ static __always_inline bool PageMappingFlags(c=
onst struct page *page)
> >=20
>=20>=20=20
>=20>=20
>=20>  static __always_inline bool folio_test_anon(const struct folio *fo=
lio)
> >=20
>=20>  {
> >=20
>=20>  - return ((unsigned long)folio->mapping & PAGE_MAPPING_ANON) !=3D =
0;
> >=20
>=20>  + return ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) =3D=
=3D
> >=20
>=20>  + PAGE_MAPPING_ANON;
> >=20
>=20>  }
> >=20
>=20
> This is wrong. KSM pages are supposed to return true for
>=20
>=20folio_test_anon(). I haven't looked any further at this patch, since
>=20
>=20the premise appears to wrong and you clearly haven't tested.
>

Thank you for pointing this out. It was my mistake!

I think I need to add a new helper function, like __folio_test_movable. e=
.g.

static __always_inline bool __folio_test_anon(const struct folio *folio)
{
        return ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) =3D=
=3D
                PAGE_MAPPING_ANON;
}

