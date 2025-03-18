Return-Path: <linux-kernel+bounces-566028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1505A67240
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EB613A6802
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9575120A5C6;
	Tue, 18 Mar 2025 11:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JR43gLZ/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CF5EAC6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742296212; cv=none; b=rCUSjKGmAT4KyAtIqqXYUfgVwxXjd2SLcNhK3zfcq87eIyQ3loRLdNyIBvq5dLLLJTY8creTW/ClBg4ezv4IdRVkZq/WDBGXmU3fRZ1Omwm8v8fTurMPZjcOqLf7334agZxTOm3PsVJIw+c89thS0fHorjEgZZqA2yklY8d+1dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742296212; c=relaxed/simple;
	bh=t+8aTqYJiQhc0a1Cq0clXumsHtAtEQPDhAUx+L34SlY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=uk0zq0cpEp3YwX+bJdrjh4H57mSp38ddw8H8f/wyUrG7e/wTiCg9yxLFhh/mZCr2X4KYaZ8Z5Q4cGm8oUcj9070Tbt0Os9v2OIMykmT16EqRldOPM4SGMxogh2fbwE6MchH3K0hy5eRQSB8InQBJolDWu3RXQZquFRAZ12HxW84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JR43gLZ/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742296210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sKeYGMJn+qJhMLwvqdHnSj6tekdHaiz41QSP0i4UJ1I=;
	b=JR43gLZ/xXO1uUCnLYVvk7fYeIDheSsJo86YXhAw+vKNlYaF5eb8g3hN0HrpfDqVosb5Yv
	pxrUCKoEW3wZ95gthx2lVKWD3QWeJ1K1YZgp116dwg/l1Yiil9kOIDc5i5ems0Nn4IXw1h
	T3ow8D9lXntP62/m+tIejt1LrWGGpto=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-S2ICisW3N-ez1TjWWeeXYA-1; Tue,
 18 Mar 2025 07:10:08 -0400
X-MC-Unique: S2ICisW3N-ez1TjWWeeXYA-1
X-Mimecast-MFC-AGG-ID: S2ICisW3N-ez1TjWWeeXYA_1742296206
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA77E1800EC5;
	Tue, 18 Mar 2025 11:10:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.61])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7814718001EF;
	Tue, 18 Mar 2025 11:10:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAMuHMdX0ShSafh44_D7D9GW5OzxYPx1NUc4uxpsKe1jAiTsBaA@mail.gmail.com>
References: <CAMuHMdX0ShSafh44_D7D9GW5OzxYPx1NUc4uxpsKe1jAiTsBaA@mail.gmail.com> <20250203142343.248839-1-dhowells@redhat.com> <20250203142343.248839-4-dhowells@redhat.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Herbert Xu <herbert@gondor.apana.org.au>,
    Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David
 S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>,
    Trond Myklebust <trond.myklebust@hammerspace.com>,
    Chuck Lever <chuck.lever@oracle.com>,
    Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
    linux-crypto@vger.kernel.org, linux-afs@lists.infradead.org,
    linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 03/24] crypto: Add 'krb5enc' hash and cipher AEAD algorithm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2481241.1742296198.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Mar 2025 11:09:58 +0000
Message-ID: <2481243.1742296198@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> > +         Combined hash and cipher support for Kerberos 5 RFC3961 simp=
lified
> > +         profile.  This is required for Kerberos 5-style encryption, =
used by
> > +         sunrpc/NFS and rxrpc/AFS.
> =

> Hence shouldn't the latter (e.g. RPCSEC_GSS_KRB5) select CRYPTO_KRB5ENC
> or CRYPTO_KRB5? Or am I missing something?

SunRPC hasn't been converted to use it yet.  The help text is slightly
misleading, I guess: "Kerberos 5-style encryption" is used by sunrpc/NFS
within the kernel, but not this library yet.

Unfortunately, the rxrpc/AFS patches didn't make it in due to them requiri=
ng
to go through the net-next tree, but having dependencies on both the VFS t=
ree
and the crypto tree.

Herbert wanted the crypto patches (krb5 lib) based on his tree, which I di=
d
and he pulled it - but then this disqualified it for also being pulled int=
o
net-next as that would've pulled *all* the crypodev patches there as well.

For reference, the rxrpc patches can be found here:

	https://web.git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git=
/log/?h=3Drxrpc-next

I intend to post them for net-next inclusion after the merge window.

David


