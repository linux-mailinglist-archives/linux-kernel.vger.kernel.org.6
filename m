Return-Path: <linux-kernel+bounces-442299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F129EDA59
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8828E282CDF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D131EC4F0;
	Wed, 11 Dec 2024 22:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="HEHg4QN+"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17782594A0
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733957217; cv=none; b=FvlAbwztwGhZ6RJwxoSdO81QC5q/DrXAp4AzqTG2fapWWY7MM/kEudziUdNbp5xnCv7/+FFjqUkQJF4KZyWbZZw4AGn1+oPca7yNkIbBY2v8rXNEsu9SRCfYs0tdmvBqjvIuCEAcAZPzGpXLJKFGIXIdMlbioe09WfQNdxEyM9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733957217; c=relaxed/simple;
	bh=XmpTB5P/asjgarifWBAVexcPHqExuER4d7PMPYHy4CA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k9TsyY3839/OG39F51oLoCYanfhG6Q9BkGhosbrrYp7TKcDiHJrM02hRjY5s1NcUgEIM62J0/QrMij9O/4OFlQgTs77hKKe+NHNRDmV1c8MxevX7/MW2OvjY14P2OLFbfmtN1OY5B7OPvDaK7azqPEIrfh+qLDbXK2B1I2AWjrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=HEHg4QN+; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1733957190; x=1734561990; i=spasswolf@web.de;
	bh=XmpTB5P/asjgarifWBAVexcPHqExuER4d7PMPYHy4CA=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HEHg4QN+M90I4L1WdUjMgCx8DVG10Q+GiW8G7e8AVR+Tqy2sT0o09Swg7nVofqwS
	 HTUQZYIc5VlrFpsRUiIGlHIB/oY2Nw7DYtxLVeE5iq/XXYgXkrGY0XwEoCMy4zsMU
	 UI6UQ2lMxCsuxM+ktRy83tPoE8Di/elj1xhfwMfsFpZ2wLCPOYgh7yCTGHQQoNEbr
	 WZ+Hdsgr0uy2nqtkUymy82HmZUQp0eppjq84j0jWmVfalvhf6HWCJEEYwDNGR69iW
	 D+3sTeYrWk5RLM9M/E54h9618FlegDKopZhfy5XOtVNAVwTKlaRIwOqDlsUygnYw3
	 lLh5QzaVLVKlnmZcDQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N4NDG-1tmgoC2wGk-016YGW; Wed, 11
 Dec 2024 23:46:30 +0100
Message-ID: <75a27bab5671c43d2be6a26ac23916b731204086.camel@web.de>
Subject: Re: commit 894d1b3db41c leads to frequent hangs when booting
From: Bert Karwatzki <spasswolf@web.de>
To: jstultz@google.com
Cc: Metin.Kaya@arm.com, boqun.feng@gmail.com, bsegall@google.com, 
	daniel.lezcano@linaro.org, dave@stgolabs.net, dietmar.eggemann@arm.com, 
	joelaf@google.com, juri.lelli@redhat.com, kernel-team@android.com, 
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, longman@redhat.com, 
	mgorman@suse.de, mingo@redhat.com, paulmck@kernel.org,
 peterz@infradead.org, 	qyousef@layalina.io, rostedt@goodmis.org,
 tglx@linutronix.de, 	vincent.guittot@linaro.org, vschneid@redhat.com,
 will@kernel.org, 	xuewen.yan94@gmail.com, zezeozue@google.com,
 spasswolf@web.de
