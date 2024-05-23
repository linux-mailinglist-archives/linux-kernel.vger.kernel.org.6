Return-Path: <linux-kernel+bounces-187588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3F18CD4E9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8FF22860D6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172BB14A4FF;
	Thu, 23 May 2024 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qie4aePa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1219314A4D9
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716471551; cv=none; b=iIXnwQSLfdc6zwmX7N/3DUeobF/FFTyhSCJU5KF1qPVbJP2eaGu/APJHi3Kjzy8pdNIfB9QcLTF3gaK7Pmsen71cB6f0Fe4UlBSEEZj4sJ9B0ZKn5rq/lTrnj9In9zIB+LJLKeuLJucok4vIfOuX9BBaJy91II4EdJUcvO6MHxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716471551; c=relaxed/simple;
	bh=f7qsf6uHpQj1b7EvGifYNKn62b0z3n3sNaoF30buF0Q=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Y6SemuJ5AtZvZGfEeZmtuJUsVwYk4PHX9kQxQOZg2/yRuuLRcqL0rzZLPRMTrLmq7ouBSQZErU6VIIOcAduQ+iloakDtMYm7KeNviMAg1woQK7br2fvPHmqZvAH+3SBC1hDHS9I15lAX2PRbwSPqOv868O1ZX07a6S1+AX1NG/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qie4aePa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716471548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ujjJR49aI7BZarO+naEDlUutu9JDS8SgDMMORQQ2PcM=;
	b=Qie4aePaXtTIDSGrETpMvMIlsRAiQV0Il3i0CcxX6v8m5q51JqpmSk/Y0aLGQWbZglEKKb
	T7KoA9FHpcuU090PoyEUlhZ/j2LEHfv3Agk31pmmfdbjH3FnVbJYaifBzkAiGiy5SBzzgC
	pKoQZAeKclR34kl7n+ECygaYrMmrJ9Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-Cw0F39TlPQyVN010Jn0Oww-1; Thu, 23 May 2024 09:39:06 -0400
X-MC-Unique: Cw0F39TlPQyVN010Jn0Oww-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A962812296;
	Thu, 23 May 2024 13:39:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 487A87414;
	Thu, 23 May 2024 13:39:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240523132341.32092-1-jarkko@kernel.org>
References: <20240523132341.32092-1-jarkko@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, linux-integrity@vger.kernel.org,
    keyrings@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
    Eric Biggers <ebiggers@kernel.org>,
    James Bottomley <James.Bottomley@hansenpartnership.com>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    "David S. Miller" <davem@davemloft.net>,
    Andrew Morton <akpm@linux-foundation.org>,
    Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
    James Morris <jmorris@namei.org>,
    "Serge E. Hallyn" <serge@hallyn.com>,
    linux-crypto@vger.kernel.org (open list:CRYPTO
                         API),
    linux-kernel@vger.kernel.org (open list),
    linux-security-module@vger.kernel.org (open
                         list:SECURITY SUBSYSTEM)
Subject: Re: [PATCH v2] KEYS: trusted: Use ASN.1 encoded OID
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <576060.1716471541.1@warthog.procyon.org.uk>
Date: Thu, 23 May 2024 14:39:01 +0100
Message-ID: <576061.1716471541@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Jarkko Sakkinen <jarkko@kernel.org> wrote:

> There's no reason to encode OID_TPMSealedData at run-time, as it never
> changes.
> 
> Replace it with the encoded version, which has exactly the same size:
> 
> 	67 81 05 0A 01 05
> 
> Include OBJECT IDENTIFIER (0x06) tag and length as the epilogue so that
> the OID can be simply copied to the blob.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Reviewed-by: David Howells <dhowells@redhat.com>


