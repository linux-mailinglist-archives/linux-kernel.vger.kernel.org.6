Return-Path: <linux-kernel+bounces-534619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C72A4693B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8FB5188DADD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B3A2253A4;
	Wed, 26 Feb 2025 18:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQp5Qxbg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E2522F384
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593615; cv=none; b=sjvMtRQE0ZRhuoxvoizTYzodBsKQENfSfn+x+NVnWhLmEb0Em3RMivYe2P4s/D+cWuCEN+uRbCKZFbRpAaAY5rjh1VZg+OY3cGtN0hi4V8z7S2WQl9uBxh8bJAT8oNSwfNUk//WgbPihmfrLTH7lKn5z/5cOLuky/4wJ27xbuDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593615; c=relaxed/simple;
	bh=XLAtlLUXwKK8ny06xKZ7zYu8j6udBGfXLlBXiJ9RE3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bH0a6tQqxU0+dufaq/+aT3MGUPA9XvUBt5KoKgqR1tDIUCfaNw5UwbOUuPAef545umtGkIf1J/xfIt3az3FeLxh3MDJZBHMCcU2FRhQi+EzvKO3UuWoITFcoq8eYCjGLvfj9Xo2/zdZb+lUsQSCHbrOB7fDJ8LVnoWwqCSFhUaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZQp5Qxbg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740593612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XLAtlLUXwKK8ny06xKZ7zYu8j6udBGfXLlBXiJ9RE3k=;
	b=ZQp5QxbgK6lFCxxhBQirYe4UHdB175Zst8vVhHc4pxQ3Pr+s5qSV4PWBT9l985HSR03GGR
	HK9w5CiH9YnNuk0FC/tBDCPBdhYRUTekVCjtKE0S1ZS0uhKtX5+guShnS3V66z5+xEyudP
	/Y5FWwaU2ZGQ+tG3qzymXnYadxXD6KA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-2kt4h1ThNnaDv1YG9PAUkg-1; Wed,
 26 Feb 2025 13:13:22 -0500
X-MC-Unique: 2kt4h1ThNnaDv1YG9PAUkg-1
X-Mimecast-MFC-AGG-ID: 2kt4h1ThNnaDv1YG9PAUkg_1740593600
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5EFC71800876;
	Wed, 26 Feb 2025 18:13:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.247])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9F3EF19560B9;
	Wed, 26 Feb 2025 18:13:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 26 Feb 2025 19:12:50 +0100 (CET)
Date: Wed, 26 Feb 2025 19:12:20 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
Cc: Manfred Spraul <manfred@colorfullife.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	Neeraj.Upadhyay@amd.com, mjguzik@gmail.com
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250226181220.GJ8995@redhat.com>
References: <20250102140715.GA7091@redhat.com>
 <e813814e-7094-4673-bc69-731af065a0eb@amd.com>
 <20250224142329.GA19016@redhat.com>
 <20250225115736.GA18523@redhat.com>
 <2a0a8e1e-1c37-4655-8a82-54681b2a83ae@amd.com>
 <20250226113845.GB8995@redhat.com>
 <b8f0fc4c-7b54-4bec-b3cf-9e0b542832f4@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8f0fc4c-7b54-4bec-b3cf-9e0b542832f4@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 02/26, Sapkal, Swapnil wrote:
>
> >Can you reproduce with "--process" rather than "--threads" ?
> >
> I was able to reproduce the issue with processes also. Total 33 processes
> were sleeping out of which 20 were readers and 13 were writers.

Thanks a lot. I am wondering what makes your machine (or .config?)
special ;) A lot of people and robots tested this patch with these
options.

> The stack trace for main hackbench process is as follows:
>
> [<0>] do_wait+0xb5/0x110

Yes, this is clear, the main thread/process is not interesting.

> I am trying to reproduce the issue with suggestions by Mateusz.

Great.

So far I still have no clue. Most probably I will ask you to do
more testing after that, perhaps with some debugging patches.

Thanks again for your help,

Oleg.


