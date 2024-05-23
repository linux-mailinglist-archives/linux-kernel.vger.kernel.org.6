Return-Path: <linux-kernel+bounces-187791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF278CD893
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 18:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCB6D1C215CD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDFA1B7FD;
	Thu, 23 May 2024 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GXyCYDmt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560E417C8B
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 16:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482499; cv=none; b=eY0BC77SIJL7uoat1XHxIMHX5tKk/8wnHywwWEur+jVbmndWHsbuJPckK71bEqSV3YUG2xTjaGIN+vvQ2T37bhJSo+9oApEUKUU2jU17JJDLCqNm39MQK5+CsFN636Ao2PrGPCromorACHO7LOaW2bU/HMCr4O1ttyhpElWntlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482499; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZA5r9meXmDeWRZ6XCEFkXaLNCqrdzXqeaThem6GQkA77RrT815fWxgkzcp8Kne+Cizt2gEiAUwF2LkaVPy4jo7nHC7iGmdYgJ+9JTZL6PldGGpQTsUvbHtkYxeF9pUfhEcc9ONf0lNnS8FG3WA17pREmvcZGpe2X3KBqRxpuuxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GXyCYDmt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716482496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=GXyCYDmtYNED3KbfCLJltEP0l0rLd7Dwowi83XEcb+Jl4W8IuVu7K3w0QqwJ1L9vHpzLZq
	2nW3hxujyzsAJJ57xaDbodsq6SwU9xpU+Cv89tlPYKCqcxJKvCU7e+Ks/NSYgiRdvGa0US
	zS9v/XpXt0rb/lvJSl6uLI916gVpL+s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-ntf8VsuvMZeYbNQGnCwrHw-1; Thu,
 23 May 2024 12:41:34 -0400
X-MC-Unique: ntf8VsuvMZeYbNQGnCwrHw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37B691C53C65;
	Thu, 23 May 2024 16:41:34 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3D06040C6EB7;
	Thu, 23 May 2024 16:41:32 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Santosh Shukla <Santosh.Shukla@amd.com>,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH] KVM: SVM: WARN on vNMI + NMI window iff NMIs are outright masked
Date: Thu, 23 May 2024 12:40:37 -0400
Message-ID: <20240523164037.134468-1-pbonzini@redhat.com>
In-Reply-To: <20240522021435.1684366-1-seanjc@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Queued, thanks.

Paolo



