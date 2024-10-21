Return-Path: <linux-kernel+bounces-374747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 510799A6F56
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 047C9283AF7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E001CCEC3;
	Mon, 21 Oct 2024 16:21:18 +0000 (UTC)
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BC71993B7;
	Mon, 21 Oct 2024 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729527678; cv=none; b=uwJDloosmhIf1iFX3goxqIVBdn7aEoy9EOQeRkO43+2+FNPDqkn/bzeKbCIepswZINvTxAGVdv+/qLpOILxhBtQK5J+oPBAWAoDZ3nlrHW0VVMqV1IOFIasK0jDwFpssizwUmmN3aiEQc5om/WWe4ia298DAev4cWAa+amKOMU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729527678; c=relaxed/simple;
	bh=neZ2VGJcuaQCKUO14GRiNCtviz7Y6xuUNx+jcEJET7g=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=ufE6y2+iPHg1WUOpr7dnpumZGM8YeSZpbI3QmKhrRAoeHCZ8JAIJIodTc/W0OytBS5exAJftqmUSy4nUc/jdRySlF6CggBOWTf0YjqVy6LbtYDwemspd48Vg2oUmQbGPHZaLrPvRcFnF+C6VpVDH9pvMd0mnv16GNnEsgRdMK8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:39828)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1t2tTi-00D8Vo-2W; Mon, 21 Oct 2024 08:33:51 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:56464 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1t2tTg-007PNk-VZ; Mon, 21 Oct 2024 08:33:49 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: kexec@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linux-coco@lists.linux.dev,  x86@kernel.org,  rick.p.edgecombe@intel.com,
  kirill.shutemov@linux.intel.com
References: <20241021034553.18824-1-yan.y.zhao@intel.com>
Date: Mon, 21 Oct 2024 09:33:17 -0500
In-Reply-To: <20241021034553.18824-1-yan.y.zhao@intel.com> (Yan Zhao's message
	of "Mon, 21 Oct 2024 11:45:53 +0800")
Message-ID: <87frop8r0y.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1t2tTg-007PNk-VZ;;;mid=<87frop8r0y.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19A3UgQ6OIzwbePtgXVLHKHHilNY2diWnM=
X-Spam-Level: *
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4615]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
	*  0.8 XM_B_SpammyWords2 Two or more commony used spammy words
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Yan Zhao <yan.y.zhao@intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 530 ms - load_scoreonly_sql: 0.15 (0.0%),
	signal_user_changed: 11 (2.1%), b_tie_ro: 10 (1.8%), parse: 1.04
	(0.2%), extract_message_metadata: 14 (2.6%), get_uri_detail_list: 2.4
	(0.4%), tests_pri_-2000: 12 (2.3%), tests_pri_-1000: 2.2 (0.4%),
	tests_pri_-950: 1.23 (0.2%), tests_pri_-900: 0.96 (0.2%),
	tests_pri_-90: 95 (17.9%), check_bayes: 92 (17.4%), b_tokenize: 9
	(1.6%), b_tok_get_all: 9 (1.8%), b_comp_prob: 3.2 (0.6%),
	b_tok_touch_all: 67 (12.7%), b_finish: 0.97 (0.2%), tests_pri_0: 377
	(71.0%), check_dkim_signature: 1.08 (0.2%), check_dkim_adsp: 3.4
	(0.6%), poll_dns_idle: 0.89 (0.2%), tests_pri_10: 2.0 (0.4%),
	tests_pri_500: 11 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] kexec_core: Accept unaccepted kexec destination addresses
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: kirill.shutemov@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, yan.y.zhao@intel.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false

Yan Zhao <yan.y.zhao@intel.com> writes:

> The kexec destination addresses (incluing those for purgatory, the new
> kernel, boot params/cmdline, and initrd) are searched from the free area of
> memblock or RAM resources. Since they are not allocated by the currently
> running kernel, it is not guaranteed that they are accepted before
> relocating the new kernel.
>
> Accept the destination addresses for the new kernel, as the new kernel may
> not be able to or may not accept them by itself.
>
> Place the "accept" code immediately after the destination addresses pass
> sanity checks, so the code can be shared by both users of the kexec_load
> and kexec_file_load system calls.

I am not at all certain this is sufficient, and I am a bit flummoxed
about the need to ever ``accept'' memory lazily.

In a past life I wrote bootup firmware, and as part of that was the code
to initialize the contents of memory.  When properly tuned and setup it
would never take more than a second to just blast initial values into
memory.  That is because the ratio of memory per memory controller to
memory bandwidth stayed roughly constant while I was paying attention.
I expect that ratio to continue staying roughly constant or systems
will quickly start developing unacceptable boot times.

As I recall Intel TDX is where the contents of memory are encrypted per
virtual machine.  Which implies that you have the same challenge as
bootup initializing memory, and that is what ``accepting'' memory is.

I am concerned that an unfiltered accept_memory may result in memory
that has already been ``accepted'' being accepted again.  This has
the potential to be wasteful in the best case, and the potential to
cause memory that is in use to be reinitialized losing the values
that are currently stored there.

I am concerned that the target kernel won't know about about accepting
memory, or might not perform the work early enough and try to use memory
without accepting it first.

I would much prefer if getting into kexec_load would force the memory
acceptance out of lazy mode (or possibly not even work in lazy mode).
That keeps things simple for now.

Once enough people have machines requiring the use of accept_memory
we can worry about optimizing things and pushing the accept_memory call
down into kexec_load.



Ugh.  I just noticed another issue.  Unless the memory we are talking
about is the memory reserved for kexec on panic kernels the memory needs
struct pages and everything setup so it can be allocated from anyway.

Which is to say I think this is has the potential to conflict with
the accounting in try_to_accept_memory.

Please just make memory acceptance ``eager'' non-lazy when using kexec.
Unless someone has messed their implementation badly it won't be a
significant amount of time in human terms, and it makes the code
so much easier to understand and think about.

Eric


> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
>  kernel/kexec_core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index c0caa14880c3..d97376eafc1a 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -210,6 +210,16 @@ int sanity_check_segment_list(struct kimage *image)
>  	}
>  #endif
>  
> +	/*
> +	 * The destination addresses are searched from free memory ranges rather
> +	 * than being allocated from the current kernel, so they are not
> +	 * guaranteed to be accepted by the current kernel.
> +	 * Accept those initial pages for the new kernel since it may not be
> +	 * able to accept them by itself.
> +	 */
> +	for (i = 0; i < nr_segments; i++)
> +		accept_memory(image->segment[i].mem, image->segment[i].memsz);
> +
>  	return 0;
>  }
>  
> base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b

