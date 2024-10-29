Return-Path: <linux-kernel+bounces-386401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 893179B42FB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BACD61C21EA8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9475A2022DD;
	Tue, 29 Oct 2024 07:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZFFRnWR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C941FCF49
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 07:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730186464; cv=none; b=spbzm4SSmilqnYnCqfWSqyS0x1rZO5yrc4o5o+pdva86k+ApE3oG7wcPpejQQu5brKceiNNWKMGkcNss/pwnIrpwCVq5zJ7/caeBkPvN390ykFXQJoZLPZALesSjwnHiWkyTGHYrfhrv9N+LhdYTXljjH6rnvtAxX0RnSwYY77k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730186464; c=relaxed/simple;
	bh=fErTdzEXL/RTrwBgiVhh2pngyoLJSz8VMgJYeRG7yjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNsE3EKlOLgINITXADJBfHKnz3uaz0IGiJo8vPIa6UdCeka+M56vfDEoDApGk51XaETUCaRVdReP4qBF/I/ch2W4TO0RBiU3ZqnENjfr9m2eUNVZbm+VRpOSnAlicsB5imwhGuCPDoBlXrZC/3GhZd7plujg0BcUrtVZP14LMDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VZFFRnWR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730186456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IiCHGdTR4rr29W5iFVVYTtuqJGTR54mDJK7cR08LVCw=;
	b=VZFFRnWRCzAP9XTxlGmHxtCESp50ns4DkQ2vd7I1NpNWMKYJLFvy7R1e393wNrUmcI2EWH
	p2qOCoFPo4l69AeXYBL4h6XjcigJvJ+bMzP5pP4jYXz/6JOfFg21xPB5tahApQ3R/w1kmR
	z1gV5FEMqqotGc/YAhPLt1M5LXns9ds=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-6pCR-5cWNz69PllIezbVTQ-1; Tue,
 29 Oct 2024 03:20:53 -0400
X-MC-Unique: 6pCR-5cWNz69PllIezbVTQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8A3119560A5;
	Tue, 29 Oct 2024 07:20:51 +0000 (UTC)
Received: from localhost (unknown [10.72.112.66])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F59619560A3;
	Tue, 29 Oct 2024 07:20:49 +0000 (UTC)
Date: Tue, 29 Oct 2024 15:20:44 +0800
From: Baoquan He <bhe@redhat.com>
To: x86@kernel.org
Cc: dyoung@redhat.com, daniel.kiper@oracle.com, noodles@fb.com,
	thomas.lendacky@amd.com, lijiang@redhat.com,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH v3 0/2] x86/mm/sme: fix the kdump kernel breakage on SME
 system when CONFIG_IMA_KEXEC=y
Message-ID: <ZyCMzFCSpsFxrCPh@MiWiFi-R3L-srv>
References: <20240911081615.262202-1-bhe@redhat.com>
 <ZvoUHcDGsCyX9fg+@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvoUHcDGsCyX9fg+@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 09/30/24 at 10:59am, Baoquan He wrote:
> Hi,
> 
> On 09/11/24 at 04:16pm, Baoquan He wrote:
> > Currently, distros like Fedora/RHEL have enabled CONFIG_IMA_KEXEC by
> > default. This makes kexec/kdump kernel always fail to boot up on SME
> > platform because of a code bug. By debugging, the root cause is found
> > out and bug is fixed with this patchset.
> 
> PING.
> 
> Can this be added into 6.12 so that SME system is available? Please
> tell if there's any concern or comment.

Ping again.


