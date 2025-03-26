Return-Path: <linux-kernel+bounces-576993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43845A71716
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988373AD6AF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7C91E1E0E;
	Wed, 26 Mar 2025 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EoN7RqyW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4701A0BDB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742994398; cv=none; b=qnJtDRk6d9t+VmcNqucj9AyIiy6TOJS15tRp74YUwH2ExeXg/1eE6kFtxJlUCoZNxJtO7bgxdj3L7qLCTbhhOTNcC78Bl9KrGlexbNLkeZqynn8pZ9LZvmUyZrzFfORl+MEetQqmyOBEYxneGbSFMUCVqrdpnXZFvDXRIuztJQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742994398; c=relaxed/simple;
	bh=w2xIYffHruj5ROfRcyn42enX7rm0EMCI6bekruskkww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzXF+MUqOE7IC6HVReL2AUgH0Pk/rs5jCOSnXaL5yPA5MhmomIPztmP18mZIxXghMCPrJfQL4fegNp/skxLLZkHOLXcPZnj8Ax8ie2wYOL58ZOqZ2NklHFrwdWUPPkQ1ESFV3W0h9SiaoWV5C93+lxvlVkNM0FjeD2UsVC0oNA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EoN7RqyW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742994395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AwslgY7sSyM8fbLk7/8aWJ9dZTx9PPsyFHnsBoNwz4g=;
	b=EoN7RqyW77Qdvzpb5JZa00efp/tdMQf9Sjy2dek/eK+NFL7DFuQlZ+rP3Bfik/fsWrOFKA
	PUc4fknKTTiCPR0Ko8cz1E8Q+LrFP0DwKBC3h1aiQGDJFIOKq0v6aSfn8My1Z+UrrNeE3k
	dEJGVLc7yPXrnT9igu+P2rNivVm/BzU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-5lAJXz7fOrSamByAApf5uQ-1; Wed,
 26 Mar 2025 09:06:34 -0400
X-MC-Unique: 5lAJXz7fOrSamByAApf5uQ-1
X-Mimecast-MFC-AGG-ID: 5lAJXz7fOrSamByAApf5uQ_1742994391
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8699518EBE8A;
	Wed, 26 Mar 2025 13:06:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.42])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D4C491801756;
	Wed, 26 Mar 2025 13:06:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 26 Mar 2025 14:05:58 +0100 (CET)
Date: Wed, 26 Mar 2025 14:05:50 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Dominique Martinet <asmadeus@codewreck.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>,
	brauner@kernel.org, dhowells@redhat.com, jack@suse.cz,
	jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
	swapnil.sapkal@amd.com, syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk, v9fs@lists.linux.dev
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
Message-ID: <20250326130550.GE30181@redhat.com>
References: <CAGudoHH9w8VO8069iKf_TsAjnfuRSrgiJ2e2D9-NGEDgXW+Lcw@mail.gmail.com>
 <7e377feb-a78b-4055-88cc-2c20f924bf82@amd.com>
 <f7585a27-aaef-4334-a1de-5e081f10c901@amd.com>
 <ff294b3c-cd24-4aa6-9d03-718ff7087158@amd.com>
 <20250325121526.GA7904@redhat.com>
 <20250325130410.GA10828@redhat.com>
 <f855a988-d5e9-4f5a-8b49-891828367ed7@amd.com>
 <Z-LEsPFE4e7TTMiY@codewreck.org>
 <20250326121946.GC30181@redhat.com>
 <20250326124402.GD30181@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326124402.GD30181@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Damn, sorry for the noise please ignore ;)

On 03/26, Oleg Nesterov wrote:
>
> On 03/26, Oleg Nesterov wrote:
> >
> > Hmm... I don't understand why the 2nd vfs_poll(ts->wr) depends on the
> > ret from vfs_poll(ts->rd), but I assume this is correct.
>
> I meant, if pt != NULL and ts->rd != ts->wr we need both
> vfs_poll(ts->rd) and vfs_poll(ts->wr) ?

I am stupid. After the lot of reading I can't distinguish "|" and "||".

Oleg.

> and the reproducer writes to the pipe before it mounts 9p...
> 
> Prateek, this is just a shot in the dark but since you can reproduce,
> can you check if the patch below makes any difference?
> 
> Oleg.
> 
> --- x/net/9p/trans_fd.c
> +++ x/net/9p/trans_fd.c
> @@ -234,8 +234,10 @@ p9_fd_poll(struct p9_client *client, str
>  	}
>  
>  	ret = vfs_poll(ts->rd, pt);
> -	if (ts->rd != ts->wr)
> +	if (ts->rd != ts->wr) {
> +		if (pt != NULL) vfs_poll(ts->wr, pt);
>  		ret = (ret & ~EPOLLOUT) | (vfs_poll(ts->wr, pt) & ~EPOLLIN);
> +	}
>  	return ret;
>  }
>  


