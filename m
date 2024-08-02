Return-Path: <linux-kernel+bounces-273209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA91B9465D3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 00:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C56E1C2150A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 22:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C031311A1;
	Fri,  2 Aug 2024 22:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GM14bqcA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A1AB67E
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 22:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722636628; cv=none; b=q2cIsk7NAxmKu4z/XpwexOy/2pR7mfOp+jiiEG9mAoEyj4NhZUsHlV1qOjRWJiHHoFNmHyyPqLjmnatKGQVjNkj9yf9DcIvZzi3IgbRGNz0P8zg4P77pZB+OU8psTCdkJLwwGREkbJ9V01iGbJOam6nk6Hr1RltezMJ70iWVx9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722636628; c=relaxed/simple;
	bh=qVTNY6Ek3gg4RffaCCvAEtIiPl1yNu8kiBIMgr+IIzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8uCx30irRmZs5uSh2yD7NhIy82W4Kh8X+AIZIbFweOpZ5jg6Fzm5+yZLi9EQLvgQbj57JrTKqtXPlavIM8hjG10cwncjKAynUgENUNJz3XAv9cw5jjphZSk66lDzblRcZGyuhkkdZmUTA9XwLBTXi/eA1LvwJZBoRoAMZ2sSXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GM14bqcA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722636625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWfuEBz0eya2VqN4v2o50upcIiV0ptJawqIrIxmzgcE=;
	b=GM14bqcABwF7nJ3tEP5UkuGShvDlj5qQaCOVjXZ6YwtL8oGxQCHyILjC1sptpKTLBa9mdN
	qdEZ2rY6yCcEK9K/HyaMhUCNmjKduEteVeIOvDJtt33II49OjI3NtEj7o+55aFGWNAPwn1
	fbmcziitnM2gQkxK8BvMgOfQRsYn58A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-OsoR8C-EOPOdu9-IZmsTJQ-1; Fri,
 02 Aug 2024 18:10:21 -0400
X-MC-Unique: OsoR8C-EOPOdu9-IZmsTJQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 852191955D50;
	Fri,  2 Aug 2024 22:10:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.3])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1F87E19560AE;
	Fri,  2 Aug 2024 22:10:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat,  3 Aug 2024 00:10:17 +0200 (CEST)
Date: Sat, 3 Aug 2024 00:10:14 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: build failure caused by RUNTIME_CONST()
Message-ID: <20240802221014.GA20135@redhat.com>
References: <20240802114518.GA20924@redhat.com>
 <CAHk-=wguPQZKfWdNjF8OedfttMNkrW57Kb5Wjv0NmTzoEbUG7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wguPQZKfWdNjF8OedfttMNkrW57Kb5Wjv0NmTzoEbUG7A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/02, Linus Torvalds wrote:
>
> > The patch below seems to fix the problem, but I didn't find any report on lkml,
> > so perhaps I am the only one which hits this problem? And perhaps this is because
> > my gcc 5.3.1 is quite old?
>
> It's not your gcc. It must be your linker that is old and decrepit.

Ah, sorry. Of course I understood that this must ba a linker issue, sorry for
confusion!

	$ ld -v
	GNU ld version 2.25-17.fc23

> > OTOH, I know nothing about lds magic, so I fail to understand where these
> > __start/stop_runtime_xxx can come from without something like the change below...
>
> So it comes from this:
>
>     https://sourceware.org/binutils/docs/ld/Input-Section-Example.html
>
> and in there you will find
>
>    "If an output section’s name is the same as the input section’s name
>     and is representable as a C identifier, then the linker will
>     automatically see PROVIDE two symbols: __start_SECNAME and
>     __stop_SECNAME, where SECNAME is the name of the section. These
>     indicate the start address and end address of the output section
>     respectively"

Thanks!

> but apparently your linker doesn't do that.

apparently yes,

> I guess we'll have to go with doing this manually as in your patch,

OK... so if you think it makes sense to support the old toolchains,
perhaps you can commit the "proper" patch?

I can try to polish my hack, but as I said I don't understand this magic,
and I can only test the build on x86.

Oleg.


