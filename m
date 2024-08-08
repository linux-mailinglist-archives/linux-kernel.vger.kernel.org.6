Return-Path: <linux-kernel+bounces-279711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E4394C0D5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6BB1F26369
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEBF18EFEC;
	Thu,  8 Aug 2024 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Aebew6D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="muLe7dzL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D713C18C935
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 15:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130326; cv=none; b=DzC2AWw8TxavB+ZQPwDQ2eEVn0zLU3t+3aPzEdXioms4+Xt/6e2wUGwrpW2U4NPbESniEV8h5T/92farFQRbyrk6bItFYCaerswwntpQr/KCLEVw+EeAm0Zub/FYVN25c7/umbr+/VJ6/OJPb/O4/hHnFERd6qvAFDvY07uJexc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130326; c=relaxed/simple;
	bh=c/7FkhIHeucHZLEXIPtcW7BvaAb+Ze0f8Z8FKUvdsYE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ss8Y73+eby/7xbkvEgftLWjT2s9NGeUfRIJDf3S7G//0quVBopblNT7cUDGchb2okdFCTTnHzTgXkSWLhbcBHMa/GQyhBouQicuYj8V2qaqpukmGIS0mEA+NJ0+sEvAQnyzFrzGqJgYUKoIhfRcrotXtr23aU13WR7rLekY4o6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Aebew6D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=muLe7dzL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723130323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c/7FkhIHeucHZLEXIPtcW7BvaAb+Ze0f8Z8FKUvdsYE=;
	b=3Aebew6D9Cqv9IGPRp05R8zTRntG8bYi/PdQDpRtKLKLXLUGE7Q45mlnLLnTsJhYMMFu2F
	zOURSVUjdKvigEbXTxfE3YemdC/K3ISxxtd9ALQyKzVP4nv0A986c1f3FkN8AabNBBR4r7
	6Icvh2kxUZbGoZOE5Nx/PUoksILRUwxMNljiCkcRWvpft+zy+MZEansWKB7UEjGEZp0OEW
	9I8KJEB1Zm7XCdGG8A7u7C4pAxmQfOS7AbBaYV+vyhkB6OHqpmDezOqsaLMbGx4mQuSNdI
	sVyCCvrTcpdXw8HTQuo7G5u6MXJZu71E469y+nnzi5UAyolLslTLa4+RucKRvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723130323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c/7FkhIHeucHZLEXIPtcW7BvaAb+Ze0f8Z8FKUvdsYE=;
	b=muLe7dzLf7lNjSn+2dvj5YfGV1xHGMWLagCOiUkHb5GZLzVCGrSdZhuZAI0gXKlV5CaZQJ
	3CH8BE5Fi9WaSKBw==
To: Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>
Cc: Dmitry Vyukov <dvyukov@google.com>, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 syzkaller@googlegroups.com, elver@google.com, glider@google.com,
 nogikh@google.com, tarasmadan@google.com
Subject: Re: [PATCH v2 0/4] KCOV fixes
In-Reply-To: <CA+fCnZeEj_0+8wb6N1JA28kx46U-o7HmAbNbbtm2UnkJcaJ5wg@mail.gmail.com>
References: <cover.1718092070.git.dvyukov@google.com>
 <CACT4Y+Z=U+Y8gKBgaU76=zg=rAdq=AQ=epAq+RxDfdXsaqO_0w@mail.gmail.com>
 <CACT4Y+Zq3t2JXEbGDzYU61Rs5KH3mhCDiZ4GP9OacKuyocnYHQ@mail.gmail.com>
 <20240619083039.GAZnKXL8euon1-hHIR@fat_crate.local>
 <CA+fCnZeEj_0+8wb6N1JA28kx46U-o7HmAbNbbtm2UnkJcaJ5wg@mail.gmail.com>
Date: Thu, 08 Aug 2024 17:18:42 +0200
Message-ID: <87cymjyre5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05 2024 at 14:52, Andrey Konovalov wrote:
> On Wed, Jun 19, 2024 at 10:31=E2=80=AFAM Borislav Petkov <bp@alien8.de> w=
rote:
>>
>> On Wed, Jun 19, 2024 at 07:20:56AM +0200, Dmitry Vyukov wrote:
>> > Or is it OK to take this via mm tree (where KCOV changes usually go)?
>>
>> Be patient, pls, you're on the TODO list.
>
> Hi Borislav,
>
> I was wondering what's the status of these patches? They didn't make
> it into 6.11 and I also still don't see them in linux-next.

Sorry. That fell through the cracks. I'm picking it up now.

