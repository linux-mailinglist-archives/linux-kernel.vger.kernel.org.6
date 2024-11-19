Return-Path: <linux-kernel+bounces-414196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 061BD9D249F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85321F231B9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E451C4A16;
	Tue, 19 Nov 2024 11:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="b21qqKEq"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9371B85D4;
	Tue, 19 Nov 2024 11:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732014720; cv=none; b=MuahesvDfAIavGwht8SJ4VcCtG3hmDvwkTztTqBDBa50hEhlnLqXIKBRfvvwY4NpbwKYhM1Oy4QTYSxeuc1xD/K4hCyiF89+5+4z6M3ipuRjy5g3RGIipEuXmEjaE+aPG8A5zNbi+L1O0Tq1uhPYHeiL96TWR0A4XQ8cbsZ7/aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732014720; c=relaxed/simple;
	bh=opfdVcLWrXjbNH0zo9xJb83W6Msg4MYneaM5kZTDw7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ciR4VtcFww7JumL1VJp4R5l9unKHhki4At9tBdDzilZ4/0JKqGmwf9NqHWxW5KBt82oHBlZ/GNj/G9FCcdQRHftTXdtcjmUrpjYf5ijXqBk8lLdWE3wVvwovWCx9oQHavhyL3U/FhY1sE3dI7KyEvjI9LVjnC9lqsZ2Lhw2vndA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=b21qqKEq; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7HMTsr4ioPCyI0+QIXCcLwBMJLvvA8QCbV5ReQFuxF4=; b=b21qqKEq+pY+nszMGYKxplvLEv
	DZ/D3QnQsf/KL2lJYNT5lSjv+LOQjE03wdvFd37QTL51u0/zfjbJ+YUxQQAvpjY0ZGtxDVfAJcISa
	LSPf1nHxJWMv7WksUbSYbYeYaBL1HMJfe2bfkk8lSmOq14t48v0OXtrVdflgl5Wfkshit1iBOgLJf
	0RqXe5cOATFQdO7RXdOuu5EckBO94vy5NfOqXHlJrf9nqgAr55msfhLjhOWLLutyoipd1/vrpoYoN
	vwn4/qfqxLff3U28o0YpyEU4KXNgAVMJ2poAg4m9Er7a18cRtWUaxlVV5Kog/ldL4JlmAOM0XyTpR
	4cbrRuPA==;
Received: from [187.36.213.55] (helo=[192.168.1.103])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tDM8s-008y76-KN; Tue, 19 Nov 2024 12:11:34 +0100
Message-ID: <b4c1e64b-daef-4181-a3fb-98b4ab3a9c1e@igalia.com>
Date: Tue, 19 Nov 2024 08:11:24 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/2] rust: xarray: Add a minimal abstraction for XArray
To: Tamir Duberstein <tamird@gmail.com>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina@asahilina.net>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241118-rust-xarray-bindings-v9-0-3219cdb53685@gmail.com>
 <CANiq72=13uaXS+mptTiQZ7OLpyO_=r7-06cXEujFqtej=150YQ@mail.gmail.com>
 <CAJ-ks9nqcrOhOSuw+fN9+871W4YEs_rwRJehm=mnAx+M_v8Pqw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <CAJ-ks9nqcrOhOSuw+fN9+871W4YEs_rwRJehm=mnAx+M_v8Pqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Tamir & Miguel,

On 18/11/24 14:02, Tamir Duberstein wrote:
> On Mon, Nov 18, 2024 at 11:52 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>>
>> On Mon, Nov 18, 2024 at 5:33 PM Tamir Duberstein <tamird@gmail.com> wrote:
>>>
>>> This is a reimagining relative to earlier versions[0] by Asahi Lina and
>>> Maíra Canal.
>>
>> Maíra's latest version has both of them listed as co-authors in the
>> main patch -- how close is this to that version? (I see some bits that
>> look fairly similar)
>>
>> Thanks!
>>
>> Cheers,
>> Miguel
> 
> It's fairly different, and I discussed with both of them - we agreed
> that Co-developed-by would not be appropriate.

I still agree that a Co-developed-by isn't appropriate, but I believe
that it would be fair to mention me and Lina on the commit message.

Best Regards,
- Maíra

> 
> Thanks!
> Tamir


