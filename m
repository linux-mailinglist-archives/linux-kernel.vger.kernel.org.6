Return-Path: <linux-kernel+bounces-228902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 978F0916874
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21D37B23351
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDCF158A23;
	Tue, 25 Jun 2024 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IwDFT0Nm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23BA157A6C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719320300; cv=none; b=i64nxC7iCMyV5ggw3vwyUaoS76/AtiO6x//grsGOBJexzh1umKrwlRDQLpzW3wKQ+5CcsgyueCtnojKLbc9KyEURHnQk9pxc6DjGPMVUZ0ZXxloqCm5PZy8dYhLW/7opbpLSGQKE0TowV+XH1IOoJ4FJvIlZMixP4S7S5moMkbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719320300; c=relaxed/simple;
	bh=r/tlR21NffIMt5ZDgvV1d7RlpuCNpsFKrOnjZOwLb0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJOW9UIpKdcITfojHe9UDU3cfmA+PrDB03MJt49OPGQfkAfD2zcNcqzlzBN74OMFhCCsOuUyrTD+XfKqAWyrIfWylPB2IqUZoji4S2AqbCejzIQHN3r4tLIFbhgbW8UcK/xlUNANQK3MJQzSy/wio678mx9sSie8K3CLvBLiM7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IwDFT0Nm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719320297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JW2KMY7G2NYtXMPV0l1YlXRPUeGBL3/eBLAs9PUnfhs=;
	b=IwDFT0Nm2s30dZvtCyhNsHMdt3uinZoXCQHWK0+FQsHQevCzbDo25FU3hCZFpJQQI5OZ8v
	3x9QFmy8ELhxicyCnuw6ybUCHfRwAwGynhejj420A/NmOWjXB/a2YWxfVJ6f2BgqbWBUOq
	gQBUjoiZU+q8o6GhiSHLWiMBFM3etZg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-2t0IgI5xNyud8bgogOpjDw-1; Tue,
 25 Jun 2024 08:58:16 -0400
X-MC-Unique: 2t0IgI5xNyud8bgogOpjDw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C48419560B2;
	Tue, 25 Jun 2024 12:58:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.198])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0A6C03000225;
	Tue, 25 Jun 2024 12:58:12 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 25 Jun 2024 14:56:41 +0200 (CEST)
Date: Tue, 25 Jun 2024 14:56:38 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/17] signal: Bring down all threads when handling a
 non-coredump fatal signal
Message-ID: <20240625125638.GA17193@redhat.com>
References: <20240609142342.GA11165@redhat.com>
 <87r0d5t2nt.fsf@email.froward.int.ebiederm.org>
 <20240610152902.GC20640@redhat.com>
 <20240613154541.GD18218@redhat.com>
 <87ikyamf4u.fsf@email.froward.int.ebiederm.org>
 <20240617183758.GB10753@redhat.com>
 <87iky5k2yi.fsf@email.froward.int.ebiederm.org>
 <87o77xinmt.fsf_-_@email.froward.int.ebiederm.org>
 <87v825h8yi.fsf_-_@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v825h8yi.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 06/18, Eric W. Biederman wrote:
>
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2882,7 +2882,13 @@ bool get_signal(struct ksignal *ksig)
>  		 * Anything else is fatal, maybe with a core dump.
>  		 */
>  		exit_code = signr;
> -		group_exit_needed = true;
> +		if (sig_kernel_coredump(signr))
> +			group_exit_needed = true;

OK... do_coredump() can fail before coredump_wait() even if CONFIG_COREDUMP

> +		else {
> +			signal->group_exit_code = exit_code;
> +			signal->flags = SIGNAL_GROUP_EXIT;
> +			zap_other_threads(current);
> +		}

dequeue_signal() and/or ptrace_signal() can drop siglock, I think
the else branch should re-check SIGNAL_GROUP_EXIT/group_exec_task.

Oleg.


