Return-Path: <linux-kernel+bounces-275637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF919487DC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 05:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB7DDB20DE0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 03:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25A959164;
	Tue,  6 Aug 2024 03:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="EQpefKrO"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18046FC3
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 03:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722914095; cv=none; b=pVEgghxZuDvVI48uQLtmWiQs03fFn1bX/neqwhpLgtVw6HB2rXsT3SBlASUzZ0YuI47kOTYzRAbFJVSsP+6E/cW+2dirL92JiZyJiBCMXq4R41eDT7sUiony18d0lTuOroIiGX5g/aOqDn01JYciITTtDNUulU9B1+0/3E2ZjFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722914095; c=relaxed/simple;
	bh=EIyTLfsIgCR2Keu3u5GYReyIkMMkcbSZt6Lkv7LWR58=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LWyci7qW35pjMofLZ6tnpSmwjP3qsG2J0aNZPtjPm84aqELbE8TMOLcQw5Fp+hkxigg0Gs6XRj2ocnD+JkeWTB90RUwobH9cIgNjvQJIgDnJH6Xy8gHR738lySNsLcIJnfpiobowhNaKBtryJ8Cg2taOro23QDQ+PKhq7tj0to0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com; spf=pass smtp.mailfrom=jrtc27.com; dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b=EQpefKrO; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jrtc27.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4281c164408so579145e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 20:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1722914092; x=1723518892; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnA0PeUHKuNbqiKyg0B4D4n1V2sk6W3EUvTsNvf0wVY=;
        b=EQpefKrOfjW47UQoaOg+s/ApTf49oLWlFmlb4D0VycN7peNxlqBg6o9sEDOLHa46Ib
         ZHUhREO14a2hQ6OcbRG8GSNn93jgsKyvsTYJ+OD5xotTk2nPmRub4EYclmwMfM6hUFAF
         5nzETkSFOIWKCRvUIkML2rK29N5HnazSybVRcfmxHR5UxPl5gs8NK6XMLSRGY6uBjDwS
         U1Ysd44k8vNN+dvikxMQAGZMW9ivJmlA7ASbvJWzW9AscoeTK+Afhy9Zoj3JwO9r8j8Y
         9gXIJAF1XIgvcOQcHJushgDgAqKBFFOMtQJhMipw+hOUYFEyugri8YJJ4LQQBqxECXM9
         9DXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722914092; x=1723518892;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnA0PeUHKuNbqiKyg0B4D4n1V2sk6W3EUvTsNvf0wVY=;
        b=U0yu2Myv0nRvl/66sqSLfh8vY8B6Y++ZOuXgEPU/+n4HcPkK2Bx7y2kiK6yAg1PoxV
         HED9oBuaKbbhgkzL0Yd7qlw0bdtDLi/QG0616rMbzvjyF+Kw0iRpInPgUaaN97xIH0mn
         1nI+CFwJjDLLGIZk4vA7aTh2V30v852Sk5im15lzvr/fxQslteq+aMT0DMuRp8YAAK06
         QgyEM96ASuRyytJczmKgHP1yF46Z0s/ftrD2WkM0NUXgyl5KBC+60JI0Fo+QLz/qZpjt
         TzjHm6PIt3kSyc3GJXg5BY1RXrxXOoHckS8ZcwbrZl/RpBvDo7fhgUXiu7ce1N+oFYVx
         BRnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/N2kL2hZmUIAqpre6iWKiQqTQKIQsQN38iSwJAB1I7EkJDVDdHU/+AuKzvC3jMbBYRllHRcdotTk9C7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP1R8DRcSZWX/+sAHuvk0kdTg0TzJq1u6qsrlCIoofgdQbKUQG
	RJWYsZiqpsf6imgl8e4NBqWaHI4oRcewNXuHxsK29FU340lWX2URLnkSzQYpsPg=
