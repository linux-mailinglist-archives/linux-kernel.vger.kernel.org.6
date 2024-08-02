Return-Path: <linux-kernel+bounces-272539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A10945D9E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484CE283920
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 12:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7349F1E213C;
	Fri,  2 Aug 2024 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DQzEWcaM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KZv3piH6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC241DE867
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722600245; cv=none; b=Ck+2HkaTVsFkBUrebuURm8J7u103GaebAyWt/CdYNgNHKwWikzKVQCeH6uuGYLmh0ZC6XbavZVpP9PHqOCny/FMUjW7bD8Y4ldnxd40qKODZgAifiVOejE4aIeYN7vJWFnv+anAMo7gGge45WvGepNktyrxFsgB/aZH190m82QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722600245; c=relaxed/simple;
	bh=brIlL67MZ3bkHdxhS1m1M2V3SjgsHNfL8rdZCpVBr98=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DIy4mMeoe2bGYw+fUG7cLM5+eEa0jx3vGo1Gkscl4C7TIW8G643lx0DwMZSlForH5Ud5stCHUuIJ8ASZG+QG7gothGR3G1T0h2/FynnPveVc300JVOH9gUlxRd63UxmICAiFh8OO98o2zLZAlIU6GEpXHyCrQBI7S+I1Du2Kk8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DQzEWcaM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KZv3piH6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722600242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4CadMtFCez8Rm5yQwTMKEWgyb+hh/0xGSxWWCZULcsU=;
	b=DQzEWcaM9Jc4MkYY9R35g+bZJijr7+SDUadcQyHciBkuF/LFOhdLu432gnEa1SMVAj4El7
	bslE7kcoCP6fSCSS7fMaYEvw9RMgjDY6FEWiAUfLdKA6Hn/LCPqrz2vODeDaq+AN+6HvPo
	6yIh+vF3qz2aBBNguWFXWdY6lT1ANWhQClnW85Nfw3ceMPpXEq8fN7A6W9c9w6O5fD2O/4
	ycV/UC11mX9wM/P8F9gHCKbmKwwdP/sYgZfLgmgQFgszz1Nd3hYfkI6/qdXgr9r2JNrNtH
	nhRPqnS+GNJy6z+TAJPu9G4io3AkAdxGZSeUgY0EE13xdM1uZSFp9yPwMSqtCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722600242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4CadMtFCez8Rm5yQwTMKEWgyb+hh/0xGSxWWCZULcsU=;
	b=KZv3piH6jfT6tjWUG7Ud/pPXshFBQhbsoC/qmKurLMitM7BpXz5q8N/mnTMyMTW1o6vwZF
	mp3s2+F/tBC2cjAw==
To: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
 linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
 linux-mm@kvack.org, keith.lucas@oracle.com, jeffxu@chromium.org,
 rick.p.edgecombe@intel.com, jorgelo@chromium.org, keescook@chromium.org,
 sroettger@google.com, jannh@google.com, aruna.ramakrishna@oracle.com
Subject: Re: [PATCH v8 5/5] selftests/mm: Add new testcases for pkeys
In-Reply-To: <20240802061318.2140081-6-aruna.ramakrishna@oracle.com>
References: <20240802061318.2140081-1-aruna.ramakrishna@oracle.com>
 <20240802061318.2140081-6-aruna.ramakrishna@oracle.com>
Date: Fri, 02 Aug 2024 14:04:02 +0200
Message-ID: <87ikwj168d.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 02 2024 at 06:13, Aruna Ramakrishna wrote:
>  
>  VMTARGETS := protection_keys
> +VMTARGETS := pkey_sighandler_tests

What builds protection_keys_32/64 now?


