Return-Path: <linux-kernel+bounces-430773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1BB9E3563
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518E2282224
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919CD194089;
	Wed,  4 Dec 2024 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gk40eKNn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480FD2745E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 08:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733301050; cv=none; b=OqBR8bkZRCazKZGgBmUQ8qMIpkPQiv/3dHPOw0/03rLqo5nspH+mdR95fraapmbNHKPHzn79rdA3oF1qcuysp3mfhh43DJ3FnMMXfFItnOaK9JBLofTRDhdkLx9/dUYarCgPYBczvZM6YDZ65GGcuDD6312Rrt3uYze7zzkCwV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733301050; c=relaxed/simple;
	bh=VU0p7473Kxk8dX8CycfIbfQFmNXYGBcxy+YYaXHc62w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQMtjrkIL2pW0vT9X60/I/tdqM/hQ0ckaWsFBitMSYmN9TlqW1VX1tVE88tr0yPRC/2zAKOzOm9gwqabkCS9NWWm3kn/fFMAzPgnKe/JXJeTxr3bAG5xBVwmykl9JNVytG3u1RLGTx2dnbsJE5UBB3dOPyBv4G8DKtJXJbwkzFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gk40eKNn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733301046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VU0p7473Kxk8dX8CycfIbfQFmNXYGBcxy+YYaXHc62w=;
	b=gk40eKNn4exVhBaJKUHyd6cM/emqWJFnxQDx8SNbFpMzEqnz82vqlLxoyTscPquMjT+4v2
	Amh5Ric4MesPt4zk277Bo6Ld2TQPUm/gKa4CmE1ugchoApw9TYuxJyqMtfEE26zcLp/pSf
	BaZFDh2Zpe57NIqtmgdWnPtkUV331g0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-fP7OCzLEPg2j_Yh0bPz4cQ-1; Wed,
 04 Dec 2024 03:30:45 -0500
X-MC-Unique: fP7OCzLEPg2j_Yh0bPz4cQ-1
X-Mimecast-MFC-AGG-ID: fP7OCzLEPg2j_Yh0bPz4cQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C3931955F3C;
	Wed,  4 Dec 2024 08:30:44 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.181])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 29B1619560A7;
	Wed,  4 Dec 2024 08:30:40 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: jtornosm@redhat.com
Cc: ath11k@lists.infradead.org,
	jjohnson@kernel.org,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	quic_cjhuang@quicinc.com,
	quic_yuzha@quicinc.com,
	vbenes@redhat.com
Subject: Re: [PATCH] wifi: ath11k: allow APs combination when dual stations are supported
Date: Wed,  4 Dec 2024 09:30:39 +0100
Message-ID: <20241204083039.7103-1-jtornosm@redhat.com>
In-Reply-To: <20241204075128.5547-1-jtornosm@redhat.com>
References: <20241204075128.5547-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

I can share mine too if you want.

Thanks

Best regards
Jose Ignacio


