Return-Path: <linux-kernel+bounces-223508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19C4911434
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 23:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 384C2B217FB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7B6763FC;
	Thu, 20 Jun 2024 21:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhyvB3Nn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A833B2BB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 21:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718918129; cv=none; b=mKXUOtR9IfV01lX6M8qnJCuuES0CO9gz8LGnlA07J9wYd6w8eB87D7D41jmzlP6/C27ZaqI+Ao0WPnvFVeTuqg5SzjolouVvYnnpZIEulsV7pgQec00Xxg46sLBoPk3c96lUVmBVL0M8fu/Cmvbzc3qTVGP+tZqINPQhHD1FEBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718918129; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FQ0W+cc5WFkyXVUc3w5fGICKtB0T/DcGyk9N4UD7yf13zo4BZHbgMk7kK2TWlaNX2s7iocAXJrbYrpBOG3RWHSCduM9pHXFk7BgYgq89ro1eAROzEOCuQq7Q+TocagsUYnO6Vfru7pKo0wfU4O4OLMwSwe6AtSH09jpjNMRg9HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bhyvB3Nn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718918126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=bhyvB3Nns1Bus9NuQgFhq4wyEkF1oq/foXEpgNdEzvzH3GILPfRIs6a3U1H7hSGk50RBWn
	6XALpMoeJtYSuOEI1ucEcfZpga9H76WzCzyvAzpT+ShfyI9S8eDsunm+MkkepWWlTDyzSQ
	WN+/co3Gn+tgAKKIQNOMdM6NDXx+PLo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-KFasPGq9OH2co6QFhcPzPw-1; Thu,
 20 Jun 2024 17:15:22 -0400
X-MC-Unique: KFasPGq9OH2co6QFhcPzPw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3DC6319560AD;
	Thu, 20 Jun 2024 21:15:20 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 97C3719560B3;
	Thu, 20 Jun 2024 21:15:18 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Marc Zyngier <maz@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	kvm@vger.kernel.org
Subject: Re: [PATCH] kvm: Simplify kvm_get_running_vcpu()
Date: Thu, 20 Jun 2024 17:15:17 -0400
Message-ID: <20240620211517.83191-1-pbonzini@redhat.com>
In-Reply-To: <20240620081114.70615-1-jiangshanlai@gmail.com>
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



