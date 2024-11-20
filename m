Return-Path: <linux-kernel+bounces-415092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC25B9D317D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 01:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 788F1B20FA7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 00:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6313B1798F;
	Wed, 20 Nov 2024 00:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U1+hknQl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FDD749A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 00:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732062948; cv=none; b=PoO4Ptr7wtqK6fkstWoyn7WJ7wcte2uxtwMMHJjoQlBgcfamErrRRrm02sacffqSht/l/rP+h5ZlAucx/O8KVWVt7smPvtpL1X0ek2CyTrBwVXfbXNideNwF1+ujUjzBB6i1aQ3QJ8PBTYp66CcP3RX7mVoANlACGLMgO8YqKmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732062948; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PvCEbk3xVjnLi9Dssstsuq182sckcUFCO8sk/Rd2gd5BdNiAo7lHigkD9DYvra5lFouFksLJko+FS1kW+QpJ7J1pFsc2LINgcgYKCAwoGMadqcDlie0ST3EkqZ3wUNk3VA8Ad+DGpIa6Rtq9ApOfrG0Guvk/VRJW5hV3TxDtCaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U1+hknQl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732062946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=U1+hknQlTHR5y27U39SsF2TQErtjzgbUAD7Sb0Cr8Fkqbe2A5I/YQjXDgICqHbxic8aI1Y
	BZyVJj/G5U8GqyZUijOfoVLkBRvwD5qZqwd0EOFqbQR8LLRcuSNQAvFhR/q1ZMan5IW88T
	zlELcmG1Ly9+0JM0eWrNocLijlzAB3U=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-XK8hdD9jP-uBpSC04kkO2A-1; Tue,
 19 Nov 2024 19:35:44 -0500
X-MC-Unique: XK8hdD9jP-uBpSC04kkO2A-1
X-Mimecast-MFC-AGG-ID: XK8hdD9jP-uBpSC04kkO2A
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 597921953961;
	Wed, 20 Nov 2024 00:35:43 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7A74E19560A3;
	Wed, 20 Nov 2024 00:35:42 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/2] KVM: x86: Fix more KVM_X86 Kconfig bugs
Date: Tue, 19 Nov 2024 19:35:38 -0500
Message-ID: <20241120003538.78187-2-pbonzini@redhat.com>
In-Reply-To: <20241118172002.1633824-1-seanjc@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Queued, thanks.

Paolo



