Return-Path: <linux-kernel+bounces-265593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDEB93F35B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A8931F2236E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCFD1459EB;
	Mon, 29 Jul 2024 10:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNuyumux"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06751459E1
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 10:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722250648; cv=none; b=p14bmfAhmOtBk+SYV8i1/5jRQaKVbsowvgHs0XtgQ21gPD3By9PhmYZ2v5r52ngsJFOA+NZmcyaKrFda1olODK2OhviJiSxBcFEM2FVDxRR1UdcYTjsO0n+14jNjthzzsUNCB22hMoWS8vZI0oiI3DRy5/kWLa81LgW648Tadww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722250648; c=relaxed/simple;
	bh=MKO/ismtlYm2YYhXLmhB06wPeTf3whlxnZoRdHHbqcY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kKN2BlIMJ2pf8LMaTi1SsJMxOOfNseXnfinJYsa5Zk8NAtE7YieekdBkIFZsoShs17e9CYklpDeGgCWJtx+3ios83xKt+HRBesyXPpWzaJzVnm8g8IxBl4dMeYkjacsOZKRhAOf8dA+JQc2VarCPLBG4m12Qm2nLyMP2103zPpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LNuyumux; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722250645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=10bUMMha3eVKE0pYqfRyimfBDUPmcMHMaix0zL5TC/g=;
	b=LNuyumuxnC5eE+dIb1YpVdk+jbRjXvuLDVv7LHZWOM1Tf6+DHOTXuNbO9YcnXE0xVPCubt
	SHwim01MbFLGZaRoMCC+drWdQpQEqfyPslhBEVZ3SYtG0YUmCuA3jutpO7G9R7GPZc8KrD
	anm+BiWkFUN2vXBTZfYVaFkLO74iwSA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-eGKs7MrkOjyhtwFWWpa_9A-1; Mon,
 29 Jul 2024 06:57:21 -0400
X-MC-Unique: eGKs7MrkOjyhtwFWWpa_9A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4C861955D54;
	Mon, 29 Jul 2024 10:57:19 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.45.224.31])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88B80195605F;
	Mon, 29 Jul 2024 10:57:17 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-api@vger.kernel.org,  Dave Chinner <dchinner@redhat.com>
Subject: Re: Testing if two open descriptors refer to the same inode
In-Reply-To: <vmjtzzz7sxctmf7qrf6mw5hdd653elsi423joiiusahei22bft@quvxy4kajtxt>
	(Mateusz Guzik's message of "Mon, 29 Jul 2024 12:50:47 +0200")
References: <874j88sn4d.fsf@oldenburg.str.redhat.com>
	<ghqndyn4x7ujxvybbwet5vxiahus4zey6nkfsv6he3d4en6ehu@bq5s23lstzor>
	<875xsoqy58.fsf@oldenburg.str.redhat.com>
	<vmjtzzz7sxctmf7qrf6mw5hdd653elsi423joiiusahei22bft@quvxy4kajtxt>
Date: Mon, 29 Jul 2024 12:57:14 +0200
Message-ID: <87sevspit1.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

* Mateusz Guzik:

> On Mon, Jul 29, 2024 at 12:40:35PM +0200, Florian Weimer wrote:
>> * Mateusz Guzik:
>> 
>> > On Mon, Jul 29, 2024 at 08:55:46AM +0200, Florian Weimer wrote:
>> >> It was pointed out to me that inode numbers on Linux are no longer
>> >> expected to be unique per file system, even for local file systems.
>> >
>> > I don't know if I'm parsing this correctly.
>> >
>> > Are you claiming on-disk inode numbers are not guaranteed unique per
>> > filesystem? It sounds like utter breakage, with capital 'f'.
>> 
>> Yes, POSIX semantics and traditional Linux semantics for POSIX-like
>> local file systems are different.
>
> Can you link me some threads about this?

Sorry, it was an internal thread.  It's supposed to be common knowledge
among Linux file system developers.  Aleksa referenced LSF/MM
discussions.

> I had this in mind (untested modulo compilation):
>
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 300e5d9ad913..5723c3e82eac 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -343,6 +343,13 @@ static long f_dupfd_query(int fd, struct file *filp)
>  	return f.file == filp;
>  }
>  
> +static long f_dupfd_query_inode(int fd, struct file *filp)
> +{
> +	CLASS(fd_raw, f)(fd);
> +
> +	return f.file->f_inode == filp->f_inode;
> +}
> +
>  static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
>  		struct file *filp)
>  {
> @@ -361,6 +368,9 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
>  	case F_DUPFD_QUERY:
>  		err = f_dupfd_query(argi, filp);
>  		break;
> +	case F_DUPFD_QUERY_INODE:
> +		err = f_dupfd_query_inode(argi, filp);
> +		break;
>  	case F_GETFD:
>  		err = get_close_on_exec(fd) ? FD_CLOEXEC : 0;
>  		break;
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index c0bcc185fa48..2e93dbdd8fd2 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -16,6 +16,8 @@
>  
>  #define F_DUPFD_QUERY	(F_LINUX_SPECIFIC_BASE + 3)
>  
> +#define F_DUPFD_QUERY_INODE (F_LINUX_SPECIFIC_BASE + 4)
> +
>  /*
>   * Cancel a blocking posix lock; internal use only until we expose an
>   * asynchronous lock api to userspace:

It's certainly much easier to use than name_to_handle_at, so it looks
like a useful option to have.

Could we return a three-way comparison result for sorting?  Or would
that expose too much about kernel pointer values?

Thanks,
Florian