Date: Wed, 11 Dec 2024 23:46:26 +0100
In-Reply-To: <20241211213527.3278-1-spasswolf@web.de>
References: <20241211213527.3278-1-spasswolf@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b3w36GzgeUomm/gZwauiR76zHBz2rePbPKlR0WHY3m8ruZzcm7I
 bA00zD1F25RVWBANit8cnWfFtKDwh4xfvXj3X//Ig8OXD/9fJ0LNFxYBlGO/is6B49MlMYY
 XHmwLgq5xEDpETx/1RbZUYMQEull0FL1jwxC481CmKIKfM4YUn2BCPtDT7fgEmOsluRfhy1
 bWqlVn0dMefEXiS8Axo0Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+n79VlMm6Qk=;2cWKFcfXzgtA65gFMhRYR/emH09
 Mb0Rj+xq1JosHMEmZvGRKFvfjgEhM7OY9sv9YAhflylh+U1K+qkMk6+ujZWTVnxU9FchO0uJi
 KV7tcKKW7dZFyEHMtgovKUh532T6fQpX8d5hsU5jrBkQrTo2Te0F87Vr2h8tn/mjHhuwhpixw
 ch8sRrW1PICHWV+pDJT6dwQ6CGnGVGCd+eMb8gQvD+Ms7VX9axwqpZs8fwlqE0DLglOoew4rr
 nb0AImV6vU77cSNQa3v0L+ZCooMkH0pLPFaIcULeTyrUKvBG07yLGdOLc57zU5JqfjHqwvJ+2
 0V4w3ZPmaWIE/t4xrs17g/712ZcPVmrfJDsXn6lWjrDiN6i66rtGsECgS2lVof4o6Y0KSNAE7
 YHabBUaRZm6MPgekJj8ixZIvvFl+8DFmMpCqX9h4naL+Xg4DokUwsqyfew5SjoviEXbG8Hfkv
 uuG8yqpNf71Ti/g2JSZ7pmtdQfxvoFqzq7KBsc6oe1U3y2qNHLwIJazlAcvV6fJPcyD9NhrG6
 bmJE2Esr8QYtIijYwSE2Bj2H+egVnZflvfoyzkEugnMKbt/mfV+N2nzgzVnu0+udXkY486c4+
 QILck1srtEQqXzn2CTv1XD2i9us44ZsvdLqwcFLYPg/3uy4g+Th6G7pT8ooycJF2eXBoRx9N3
 bFUxsSL3NPx02shh0UVtcRqiLsGq9iJLWzAlXMb1ZN8RdEHSE+SuUcCo93ngCwZHBYfVGdP7g
 kIvpX+f78aNHD0b+/hZ3Ya3+YIb0qpiMPJVfdpFETmZBXLwfZuYdzqy0KlIXYXXJyoQ7AqEwQ
 stk7iIOrtcMLOcGNUicAkfe2eLsw+myJnH8LCymFpikrxkUWXyd158akBUSq5VQfUOzXkLqYz
 /KBUnPNddo2zsUxhbCF1zcdTPqP33l+7TOOoyVlvFizJIjJXsxo9cw+WvXXbYR57TX2E0HYSF
 1e4drZIOSeuF0a9XNIlLN+2ewwsgNZehrfxpxeljnX/6JUybtUcSzqub/JP94+ne7jM4IF8I4
 7Ral/hGeqfAUYULq8AJTBmLAfKkPAnddeCMvI9f0Fa31D2vAuFAQI6vubfNVG3K+kyoIDX4DB
 SmOFJ4thk=

Am Mittwoch, dem 11.12.2024 um 22:35 +0100 schrieb Bert Karwatzki:
> I have confirmed that I that linux-next-20241210 is fixed by the same re=
vert
> as v6.13-rc2 (ten boots without incident is the criterion for a good com=
mit)
>
>
> Bert Karwatzki

Also this bug only occurs with CONFIG_PREEMPT_RT=3Dy, I've just checked v6=
.13-rc2
without the revert and the following preempt settings and got 10 clean boo=
ts:


CONFIG_PREEMPT_BUILD=3Dy
CONFIG_ARCH_HAS_PREEMPT_LAZY=3Dy
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=3Dy
# CONFIG_PREEMPT_LAZY is not set
# CONFIG_PREEMPT_RT is not set
CONFIG_PREEMPT_COUNT=3Dy
CONFIG_PREEMPTION=3Dy
CONFIG_PREEMPT_DYNAMIC=3Dy
CONFIG_SCHED_CORE=3Dy

Bert Karwatzki


