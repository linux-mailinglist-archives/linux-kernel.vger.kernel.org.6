Return-Path: <linux-kernel+bounces-245576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B291092B484
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3B801C21E3E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5A915575F;
	Tue,  9 Jul 2024 09:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AYzguC7Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD1B15534D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 09:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720518995; cv=none; b=c4IAZ9HBYO14wITSAqDytR8I4uo8DMEzMt9Ac9KiP/NYYTrBWu3pbLLtx76fzuTgdYvGRnJSlOmS2HvHL3lniuNoNHHHA/V7TYrDHxHUxF/DMsD5Lf4tUncOPIq2FE/uRjFFx1qeqR9rOhNZM01J1ce6yzsbATPNmf4gZQTSO+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720518995; c=relaxed/simple;
	bh=Hc8mWwTsSqLiKssBhrXI+RSJ3hB0JGDAaECesXNRoKg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AOi6imkyqfeshT8Zbi8v6UAIbrNjq1TNjwwxnTE9ql67fWAB8ldvnSDPvEmcC0WiBQtDmQVVEG6kts6OpXLEWTE2i1xYZdBIwljdqQ11dkknoC4fwpcWfUm4s4ERd3m6C3z0LAx7utlfgalOIJEwhjYAVnp3wz9Unjy4uAFH2p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AYzguC7Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720518993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LQm8VxvucuXhAHUDsU97RygdB8K+z8KC0PccTln5VKI=;
	b=AYzguC7QDtPIpFBd2qIZgTj6Ies6YGxtwkoxXQm9CxzhcWVdZLPHCK0momFoEUXXnCjJAU
	j9h8y0/qa3sOlym93SoQG5unj/tqQgWahHpQDXQZGrnlP8/JMV7KgLfjKcixxDCGZLgIW5
	JAm8la9vVkHC4Sfpw8AMqCLH6uWQHQU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-me0haLOVNvacykUi3jFQTg-1; Tue,
 09 Jul 2024 05:56:30 -0400
X-MC-Unique: me0haLOVNvacykUi3jFQTg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE74F1955F45;
	Tue,  9 Jul 2024 09:56:28 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB8D219560AE;
	Tue,  9 Jul 2024 09:56:28 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 2DD3130C1C1C; Tue,  9 Jul 2024 09:56:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 2ACDA41970;
	Tue,  9 Jul 2024 11:56:27 +0200 (CEST)
Date: Tue, 9 Jul 2024 11:56:27 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: Alasdair G Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
    Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the device-mapper
 tree
In-Reply-To: <20240709185733.4aac356a@canb.auug.org.au>
Message-ID: <49ab648e-3c89-d4d-f2f7-3c1e2aa2cab@redhat.com>
References: <20240709185733.4aac356a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12



On Tue, 9 Jul 2024, Stephen Rothwell wrote:

> Hi all,
> 
> After merging the device-mapper tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> Documentation/admin-guide/device-mapper/dm-crypt.rst:168: ERROR: Unexpected indentation.
> 
> Introduced by commit
> 
>   04a1020ad350 ("dm-crypt: limit the size of encryption requests")
> 
> -- 
> Cheers,
> Stephen Rothwell

How should it be fixed? Delete the '-' character? Or some other change?

Mikulas


