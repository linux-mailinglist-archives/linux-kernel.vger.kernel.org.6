Return-Path: <linux-kernel+bounces-285434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DBF950D73
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6B21F2313C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6ED1A3BDD;
	Tue, 13 Aug 2024 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hnNncHiF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDB555898
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 19:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723579117; cv=none; b=DEjF4O8p+3rB5jB87OJuEvyxZtf7EsrovJNsU4bWYm25+TL+P8mWrvgR+MKm4f1sLx6g8g+V22PFwm8xXSAFfNHhYmOi/f+ifH8B4H+MdaiPRR+FLkraGsDeH6/1mhrLa7sblC9wL4G5ShE0zXdnpuUiNrKpLYKSuiqnZUvBdZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723579117; c=relaxed/simple;
	bh=+nXgt26wlSBMSb6FGMTM9riOviaDIeeL5n12zf7YFKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PxyL8E6YBcSML9KASH+CgD0P8Al0Kf59B6hAY6oRAnFPGGTKx16/jo+h4Zan+/O1IKSSkalEvvqjSBjwzfOPAlGEpi2mcwj6+AcsRIOe6nJJdyT0MH0/qq4SvgtKwkxlWcXu31XdNuxxQs3P6iWXZt8rryPNbUYorNdTKC22ZUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hnNncHiF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723579115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yLCM8/C9gTPKJe0A6J9d70v78GMU1T9JDD/hkFZE3ks=;
	b=hnNncHiFtufhrWjno1y+PnR3g6T2b5yjo7Ujp7lwn+3uCRAPz6I39k5CJ7DM7RL69gds/T
	rZZ1yiAeRJfouDFE4tiMieba9DKd7mOYYteErxCgEqS7s/lg3CpIvQZwPgszWpofJHMuC1
	bcqX6xIeDtbt/R7Yn07AW7gXKfE+bEU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-OsHI6CCuNPyyjZErEFIVZw-1; Tue,
 13 Aug 2024 15:58:32 -0400
X-MC-Unique: OsHI6CCuNPyyjZErEFIVZw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D4A41956080;
	Tue, 13 Aug 2024 19:58:31 +0000 (UTC)
Received: from [10.2.16.208] (unknown [10.2.16.208])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9D93819560AA;
	Tue, 13 Aug 2024 19:58:28 +0000 (UTC)
Message-ID: <5d54a189-3c2b-440a-9626-4e00e95a7f77@redhat.com>
Date: Tue, 13 Aug 2024 15:58:27 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] Avoid memory barrier in read_seqcount() through load
 acquire
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: cl@gentwo.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240813-seq_optimize-v1-1-84d57182e6a7@gentwo.org>
 <183ee6fa-1d42-4a01-8446-4f20942680d2@redhat.com>
 <CAHk-=whgwpzsn9XvZt3zRgP87r4mSScD04P_g5JeiR1irN3vRA@mail.gmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <CAHk-=whgwpzsn9XvZt3zRgP87r4mSScD04P_g5JeiR1irN3vRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40


On 8/13/24 15:48, Linus Torvalds wrote:
> On Tue, 13 Aug 2024 at 12:01, Waiman Long <longman@redhat.com> wrote:
>> Do we need a new ARCH flag?
> I'm confused by that question.
>
> That's clearly exactly what that ARCH_HAS_ACQUIRE_RELEASE is.
>
> Obviously all architectures "have" it - in the sense that we always
> have access to a "smp_load_acquire()/smp_store_release()".

Sorry for the confusion. What you said above is actually the reason that 
I ask this question. In the same way, smp_rmb()/wmb() is available for 
all arches. I am actually asking if it should be a flag that indicates 
the arch's preference to use acquire/release over rmb/wmb.

Cheers,
Longman

>
> But if the architecture doesn't support it natively, the old rmb/wmb
> model may be preferred.
>
> Although maybe we're at the point where we don't even care about that.
>
>                Linus
>


