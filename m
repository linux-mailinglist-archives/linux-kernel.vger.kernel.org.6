Return-Path: <linux-kernel+bounces-334013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 501C597D162
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F061A1F25D98
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 06:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB3C43AAE;
	Fri, 20 Sep 2024 06:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EzddszIU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5190B22F1C
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 06:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726815473; cv=none; b=bxSJN+YjiMqAjKR+gWnE7hmy5OWf6tU64dsKnyvplEG0m1WB/ToHFCvYqzymGD4VjUV1J9J4GWh438bY85yyBRM6P6NwcQcY5vJChbYK25YMDmUR2tcC2Y1Qh5U1hCT8pJkT1h/njaFHsUoGmbxozR+qbGICH6iJMBeBOwfH7q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726815473; c=relaxed/simple;
	bh=/3zJTUKcPcY1qJQvysJac6KKiduAoMFXjdnYlQaWmLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HVIqGN/jKPE0pgUg9FERzFvF5cIhGQGVww1+JsXxTPBiPPYofncwQZkxSX1rIc5RSZj920VwCb2O8yQb4djJin7WsyZZ0PW+p0vJogos22k8lzNQlmoKc8JnVh67S64IkIUJyBjQjUnjRd80uB1pBV4dU1U79alHjeRixD5tQbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EzddszIU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726815468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q+6mbG9HFMsitEGSceaE//8ueiFi32tZoHOiay2lvLg=;
	b=EzddszIUUuGeyGPAyAl0srr7V0P+kZI2ZoY22ecayVx6c+Bph9PEoP6UwchnaR6y6SaopI
	SzErNYf6o2uubmPf1q3BMB2ZqS9ZqmOiDxsPWlJrWiG7z9BSvuE/LzmFL/vxjByak/7DiM
	ustfG9ovP25WlmED08EtpWH5w6zI0Xc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-0tpmOPtIMrqS7utymy6Trg-1; Fri,
 20 Sep 2024 02:57:44 -0400
X-MC-Unique: 0tpmOPtIMrqS7utymy6Trg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B52D192DE05;
	Fri, 20 Sep 2024 06:57:42 +0000 (UTC)
Received: from [10.45.224.224] (unknown [10.45.224.224])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A824D1956088;
	Fri, 20 Sep 2024 06:57:36 +0000 (UTC)
Message-ID: <0402bea4-bb0a-4d67-9ae2-f534a6076861@redhat.com>
Date: Fri, 20 Sep 2024 02:57:34 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] x86/entry_64: Add a separate unmitigated
 entry/exit path
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Kaplan <David.Kaplan@amd.com>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20240919-selective-mitigation-v1-0-1846cf41895e@linux.intel.com>
 <20240919-selective-mitigation-v1-1-1846cf41895e@linux.intel.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240919-selective-mitigation-v1-1-1846cf41895e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15


On 9/19/24 17:52, Pawan Gupta wrote:
> CPU mitigations are deployed system-wide, but usually not all of the
> userspace is malicious. Yet, they suffer from the performance impact
> of the mitigations. This all or nothing approach is due to lack of a
> way for kernel to know which userspace can be trusted and which cannot.
>
> For scenarios where an admin can decide which processes to trust, an
> interface to tell the kernel to possibly skip the mitigation would be
> useful.
>
> In preparation for kernel to be able to selectively apply mitigation
> per-process add a separate kernel entry/exit path that skips the
> mitigations.
>
> Originally-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

For the current patch, not all x86 CPU vulnerability mitigations can be 
disabled. Maybe we should list the subset of mitigations that can be 
disabled.

Cheers,
Longman


