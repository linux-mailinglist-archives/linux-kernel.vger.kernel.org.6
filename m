Return-Path: <linux-kernel+bounces-423948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1439DAEA2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9BE2821E5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6412916132F;
	Wed, 27 Nov 2024 20:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="rvf23UxE";
	dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="m8ZR3PTF";
	dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="uQ7H2Byq"
Received: from e2i702.smtp2go.com (e2i702.smtp2go.com [103.2.142.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17A414F90
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 20:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.142.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732740764; cv=none; b=NQUS30Nt56dCoMo71d7E6XXpkhMdTILBQoPh0e0qa2ehDdoCLMJv15fqzPRqYYX8pUMOqWAFMpEQnsWeLGu3ToV6ieESowzr/3fu7NHCyBfT+AzzBa65+UMop1GQ8PdIMoCzznwlAZi3qQV0C9juj5qDPCHjII/puXOy6DZwEBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732740764; c=relaxed/simple;
	bh=em50niaeJ/+DFKfLB8owqRPQ+e0oCNG4MKo4HwmVwYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKBm0uNE5M0Jzw61eowQ50phfJyNiAyWJbfZeBcmHWNEe0H+nvQCZJgB0zmLaDkhOdDyJ0DQTyfhyHHP1Smr185b7kvuY21ZK2JWRT1hLVwFqALq0uECobTnReutjFGRlzJSGWjpCmKn2WS2sVar8vLc8QdN61VVrvtPNT/6eIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=em1174286.fjasle.eu; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=rvf23UxE reason="unknown key version"; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=m8ZR3PTF; dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=uQ7H2Byq; arc=none smtp.client-ip=103.2.142.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174286.fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=mp6320.a1-4.dyn; x=1732741653; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=2WINOyRzo695WtaTsQIcd3pK9JHKA4hoY8eCup6zQQo=; b=rvf23UxEberOhLb8Ko8UA4nliL
	ZrvtBPzj7E0lwDCaQZI5l+G5RdFFXgOXa4tETRExZz7ZhsGGRW8cjtZGcLeWe+65YEfw58K4FzCOQ
	VrzCekaCeLmoGfsFAGPuq8lU1+rg9T/+g45NygAripQ83yS91LFyL/z0xDX599gvoy8MBMKbwNZdM
	O8ZqyeJyumRoeGd9acsyx6s/JxOusvZKpUdfq4oq0TGpOwD8puiY0j0CMvCy6GMsIFADxZGcYsEjB
	N7M1u/NvNwD28btPJjqbnGg+5/iVbuyasF5rSI2PPEoI92/AryQ4Zd/MuF4+0GRSbvTusNhzq8XMt
	srv8xQ5A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjasle.eu;
 i=@fjasle.eu; q=dns/txt; s=s1174286; t=1732740753; h=from : subject :
 to : message-id : date;
 bh=2WINOyRzo695WtaTsQIcd3pK9JHKA4hoY8eCup6zQQo=;
 b=m8ZR3PTFjjNy6pjZB5JfE1BrhOnlkN0f0x56u4fOG2CJa1lhuW82E0a4a23WfJXxWIuJa
 zWzLyRSIraUvZmDBCW6Jq89sRMsZx12m52MK+o6X8+JgjiHiy40qy8UFAPoa4WUL/DDg+Pm
 ivVcVOJcdt/zdARg6UJiQuEX1I903/rkJwoEAqOcCSOGKRPckFE/1Tr04RwHDyyQJ7qH9HT
 e9DhkUmmxPBb6yX9kktXSiDVMYMIV81lqYyo0PuqTw19Sc8M5QyPKM6LOvW2t7f4yWSu9kv
 HD/ns6wJ6sUlAufocCLGD4S2JmCrwBEmohjar07PoKou7T1ho9gtwvLULbrQ==
Received: from [10.172.233.58] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1tGP0o-qt4KpM-ES; Wed, 27 Nov 2024 20:51:50 +0000
Received: from [10.85.249.164] (helo=leknes.fjasle.eu)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1tGP0n-FnQW0hPueOx-n8LA; Wed, 27 Nov 2024 20:51:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
 t=1732740708; bh=em50niaeJ/+DFKfLB8owqRPQ+e0oCNG4MKo4HwmVwYE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uQ7H2ByqwM2bNS8kgFd/4tj6GiGvQlM2GnCKAi3M4xf21iew9DK6D9Xdcb3NXe9Yv
 6mYzAWAjgdzB7R/bNUJu77oJCxUdo+Avf4pssR+q/9Sk5QOsrpnOjsoK4qb5u1cYz7
 L8/W3ZuIE5Sm3ISPZaha3/h2Mv24Zm3yzqibezQA=
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
 id 1F0C93CDEB; Wed, 27 Nov 2024 21:51:48 +0100 (CET)
Date: Wed, 27 Nov 2024 21:51:47 +0100
From: Nicolas Schier <nicolas@fjasle.eu>
To: Advait Dhamorikar <advaitdhamorikar@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH-next] modpost: Remove logically dead condition
Message-ID: <Z0eGY_6e9jVMezxE@fjasle.eu>
References: <20241127162904.28182-1-advaitdhamorikar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241127162904.28182-1-advaitdhamorikar@gmail.com>
X-Smtpcorp-Track: Fi521KbK9sq6.ANwmu6pIYeB0.UxtY8gdOHFk
Feedback-ID: 1174286m:1174286a9YXZ7r:1174286sXt6ANBR9r
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

On Wed, Nov 27, 2024 at 09:59:04PM +0530 Advait Dhamorikar wrote:
> In case of failure vsnprintf returns `pos`, an unsigned long integer.
> An unsigned value can never be negative, so this test will always evaluat=
e=20
> the same way.=20

'man vsnprintf' on my system reveals a different behaviour:

| The  functions  snprintf() and vsnprintf() do not
| write more than size bytes (including the  termi=E2=80=90
| nating  null  byte  ('\0')).   If  the output was
| truncated due to  this  limit,  then  the  return
| value  is the number of characters (excluding the
| terminating null  byte)  which  would  have  been
| written  to  the final string if enough space had
| been available.  Thus, a return value of size  or
| more  means  that the output was truncated.  (See
| also below under NOTES.)
|
| If an output error  is  encountered,  a  negative
| value is returned.

vsnprintf prototypes also indicate 'int' as return type.  What is the sourc=
e of your mentioned findings?

Kind regards,
Nicolas


