Return-Path: <linux-kernel+bounces-343031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E4B98960D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 16:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 662AE1F226EE
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 14:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D48515C150;
	Sun, 29 Sep 2024 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ntk1Q4Wb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1298F6D
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727621425; cv=none; b=J3wq8u1rY+sXnOEPWL/sctwnqsCLhYnH0uQf4q8+cb4GUA4udNc75MQXnj9Hwvc4O9P/Pi6dEk3lIzkh4qY54C+dUAC/32gWFEK7HU7oyLbO8h5GMDsuTRjwiw3neQ8BkSfsMs6PoHvVFOl3VUC44Yhqb/swCcOYMJtMkSqfYlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727621425; c=relaxed/simple;
	bh=c2pFh8MSacF00zIPu9T+SlnGpQUPCGaMSgDq/bJR2Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLv6LFEZGPaGPnmzOCGcwNPG96FLGcI2wvAvZxwa5oxt0OjmnVXHwVojZq0kzDDCHG2GAJ0vl2EvQTuW+gIh8KOxMzZrEHIT8JDBNCeioo7Vu1Vaz8UkmVGLJcJFra2Dw/xSu/LgoeRa8g1lMz/yfxUpp7HmFVbTfG/QJtB1VZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ntk1Q4Wb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727621423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c2pFh8MSacF00zIPu9T+SlnGpQUPCGaMSgDq/bJR2Ps=;
	b=Ntk1Q4Wb63cSpbJ35Y8fFkQWmuJPMxQt+J6NnhNbjvObKErr1MdK9twt8w+sO0DhhRreS+
	FIXyGZhIS8fYJK7c1awLuiltWH3SbhEj/ifJ/deE8zopY/F5JFFQVTrT4+JTKLOY/qGDBk
	NHW55iZzSrb21yx9v6UETn0rVUqfVPU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-eww7pn4SMqGEash76t6VsA-1; Sun,
 29 Sep 2024 10:50:19 -0400
X-MC-Unique: eww7pn4SMqGEash76t6VsA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C936190ECE8;
	Sun, 29 Sep 2024 14:50:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.44])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 466451944B22;
	Sun, 29 Sep 2024 14:50:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 29 Sep 2024 16:50:04 +0200 (CEST)
Date: Sun, 29 Sep 2024 16:50:00 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Liao, Chang" <liaochang1@huawei.com>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: fix kernel info leak via "[uprobes]" vma
Message-ID: <20240929145000.GA8931@redhat.com>
References: <20240926162901.GA9716@redhat.com>
 <20240929223956.5043f74bc781a124e761f013@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240929223956.5043f74bc781a124e761f013@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 09/29, Masami Hiramatsu wrote:
>
> On Thu, 26 Sep 2024 18:29:01 +0200
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > xol_add_vma() maps the uninitialized page allocated by __create_xol_area()
> > into userspace. On some architectures (x86) this memory is readable even
> > without VM_READ, VM_EXEC results in the same pgprot_t as VM_EXEC|VM_READ.
>
> Good catch!
> I think we push this urgently and send it to stable tree too, right?

Agreed, can you route this patch?

> Fixes: d4b3b6384f98 ("uprobes/core: Allocate XOL slots for uprobes use")
> Cc: stable@vger.kernel.org

Will add this or should I resend with these tags included ?

perhaps the changelog should mention that debugger can read this memory
regardless of pgprot_t...

> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

Oleg.


