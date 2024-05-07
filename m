Return-Path: <linux-kernel+bounces-171893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 352D68BEA11
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 19:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9B561F235A7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860CB1649C8;
	Tue,  7 May 2024 17:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpVRHa6S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ED254BEA
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 17:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715101690; cv=none; b=fzO+VhbgUaxxdNpxWlizF0taCtduBMzNZ1WlbCrjagrSDmyFHDCp9PFJ5l8+CJr1Eu64dpKA60yR7Mn5EBRqTrSnUjemWTFVSXCwq5LcesVN+IANqPLuyFy5NkszwqXmi+6OYdXi9P+Vy08+fjUqvEWubweeTIylRnmzq88hOTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715101690; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAk3YB1OrAjd4P7AkyxtQD/zJxDmbEypP3y8aMqy5SRmNIXkcKEViTYq69nudWt+J+BNTcgeTXcrRrC+spwEf3hS7sxWjj/hIYdIGjRQI3lU+k/Qy5xY0YkOIL9c0uUAoeJumcIETkxyp972skOrvbul2/LU0bjf6PENWxaPE1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bpVRHa6S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715101688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=bpVRHa6SMsHm2wN1mjlYJYPllqQ2skZiwZjZVNfFm5qk1T6FDrw1G8QOys1S2Gh7eNtg/U
	PsQfvTeiCzsg+deu3tBENsu8RkC+DH4FfFbA9HVedMKBTlhfUaSXHrZHC07wL7hKQtPbab
	ToZRw0pU8ze61I7vW5cnJM+atwGkXwA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-bwgcQO3KNsiNdprn_fLJNw-1; Tue, 07 May 2024 13:08:05 -0400
X-MC-Unique: bwgcQO3KNsiNdprn_fLJNw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D783A802314;
	Tue,  7 May 2024 17:08:04 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BB32E402E84;
	Tue,  7 May 2024 17:08:04 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] KVM: x86: Fix supported VM_TYPES caps
Date: Tue,  7 May 2024 13:08:02 -0400
Message-ID: <20240507170802.3967729-1-pbonzini@redhat.com>
In-Reply-To: <20240423165328.2853870-1-seanjc@google.com>
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

Paolo



