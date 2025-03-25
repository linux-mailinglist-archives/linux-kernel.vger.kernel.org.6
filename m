Return-Path: <linux-kernel+bounces-575383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F1EA701B8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 415CE3AA512
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BCB25C6F0;
	Tue, 25 Mar 2025 13:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjS9SY3H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3120025A64E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 13:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907902; cv=none; b=fwfNUmY5e8BrayxekSAYDDKtRXsVvfvO5ykhQpfe86bkwsqVXY6ET9+UAZBOxpM+pdxXq/hhiRemwU3mKNy7VwRiXZw1la+a0KBY5GliXfr2tOa8hG7Lcd5iVhVlp9Vus6XltaUp2W/mIdGqucRa8SUBsXJai2HelT3Ycn3RkWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907902; c=relaxed/simple;
	bh=KtXukF7zS507yXC0bV3Lgtc0k1fuYoFUyPiii35Srw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjD1iFdcAeZD5ytpVjoPIoX8ZX7UsXTTH1PyiQ6WNInDv7Z2h/LWnZZC4mWM8/y7nb/cFv+GhLuywRLQumGLwvLI54dKUT3AIv9odCOb3yGwdRSoOJKHWfZwgC0CZgOWcD3zpAaJaGWkLycKMBiXM9S4+oBMCz0Kkpgg16VsFLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CjS9SY3H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742907900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a717aorAR0FFD6ZXSPKWzRFsANFSqFlPrG/xcqr9NTM=;
	b=CjS9SY3HIFBd6k6NuSRNqBivatesiYZE7jIna8UsH7yflmFCgKXmguCVR8q49vvim+fcB0
	7FmPWYgwN20WWzmeLIOt2NNFh9sz2CbBDNf6IqpJHCRz6TRmEho/RuLbcXAPOZ2mFbPci/
	scl9jN5K4cGVD48xtbPb7pF8h7Z4Ops=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-ONqfwzWAMceN_6i1pbI_rA-1; Tue,
 25 Mar 2025 09:04:54 -0400
X-MC-Unique: ONqfwzWAMceN_6i1pbI_rA-1
X-Mimecast-MFC-AGG-ID: ONqfwzWAMceN_6i1pbI_rA_1742907891
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E66D21956067;
	Tue, 25 Mar 2025 13:04:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.42])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 719BF19541A5;
	Tue, 25 Mar 2025 13:04:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 25 Mar 2025 14:04:17 +0100 (CET)
Date: Tue, 25 Mar 2025 14:04:10 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>,
	brauner@kernel.org, dhowells@redhat.com, jack@suse.cz,
	jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
	swapnil.sapkal@amd.com, syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk, v9fs@lists.linux.dev
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
Message-ID: <20250325130410.GA10828@redhat.com>
References: <67e05e30.050a0220.21942d.0003.GAE@google.com>
 <20250323194701.GC14883@redhat.com>
 <CAGudoHHmvU54MU8dsZy422A4+ZzWTVs7LFevP7NpKzwZ1YOqgg@mail.gmail.com>
 <20250323210251.GD14883@redhat.com>
 <af0134a7-6f2a-46e1-85aa-c97477bd6ed8@amd.com>
 <CAGudoHH9w8VO8069iKf_TsAjnfuRSrgiJ2e2D9-NGEDgXW+Lcw@mail.gmail.com>
 <7e377feb-a78b-4055-88cc-2c20f924bf82@amd.com>
 <f7585a27-aaef-4334-a1de-5e081f10c901@amd.com>
 <ff294b3c-cd24-4aa6-9d03-718ff7087158@amd.com>
 <20250325121526.GA7904@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325121526.GA7904@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 03/25, K Prateek Nayak wrote:
>
> I chased this down to p9_client_rpc() net/9p/client.c specifically:
>
>         err = c->trans_mod->request(c, req);
>         if (err < 0) {
>                 /* write won't happen */
>                 p9_req_put(c, req);
>                 if (err != -ERESTARTSYS && err != -EFAULT)
>                         c->status = Disconnected;
>                 goto recalc_sigpending;
>         }
>
> c->trans_mod->request() calls p9_fd_request() in net/9p/trans_fd.c
> which basically does a p9_fd_poll().

Again, I know nothing about 9p... but if p9_fd_request() returns
an err < 0, then it comes from p9_conn->err and p9_fd_request()
does nothing else.

> Previously, the above would fail with err as -EIO which would
> cause the client to "Disconnect" and the retry logic would make
> progress. Now however, the err returned is -ERESTARTSYS

OK... So p9_conn->err = -ERESTARTSYS was set by p9_conn_cancel()
called by p9_write_work() because pipe_write() returns ERESTARTSYS?

But I don't understand -EIO with the reverted commit aaec5a95d59615

Oleg.


