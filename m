Return-Path: <linux-kernel+bounces-312691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 757FD9699DB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CE171F237D6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2E91AD254;
	Tue,  3 Sep 2024 10:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aIOs5wpK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64391A0BED
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358540; cv=none; b=TknUe/aY3RKpgAFw5o5JHutvJGZtHYhm5o4uTsDukhsZSE1uZeua1XUjnS/togNvCASNKuHQ/5F6VPzMjGVICCXraaO2dnoj/Jw3Ijmf5/q9kCAicKOcjbnNSWTeSLqF5Ip2xQDfg8NNqGtIq5h3AWrtAqDCD353E+5FtUs28jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358540; c=relaxed/simple;
	bh=3ROBpLYRQU5t6rZgCY30BR3EPdo1Yn+grvnf5y04KUk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=A6AfXQYHZgtiZAq7qhYEbIZ2aTJna+tB9o/BW2d85RU8QLc+EvyDMcm7fzlrvsej83a7VI/b1OdlpauIJxif5Tyz7/zCfZd4u8Dq1QEsEIFj8vSc51Nz2eBK303CAW8Tm4DqpWzjvwE6TaocbOt8yYmBeBNq3MNs/q+be13oPuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aIOs5wpK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725358537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cmLYwYb+SWbQ2tgv0jNSGEqLxszTO3ibo+yOFRuOLE4=;
	b=aIOs5wpK3b3myMJs8IYUKdKJDbyT0bVcf6JQGHNvEI8zDehmh4CNM38jBw/MtNYwbKfDy2
	gAVLzSWcA5r5vgZmRCSRjufUCVJ28n07iQvohZOY/ErPAzJlCW2UwU8qLQqawUw3HW91ll
	il/CwzaHUMl8BXR7s8kowFtkVffbyM8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-NPQHD1dQOXKKCet7cnWEtw-1; Tue,
 03 Sep 2024 06:15:34 -0400
X-MC-Unique: NPQHD1dQOXKKCet7cnWEtw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E43A11955F45;
	Tue,  3 Sep 2024 10:15:32 +0000 (UTC)
Received: from [10.45.224.222] (unknown [10.45.224.222])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A8441955F1B;
	Tue,  3 Sep 2024 10:15:30 +0000 (UTC)
Date: Tue, 3 Sep 2024 12:15:28 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev, 
    linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] dm-integrity: introduce the Inline mode
In-Reply-To: <512a07c-d41a-27c4-b1f9-8fe19352d1f@linux-m68k.org>
Message-ID: <46e7758b-c9d1-d381-3959-16cb943e5de5@redhat.com>
References: <c994d5e-cc3d-d7f5-ce3-fd2cf91e850@redhat.com> <512a07c-d41a-27c4-b1f9-8fe19352d1f@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15



On Mon, 26 Aug 2024, Geert Uytterhoeven wrote:

> 	Hi Mikulas,
> 
> On Tue, 25 Jun 2024, Mikulas Patocka wrote:
> > This commit introduces a new 'I' mode for dm-integrity.
> > 
> > The 'I' mode may be selected if the underlying device has non-power-of-2
> > sector size. In this mode, dm-integrity will store integrity data
> > directly in device's sectors and it will not use journal.
> > 
> > This mode improves performance and reduces flash wear because there would
> > be no journal writes.
> > 
> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> 
> Thanks for your patch, which is now commit fb0987682c629c1d
> ("dm-integrity: introduce the Inline mode") in v6.11-rc1.
> 
> > @@ -4433,9 +4737,12 @@ static int dm_integrity_ctr(struct dm_ta
> > 		ti->error = "Block size doesn't match the information in
> > superblock";
> > 		goto bad;
> > 	}
> > -	if (!le32_to_cpu(ic->sb->journal_sections)) {
> > +	if (!le32_to_cpu(ic->sb->journal_sections) != (ic->mode == 'I')) {
> 
> As reporting before in e.g. [1], this is causing build failures with
> gcc-5 and -Werror:
> 
>     drivers/md/dm-integrity.c:4718:52: error: logical not is only applied to
> the left hand side of comparison [-Werror=logical-not-parentheses]
>       if (!le32_to_cpu(ic->sb->journal_sections) != (ic->mode == 'I')) {

Hi

I fixed it. The fix will be submitted upstream in the next merge window.

Mikulas


