Return-Path: <linux-kernel+bounces-331689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386E297B00B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 14:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C9F28297C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3354916A95B;
	Tue, 17 Sep 2024 12:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPkUKIQK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0CD156250
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 12:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726575751; cv=none; b=OhLZRjuOYEVjD9EsArIckfsEZKMR5/iZwRf5xVpuWrc0ytM7aWcbxm2VzYfQ/1CjYwYFbibmkwO1DuAKNSYVTBFaG8teQ+ST1NfwfWUlmVelUm7hbtzXu2ccc5jcR2qE7qYQ/cQ2G5oCCJWKRYmTWQOYYCCE20SvId1hx0cq1Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726575751; c=relaxed/simple;
	bh=xeuHGDnRy1DC9m3oPh8xhe81PwylpW4rMI++5qNAX/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8frhPuyeoq5KXAi28BQT2PbJaZC7gYYzXoei4K4xlnyzI/zOJhnSR2MnzXrnGFDciV99gQ92ZcfrMLU/iWEwIBsIRs3ZYOJv1hdLnC++veTSkFIjofMA3GcIPKEUeox7eGkYsPrtx+lLtmGOU1U1ty4xG377gbmE15w4SukleE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YPkUKIQK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726575748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jdc0W87W/DOchOKoYPEek4bV7oRWeb/I9Hni4nlJ9R8=;
	b=YPkUKIQKe0u9zWZWJvD477Vq0fHn23AhQ1iV1y+WCGfvi5BDS8ftVCIrQBiqBREqyMJLU1
	8kl1emoR7fqkzXT+gbglTnk+joCgXQodeJFNSXzppaZGKbjRGIG4xwYLbB8fYCTk1pktpv
	q1ysBX1Wfv0bJS8VrlQ4aoVydNG282U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-nok1KpieM02snB7pAK7qkA-1; Tue,
 17 Sep 2024 08:22:27 -0400
X-MC-Unique: nok1KpieM02snB7pAK7qkA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03E2919560A3;
	Tue, 17 Sep 2024 12:22:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.79])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id CF70F19560AA;
	Tue, 17 Sep 2024 12:22:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 17 Sep 2024 14:22:12 +0200 (CEST)
Date: Tue, 17 Sep 2024 14:22:05 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 02/14] uprobe: Add support for session consumer
Message-ID: <20240917122204.GB7752@redhat.com>
References: <20240917085024.765883-1-jolsa@kernel.org>
 <20240917085024.765883-3-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917085024.765883-3-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/17, Jiri Olsa wrote:
>
>  static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
...
> +	if (!ignore && !ZERO_OR_NULL_PTR(ri)) {
> +		/*
> +		 * The push_idx value has the final number of return consumers,
> +		 * and ri->consumers_cnt has number of allocated consumers.
> +		 */
> +		ri->consumers_cnt = push_idx;
> +		prepare_uretprobe(uprobe, regs, ri);
> +	}

This looks wrong. ri is not kfreed if ignore == true.

But see my previous email, if we change this code as I tried to suggest
the problem goes away and handler_chain() doesn't need "bool ignore".

Oleg.


