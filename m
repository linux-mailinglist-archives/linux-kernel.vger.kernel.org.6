Return-Path: <linux-kernel+bounces-173378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2438BFFAA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2CD1C22A2F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE9F85646;
	Wed,  8 May 2024 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cQCBw2m/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ED784D3C
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 14:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715176837; cv=none; b=V6KrPAWXl5THHArjx9ndXH5vi/qc0ravEK78B0z43e6Zfx1hbrWr62TNJSwdGVOOr32EtWQcbVeVR6Ht6GPqu7Mg+I0dIf6aq4xAc2cEzTqTc0P7bzIHfcnTezqv+BkGwDMhSvuFaegWDSjtTyvCirHSF8mOBRvH8RCeTJuUPCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715176837; c=relaxed/simple;
	bh=6IAkZm0nr73a+FCvQU9RrVmjEV4QH7pNc4Sf5PL277k=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=PirFULYc8ia9GWNWa8/RSss3Ickp1ERSdOu1SApOD1ljs6UWYYnd+zdvVwKPsCgvpUxRkFFm/Q9MuFULguZ4WWniW/v4V/I/bXzNdXl2i9Br+otE+q4Jem263y65X8Cgi+motSeflszviiBdLxcAlXlmcafg7n92C2FG6h50+WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cQCBw2m/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715176835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ab+XWd2myJ6L7McJ527uKHYQsSkysWxpTlgV7y7p67A=;
	b=cQCBw2m/KIgfIdK2QOlSpNrLdemouVyMCd98u1wzcE4Ak8fY1xiYtdDEgJZKOoH4Wc7tEW
	bIU+7lSBSI09bJQOGphPYFnNj/sH69Tp/C6pb8aV66im9otb/Y0Krlj2USFWE4RS3idLqZ
	QCg1g1yOCv0ArgGEekKwcI1lTGTt7Mw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-p2fO3rSnO12MqJhgGTVguw-1; Wed,
 08 May 2024 10:00:31 -0400
X-MC-Unique: p2fO3rSnO12MqJhgGTVguw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A69C23C025B1;
	Wed,  8 May 2024 14:00:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.34])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7DF97C0157C;
	Wed,  8 May 2024 14:00:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240507194447.20bcfb60@kernel.org>
References: <20240507194447.20bcfb60@kernel.org> <20240503150749.1001323-1-dhowells@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Marc Dionne <marc.dionne@auristor.com>,
    "David S.
 Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/5] rxrpc: Miscellaneous fixes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1478420.1715176828.1@warthog.procyon.org.uk>
Date: Wed, 08 May 2024 15:00:28 +0100
Message-ID: <1478421.1715176828@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Jakub Kicinski <kuba@kernel.org> wrote:

> Looks like these got marked as Rejected in patchwork.
> I think either because lore is confused and attaches an exchange with
> DaveM from 2022 to them (?) or because I mentioned to DaveM that I'm
> not sure these are fixes. So let me ask - on a scale of 1 to 10, how
> convinced are you that these should go to Linus this week rather than
> being categorized as general improvements and go during the merge
> window (without the Fixes tags)?

Ah, sorry.  I marked them rejected as I put myself as cc: not S-o-b on one of
them, but then got distracted and didn't get around to reposting them.  And
Jeff mentioned that the use of the MORE-PACKETS flag is not exactly
consistent between various implementations.

So if you could take just the first two for the moment?

Thanks,
David


