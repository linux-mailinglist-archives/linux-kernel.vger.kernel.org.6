Return-Path: <linux-kernel+bounces-404411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 066949C4372
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC2561F223E5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850AF1A704B;
	Mon, 11 Nov 2024 17:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="SukEesPX"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231F71494BB
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 17:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731345562; cv=none; b=Q5pplR1cLvyNQdGfFwgnn2nAZq1HTbi5iTAJlfPAKa2cSsJDByb0FgRlIzmz7woe84hfnEo814Jc3b3Sc9SKg6c4HGJzl0yg6Ql9JG/MBQXJ7jQUoiwYR3QIuSn5WIs3ZMHMRqJZlDFv7cbDFVpIWYMZrHCDc6OdjfUBte7dL7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731345562; c=relaxed/simple;
	bh=hNUeqD+lVsJBRbEFkK4PmdQAcN/BCXV1PSZ3SYH4tC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lf77wLKMk6f0h1IdNDCD2YkLtbsh1wO6OmQ97Gp9CBQ+V3a/5HGc3e13U5BGT2Gun+k8W6kQ2njFhjE3cuL4ErSH5N1QncqglPKlFkkYqlHbHcsaam0BZO/JP2np5U1VXbnHR7QN/lIcOSj+g3e6mujW4MNOBNkRrhvCvUV27vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=SukEesPX; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vt8QrytlM6V2BUYi8TToKbcS7cl84Bzk+nOqQuQcapI=; b=SukEesPXyt7+N2QyisJfBalF7k
	t68isgZ8AUvFf29f8ztiWoUz/RXl5+BsbEiyJ1/O06+iatuOHkMApIPEAx4CXF58Oo7RDBEiT6GD7
	nDD/EL3SJqBB0M/H4KP91d+RA4V2W3oO762eAISI06oIjwO6kDp9v4JSv0Gn/HUZrt64IgBqwG0KJ
	9DPoYIupOeaO0IV/PT7S3ALl/HMzBvP8n7fjy9YeEBn3GGE5LKC4jk9NIX8kxt8MR8RpIBZ3I9Tim
	c3aVgtWpDVMpf0SGAHaXWITm26Mgf2s8k7Pi3Yx5prLVG7BDD4p7B7EXyz4GemVDFSP0sKP1LZBvV
	ITpv3WNA==;
Received: from [179.118.191.54] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tAY4A-005ZCK-Ur; Mon, 11 Nov 2024 18:19:07 +0100
Message-ID: <9b753080-87c3-424e-a2a9-d4b04c1dbec4@igalia.com>
Date: Mon, 11 Nov 2024 14:19:03 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: shmem: Fix variable type to int to evaluate negative
 conditions
To: Karan Sanghavi <karansanghvi98@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Christian Brauner <brauner@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Gabriel Krisman Bertazi <gabriel@krisman.be>
References: <20241111-unsignedcompare1601569-v1-1-c4a9c3c75a52@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20241111-unsignedcompare1601569-v1-1-c4a9c3c75a52@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 11/11/2024 14:10, Karan Sanghavi escreveu:
> version variable captures return value from utf8_parse_version
> function which can be negative, but unsigned won't
> let it capture, thus missing the further checks on negative values.
> 
> Fixes: 58e55efd6c72 ("tmpfs: Add casefold lookup support")
> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>

Reviewed-by: André Almeida <andrealmeid@igalia.com>


