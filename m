Return-Path: <linux-kernel+bounces-284971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44466950779
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB9AA28428F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E3B19D087;
	Tue, 13 Aug 2024 14:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D0ghPd2I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0361319B3DD
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559092; cv=none; b=MGoR+FlpJXwFAf/UeoTihRGOQkK1dgxWRwrkR+kOghpA0na0xXrIuWm1xPqvtnoe4EYuBHbB09b4qTc1JHwLr345DnoWxQNQHVeTvxgLMSFD8QhR4Zgj3fpnU2Chnsrrf4qihuitNUXPp6x7UtfSMr84d9PBUPGUozL6KAOjXuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559092; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cK7nduCV3Rb156999rtchxat1UJmp5M9zKCNNjsqWTNin/Xqi459U4rKQ5pMRE2zGbbBmGSOfqvUGKoc+uI7voZvQelwXIAjTfq0Ee6fXz5tqEFYKnfIGdFzRsXS6YFyuVhs389knb3R56lwNmzhuqo19Bc3ir1aR1m3Bx7Q808=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D0ghPd2I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723559089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=D0ghPd2Iti+DTxxeze9L+NJzM95qz6/thKVuxYjvJ3/I1M5ULi6FMAKPLaTbY2GtPe35nE
	0Tc6mO++azCoWtKst+sonPIgezBIOVtNrcrRnQbIpF8ktB95JnHZ+TdBZUsnGl4F08sfm4
	NW0zcQxN+JSO/pBDzUAgUt9eNm0V3b0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-sjYWYpHfN6y8_9HHD8-szw-1; Tue,
 13 Aug 2024 10:24:48 -0400
X-MC-Unique: sjYWYpHfN6y8_9HHD8-szw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D3661955EB7;
	Tue, 13 Aug 2024 14:24:46 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4574D1955F23;
	Tue, 13 Aug 2024 14:24:45 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	Chao Gao <chao.gao@intel.com>,
	Yuan Yao <yuan.yao@intel.com>
Subject: Re: [PATCH] KVM: x86: Use this_cpu_ptr() instead of per_cpu_ptr(smp_processor_id())
Date: Tue, 13 Aug 2024 10:24:43 -0400
Message-ID: <20240813142443.133703-1-pbonzini@redhat.com>
In-Reply-To: <20240802201630.339306-1-seanjc@google.com>
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



