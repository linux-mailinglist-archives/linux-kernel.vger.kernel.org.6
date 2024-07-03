Return-Path: <linux-kernel+bounces-239789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D04926551
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E37F282925
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABCB180A9C;
	Wed,  3 Jul 2024 15:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FHOPPJdb"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04C917995
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720022075; cv=none; b=aD6Is6/X965pQ6zHkMR+NlwLGPE07hWUxxZ7SS1bvaP6g6B84E2GS84F5IK8GbTuNaK+HfQiyMgmAELC5hu4TvpLK5wLpMCjUHwJ855NNMuYxuT1Un+tEVffEGosZ+VIu5GFZIvc7KygREwae190dihtUXR/qVA5ZeeHsxnQ0PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720022075; c=relaxed/simple;
	bh=tfqRJwvONI8GGlj/8E/+reu8SFTZ2hWpcslVf0EMaH4=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID:
	 References:In-Reply-To; b=pjPAKt+uj4Dgtg8TTpS4oM6/YXzJbQWelXI+oqVgs0ahfrOYZbUE5RXfbbsGaDqNfF9WhpldqTiL4644OFcCgHusqVYvMNVhwIjsNAydN5h7KpVwRvAqSwmwOi6E70XfDKkt2FOZdvza2gtxTvYMjDhxivsZ0hpmrYxtUSZDkGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FHOPPJdb; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C0C8D40E021B;
	Wed,  3 Jul 2024 15:54:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5R8ocm1oCB7O; Wed,  3 Jul 2024 15:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720022066; bh=O8sfi56HtPF76e9XLUaUnSvoXfoE8PrURdzXWpeiRdc=;
	h=Subject:From:To:Cc:Date:References:In-Reply-To:From;
	b=FHOPPJdbb7oawsQaS0nwefEpH+lLEZWbcp9UiE2sdbu1KlMN/m46PSXhwFG8B7DV4
	 xEzrPdMMb8BS41vpSA8LWk+LSfH8GoDBYsi2U25AsQSFPydXZvoyevBA2WyVVRi/DS
	 8R+Q1htyjIPx521i3+zNcRXCRv/BWHABRwgyfHBLjvN9V/NKUHrac4jOrhD+U7VN5U
	 pFrsdRi3PlNvqDLDGNlaSDIZ7zb3dzehsdHw54ZtAHXGWIfIXhE2Tw1qtHMMPlXgaW
	 SIlaGDXbxhzOUrJW1PDRCDptfDSyjSr7se+s+gZpluHuTaY5CZ3xA0yTL25v45yybT
	 ID9mnJY7KtfOejjIawF8ieNBbZmWOJvPUnTR4WkspPPjiOt5vtuO8rdW3r/ufvbbA7
	 8Hymvs+DyW6Sth1D8K4F2ACVKFQIJUeKdesNZKFfcZRdPPSRnJdoCRCZADgfTeXuco
	 y+SFGe+l2l3xECAzNFMwwuO2wXTp0+mgoaYy6Vr7ZWR+G11/qCkN3WtFUJu3qQElQZ
	 GgNi5q2WQLP6zcYyMTdg3cFwxeYrsZbNS4D+cARph0LWgLWXvcn22JO7liPgSjjWO+
	 rTqvwPu/aQKM3sgJRjT86zZilGGc7R0ZJCcpEt7EJ2gInxOkp0zzaJtku1INWgnpCi
	 tXoZrRlZpoNIojmjzklkXo+s=
Received: from Ubuntu-2204-jammy-amd64-base (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1056C40E019C;
	Wed,  3 Jul 2024 15:54:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1 2/4] x86/fred: Write to FRED MSRs with wrmsrns()
From: "Borislav Petkov" <bp@alien8.de>
To: dave.hansen@intel.com
Cc: xin@zytor.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
 tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, peterz@infradead.org, andrew.cooper3@citrix.com,
 nik.borisov@suse.com, houwenlong.hwl@antgroup.com
Date: Wed, 03 Jul 2024 15:54:14 -0000
Message-ID: 
 <172002205406.3280081.14523962650685954182@Ubuntu-2204-jammy-amd64-base>
User-Agent: Modoboa 2.2.2
References: <9063b0fe-e8f3-44ff-b323-b2b6c338690f@intel.com>
In-Reply-To: <9063b0fe-e8f3-44ff-b323-b2b6c338690f@intel.com>

Dave Hansen <dave.hansen@intel.com> wrote:
>On 7/3/24 01:54, Xin Li (Intel) wrote:
>&gt; Do FRED MSR writes with wrmsrns() rather than wrmsrl().
>
>A longer changelog would be appreciated here.  The wrmsrns() is
>presumably to avoid the WRMSR serialization overhead and the CR4 write
>provides all of the serialization that we need.

Also, all those wrmsrns() writes better be behind a CPUID check.

Thx.

