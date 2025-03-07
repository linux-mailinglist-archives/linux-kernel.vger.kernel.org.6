Return-Path: <linux-kernel+bounces-550222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F13A55CB8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25C73B5731
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CFD143748;
	Fri,  7 Mar 2025 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fw1WiLFx"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6814F136352;
	Fri,  7 Mar 2025 01:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309827; cv=none; b=J8vDHmKH4Y7HkHqP57bLW9MheblVMxQQfMSW4mXVBSnY6MZjpnQmQGT+4zkqbBphJdrOQQJTPvKpwPGEIcCWAPSkXbzZsG1pawGMV6haVEA8vhYWySxLfLY9j33bSORiXvKFkIsceYI6qih1TMF6s4I2oydtnpNBmyJ23qAolWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309827; c=relaxed/simple;
	bh=1wC451i+1YK+YHCL/Lq3MatDtPzBmP7gjobXtW86K/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IGmByJfQ4KQFfjfto4rtVGF3p8PuzHRsNBVPp1HSpg8+5zY5WGxxjFJsrfWW9mKGS5g/FvE6Z71zVeLG/uAWSGOGIU4gYg8xIdD/7ZJTU6G9ZDTZ0Xf0z2Xhx4PPN7e4wlIMCWWWR9FOTMWaOvHzm0liZv+ZO8W80N9uyVi/Aj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fw1WiLFx; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-390edaee0cfso941862f8f.2;
        Thu, 06 Mar 2025 17:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741309823; x=1741914623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wC451i+1YK+YHCL/Lq3MatDtPzBmP7gjobXtW86K/c=;
        b=fw1WiLFx+CI32VgwPS0TP+vXvrl9luWDZNhXD0KrpC6aLi2C4ZYOFx1oZz22NJhV1x
         1OE918n+gkqZBt4QYy48FCQiVrpwyDS8aPDViUA1VVuZ4HYEEHDsrt7h8Jdui34upmxg
         ARu0Rdl+zA8cFqefD3KxKlrZLRZDuXtiBdDt2zbce/Th4ox9CzX5zVapQ+eh5D18vnDw
         OtMQuz35wOlcFFp36llAQs+rbsHHNaZL2kM0TdWR65ZK0epgyzubyBlJnL9LVV29nnwo
         Gd3SOxisXvg901srOanE55vrUnRaa7ZxeAYPtDy+6TXp4sghtn5ZxZcjjCvILjjJvlrb
         oBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741309823; x=1741914623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wC451i+1YK+YHCL/Lq3MatDtPzBmP7gjobXtW86K/c=;
        b=Rt63irCIeJb5BQnyEYkJCtIcnGkcmGAMqTNAOfGXSoKzhwI12mYSZkc1wXrKAHH4cE
         qjSDXmIzqd+kPIHLSAwKP+DyOWYkhzULKrFyr9NMK7mTJRk8WkVOXl19aquyNTD/qDfq
         fnhzVM/q+lg2ixuB88tRIcbdAbzqh3I8l5slMYvzFTrmr6Nc2/2qZn4dF+DzAzdoY/so
         z9HTgZuCcW94s91vuBS0ay+Xow17X1JSiUa4jDXXh5Q2reBJNve56Ng4hzl4FDS1/gcK
         Nu/SzRE5yzYxRRr4c6UuDUrXmtwOWQdEedPF121TI9o4GCYPL59yKcEczFvu8Aalxp9S
         k9cg==
X-Forwarded-Encrypted: i=1; AJvYcCVUFiMjyMfmupPeQ1AbzmdSfP2ISRhVYXd8Z7VSpFN7H0WtXV1tCJlHFmOh+apgLVmEYVfZErD6e3WPCJ1I@vger.kernel.org, AJvYcCXUP7fZzT2J6Wj19DL182zDPUNTCG23ry2lua/yT0busurR+H6xDoJ/rMhEbtJeK0Clfiyt+PsbIXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw9yVBHN65uyl1M6zK17DUiywkuR0tMLccOAkH4+qyLY2cflLB
	vCJaIuVhDxcI+pasDqtRC+OJTsrtBxSzVPTAbMja61DKTgyRi7V/LuwLFZyI2MLLElAr9YaMYKR
	Y2UkV7KWhoYW3T/0EAPHRdK+Z1Bs=
X-Gm-Gg: ASbGncuRStJ7kThcRou4+mYRDkh6W2dA7NExzO5aXKHw31u+Cya/RM5Duy+RG4vUUcH
	0xu3ZSb0s6UtgiwPbwVf24RH01hAd4RRFpAGtYl7PIGgF5IpJc7Jyh7VRFrXfSV7Zfs7DzUdBKP
	kng/QCXk6sUNiLfaxoVRx12aKLU+qf
X-Google-Smtp-Source: AGHT+IF6UzqzVOKie9IFCqxeppq4G6+t6iY7fQR70YW71IqLud6fEfFCyOSdlbvoD93AgUNPMyo6tbR6VluYzPs4wUA=
X-Received: by 2002:a05:6000:1541:b0:390:e62e:f31f with SMTP id
 ffacd0b85a97d-39132d06e74mr961131f8f.3.1741309823366; Thu, 06 Mar 2025
 17:10:23 -0800 (PST)
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
 <CA+fCnZfb_cF1gbASZsi6Th_zDwXqu4KMtRUDxbsyfnyCfyUGfQ@mail.gmail.com>
 <paotjsjnoezcdjj57dsy3ufuneezmlxbc3zk3ebfzuiq722kz2@6vhollkdhul7>
 <CA+fCnZcCCXPmeEQw0cyQt7MLchMiMvzfZj=g-95UOURT4xK9KQ@mail.gmail.com> <aanh34t7p34xwjc757rzzwraewni54a6xx45q26tljs4crnzbb@s2shobk74gtj>
In-Reply-To: <aanh34t7p34xwjc757rzzwraewni54a6xx45q26tljs4crnzbb@s2shobk74gtj>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 7 Mar 2025 02:10:12 +0100
X-Gm-Features: AQ5f1JqsmdGRGu2uHlQaWnjOnFHn8usJJdOQ1XiECzwCgn8ytUJNZ-8vyFlkmEo
Message-ID: <CA+fCnZdj3_+XPtuq15wbdgLxRqXX+ja6vnPCOx3nfR=Z6Q3ChA@mail.gmail.com>
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

On Tue, Mar 4, 2025 at 1:31=E2=80=AFPM Maciej Wieczor-Retman
<maciej.wieczor-retman@intel.com> wrote:
>
> One other question that came to me about how KASAN works, is there some
> mechanism to prevent data races between two threads? In the compiler perh=
aps?
>
> For example memory is de-allocated and shadow memory is poisoned but some=
 other
> thread was just about to do a shadow memory check and was interrupted?
>
> I've read the kasan/vmalloc.c comments and from them I'd extrapolate that=
 the
> caller needs to make sure there are not data races / memory barriers are =
in
> place.

KASAN does nothing to deliberately prevent or detect races. Even if
the race leads to an OOB or UAF, KASAN might not be able to detect it.
But sometimes it does: if poisoned shadow memory values become visible
to the other thread/CPU before it makes a shadow memory value check.

