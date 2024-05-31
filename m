Return-Path: <linux-kernel+bounces-196774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A465C8D61B5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3882F1F25CA0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23E51586CB;
	Fri, 31 May 2024 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aa19eOk9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BAB39FF3
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158489; cv=none; b=E33AGMBIHKilpOIPDNmdpyDmAwQeRWrUkoSiNJwoo9WP0BvGbFx+0bdrWm0ObVCP02yUP/Fi86/M/r9IM0SuoyVJBx9DZCdRjAwU41L/zuO9z3lzPQPCFnZIAmaPcuzhRg8iyz3+MKEjkdPjvlOw2CBxeK1N3qT5ZKfAsBA/v6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158489; c=relaxed/simple;
	bh=02xQIpzrJDvBVIgLx4jKyyxdR1qj1m751XRn6SUG1g0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q2V+9Va23JKxaEN1pm8s2QDWobqgbiYreNYZkTci9hxSZmA10T3Oc073UcY/mgpiyM2/WAw2SruBr+LdNYIsBOmjIRAxFYUJpriNXtSCOueB/ZBkjnxUoVp5hb8kjDRmu6kvgYM2ZQ5hnSEQCin7VZr4W1ekPd0MT65/rJ5+MuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aa19eOk9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717158486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=02xQIpzrJDvBVIgLx4jKyyxdR1qj1m751XRn6SUG1g0=;
	b=aa19eOk987oq6NXoSb22SUwVhY+TPLDZ/l7FhMN459nl2jvt8b6Cl4wFLwFtaQFRSpTKVw
	0AEFERVDuiuUP1QpKJOjI99JmATNdQ6ZpqKFgMbpaegljJW6DgBmRp5I4hMzxLkALiOVj7
	wrPCINWMQ2IF+JkoCCiz7j784Q+rwTE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-xiMw4JBCMDeAwMc9v_a3OA-1; Fri, 31 May 2024 08:28:03 -0400
X-MC-Unique: xiMw4JBCMDeAwMc9v_a3OA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0911185A780;
	Fri, 31 May 2024 12:28:02 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-11.rdu2.redhat.com [10.22.0.11])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E4017103A3AA;
	Fri, 31 May 2024 12:28:01 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: linux@treblig.org
Cc: trond.myklebust@hammerspace.com, anna@kernel.org,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NFS: remove unused struct 'mnt_fhstatus'
Date: Fri, 31 May 2024 08:28:00 -0400
Message-ID: <D6834CFC-CD3D-4CC9-BB6C-E874F8F0755B@redhat.com>
In-Reply-To: <20240531000033.294044-1-linux@treblig.org>
References: <20240531000033.294044-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 30 May 2024, at 20:00, linux@treblig.org wrote:

> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> 'mnt_fhstatus' has been unused since
> commit 065015e5efff ("NFS: Remove unused XDR decoder functions").
>
> Remove it.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


