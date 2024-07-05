Return-Path: <linux-kernel+bounces-242717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25597928C1C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 18:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D542D284BBF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 16:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD07616D331;
	Fri,  5 Jul 2024 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUHccMjB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C022B9B9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720195814; cv=none; b=O/1jnanvuNjRvulMXyEMTRofI/9LBgOQY1vR8ZNcWq5U+rcEwbQ0wWVzoaW76bhF1yKaGcOKet3DwJ5PsrAMh11Iqqis0TRsGns1C3mJ9G7drURnwf7RBL6Adw+/ZgCF3h2rvRI/wipkK/7JoZZwU5ozOIed1srOO/lOZ4bZoe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720195814; c=relaxed/simple;
	bh=Dt14CO6nqTeJOKkkPfWE85lOabdCJ0iOs4fa/9fzW6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3iJS53x35bRCAQVIfxT2fNvjzU1xkXeVHSyLkH12nzvhX3dzksJJM4q9St606iHNBdVhX6h9r3sTYU2h6qMN1Om7B0At9k0R1m6Wko/i0yVvBuoK2OkiS4OfR3NXnEv6yEvFD+sTrhs4NA37iPukQvqzI9SOhyAHC+DCVYt/kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QUHccMjB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720195811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dt14CO6nqTeJOKkkPfWE85lOabdCJ0iOs4fa/9fzW6Y=;
	b=QUHccMjBARhreafaT6XGpASKZjwXuqhcWbV6EUtCX3uuc4wQ2/2NwT8yH2jE4i+pAkrY0+
	xGXr0rg9CXekSnp1JNqP4ERepYZsAl1lVNduAwGOdGqY/4idSummY9T+4MMLJ+jSd3HNi8
	TIPeb2Q2OmI23KJCLl8gl6LsyUM96j4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-hSyND49yNdatSSZMFY85Ug-1; Fri,
 05 Jul 2024 12:10:05 -0400
X-MC-Unique: hSyND49yNdatSSZMFY85Ug-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D35E5196CDF1;
	Fri,  5 Jul 2024 16:10:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.9])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 923C61955F3B;
	Fri,  5 Jul 2024 16:09:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  5 Jul 2024 18:08:26 +0200 (CEST)
Date: Fri, 5 Jul 2024 18:08:17 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Rachel Menge <rachelmenge@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Wei Fu <fuweid89@gmail.com>, apais@linux.microsoft.com,
	Sudhanva Huruli <Sudhanva.Huruli@microsoft.com>,
	Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Mike Christie <michael.christie@oracle.com>,
	Joel Granados <j.granados@samsung.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH] zap_pid_ns_processes: don't send SIGKILL to sub-threads
Message-ID: <20240705160816.GC18551@redhat.com>
References: <1386cd49-36d0-4a5c-85e9-bc42056a5a38@linux.microsoft.com>
 <20240608154835.GD7947@redhat.com>
 <87msnpov2z.fsf@email.froward.int.ebiederm.org>
 <20240613150001.GB18218@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613150001.GB18218@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 06/13, Oleg Nesterov wrote:
>
> Well, if SIGNAL_GROUP_EXIT is set we do not care if this process was
> killed or not. It (the whole thread group) is going to exit, that is all.

OOPS. I forgot again that you removed SIGNAL_GROUP_COREDUMP and thus
we can't rely on SIGNAL_GROUP_EXIT in this case.

I still think this was not right, but it is too late to complain.

Andrew, please drop this patch.

Currently zap_pid_ns_processes() kills the coredumping tasks, with this
patch it doesn't.

Oleg.


