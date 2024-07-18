Return-Path: <linux-kernel+bounces-256089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 800DE9348CD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16EE41F20FC7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCEA770F6;
	Thu, 18 Jul 2024 07:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ILgxsa4l"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299B97605E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 07:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721287716; cv=none; b=pIQBNwkdr2upgt6+eUnUWSv8VVWccVuJ4OZyHoboNasup43dvajg2jggQ+vYyPKlM70YLhm8UUNKcaZ52kto7cPUSgvrJ8AGTovyw59FBLA5oAcGbZdxSJDLOYT8j7E2oCD8sytIAR+PJ91J6EyS9cCVJb3EWNrit5+4AIQ/PX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721287716; c=relaxed/simple;
	bh=J0zu6UYzFzKqQ1OcRouTUBxQW3l6uNgwoyeCJY1FPfo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=s3vUJEDiRlG+9OWT3YU9EKnrXTPPdQoZe0BzXDU7PO1SKYBgz9oJl6tzQ4MrYzqIgbO4Ba9qxTOZ5jOJ7Cd0HLFnGHgtoMD/0ZHamL7r+w0i1wBxXIoqwIOPB1yYxGD+Wh2ElKneW88a7Li34HRkT3ocyx5IqMvZe6aEoJugkTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=ILgxsa4l; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 46I7SBPH3114719
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 18 Jul 2024 00:28:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 46I7SBPH3114719
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024071601; t=1721287692;
	bh=J0zu6UYzFzKqQ1OcRouTUBxQW3l6uNgwoyeCJY1FPfo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ILgxsa4l+rtHw3pKyTf7Ap7TePeaIkxYJpWU6RjVDiYOWXrgE7TRBKT0HyEyygo1/
	 Nluj5MckUKzafNL9Ewwa+C3ZwxylnxR5sRYSPl+CmSkMUlPnQhwrBRQiNPhnwzAVrI
	 ydoDSpZvaMzKSnFWVrSbkCP5jhlwKnWQ9PA/MEyDWrUPvpGGcaCtB22sIHXi8IeCVj
	 l9CncbtJCG6OARvRhYgF6wgkWKVRyS9AKUY0cGCxzc2gd4s9R1PT1rmVeFzvXbeXH+
	 6QaoDz09KVUCENIiOA2O8ReoVe6bem77f3dK5ZVXuWCNvq7fQ9s+TpYJQ2ZoFEZ2Mg
	 U4uHYq3N/1E6g==
Date: Thu, 18 Jul 2024 00:28:09 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Uros Bizjak <ubizjak@gmail.com>
CC: x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_x86/boot=3A_Use_=5F=5FASM=5FSIZE?=
 =?US-ASCII?Q?=28=29_to_reduce_ifdeffery_in_cpuflags=2Ec?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFULd4ZXQzxq4ACOZUKpZKmGFomPxHxc+LhmXZ_uEVizjWbXiA@mail.gmail.com>
References: <20240718063242.52275-1-ubizjak@gmail.com> <4049EB19-E869-4886-AD61-E716A75E4559@zytor.com> <CAFULd4bVO39emR49thto4w6LZX0vS9eJKE75u26aCFk7CRVrVw@mail.gmail.com> <3E2205B3-C2D9-4D4C-9847-1CF0BFF68D72@zytor.com> <CAFULd4ZXQzxq4ACOZUKpZKmGFomPxHxc+LhmXZ_uEVizjWbXiA@mail.gmail.com>
Message-ID: <6CDAC2CA-7F30-4DFF-994D-576E5F8396B7@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 18, 2024 12:27:04 AM PDT, Uros Bizjak <ubizjak@gmail=2Ecom> wrote:
>On Thu, Jul 18, 2024 at 8:59=E2=80=AFAM H=2E Peter Anvin <hpa@zytor=2Ecom=
> wrote:
>>
>> >> >-#ifdef __x86_64__
>> >> >-#define PUSHF "pushfq"
>> >> >-#define POPF "popfq"
>> >> >-#else
>> >> >-#define PUSHF "pushfl"
>> >> >-#define POPF "popfl"
>> >> >-#endif
>> >> >+#define PUSHF __ASM_SIZE(pushf)
>> >> >+#define POPF __ASM_SIZE(popf)
>> >> >
>> >> > int has_eflag(unsigned long mask)
>> >> > {
>> >>
>> >> Just use pushf/popf=2E gas hasn't needed that suffix for a long time=
 as far as I know=2E
>> >
>> >Yes, this works, too=2E So I guess we can also remove the comment
>> >explaining the reason for explicit suffixes?
>> >
>> >Thanks,
>> >Uros=2E
>> >
>>
>> Yeah=2E You may want to check the version of binutils that fixed it and=
 put that in the comments=2E
>
>I have checked that the build works with 9 year old binutils-2=2E25
>(minimal required version), so the fix was applied to an even earlier
>version=2E I guess we don't want to burden unsuspecting readers with
>historic toolchain oddities, so I propose to just remove the comment
>for good=2E
>
>Uros=2E
>

Yeah, I meant the commit message not comments, sorry=2E

