Return-Path: <linux-kernel+bounces-515794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CCCA36928
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59DFC18917C6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 23:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D181FDE01;
	Fri, 14 Feb 2025 23:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CH/ddxgW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64B31DC19F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 23:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739576518; cv=none; b=j3pBssjNsAXK/SpjYKZ9qE2cX5Ul3f3aJCO7zka5FkOX32rp/NXJgbu/w4sIcjBPzL6dyjWgXWpwo1a3OQO9ch3bs64gEFtchVUWXmBDALLL8CVil6bzVuRWuZcwV0GTZ/ptdg5qBuubOZKM03UoO1zVb4LlcK9arwwGQZUKTqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739576518; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsDO7vy07gLC9f3zoRhFRhyVyDuWUjoMmvj2opdOBV0rpAevqeCL+llv8Xe6T9qbDGLisNbotcFMZgMpPLopeDbB+Yn0fTA/vAvLcDWo6V/CQDq66hAXW2KY8s9FAKJZmehuxjhyfgkoSmB2Y7DiYNkChdzP28PSHhEEczd7Rt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CH/ddxgW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739576515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=CH/ddxgWfs5yY+CelhGY6YsXpxyi2rOZYLSqF6SKn2USvOdzMjifPvzkLViHUxoJlcE4AC
	7WgZmpJ2v0XdTOGGKxvzvQGlwWqdVPaPTO8wHaiXB1hU1kAE5B6vIjjx/lFYFfLgtgl3qs
	8Y1TKo3zI4wt9LQ8g+wNguGdksoBY3A=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-9P3SI80JMEmV33ESfQD9wA-1; Fri,
 14 Feb 2025 18:41:50 -0500
X-MC-Unique: 9P3SI80JMEmV33ESfQD9wA-1
X-Mimecast-MFC-AGG-ID: 9P3SI80JMEmV33ESfQD9wA_1739576509
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF60118EB2C3;
	Fri, 14 Feb 2025 23:41:48 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 05E051800365;
	Fri, 14 Feb 2025 23:41:47 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Stultz <jstultz@google.com>,
	Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH] KVM: x86: Load DR6 with guest value only before entering .vcpu_run() loop
Date: Fri, 14 Feb 2025 18:40:58 -0500
Message-ID: <20250214234058.2074135-1-pbonzini@redhat.com>
In-Reply-To: <20250125011833.3644371-1-seanjc@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Queued, thanks.

Paolo



