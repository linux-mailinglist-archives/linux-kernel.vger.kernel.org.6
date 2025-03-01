Return-Path: <linux-kernel+bounces-539656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 272C3A4A6F3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 01:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C017E3BDB94
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 00:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A407AAD2F;
	Sat,  1 Mar 2025 00:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnuikQIL"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798974C98;
	Sat,  1 Mar 2025 00:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740788581; cv=none; b=CZtrn9DOK+NSi8NJO/vPbCyce9MHlilOTs0hWXd4fEfBl2jJIADANUQo3T0Ca0JAFFolWSD/ZqVzqI0dS1ci7skekFUKN1EDRUdbZEY42IJLvf/wySvOOi39XeId5A0B7UtYeiE9tnlyOaH019TGIbGtUz7JuF/X3r0Y7EPZ4XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740788581; c=relaxed/simple;
	bh=BJ85jd9LWmkfvxQt+PubnvRoJI2+CN6NMADWkuH7ehQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GmxoX0+gnSK+1bZlhcJQcUOlk3AHlBp/RVcLJr4GsMUXcMBrC8iCF/jgdLJi3x7pm/L3g0LV+ApG2Dj2JWnW8BzYFdDGj7k5abT4HjWXnOIkt41uVGt4KwGU29+olTo2ICMUHKT0mMQlO94fpZQEJuvWhLbj8grhYZkKIAC7X10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnuikQIL; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-390f5556579so479084f8f.1;
        Fri, 28 Feb 2025 16:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740788578; x=1741393378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJ85jd9LWmkfvxQt+PubnvRoJI2+CN6NMADWkuH7ehQ=;
        b=dnuikQILYIxLTKbaeTt4xeEV9N5MfH91TUY9cSU2EcRG0HOLpswPqT/NS9fQ/ydgCh
         0lX+v6hjUn3Y1y0ov7nDl1Q6wPfvYKTSMcWmI9QvE3zr9fAzEZfcjVJKetbboZIL2uoF
         75TyC+pzsGomN/E6s4vFzdv8pk6Q0Kt/I4JrHQks/CXInET8SEJ66cIU/Fg35lHHsvkL
         3OlxBR6ugfYIUjza3a2bX44xyWyNChL2V990WO3BbI6+G6iR+7qPCCHXhJMlDmwarjFb
         5MbPb8r7tbEaAFdjPu1yPO7zFAsNgbBXxYoGNDGy/ENFmOnnI0/oD65vTi54MhYHcKGC
         zmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740788578; x=1741393378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJ85jd9LWmkfvxQt+PubnvRoJI2+CN6NMADWkuH7ehQ=;
        b=q4NbfWV0hOA0bhpJ4MJJGH+9hFSTXoE6/6B6KCw2S3fEqoeQJmDlaeuPLV4/ZvDrpn
         doV90NBb4cSFIDQUEr4IrJjBPnUM63WqFj7OIVNYFov5PCxd7fWvx++njTtsRpwFABL1
         pCJJjbbuTxYUWHqC21TtCAfCaCvEbKi6lsEFZU4bFIRd9rVMEW8C8BA48AxDvm5Ory8b
         Iv4N02uxlMauNoGt9V22rUCyrTaMXTo8rEPxEbcYdt9NNAny56XKNbpUjyK43RHV+fbc
         FxnpfTaFcxlwDuzO4Dvna4cfFGSXjqxlWdsbw6VDtfneUYTYPb0tZ4z7+TzYYhfPxZZt
         gZBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVB9UUaT4HCT85kdSPUX6q+CEZgHa37cDacZjDXhOh0fxEy9E/Gto7s5s5G3568lDB6VjM9LD0we4w=@vger.kernel.org, AJvYcCVQWPfTjFjY+obWieiBjKY12MYxy65F9yDBtUiwjdSThIC9qMG0H5ifgnU9TeiYohlQzL70lXzYJo0xhgO3@vger.kernel.org
X-Gm-Message-State: AOJu0YzAJvy/qkmLQ4wiF5cjiJBqZ6NDWmOiU6imaBCZ/SaZeB7k7WMh
	lpYvtQemwfhJchl2GO4KI9cZ3Mg3CxpS1OofifpIQEx3tsqLwMsZ3++XOuEdIf+vGCwvEw6B6a/
	VApY2oKU0RJbEWE1Hnvnb+3MvlbI=
X-Gm-Gg: ASbGncuMto9cOjzXE9O3U2xRVoI5Hqt8HWPjfJgzX6HAMxwWaUXCcE0DCnoBNo5mZKx
	j3f62RhT6zKyXIG6Dttd2iR1g36ni+tvY5m4CHDexi+aW0qoK7dICxmq5Zg7n1EYfxRv3GHwsag
	noOeLnXlaGH/CHcz0qskihpjjFdigu
