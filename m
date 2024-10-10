Return-Path: <linux-kernel+bounces-359709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC6D998F63
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CBF41C23D5E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9001D1CDA31;
	Thu, 10 Oct 2024 18:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="fByw2uCd"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64B71E22E3
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583619; cv=none; b=JGv8wLE5ecA5+LOBeXiDUJxcz+PjZo53G2E9RijBzkEEobiKPxMgRB/fsPhn3B1aWQ4bdQDiuf+sp265yUnHcY8H/m6jCIX3YLqPlaMZZsT5L6UYOiGqBBpNbFBYlfdQEdXZdXKlXjMfa7yBc49pyRVg1cMVafgn0G7ju2hTekg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583619; c=relaxed/simple;
	bh=6MsBGtNkdC9fBTbiWSrFtxWvfPXwMPK9K04yhvsvUI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dukj2poTyu9j6yNAEJEf6pAo7xKyP79MiqtwmSAZ1SdKqmTA0X47pcp6F67B/0EGvMQCwvZ1OdXYwdRCm+UctRCZBWD8iAEW79oZ/F+5zRjZj2R5LCeP+VzAz6CNKzhfBlDPW4iaZMfXVvky7oGZntFJtgU+DLAlPatWykrfkME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=fByw2uCd; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PCF5tWgmHAb+hKF0MKw05oZojZksbtFsgk0xGK2TXI8=; b=fByw2uCdnoLBo/272ybMYvaODA
	UW4OPxiEayY+0LzPdpb6QUtVhopyp2LkehvbaRfqPSt/i5oKU8rInWNBqV+FMWuglQbwxl8MvNwy2
	g+mELD0lD9TOaRh2fuil9okS5vfCsLK2oPL1PX+Av7p013bHFGrahp0Qpd5kIVxmHnBo/PYVIKGDl
	MeNykp3a0rBPDhM2WuNJTpMj/anQ2JvoqSS/SDxB37ApTyLqOsBsrRomZf/s2pfG85X/6ewdNXnkO
	9WMCdSKkdyep59OTBPwuxFUxxGNzCwx/GYHQBSdDzoZj3sA5l1uOfIvyuxKbkNvd1prn1Mci5FDr5
	BOkKnkiw==;
Received: from [187.57.199.212] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1syxXw-007QUl-Vt; Thu, 10 Oct 2024 20:05:57 +0200
Message-ID: <f8db7927-cbbe-4cf9-bab5-4bf4465a637f@igalia.com>
Date: Thu, 10 Oct 2024 15:05:53 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] futex: Use atomic64_inc_return() in
 get_inode_sequence_number()
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, linux-kernel@vger.kernel.org
References: <20241010071023.21913-1-ubizjak@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20241010071023.21913-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 10/10/2024 04:10, Uros Bizjak escreveu:
> Use atomic64_inc_return(&ref) instead of atomic64_add_return(1, &ref)
> to use optimized implementation and ease register pressure around
> the primitive for targets that implement optimized variant.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: "André Almeida" <andrealmeid@igalia.com>
> ---

Reviewed-by: André Almeida <andrealmeid@igalia.com>

