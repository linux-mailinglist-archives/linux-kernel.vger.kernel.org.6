Return-Path: <linux-kernel+bounces-327882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A148F977C3A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 160FFB23B93
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40611C1ADD;
	Fri, 13 Sep 2024 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WSoEobQb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7421C230C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726219964; cv=none; b=MbdA63JQEKESLdDDfKAhQOylQ7V8pNdQ0bxqc5MNJqBsqeSMT65ai6Yd35oiCzFEpQYCfenUY17bwYLRKblbPt6F8QmI7CzkZgRIXZJ7eemvkPfZ6eEiPKHhG3dwC8PQbACwPiGWBmsEpQDR5N8/xvGr+rzh+cg5nyTVXzMo1gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726219964; c=relaxed/simple;
	bh=4O2NPtM1NLF8/x7jRBau7jSt45OgkOZjXoYGaAykKhw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=IxMWdKzKj44oGjs2lhYWzkuEcJq84fCAdPTiRVBaCtP2KUhVTDDhWvtVffPFPgpd7CA+8RozLw4w8MTq77YVNYn27MZosrvcliapOAAEEr1uPSs4axdvb7oTvgvJUT3zgXn3dBjiRvnDH6STIZXDn7tVwrhIpr22XcxEVMqrxMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WSoEobQb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726219961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pKVcQh0mMWfw7YNLqAXgPrezuHhuotyVKCaDrGzitZI=;
	b=WSoEobQb8ga/5EjTB8LtEicyTEb0daigoLiFLCc3xnatnar5XgNHnDRBZll4jTHLWAaMKf
	1agGT009LRiSh6gVoypxkg5bWyeY2+KhuKvvz2l3Og1SRQ3Kje+t+HiwS8yf33OXJloGcc
	NbGLOIMaXE0fMQbhtO7MUIAQ0PYLnJc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-lLH3y46ROHGoR321_9vN-A-1; Fri,
 13 Sep 2024 05:32:38 -0400
X-MC-Unique: lLH3y46ROHGoR321_9vN-A-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA49D19560AB;
	Fri, 13 Sep 2024 09:32:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D2B8C1956086;
	Fri, 13 Sep 2024 09:32:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZuPDZL_EIoS60L1a@gondor.apana.org.au>
References: <ZuPDZL_EIoS60L1a@gondor.apana.org.au>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dhowells@redhat.com, Roberto Sassu <roberto.sassu@huaweicloud.com>,
    dwmw2@infradead.org, davem@davemloft.net,
    linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
    linux-crypto@vger.kernel.org, zohar@linux.ibm.com,
    linux-integrity@vger.kernel.org, torvalds@linux-foundation.org,
    roberto.sassu@huawei.com
Subject: Re: [PATCH v3 00/14] KEYS: Add support for PGP keys and signatures
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1266434.1726219950.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Sep 2024 10:32:30 +0100
Message-ID: <1266435.1726219950@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Herbert Xu <herbert@gondor.apana.org.au> wrote:

> Personally I don't think the argument above holds water.  With
> IPsec we had a similar issue of authenticating untrusted peers
> using public key cryptography.  In that case we successfully
> delegated the task to user-space and it is still how it works
> to this day.

It transpires that we do actually need at least a PGP parser in the kernel=
 -
and it needs to be used prior to loading any modules: some Lenovo Thinkpad=
s,
at least, may have EFI variables holding a list of keys in PGP form, not X=
.509
form.

For example, in dmesg, you might see:

May 16 04:01:01 localhost kernel: integrity: Loading X.509 certificate: UE=
FI:MokListRT (MOKvar table)
May 16 04:01:01 localhost kernel: integrity: Problem loading X.509 certifi=
cate -126

On my laptop, if I dump this variable:

	efivar -e /tmp/q --name=3D605dab50-e046-4300-abb6-3dd810dd8b23-MokListRT

And then looking at the data exported:

	file /tmp/q

I see:

	/tmp/q: PGP Secret Sub-key -

The kernel doesn't currently have a PGP parser.  I've checked and the valu=
e
doesn't parse as ASN.1:

	openssl asn1parse -in /tmp/q -inform DER
	    0:d=3D0  hl=3D2 l=3D  21 prim: cont [ 23 ]       =

	Error in encoding
	001EBA93B67F0000:error:0680007B:asn1 encoding routines:ASN1_get_object:he=
ader too long:crypto/asn1/asn1_lib.c:105:

which would suggest that it isn't X.509.

David


