Return-Path: <linux-kernel+bounces-343047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA0B98962E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 17:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE381F22513
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 15:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E582515C150;
	Sun, 29 Sep 2024 15:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oo9AmKs0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC157B667
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727625433; cv=none; b=NwI6vIgP+rIahP0JFn49ep2AybyJR1HgzQ+IUe2vXZ0x18VXjT0c3gKG5V/WNlbLwGlDqTkWW0Gajpo4woqBkVE3cxHS3RubdPYE7ESg9ncDS3eFol4adXL8GzN3jtFlIzgI7YrCuior9kOmJosLqW08EQP/kaJMwYWIivBQ/Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727625433; c=relaxed/simple;
	bh=zXuUxvbxqdiqeSsF35Mzz13cPHbzEzbDbbgC5x/B9aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ladM9mocCdcPgXDZTbklq59jgQIdOdBiLwLKh9NvmGqdOzLPgxX3Ysp5Ics1/zl4tiLWE2zdbKQ4q4vAjuSMoreJWRO2Lx9ACPBNgdntPSNQ53Js2N2n3A418AmUSpGNhuEBkKxBZYEFg0HnUzUI1aqasMdmiimMbif5kTW+OVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oo9AmKs0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727625430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zXuUxvbxqdiqeSsF35Mzz13cPHbzEzbDbbgC5x/B9aE=;
	b=Oo9AmKs0EW33JEefYayjBsByLD+wRoZwXgHM8aIblvTqqp5DRrjKRCCQ8mHlCwZMgfBYZd
	PQBgvalAt3Urx2qCi4FkC8bkjePu4oqNkNi0SPfMVEZSU/j/UwmzzeajBgNiqvL+TrGPCD
	35sr9THEziOxklyoJI7vdUI0PDj38X8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-uUvuSsbrOruJNAIAFJZ2wg-1; Sun,
 29 Sep 2024 11:57:05 -0400
X-MC-Unique: uUvuSsbrOruJNAIAFJZ2wg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C231119B9ABA;
	Sun, 29 Sep 2024 15:57:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.44])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1A4EA19373D7;
	Sun, 29 Sep 2024 15:57:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 29 Sep 2024 17:56:50 +0200 (CEST)
Date: Sun, 29 Sep 2024 17:56:46 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Liao, Chang" <liaochang1@huawei.com>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: fix kernel info leak via "[uprobes]" vma
Message-ID: <20240929155646.GB8931@redhat.com>
References: <20240926162901.GA9716@redhat.com>
 <20240929223956.5043f74bc781a124e761f013@kernel.org>
 <20240929145000.GA8931@redhat.com>
 <20240930003931.f1927079bf6feccb6627416e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930003931.f1927079bf6feccb6627416e@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 09/30, Masami Hiramatsu wrote:
>
> On Sun, 29 Sep 2024 16:50:00 +0200
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > Agreed, can you route this patch?
>
> Yeah, OK.

Great, thank you!

> OK, if you can do that, can you add it and resend it?

OK, I'll send V2 with the updated changelog in reply to V1 in a minute.

Thanks,

Oleg.


