Return-Path: <linux-kernel+bounces-329389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 688849790B0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 13:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE982843E9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 11:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96A61CF2B1;
	Sat, 14 Sep 2024 11:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=gus@collabora.com header.b="UOopn25c"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DDE1CF2A5
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 11:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726314826; cv=pass; b=AZgbSWm7lz3dcd28kW6ZUH1JlJhWuf3AC4S/z1LOTrlFtSR3FGWRqbVRbx9sxMKRX5FzBpED/EbN/iA26plYCr3k54TQOOVUqbWBduKzK99qph32Q8/rRVOtX6kwic3a/NRcSdcXGYPhpc9nzsuHLphurVNNJe6ROyjf0natMeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726314826; c=relaxed/simple;
	bh=2cMk9xzXcz0iTlDggH7xkL6dGopS/AbAy9+ZVXGpiMM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=gwaWZqu4vcO5HFVaQ2sSGDlDj4rJNhwzAtItxeJ8+9N6Fpu+grfvgDzsdAk7KlzsLfMrWsoM52ObQIkkXYZ++hZjxOENOjpE4KBttdFg1MscK7h299imWH1qBPYW088tHFLnEGw9At1vqeitrV0zBccfcC1Gh1I65avZUQNmtoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=gus@collabora.com header.b=UOopn25c; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726314817; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=G3EpJWUW925+weYaPWeimhC30LGUQ5lBgpVnaSj8k8J5o7NMHF8plXG7dYEY56Hr3POoT6+ssFIVRLyJXgom9e2vJjJ/ZgiSwj4Haa2wfAssCPtt5JERvhUmc7XJcH4EX3b/inOR4zGqPlDUHPgW64iE1Gtrl3cEiz7fQ8mOaD0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726314817; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=azMYP6KBpiZIOYO/WQVDNGf4MXZo2M8msIEEBLLHLr8=; 
	b=VgTbMAFgz7xs05sfstKfRfKSfrPar7Lfq576wc7eO3O8pGKo2D/EmvZSmIMoZy7/EZDEBm3BsTQVqFU2w6ZNXTdAPreKE0NfI+Ys4Tr2UqAJBjpLRy6rCnOiAZm21DUusb470bbyKFZk0YwZvmpWq31vK/aH8hm1+0i0KVqbutE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=gus@collabora.com;
	dmarc=pass header.from=<gus@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726314817;
	s=zohomail; d=collabora.com; i=gus@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=azMYP6KBpiZIOYO/WQVDNGf4MXZo2M8msIEEBLLHLr8=;
	b=UOopn25c3eBnbduUsjmKxpRHMsHgi0Cl5z4taXdSPVclQmbV3QS79S8fc6Z48EM8
	NIssONGOdQfec/C+c3M1rt+vPclXVPHnOD8gWhnrVH8R7V/MtxVlAkuW6NMECMKeFvX
	SXd5AR7ZuOyYBWXd7WJH0qZ7IJBNtQNtW9O5FT2M=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1726314816736814.5941690184366; Sat, 14 Sep 2024 04:53:36 -0700 (PDT)
Date: Sat, 14 Sep 2024 08:53:36 -0300
From: Gustavo Padovan <gus@collabora.com>
To: "kernelci lists.linux.dev" <kernelci@lists.linux.dev>,
	"Automated Testing" <automated-testing@lists.yoctoproject.org>,
	"Linux Kernel" <linux-kernel@vger.kernel.org>
Cc: "Berry Sheraw" <bsheraw@ti.com>
Message-ID: <191f061a496.e90034c62577139.3763107244141140980@collabora.com>
In-Reply-To: 
Subject: KernelCI & Hardware Vendors discussion in Vienna
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hello,

The KernelCI community wants to bring together Hardware Vendors interested in collaborating towards a better upstream Linux kernel integration for products and the subsequent long-term maintenance.

If you are attending Open Source Summit Europe or Linux Plumbers Conference in Vienna next week, we invite you to join us. It's going to happen on Wednesday, September 18th from 1:30pm to 3pm at LPC Room 1.34. This is a off-schedule event, but we will try to find ways to enable remote attendance if possible using the LPC infra.

Read more about our invitation:
https://kernelci.org/news/2024/09/13/hw-vendors-meet-in-vienna/

And also check the full participation of KernelCI at LPC
https://kernelci.org/news/2024/09/11/kernelci-lpc2024/

If you are coming let us know. You can reply here, to me or reach out to kernelci-members@groups.io as well. 

See you there!

Regards,

- Gus

--
Gustavo Padovan
Kernel Lead 

Collabora Ltd. 
Platinum Building, St John's Innovation Park 
Cambridge CB4 0DS, UK 
Registered in England & Wales, no. 5513718



