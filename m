Return-Path: <linux-kernel+bounces-339630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2802C98681B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 23:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587891C21902
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 21:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E334D14D2B8;
	Wed, 25 Sep 2024 21:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E3cBsnqf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37513145FFF
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 21:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727298590; cv=none; b=GB6jxBWR0MyzadCpG2vk1RVc0TY3WtQgdTK9voNp7ylOmw3HKN6XIh/o0EtZ8bFNlhfGM0XAJ8pxysYJfnU1OEkq8hIYEAdEHJi9RV53a/jW+J4lna+Soe9tWcXGVaulaBily7m0EhYT5KonVijHMeMTXyT+C8vIoeoRxbtWv/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727298590; c=relaxed/simple;
	bh=ltJU61g0F1kiJyay/V4sLGhXkraR2ot+HlyaNfiBreE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tY4HEyCSLEEHRUSRgDw0w+FFEGuc+MWiLim+baOELapi6qH1YaKH9zNs/d03clL2hkjDIwVllyL8wRcwpcP144mOlyRyiMcOHL6GtpTADoZxzH6nfGA7nJN8SquUgDNf+kJiiLi86gyQrm+E9eBMCRw2r8J8TFM8vxi6zn6E89E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E3cBsnqf; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727298588; x=1758834588;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ltJU61g0F1kiJyay/V4sLGhXkraR2ot+HlyaNfiBreE=;
  b=E3cBsnqfqLA2R+IvMK/9TxHpCe6Flsam01KeL5bfV2gEmu0osPJZBGLp
   HYWdt+kh/5/uhdkMZ9A9Yf63baba12cn3/CPh4OfyjmU16CizN2GK1hMo
   BWk2rVZicpicMATKr3fE3yc5PIHSAOCfse9P/wXCoYCbBhjRXMDJZ9tfj
   S+ePkpOCInSz7Nokt/0meCbtq7YEOyRMP9RsoMFMM6i4qEcJDC3PJbHze
   wMQyKKN7vZzH0+MPlpqrPL/BP2298/DwbDS7TQR+BfmAqJb9d1w2/NkG4
   Tae2fo6nnwZ+ypvyUlhNjSDHTsRxC8rIxq8IzBpgrK9WSSfCiHcxt85EE
   A==;
X-CSE-ConnectionGUID: WrxCIWLlR1WE1kLIzWOjGA==
X-CSE-MsgGUID: os9SCyMoQOqjv1vu6/fmwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26235405"
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="26235405"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 14:09:11 -0700
X-CSE-ConnectionGUID: qlQst7lHQbC5667tIj4vXA==
X-CSE-MsgGUID: xukS9XTvTV2/dpDf0CJANA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="71998838"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by orviesa009.jf.intel.com with ESMTP; 25 Sep 2024 14:09:11 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id 2063930183B; Wed, 25 Sep 2024 14:09:11 -0700 (PDT)
From: Andi Kleen <ak@linux.intel.com>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org,  Ard Biesheuvel <ardb@kernel.org>,
  x86@kernel.org,  "H. Peter Anvin" <hpa@zytor.com>,  Andy Lutomirski
 <luto@kernel.org>,  Peter Zijlstra <peterz@infradead.org>,  Uros Bizjak
 <ubizjak@gmail.com>,  Dennis Zhou <dennis@kernel.org>,  Tejun Heo
 <tj@kernel.org>,  Christoph Lameter <cl@linux.com>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,  Paolo Bonzini <pbonzini@redhat.com>,
  Vitaly Kuznetsov <vkuznets@redhat.com>,  Juergen Gross <jgross@suse.com>,
  Boris Ostrovsky <boris.ostrovsky@oracle.com>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Arnd Bergmann <arnd@arndb.de>,  Masahiro
 Yamada <masahiroy@kernel.org>,  Kees Cook <kees@kernel.org>,  Nathan
 Chancellor <nathan@kernel.org>,  Keith Packard <keithp@keithp.com>,
  Justin Stitt <justinstitt@google.com>,  Josh Poimboeuf
 <jpoimboe@kernel.org>,  Arnaldo Carvalho de Melo <acme@kernel.org>,
  Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC PATCH 25/28] x86: Use PIE codegen for the core kernel
In-Reply-To: <20240925150059.3955569-55-ardb+git@google.com> (Ard Biesheuvel's
	message of "Wed, 25 Sep 2024 17:01:25 +0200")
References: <20240925150059.3955569-30-ardb+git@google.com>
	<20240925150059.3955569-55-ardb+git@google.com>
Date: Wed, 25 Sep 2024 14:09:11 -0700
Message-ID: <87ikuj30g8.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ard Biesheuvel <ardb+git@google.com> writes:
> This substantially reduces the number of relocations that need to be
> processed when booting a relocatable KASLR kernel.
>
> Before (size in bytes of the reloc table):
>
>   797372 arch/x86/boot/compressed/vmlinux.relocs
>
> After:
>
>   400252 arch/x86/boot/compressed/vmlinux.relocs

I don't know why anybody would care about the size of the relocation table?

What matters is what it does to general performance.

Traditionally even on x86-64 PIC/E has a cost and the kernel model
was intended to avoid that.

From my perspective this patch kit doesn't fix a real problem,
it's all risk of performance regression with no gain.

-Andi

