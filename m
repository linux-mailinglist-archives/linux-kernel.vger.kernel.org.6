Return-Path: <linux-kernel+bounces-248154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1B092D8FA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B91AD1C20B5B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11650197A7E;
	Wed, 10 Jul 2024 19:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4rVl3Lr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C597195B18
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639338; cv=none; b=qX9HNW9MDp3+xJf+GXe2rnmSC3RSgpLxSUpJujHQ/UUg8hmORKSGN4gPAAdByjVcT8OK85aP6+eHZjcg9Y2K1oRiLeIibcjAKqVlDTcUYRSN1JKBns/NUA/j5DoLVQ3yU+/vUPSDnEDV6pJyMcr9sLh3+cbuQKCq0ZgPcEijbMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639338; c=relaxed/simple;
	bh=99x6lVqOqvCeYjSn4ZVj1ng4JSR9mJnd4vgkrC8bLuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtWOvWdfw4EFCNX9OOk99xzwHTwlrWVjJGUN76RmkrJfAq1pDQNQ4DWY/Z/qE/unEg0cKf1orgm9GQKWgkY0POP3/MsLIpFkrulYWdlWYjkji9c4ecUAJgCHOagkSwGDCHPQaqxIzuH/DxBtEaAueT+/CfdP5MubNkGIrDWciuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D4rVl3Lr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720639336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y3V+UTq3bUwpxp49KcL5gUmo7ySjSLLopUv0X+VkkZ4=;
	b=D4rVl3LryfazPgVWxFO4ZaXrrBTa4TfPlhdV250ti5BzxMeUMn3hKQRYSAvjl+J4YvSDed
	LZZCn88GYjuRQladJ2iah00HTDoWje1cyjBMBy1U0BTCRZl3GlGTtE12okMSNiZXk7Rf2L
	VJLtgZozVRsdKpen356vK4FKBGdHZA4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-PWoPkXAiPE2SlRD_Zg8MJA-1; Wed,
 10 Jul 2024 15:22:11 -0400
X-MC-Unique: PWoPkXAiPE2SlRD_Zg8MJA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2A831955F40;
	Wed, 10 Jul 2024 19:22:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.169])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B2D5E1955F40;
	Wed, 10 Jul 2024 19:22:05 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 10 Jul 2024 21:20:33 +0200 (CEST)
Date: Wed, 10 Jul 2024 21:20:28 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org,
	clm@meta.com, mingo@kernel.org, paulmck@kernel.org,
	rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] uprobes: make uprobe_register() return struct uprobe
 *
Message-ID: <20240710192027.GE9228@redhat.com>
References: <20240710140017.GA1074@redhat.com>
 <20240710163022.GA13298@redhat.com>
 <20240710163133.GD13298@redhat.com>
 <Zo67c9nvbRD0h4-b@krava>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo67c9nvbRD0h4-b@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07/10, Jiri Olsa wrote:
>
> > @@ -3180,10 +3181,8 @@ static void bpf_uprobe_unregister(struct path *path, struct bpf_uprobe *uprobes,
> >  {
> >  	u32 i;
> >
> > -	for (i = 0; i < cnt; i++) {
> > -		uprobe_unregister(d_real_inode(path->dentry), uprobes[i].offset,
> > -				  &uprobes[i].consumer);
> > -	}
>
> nice, we could also drop path argument now

Indeed, I missed that. Will send V2 when/if this makes any sense.

Thanks!

Oleg.


