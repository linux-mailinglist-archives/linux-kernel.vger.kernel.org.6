Return-Path: <linux-kernel+bounces-536961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 751A9A48668
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A8D164325
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4479B1DC9B8;
	Thu, 27 Feb 2025 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dgM0bLYA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6C51D5AB7
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740676404; cv=none; b=ECUKKjK4MxDA7ZcJjDQIjXocTPTqIvXDo/Q3c5dDHnnyX9Cp2BbOSF2tXYVNUysPCCJcohx55cyo6KvqadPQksIL8FoykgRB2+w+r8LrYApjuqbymZODDhLaKpFSaNA+nZbLe812j/fIi5H0JyKw3K+Fg4a9ISn0t8H6DbcbHkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740676404; c=relaxed/simple;
	bh=TC6frsDM+/9tSsHy7M6daCpw9KqvuE9mdRA1+bIEnyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTCQphJclxTtIWs1lxMTjc6z1FNVCjhHZL+t6AtMfgNxEJwoUoEIZgbqJVoMk6GnaAQ4led8PbftuWNj55dzQa5FfB3Ito5wLfFS3tQ8eYAk/F5yEEXzKdx8iFQHpwpt0bQOarszEnZduBgILezDRuRkWAUSpSlnILT9B2io8ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dgM0bLYA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740676401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XzXmsE9Expxm+FyvE3ioQhLue1pjlpaem6Ooi+vTdPI=;
	b=dgM0bLYAfPrA5kjqW4NCe9iC5HhKpKmVQ9YnAulKKwQyea5mlLfDRwc6saun9iqqVeIxu6
	czzJGam2cgdDUIiWOFJxRvNvLTEnlS3CGP5szdGkawB7MzAAKNf8VLsZW1zTwEXXe+GpVa
	eU/aQyKZs/YzgkU/SjZmZuqxW9s7W4o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-IzkHkFm3OxyVBCFJX_QD8g-1; Thu,
 27 Feb 2025 12:13:20 -0500
X-MC-Unique: IzkHkFm3OxyVBCFJX_QD8g-1
X-Mimecast-MFC-AGG-ID: IzkHkFm3OxyVBCFJX_QD8g_1740676398
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19D231801A18;
	Thu, 27 Feb 2025 17:13:18 +0000 (UTC)
Received: from redhat.com (unknown [10.22.82.64])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29ABE180035E;
	Thu, 27 Feb 2025 17:13:17 +0000 (UTC)
Date: Thu, 27 Feb 2025 12:13:14 -0500
From: Peter Jones <pjones@redhat.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	Lenny Szubowicz <lszubowi@redhat.com>
Subject: Re: [PATCH] efi: don't map the entire mokvar table to determine its
 size
Message-ID: <8f085931-3e9d-4386-9209-1d6c95616327@uncooperative.org>
References: <20250226201839.2374631-1-pjones@redhat.com>
 <CAMj1kXGoZ5RB4GWs_YTG7g+vGZokwe3yF-ri5BV4vOBinhqfLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGoZ5RB4GWs_YTG7g+vGZokwe3yF-ri5BV4vOBinhqfLQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Feb 27, 2025 at 08:50:08AM +0100, Ard Biesheuvel wrote:
> 
> Should we add something like the below to avoid mapping the same page
> over and over again? Or is this premature optimization?
> 

I can't honestly say I'm sure either way, but I'm leaning towards
thinking it's probably worthwhile.  On my development tree the number of
these we wind up doing in the maximal case is 31, and but in a typical
case it's more like 20, with a series that looks something like the
below list of sizes and relative addresses from the first entry.  (I
generated this with ls and awk, so it's not quite exact but it's
fairly representative.)  I've marked which ones could be eliminated.

map 264 at 0x0
unmap 264 at 0x0    <-- gone
map 264 at 0x146    <-- gone
unmap 264 at 0x146  <-- gone
map 264 at 0x2a2    <-- gone
unmap 264 at 0x2a2  <-- gone
map 264 at 0x43e    <-- gone
unmap 264 at 0x43e  <-- gone
map 264 at 0x548    <-- gone
unmap 264 at 0x548  <-- gone
map 264 at 0x660    <-- gone
unmap 264 at 0x660  <-- gone
map 264 at 0x84d    <-- gone
unmap 264 at 0x84d
map 264 at 0x191f
unmap 264 at 0x191f <-- gone
map 264 at 0x1a73   <-- gone
unmap 264 at 0x1a73 <-- gone
map 264 at 0x1b7c   <-- gone
unmap 264 at 0x1b7c <-- gone
map 264 at 0x1cd0   <-- gone
unmap 264 at 0x1cd0
map 264 at 0x21a8
unmap 264 at 0x21a8 <-- gone
map 264 at 0x22c2   <-- gone
unmap 264 at 0x22c2 <-- gone
map 264 at 0x23cb   <-- gone
unmap 264 at 0x23cb <-- gone
map 264 at 0x24d4   <-- gone
unmap 264 at 0x24d4 <-- gone
map 264 at 0x263c   <-- gone
unmap 264 at 0x263c <-- gone
map 264 at 0x2746   <-- gone
unmap 264 at 0x2746
map 264 at 0x4043
unmap 264 at 0x4043
map 264 at 0x86f7
unmap 264 at 0x86f7

So going from 19 map/unmap pairs to 5.  Seems like it can't hurt, but
it's a small number either way.

Anyway, I tried your patch and it works for me:

Tested-By: Peter Jones <pjones@redhat.com>

-- 
        Peter


