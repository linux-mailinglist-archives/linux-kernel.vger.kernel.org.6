Return-Path: <linux-kernel+bounces-425727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391309DE9D0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C35BB21A44
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 15:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45999147C9B;
	Fri, 29 Nov 2024 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZAXMG/mu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F07A145324
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732894842; cv=none; b=TUN797ngkE4mIieZhSfgb0uLfklFa/G2mpqwAPRVdGx2/N4QpmELgI61uYqCXc9xejkcC7GYENkattbmUEM283KsvrMsQPICw6rQv4RwPRNkPwhQPh3puzm+wGM1UXID1hqF0Vr3z4m84g7vapSAFhkhYOHmQzHbmfJ/Z9uDhZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732894842; c=relaxed/simple;
	bh=DQXV/lX8AJAyksuQYh2MDAxaCLo9dBy1c30SxH08BIE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F8llbOsEkPoV4WxDUd6O6NJkRIh+x7C6L05dXCQhBY5XsKsp3Wvcobk2GDdarnbDCUW2JkhTi6z3MUjwy4g4r+rjx+Oa1lq5E5XqcoRFpurJnZRReZ88kQ+9sIplDDW5uZ606eCkJiU6YTkhvWxwfjGPtwvLWmJTeEP024I+SaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZAXMG/mu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732894839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=xRleUaVI6FgVOpMR9bWasugQRlKLiDLyf42yxmaI4Ms=;
	b=ZAXMG/muxAn99MwqGccorkWgnmQyjiHXxPiEUwnhsBwJotQSKKAdxg6RJJx1tbXQwcLTd3
	G47PMm6wL1XKrHAhWcdbU9UvhITJ55cRTWvGHCfUrDeW+9gbNVvdfv5fRnC3QIrEKlCxHM
	TrxDre10yUO5L30wg0qu1nj26XWlgHY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-SaAcaoD0NKWeiYmxV0rLfA-1; Fri,
 29 Nov 2024 10:40:35 -0500
X-MC-Unique: SaAcaoD0NKWeiYmxV0rLfA-1
X-Mimecast-MFC-AGG-ID: SaAcaoD0NKWeiYmxV0rLfA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17212195419B;
	Fri, 29 Nov 2024 15:40:34 +0000 (UTC)
Received: from localhost (unknown [10.42.28.6])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 27C33195608A;
	Fri, 29 Nov 2024 15:40:32 +0000 (UTC)
Date: Fri, 29 Nov 2024 15:40:31 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
To: David Rheinsberg <david@readahead.eu>, linux-kernel@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86/insn_decoder_test: allow longer symbol-names
Message-ID: <20241129154031.GA7195@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

[Sorry for possible mail threading errors, I don't have the original
email in my archive.]

We're hitting the bug mentioned in this old patch:

[https://lore.kernel.org/lkml/Y9ES4UKl%2F+DtvAVS@gmail.com/T/]

> Increase the allowed line-length of the insn-decoder-test to 4k to allow
> for symbol-names longer than 256 characters.
> 
> The insn-decoder-test takes objdump output as input, which may contain
> symbol-names as instruction arguments. With rust-code entering the
> kernel, those symbol-names will include mangled-symbols which might
> exceed the current line-length-limit of the tool.
> 
> By bumping the line-length-limit of the tool to 4k, we get a reasonable
> buffer for all objdump outputs I have seen so far. Unfortunately, ELF
> symbol-names are not restricted in length, so technically this might
> still end up failing if we encounter longer names in the future.
> 
> My compile-failure looks like this:
> 
>     arch/x86/tools/insn_decoder_test: error: malformed line 1152000:
>     tBb_+0xf2>
> 
> ..which overflowed by 10 characters reading this line:
> 
>     ffffffff81458193:   74 3d                   je     ffffffff814581d2 <_RNvXse_NtNtNtCshGpAVYOtgW1_4core4iter8adapters7flattenINtB5_13FlattenCompatINtNtB7_3map3MapNtNtNtBb_3str4iter5CharsNtB1v_17CharEscapeDefaultENtNtBb_4char13EscapeDefaultENtNtBb_3fmt5Debug3fmtBb_+0xf2>

in Fedora:

  https://bugzilla.redhat.com/show_bug.cgi?id=2329496

I notice that BUFSIZE is still set to 256.  Setting it to 512 fixed
the problem for me, although I understand that this is just a hack.

Was there any further effort to get this patch upstream?

Unfortunately I don't know what exact symbol is overflowing in the
Fedora case, but we do have a very full-featured kernel, including
Rust enabled (if that is relevant).

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v


