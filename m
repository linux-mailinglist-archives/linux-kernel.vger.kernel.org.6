Return-Path: <linux-kernel+bounces-302973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 273629605AD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B89CCB230D7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870BA19D06C;
	Tue, 27 Aug 2024 09:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i5AsPKKG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BE1155393
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751222; cv=none; b=u7rT5NFV0czzpLf1cRbTXCpY7Tl0NSHN9TdTdbfNaXcLlocJjOK4PvHKUVqeDHMG3pIrI01/gAUsPgEmkUZYsq/RANt+Gn7JTZjJp0zQnxIR9rFqyQqhNNkUNmB1oINc8SN+BX/BNm6+xW6WkegriCtvsAnP9aOzbAoaqGP7VqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751222; c=relaxed/simple;
	bh=V7aWxvyu2NNNuOIIPUEc2jOovLlsk3r14oEGvmpUfD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzrpi8LYReT6GLysdlbaDgoT+cCgdXdy1GXEpUOwUrTpm+4kUeNUN3Hr9k9cBzYLgpq0U7GJPY4eazsLYyiu2LoS6Hw7gEvKPS64nOZ9BJ0I3+zikbtbyIr1FKILykiG0FuUwnBhG9Q9A6aQsYLHCVwWx7IPIZ/fg9pYLVJNKTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i5AsPKKG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724751219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xioG04ypc2y3mzfncp7R682Hre9B7EvlJbcD2gyIjIg=;
	b=i5AsPKKGTU6B+5LRos+5MKCDpUMRcek8H+QyiRcb6lL/oMte6kvA6iDLu9zbUYycWH1DB8
	exvor2Q+Lqlb8SJEIpIcqqKR8+Txdjizx17U9ZXFoeLsq7O6R09UkCg21DwdYddF0hmMG8
	BLLYIL1d8W7Ckm+YmQnn26312T+cvPI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-EbzGIH8aMEaTI4cZ3J3YLg-1; Tue,
 27 Aug 2024 05:33:36 -0400
X-MC-Unique: EbzGIH8aMEaTI4cZ3J3YLg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B906D1954B05;
	Tue, 27 Aug 2024 09:33:34 +0000 (UTC)
Received: from localhost (unknown [10.72.112.42])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 700031956056;
	Tue, 27 Aug 2024 09:33:32 +0000 (UTC)
Date: Tue, 27 Aug 2024 17:33:28 +0800
From: Baoquan He <bhe@redhat.com>
To: Dave Young <dyoung@redhat.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
	noodles@fb.com, x86@kernel.org, lijiang@redhat.com,
	kexec@lists.infradead.org
Subject: Re: [PATCH] x86/mm/sme: fix the kdump kernel breakage on SME system
 when CONFIG_IMA_KEXEC=y
Message-ID: <Zs2daJ9FHA8vPkPP@MiWiFi-R3L-srv>
References: <20240826024457.22423-1-bhe@redhat.com>
 <35e40987-1541-cbbe-6b16-1ddadc2c4c35@amd.com>
 <Zs1j31JGB/5EJatz@MiWiFi-R3L-srv>
 <CALu+AoTNtzVGFyG=GLAtT=VEWJG7FNbx6jD_Ye+4ORYXOiMekw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALu+AoTNtzVGFyG=GLAtT=VEWJG7FNbx6jD_Ye+4ORYXOiMekw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 08/27/24 at 01:41pm, Dave Young wrote:
> On Tue, 27 Aug 2024 at 13:28, Baoquan He <bhe@redhat.com> wrote:
> >
> > On 08/26/24 at 09:24am, Tom Lendacky wrote:
> > > On 8/25/24 21:44, Baoquan He wrote:
......
> > > > ---
> > > >  arch/x86/mm/ioremap.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> > > > index aa7d279321ea..7953c4a1d28d 100644
> > > > --- a/arch/x86/mm/ioremap.c
> > > > +++ b/arch/x86/mm/ioremap.c
> > > > @@ -717,7 +717,7 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
> > > >             paddr_next = data->next;
> > > >             len = data->len;
> > > >
> > > > -           if ((phys_addr > paddr) && (phys_addr < (paddr + len))) {
> > > > +           if ((phys_addr > paddr) && (phys_addr < (paddr + size + len))) {
> > >
> > > I don't think this is correct. You are adding the requested size to the
> > > length of the setup data element. The length is the true length of the
> > > setup data and should not be increased.
> >
> > I talked to Dave, he reminded me that people could mix the passed in
> > parameter 'size' and the local variable 'size' defined inside the while
> > loop, not sure which 'size' you are referring to.
> >
> Baoquan, you are right, but I think I mistakenly read the code in
> memremap_is_setup_data instead of early_memremap_is_setup_data.  You
> can check the memremap_is_setup_data, no "size = sizeof (*data)",  so
> these two functions could both need fixes.

Agree, memremap_is_setup_data() has the same drawback in code.

> 
> Otherwise it would be better to change the function internal variable
> name, it could cause confusion even if the actual result is correct.

Ok, will consider to change when spinning v2.


