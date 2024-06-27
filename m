Return-Path: <linux-kernel+bounces-231987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F276891A127
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5F61C21781
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53FE745ED;
	Thu, 27 Jun 2024 08:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T5e3TRNw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UWJzLCu0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SJsXO90Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IF6HcUwx"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5428A7347E
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 08:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719475837; cv=none; b=UMpCEaXml9lchRkQCU8qGoUE25YKclxmw7+aevZvBJUjNLlpebSZdDuB1uY48hWrsrfLFugYD+XepOCY+7jIKT9lTnjU3Z3DmM26BHg2L+cQ8ac/1Y/+QsHZr6XQobcJwQLkTDTiRtiAnd6WLqSDCMLILmBrZmeujvqOFCsrqLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719475837; c=relaxed/simple;
	bh=MNdIV2qk3sEG1FDAhhdiDJnZ7AgICbuvXyhVW1pcZYo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eyv5sXBg9LQ8Pjr8NO7EDlI4RYh5jzjOUcREBMdqpH3iz7vTuHy/SuPo8YP19Tp3hxai3+cQwsqVnWlnyAuplFsVWePcsC+/ZggSOjR/3eR5F7TfbvEjA0e8+GoSkSKAq9QEbNvrvtvlLgwt6x1ustndORLDMC06iqDebnxGwnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T5e3TRNw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UWJzLCu0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SJsXO90Z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IF6HcUwx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
	by smtp-out1.suse.de (Postfix) with ESMTP id 56D9E21B62;
	Thu, 27 Jun 2024 08:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719475833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O/6bKq4Llc5fVguWZOvySL2EpXqSm5wW1VCRN/H060g=;
	b=T5e3TRNw5488vzhgVQe8aAo7J4NB8KWUWaZHJo4LGBaTy3ne3FrCpWvGjq2cQtK8i+Alad
	55EJ5ZMN5w5aHbGtTpj8zg3TIlwtbpolQdk6xiGX48ShQeaKdybr8j6qG2jGvpzdl7DUkr
	B+supgOhi4HSt8HZixhtdd2kaxs0/4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719475833;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O/6bKq4Llc5fVguWZOvySL2EpXqSm5wW1VCRN/H060g=;
	b=UWJzLCu0nbusV2XQPoU19fjHKw/YjolxGL0/UPRAYbBXsbvUYAuPYNrSFExHdQGDx668zT
	4HCL2tIeIBsiDtAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719475831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O/6bKq4Llc5fVguWZOvySL2EpXqSm5wW1VCRN/H060g=;
	b=SJsXO90ZTmZNvd4HrKg1Fo0TWZe72U5/Y04jsZ9hbmds6RxuY7Uu98Z1BGKo82Mivv0D+j
	vA4qXWao6T3R2ceo0XB3EfYlWQIbD7YZWSBVKBYQhiMGo1aw2G+XGY9NwhSl5Dw88qAK+U
	t/z53QSdbqtkEce5d5cPR7ixccuJjqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719475831;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O/6bKq4Llc5fVguWZOvySL2EpXqSm5wW1VCRN/H060g=;
	b=IF6HcUwx4qYltG85wA4ByX/ubyFpy9+iwe1K0Zqp5nzBAimsG8e5GwY3L1LwDBOGSu5zYv
	/rwX5I07a6KRs3CA==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
	id 476F94A050D; Thu, 27 Jun 2024 10:10:31 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: Celeste Liu <coelacanthushex@gmail.com>
Cc: "Dmitry V. Levin" <ldv@strace.io>,  Palmer Dabbelt
 <palmer@rivosinc.com>,  Paul Walmsley <paul.walmsley@sifive.com>,  Albert
 Ou <aou@eecs.berkeley.edu>,  Guo Ren <guoren@kernel.org>,  =?utf-8?B?Qmo=?=
 =?utf-8?B?w7ZybiBUw7ZwZWw=?=
 <bjorn@rivosinc.com>,  Conor Dooley <conor.dooley@microchip.com>,
  linux-riscv@lists.infradead.org,  linux-kernel@vger.kernel.org,  David
 Laight <David.Laight@ACULAB.COM>,  Felix Yan <felixonmars@archlinux.org>,
  Ruizhe Pan <c141028@gmail.com>,  Shiqi Zhang <shiqi@isrc.iscas.ac.cn>,
  Emil Renner Berthing <emil.renner.berthing@canonical.com>,  "Ivan A.
 Melnikov" <iv@altlinux.org>
Subject: Re: [PATCH v5] riscv: entry: set a0 = -ENOSYS only when syscall != -1
In-Reply-To: <9c102328-6bb3-46b6-bc2f-d011a284d5b0@gmail.com> (Celeste Liu's
	message of "Thu, 27 Jun 2024 15:47:47 +0800")
References: <20230801141607.435192-1-CoelacanthusHex@gmail.com>
	<20240627071422.GA2626@altlinux.org>
	<9c102328-6bb3-46b6-bc2f-d011a284d5b0@gmail.com>
X-Yow: Your CHEEKS sit like twin NECTARINES above a MOUTH that knows no
 BOUNDS --
Date: Thu, 27 Jun 2024 10:10:31 +0200
Message-ID: <mvmr0cin6vc.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.20 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_NO_TLS_LAST(0.10)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[strace.io,rivosinc.com,sifive.com,eecs.berkeley.edu,kernel.org,microchip.com,lists.infradead.org,vger.kernel.org,ACULAB.COM,archlinux.org,gmail.com,isrc.iscas.ac.cn,canonical.com,altlinux.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hawking.nue2.suse.org:helo,suse.de:email];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -4.20
X-Spam-Level: 

On Jun 27 2024, Celeste Liu wrote:

> suggestion and we found cast long to ulong is implementation-defined
> behavior in C

There is nothing implementaton-defined in a long to ulong conversion.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

