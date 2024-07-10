Return-Path: <linux-kernel+bounces-246968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 537D092C974
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 989BDB2167B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02B03BBF5;
	Wed, 10 Jul 2024 03:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="fCM6lj9T";
	dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="scvggdjo"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CAF1799B;
	Wed, 10 Jul 2024 03:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720583774; cv=pass; b=pXXtSQf8aJaPYBeRj+x3rSUb4UGc9xgZsE6QhNot2xyska0Lh+twtxFs2L03cnjhSc7j2jvLe3WbgKFHLGzqblZQ8ck/iG5kPIMmu1qUs74P5sdNwhMlqNpXe/qKNnyvYgzV+WY8ZhIyhXhmwXaTxdkV1pczcDKrdqH+CGJuHPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720583774; c=relaxed/simple;
	bh=JfISGwFRIWEgdJA6hzOo06B7wiZKNpm///RXaIBBGGY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FLjayOm5iCcTV8FK09NVPpLJw3ks3QvtWO3k4BFuOPzwIMlZVHrgu5J3Dba+8zi0ddxqi7Ksq0ZDT5+7QqFTNYwi36X+DsW9SgxzEYRtzQ4y24CWOpkrSLXUae+towqMWFHVj3eLZv51Rmr2u9fYFYS3L1Y/JCVwtL35Naq5eKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=fCM6lj9T; dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=scvggdjo; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1720583580; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hoOnVnmAwl5/d6O9LWBGgLHtxLKdnVTiF88/W4WDqnUekf14Yd6qauuT9ix/8fa4hs
    18KUEeaHMHFqKlgFtHU5qv81L8TdZODAr+ng6RrXbmTiMS3SABIPwiIhb/SeXYnYINI/
    QVJhVAjdE95dBYV+Ns3/mQyjr8l2cnKwOjssCWjgewX8Q/MVF3EOAhXqt+lFptVWZQWn
    VP4GrtURgsyaqkpCUq2BKmrJ/9Cb8fHpuZiBBzKo4v2OQB/tnBAEcmJgrWY4wei99HbE
    dzOnpegCJ55xR3BYtWShJbRCFDAO+ewni/ugakPToNwtp+LTOReD/dczoQZEXYGHv3t9
    ObGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1720583580;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=KRsZudZaU66bfqcpsExsQgaeHpzwNOwn1WEuUI/OyRA=;
    b=sFWNg31SL3rE48PT+jPyiDJqH2ETQKNEcRv8KnLvMkcLRR5PoG0QmUS81hX4piJuz+
    9ObVjBq7OncAkHCi46XNlTfU8MNPUXtbcUFE9ZV11Aa4b9Y/ykh9gOpj3xH9guwWwZdO
    e8LGQ1SmwT9JyZoXjtR3vZSCDA5FglX4LEGN8Oou7ndzf3FAiYNQGuOAt/Kx4/4pwj3K
    uZNRbLUq9fGQQStAGG2K2Al+tDr+ztUyZEzGIMZ7nRm0+xWGUQAzKa/AGm6uKs2Gv5g+
    R2suadLKjsqVpqUWt7plcSlzhUIgm4/rNiMo7NWGGcrzFlvg18+CcWYPfTbK8A3i5YmC
    hSXA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1720583580;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=KRsZudZaU66bfqcpsExsQgaeHpzwNOwn1WEuUI/OyRA=;
    b=fCM6lj9TSrbNvTu5XpoCXJ+W+IzmaDucjm8UV2Iops2Zmc1RvCcS4LiNbmCl9FCrvg
    eX1qwJiImPWhFgEviVmpVCPD+vDBgLSuHmQgfzBUhbG4lmhVA2BEDqc8Ssuor6n4Ny4J
    EjPRTpf1G/nfcKbfjejDFhLlfooT1nubOIa32+BcCzNdPqCLfXvZpIy4BAPHvaU5Xc46
    PCnpJlMVVc+2N7NcJhH+1ckDREBP5Nmwt0Mr/Jt8FQdNqVkZMY9vWwBfEKB+A0ltO39T
    R4K33F1FPp3Bsn/nPRl9b8j+BT6nGOysqoPGfBAyeMYrh0TlvNJR+q2WBlsoZ5mAu9iC
    k7ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1720583580;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=KRsZudZaU66bfqcpsExsQgaeHpzwNOwn1WEuUI/OyRA=;
    b=scvggdjooBCng+3I0Y9aHPMwxcrFQR67GZncRNUHpSXuYrvcxw9uczkCVwhVtNQzdr
    hf8T/fNvWKn9Q++3IQDg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHvJzedR43J0obSjfTFwxtSORXzhXD5BXQVVAX0YLHX9mRQ=="
Received: from [IPV6:2a01:599:819:be6d:c234:9ffb:cfc:6d3e]
    by smtp.strato.de (RZmta 50.5.0 AUTH)
    with ESMTPSA id e0838906A3qwiWE
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 10 Jul 2024 05:52:58 +0200 (CEST)
Message-ID: <c8010a06-9d8d-466a-9a83-ee25950f1885@xenosoft.de>
Date: Wed, 10 Jul 2024 05:53:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PowerPC] [PASEMI] Issue with the identification of ATA drives
 after the of/irq updates 2024-05-29
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Michael Ellerman <mpe@ellerman.id.au>, Marc Zyngier <maz@kernel.org>
Cc: Rob Herring <robh@kernel.org>, apatel@ventanamicro.com,
 DTML <devicetree@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 mad skateman <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Matthew Leaman <matthew@a-eon.biz>, Darren Stevens
 <darren@stevens-zone.net>, Christian Zigotzky <info@xenosoft.de>
References: <aeaa9b78-5853-473e-b985-b10241e88e0d@xenosoft.de>
 <8FDD860C-4DA4-46EF-BAD6-8F68837DA993@xenosoft.de>
Content-Language: en-US
In-Reply-To: <8FDD860C-4DA4-46EF-BAD6-8F68837DA993@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

The RC7 of kernel 6.10 boots without any problems [1] if we use the 
second irq patch [2]. Is it possible to add this patch to the mainline 
kernel?

Thanks,
Christian

[1] https://forum.hyperion-entertainment.com/viewtopic.php?p=58643#p58643
[2] 
https://github.com/chzigotzky/kernels/blob/main/patches/X1000/of_irq_v4.patch

