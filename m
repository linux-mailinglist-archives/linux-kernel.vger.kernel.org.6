Return-Path: <linux-kernel+bounces-184456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 896308CA6FD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB1CA1C2101F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC951865C;
	Tue, 21 May 2024 03:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/jFYeyR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC152CA8
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261608; cv=none; b=Dy5GTUfB/GqbVhAa0xtRtpyrCrxv05L8vggdUTMkmELljjjA4YODEnMHj8smqFtxfBbP8NkIGRf45rNFk+gBFlhV52u9y9eEB3+l38K1j5H2EiZnb1sWjQOBrtYxNOnCXqaDAkBWxzsJw4hahxawFpnrkp6zWBzbM4tu4OJ99Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261608; c=relaxed/simple;
	bh=Pp99i8dwVWqPLjoJadp0wrD1mFImJew4KeuMWLz0Jbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+btexzRZYujyNBCekHKBwWyhGV9nHOFFpaq/sDrZRam0qWh7ma+InLZ7+xuXOE9YRedyuPhhUWHLpyJ4k2MF9TdHF5DcS35JhGD/AVA/i5+n7Wo+cV6hwJU2HsUe2ndoUs+H0oywA1r8sKgheg5Mq75OCL7yglue41zdk25VVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J/jFYeyR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716261605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hOmz1H0+MMWbfr1lFiKOcLjgn2XgwhPLxYAWmTnPe74=;
	b=J/jFYeyR1Byj5ZFdSZFjc4vX8LXsOXNCK2eBNgrDKdwdb1xddgDByfT5guELN+FLLdhTZA
	34XwsUDZxOxOvZ7bEecV3ViquwhZX1N4zx1TJh12a/euvDUQ6cS6cyGwlS45PQ8FzC0sC/
	pCPKyn+tYvJvLVDLQqXRct6HWsorutc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-32LAG1HHPKSOFakPszE3fw-1; Mon,
 20 May 2024 23:20:02 -0400
X-MC-Unique: 32LAG1HHPKSOFakPszE3fw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3EB129AA393;
	Tue, 21 May 2024 03:20:01 +0000 (UTC)
Received: from localhost (unknown [10.72.116.65])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C29E45618;
	Tue, 21 May 2024 03:20:00 +0000 (UTC)
Date: Tue, 21 May 2024 11:19:57 +0800
From: Baoquan He <bhe@redhat.com>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v3 0/7] Support kdump with LUKS encryption by reusing
 LUKS volume keys
Message-ID: <ZkwS3UNmjTkK2HeY@MiWiFi-R3L-srv>
References: <20240425100434.198925-1-coxu@redhat.com>
 <ZkrrIf1P6rx3WhjM@MiWiFi-R3L-srv>
 <iwx2noaevjat4uzqvagmrwgxgxj3rufanut4gnjte33thx2bdr@r3fhtf45sgrv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <iwx2noaevjat4uzqvagmrwgxgxj3rufanut4gnjte33thx2bdr@r3fhtf45sgrv>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 05/21/24 at 09:43am, Coiby Xu wrote:
> On Mon, May 20, 2024 at 02:18:09PM +0800, Baoquan He wrote:
> > Please don't add dm-devel@redhat.com in the public list because it's a
> > internal mailing list or aliase. And I got error when replying.
> 
> Thanks for the reminder! Actually it's a public mailing list and you
> can find all emails publicly listed on [1]. I did some research and it
> seems we should email to dm-devel@lists.linux.dev instead. Quoting [2],

I always got this when replying to your patch. Maybe you registered
before.

msmtp: recipient address dm-devel@redhat.com not accepted by the server
msmtp: server message: 550 5.1.1 <dm-devel@redhat.com>: Recipient address rejected: User unknown in local
recipient table


> > To post a message to all the list members (who were subscribed with
> > mail delivery enabled as of 2023.10.20), send email to
> > dm-devel@lists.linux.dev.  You can no longer subscribe to
> > dm-devel@redhat.com, to subscribe to dm-devel@lists.linux.dev please
> > send email to dm-devel+subscribe@lists.linux.dev.
> 
> [1] https://lore.kernel.org/dm-devel/
> [2] https://listman.redhat.com/mailman/listinfo/dm-devel
> 
> -- 
> Best regards,
> Coiby
> 


