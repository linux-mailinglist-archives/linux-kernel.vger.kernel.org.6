Return-Path: <linux-kernel+bounces-444144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAAE9F01D8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 02:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C6FC2879AF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 01:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79281F94C;
	Fri, 13 Dec 2024 01:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="CaKP9zze"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B17C17BA1
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 01:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734052590; cv=none; b=phiDpEKNSX92ImMmsW3GBiSp5qVU7bL2ZjWpZOcMrbvYIc9o6q9BcXztjktVxtCW/xx/1kQAz9BmB1c8PmQm0iAr+H8JCSLy/ATFnpEUXYh2MDiLdzh8H5L1va6F9oeN+AKQIkc3r6nWgpFwqwWZa4P1BeR/RrxsQjzApf2p0pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734052590; c=relaxed/simple;
	bh=u7mAhfQK3/9tnkSmNAfLRnpr/pNk8d5aZ93+Q+019dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y/FevnkRBV209hQZcywwgIPVpWV61Cp+HcnxzGkRpOdGH+2mzL20I+umnIbvpujsf16T/Xb90kHuWRXTwH1SkCRCIkKSbDVVq7OF/G9TqgPuIzi7WlenS9/iLo/KqZNl3e0WHbsD8bfHXtdk3KhdK4ePWSh/3TvW7BZCewfkyZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=CaKP9zze; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zt0iBnn2EnEmd+EGTwbF1Elj1ZFiGOgKhBTmJtK5+Bw=; b=CaKP9zzeqzINQCS6ln2bkysGPy
	fMdjJu7j1rCs9jPZLzMlfXWKI5Kr7Epleg3DhpH2KwlVdQRrlGslBcXRONHHpkpnf/bn8ZHrjBW4s
	ivs8AvzJMFHEDPGY1yUQ9WEUxz0ALRLZNbOP3q/h8SQETp5Sr8HyBy44eqTPZHSZHBbnNr3vybc0k
	8S1kPNt7Mf3Ajfh0wUl7fhsDk8t44mrY4iXAebmUgLLEto2EYjMAKbIYWI3P5Rw5rXOjSS2swjysX
	JIHgLVtKbNVMlx4E7yPZ/HIzx6W8K/ITqCGpg8mUNoOb7cmFbHjLGq64RH4ui6XydyKDOpXJ5+GFn
	vSwfUAnw==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tLuHp-002TCH-7i; Fri, 13 Dec 2024 02:16:09 +0100
Message-ID: <bf8a3eb3-ae11-4441-9207-d7241939d359@igalia.com>
Date: Fri, 13 Dec 2024 10:16:02 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] sched_ext: Implement scx_rq_clock_update/stale()
To: Tejun Heo <tj@kernel.org>, Changwoo Min <multics69@gmail.com>
Cc: void@manifault.com, mingo@redhat.com, peterz@infradead.org,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org
References: <20241209061531.257531-1-changwoo@igalia.com>
 <20241209061531.257531-3-changwoo@igalia.com>
 <Z1lCnEr25fOB8RWI@slm.duckdns.org>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <Z1lCnEr25fOB8RWI@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 24. 12. 11. 16:43, Tejun Heo wrote:
> On Mon, Dec 09, 2024 at 03:15:27PM +0900, Changwoo Min wrote:
> ...
>> +static inline void scx_rq_clock_stale(struct rq *rq)
> 
> Would scx_rq_clock_expire() or scx_rq_clock_invalidate() be a better name?
> Also, I'd roll this patch into the next one.

Thank you for the suggestion. I will change it to
scx_rq_clock_invalidate() in the next version.

Regards,
Changwoo Min

