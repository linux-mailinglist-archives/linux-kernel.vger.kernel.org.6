Return-Path: <linux-kernel+bounces-279523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAAC94BE77
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF5F282633
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8535D18CC1E;
	Thu,  8 Aug 2024 13:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RP8CF4m3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B13818B475
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723123291; cv=none; b=Uj9NXHg+w7LHoBveMdaCTcOGhFoy+5TwnCXFjjx0StiwC+WWm9xbnIldGGU1JuigpU3gbjHlQAnGcdfE74fZYKejdsGmWYjkCTw9FnkkGAyrWQ/Y1m8IA97uiwpm8BTMyTinFOb4pBq499COqH92PulN24sm2665ki7Rf6mhWkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723123291; c=relaxed/simple;
	bh=voxIidc+bu09SL1fdDxa9CxG6oZNDwShZXW+6MTh88s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ez/ntXNfB2DYVXkWSf9V6di4NmT0e05wPzWf4c9A6kw+XaUOSxhtTqXypPZGa0NtWbWCLVyYYekP2MYbX/3xp0pbeX4wG0iImGC05PyTGpQ4fO/CJx/xPLC3xRkO9kAzoEcHkzAtYM+SFbP4rxwAu1MiOTD0YQWIWAaTaE5x/zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RP8CF4m3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723123289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hoD6+q9lWBYV5Y2sZnVNVJtxg5xTJA0wa/FmI0JBJo8=;
	b=RP8CF4m3Ny8FjxoT2inA33f408qY32htcFZJ9XGZDkyjWCE19gtU4KQ2n8ysq48LK++Jrn
	en6pmljJyvTUTG/nZoY0UtUCm4DzxuZkjIOIjU3xrC1OOgAyl3KB3k/zwz97XeUX5HG2Z/
	wAKSKS2hQIxldyV+pvwCzLF8IFB1rK0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-XZO5YEC7O8eFwtnt1lRJag-1; Thu,
 08 Aug 2024 09:21:26 -0400
X-MC-Unique: XZO5YEC7O8eFwtnt1lRJag-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D5CA19775FB;
	Thu,  8 Aug 2024 13:21:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.245])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B1BF1955F38;
	Thu,  8 Aug 2024 13:21:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 3E48B21E5E6E; Thu,  8 Aug 2024 15:21:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,  Shiju Jose
 <shiju.jose@huawei.com>,  Cleber Rosa <crosa@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  John Snow <jsnow@redhat.com>,
  linux-kernel@vger.kernel.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH v6 08/10] scripts/ghes_inject: add a script to generate
 GHES error inject
In-Reply-To: <e9f2011095facb566815ccac13c9c87be710fa5e.1723119423.git.mchehab+huawei@kernel.org>
	(Mauro Carvalho Chehab's message of "Thu, 8 Aug 2024 14:26:34 +0200")
References: <cover.1723119423.git.mchehab+huawei@kernel.org>
	<e9f2011095facb566815ccac13c9c87be710fa5e.1723119423.git.mchehab+huawei@kernel.org>
Date: Thu, 08 Aug 2024 15:21:21 +0200
Message-ID: <87ed6zup4e.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Using the QMP GHESv2 API requires preparing a raw data array
> containing a CPER record.
>
> Add a helper script with subcommands to prepare such data.
>
> Currently, only ARM Processor error CPER record is supported.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

[...]

> diff --git a/qapi/ghes-cper.json b/qapi/ghes-cper.json
> index 3cc4f9f2aaa9..d650996a7150 100644
> --- a/qapi/ghes-cper.json
> +++ b/qapi/ghes-cper.json
> @@ -36,8 +36,8 @@
>  ##
>  # @ghes-cper:
>  #
> -# Inject ARM Processor error with data to be filled according with
> -# ACPI 6.2 GHESv2 spec.
> +# Inject a CPER error data to be filled according with ACPI 6.2
> +# spec via GHESv2.
>  #
>  # @cper: a single CPER record to be sent to the guest OS.
>  #

Accident?  Drop, or squash into PATCH 04 instead?

[...]


