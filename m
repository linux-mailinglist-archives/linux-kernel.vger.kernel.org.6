Return-Path: <linux-kernel+bounces-170429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0058BD6B1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 23:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5371C21014
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 21:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF4315CD51;
	Mon,  6 May 2024 21:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avjLhaIw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96AE15B54C
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 21:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715029866; cv=none; b=tnkjdIeAkSj65GrUM114Bk/8+JHFV76IJ+VCVUen1fXRwYXlWUwC7HKoVVjkbdaqcmGzoORTd/mLy+TSSEYo3scOgeNRJqYNsOzSF5xpKDONieyPcssCO6bjixKv1uPPinrcirphabiSqGG3FFB7Df5AFhnBxPB4lTvh0xrhUlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715029866; c=relaxed/simple;
	bh=WGO5QO3dRKlfICitdweFGYAhS6YfziQiBFs8T7YQuUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjMEw/3sNvqY6EtBRACZhuEj71abcBr7lZT9bL4iNxuj9WqzGwGU7v6Tce7mzxVm/uVC6WgZFBN9uRmeUswwL9Qepqf3KFlwa1EWSZ1KHhPH2tbI1NPWl9dMlYP/XpnrCa1SzCKsXvOFDVzGdVmYIQg8ROpeit49M0iNtfP4vC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=avjLhaIw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715029863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vpuM7DdZ1dIVsrgmEZWd5kU26lRSp4glNuqdk/kl22U=;
	b=avjLhaIwOQ5NR4bFCK/sNko38PnRBKMZhBMkzyux4cVHqrqMB4gc+WhkBYldCi2CTI7W4g
	H3mR06F2O1I5RwAtIV14w5DStL1g+tBLjsPvX9utZGgwd4Mvm17D0YcJQRTc3K+ycpT+lT
	8ydOKQCXZ3csonlz2yfYHh/BklgOlWw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-RUNP_kfqNUyH-DGcUyNMHw-1; Mon,
 06 May 2024 17:11:00 -0400
X-MC-Unique: RUNP_kfqNUyH-DGcUyNMHw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C66A71C05153;
	Mon,  6 May 2024 21:10:59 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AEF3CC13FA3;
	Mon,  6 May 2024 21:10:59 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.2/8.17.1) with ESMTPS id 446LAxvH004709
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 6 May 2024 17:10:59 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.2/8.17.2/Submit) id 446LAxVh004708;
	Mon, 6 May 2024 17:10:59 -0400
Date: Mon, 6 May 2024 17:10:59 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Joel Colledge <joel.colledge@linbit.com>
Cc: Christian Loehle <christian.loehle@arm.com>, dm-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] dm-delay: fix hung task introduced by kthread mode
Message-ID: <ZjlHY02it0wBL0TB@redhat.com>
References: <20240506072523.399767-1-joel.colledge@linbit.com>
 <20240506072523.399767-2-joel.colledge@linbit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506072523.399767-2-joel.colledge@linbit.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Mon, May 06, 2024 at 09:25:23AM +0200, Joel Colledge wrote:
> If the worker thread is not woken due to a bio, then it is not woken at
> all. This causes the hung task check to trigger. This occurs, for
> instance, when no bios are submitted. Also when a delay of 0 is
> configured, delay_bio() returns without waking the worker.
> 
> Prevent the hung task check from triggering by creating the thread with
> kthread_run() instead of using kthread_create() directly.
> 
> Fixes: 70bbeb29fab0 ("dm delay: for short delays, use kthread instead of timers and wq")
> Signed-off-by: Joel Colledge <joel.colledge@linbit.com>

Reviewed-by: Benjamin Marzinski <bmarzins@redhat.com>