X-Google-Smtp-Source: AGHT+IGoc6NJrzp0HaNuMdYWDlqDKUAt+5MvncZka3icw6yUOJNEnVFMF+vsFEP8NZyUYmLP7Hvhfg==
X-Received: by 2002:a05:600c:19c9:b0:428:f41:d467 with SMTP id 5b1f17b1804b1-428e6b014c5mr96923965e9.10.1722914091868;
        Mon, 05 Aug 2024 20:14:51 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e08012d7sm190760575e9.22.2024.08.05.20.14.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2024 20:14:51 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] irqchip: let the probe of APLIC be earlier than IMSIC
From: Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <CABvJ_xhMAU+Ft-Ut2hMapO9dCSkz4M2PqxvdCrJS6eaSz02hLQ@mail.gmail.com>
Date: Tue, 6 Aug 2024 04:14:40 +0100
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Anup Patel <anup@brainfault.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-riscv <linux-riscv@lists.infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <804B47DC-1A68-4219-8411-B3F7AF1B2D97@jrtc27.com>
References: <20240802075741.316968-1-vincent.chen@sifive.com>
 <CAAhSdy3yx=mm3M6U_Q+_WdMs12SGCypPgNkBAVc9Kwn9jgev6g@mail.gmail.com>
 <CABvJ_xgcbyQKa1+U1MC7cLEB-SUzzNaWqKdXFp+13mni0YSvNw@mail.gmail.com>
 <87sevj5r45.ffs@tglx>
 <CABvJ_xhMAU+Ft-Ut2hMapO9dCSkz4M2PqxvdCrJS6eaSz02hLQ@mail.gmail.com>
To: Vincent Chen <vincent.chen@sifive.com>
X-Mailer: Apple Mail (2.3776.700.51)

On 6 Aug 2024, at 02:56, Vincent Chen <vincent.chen@sifive.com> wrote:
>=20
> On Mon, Aug 5, 2024 at 4:08=E2=80=AFPM Thomas Gleixner =
<tglx@linutronix.de> wrote:
>>=20
>> On Mon, Aug 05 2024 at 10:43, Vincent Chen wrote:
>>> On Fri, Aug 2, 2024 at 7:03=E2=80=AFPM Anup Patel =
<anup@brainfault.org> wrote:
>>>> Secondly, changing compilation order in Makefile to influence
>>>> the probe order will not help in any way.
>>>>=20
>>> I was confused here. If possible, hope you can help me clarify it.
>>> The following is the backtrace of really_porbe() dumped by GDB.
>>> #0  0xffffffff8092318a in really_probe ()
>>> #1  0xffffffff80923516 in __driver_probe_device.part.0 ()
>>> #2  0xffffffff8057c856 in driver_probe_device ()
>>> #3  0xffffffff8057c9ba in __driver_attach ()
>>> #4  0xffffffff8057aaa4 in bus_for_each_dev ()
>>> #5  0xffffffff8057c3ea in driver_attach ()
>>> #6  0xffffffff8057bc4a in bus_add_driver ()
>>> #7  0xffffffff8057d75a in driver_register ()
>>> #8  0xffffffff8057e83c in __platform_driver_register ()
>>> #9  0xffffffff80a2455e in imsic_platform_driver_init ()
>>> #10 0xffffffff8000212c in do_one_initcall ()
>>> #11 0xffffffff80a01188 in kernel_init_freeable ()
>>> #12 0xffffffff80928d80 in kernel_init ()
>>>=20
>>> According to this result, the source to call really_probe is
>>> do_one_initcall(), regardless of whether it is APLIC or IMSIC. The
>>> do_one_initcall() function follows the placed order of the
>>> initialization functions in the __initcall6 section to invoke them.
>>> The compile order determines the order of the __initcall6 section.
>>> Therefore, I try to adjust the compile order to influence the probe
>>> order between IMSIC and APLIC. Do I misunderstand something?
>>=20
>> There is no guarantee that this order is retained. The linker can =
freely
>> reorg the section. That's why we have deferred probing. It's neither =
a
>> bug nor a problem, so what are you trying to solve?
>>=20
>=20
> Hi Thomas,
> I understand now. I didn't realize that the linker could freely
> reorganize this section. This patch won=E2=80=99t actually adjust the =
probe
> order. Thank you very much for the explanation

Also FYI your patch subject is backwards, which initially confused me.

Jess


