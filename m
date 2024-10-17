Return-Path: <linux-kernel+bounces-369325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AAE9A1BD4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37AC71C210A6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 07:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCC51CFEC2;
	Thu, 17 Oct 2024 07:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bEn1Q6Nm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D3F1CEABB
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 07:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729150775; cv=none; b=WDO1NDFvXaNx+iVqOEp4WhVAKokbWbcLzKc6zboMEe72G8xxDOB5WUwsHF0FEP7hYtAHXvId31dt6rcwP5SDfjF49v4PO2qfYvUmjvFQA7EvaYiQTO7lLpV5dx0ix2BC6LC+bwnnFUmrxKELr4wGtLHTkzpWEe5ok78Yg56QSy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729150775; c=relaxed/simple;
	bh=m4eEYHr5HZdR14z2m0HhKfVxLLSkjgYI0qJOJpkvDww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5AN4Krx2lpDanYLfhjO1viICXLYS409eOy6ADWiDQ0LE0lg1V2Wrz3X7YtnNzAPxQ+1qoRQxoz8evOpcDvZgNsLVNLmVV+gWKEh2uD6tYM5qtFf7joOQqZp7tYH3MwS75rK1C5Xs7z3ev6DWXZPxaodnTUHPZXeWRmfEQlqgCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bEn1Q6Nm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729150772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m4eEYHr5HZdR14z2m0HhKfVxLLSkjgYI0qJOJpkvDww=;
	b=bEn1Q6NmvHiL7Gvvypsld0e7h5XZKzPkFYHYN7x2oi2c61LNKQ3Ph/yDwe8LUK1FeRY1rZ
	aJ2kSkz44TGeglTpIWvp5aaCc3hrOKrtWfQ/OyXLdS14Pf35etY5xUM67t/LR2eDQ5JVvI
	8PdCu357b4Fp3ncpDMS1hbsb/2VBlSI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-hZvoJQuhPv-T_dST5p10zA-1; Thu,
 17 Oct 2024 03:39:26 -0400
X-MC-Unique: hZvoJQuhPv-T_dST5p10zA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7AD7919560AB;
	Thu, 17 Oct 2024 07:39:25 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.60.16.52])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 461B8300018D;
	Thu, 17 Oct 2024 07:39:21 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: quic_jjohnson@quicinc.com
Cc: ath12k@lists.infradead.org,
	jjohnson@kernel.org,
	jtornosm@redhat.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] wifi: ath12k: fix crash when unbinding
Date: Thu, 17 Oct 2024 09:39:17 +0200
Message-ID: <20241017073920.176412-1-jtornosm@redhat.com>
In-Reply-To: <7edcf090-ac17-45de-a81e-33a1bb520126@quicinc.com>
References: <7edcf090-ac17-45de-a81e-33a1bb520126@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hello Jeff,

> FYI I didn't comment on this previously but
> <https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages>
> has some guidance on trimming backtraces in commit messages.
Ok, I will trim the backtrace in a next version of the patch.
And I will fix the typos too.

> I still don't understand why this check is necessary.
>
> Why isn't just adding the "dp->tx_ring[i].tx_status = NULL" inside the loop
> sufficient?
>
> You previously wrote the "warning comes from free_large_kmalloc". Is that
> warning due to a NULL pointer, or due to a double free?
>
> I don't see how it could be from a NULL pointer since in kfree() the 1st thing
> it does is trace the entry, but then the 2nd thing it does is return "if
> (unlikely(ZERO_OR_NULL_PTR(object)))"
>
> So I'm suspecting a double free, and setting dp->tx_ring[i].tx_status = NULL
> should fix that issue.
Sorry, I didn't understand you at the beginning and I thought that you were
referring to the complete fix (including setting to NULL). You are right, it
is a double free and the test is not necessary, just set to NULL after
freeing.

Thanks

Best regards
José Ignacio


