Return-Path: <linux-kernel+bounces-181327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3448C7A78
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 18:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE216282B12
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1CB63D5;
	Thu, 16 May 2024 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XToibkZ2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B044C63
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715877554; cv=none; b=Chfj2PFk5aYmjrbT5Btt/R7BJUAQTIvkIjeZ8XvkVt3Vx1cueto2MZDa0IsmMf31LsuMqNP6POjuKjbSTI26qiWDiAOJr7WRaS4bjFlYSoDpJU+NqAKI8E3njiw9jB41S+R4rzqHObAc+VtlHMeZC/47zANNXHR3GiwPiV3kP5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715877554; c=relaxed/simple;
	bh=rUyXihDhNu7Z1iAvgieVjKk23YR4PPc7ojQiMkhbqlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvaU7uQ+LSKnUiRDuQaa2Qzqic1nvkoVmnKuY/lkfEjweElvI15EawVHJ72HYMu5Pe+6GBF+H7GGfe8oVV/bAc8kF1YmUQ8odJMsaQIZA3InlUYBhKY9baa/KgCVPCsfoyceghCgKFQN8F1LLYuivYWEGX51WdsuDJ8HZ8FKUdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XToibkZ2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715877551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QBHCOS4PG3tX0fhnUU55Pd+Wdr3Qjy0XkhyjMsdKKB4=;
	b=XToibkZ2VYT1fKvvsvrLQjeKw8iQto3c9YZTsjJnQLAMwaj/YQvwh8ivg45Ri3ZWiahvHp
	ZlgqOIwMN65VwGiXlOFCpRmh9eoJfLbqAve7HH7qCWti36PO47YDiB7slAD4RZcM88Pems
	yReZOpR9QxP/eFi75mKp7OMl6UeSnxQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-LbmT44npPzGsAD4ekVPLPA-1; Thu, 16 May 2024 12:39:09 -0400
X-MC-Unique: LbmT44npPzGsAD4ekVPLPA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC3E1801211;
	Thu, 16 May 2024 16:39:08 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C37B45ADC40;
	Thu, 16 May 2024 16:39:08 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.2/8.17.1) with ESMTPS id 44GGd8DT132591
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 12:39:08 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.2/8.17.2/Submit) id 44GGd8mq132590;
	Thu, 16 May 2024 12:39:08 -0400
Date: Thu, 16 May 2024 12:39:08 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: YangYang <yang.yang@vivo.com>
Cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] dm: support retrieving struct dm_target from struct
 dm_dev
Message-ID: <ZkY2rKP6AzEGfpkn@redhat.com>
References: <20240514090445.2847-1-yang.yang@vivo.com>
 <20240514090445.2847-4-yang.yang@vivo.com>
 <ZkTXzG1yrPmW64Z6@redhat.com>
 <ZkTcHCM49DDqhaYD@redhat.com>
 <4971046c-213b-494b-bf4b-ebe3feaa03c1@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4971046c-213b-494b-bf4b-ebe3feaa03c1@vivo.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On Thu, May 16, 2024 at 10:12:25AM +0800, YangYang wrote:
> On 2024/5/16 0:00, Benjamin Marzinski wrote:
> > On Wed, May 15, 2024 at 11:42:04AM -0400, Benjamin Marzinski wrote:
> > > When a target calls dm_get_device(), if it adds a new table device to
> > > t->devices, then it's the first target in this table to use that device.
> > > If flush_pass_around is set for this target, then it also sets
> > > sends_pass_around_flush. In __send_empty_flush() if the table has
> > > flush_pass_around set, when you iterate through the devices, you only
> > 
> > Err, "When you iterate through the *targets*, you only ..." In this
> > method you don't iterate through the list of devices (which is supposed
> > to be protected by t->devices_lock).
> 
> I'm not very familiar with this area, I thought that the device list
> of an active table cannot be modified, so it doesn't need to be
> protected by t->devices_lock.

Actually, looking at this some more you're basically correct. The only
place where dm can modify the devices list of active table is in
multipath_message(), and that's bug. So you should be safe not locking
here.

I'll post a patch to fix the multipath target.

-Ben
 
> > 
> > > call __send_empty_flush_bios() for the ones with sends_pass_around_flush
> > > set.
> > > 
> > > Or am I overlooking something?
> > > 
> > > -Ben
> > 


