Return-Path: <linux-kernel+bounces-269186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FBE942EF6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0774D1C21905
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDFC1B013F;
	Wed, 31 Jul 2024 12:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=whu.edu.cn header.i=@whu.edu.cn header.b="aOq9TQOh"
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093191B142B;
	Wed, 31 Jul 2024 12:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430054; cv=none; b=cwafu2/DjfMcL4m7d0VtSRwhSyhowrs0KZ/28uGXFaB1N2LIepvRWE2yTydt6vTHfc5dM4q8uYIdjvSnac3vBfvr/QG5EySK0Pkzzh6Toe4VsLBVaf7vCUSmvvP8Gw7D+h22TNWCJ87ZrKTN82m2MB295BxV0y+IGiMlR5AMY3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430054; c=relaxed/simple;
	bh=6G+rgx/q9MXLtttq4evrxMQ72GI3w/vZ5qSXUcu+9tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hENaquPw/Hf1vG9gSc+iXkx6QPDohuwGGBvND+X3koJgz53onyZpnXfMQ/BM7bFbtdxhnyqRv6Tr077pBzROlgYfZcnFU/8t1V6qHguAp4XZcThxnVn4MZ3pfw4LRfcRjQcPtPN/PRvhhyckx9y76HWdNnWPBz1qgqHDwqxvUEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=whu.edu.cn; spf=pass smtp.mailfrom=whu.edu.cn; dkim=fail (0-bit key) header.d=whu.edu.cn header.i=@whu.edu.cn header.b=aOq9TQOh reason="key not found in DNS"; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=whu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whu.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=whu.edu.cn; s=dkim; h=Received:Received:From:To:Cc:Subject:
	Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	Content-Transfer-Encoding; bh=6G+rgx/q9MXLtttq4evrxMQ72GI3w/vZ5q
	SXUcu+9tM=; b=aOq9TQOhkjWbW2A0xH1yswP3bfHpy9sezv5SmTwh0L6EZKu2gv
	KeEkq2cFzkvvDvdhKGP1MTEf0AfOJ50VsKAZ+S3afXKI8faXjmTcHA/nxJbC0XBj
	MrGD6lXWDSPqoL3NVNyCIdCg7crUBjN40wIe5FQBveXwKW4Wyw1DgzOhU=
Received: from whu.edu.cn (unknown [10.1.14.8])
	by app2 (Coremail) with SMTP id Bw4BCgCHOxFYMqpmY9UTAA--.8872S2;
	Wed, 31 Jul 2024 20:47:20 +0800 (CST)
Received: from zehuixu-vmwarevirtualplatform.localdomain (unknown [82.130.46.207])
	by mtasvr (Coremail) with SMTP id _____wA35MNSMqpmficOAA--.4380S2;
	Wed, 31 Jul 2024 20:47:19 +0800 (CST)
From: Zehui Xu <zehuixu@whu.edu.cn>
To: ojeda@kernel.org
Cc: zehuixu@whu.edu.cn,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: Kbuild: Skip -fmin-function-alignment in bindgen flags
Date: Wed, 31 Jul 2024 15:47:12 +0300
Message-ID: <20240731124713.9866-1-zehuixu@whu.edu.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <CANiq72n48BvaSNvghkEMn796u4K3_1owZqD9Gjmyk7h3R9GT+A@mail.gmail.com>
References: <CANiq72n48BvaSNvghkEMn796u4K3_1owZqD9Gjmyk7h3R9GT+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Bw4BCgCHOxFYMqpmY9UTAA--.8872S2
Authentication-Results: app2; spf=neutral smtp.mail=zehuixu@whu.edu.cn
	;
X-Coremail-Antispam: 1UD129KBjvdXoWrZr43XFW7WryfWrWxJw4ruFg_yoWDKFXE9w
	n7Xa4Ikw18Gw4UA3Z7Gw4UCF909rWvgr4UtwsIvr4agw1xZan5uFs8CasI9w18JFWfuFnI
	kr4DZFyvkry2qjkaLaAFLSUrUUUUnb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8YjsxI4VWxJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
	8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2kKe7AKxVWUAV
	WUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_GF4lOx8S6xCaFVCjc4AY6r1j6r4UM4
	x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxkIecxEwVCm-wCF04k20xvY0x0E
	wIxGrwCF04k20xvE74AGY7Cv6cx26r4xMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I
	0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7IUUsmRUUUUUU==
X-CM-SenderInfo: qsqrmjqqqqijqqxyq4lkxovvfxof0/1tbiAgcPA2apDkc6vAABsI

On 7/31/24 13:18, Miguel Ojeda wrote:

> On Wed, Jul 31, 2024 at 5:41 AM Zehui Xu <zehuixu@whu.edu.cn> wrote:
>>
>> In addition, since -falign-functions is not used when
>> -fmin-function-alignment is available but skipped and libclang
>> supports -falign-functions, this patch adds it back to the
>> bindgen_extra_c_flags to ensure the intended function alignment
>> is maintained.
>
> Does it change the ABI or could change `bindgen`'s output in a way we care?

You are right, it should not change the ABI or the bindgen output in
a way that affects us, as bindgen only generates .rs Rust bindings and,
after comparison, the generated results are exactly the same with or
without -falign-functions.

> If we do need it, then I think passing `-falign-functions` makes
> sense, since it is the only one that Clang supports and has the same
> behavior as `-fmin-function-alignment` in GCC (i.e. applies it to all
> functions).
>
> If not, then it may be best to avoid unneeded complexity.

Considering this, I will send a patch v3. Thanks!

> Thanks!
>
> Cheers,
> Miguel

Cheers,
Zehui


