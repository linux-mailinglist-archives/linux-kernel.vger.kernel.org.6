Return-Path: <linux-kernel+bounces-535375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6D2A471C9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4D927B09CE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5A76F06A;
	Thu, 27 Feb 2025 01:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="VFQVkkL4"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5D0E571
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740621279; cv=none; b=IpDFejOJpTF3CO4NIShcyJRm2gYohQgIqE/LLmUIacDhs6c2HcI7lVSi/LeHAOl0temp0fhoHbF9CsDX7N5yfMt+oPpVApJyc0vabhFRaG5eezyfsGBEKRnTdhn0UKadnkAUd0s3EmNfZkjkFI9b0SrVSkJdFtwSLFMQ5jlRclY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740621279; c=relaxed/simple;
	bh=MSRoSlHAQv7XX+7oH3zz5atc5WoNBaIINm4hNCf409M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZq2z6qS9zbjJXXaOYcqDPe19klnjDYKkvisrFGyuzQqIKCd3HUBt3tmxFApEzBAWSk5IRosKzo7322fX4QS893Pg/bBHIdoiS2wRYrTw+YQkEoKA48LI0vof/4dUu3zuGifxQ1QNC/A9ZDFP0vlN34nD1mgD6d/vP/ljYLk1G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=VFQVkkL4; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NjgfQxROOXoj4xmpkajlhI4W4u/CIKSsCPZCdmuSgBY=; b=VFQVkkL4JHlp1x4D6sc/uC3c3C
	p/aX5E5l0x5NzdpceZuFcks3RvqBfThpBeaSnWatoLJ1ZnNGyuhahZot7Hef5UkmnS0x9nbBN4dw/
	txxUyJjOL/RfWcQbBvQ+qa1wYM/g+m2DpJ3+X9rNM+vGrkWbNufAMOkrRMAf8mYZ02XE1EaRGjaLN
	isgcSaoI+CeK11P0sTbAVgV/gu2IEsVhvOoLQuuKYr9wJfucGCnC32iTd2AE0trzkhETQwVfiDsYH
	f+0lbafN5/sh5Zopo9xXumOauZaGZo1S4GWfcGpWCPmzv6fCat8aNxvHveIUj9i/uPfdR5D9wvMeh
	Br6/bAmA==;
Received: from [191.204.194.148] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tnT6T-001MMu-Ql; Thu, 27 Feb 2025 02:54:27 +0100
Message-ID: <be388631-75a5-4890-b7c4-063a08e6c7e1@igalia.com>
Date: Wed, 26 Feb 2025 22:54:23 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] futex: Use a hashmask instead of hashsize.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, Waiman Long <longman@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20250226091057.bX8vObR4@linutronix.de>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20250226091057.bX8vObR4@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 26/02/2025 06:10, Sebastian Andrzej Siewior escreveu:
> The global hash uses futex_hashsize to save the amount of the hash
> buckets that have been allocated during system boot. On each
> futex_hash() invocation this number is substracted by one to get the
> mask. This can be optimized by saving directly the mask avoiding the
> substraction on each futex_hash() invocation.
> 
> Rename futex_hashsize to futex_hashmask and save the mask of the
> allocated hash map.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: André Almeida <andrealmeid@igalia.com>

