Return-Path: <linux-kernel+bounces-172865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A62B8BF7D0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9DAE285F30
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878C836AF3;
	Wed,  8 May 2024 07:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YYwh1J3n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796332BB09
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 07:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715155030; cv=none; b=sT2nRO/Br4WTKRd0QO4I9dbwX6Ytah2tVuFpLmQu4ji+1gXuuDgg0XbBC2ecJRnCCdwxQsBxFUzR/OSfJCcc2XFHqykixcpv8u+JU1zzxpQBAN3p0dFlEACqAars7pIloJaDZdKYAEj0Tpz+9Nuk+sK/o3sJDYtjuJ9tY2rWsGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715155030; c=relaxed/simple;
	bh=V/YjDIQfRp2l7miiRrx3Z5IZQokNP9VXtuvlvHRlYG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XrtqhQYYnrsK3AXpE4gfTJS8sTFbHPtsHqa5Y5HYaponh4IGxeV1f82sVj5UGHahhoDGtz5oRhMszdkvGzWdWawR6/4ELDRH/ANKzzkKoHZycQLx7IRr84G/DM1H1zLKiIPGUNCEmbdcMdja1+YmMb8Q94YMx6PjqVjn2ReS4MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YYwh1J3n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715155028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V/YjDIQfRp2l7miiRrx3Z5IZQokNP9VXtuvlvHRlYG4=;
	b=YYwh1J3nqrx1onSt4KlfD7Hnz2cbp0K7apfC+vNwKMkMVbWmDN2Xznj99ZB+V8l9ODI35Y
	PoSCwmb893YGracuv7zrWq/56zGxqOd/y4llDRuVIvR+Bt9+TOdkSMMA9SxpDURgF3mr9s
	L0sww24/lCHft64i3GZ2yQ2ZQndoyB0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-9zIbIx_RPi2zsftI5GvHzw-1; Wed, 08 May 2024 03:57:04 -0400
X-MC-Unique: 9zIbIx_RPi2zsftI5GvHzw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DAAA800262;
	Wed,  8 May 2024 07:57:03 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.44])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E6CE57414;
	Wed,  8 May 2024 07:56:59 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: yongqin.liu@linaro.org
Cc: amit.pundir@linaro.org,
	davem@davemloft.net,
	edumazet@google.com,
	inventor500@vivaldi.net,
	jarkko.palviainen@gmail.com,
	jstultz@google.com,
	jtornosm@redhat.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	sumit.semwal@linaro.org,
	vadim.fedorenko@linux.dev,
	vmartensson@google.com
Subject: Re: [PATCH v2] net: usb: ax88179_178a: avoid writing the mac address before first reading
Date: Wed,  8 May 2024 09:56:54 +0200
Message-ID: <20240508075658.7164-1-jtornosm@redhat.com>
In-Reply-To: <CAMSo37UN11V8UeDM4cyD+iXyRR1Us53a00e34wTy+zP6vx935A@mail.gmail.com>
References: <CAMSo37UN11V8UeDM4cyD+iXyRR1Us53a00e34wTy+zP6vx935A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Hello Yongqin,

Sorry for the inconveniences.

I don't have the db845c, could you provide information about the type of
device and protocol used?
Related driver logs would be very helpful for this.

Best regards
José Ignacio


