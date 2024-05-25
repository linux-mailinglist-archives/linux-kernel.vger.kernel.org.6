Return-Path: <linux-kernel+bounces-189422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAAD8CEFD4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 17:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6695B20F9E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 15:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3121C83CBD;
	Sat, 25 May 2024 15:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QOeVB3fG"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732857A140
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 15:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716650920; cv=none; b=WVbyELCmBxS3RGeYosh3k+upt47PwHepvwjZWUFV8e+CsJlSPBR/3y7Wa3zCV3f6Lb+46GmgLKP5EXOcinCQjiNiC71O3rz5+sEOowrWCS7J2Snhgz2NWQZtjruCXTPyqlmsW3hEgzeR1IoZPYEXXvQnmJsvMccQMrSHeFwRMpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716650920; c=relaxed/simple;
	bh=Tab7cqn379rlkg3kSHAFZeaUh1Sm9q02BTLmBbkmx8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mfTD6oPlgGmfXAEcVkvJeAOVxgmHdWst3u+8+yJSozyreAY83u8Q8emRWIR+hBqUFigxdbxmgL8IHX1iqxMlp8oJvOPWjsVFfM8R8TKjygiFT8OPSHxZtaVMQIg0tRphYan7fpPu9fKq6P4Chd16jeehPqGqYTZaLibdxPSsrN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QOeVB3fG; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2bde882ab2bso459780a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 08:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716650917; x=1717255717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mvaQivK8mekHucOwQxDsNjRw0zP1T86L+9CtTlhngGg=;
        b=QOeVB3fG6pbkQb0/3ctMSttGZbbiZDWkoAyoxpyLKOs4FcrNw3BMhrf9t16YWK4Pe/
         b3WrJLnLLsaEOs+Hr/is16I7Y3Rxu3bWsirJVhnFtYLVn1Pfvcn/3e8r8t/OEtcNTOV9
         14PPcMWLYBJKdwg2JEmPUCUOiScU61t2csioSKjWGrqZEmOiGACpG+vTdbts0+OxNW00
         wIhlQk2YDQg0cPi9dQaGmZETVrmNDszb2+1ZmEBu99AUN+EffxgwOGXuffYtrqjtCtan
         Gq459coMYZ3CItjBDXo4+nxTI6Pni4JorU2Nr0VCkwFt0piVdWlCqrBdR2FiJECylCjw
         ieZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716650917; x=1717255717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mvaQivK8mekHucOwQxDsNjRw0zP1T86L+9CtTlhngGg=;
        b=VxsADnPLw3w+d4O5ohy7av2PeJ2gF118Hz57yKN6dlZbhRXGDpWxS10Ut6rQn25p6R
         ZOWTPOdNE7Eu1e3WuvHE8IaJf6OJAKsvwSGX3TqP2ekYnEIeW9Zv+N4RpiM+w5J4uC2V
         y5UWNyyT/HgUGK2laZ0O6BqaiSi7bcnnfKh8rsxn04jng/a/OvAFbBX0cbMMr6zMKOo6
         1kI3sjNRvxKKiIJuP2YktmTekA9G2rvjtsLUrUBZbaa6941ovKEY4MyFxjU3Pv5mTwqX
         OX1teu1sQcncpjDf4y5jsemImnFt2FsFHaKcxFEDArv+0zgIq6bLhhs31vEPn9w1z1rF
         Fbrw==
X-Forwarded-Encrypted: i=1; AJvYcCU3a9m6BmCGHJUxaudvJrb/onon/teOkYyPNhg9dS+gXdaJvDxlKHve359DJEdiFDShyON0nSuY1wuocA9OHkRHLdp2D5xYGR6tbKn6
X-Gm-Message-State: AOJu0YymqXWEa28UsPiL6kyd+fMLa4EzUdFxPHwy7H1q/c0MmhI9vMaK
	Z0E1qrWtB6PtNUfo69QrTuZ+va4WtJBip4WtWqn2rp8as8pcENiAmuNdRaNgWr4=
X-Google-Smtp-Source: AGHT+IFlJP9VKylPOe5rp9ayZ6NpiIWomElUr0eWwjWBs5ky58P3jQYKZo3eM3RzUrhBGLQkDFCBIA==
X-Received: by 2002:a17:902:e811:b0:1e5:1138:e299 with SMTP id d9443c01a7336-1f4486c2b84mr55381465ad.1.1716650917398;
        Sat, 25 May 2024 08:28:37 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f46f0ddc04sm11745165ad.125.2024.05.25.08.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 May 2024 08:28:36 -0700 (PDT)
