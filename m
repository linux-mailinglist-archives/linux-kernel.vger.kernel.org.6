Return-Path: <linux-kernel+bounces-401313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0D19C18AD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A059282D6C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E258E1E0E14;
	Fri,  8 Nov 2024 09:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQjOPsJa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABA01E0DCF
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 09:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731056586; cv=none; b=fB9x155yu4/L4BT9C4/LE3eVzrDHIIoYMwxU1MrVxynLbA3c0gdid3PnJSx0KgDPWsOsFWIgJdkJN6sy8I8yh5M7eOJKIBeR/UoQlDWqVoVxLzYUUUlXyS6OyZzf24y4jHjMZ6v37rdM9pjsD20LzCa0Gmul+lPQAIbGml63dNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731056586; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6NJouoHChQSh6ljRnQ2vqXlLmfFsbbYMSvmwQgDFUWPqLckwUGxIBbyr778C9gon1jmbSs702ugXhrJRBwhdH0gOrsoeVw2tpM8cM2dNhTQgxjy3gwl2IWo2otuGXiVA3pd1fPYvoVFSlH9/vYaQTOiLdndCVwipJfmKageFPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EQjOPsJa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731056583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=EQjOPsJaTUyS7rzeU5+QrCuJI4Qoq/I+rlmHGai6PsCrBTa+x9BzsicdlomBHHn9qIFKlB
	CKRvks85tawSJN43JL3P68HRhvhIIt7oe7jh8JJPtEbPQKaMAqL7nI6vJzIukehGSssi2u
	t+z4f9A6dvC+CgSqvXq0lZ7DH5ptrZs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-5hdWNaeuNf6vdLl1mQaSbA-1; Fri,
 08 Nov 2024 04:03:00 -0500
X-MC-Unique: 5hdWNaeuNf6vdLl1mQaSbA-1
X-Mimecast-MFC-AGG-ID: 5hdWNaeuNf6vdLl1mQaSbA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27B091956048;
	Fri,  8 Nov 2024 09:02:59 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 45F6B300019E;
	Fri,  8 Nov 2024 09:02:58 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Yong He <zhuangel570@gmail.com>
Subject: Re: [PATCH v2] KVM: x86: Unconditionally set irr_pending when updating APICv state
Date: Fri,  8 Nov 2024 04:02:52 -0500
Message-ID: <20241108090252.5439-2-pbonzini@redhat.com>
In-Reply-To: <20241106015135.2462147-1-seanjc@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Queued, thanks.

Paolo



