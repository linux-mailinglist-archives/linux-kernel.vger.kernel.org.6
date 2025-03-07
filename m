Return-Path: <linux-kernel+bounces-551296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE08FA56AC2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCEEC3AEEA4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3AF16EB4C;
	Fri,  7 Mar 2025 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="swZ+3xiK"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986798BE5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741358833; cv=none; b=oPPooUrecW3G1DdDAQAUSedzdxLQaAxOCtrNRgrHIlPbv8ztSrVGeGxlkFQcqWCMgviqt7Dcz5XZDVY3gsobpqHpJI+4KtIuF/x2+wj+a5dUjnMxmc65RGqmqtoyvZBGIW9n5mWmAsnnKjncxLNnfZS4ko8wtF3ZPN3ZWA8byKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741358833; c=relaxed/simple;
	bh=WnXd9/A5usTufTAwCtsOFIl/49IpegbbcLvLIXxJKgY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=neOHpw9j51Fu5oFz4aHxq7o5B54vdlAB4AX51DwbaPKY0FWKU/1geOrXw22R8QErAhu3rf8kzOwLL1ndUV5G8nGc0yruGuMy0R71cGruiIdKfQcQhcl/qrwxcS+5mGxcjqIrr7nGKCj6jTUPGpp5w/aOEoFx2qMl+rIaEaJHmrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=swZ+3xiK; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 527EkbiM275544
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 7 Mar 2025 06:46:38 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 527EkbiM275544
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741358798;
	bh=P8JY6bLysSIkrcqsUDxmmRNsXU6eq/QAv1JbYb7F2GE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=swZ+3xiKszsajZNbLMZzl+6/gwleVcr7zGCyxIoIw34wiGhv5yOibVzWvd4ZquAdK
	 aYTn6meQnUutXAaYun/hnXE+9NBk1RJRuY1s3nrhmOqbmy793lgpHhwhwFZLNz1USt
	 Zc92vQz806zOz+dC+b6DqTvTiDLDiqUc2M+VMmWbXngO/k5peSydmjuzu0a5vVXUyc
	 plbBYFYGCiGW1UnVHtXjxKWSaQ5Coj2W+WmqtpaGVS9RmAk6NtVY/m00YMvtB0ui1g
	 FNAazy+rDOM4c5Wy20mV9i6RYVil9Rzd9H679vi3ie1anQH7CQw6f6iVN5kzRWLT7u
	 dc7O5+ylrXmYw==
Date: Fri, 07 Mar 2025 06:46:35 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Uros Bizjak <ubizjak@gmail.com>
CC: x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_x86/boot=3A_Do_not_test_if_AC?=
 =?US-ASCII?Q?_and_ID_eflags_are_changeable_on_x86=5F64?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFULd4Z=ZU0z3g3yc6FTBkN38tsgF86ps2P7Dhc+bdF8A416Uw@mail.gmail.com>
References: <20250307091022.181136-1-ubizjak@gmail.com> <DC668A65-3173-4A0C-BF78-1CECF60D300B@zytor.com> <CAFULd4aMkxYp6L=grE7TrvvfdX7gTGOTAJgojJ=mjHfDLJ=kVQ@mail.gmail.com> <E3E112F8-CC41-4933-9FEC-B53D6A0AFA7A@zytor.com> <CAFULd4Z=ZU0z3g3yc6FTBkN38tsgF86ps2P7Dhc+bdF8A416Uw@mail.gmail.com>
Message-ID: <5147E060-2F35-4B55-ACAA-56D9DB0DD818@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 7, 2025 5:45:42 AM PST, Uros Bizjak <ubizjak@gmail=2Ecom> wrote:
>On Fri, Mar 7, 2025 at 2:13=E2=80=AFPM H=2E Peter Anvin <hpa@zytor=2Ecom>=
 wrote:
>
>> >> PUSF et al =E2=86=92 pushf
>> >>
>> >> The -l and -q suffixes have been optional for a long time=2E
>> >
>> >No, not in this case=2E Please see the comment:
>> >
>> >/*
>> >* For building the 16-bit code we want to explicitly specify 32-bit
>> >* push/pop operations, rather than just saying 'pushf' or 'popf' and
>> >* letting the compiler choose=2E
>> >*/
>> >
>> >We are building 16-bit code here, and we want PUSHFL, the one with
>> >operand size prefix 0x66=2E
>> >
>> >Please consider the following code:
>> >
>> >    =2Ecode16
>> >    pushf
>> >    pushfl
>> >
>> >as -o push=2Eo push=2Es
>> >
>> >objdump -dr -Mdata16 push=2Eo
>> >
>> >0000000000000000 <=2Etext>:
>> >  0:   9c                      pushf
>> >  1:   66 9c                   pushfl
>> >
>> >Uros=2E
>> >
>>
>> *plonk* I should have remembered (=2Ecode16gcc is different then =2Ecod=
e16 though=2E) I wrote the damned things after all=2E=2E=2E
>
>Please note that while "gcc -m16" emits =2Ecode16gcc, "clang -m16" emits
>=2Ecode16, so in the latter case we don't have =E2=80=98pushf=E2=80=99, a=
nd =E2=80=98popf=E2=80=99
>instructions default to 32-bit size=2E So, the only solution is to
>decorate pushfl with operand size prefix in this specific case=2E
>
>Uros=2E
>

Can you please beat up the clang people who do gratuitously incompatible t=
hings like this?