Message-ID: <ededb63f-7abc-4cca-8bf7-c767e6026e48@kernel.dk>
Date: Sat, 25 May 2024 09:28:35 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2023-52656: io_uring: drop any code related to SCM_RIGHTS
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Gabriel Krisman Bertazi <krisman@suse.de>,
 linux-cve-announce@vger.kernel.org, cve@kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Tam=C3=A1s_Koczka?=
 <poprdi@google.com>
References: <2024051338-CVE-2023-52656-6545@gregkh>
 <871q5rqhuc.fsf@mailhost.krisman.be>
 <d1cb0cd3-0826-48fc-8713-8648d6eb9fd7@kernel.dk>
 <2024052542-diner-snare-a618@gregkh>
 <CAFswPa9jR6mKAsCrdmspCARe-evk16s1t0SG9LrRLCze_f6Ydw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAFswPa9jR6mKAsCrdmspCARe-evk16s1t0SG9LrRLCze_f6Ydw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/25/24 9:09 AM, Eduardo' Vela" <Nava> wrote:
> On Sat, 25 May 2024, 09:15 Greg Kroah-Hartman, <gregkh@linuxfoundation.org <mailto:gregkh@linuxfoundation.org>> wrote:
> 
>     On Fri, May 24, 2024 at 10:57:07AM -0600, Jens Axboe wrote:
>     > On 5/24/24 10:45 AM, Gabriel Krisman Bertazi wrote:
>     > > Greg Kroah-Hartman <gregkh@linuxfoundation.org <mailto:gregkh@linuxfoundation.org>> writes:
>     > >
>     > >> Description
>     > >> ===========
>     > >>
>     > >> In the Linux kernel, the following vulnerability has been resolved:
>     > >>
>     > >> io_uring: drop any code related to SCM_RIGHTS
>     > >>
>     > >> This is dead code after we dropped support for passing io_uring fds
>     > >> over SCM_RIGHTS, get rid of it.
>     > >>
>     > >> The Linux kernel CVE team has assigned CVE-2023-52656 to this issue.
>     > >
>     > > Hello Greg,
>     > >
>     > > [+Jens in Cc]
>     > >
>     > > This is stable material, but doesn't deserve CVE status.  There is
>     > > nothing exploitable that is fixed here. Instead, this commit is dropping
>     > > unreachable code after the removal of a feature, following another CVE
>     > > report.  Doing the clean up in the original patch would have made the
>     > > real security fix harder to review.
>     > >
>     > > The real issue was reported as CVE-2023-52654 and handled by a different
>     > > commit.
>     >
>     > FWIW, the same is true for a number of other commits recently. They are
>     > nowhere near CVE material, it's just generic bug fixes.
> 
>     Ok, glad to revoke them if you do not think they are user triggerable
>     issues.  I'll go reject this one right now, thanks.
> 
> 
> Good day!
> 
> So, either I'm completely lost or CVE-2023-52656 shouldn't have been
> rejected. Forgive me for mudding the problem even more.
> 
> I think we need to unreject this CVE (CVE-2023-52656) or
> CVE-2023-52654 should be amended to include the dead code removal
> commit.. that said, that'll be weirder than just unrejecting this
> commit.
> 
> The reason is that the commit "io_uring/af_unix: disable sending
> io_uring over sockets" is not enough to fix the vulnerability in
> stable branches, because e.g. bcedd497b3b4a0be56f3adf7c7542720eced0792
> on 5.15 only fixes one path (io_sqe_file_register) to reach
> unix_inflight(), but it is still reachable via another path
> (io_sqe_fileS_register) which is only removed by
> d909d381c3152393421403be4b6435f17a2378b4 ("io_uring: drop any code
> related to SCM_RIGHTS").
> 
> Although that patch claims "it is dead code", this claim was only true
> on upstream, but not on stable branches (or at least on 5.15 where the
> vulnerability was proven to be reachable).
> 
> What a mess! ?

Ah right, yeah it was a mess because of the stable backports, it was not
for the upstream front. Agree Greg, let's just keep it because of the
stable side.

-- 
Jens Axboe


