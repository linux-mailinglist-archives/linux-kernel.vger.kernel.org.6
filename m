Return-Path: <linux-kernel+bounces-185091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD99C8CB060
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4672AB267F8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D199130A6F;
	Tue, 21 May 2024 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BcC+kn0q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A7513048D
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716301462; cv=none; b=Ht/jXcPHQdXnyz/VpWOHmXc9sk3MQg4Si+HE8LOkLtXiH3zWw06x5gOoy6PHmq89pg6QcLcJgaw1qhkSs1Wg8REVcPydcmatA9OkVBKBQwh4G6i/tpybFflbzJ/j1TQ21w0PY01gud2IrnZlIcCNcxDU13+a8xVNQKTHDxeJlAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716301462; c=relaxed/simple;
	bh=tfhs4G1UxiGQsBmQ8SRV1xtzgUc9WBEgAUO1utJnNF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0QYPZbXNKaq+blMzroJiE6TbOCDg02pey+1svVaANYwNNTgLv0Hnpyb4sJ/v++tfJ5Pct4NLBaP+N9Ai5IoDHSnc47TSLP5Yylt/JtqiSDIuFSuujEDEHzHPSWmD4QyvWGBwPRE/h+kQbS82YhqIZdnmyQeVlV5Y5Cej68ASmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BcC+kn0q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716301460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tfhs4G1UxiGQsBmQ8SRV1xtzgUc9WBEgAUO1utJnNF0=;
	b=BcC+kn0qLh+yFfZiRhtW95a5JJbuKaawHXcJqc0+z6sHe8JkTErFJ8XCjcaV3yWpmra1iG
	3hPXFN7oTIbX20HoiVCQBljJNEda23Okv/xZ5wY2xK/+tG62P5zFqwgsqJhadUb0sz0ftt
	Pj07vfY7kfwkrNxFnQr7ss9eqgn42vU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-nhnsxC0UO6SnsoRjeBDPPg-1; Tue,
 21 May 2024 10:24:12 -0400
X-MC-Unique: nhnsxC0UO6SnsoRjeBDPPg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C79A11C03150;
	Tue, 21 May 2024 14:23:53 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.64])
	by smtp.corp.redhat.com (Postfix) with SMTP id CBF361C0948E;
	Tue, 21 May 2024 14:23:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 21 May 2024 16:22:27 +0200 (CEST)
Date: Tue, 21 May 2024 16:22:21 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>
Subject: Re: [PATCHv6 bpf-next 1/9] x86/shstk: Make return uprobe work with
 shadow stack
Message-ID: <20240521142221.GA19434@redhat.com>
References: <20240521104825.1060966-1-jolsa@kernel.org>
 <20240521104825.1060966-2-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521104825.1060966-2-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 05/21, Jiri Olsa wrote:
>
> Currently the application with enabled shadow stack will crash
> if it sets up return uprobe. The reason is the uretprobe kernel
> code changes the user space task's stack, but does not update
> shadow stack accordingly.
>
> Adding new functions to update values on shadow stack and using
> them in uprobe code to keep shadow stack in sync with uretprobe
> changes to user stack.

I don't think my ack has any value in this area but looks good to me.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


> Fixes: 8b1c23543436 ("x86/shstk: Add return uprobe support")

Hmm... Was this commit ever applied?

Oleg.


