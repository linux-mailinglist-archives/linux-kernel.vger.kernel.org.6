Return-Path: <linux-kernel+bounces-268985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1091F942BE7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9941DB2142B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0032F1AC429;
	Wed, 31 Jul 2024 10:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yuEGRxPn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1jxQraHY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C398801
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 10:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722421671; cv=none; b=o00q/JxZUWSAD77tVrfSnzQUQB9gAd5vTq3lyzMnNLttRUh44vKqkSt/jI/xJgLUogEpcK/EnKm4Tv4TITs1eV5ATX2mtmzXWrKoT8gKg2JDLyMzhR5MpPVGYj4hpSgASFKTiuQYHCXiarXuL+hESj9b5oTizOlhibILEh/2NAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722421671; c=relaxed/simple;
	bh=VkBQrTlGKZcqjcTDf1cGm4WHIvbTX55EQ5gHO70PdAQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W3eHX68q6RFZRyilG8CqZNIKIQJHmirouCCDkTkqs734lRO14xJcEFwXJU62wV1Drbp5er7SmxiFwCAm884x5uw2aGjTf337ENQdRpi3eONbhW7vEckND7gLExVG0JltiAitxEL+C5iZuP7ZfPYd0yL2nULsvYMjdqZJL3d5/SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yuEGRxPn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1jxQraHY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722421668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+2WiS37JbmCxNlGKN1CAx63Qz/WDKprgYFwCmASZdTs=;
	b=yuEGRxPnuDJr/wvzoTRwB8tWCsiYJd1IrUYwualwZPB0NanY9Fz1kyE2FQ83eK8irtFHJg
	nrrbZXe+2gZOgU63dY4TRxdgWvmAkZqUKIl5rbPpxoDq+LBo2x21gQ60e+4UFj7g4/2TBj
	K6EFEyjuko13nUTbew+usImvUOB0sIE2BFaVMkzsdfUyPA2M94XqBowTR+4P1jbv9e9dmB
	RFQDOS2rLdMkQmL77x625cvGHyvRHson48b39y01txtg5uCUVSOOIDDbcj4VgbJUKHTrL3
	LQQfDDrR6eM4/8uMvg6sHIvxubRFRLTBWDioFWWZh/uNlUJZlLNbvaVeoHHpbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722421668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+2WiS37JbmCxNlGKN1CAx63Qz/WDKprgYFwCmASZdTs=;
	b=1jxQraHYtD4qSM38HL7PNqHpM032iKDVgHeii9Bsvxh9UYzxKL2leZzOLohHaNN2ye5G9t
	P7ipU/OtrhYQYxAA==
To: "Nysal Jan K.A." <nysal@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>, Michal Suchanek
 <msuchanek@suse.de>, "Nysal Jan K.A" <nysal@linux.ibm.com>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, "Naveen N. Rao"
 <naveen.n.rao@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Pawan
 Gupta <pawan.kumar.gupta@linux.intel.com>, Ard Biesheuvel
 <ardb@kernel.org>, Eric DeVolder <eric.devolder@oracle.com>, Sourabh Jain
 <sourabhjain@linux.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Laurent Dufour <ldufour@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/2] cpu/SMT: Enable SMT only if a core is online
In-Reply-To: <20240731030126.956210-2-nysal@linux.ibm.com>
References: <20240731030126.956210-1-nysal@linux.ibm.com>
 <20240731030126.956210-2-nysal@linux.ibm.com>
Date: Wed, 31 Jul 2024 12:27:47 +0200
Message-ID: <87r0b96el8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 31 2024 at 08:31, Nysal Jan K. A. wrote:
> If the user has decided to offline certain cores, enabling SMT should
> not online CPUs in those cores. This patch fixes the issue and changes
> the behaviour as described, by introducing an arch specific function
> topology_is_core_online(). It is currently implemented only for PowerPC.
>
> Fixes: 73c58e7e1412 ("powerpc: Add HOTPLUG_SMT support")
> Reported-by: Tyrel Datwyler <tyreld@linux.ibm.com>
> Closes: https://groups.google.com/g/powerpc-utils-devel/c/wrwVzAAnRlI/m/5KJSoqP4BAAJ
> Signed-off-by: Nysal Jan K.A <nysal@linux.ibm.com>

Assuming this goes through the PPC tree:

  Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Michael: If I should route it through my tree, let me know.

Thanks,

        tglx

