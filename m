Return-Path: <linux-kernel+bounces-255117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD04933C4C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1131F234BE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D35017F4F3;
	Wed, 17 Jul 2024 11:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaCZzjJb"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1413079952
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721215787; cv=none; b=UVhOo4CratR3nESfTDj2ISimoVNDwA2xpQLLnFKi7yl/PTjvkKL+0jkgV/7ZF3cq3pceUqFwtb8Od+O8qgmFNVTKp/CAi3liPEiNc7ryNR7pJcNHqTf4XM1Xm6kq3E+gq6AAZnLTPl3Vn1Pam6mhKf+OGEUO2IsCy7lmBnqveYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721215787; c=relaxed/simple;
	bh=ydPlujLHMMzd560//B9PWO2akn0bi2X/lkI/t3yjUFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RnIgLrf6jVT7aa9TG2BRi/zYgLNFagHwA0Dmf7Pas69Dmy4igNS6IHndgGRIisoC92yL/0w75nT4xLUT65grzn9mLEMCkMuH89++lt3CgQCYtRT+jIYFRqlY0NKGg+yiHGwFMi7lTtaxUBJ3QE66PNRWXywRryJmU2m9ftrV7UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaCZzjJb; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a797c62565aso682094666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 04:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721215784; x=1721820584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzVI1EFi6ALaN0XOENS1zraS9tfSh0A/9XOpn/vT/ZY=;
        b=CaCZzjJbD74Oer+EwEdmlkOxuFGevivuC2hMKn7rdhY+q8SRmBJKmDlHUNxQZ3JFah
         oVCUwzFxUKSh89hhh3Q6GjIAyKqO74Ltd34JlQmJSl1BeOBo5RAj0DghRyjkIh8clCDp
         QaW9+9KG5lEwVM7wItwYcSCgT0af4Rs9QG3NjwFJiySqHnGbZdiMZI3gMghTcrSSlkq/
         6r3yc499xagHCDk87j13GEAGagu9ZPbh6mI+Fzf7/UPPEoss62Meu0KSq7sGiS5Qq21W
         JlQ1PicIeaVSFLrDfGRlEFTuJ7eiFPmQgDXK+Y89IbyFb+DZqbOa7KOSHgVV21V//byl
         yW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721215784; x=1721820584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzVI1EFi6ALaN0XOENS1zraS9tfSh0A/9XOpn/vT/ZY=;
        b=ZCz9FlCWYje+nGHWrFoigDTD+wAfzKpJj6hSpdqyfKY9hpa1lOue9c/hyQPL5NvUcJ
         HaKM338JrafUq+eKkoaNoNI7Yl2zH/0Th0Udlu8Vk95kmau0Brb5Em273WM9OiYIoMb+
         fVQ2IRRfNo2+QsAxfIe+DACDzbAWOkDQvdtL2dfUqz0OdUa0Dw19GDqKvyVLgRBNmmPn
         ClaOk+bYlBqe8sUcQ694vLl2HVwhF1nhyiAQvejNYO+D7NNOLOVWa7tO6bjE7Ctkk63X
         cp4uOWFQQLBM7JhiCnc7rivRj3thH2Rz2bjorbKtv8k1lr1CCL6xLoOYgJTg1ykvE6Qi
         KMwg==
X-Forwarded-Encrypted: i=1; AJvYcCXhRVeAyGxFv84H4c/n8zaaIzr/QEzBX/6np7ktUj24Y4xjXGoIdIWzFK1W3neSkQMtX3tpApnUNGDyGOKX/vK45ZV20NZn4Urpz2Kt
X-Gm-Message-State: AOJu0YxAQ6De5HGZiNi3C5+F7lAd4YW2eUw/WQ/moURSojS8w/WK6dKD
	vb9JaNJ33rM1rPY261cMnE8goKMjIh4xg7WTixPFpcCUMEi6ICgeOCAMkJ7EchYgoHdmFfaxR3F
	Ru056EjW5FT7ftC/1pGl5oJk1jMY=
X-Google-Smtp-Source: AGHT+IGZ45vk6STtbL9xDLsKaQi2+D8pgY/I0jmfzUSTDFYODXC0DIYb58IA1z/3Vcs03IpW+4zu4qLJoie/U3dy/A8=
X-Received: by 2002:a17:906:547:b0:a72:8d2f:8594 with SMTP id
 a640c23a62f3a-a7a01147a55mr97637366b.27.1721215784008; Wed, 17 Jul 2024
 04:29:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com> <3128c3c0-ede2-4930-a841-a1da56e797d7@suse.cz>
In-Reply-To: <3128c3c0-ede2-4930-a841-a1da56e797d7@suse.cz>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 17 Jul 2024 13:29:31 +0200
Message-ID: <CAGudoHESB-+kHPJO+4MHnUDPJXGP87=yJ2QrW3q8pkO5z7OLRw@mail.gmail.com>
Subject: Re: Hard and soft lockups with FIO and LTP runs on a large system
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Bharata B Rao <bharata@amd.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	nikunj@amd.com, "Upadhyay, Neeraj" <Neeraj.Upadhyay@amd.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, willy@infradead.org, 
	yuzhao@google.com, kinseyho@google.com, Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 11:42=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 7/3/24 5:11 PM, Bharata B Rao wrote:
> > The general observation is that the problem usually surfaces when the
> > system free memory goes very low and page cache/buffer consumption hits
> > the ceiling. Most of the times the two contended locks are lruvec and
> > inode->i_lock spinlocks.
> >
[snip mm stuff]

There are numerous avoidable i_lock acquires (including some only
showing up under load), but I don't know if they play any role in this
particular test.

Collecting all traces would definitely help, locked up or not, for example:
bpftrace -e 'kprobe:queued_spin_lock_slowpath { @[kstack()] =3D count();
}' -o traces

As for clear_shadow_entry mentioned in the opening mail, the content is:
        spin_lock(&mapping->host->i_lock);
        xa_lock_irq(&mapping->i_pages);
        __clear_shadow_entry(mapping, index, entry);
        xa_unlock_irq(&mapping->i_pages);
        if (mapping_shrinkable(mapping))
                inode_add_lru(mapping->host);
        spin_unlock(&mapping->host->i_lock);

so for all I know it's all about the xarray thing, not the i_lock per se.
--
Mateusz Guzik <mjguzik gmail.com>

