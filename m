Return-Path: <linux-kernel+bounces-569895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D14FA6A8E6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 079133BCD5F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1150D1E32D7;
	Thu, 20 Mar 2025 14:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="islBIcnP"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF8616D32A;
	Thu, 20 Mar 2025 14:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481908; cv=none; b=O4szitWigpWBpZKdfXO95dPYr/CPFm/+PnQjMEm8S07Q6QaLu20EXNkoxjd80Ywu87spgsO9Q+PkSf3lFXR8NG83o+i2zGjcExgiz7KPHSger0KQso+FzQWI6Tu1XBYgvcjTfOWX+5Gz0zI3IoZrcD+ZE+Wzy8G0grXxaCvnJJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481908; c=relaxed/simple;
	bh=kvFDZZfubpKqfDarf88i3jdXBTPwFlTbnMmYGlzeAK0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fskSpV+iVsAnypHQiP4tz5umBDfaGQ1dZHRSyI2QGYG6AvCNTovSCKTC3cpqWMW6cWBJBlsoUuP/qBHBbu5+HAAIR+ohECCkxmNizY8jE7D04n54Du8Gz2V5TKorEE4tbTWhBCFcX0swbHJH7OYQMUveHIYHvbcFMLtep+39u1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=islBIcnP; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6D2FF41067
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1742481904; bh=CoF70uKeI5oxzSiOPNjzHWGikLf7hCVkYp2xH2dZwr8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=islBIcnPKt8uW5hA3T3PPSmSCAiYqTkWFBEgj6iGu0PWPhW3yjcXFHgamlCxP1MrS
	 /Lj+fUKxr5XHpTVprLUBgUismDvPS5CB5J1IUUz2odXEXKxobBdvyGKp74eASDg1b7
	 3NcoQjKXG2u/38NTpV85yQL2oGjhpBevYaOfsEqQNZYT3+llSNJ46De0it7L6QHik5
	 4OCNYQKMEJTCOOJW9yd4iQ9bGRG/5GewfSs/+M1vFeCmQII3N0M93VIhTR33fzTGT2
	 XjQTWkJpZniQrdJpagKpy1B+EeTb8h9XOtTFnPpNxPzbj/PPuetJF6/iR/xdwKAoCn
	 7GVrkwxcSB9Ag==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6D2FF41067;
	Thu, 20 Mar 2025 14:45:04 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org
Cc: graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org,
 anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com,
 benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
 dave.hansen@linux.intel.com, dwmw2@infradead.org, ebiederm@xmission.com,
 mingo@redhat.com, jgowans@amazon.com, krzk@kernel.org, rppt@kernel.org,
 mark.rutland@arm.com, pbonzini@redhat.com, pasha.tatashin@soleen.com,
 hpa@zytor.com, peterz@infradead.org, ptyadav@amazon.de,
 robh+dt@kernel.org, robh@kernel.org, saravanak@google.com,
 skinsburskii@linux.microsoft.com, rostedt@goodmis.org, tglx@linutronix.de,
 thomas.lendacky@amd.com, usama.arif@bytedance.com, will@kernel.org,
 devicetree@vger.kernel.org, kexec@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org, Changyuan Lyu <changyuanl@google.com>
Subject: Re: [PATCH v5 16/16] Documentation: add documentation for KHO
In-Reply-To: <20250320015551.2157511-17-changyuanl@google.com>
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-17-changyuanl@google.com>
Date: Thu, 20 Mar 2025 08:45:03 -0600
Message-ID: <87wmcj69sg.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Changyuan Lyu <changyuanl@google.com> writes:

> From: Alexander Graf <graf@amazon.com>
>
> With KHO in place, let's add documentation that describes what it is and
> how to use it.
>
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Co-developed-by: Changyuan Lyu <changyuanl@google.com>
> Signed-off-by: Changyuan Lyu <changyuanl@google.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  25 ++++
>  Documentation/kho/concepts.rst                |  70 +++++++++++
>  Documentation/kho/fdt.rst                     |  62 +++++++++
>  Documentation/kho/index.rst                   |  14 +++
>  Documentation/kho/usage.rst                   | 118 ++++++++++++++++++
>  Documentation/subsystem-apis.rst              |   1 +
>  MAINTAINERS                                   |   1 +
>  7 files changed, 291 insertions(+)
>  create mode 100644 Documentation/kho/concepts.rst
>  create mode 100644 Documentation/kho/fdt.rst
>  create mode 100644 Documentation/kho/index.rst
>  create mode 100644 Documentation/kho/usage.rst

I will ask again: please let's not create another top-level docs
directory for this...?  It looks like it belongs in the admin guide to
me.

Thanks,

jon

