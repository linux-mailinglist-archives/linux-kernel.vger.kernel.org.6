Return-Path: <linux-kernel+bounces-322800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FEB972E46
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44BCB287222
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E4818C015;
	Tue, 10 Sep 2024 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCt+lu5u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4EB1885A6
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961251; cv=none; b=bvNrL4cfuI/CXWTFo2LHDwCqX0TEKoFkpU11HNuAAGKSx4tssfkoUy7DyDj4jGB6EST5nbtuLJpzLLHuvbQ2NzQETQOSA5vrP8eykJbHXNh288ModesYOIUuS6P5I3SlC9NXKofB93fl1Vh3bbMTTXj0k0r2KUs3Q49QUzqmGA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961251; c=relaxed/simple;
	bh=pDQz+l8apuQA9xKefB7YZY8tvNvC4eo7EmVtLISQ4GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7KMy5+3NU6fCpo8dR5NUUpLDyi2MJgKdaXq9ajVjj2NOy1WChtoQo+QDORi/9HM0MrMzdU5LUPqlKmSlrBp9KVNSCLoGX0yx7XCVF0UKoUezNpb8agnC8A4kxBc1JmLhWvCaVuhXGJP+nregoIcRsKMAFn5e4yoNA3dmYw6fC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YCt+lu5u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725961248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UFE0gTOSvJ22bbsZXLn7Kw50Px9Uq2WJzebFyV8nzxY=;
	b=YCt+lu5ulSGTYLOcKeMitg2NvFiTA1APuo3mOb8IzbPBL9b9sTbx3qavmOCQzdSaDHieND
	V2Js+yP63CYJxfwLLFfwgVbdLn4Efpoi33w5EbL2+VBQKIXf5JIw1PsMIMzPQh83ifXbF3
	zoEkvOy8N2fXwucKMmSepp0OvfLfN9w=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-srpyLGbuNGu7w9mpKxLywQ-1; Tue,
 10 Sep 2024 05:40:44 -0400
X-MC-Unique: srpyLGbuNGu7w9mpKxLywQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53FDE1954B16;
	Tue, 10 Sep 2024 09:40:43 +0000 (UTC)
Received: from localhost (unknown [10.72.112.58])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE4F1195605A;
	Tue, 10 Sep 2024 09:40:41 +0000 (UTC)
Date: Tue, 10 Sep 2024 17:40:37 +0800
From: Baoquan He <bhe@redhat.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, dyoung@redhat.com,
	daniel.kiper@oracle.com, noodles@fb.com, lijiang@redhat.com,
	kexec@lists.infradead.org
Subject: Re: [PATCH v2 2/2] x86/mm/sme: fix the kdump kernel breakage on SME
 system when CONFIG_IMA_KEXEC=y
Message-ID: <ZuAUFTgK5G2xzSya@MiWiFi-R3L-srv>
References: <20240829104016.84139-1-bhe@redhat.com>
 <20240829104016.84139-3-bhe@redhat.com>
 <43291018-098f-291a-629b-6e02ef00f8e5@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43291018-098f-291a-629b-6e02ef00f8e5@amd.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 09/09/24 at 09:53am, Tom Lendacky wrote:
> On 8/29/24 05:40, Baoquan He wrote:
......snip.. 
> > Here fix the code bug to make kexec/kdump kernel boot up successfully.
> > 
> > And also fix the similar buggy code in memremap_is_setup_data() which
> > are found out during code reviewing.
> 
> I think you should add something along the lines that the "len" variable
> in struct setup_data is the length of the "data" field and does not
> include the size of the struct, which is the reason for the miscalculation.

Fair enough. I will send v3 to add the reason of miscalculation.

> 
> Otherwise:
> 
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

Thanks a lot for careful checking.


