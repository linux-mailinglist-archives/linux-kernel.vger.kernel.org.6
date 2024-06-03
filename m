Return-Path: <linux-kernel+bounces-199484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF36A8D879D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 844EC281AFB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A12A137755;
	Mon,  3 Jun 2024 17:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBhvhAUC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF441369B8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717434357; cv=none; b=Tf5FAqR6RR/Ct23jiDMdHsb1vqO82EcH7UL9GRV/QOQ6uToTXdaBkUaQ/szeVVhx/gXQbPC1FAhq9rSZ+eoBm0Y6IX/3k5Wi0bAHeGmzwo+g6lItqEIigSazg4rRSgH9O/pe/QK2/1gkwX9LWrwiVD7zai/Y66jY8+d9ONAq/H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717434357; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TONQiapVUObaogdc+wO+pAV6xiV6jUfgd9mAaExwtSD/OYbd2QSi4Jd/loooqRa9jWreq6+ZOMSNK5PxsqnJa10VQ5EfzkzJvS6ICR0RAjCYEjOGDsVSwRwtHlwefVXsdej+zUrGJuH/fDMKZ3j0jYdN4ozWEJnqcChyIfYM63Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iBhvhAUC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717434354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=iBhvhAUCvtJ28/kU0n+841w1V9DMV0S/IzgE3oqWXINk4AKD7VaLOLozoeGZLl3F18Vx1Q
	NwujDoPOmaKTf/XkE/2tYg8IF3h8/28ujFKn0ZCLxm3VZILRxyrkW8gxYymAtskpaYCf7e
	FZJLpgnxW/o4LX+ZWuS/uCUiFRQRpdw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-uhUQv5t6NpGapgPUOR69Ow-1; Mon,
 03 Jun 2024 13:05:49 -0400
X-MC-Unique: uhUQv5t6NpGapgPUOR69Ow-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B4F133806701;
	Mon,  3 Jun 2024 17:05:48 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3C4245624;
	Mon,  3 Jun 2024 17:05:48 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	nikunj.dadhania@amd.com,
	thomas.lendacky@amd.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	michael.roth@amd.com,
	pankaj.gupta@amd.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	santosh.shukla@amd.com
Subject: Re: [PATCH v4 0/3] KVM: SEV-ES: Fix KVM_{GET|SET}_MSRS and LBRV handling
Date: Mon,  3 Jun 2024 13:05:45 -0400
Message-ID: <20240603170545.11817-1-pbonzini@redhat.com>
In-Reply-To: <20240531044644.768-1-ravi.bangoria@amd.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Queued, thanks.

Paolo



