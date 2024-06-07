Return-Path: <linux-kernel+bounces-206611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52322900C0B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B14F1C20EAE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385A513EFE0;
	Fri,  7 Jun 2024 18:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="WFw1/GNp"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E268510A24
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 18:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717786272; cv=none; b=S7jMKIrOTA6PVSO415LK9BUabeMO1nsOSRWTtVCAOJNg3EWtN1png0QtCuhmG9ZiyRqYGzmBh0B9N36NRBqsXqZi3OSnbj55XEbHI50TItlRigQwNZwrT6LG3E5yc5w+IUJuU9vKXBheVscl3+sXaVYMfTSDM1Fv8SmWAZ3ejW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717786272; c=relaxed/simple;
	bh=spdlnQosYbgxz0z1aI+nHwJdAm4uQJgtsueSAk82Hto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8mSJA7e0tU7Ccm/5W0XVZv+SsQWoWZ60ZNhNUPjvCgcb+EE7IuiibUCPLUtNytKRHOFtHVj5f+VkAGvWi6XuwoD3SuARr8XjIa+7wJ4TfsneOLtIgeN6HCLAekXnG+QI1Tx31aYSz+1M6oQBmj5gfDQUISzVygze4PfZT+mMrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=WFw1/GNp; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f47f07aceaso22000505ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 11:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717786270; x=1718391070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=spdlnQosYbgxz0z1aI+nHwJdAm4uQJgtsueSAk82Hto=;
        b=WFw1/GNp9FeBe4ASe4EDPLuFie7nG9LNLf4G7KoAwtK0dNqDYH6hHOl5BXTsBoFcCf
         ex7qGv1TQY8+NocTH5r9/Ry75oOPxUjMvuyKGRAKTdx3Z/9xPhiPOfF6BXaINr7XGX+d
         LhI1MjymNXVJYdcAAp4RIzUAcitke7jJbRcCuoXJeV62AWFVfVGiyuAefzg+vSQ4QQe9
         rV9FHByZQYj5s2OFzJSjrArFdQMj/419yAkc6FEvbtvUOo9m0q2lbRX4iFLgWwPUQ0lW
         8Z1HmLWwyBPuqBDsFQS6ItmjN277sgfz6lRERSPOYxfX8gan430YZ5HdSMS8eMACZicC
         vfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717786270; x=1718391070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spdlnQosYbgxz0z1aI+nHwJdAm4uQJgtsueSAk82Hto=;
        b=tYvBJtdBD+V+KlJJZQJa6aUxpIF1ajPRPhvc4qVy6m1Aae9MuWth7kZ31JrFANcu1B
         uCKbDdO8OqwV8IhymYM32J03BoIrGZbEqpw7eUdL7GNedVSCbH0Lh6K9k6IflWEZxLRF
         94j42UdHyGNlW97h8yeE4Aq9x9tFmZZaQtjCoQyQ9YL88+28q7WqyzgdDnYJmV6KfkVg
         1ORMZ7ysgTzdxeYEj7Znl/oYIWJzAIPOFH7Hg0BJILCdybxsS/Vm1sYYBNSwy3xliUEz
         D75mNOIIHx3dZ/OITLIWK9YfD4Xezt2VD+WP9/phC1aWF2+7Ow6Z/T7KNZjQjSLRlP8Z
         +yUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXShDKqxkq8MnNoqOVY7aBaMhCusvrNVn9skmB0rR2KWjY8g3KaaJXKZFwu7sEg9ZJQZRXeBxeH3iZCjGpCGBjNJBEMY7PvIvudi50k
X-Gm-Message-State: AOJu0Yy4oTkAjQG6ALJCqZ4H5DxbnfzVstLSXEPljJ1YauvMG21VcizQ
	F3JIFjaBu5PfPBlG3LW15PJrrQYdgc+NDkVPpg/+638m05mqCoq8IQRH2fzJvbQ=
X-Google-Smtp-Source: AGHT+IGMjAuAS3XI2gD8/NyTDV8hJlKEUmolHeTNHvKFVpM0ZupPk3AuvNMIhwwVwTDX8d6lLV85Cg==
X-Received: by 2002:a17:902:e887:b0:1f6:8081:6818 with SMTP id d9443c01a7336-1f6d03c0e1dmr36550955ad.52.1717786270083;
        Fri, 07 Jun 2024 11:51:10 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6ea2d17c5sm7512365ad.46.2024.06.07.11.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 11:51:09 -0700 (PDT)
Date: Fri, 7 Jun 2024 11:51:07 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Jesse Taube <jesse@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Alexandre Ghiti <alexghiti@rivosinc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v0] RISC-V: Use Zkr to seed KASLR base address
Message-ID: <ZmNWmxak9Rc80Kpb@debug.ba.rivosinc.com>
References: <20240531162327.2436962-1-jesse@rivosinc.com>
 <20240531-uselessly-spied-262ecf44e694@spud>
 <b199fde6-c24e-4c18-9c38-fdc923294551@ghiti.fr>
 <20240603-stinking-roster-cfad46696ae5@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240603-stinking-roster-cfad46696ae5@spud>

On Mon, Jun 03, 2024 at 01:47:40PM +0100, Conor Dooley wrote:
>On Mon, Jun 03, 2024 at 11:14:49AM +0200, Alexandre Ghiti wrote:
>> Hi Conor,
>>
>> On 31/05/2024 19:31, Conor Dooley wrote:
>> > On Fri, May 31, 2024 at 12:23:27PM -0400, Jesse Taube wrote:
>> > > Dectect the Zkr extension and use it to seed the kernel base address.
>> > >
>> > > Detection of the extension can not be done in the typical fashion, as
>> > > this is very early in the boot process. Instead, add a trap handler
>> > > and run it to see if the extension is present.
>> > You can't rely on the lack of a trap meaning that Zkr is present unless
>> > you know that the platform implements Ssstrict. The CSR with that number
>> > could do anything if not Ssstrict compliant, so this approach gets a
>> > nak from me. Unfortunately, Ssstrict doesn't provide a way to detect
>> > it, so you're stuck with getting that information from firmware.
>>
>>
>> FYI, this patch is my idea, so I'm the one to blame here :)
>>
>>
>> >
>> > For DT systems, you can actually parse the DT in the pi, we do it to get
>> > the kaslr seed if present, so you can actually check for Zkr. With ACPI
>> > I have no idea how you can get that information, I amn't an ACPI-ist.
>>
>>
>> I took a look at how to access ACPI tables this early when implementing the
>> Zabha/Zacas patches, but it seems not possible.
>>
>> But I'll look into this more, this is not the first time we need the
>> extensions list very early and since we have no way to detect the presence
>> of an extension at runtime, something needs to be done.
>
>Aye, having remembered that reading CSR_SEED could have side-effects on a
>system with non-conforming extensions, it'd be good to see if we can
>actually do this via detection on ACPI - especially for some other
>extensions that we may need to turn on very early (I forget which ones we
>talked about this before for). I didn't arm64 do anything with ACPI in the
>pi code, is the code arch/x86/boot/compressed run at an equivilent-ish point
>in boot?

cc: +Clement and Atish

I don't know all the details but on first glance it seems like instead of ACPI,
may be FWFT is a better place for discovery ?
https://lists.riscv.org/g/tech-prs/topic/patch_v12_add_firmware/106479571

Supervisor could query if Sstrict is implemented and then it can check for
lack of trap on CSR_SEED or straight-away check for presence of Zkr.



