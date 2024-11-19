Return-Path: <linux-kernel+bounces-414860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F2D9D2E84
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6B15B29161
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7651D0B9E;
	Tue, 19 Nov 2024 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="K8NFVWA6"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FC040BE0
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 18:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732042640; cv=none; b=IDNrcgSCCaKh3ZWc4422fZ+WtwdR/nvXoPbJRnrI8d94nBSEA846li41zRfM7lOhoW+gbjZHfaebhW8ahzhB29S6Fc3Z64zH3mRjF173Qa3I2oW7gPayTpvnUhFjpHNh8owa/ETQsvHfHEzqQNndxdr1QzlR0UtxNJ1ACPUIXX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732042640; c=relaxed/simple;
	bh=Nbm2T7xHbb4DbCWUnZbZw7BxVMybyEThr3brvE9IOr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pUYmvp9d4MzGqvItPrXyI6y/BgFoK7WA3KY9aispwYUq5NdRHLjZnURKjapWedqhUhHluHBCvdi67fcWUee3veEB3rtpSdMg6Vo6B8KFAqH8G//YlWfWJ/Yi+iL7c3BQLCbKSZFzLCKMYr91yR8fFKCZjZeYao7MikgI1cBbwa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=K8NFVWA6; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732042610; x=1732647410; i=markus.elfring@web.de;
	bh=Nbm2T7xHbb4DbCWUnZbZw7BxVMybyEThr3brvE9IOr4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=K8NFVWA6dvt4Z9w0KnGFf1lMVhIZypKix17p2JAOT975xqcMeDKq6Me0u4D39EW+
	 QDLVWK32qLLd7WwEkOBC4g46HkY2+0SGAiwFhbCfox63narplsPum6n2GKhnYVS9a
	 ObhbM8qV8F5pdrbbW+//qR9u33U6Q+9Fx7Q7JijhqRQG8H3X47AdfDJChexVkQ6HE
	 2wfAFdEZkHFixBVb2TI/XdOwE6unb+hcYKk3LIkDitJFu2wI2xNRptrsZTq8I1jzv
	 8vWhNQx0xHFIw4islKyQWoXpgw0rof39pmSslSkDq/c/r1kP36Cc8+Gvevavuqy7+
	 MaBSxdnAi0LIKl59yQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MBSB9-1t2DWg3zHr-00ARLF; Tue, 19
 Nov 2024 19:56:49 +0100
Message-ID: <133d5ad1-2eb8-40ac-925b-97ab39be0d5e@web.de>
Date: Tue, 19 Nov 2024 19:56:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: x86/sev: Fix dereference NULL return value
To: Shresth Prasad <shresthprasad7@gmail.com>, x86@kernel.org
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 LKML <linux-kernel@vger.kernel.org>
References: <20241119-fix-dereference-null-x86-sev-v1-1-82d59085e264@gmail.com>
 <9dd3d046-6949-4e42-ab5a-af505f9b3981@web.de>
 <CAE8VWiJ62xT9shaEmUTOPF1OAztaWsr57m-wY9jyMJt5WFke5g@mail.gmail.com>
 <ea06c201-5a99-4875-b2d1-3bc4a35e2d5a@web.de>
 <CAE8VWiJqTB+PB1cFv2Sj8YbRWxgcrua3ZjyeWGF-7uqrsE95iw@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAE8VWiJqTB+PB1cFv2Sj8YbRWxgcrua3ZjyeWGF-7uqrsE95iw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ZKbOS6BWcYxclddu9YPNMWi8Q7oEQUO1+M7d1gvi8eJGkIV5eVp
 bNWYOHd/Rn1/LA6T00YsFpQgl9wzkyfv4tZXJQjdvKNNUUieDq/5osQsM2WNbl5xR+9fadX
 ON7mZjOpJEdV86vMhQGv6Syjhy+owwLBPVy7ZFv5QHzQ3FiznJoWNRD/27as916lSLkLae8
 JAv4YswX6/u3P/orpEyqQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xG7gMTt4eHw=;kypkDx8dvtFPjUclxlGulBzmptm
 XT047XnFwkrS+GRUgFA+a1ILzzzt8vxVxGNT9mW66m3A+v+JpX/hZ0dfuXP7Sc5wWUrP60KyW
 uVE/77QG2govqv79zi74LiaKMCtbZvSYh1hrxNxFD/OgARXdtJ//4x5BvupPxKSjiEI5SABlL
 cCfK5Th9C2vR5sk0eLjiFZ6GgGX9NBCPIRM0M+3yepTzomCPs8XX7RkiRuBRJLM1oeZ5dAqKf
 Ht6fSsH0UTzf8l4dUO3T8Mp1FNE3c83SjnUmFUIeyVBsno+Xka/zp49PC1XFL3FAfPNQ1REui
 pWUd+FnccEEsVB1Em8IdDrP7psnPhD5kBSpdHxK+zY5/HIdUlVx51Z0U5G55tCndiot3g44hO
 UDA752uHrTl0LArAvthEuOCkOV/mIG+wylkgNfK5kdmWUCB3h6RSt070dXtUmlVlFuPokpPtX
 hjvd/emy8zKdtmR37UDOd2Q6MIOLCk+jw/YzmcAayml3dizGQfUZJX64mBZ+RkyCLzarxjjPL
 VzDAFT4dgk2E5/OnRe1YeYlnWZjuaPmO5838EAjzPGlqHWg80sTb2lK/XrT7r39jatFRxJZok
 aQck6EQsiw1KulVWlnZw8z/9JCLOqY8Gn6UD7IJsU82zRkEvTIzmkdXYv3t/jVk5CPSgZbukE
 +KDez3jE0v8FZeaW+0owKBEteJIAmyH+cx8iiRFBfWazkSQdop1ivYMUEtKzIuAQd4odmoT0g
 tNBl+k4poLRwdgumMWycGhL2CKFV77o3NA7Dlpmy+JzqbGY3pE/+mNGv8Cnkp1QthxkAhCE7d
 6GNkNEWVgFv9JXrU5o6Qq98HX7b74r7+CgUW/RMtFtJNCYwhD24oiyRQ9KDsdeI4D+SlkKnv3
 +10bKB9I5qbQVImGMOLHKM2UyUIi/dH9ofWXPUB6BR+cKqP2alXY8dMDn

> Using git blame I see that snp_kexec_finish() was first introduced in
> 3074152e56c9b
> and has stayed that way since. Should I just use that hash?
Probably, yes.
Would you insist to use only 12 characters from such an identifier?

Regards,
Markus

