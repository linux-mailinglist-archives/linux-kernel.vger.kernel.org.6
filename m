Return-Path: <linux-kernel+bounces-446972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5FE9F2B89
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26C6164024
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3FD1FF7B4;
	Mon, 16 Dec 2024 08:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="TUc647am";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="I6QdetgM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="IR5N6IC/"
Received: from fallback19.i.mail.ru (fallback19.i.mail.ru [79.137.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4C729CA;
	Mon, 16 Dec 2024 08:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734336603; cv=none; b=sM4GqBy9epXlSGRMX89GGnkMQ1G1HuHidlZQmcqN7c9va8KyOzhPBO+wqxUcDv0xdkyMgodIN2ULN1V3JosAZLblxjJz80n9hAdSJdOFUxiBeykyjF6y4sQ8FnepPcgwP/oNY35gVk73k3K7mr0TB8w+rstjLB7BxYjtF861eOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734336603; c=relaxed/simple;
	bh=NXzcrLCIwrZaNpk9mMoWHauRMQChNldb/gKbfED1vCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RwUWmSbA4W4cfcDPZY2xnpNyezz+/TjywfvnFjz1dOBSMyjRkffqLfg6vUHGdqzbEsJlIPh2eSfP55Xecm08JgLKR4J3VQg7hqW+hlyGbLHHEHeVH2uD75Bq8tiIL6AC+EKe9pPD6jvZc1mxZKILTKh0dWZYa8Js4QZahrh7FQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inbox.ru; spf=pass smtp.mailfrom=inbox.ru; dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b=TUc647am; dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b=I6QdetgM; dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b=IR5N6IC/; arc=none smtp.client-ip=79.137.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inbox.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inbox.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=fSgLWw6k1JQtHPu8TTYQ015LHdBWZ9OZx6PpNk1hcxU=;
	t=1734336599;x=1734426599; 
	b=TUc647amGWORL5XEJi6pgrm0j9H0N+ZBEMahGe5nHlFvejfGLgykq8ubq0FIQlOiceMmxFAnU3kkaaCdyIW3K79YVUcOw7t3h14bk1Y2Nj5Ga/WIO6LqlGGcaUCMpvgFZtMSmeL3ARVUTAfhFR9zUO3ih0I8p5kA3hsOrWonvtU8SBVqDZOT7Iboxz4B6z5T9DeJUKQHdfZYSRQ+J+q9zZpEbqPRmGeMTNu+uxH+Yh4HXf3wCJrb7Xo2T/TCMEzWTaxiBuCPdRjde7pIUw+ztwmXemityKX49dMxD3KawONqegVM8jWZ9omoVJD5QUXIP//9Oil5xyS0OFkznS07fw==;
Received: from [10.113.54.58] (port=52254 helo=send288.i.mail.ru)
	by fallback19.i.mail.ru with esmtp (envelope-from <fido_max@inbox.ru>)
	id 1tN5tY-008fFU-0b; Mon, 16 Dec 2024 10:52:00 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
	s=mail4; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References
	:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=fSgLWw6k1JQtHPu8TTYQ015LHdBWZ9OZx6PpNk1hcxU=; t=1734335520; x=1734425520; 
	b=I6QdetgMdqnbdVXMgn4wqOXcK09hi64sLJvQUfZeRQ4zOBySq8AhwNuY50NwRPVDIxCOKlQI8XR
	dCXlLstQEwiXTqKrJyPzV/iKdC1rRXfB18LhkRmOruJXpsdHak3vIKR8qlKfGGBL07GmZWvpF0p5U
	s3xM6ymm7mpOmpwP8vntVub8qbHHHfyniLkYW/PgmTXYmPjHGgnK4kYrkmmrNi9fl+L+p97wJfa5J
	5BLlEF1ToZwTtyTyTDJ+jXlv92hrDINdga7apKUvlp8gpRAJoPav+9zv6H8aL5/HCcW6kqKlTuMcm
	9Z96Lb/fzNqUlFSnJTysqZ7e8V/Cuhc5ii5A==;
Received: from [10.113.102.47] (port=34658 helo=send34.i.mail.ru)
	by exim-fallback-5b68796bc4-dzqxh with esmtp (envelope-from <fido_max@inbox.ru>)
	id 1tN5tP-00000000D74-1jBa; Mon, 16 Dec 2024 10:51:51 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
	s=mail4; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References
	:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=fSgLWw6k1JQtHPu8TTYQ015LHdBWZ9OZx6PpNk1hcxU=; t=1734335511; x=1734425511; 
	b=IR5N6IC/rheW9WLWCv8XXk2DbwqqGB7rQC0gl4rB8hah2pmqtwT5JjNgENYFu3PLr9N8iFbjhpV
	zN6cy/9nVtyrKX/8Z3vdVOpcE5MMkM64i7CxvdSA4PyCbu8y84ezrt78+uc48HmxYwgXB3YlfDMpX
	FjQbBsyF4BKfndBeQdrRrnYFk5IHYDpZcoJ4AWPDI5Y01eMdYOR4hOpmcKCTOAQBQreXvSiKFlvW9
	/m7n5DyH3w4v2S25DODrZBKHpLHyXFB1UvNK9FEjykfZWNspzhld48Q8AAauUI11vR3KE+V8zTHiN
	PW1Iyj5V6aK4laQxsIdx+steBqpzzcG7z63w==;
Received: by exim-smtp-76d484c77c-jrrj8 with esmtpa (envelope-from <fido_max@inbox.ru>)
	id 1tN5tA-00000000PeK-1jZI; Mon, 16 Dec 2024 10:51:37 +0300
Message-ID: <1ea49866-1ad3-4e54-add7-cd8f0dc26916@inbox.ru>
Date: Mon, 16 Dec 2024 10:51:35 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ASoC: codecs: nau8824: fix max volume for Speaker
 output
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-sound@vger.kernel.org, u.kleine-koenig@pengutronix.de,
 tiwai@suse.com, perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org
References: <20241216043910.11875-1-fido_max@inbox.ru>
 <CAHp75VfLa4VvfM1aRPie9k69Pw-Bg-6P_S=Fq6VDpZz68tNVJQ@mail.gmail.com>
Content-Language: en-US
From: Maxim Kochetkov <fido_max@inbox.ru>
In-Reply-To: <CAHp75VfLa4VvfM1aRPie9k69Pw-Bg-6P_S=Fq6VDpZz68tNVJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD977EAE61095F37AC599FC447346B8CA5F2D619F394106ECEC182A05F5380850405F50AB6324DAC6A53DE06ABAFEAF67052919C37AB8FDC383DF47DE13ADC868FE58986F725C2A4283
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7260723E369DE2609EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637DEEC83A7CF8598608638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8437BBB6A66706F77E21E0E4709FB1AF497AC97FCD86C75F220879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C05A64D9A1E9CA65708941B15DA834481FA18204E546F3947C0A6B3CD6EB70C818117882F4460429724CE54428C33FAD30A8DF7F3B2552694AC26CFBAC0749D213D2E47CDBA5A9658378DA827A17800CE77A825AB47F0FC8649FA2833FD35BB23DF004C906525384302BEBFE083D3B9BA71A620F70A64A45A98AA50765F79006372E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89F83C798A30B85E16B5E1C53F199C2BB95B5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A59DD401627F2836E85002B1117B3ED696CF9CCC1E5C949A71A13BD6A4B0E00B96823CB91A9FED034534781492E4B8EEADB1D70E2111C441FFBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742424CF958EAFF5D571004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D34181D1E89D5A0B42F4AFBC0380BF13D33BB14DC6FEFC395603436F9C01C841FBABB112A00711CA1B71D7E09C32AA3244C1193CF46BA31920677DD89D51EBB7742FD674B40F332F446EA455F16B58544A204553CF91077F0FB57ADA2CBCE38F05762A0BE504FE5E636F1E3461735CEBA253FCF178C6DD14203
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojaQ2NfKPcDQMA6RjhCloW5Q==
X-Mailru-Sender: 689FA8AB762F739381B31377CF4CA2192A588F0CEFBD54CDBABFCBA83C06B86D259EFEA13845245290DE4A6105A3658D481B2AED7BCCC0A49AE3A01A4DD0D55C6C99E19F044156F45FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B46EA299E95BC82A7894C8F8DBFF25E4DC683ECBF39C53289F68F3CF0E9FE49B69A7073F105D29789002C9AF74F672F9BEE45EDEECB688B1DEE5301E8E9469BB4788775C9AF3D7C914
X-7FA49CB5: 0D63561A33F958A578B63B2A807DA8AA5002B1117B3ED696550BA49339F10E0C48CF2B314AC7178202ED4CEA229C1FA827C277FBC8AE2E8B586CC7FA44D4B06A
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5+wYjsrrSY/u6NqYXWMR0/V85CnFjCYTu9APdQH0PvpnP5qz8aO2mjTJzjHGC4ogvVuzB3zfVUBtENeZ6b5av1fnCBE34JUDkWdM6QxE+Ga5d8voMtmXfSpHqEYnscTDIXvnsmttD4RG
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B46EA299E95BC82A7894C8F8DBFF25E4DC683ECBF39C53289F68F3CF0E9FE49B69A7073F105D297890D0CA04B195ADB0C1666EEAFE638C25E3D05C1FD1B6BF8608
X-7FA49CB5: 0D63561A33F958A54368912E3D7286086D033853BF8EDC40FDF4DD0D389D1F7ACACD7DF95DA8FC8BD5E8D9A59859A8B69D685252E6FD7D2F
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5+wYjsrrSY/u6NqYXWMR0/V85CnFjCYTu9APdQH0PvpnP5qz8aO2mjTJzjHGC4ogvVuzB3zfVUBtENeZ6b5av1fnCBE34JUDkWdM6QxE+Ga5d8voMtmXfSpqir9ySoAJTLJdENjvzQK2
X-Mailru-MI: 20000000000000800
X-Mras: Ok

16.12.2024 10:41, Andy Shevchenko wrote:
> On Mon, Dec 16, 2024 at 6:39 AM Maxim Kochetkov <fido_max@inbox.ru> wrote:
>>
>> There is no audio output if Speaker volume is set above 25.
>> According to datasheet maximum allowed value for the Speaker
>> output is 0b11001 (25).
>> So adjust this value with datasheet.
> 
> ...in accordance with the datasheet.
> 
> Can you add the section number and its title and possibly the version
> of the datasheet?

Rev 2.5

0x6D CLASSD_GAIN_1/ 0x6E CLASSD_GAIN_2:

Left/Right Channel Class-D Driver Gain For DAC Left/Right
Input
(Step size is 1dB.)
00000 = Mute (DEFAULT)
00001 = 0dB
00002 = 1dB
...
11000 = 23dB
11001 = 24dB


I will add it in V2


