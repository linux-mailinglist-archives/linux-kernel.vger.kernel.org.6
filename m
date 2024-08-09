Return-Path: <linux-kernel+bounces-280786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A3994CF30
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3CE2284324
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6FA192B89;
	Fri,  9 Aug 2024 11:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmOMEylS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A2D192B7E
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723201537; cv=none; b=uzLSwkl5FNXtnXE9bl3EwnVdYyaqCRNY4u53bKhFB20TZodxCMJ28h1l8ytoDvQMSm8XrjinvICD29pk4RFfoJ262pfUrPN/0QqoClkFFm2H5XClLLmVB6LTUgUd0G3BZpdVHx67VNcfds07zShTaN1PdFJbDTat3XUPls457aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723201537; c=relaxed/simple;
	bh=+fGjLyr8+mM3EQ1Qg4zs7+HDFWx/1Tx8NMju1CR3Gl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDldew7SgwrhWysfFAkSVWsubKNjompGU8jMCxbZAn6Ba6uxYkgqFkBQbiqiy/NwSiH4LueGCR2+MevnZJCM9g0H6j3f/4EXSFfcTopxBF8f4ZTu9u2Gyu0FINIRKRzkKpTFKA6ppcmpI5ION1g7nk59pKAxT9AgiTHKbniLqT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XmOMEylS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723201534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+fGjLyr8+mM3EQ1Qg4zs7+HDFWx/1Tx8NMju1CR3Gl0=;
	b=XmOMEylSQBwulvbf+wwTMypswMQBeyOYfSLCORkJprN5hJOaiNByRfHlXC/5fI1pPqslTB
	rJrmXkEjGhPSauxdOBr2vutuQz2lVGuxJRi4LjzUU2LPeG3Q1zEDIgt4cfd72g3FG2BXSt
	PDZ+t25XrPT3i3W+VkJ6VDOFMeUK7A8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-v7TboLfKMBCkG85x3hY8lQ-1; Fri,
 09 Aug 2024 07:05:29 -0400
X-MC-Unique: v7TboLfKMBCkG85x3hY8lQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B383219560A2;
	Fri,  9 Aug 2024 11:05:27 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.45.242.6])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 619B719560A7;
	Fri,  9 Aug 2024 11:05:23 +0000 (UTC)
Date: Fri, 9 Aug 2024 13:05:19 +0200
From: Eugene Syromiatnikov <esyr@redhat.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Davide Caratti <dcaratti@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mptcp: correct MPTCP_SUBFLOW_ATTR_SSN_OFFSET reserved
 size
Message-ID: <20240809110519.GA30788@asgard.redhat.com>
References: <20240809094321.GA8122@asgard.redhat.com>
 <c78f98ff-df44-475f-bb1c-5c33f816ee11@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c78f98ff-df44-475f-bb1c-5c33f816ee11@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Aug 09, 2024 at 12:42:19PM +0200, Matthieu Baerts wrote:
> Do you mind sending a v2 with these small fixes, so your patch can be
> directly applied in the net tree, please?

Sure, will do.


