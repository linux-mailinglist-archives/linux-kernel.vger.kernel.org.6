Return-Path: <linux-kernel+bounces-412325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F5B9D0799
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 02:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 700F4B21933
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 01:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750F52110E;
	Mon, 18 Nov 2024 01:34:05 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F4417BA3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 01:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731893645; cv=none; b=aMzvcPreuDN1NQw4jsPYoVrDLzEXd0NftP3AjBf3uPO3v9fn+kGgBr8MnZIIp79hokHv/oC8GkcRcdY2nwfiMCtQ7yT0WoISqeORFgx9pkhqFAtxR8+R3hEhonPntfDCj1k7xyXgiFbreaU6VWVX7A3itg7Q346ULCtuGT57aE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731893645; c=relaxed/simple;
	bh=8mOs4oxYbYD+FWRf6UUyMcunl959DqhJVom8TB+XMh0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OgrXyEz9DIRVCMaT3eA9GtYxdKR23VLFdsOzXgKwNVciifflg55xxu6ILLQHTzn/0BMHefNNufeXcTLuyRqK9QfFSfPosteEs2SgjznmpLlvEZFpkaDNiARrH9O0z/jYTHMvkeDLo56WWDpD59aB9+RPYcINe5tw6aU1cgIdxjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8AxUa9_mTpniuNAAA--.62577S3;
	Mon, 18 Nov 2024 09:33:51 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMBxqsF9mTpn1N1aAA--.6147S2;
	Mon, 18 Nov 2024 09:33:50 +0800 (CST)
Subject: Re: [PATCH] soc: loongson: add Loongson Security Module driver
To: Xi Ruoyao <xry111@xry111.site>
Cc: arnd@arndb.de, olof@lixom.net, soc@lists.linux.dev,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
References: <20241116085729.12651-1-zhaoqunqin@loongson.cn>
 <0509da76bd3be0d4c7ff433da854ae74cd367d5b.camel@xry111.site>
From: Zhao Qunqin <zhaoqunqin@loongson.cn>
Message-ID: <f580c60d-3608-0f82-9639-34f529825cde@loongson.cn>
Date: Mon, 18 Nov 2024 09:32:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0509da76bd3be0d4c7ff433da854ae74cd367d5b.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMBxqsF9mTpn1N1aAA--.6147S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zw
	Z7UUUUU==


在 2024/11/16 下午5:42, Xi Ruoyao 写道:
> On Sat, 2024-11-16 at 16:57 +0800, Qunqin Zhao wrote:
>> +config LOONGSON_SE
>> +	tristate "LOONGSON SECURITY MODULE Interface"
> "Loongson Security Module" as there's no reason to use all upper-case
> form here.

Agreed.

Thanks.

>> +	depends on LOONGARCH && ACPI
>> +	help
>> +	  The Loongson security module provides the control for
>> hardware
>> +	  encryption acceleration devices. Each device uses at least
>> one
>> +	  channel to interacts with security module, and each channel
>> may
>> +	  has its own buffer provided by security module.


