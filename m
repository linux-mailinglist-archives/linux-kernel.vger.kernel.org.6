Return-Path: <linux-kernel+bounces-283647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AB194F745
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BBA9284BC3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB19918E772;
	Mon, 12 Aug 2024 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TOasl+bI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B4513BC02
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 19:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723489770; cv=none; b=ePdKwkQEv9v8PYrFjdDG3G7xrDdCw2FJXOyDmFkS8LJH2+HRbrqyOeaFME0/1ZPBdgNNPXULoJG0E4KRmjcqUecjkGEi9DOJah31IuZz6xDSRtsu7ZxCqWIHltpXCgD5n3ZAIvJBdlABM3lbk2/5DfVq2p1B2wIjHuWe4nceBng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723489770; c=relaxed/simple;
	bh=hl3zhelEZdSlFNb3HG51ao21RebGZxdvqI3dcz3HA+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KT+k1KTIvGreishLY6Yr1s4uHk7KO4YN+51jeHvYYXWArLIkS94/K0LMP0ZAhvwKIk/6+Y4qBeNylvZKZRrZUnDEErUopI/1ODpNceS0gnV8DK2+iX6kd3JILKK5ewN4X2DMaGeXTzeOqSEV9/LbAfua3oovRDx3sSigyAiqvmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TOasl+bI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723489767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8rWSMdZMas+2CGR4Nj0Z/BwCy53ptGF3/CJIWkdpz7c=;
	b=TOasl+bIa3y51UPMX3VPX4Uv4yMueBCbNrDoK819Tq2leoHjGPy/B6n6/iqWGO3mN6jc/+
	9y3/1SLW1/KJM0UoHyuEHCHUmRNTlEjKNm7uAFNNQvzs9uKBE6f1QP+by83YmhQFYShkQI
	RTMlLB3UIWYh1P5F4RnMR7mlGar1JEw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-KQI689RTOCyZN-kQkQ07Ew-1; Mon,
 12 Aug 2024 15:09:23 -0400
X-MC-Unique: KQI689RTOCyZN-kQkQ07Ew-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D2F11944F0A;
	Mon, 12 Aug 2024 19:09:22 +0000 (UTC)
Received: from [10.22.33.123] (unknown [10.22.33.123])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA7161955F6E;
	Mon, 12 Aug 2024 19:09:19 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs: Remove unnecessary NULL check before kfree()
Date: Mon, 12 Aug 2024 15:09:16 -0400
Message-ID: <B6F7413C-FCF5-441D-81E5-B08766CBC2FC@redhat.com>
In-Reply-To: <20240811121809.127561-2-thorsten.blum@toblux.com>
References: <20240811121809.127561-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 11 Aug 2024, at 8:18, Thorsten Blum wrote:

> Since kfree() already checks if its argument is NULL, an additional
> check before calling kfree() is unnecessary and can be removed.
>
> Remove it and thus also the following Coccinelle/coccicheck warning
> reported by ifnullfree.cocci:
>
>   WARNING: NULL check before some freeing functions is not needed
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Correct, of course.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


