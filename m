Return-Path: <linux-kernel+bounces-368870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4519F9A15E1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5215F1C21725
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2686D1D45FE;
	Wed, 16 Oct 2024 22:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="wr1xkzLI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876801D279F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 22:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729118668; cv=none; b=ghoviZBdrDLeTdxhQ2NtrvY2uVDRgljEAqZhT0nUDk8gpZHcxBnWBC1ZjCYa1+bf9bcCDTJVmYKlV/HYmlsaSNYI5UPAHyPZFN8PPxrCzsKgTppG28Trkr3qCrO7aiD2r4rzrhXZOSCMWe3SxFTsFMBMfm2IDs+Cq2hlyDQs29I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729118668; c=relaxed/simple;
	bh=BLSdDUXmAvvkg/ODHeQ0Us7T1GvzPnf6FLS3oIfzUaA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=E97qtVyeIzDCH15KkQpZpLotmOxJ2Qey6btYN4VloJyRZ5eUIBPKu4DM0DgNotydx/d0+qVGu6Dky41A+DfUm2yRbPBMtI63DxwE4//zwmPGNhFasrW7AWTd9yxw+yRJPB5AdU//kHafWI5YC7TlGiZGwH6N8AJuyMhNt2V13Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=wr1xkzLI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFABCC4CEC5;
	Wed, 16 Oct 2024 22:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729118668;
	bh=BLSdDUXmAvvkg/ODHeQ0Us7T1GvzPnf6FLS3oIfzUaA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=wr1xkzLI/AASHJrsd4eVLYSG4xhWVUGeQrndEJSmbi7vZ0C5YnXbpeTX2FngsSV6f
	 jVfp1t2p9JnLUZVFaqaFh7Y+eRM8UjlVq5ZanrDDx0jYiK6i4ygbwE/GpawnGDVJCU
	 RH+fntL+SN2yTdKSynyQzNOafu4TEEPHierlByBU=
Date: Wed, 16 Oct 2024 15:44:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, syzbot+7d917f67c05066cec295@syzkaller.appspotmail.com,
 Jann Horn <jannh@google.com>
Subject: Re: [PATCH v1] mm/pagewalk: fix usage of pmd_leaf()/pud_leaf()
 without present check
Message-Id: <20241016154426.8d946e3e4f94914a860bd7db@linux-foundation.org>
In-Reply-To: <0436c217-0afc-45e6-949b-2291ee1ebc6e@redhat.com>
References: <20241015111236.1290921-1-david@redhat.com>
	<4898fdf4-7c88-4697-9df4-64fd8a900e95@redhat.com>
	<c364015e-ab37-411d-b2e9-4e7b10effdf5@bytedance.com>
	<0436c217-0afc-45e6-949b-2291ee1ebc6e@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Oct 2024 13:05:54 +0200 David Hildenbrand <david@redhat.com> wro=
te:

> >> [=A0=A0 54.372227]=A0 do_pages_move+0x1c5/0x680
> >> [=A0=A0 54.372972]=A0 kernel_move_pages+0x1a1/0x2b0
> >> [=A0=A0 54.373804]=A0 __x64_sys_move_pages+0x25/0x30
> >=20
> > It would be better to add this call stack to the commit message, which
> > can help people find this fix patch when they encounter same problem. ;)
>=20
> The commit is not part of a released kernel, though, and a lore search=20
> would return the result until it's included.
>=20
> Before it's included, the commit message won't really be helpful :)
>=20
> But sure, @Andrew, can we include that in the commit?

Done, thanks.

