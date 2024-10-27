Return-Path: <linux-kernel+bounces-383852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2419B20F3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 22:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E86642816CF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D651885BE;
	Sun, 27 Oct 2024 21:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="WFfXYvMY"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B3B538A;
	Sun, 27 Oct 2024 21:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730066260; cv=none; b=aIlu8WKCRpiaXRj5a/FCvWyrpcr8EZDiqL/YLBCq9SqiNzEQGqgKuwRj1Dn/ZA3qBQ+s2EJ64ALT9iwp4ZbvcSmXksuKyWt9kVplS5sQzroISs0sq79iemm7TEqSoj4CclJnt6eEucGEoxAUd7MB4w8e5RIFCxjv/C6193YVTvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730066260; c=relaxed/simple;
	bh=zhpA/pUJ6k/6prCSe7Jj2nIyo1Q0CSS/ioHWtzTETXg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lP9nYCce6J+AV3ht7is1BmQa6M5wTc44KvF9pdcDzIiHOYhwp8/35D2lckN5T6RFTl1yzloU6gz0pvLzMnhy/xmFyk32ri914JJJ5itMinwrI8nv+MpJ15e2fakTVqerJkYj3cBtf++ucUC2D+oIqfr5u+t4q348SkZsbzJ6ZXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=WFfXYvMY; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0CA5942B33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1730066252; bh=ifWpwQOiXGSyOuEBW/cbbUk+XXsVKdYLGRNKIE0JELs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WFfXYvMYaqGAdjI5juyW2qvxrrcdWA8+Xj4WIAS7BjVtJs9axGKZMPdS/Sud0633e
	 Heh5RMduZ7dXYdwf9ET/K9EbYGEu7z52L1uJQJr2Ym+vpV9tMyLRPF+PuhxIyxtbg9
	 YkOMELF0+TB0MorhiX+cL1sAxkIcH/wSC7JpV3vvsvWmRmV4Mj+sxwBJOexZiErmT0
	 PM726lZ2hYCf1ZSIyZLykWgSeCbj2Zi7hNZAo3panvCj+u4L2kZ61LmowG7dXTd/zp
	 8PteW6x2e9eX27I88qJnl/qsZ+xlx0cOmPh1AaRfkfHgMAcqIHVX3TlQkwI8laTztH
	 VqjRxoFLV7RJQ==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 0CA5942B33;
	Sun, 27 Oct 2024 21:57:31 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: xu xin <xu.xin.sc@gmail.com>
Cc: alexs@kernel.org, fan.yu9@zte.com.cn, he.peilin@zte.com.cn,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 mudongliangabcd@gmail.com, qiu.yutan@zte.com.cn, seakeel@gmail.com,
 si.yanteng@linux.dev, tu.qiang35@zte.com.cn, wang.yaxin@zte.com.cn,
 xu.xin16@zte.com.cn, zhang.yunkai@zte.com.cn
Subject: Re: [PATCH linux-next v8] Docs/zh_CN: Translate physical_memory.rst
 to Simplified Chinese
In-Reply-To: <20241027133518.2972180-1-xu.xin16@zte.com.cn>
References: <87ldyc1g3o.fsf@trenco.lwn.net>
 <20241027133518.2972180-1-xu.xin16@zte.com.cn>
Date: Sun, 27 Oct 2024 15:57:28 -0600
Message-ID: <87h68xw6nr.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

xu xin <xu.xin.sc@gmail.com> writes:

>> > From: Yaxin Wang <wang.yaxin@zte.com.cn>
>> >
>> > This patch translates the "physical_memory.rst" document into
>> > Simplified Chinese to improve accessibility for Chinese-speaking
>> > developers and users.
>> >
>> > The translation was done with attention to technical accuracy
>> > and readability, ensuring that the document remains informative
>> > and useful in its translated form.
>> >
>> > Update to commit 7332f9e45d2e("docs/mm: Physical Memory: Fix grammar")
>> >
>> > Signed-off-by: Yaxin Wang <wang.yaxin@zte.com.cn>
>> > Signed-off-by: Jiang Kun <jiang.kun2@zte.com.cn>
>> > Reviewed-by: xu xin <xu.xin16@zte.com.cn>
>> 
>> One does not normally put a Reviewed-by tag on one's own patches, so now
>> I am confused.  What is the role of you and Jiang Kung in the
>> presentation of this patch?
>> 
>
>  Let me explain that, it's because of our company email permission policy,
>  The author of this patch, Yaxin, has no permission to send out the patch
>  temporarily. So I'm just helping to send it on their behalf. and at the same time,
>  I'm a just reviewer, not the owner of this patch.

If you handle the patch and send it onward, you need to add your own
Signed-off-by tag stating your right to do so.

Thanks,

jon

