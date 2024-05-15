Return-Path: <linux-kernel+bounces-180101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C17358C6A1B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4E5D1C20F85
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7C4156231;
	Wed, 15 May 2024 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUYPQmb4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A977155723
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715788840; cv=none; b=UFtNaVYyLxAILbyRt2RobShrLrKH7BwTVK4bfG691fulaFuL4oZQDlHDUQAQ/UO5bfbxMOaHyednEX3spT1vlgDNiZSiZ0mKzOG++WfUY+5Ks/a1Q7lx7D0kX6SH34rgpnQ96zGGII/OL+fL88PDCB9jttqxtnXg0+2+InVmTjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715788840; c=relaxed/simple;
	bh=vSZLadVXxqpR4dC7K/Hoqnf7AMMN3R3Jvpg2OocRMww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blaK+4Z6CE2llFD3amWBqapXyUjHOM52e6BKb46IV8D8sTvMBTeQLjxNiVUyw1rRIJtyeZFFqIV17wyNDYQBRdrOhj6bsq9YJmUQwkX7gDiCsl1/ccMclAH3IoGY9gWyBpv4XrhKf8keEUzNgyxdMtJNd079cpJ5jUBklHwOGyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UUYPQmb4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715788837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yt8DsUxFz497IwJBgOgaEyff2Zjn77BCwz7q5rgLuW0=;
	b=UUYPQmb43gGEIB73cLv6xi2HguMjnwwuH9btCbhiMePrqEy0l8nxTvKX0YWhkpsEPj6VPd
	mBK8CSujQ2IrETl52WhHYVOc/ihFL+f9XjM3zMEVtyuzEnQ2FC3CT80XDJwj1n1bnN6wvQ
	hF3BAdhiOLrINc1hJFLFZsoVGiKF/0s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-7hRf04vjNHiCrAOya3-RTw-1; Wed, 15 May 2024 12:00:29 -0400
X-MC-Unique: 7hRf04vjNHiCrAOya3-RTw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C15B98025FC;
	Wed, 15 May 2024 16:00:28 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AC6F2C15BB1;
	Wed, 15 May 2024 16:00:28 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.2/8.17.1) with ESMTPS id 44FG0S7l119889
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 12:00:28 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.2/8.17.2/Submit) id 44FG0Sq3119888;
	Wed, 15 May 2024 12:00:28 -0400
Date: Wed, 15 May 2024 12:00:28 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Yang Yang <yang.yang@vivo.com>
Cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] dm: support retrieving struct dm_target from struct
 dm_dev
Message-ID: <ZkTcHCM49DDqhaYD@redhat.com>
References: <20240514090445.2847-1-yang.yang@vivo.com>
 <20240514090445.2847-4-yang.yang@vivo.com>
 <ZkTXzG1yrPmW64Z6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkTXzG1yrPmW64Z6@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Wed, May 15, 2024 at 11:42:04AM -0400, Benjamin Marzinski wrote:
> When a target calls dm_get_device(), if it adds a new table device to
> t->devices, then it's the first target in this table to use that device.
> If flush_pass_around is set for this target, then it also sets
> sends_pass_around_flush. In __send_empty_flush() if the table has
> flush_pass_around set, when you iterate through the devices, you only

Err, "When you iterate through the *targets*, you only ..." In this
method you don't iterate through the list of devices (which is supposed
to be protected by t->devices_lock).

> call __send_empty_flush_bios() for the ones with sends_pass_around_flush
> set.
> 
> Or am I overlooking something?
> 
> -Ben


