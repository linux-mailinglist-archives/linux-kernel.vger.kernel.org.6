Return-Path: <linux-kernel+bounces-223515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C388C91144B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 23:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BE47B21ABE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A610277F1B;
	Thu, 20 Jun 2024 21:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YsR6E6gS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E364D8A1
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 21:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718918472; cv=none; b=DaJqqbg4Or0PuLrjSlLJwNr4uq6ylUblYblIN85c7B0x2DXlesDrRB3BNsNOU/4z7l9BrjuBOnk24247zqowYwj7tgIWvVNIFj6VytCA9s+Ph777hVBvODqGLoWshqhfFShUGd1+H1W1M7AlSN4fgkMIOp1azajqQvZJuXNYnjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718918472; c=relaxed/simple;
	bh=er3H0zKr4OnXkfwx/kKph//woI+og5q1ZS/7rOKCv+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=asvZYxLs/MsbaP0zOLkOPQjX7UIqVU3UUb0pFSyO/Ip3FyE5/kmxO8miVSE1jxYOB8NmQkm87gGkdhgvddSBxI3xQPS0+6zbPvw98UL5MBDsc//iqGVOWhaKJOv2AdG/gX5bb9N8rPeuMxfdjt21FtbNPsVPZPMyXTJdzgqNfBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YsR6E6gS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718918469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=er3H0zKr4OnXkfwx/kKph//woI+og5q1ZS/7rOKCv+g=;
	b=YsR6E6gSLVMgz+u7W8f3nCiuZ+3o6wCmBgTjyThNzKEdBa/jsxO8NDu2G/sUi+E3h+Xqfx
	T6RsgoTdUKqVIHnGd3fJajZ34xSKom7El9tK3LzZiN0jkR1mQ2Mg8gE/v+7Y4cq/VAmU4Y
	3htrEZT/w4EtLPW/H9RJxQ/wor6ub6c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-IdBiGMwqMVCytto1RssGEQ-1; Thu,
 20 Jun 2024 17:21:07 -0400
X-MC-Unique: IdBiGMwqMVCytto1RssGEQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 155F51956088;
	Thu, 20 Jun 2024 21:21:06 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 616521956048;
	Thu, 20 Jun 2024 21:21:05 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: Discard zero mask with function kvm_dirty_ring_reset
Date: Thu, 20 Jun 2024 17:20:47 -0400
Message-ID: <20240620212046.83469-2-pbonzini@redhat.com>
In-Reply-To: <20240613122803.1031511-1-maobibo@loongson.cn>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Queued the alternative patch that returns early from kvm_reset_dirty_gfn,
thanks.

Paolo



