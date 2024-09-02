Return-Path: <linux-kernel+bounces-311566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7105D968A7F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3B841C220AE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E2B1C62D3;
	Mon,  2 Sep 2024 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BPXV2yXk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759C11C62C8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725288995; cv=none; b=Aub1nxYvjYnTpcX+D+/cLGFOmxI73u/W3jEZeUhW4rgK+3OUsHepAIUBOjj8JOgfiONcsYjnbPkhCx0iQe6fh285+GbkGNdixarFndsE1hiFD1uhq4/9zGyvWz9Ijyk31ZhemShp+UwnZD0Cl7yaIlgyvxChE7LpzzSU4hV5Xkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725288995; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMLUjtVdDecayovnxp7ACHOfRZdEBWf64u1JRxIyWlFJ6bG3YB+X12vz1pv8BM50wDPb1WX78cnDG+bfK/QQMy+tejYGmRzYPMpfMs8rMY9u7d6yKo9vaJ/j6aJ0rQ0c7EmKxk7iS0Z//iawsVl6ZwMQTAt6MUBR2hE7lHInqrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BPXV2yXk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725288993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=BPXV2yXkw9L9SwweUWbghWBsH2RLCyFuofChWzj2E4nzmUL7a6gLlgSek0kRzAL3RGbJeL
	PvlZMSrC/Y7c9dLe2s5PDMfEiAbU9l6A5Q8BftQTsDx0FblNnkYf8FeyHgnEQEmUMbc7nL
	i/U2CJr/9oooTHWwblNV4f41iEJfTCU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-ssdQZ4g1MhaeoubITEXOEA-1; Mon,
 02 Sep 2024 10:56:29 -0400
X-MC-Unique: ssdQZ4g1MhaeoubITEXOEA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 032ED1955D48;
	Mon,  2 Sep 2024 14:56:28 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EDA6819560A3;
	Mon,  2 Sep 2024 14:56:26 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Tom Dohrmann <erbse.13@gmx.de>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH] KVM: x86: Only advertise KVM_CAP_READONLY_MEM when supported by VM
Date: Mon,  2 Sep 2024 10:56:25 -0400
Message-ID: <20240902145625.173549-1-pbonzini@redhat.com>
In-Reply-To: <20240902144219.3716974-1-erbse.13@gmx.de>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Queued, thanks.

Paolo



