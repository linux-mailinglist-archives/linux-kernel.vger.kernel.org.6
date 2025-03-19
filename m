Return-Path: <linux-kernel+bounces-568744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDBFA69A05
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC40481640
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27ABD214A69;
	Wed, 19 Mar 2025 20:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c9lv5Rlx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C6320AF7D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742415105; cv=none; b=pcHYx9b2+yemoHGrTRzf3orCBOe0S4sXjLiOD/EkLq7pveH9fFb+sUYIJVpOYDmn+otv9ztgNG7DH4P7hds1ZvgctD8t3vkPLYq38dymk+0dtAvbrsoWL1hwCENA0bAgWLXwGU3pGNrcOvW70+gH2hbWYdb0skpHX8vc+An3Lh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742415105; c=relaxed/simple;
	bh=4WqiFyzAD9xMCaMHZ7odABM/W/WfNwn2UuTWoyyMiXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qal0/aWqJJrRso2gXM5lGY4lRciiJmSt2Mt5q67bfM4HmacEJPnO7aakhrhJRMjUGej07To2zzJUzsJy77YllXB1ZKZlhZXlxudTJWqtOG38HkIsLZqIcqGnzFL6PVzlv6brM01CiTjhCO95Q+PlYUfgJiwhISNrdzXTsSLWlwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c9lv5Rlx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742415100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4WqiFyzAD9xMCaMHZ7odABM/W/WfNwn2UuTWoyyMiXA=;
	b=c9lv5Rlx0WULGJzSP/fNh+WYud7uHfPhCoSfxYY3SLwtNrGMRpTb86JIYlyLW+/G5qJAzA
	zQjNCfSvavyTcaD62jR4Pcq3LFfTtkOsASn+RjGFBQNjkCNf9JtU++i8WaLSFFSBR/NXfE
	MUzqShh0zF+JVYZRaWS5ur8IQMl9BVs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-4u00dda1MveelLlSphsFFg-1; Wed,
 19 Mar 2025 16:11:38 -0400
X-MC-Unique: 4u00dda1MveelLlSphsFFg-1
X-Mimecast-MFC-AGG-ID: 4u00dda1MveelLlSphsFFg_1742415097
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6C47195604F;
	Wed, 19 Mar 2025 20:11:36 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.12])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3DA3D1955BEF;
	Wed, 19 Mar 2025 20:11:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 19 Mar 2025 21:11:04 +0100 (CET)
Date: Wed, 19 Mar 2025 21:11:01 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] exit: combine work under lock in
 synchronize_group_exit() and coredump_task_exit()
Message-ID: <20250319201100.GH26879@redhat.com>
References: <20250319195436.1864415-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319195436.1864415-1-mjguzik@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 03/19, Mateusz Guzik wrote:
>
> This reduces single-threaded overhead as it avoids one lock+irq trip on
> exit.
>
> It also improves scalability of spawning and killing threads within one
> process (just shy of 5% when doing it on 24 cores on my test jig).
>
> Both routines are moved below kcov and kmsan exit, which should be
> harmless.
>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


