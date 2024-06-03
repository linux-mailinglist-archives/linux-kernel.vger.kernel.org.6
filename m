Return-Path: <linux-kernel+bounces-199199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F90C8D83B5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0C291F21DC0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BC212CD8B;
	Mon,  3 Jun 2024 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="TLEHQHsK"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC92F1E516
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 13:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717420601; cv=none; b=TTlXuDPq318TEU3jlvXvxDOOEQz2D0mN5pnxo+LA5RGOGacHgM1WtZ+KuqhHUFN0QM6TP5b05JY37P/Avqo/61WVZHy6J9/fKJx8wDHpgrUJYEhDdDxwyWiQSE/kOxk+5GXyQDl4519tPSIRnETIp+szdYOf9rJ+dAaLs0kioh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717420601; c=relaxed/simple;
	bh=l+WIyHgTLhnFhf8BaYaueMhJZVr7Ddc9ryc1XX4xAwo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=DXmPMGaMqpRy6g48dG1rq8MEGNwLO4phaNWnkdYSCjp8cqO33XT/t2ARh+ucx+1IFDVbGDil5e+J17ZIkeUrIbBrSWyMnnL55iQ0XbNJf8Q1nOjdraFLuwLg2SyuaMgNJtki/6KR2pn5/Mb6yld2EDMuFJmEbb3jhnABp3V7ufM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=TLEHQHsK; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717420551; x=1718025351; i=markus.elfring@web.de;
	bh=l+WIyHgTLhnFhf8BaYaueMhJZVr7Ddc9ryc1XX4xAwo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TLEHQHsKC4MJswesnKJfupIHS/56t9GHBTToi1ghqco1WIm/7iFm88gf7aMHTM5H
	 DiVlwuLVUgZLWX9VAO9xpq8R+ise2EZgSv2uaAfUIcVY7ate8biWhqWJ9pNYzKvR3
	 OGAfBAeeQEMO6u5KZRROH2ghmXjCskfZkpZGKzNnL8pafz/b575F0c38u6qEGogcq
	 /i0pQKq4AmvgELieSxPASSz/Jql+SeSTYjJ8kCGqpEG+YYjV/r52LMUy120Z8flt3
	 /KmYOJ1Qy/6HBjavpdq89QobQqnoYXU0qe88JGcephnt52JN4cZrjvOEowjnQwc2f
	 6NhqxIfXU8LNr25MOQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjPPs-1suN7V0cCg-00he9D; Mon, 03
 Jun 2024 15:15:51 +0200
Message-ID: <d9fbc964-c5fd-4b55-8f9b-db6971c3188c@web.de>
Date: Mon, 3 Jun 2024 15:15:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Geunsik Lim <geunsik.lim@samsung.com>, linux-mm@kvack.org
Cc: Geunsik Lim <leemgs@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Axel Rasmussen <axelrasmussen@google.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@elte.hu>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>
References: <CAGFP0L+BaNAtCF7c7cJ1bvbjomp03Fy0=6=w6dj29Fnr0ygSCA@mail.gmail.com>
Subject: Re: [PATCH] fix: Prevent memory leak by checking for NULL buffer
 before calling css_put()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAGFP0L+BaNAtCF7c7cJ1bvbjomp03Fy0=6=w6dj29Fnr0ygSCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:su21ZysES24P7GJnZCmdwTrLwleufIWg/x6RtUyVSRvY6qDNFwS
 YOgQP6RKqAtOzYXUbZ00GkaL6SodMmvDRY3dt4IQlCeJyyMTNli3UckYcs34hASVl31fzi9
 aGrUkZhWcjhbiFc5fNW1XZgfiH6SC9bNGP0j2tK3gR8owRuemWMzNyCE10aPh9AI15m2DES
 PYFGUDoHNrVT1TRwY4MbQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:T7gFyDWMF6w=;G9VKhKd2USAhNh3h8kfItzutdKu
 YqFU0t2q+nk8PLIuNGSFYapNddBrP8IhHqvj+t+RhXvxtvf/3beGqugfHswwU8E0dgi0JKXP4
 iOERIyhFgQLKXT70ZVU2w3RMMIIl7PrZhiKKTYIm+T3Bn7ABDAYoZ2B1M1BsfaFbHSjOluFYa
 AN7u2yjVYBxaG0NXUe2P/Wr3yQa01F7TjDeyIUQ9nyHHWANQ5we/KM1A4ecgNp/1XTtvMW5If
 Rv4yIzPtpIiFG1krWgc+XEsqRAlEqO2sCfEVGoVnOSdGOnUXwinJEoz8xqzXWom1Rr3lw5r5P
 niurGmaUE+Dg1LsxRvVzivVhrqeYCtHxXbNyM8zXoMSWTyd0tuTFGki6W0AA1GjN1ggVxSj3F
 sS9KMPoFiInRjn9jsd1ZxNgBtruFNp8ztNbdQutm8isPvQeeTxr9r5qc1CyPnWHaG1AVokkw+
 RX15DOkhY44h/EvXK+cSFYitGZkAPTzD/8eUWeY4BahYnjV+epkZ2Agcoh2XnUY1vdEAyn0TK
 K02LIzammtX8c6eO/Nm7jZ3Y9LwhE9GDuR6mPbI7UNDdflj7v2XhCuplWDzPaJML2m6x4LtEB
 V9vIYO2c/DIJGqQRgjysAaWPQ4Lhx/NziRwruG+yRYETfbZTbQoB118BuxxHp2Yk9gBApl4eY
 f62MvqmelMjrQfR16tQRaVqlUe/LJXR45qY+l4QDD1GAqE90aImMZSvDhkkEssu1yTfwETUg8
 uv0zZ+1w/mq+p937ikmUP7YWWi9jwzyqXe4wikqA+qmwAbILPint8kt+LfBTMmdZweZaEd+qb
 uhnUxmzQJF4xs97d5kMp4zlQ/wjpfcs/5kPCrHvX6cYZ0=

=E2=80=A6
> Previously, the code would directly call `css_put()` without checking
> the value of
> `buf`, which could lead to a memory leak if the buffer allocation failed=
.
> This commit introduces a conditional check to ensure that `css_put()`
> is only called
> if `buf` is not NULL.
=E2=80=A6

How did you come to the conclusion that such a source code adjustment
would trigger a desirable effect?
https://elixir.bootlin.com/linux/v6.10-rc2/source/mm/mmap_lock.c#L188

By the way:
Would you like to reconsider word wrapping for such change descriptions
any more?

Regards,
Markus

