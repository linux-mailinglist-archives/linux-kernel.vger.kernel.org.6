Return-Path: <linux-kernel+bounces-187792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4780B8CD897
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 18:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60EEB1C20A1B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2873A17C8B;
	Thu, 23 May 2024 16:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7fVHmmz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90011862A
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482544; cv=none; b=mf83jOfPn/OtVdUpRZdUAm+CKdwB0TOn4uxuI5plZNwIPIai+2SnP1fkvz8FDISyNeXoMeV9RI9SxJV5LzUXQCPki8yzYuzeOgIrUA//U0U4//0LTW/b/xQVrdeHQce93XjWC3xvh3RjnurZomw7gTcQ7g624oj8cPEF/Gt5QNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482544; c=relaxed/simple;
	bh=0pgqSCanJA5BABrmpoRT60aJlomcl92iXLmt5UCD/Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V72o/IHprSfvpuRRvGsO9YXR+gqf4C/H1+R3CnSpnUytlZR363RMPdzBOJPsvZiY5EEFEwt/3wN6F9UvC9egX4YXhmeXm6rWDJ74MpjyNSileU0nJm1cSNwDPIljlzg9riWC1ybn2bY1+nvZmMxsCn2xVHMZrlqnrI1n+Wdb6Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I7fVHmmz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716482541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0pgqSCanJA5BABrmpoRT60aJlomcl92iXLmt5UCD/Gw=;
	b=I7fVHmmzkSrvx1B4Y7ptdS5jLCZMw/Tr5sXpwqxughOU5uikERjGBNbqAwK+VDMY4WCbON
	kFSz/HhKC03Nv1xRlsFYeL/KCskaZpfBTNyFDmOvrGeeoleNOQ5mltOFQBHWD8JHYp8F3f
	MrhXs/y+rWhjl7ubwk0MpNCV8p01MUQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-ngerKUuBNwae7ME_6i9B7g-1; Thu, 23 May 2024 12:42:17 -0400
X-MC-Unique: ngerKUuBNwae7ME_6i9B7g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51ECC8058D1;
	Thu, 23 May 2024 16:42:17 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 352F5492BC6;
	Thu, 23 May 2024 16:42:17 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] KVM: x86: Fixes for KVM_INTEL_PROVE_VE
Date: Thu, 23 May 2024 12:41:54 -0400
Message-ID: <20240523164153.134494-2-pbonzini@redhat.com>
In-Reply-To: <20240518000430.1118488-1-seanjc@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Queued, thanks.

I moved "KVM: VMX: Don't kill the VM on an unexpected #VE" as the second patch
in the series.

Paolo



