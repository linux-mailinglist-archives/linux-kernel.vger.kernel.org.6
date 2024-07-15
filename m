Return-Path: <linux-kernel+bounces-252872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DA193192A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0171F21F42
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503FF45016;
	Mon, 15 Jul 2024 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C5HP2OYj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378362421D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 17:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064226; cv=none; b=j4sNC5hdkwnByAqA6S+ugUwH7JmISGCNDkRONBTHj7T/xrJog/C/sg9GLXjGTbNCs0471GJrWWOFEzdSlplX3000kjFYSCtim70R9UHFMJe04QADcytj05XB+/WJKn0ShAh+KtdvFWrq0IU7tq6uiCUa//jTdDlRfMkxYgDtyTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064226; c=relaxed/simple;
	bh=Yn9UsdTXq5qs6s0t/ZhLNW2lYcFWMWhKSZF03l3zX5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+uj3K7UAwITOsHzc2+bWnTsvtCACY1qyrct/onvQv/OtSY1j5nm5CQaU05hAilsNSJNnIv7HNkaj/9qcIMMpafD6kUwibk4IcbVC3DC2+9/age8EDGL5xif1qkEaEC+DXqYVCvM/JMMHSW2QJbhQINLOc52lyLb7o4PkBj2Soc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C5HP2OYj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721064224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yn9UsdTXq5qs6s0t/ZhLNW2lYcFWMWhKSZF03l3zX5g=;
	b=C5HP2OYjbCJqjYUO5+aLeDZAq4vQALFIRezFNIPAAnuUq3ooe5qI7hhwhhu9pFvGZsvSK8
	JKecqCeJWtuddkg648dz1RXO/xep126jmzPnBkdjiOsekV2GcL7JCLCWRKrNHIba5p5qDM
	++8cA6+oO4lzq9ig+qGmMnOO4TS+dsA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-BLuKU4gvM56sSe62T6boQA-1; Mon,
 15 Jul 2024 13:23:37 -0400
X-MC-Unique: BLuKU4gvM56sSe62T6boQA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5346E1955F65;
	Mon, 15 Jul 2024 17:23:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.45])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8DA891955E8C;
	Mon, 15 Jul 2024 17:23:31 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 15 Jul 2024 19:21:57 +0200 (CEST)
Date: Mon, 15 Jul 2024 19:21:52 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>, mingo@kernel.org, andrii@kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add uprobes entry
Message-ID: <20240715172152.GA15187@redhat.com>
References: <172074397710.247544.17045299807723238107.stgit@devnote2>
 <20240715181417.6421de1e1a18a39685533115@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715181417.6421de1e1a18a39685533115@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07/15, Masami Hiramatsu wrote:
>
> Hi Peter, Oleg,
>
> If this is OK for you, please give your Ack.

Acked-by: Oleg Nesterov <oleg@redhat.com>


