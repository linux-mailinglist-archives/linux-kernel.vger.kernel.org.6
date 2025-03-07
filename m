Return-Path: <linux-kernel+bounces-552069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF502A574F2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3116918969ED
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B92C258CD8;
	Fri,  7 Mar 2025 22:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YEyr3Ktr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7DE257AFC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 22:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741386700; cv=none; b=jArBpy+Rbd1pVZhbaCG3DLyzxeycV2GCNfUg6DxzdRRCvowcdOb0LN8/HmQZCalcqdQnbfLeqqfbs7iRtwRR20hMYTP+34/7r1bzh8M2YRAbz3U6UDl/DfhivGjT41PSUDxfDoxnUa2Q4jiS/hgMJwgPBYeiQjCwd6WGky/Z81M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741386700; c=relaxed/simple;
	bh=nZGk6mfExWAHXyq0mprCBSGfLZIliOmAUPxja8XuxLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgAc+L5bz/X6hRnfi1/Ki+ThnwE2pJP+FEjZTrfKSqGCyKcdQ62EwHP6ylIYjWt+tU0JK9nRslsAop1FYoan/IMKCGMmORfW/2V/tPos3rvUcUXijnahvGNfsbZ0BCI8AVUpTsyU4gz194zmMhY9GLXM7wsE89sDhL8aFn27isc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YEyr3Ktr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741386697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sV7vvuO22v8uBl/5aRjBBU/B50QkuFj7vsyvnziHuTE=;
	b=YEyr3Ktr9iQW0V/Cjp016s7Z6dYVOHufYGYRdnxBb2fv9KorbMnDsNB4vcvFRx8iDxTAzC
	0jI6QADMxX7pCkM0Vj13pH/e9ZeXkzL5/l9uav2pEq75UN/QWEIkNQ/QsMO4Mif+nSZdGy
	Uy43Q2sHcNlPaD6tKXwjYH0Y8RHjVaE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-x-Bv2qhWPamQcyY_046LPw-1; Fri,
 07 Mar 2025 17:31:01 -0500
X-MC-Unique: x-Bv2qhWPamQcyY_046LPw-1
X-Mimecast-MFC-AGG-ID: x-Bv2qhWPamQcyY_046LPw_1741386659
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A828419560B3;
	Fri,  7 Mar 2025 22:30:58 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.108])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E00E5180174F;
	Fri,  7 Mar 2025 22:30:52 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  7 Mar 2025 23:30:27 +0100 (CET)
Date: Fri, 7 Mar 2025 23:30:20 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Rasmus Villemoes <ravi@prevas.dk>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Neeraj.Upadhyay@amd.com, Ananth.narayan@amd.com,
	Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: Re: [PATCH v2 1/4] fs/pipe: Limit the slots in pipe_resize_ring()
Message-ID: <20250307223020.GA28762@redhat.com>
References: <20250307052919.34542-1-kprateek.nayak@amd.com>
 <20250307052919.34542-2-kprateek.nayak@amd.com>
 <20250307145125.GE5963@redhat.com>
 <7cbc5845-e890-4bf5-9488-cd2496642f7e@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cbc5845-e890-4bf5-9488-cd2496642f7e@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 03/07, K Prateek Nayak wrote:
>
> On 3/7/2025 8:21 PM, Oleg Nesterov wrote:
> >On 03/07, K Prateek Nayak wrote:
> >>
> >>--- a/fs/pipe.c
> >>+++ b/fs/pipe.c
> >>@@ -1271,6 +1271,10 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
> >>  	struct pipe_buffer *bufs;
> >>  	unsigned int head, tail, mask, n;
> >>
> >>+	/* nr_slots larger than limits of pipe->{head,tail} */
> >>+	if (unlikely(nr_slots > (pipe_index_t)-1u))
> >>+		return -EINVAL;
> >
> >The whole series look "obviously" good to me,
> >
> >Reviewed-by: Oleg Nesterov <oleg@redhat.com>

So, in case it wasn't clear, you could safely ignore everything else below ;)

> >pipe_resize_ring() has another caller, watch_queue_set_size(), but it has
> >its own hard limits...
>
> "nr_notes" for watch queues cannot cross 512 so we should be covered there.

Yes, yes, this is what I meant,

> As for round_pipe_size(), we can do:
>
> diff --git a/fs/pipe.c b/fs/pipe.c
> index ce1af7592780..f82098aaa510 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -1253,6 +1253,8 @@ const struct file_operations pipefifo_fops = {
>   */
>  unsigned int round_pipe_size(unsigned int size)
>  {
> +	unsigned int max_slots;
> +
>  	if (size > (1U << 31))
>  		return 0;
> @@ -1260,7 +1262,14 @@ unsigned int round_pipe_size(unsigned int size)
>  	if (size < PAGE_SIZE)
>  		return PAGE_SIZE;
> -	return roundup_pow_of_two(size);
> +	size = roundup_pow_of_two(size);
> +	max_slots = size >> PAGE_SHIFT;
> +
> +	/* Max slots cannot be covered pipe->{head,tail} limits */
> +	if (max_slots > (pipe_index_t)-1U)
> +		return 0;

Sure, this will work, but still it doesn't look clear/clean to me.
But no, no, I don't blame your suggestion.

To me, round_pipe_size() looks confusing with or without the changes we
discuss. Why does it use "1U << 31" as a maximum size? OK, this is because
that "1 << 31" is the maximum power-of-2 which can fit into u32.

But, even if this code assumes that pipe->head/tail are u32, why this
restriction? Most probably I missed something, but I don't understand.

> Since pipe_resize_ring() can be called without actually looking at
> "pipe_max_size"

Again, only if the caller is watch_queue_set_size(), but it has its own
hard limit.

So. I won't argue either way. Whatever looks better to you. My ack
still stands.

Sorry for (yet another) confusing and almost off-topic email from me.

Oleg.


