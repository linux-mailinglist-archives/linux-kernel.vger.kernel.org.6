Return-Path: <linux-kernel+bounces-273463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F769946991
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 14:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 849891C20B5C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 12:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2AB13A24D;
	Sat,  3 Aug 2024 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hg5cnB9R"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DE8D53B
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 12:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722686508; cv=none; b=RfDtwiIFiPGu9cQ5K0W2xq+tY1BR0bseevMhQAQHHR4zj6lEVICLxJ1R1YZIpULrtB6k5sRoPLWJWZbWnyrW3qfqmNnj8qvduw+8ix3rlRE5pHgJ6OLZNMQmgsP0m7NlxHJGxSA3iIy2P0H9D5/+rnb+qbgTNh3qUPzZBoA5yWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722686508; c=relaxed/simple;
	bh=PVG0QbWIy3Jq7tpWfEuAUfWg24Bbkqc47qZiyrZ6K3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1q43YbcRymJoCLmmfzqYzhVSu0qZZRbEMKhqy0TeuNkWDNTsSYbPTMqAaPlcgvW4VHFVMDFN+8VvCZ8V5Q2xfDhdOdEKPHniQYJD4O/B/1ZzgWk71545o3rU1HwZjnTnJUVuTcUsdLGkzNRpdzt8W8ktYEUU+D7hfMYW6qHsC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hg5cnB9R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722686504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlJJoPFs7kAko2Wub4McShsSW/Sq7VRaJRZBtkgUMog=;
	b=hg5cnB9RiZrx2x9BQuRy2fNdYy4KQwTisCF5Mg9xgusCeFpExoyMwCT3ZDe3rjf2BGVf5z
	Cxn9ai8kwtKN0VikBYHr5MpdLGWl9R0b+ofkxfyuaQGva6SP/wHkGmqMk2zhpjFVYGQhod
	2bmtHA4qf3UnvdjdFy3HU8Utzbxbpwc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-GoQdeSckPJ-1AGUaZehDUg-1; Sat,
 03 Aug 2024 08:01:41 -0400
X-MC-Unique: GoQdeSckPJ-1AGUaZehDUg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C0441956080;
	Sat,  3 Aug 2024 12:01:40 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.44])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2DA1F1955E80;
	Sat,  3 Aug 2024 12:01:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat,  3 Aug 2024 14:01:39 +0200 (CEST)
Date: Sat, 3 Aug 2024 14:01:37 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: build failure caused by RUNTIME_CONST()
Message-ID: <20240803120136.GA2986@redhat.com>
References: <20240802114518.GA20924@redhat.com>
 <CAHk-=wguPQZKfWdNjF8OedfttMNkrW57Kb5Wjv0NmTzoEbUG7A@mail.gmail.com>
 <20240802221014.GA20135@redhat.com>
 <CAHk-=wiXK4cc8ikqN15vfi2+wsYJYh08qH8qzCpy+08Gh9whLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiXK4cc8ikqN15vfi2+wsYJYh08qH8qzCpy+08Gh9whLw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 08/02, Linus Torvalds wrote:
>
> On Fri, 2 Aug 2024 at 15:10, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> >         $ ld -v
> >         GNU ld version 2.25-17.fc23
>
> Yeah, we document that we support building with ld-2.25.

Where? I tried to grep Documentation/ but didn't find anything...

> Reported-by: Oleg Nesterov <oleg@redhat.com>
> Link: https://sourceware.org/binutils/docs/ld/Input-Section-Example.html [1]
> Link: https://lore.kernel.org/all/20240802114518.GA20924@redhat.com/
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Tested-by: Oleg Nesterov <oleg@redhat.com>

But,

> -#define RUNTIME_NAME(t,x) runtime_##t##_##x
> +#define NAMED_SECTION(name) \
> +	name : AT(ADDR(name) - LOAD_OFFSET) ALIGN(8) \
                                            ^^^^^^^^
it seems that all other section do

	. = ALIGN(x); name : ...

was this change intentional?

Oleg.


