Return-Path: <linux-kernel+bounces-436948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 860079E8CFB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71151883E91
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85256215177;
	Mon,  9 Dec 2024 08:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xjx3RXWz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617B5215054
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 08:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733731429; cv=none; b=iwnBt7Q8aG6Toeep6GBtk5upQWa8qJjFoDzx0+WR9PjQjJ/8HjYTidfqeE6fEpxcJ3QokvDY4KKWiv0rV/5jkaQp7j2rl8EMpcr+gagdwsUZ7qS1xNdfrElrgK5+GI9kcHGpRcDDnkv4SHN8z6DUQXf279Cqih2vpCxlf4TCPLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733731429; c=relaxed/simple;
	bh=mV6ov3sFgpt7rgCC6Pvrp/3B/vFOn5GJ/ODx71pgw1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UnBdm9bW9klxlCnMLJhg/5R9aypgZL2KRL8CKZG37hCupft19omOl/Gt8Mivn0p3ScDCvFPPUV6InxnhZOi6cPWtxBvjhgHTi3/uCED9CvL/W24I9a2BLH6F0gMIalgO04oljZFhyR3+WBY2X2iDASQ6atsLd3XqSd/D5zLXw20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xjx3RXWz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733731426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mV6ov3sFgpt7rgCC6Pvrp/3B/vFOn5GJ/ODx71pgw1c=;
	b=Xjx3RXWz2DJcThKTb3w1ekiIwWBOe22d23LBYkVbCNnbIuJmdj6sJOH4D0nJ3M7j+ozxL0
	6WUCPKqmqo7SZPZMh5PSs0u4PuWBr1bgK+SI8ryG7uJAw8sHNhVHvJatonL5k04VrySwrO
	aLfxkOHELDxZGeDTc7HxPZvFzMZ9Yns=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-TTUgGWDePXyyFS5-S_VJzQ-1; Mon,
 09 Dec 2024 03:03:41 -0500
X-MC-Unique: TTUgGWDePXyyFS5-S_VJzQ-1
X-Mimecast-MFC-AGG-ID: TTUgGWDePXyyFS5-S_VJzQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 906811954B39;
	Mon,  9 Dec 2024 08:03:39 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.253])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BFB03195606C;
	Mon,  9 Dec 2024 08:03:35 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: quic_yuzha@quicinc.com
Cc: ath11k@lists.infradead.org,
	jjohnson@kernel.org,
	jtornosm@redhat.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	quic_cjhuang@quicinc.com,
	vbenes@redhat.com
Subject: Re: [PATCH] wifi: ath11k: allow APs combination when dual stations are supported
Date: Mon,  9 Dec 2024 09:03:34 +0100
Message-ID: <20241209080334.5989-1-jtornosm@redhat.com>
In-Reply-To: <1123551c-1a6d-4d0d-b3c7-f65c15509280@quicinc.com>
References: <1123551c-1a6d-4d0d-b3c7-f65c15509280@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

> So you can't up with ap type or can't up with managed interface?
Please, let's go to focus and not repeat the same, due to the reasons
that I commented before, I can't up my scenario with aps using your
proposed inteface configuration.
I am going to remark again, I can do it with the old configuration
previous to the commit f019f4dff2e4 ("wifi: ath11k: support 2 station
interfaces").
Thanks to my patch after 019f4dff2e4 ("wifi: ath11k: support 2 station
interfaces") by means of a parameter I can do it too.
And that's all.

Thanks

Best regards
Jose Ignacio


