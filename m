Return-Path: <linux-kernel+bounces-278392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D907C94AF9F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9149E1F22EDA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE0813A25F;
	Wed,  7 Aug 2024 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E6/ZoS25"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3866263CB
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055092; cv=none; b=hzkGzl/L9YZIr8II2ru4TjXuD0NYHmXh0TI0CPgSaAS1HD95r+2og8XW3wKYOCkVN2o7EX4jbuc0JFrCw8uo/4sZstQuhQQDsCD4k+yMcDlrS/6ntIHFqg4P+4F7Zcuoa93liAPfWB1FizMp/y28VRtPzljaZHXTlbmql9q3mG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055092; c=relaxed/simple;
	bh=9D2wJx7b2TcE05VUmWhYDYryIterDH+F2PD6mBFHDzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiDagHK9PF0s55hkWUPBrVyFDJZG5kq/FsWAXNL+YV2ypZRFVli4TqbAx6UqsZllzIfDXKY6qJa4pWAG5nsKV2UHITsmfV1ubCsyC2KHSkWjG2I9hBjGRYgHqvL+4HMVqb03P843v6AtX2nAh882E6FYcJFS6z/q0LYe2/i2Wgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E6/ZoS25; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723055090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9D2wJx7b2TcE05VUmWhYDYryIterDH+F2PD6mBFHDzQ=;
	b=E6/ZoS25dEYIL/qPLuYdKrJD+76o8R+w6/QJVhB+9KhNkYsQVXXeztCJO3gaCo5M5QhiXR
	5YOo1xdsOWb2eeJi5YGKl3lrPRqBql2xIbGmDCqWslap71X3F9CBrZ1XtPAuo1+gh4pTux
	t40HAoRltShusA9If0eJXkZkXWuWuYU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-8TT0jHODPPu6z4IrG3IxQQ-1; Wed,
 07 Aug 2024 14:24:48 -0400
X-MC-Unique: 8TT0jHODPPu6z4IrG3IxQQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 93B07195608A;
	Wed,  7 Aug 2024 18:24:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.97])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4464319560A7;
	Wed,  7 Aug 2024 18:24:41 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  7 Aug 2024 20:24:44 +0200 (CEST)
Date: Wed, 7 Aug 2024 20:24:39 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Liao Chang <liaochang1@huawei.com>, Andrii Nakryiko <andrii@kernel.org>,
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH 0/8] uprobes: RCU-protected hot path optimizations
Message-ID: <20240807182438.GE27715@redhat.com>
References: <20240731214256.3588718-1-andrii@kernel.org>
 <20240807132922.GC27715@redhat.com>
 <CAEf4BzZSyuFexZfwZs1bA9S=O0FHejw_tE6PXm5h8ftMsuSROw@mail.gmail.com>
 <20240807171113.GD27715@redhat.com>
 <CAEf4BzZ8SaFK4iMtPPxYZQjHOvaPqpKApE8=Bz+h29xq+xMEsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ8SaFK4iMtPPxYZQjHOvaPqpKApE8=Bz+h29xq+xMEsA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/07, Andrii Nakryiko wrote:
>
> Are you going to send a patch with
> your bool flag proposal?

No, I will wait for the next version from Liao.

If he agrees with my comments. If not, we will continue the discussion in that thread.

Note also another patch from Liao which removes ->siglock from uprobe_deny_signal(),
https://lore.kernel.org/all/20240731095017.1560516-1-liaochang1@huawei.com/

Oleg.


