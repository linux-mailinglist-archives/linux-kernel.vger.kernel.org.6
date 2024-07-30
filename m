Return-Path: <linux-kernel+bounces-268056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D22BC941FD7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A4D285C74
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6AA1917C7;
	Tue, 30 Jul 2024 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lK8cQuQ4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c+ufuVS1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B59D18FC75
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 18:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364569; cv=none; b=CGq1DhQnzjOVBHj0dYQHW31zAol7OFynxxfEKwkF4usE8rJjHl5didt9OA27fPcORQWuO8jKidkoHyHMf+XpSvJ0qZ0+3silZvoLGMjQvw2Eb0VHpKg2ht4DdpKtDDwMCdQptqxx/0/PwpinowLqWQpVp01fe9q4jOLC0ji3DsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364569; c=relaxed/simple;
	bh=qAkb3L/9/ImoWzdyghJep8SgsQxBSZSdKRYK5rkg44o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lqvNOiEv6TRMvOYmSHOem86xXl4agNhCpI3IbeHBy3KRLX8qmYTOTjvvWKz4ugNOJJbtn7jR4b3xC936kUikBw3jikb2YME0tqNfgYxt8Z7H0EH4Eup52sG9f7sH3ZjESxxj9ERpCrndIaSRp2Dd3JZ+81tr3L89+wjaXxvRvjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lK8cQuQ4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c+ufuVS1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722364566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qAkb3L/9/ImoWzdyghJep8SgsQxBSZSdKRYK5rkg44o=;
	b=lK8cQuQ4kTdHcIWfAzC003i9rdZU2ZNdop0zMt5hF/8D24RAYbRj2YA2wYyU5HhUbx8NLk
	OrfY4Ms9SRnOq6GsPbUOxiB4TFhWxbiO3YOJKfAIKzWriQCwE38wtC5JrQo5jLPXX6Qbs7
	14kx4sDxTgKZNxQsBTneWMycV/urGnDzVnCRgQR0B2oqeUEzwJjxCJpxtZZT/gIRI/856P
	PHdzdRB1aoUEJrJmZR57gktiPJ6LvVXFdKaMLk+V6fJAcHtb4diB9epXIxDxoS+L4t+LIm
	YYNDtBGvSkl5bF7pvqjv8ck8DeVMHmXgsr+7pZo6s7LN3udiW4gfeVWjnJe4/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722364566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qAkb3L/9/ImoWzdyghJep8SgsQxBSZSdKRYK5rkg44o=;
	b=c+ufuVS1B8LTsGIKO6edaFHNqdyoFKD9cmeGV2Qb/j/+EuQMNXbVGmfYfkLmZ55qNvBOPS
	StJ0HkC5wtGde+Dw==
To: "Alexey Gladkov (Intel)" <legion@kernel.org>,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton
 <akpm@linux-foundation.org>, Yuan Yao <yuan.yao@intel.com>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Yuntao Wang <ytcoode@gmail.com>, Kai
 Huang <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, Oleg Nesterov
 <oleg@redhat.com>, cho@microsoft.com, decui@microsoft.com,
 John.Starks@microsoft.com
Subject: Re: [PATCH v1 3/4] x86/tdx: Allow MMIO from userspace
In-Reply-To: <0331020dce360b77e40c53dfdb0624574dbb249f.1722356794.git.legion@kernel.org>
References: <cover.1722356794.git.legion@kernel.org>
 <0331020dce360b77e40c53dfdb0624574dbb249f.1722356794.git.legion@kernel.org>
Date: Tue, 30 Jul 2024 20:36:06 +0200
Message-ID: <874j867mnd.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 30 2024 at 19:35, Alexey Gladkov wrote:
> The MMIO emulation is only allowed for kernel space code. It is carried
> out through a special API, which uses only certain instructions.
>
> This does not allow userspace to work with virtual devices.
>
> Allow userspace to use the same instructions as kernel space to access
> MMIO. So far, no additional checks have been made.
>
> Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

