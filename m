Return-Path: <linux-kernel+bounces-369959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9942D9A24EA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E15D28B6C1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FA51DE3D6;
	Thu, 17 Oct 2024 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hEWQa0gM"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47231DAC8E
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729174994; cv=none; b=gJmd/b8GmYMxRwdsFOufvMgD0GYF4ZnHgRYVBqJPzBzILnFTtz1M7S/J8epoFIbbWUaAAbHqDjPmU9rwmZuiU2zgsWQ9DFvAMMNxPtwJxKMXsrHgZJkyVJnd0F+1kUaj1Kcb362UzeyW1IQgQU/c4HpIpf39x2b90mdNJYYhv+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729174994; c=relaxed/simple;
	bh=/oKzF01zLyly/tbLX0q/TExjLUJBosYRk2Ziq2D9EZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MiTSIN1NUadvWm9j2mJ4pV8w2+ag4E0DzMpc1hGM6ftyXGCpkZOXO23gPxU6SprlPGh3yeUh2HDROh4zg9vLxxmVijU+H+GeoRiyxZ17OHExL3o6xBDDIIYHiL5P4Te1ogYh/V6774h8gMC2fhh4f/hyODSmW4f+cFjX+IPsUr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hEWQa0gM; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-656d8b346d2so705028a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 07:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729174992; x=1729779792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9fTERrQKqMnvmgvP0SOzXoTwAvCNChxoWuC9cArNN4Q=;
        b=hEWQa0gMPAZVaXl7lz7lJ3XFHbKsER4f61FvbNe+rbkp7AVjnFjYBTZony5X723Jao
         V+hemHtXM+saByx6FB8UphcHgWOgkwxqpRCjnjB6Jefwqm5b+9MtlhhgukmkczGxo6kB
         F3TJmDyefND0oA4Pm7oRkOqUI8HSfTGJHLKGhmQdouPK+0cjk0VaM6dGDqGj6mTF5I1s
         O7QMn3eAswc9TA62ZeJ1RRN0WEr6DhjVJuNfBgVj0MliuCXycd2y8oxe93NXDyngUGw+
         u22w1GywfYVqACjP+0DeJdyVYYW4ztDMXs2My1D2evs/4Tr6M0puTXtiMrUewGRNaGj6
         O6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729174992; x=1729779792;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9fTERrQKqMnvmgvP0SOzXoTwAvCNChxoWuC9cArNN4Q=;
        b=p9s1u7fpzgEptcwR92DByNB92btfOpkF37zOglSFPQtAE1y2JAPpJwpKNckxGX3Nwv
         MMOnFjCAQDlHHX6JrbPzn6GP15lIFvz47bca6Y+cctRnAJo660jK1LwZkBJFXHK3lOMW
         jeuDONDpNOysFTfnBk2GZOqnu1U5GEkfzHT6DxmR3wpkJE0ljkR7wh4xK/EwG9qZThuS
         9U7Vcg6+gcA5EYknIhAXWIySC/pWDjbbfaBTmx1AEyHBX768Kz4PZYPxW72i3MWigW6t
         n9oQMUgXWt4ThvLfPh666/J4ukHVZgLalaxMiKGimtS3mM2lbLbY5gt2cO1EUjprQzg9
         X5AA==
X-Forwarded-Encrypted: i=1; AJvYcCWo926C3smFyqRKM01NAFvMHTKLTFDIiuo9A25XPJ7K1GRE5mdPqfoQTgOoO2qh1G801T9SZr7lYFEBSOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnMCwNNQIWhEQLlag1eA8iWk/V747rowCuOx4JGNhFWRyO0PyT
	nONgR7ktJU5WuJ2/8jIsZvQH8LvxEqYekCo4Y/ypIca7Gi8JdPgWLtgm8ZbK8yw=
X-Google-Smtp-Source: AGHT+IFeylxJB+BrRDiwJcZ2ACKQfqwRzp6C9c9ZmanBqyrah5yhHpghkWrJLJsQuqCUJP7Ete/9bA==
X-Received: by 2002:a05:6a20:e605:b0:1d9:1907:aa2b with SMTP id adf61e73a8af0-1d91907af95mr5986334637.1.1729174992039;
        Thu, 17 Oct 2024 07:23:12 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c6ba2a8sm5066138a12.6.2024.10.17.07.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 07:23:11 -0700 (PDT)
Message-ID: <4d4bf52a-dd91-48ad-8949-198b2ffbc9da@kernel.dk>
Date: Thu, 17 Oct 2024 08:23:10 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AMD zen microcode updates breaks boot
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <d7aff674-ad92-4a36-9ebf-8d3c42774723@kernel.dk>
 <CC418B80-5ED9-4F64-917F-BA6F94130F83@alien8.de>
 <ad9638b4-0a4a-4cd0-9fcb-2690693da157@kernel.dk>
 <20241009091247.GCZwZJDwFETmN5pEGe@fat_crate.local>
 <77f16324-47e1-41e6-a9e9-2cb7cbc8d14d@kernel.dk>
 <20241010134613.GDZwfapaZ8AKp0n72C@fat_crate.local>
 <842a76fe-3d6a-4846-83da-bb113634b8bc@kernel.dk>
 <13fe104b-d83b-4d6d-a348-1103d402540d@kernel.dk>
 <20241017100257.GAZxDg0VqDAesee00m@fat_crate.local>
 <3400cf0b-85ca-4ec2-a8a0-c9d75889d573@kernel.dk>
 <20241017141314.GDZxEbenNT6XF4jIaA@fat_crate.local>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241017141314.GDZxEbenNT6XF4jIaA@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/24 8:13 AM, Borislav Petkov wrote:
> On Thu, Oct 17, 2024 at 08:05:09AM -0600, Jens Axboe wrote:
>> Same thing, doesn't boot, just hangs after loading the kernel.
> 
> Ohh, so it is not the patch application but something else in the code.
> 
> I presume "dis_ucode_ldr" on the kernel cmdline makes it boot?

Yep, it boots with that added on current -git WITH the microcode
package installed.

-- 
Jens Axboe


