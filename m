Return-Path: <linux-kernel+bounces-389928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0169B731E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 04:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BD9A1F2593F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 03:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74827139D03;
	Thu, 31 Oct 2024 03:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PQoHyQfH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC05826AD0
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 03:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730346087; cv=none; b=jmt967pro8d0jnmkt/l23Z/8znvKg/QRSt+KEofkPJfdC/Io+cqjUup0hCn3648VECRjUL7d1uJN9Y/tdkxr457x1NEbwk2zb35VEqs2V2NOgsg25npllkJqzc9bjN1eSgymRDbVBHWYgYEKKt1/JUAnajYNHYuMvtIJ0paEOh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730346087; c=relaxed/simple;
	bh=jgKiNzsGrXxxV0JsFN98yJ1rNKKThkpUguht9lLu4yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQTHKIhGupZUT6AssZ2bshr0opPd56VD2FdfyFAEvDmvYS26nk+JexAZVFbcIp56fkapOXhGkKWwonYEsguvnQx96cKdUSYkU96nBsGDIpzHbEo2NZSxTI//Z/PckuGZLxgRoTzTrC+BwKzrLVXOAY0t3G0hdl25Zp+Hg/8lX3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PQoHyQfH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730346084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mzos0guM5CCjsx4ktHYZDA2/aTNVPouGHC3JHAxwbeI=;
	b=PQoHyQfHSvO7eixAYtjDzledyCxiNP3NaorzeWMGgX9s0dy8jJ9ZrdwDTmy30bbrtLNH/9
	XOGb1DDI+/jPgttJ5mqDkLBHhTwcmTYTF/beYxDYSWOw1HcWz4RannfEXX92bN1oGq85Tp
	PPtzgPxjFVrvsLgrMnik2VRsun17LW8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-bWcVKkV5MF678Gqq89Il1g-1; Wed,
 30 Oct 2024 23:41:21 -0400
X-MC-Unique: bWcVKkV5MF678Gqq89Il1g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99ECE19560B1;
	Thu, 31 Oct 2024 03:41:19 +0000 (UTC)
Received: from localhost (unknown [10.72.112.132])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4AA2A1956054;
	Thu, 31 Oct 2024 03:41:16 +0000 (UTC)
Date: Thu, 31 Oct 2024 11:41:12 +0800
From: Baoquan He <bhe@redhat.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, dyoung@redhat.com,
	daniel.kiper@oracle.com, noodles@fb.com, lijiang@redhat.com,
	kexec@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v3 1/2] x86/mm: rename the confusing local variable in
 early_memremap_is_setup_data()
Message-ID: <ZyL8WDTw9F3laupG@MiWiFi-R3L-srv>
References: <20240911081615.262202-1-bhe@redhat.com>
 <20240911081615.262202-2-bhe@redhat.com>
 <20241029181101.GXZyElNXVuF6596TKG@fat_crate.local>
 <ZyGDlYsg6YWNXSVo@MiWiFi-R3L-srv>
 <8c81835b-97fe-a0b3-a860-0bbd5c0341f6@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c81835b-97fe-a0b3-a860-0bbd5c0341f6@amd.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 10/30/24 at 07:49am, Tom Lendacky wrote:
> On 10/29/24 19:53, Baoquan He wrote:
> > On 10/29/24 at 07:11pm, Borislav Petkov wrote:
> >> On Wed, Sep 11, 2024 at 04:16:14PM +0800, Baoquan He wrote:
> >>> In function early_memremap_is_setup_data(), parameter 'size' passed has
> >>> the same name as the local variable inside the while loop. That
> >>> confuses people who sometime mix up them when reading code.
> >>>
> >>> Here rename the local variable 'size' inside while loop to 'sd_size'.
> >>>
> >>> And also add one local variable 'sd_size' likewise in function
> >>> memremap_is_setup_data() to simplify code. In later patch, this can also
> >>> be used.
> >>>
> >>> Signed-off-by: Baoquan He <bhe@redhat.com>
> >>> Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
> >>> ---
> >>>  arch/x86/mm/ioremap.c | 18 +++++++++++-------
> >>>  1 file changed, 11 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> >>> index aa7d279321ea..f1ee8822ddf1 100644
> >>> --- a/arch/x86/mm/ioremap.c
> >>> +++ b/arch/x86/mm/ioremap.c
> >>> @@ -640,7 +640,7 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
> >>
> >> Huh?
> > 
> > Thanks for looking into this.
> > 
> > I ever doubted this, guess it could use the unused 'size' to avoid
> > warning? Noticed Tom introduced it at the beginning. It's better idea to
> > remove it if it's useless.
> > 
> > commit 8f716c9b5febf6ed0f5fedb7c9407cd0c25b2796
> > Author: Tom Lendacky <thomas.lendacky@amd.com>
> > Date:   Mon Jul 17 16:10:16 2017 -0500
> > 
> >     x86/mm: Add support to access boot related data in the clear
> > 
> > Hi Tom,
> > 
> > Can you help check and tell your intention why the argument 'size' is
> > added into early_memremap_is_setup_data() and memremap_is_setup_data().
> 
> That was a long time ago... I probably used it while I was developing the
> support and then never removed it in the final version where it wasn't used.

Thanks for confirming. Then we can remove it to avoid confusion.

Hi Boris,

Should I send the fixing patch alone and clean up the useless argument
'size' later, or squash them into one patch?

Thanks
Baoquan