X-Google-Smtp-Source: AGHT+IGOs2J8Ec3SpsExVrc6QQu8Fiv07hIlgJmQJEhCPmeI+K9xrAkJp6tJ/1xDwbSrLdOEQrceGucIYIyYI4ePgr0=
X-Received: by 2002:a05:6000:1849:b0:390:f698:ecd0 with SMTP id
 ffacd0b85a97d-390f698ed13mr2102576f8f.11.1740788577700; Fri, 28 Feb 2025
 16:22:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739866028.git.maciej.wieczor-retman@intel.com>
 <168f775c4587f3a1338271390204a9fe16b150dd.1739866028.git.maciej.wieczor-retman@intel.com>
 <CA+fCnZcVSwUAC9_xtVAHvO6+RWDzt6wOzWN623m=dT-3G=NnTQ@mail.gmail.com>
 <cik7z3nwspdabtw5n2sfoyrq5nqfhuqcsnm42iet5azibsf4rs@jx3qkqwhf6z2>
 <CA+fCnZd6O0_fc1U-D_i2shcF4Td-6389F3Q=fDkdYYXQupX1NA@mail.gmail.com>
 <uup72ceniis544hgfaojy5omctzf7gs4qlydyv2szkr5hqia32@t6fgaxcaw2oi>
 <CA+fCnZfb_cF1gbASZsi6Th_zDwXqu4KMtRUDxbsyfnyCfyUGfQ@mail.gmail.com> <paotjsjnoezcdjj57dsy3ufuneezmlxbc3zk3ebfzuiq722kz2@6vhollkdhul7>
In-Reply-To: <paotjsjnoezcdjj57dsy3ufuneezmlxbc3zk3ebfzuiq722kz2@6vhollkdhul7>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sat, 1 Mar 2025 01:22:46 +0100
X-Gm-Features: AQ5f1Jp9iybs6pTKPBUq6fE1AmEKUlDJIkwe5Kr9NN_-2VapuhLDqeATKkl6mP4
Message-ID: <CA+fCnZcCCXPmeEQw0cyQt7MLchMiMvzfZj=g-95UOURT4xK9KQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] kasan: sw_tags: Use arithmetic shift for shadow computation
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: kees@kernel.org, julian.stecklina@cyberus-technology.de, 
	kevinloughlin@google.com, peterz@infradead.org, tglx@linutronix.de, 
	justinstitt@google.com, catalin.marinas@arm.com, wangkefeng.wang@huawei.com, 
	bhe@redhat.com, ryabinin.a.a@gmail.com, kirill.shutemov@linux.intel.com, 
	will@kernel.org, ardb@kernel.org, jason.andryuk@amd.com, 
	dave.hansen@linux.intel.com, pasha.tatashin@soleen.com, 
	guoweikang.kernel@gmail.com, dwmw@amazon.co.uk, mark.rutland@arm.com, 
	broonie@kernel.org, apopple@nvidia.com, bp@alien8.de, rppt@kernel.org, 
	kaleshsingh@google.com, richard.weiyang@gmail.com, luto@kernel.org, 
	glider@google.com, pankaj.gupta@amd.com, pawan.kumar.gupta@linux.intel.com, 
	kuan-ying.lee@canonical.com, tony.luck@intel.com, tj@kernel.org, 
	jgross@suse.com, dvyukov@google.com, baohua@kernel.org, 
	samuel.holland@sifive.com, dennis@kernel.org, akpm@linux-foundation.org, 
	thomas.weissschuh@linutronix.de, surenb@google.com, kbingham@kernel.org, 
	ankita@nvidia.com, nathan@kernel.org, ziy@nvidia.com, xin@zytor.com, 
	rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com, cl@linux.com, 
	jhubbard@nvidia.com, hpa@zytor.com, scott@os.amperecomputing.com, 
	david@redhat.com, jan.kiszka@siemens.com, vincenzo.frascino@arm.com, 
	corbet@lwn.net, maz@kernel.org, mingo@redhat.com, arnd@arndb.de, 
	ytcoode@gmail.com, xur@google.com, morbo@google.com, 
	thiago.bauermann@linaro.org, linux-doc@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 1:33=E2=80=AFPM Maciej Wieczor-Retman
<maciej.wieczor-retman@intel.com> wrote:
>
> Btw just out of curiosity on the topic. If we used a runtime specified ka=
san
> offset, could the gdb script issue (not knowing the offset at compile-tim=
e) be
> fixed by just exporting the value through sysfs?
>
> I know that in inline mode the compiler would still need to know the offs=
et
> value but I was curious if this approach was okay at least in outline mod=
e?

I think this would work, assuming that GDB can pick it up from sysfs.

