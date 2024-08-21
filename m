Return-Path: <linux-kernel+bounces-295838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5715495A1F3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B271C23FD7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005C216A925;
	Wed, 21 Aug 2024 15:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bZRGA5Yo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CFD1547F6
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255086; cv=none; b=aV1FNa0dxMe89P9Rlk1/pApcBCdyYXM6Y2sWXrR8aNYOPO5wCUhcdaXH40XYXdoBc4vTGxxSx4DmdUBcL151J6qYKrAw768L5l89qTD81eA4duQPwzSxDneXTrNxF8Uf+ROJl1xVDkGP8QfWBKxSolyGp0iZxTphhS48QznSQLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255086; c=relaxed/simple;
	bh=rurQBwGxLpj2WymIA71KzG1DofWdq83pEQdb33jxloc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iHXCR/H2xFowm66MQpkIIGoFFnuqG7sEoTax5FyXOffg0QMiPDzsFo7H9r1FDRGDgd4ycBU4b3YElAL6ME1dqQFQgjYQldzRMK1w+Cf+pTnnBFqbJSfzCMn90mwhvBEjs8Ga1Pyt4bCCUAMlYw7y5Uf9fOOXVE0x34aOKodM6XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bZRGA5Yo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724255083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rurQBwGxLpj2WymIA71KzG1DofWdq83pEQdb33jxloc=;
	b=bZRGA5Yo/eltC8m0AoHYmc/G99Zx+yoE5oD8fjatrrqZkxcdeDMBI9irZFtgPZXVQObGaF
	HRMr7eo1ZZpxol+EXpe2VB5oqKq0gOQYoQ/0EunhnAV72sr9A5rH+RLPk+Ait21Bi//a1m
	MHq4v4LD2c8sNLW2QMu84Oo+BAjR13s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-e02Es0PnOK-NzjB8Wam-tA-1; Wed,
 21 Aug 2024 11:44:40 -0400
X-MC-Unique: e02Es0PnOK-NzjB8Wam-tA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 100741955D45;
	Wed, 21 Aug 2024 15:44:39 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.5])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64EBD1955DD6;
	Wed, 21 Aug 2024 15:44:37 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Lance Shelton <lance.shelton@hammerspace.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nfs: fix bitmap decoder to handle a 3rd word
Date: Wed, 21 Aug 2024 11:44:35 -0400
Message-ID: <358BF534-D6F3-4C05-9490-BC5B1C7B963A@redhat.com>
In-Reply-To: <20240821-nfs-6-11-v2-1-44478efe1650@kernel.org>
References: <20240821-nfs-6-11-v2-1-44478efe1650@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 21 Aug 2024, at 8:28, Jeff Layton wrote:

> It only decodes the first two words at this point. Have it decode the
> third word as well. Without this, the client doesn't send delegated
> timestamps in the CB_GETATTR response.
>
> With this change we also need to expand the on-stack bitmap in
> decode_recallany_args to 3 elements, in case the server sends a larger
> bitmap than expected.
>
> Fixes: 43df7110f4a9 ("NFSv4: Add CB_GETATTR support for delegated attributes")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


