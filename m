Return-Path: <linux-kernel+bounces-427794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 097079E09AD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BF99B3AFF9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6124220899E;
	Mon,  2 Dec 2024 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bell.net header.i=@bell.net header.b="KHLYh4rW"
Received: from cmx-mtlrgo001.bell.net (mta-mtl-005.bell.net [209.71.208.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE62204F82;
	Mon,  2 Dec 2024 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.71.208.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151273; cv=none; b=WV5lV+hShyij5bonTV3uJiwGRAFvisnhRNPQ4AwbtYfvB5UaIyZ/8eBtJzqA1XKxmQ7ACzSmagoYP1TNgMj5d1iLznlep5oHmgxolQpO0nYZ2eD8nDUoKW6+PoaAb5MeYc0GT/k2M3E7TYXZHxcTNPzNOZrW0cRKo2+nj88LnoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151273; c=relaxed/simple;
	bh=ydJ050p5kRpGPo5p0DhJYef3kqtFLbzFSwEI1+UYF0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gGtDgD94ve+5U3AAx4jxP30o3sDPRWxldoCbIcD7HKIL/Ndp1S4Pw95XqFGMojxx3ifFRTMBhvoCKzAZ7ci91uVTZqZmh+zNQbnaCQJx0Vq/3YEDFFz+5jLbLCUCcJU0dBTgFOXMgqSj9Zfv06z++xs1ebbodr7X3qzET/6mm04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell.net; spf=pass smtp.mailfrom=bell.net; dkim=pass (2048-bit key) header.d=bell.net header.i=@bell.net header.b=KHLYh4rW; arc=none smtp.client-ip=209.71.208.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bell.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bell.net; s=selector1; t=1733151271; 
        bh=DY3LsWMnbJe3ainU8D47fIH4dK+344l/UIDmFctiWFQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:In-Reply-To:Content-Type;
        b=KHLYh4rWiB+/iII/Yp7vpNlaAFkd0Ir7dtqjWqizh5RchUqYHHjgLuwGLUjDOz3pvQVR5ryG2tTgWh3sBCTzoOsYebesISODVU6qeZCt2vdWBlIuHz6zZpq8QKiBCBUWzYD61u1eK4ENHRVGcwcbR6P5/1Wa+q1l/1YHWB83IoVWFcHVh0dMTpmXoNyDD3QmsiEn8LMBl/Lw0cvqd9vFvpac52CFbkm1pGHbuNjfl+9VWraUOXqKdJXaxBp4WOU40TKftqPUv0AijorgX37eEGeQHgAEFIpfq8SDvLW0N5x1N62WtrZKGQ8j2CTTEciJspGe1wOI1aZ0IxvlN+k6cw==
X-RG-SOPHOS: Clean
X-RG-VADE-SC: 0
X-RG-VADE: Clean
X-RG-Env-Sender: dave.anglin@bell.net
X-RG-Rigid: 673CEB06026C2CE5
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefuddrheelgdeikecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceugffnnfdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeflohhhnhcuffgrvhhiugcutehnghhlihhnuceouggrvhgvrdgrnhhglhhinhessggvlhhlrdhnvghtqeenucggtffrrghtthgvrhhnpeejleffffejhefggfeuheelgeefgeeuieegtdekffegudeuteffgeffjedukefgueenucfkphepudegvddruddviedruddvledrieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedrvddrgeelngdpihhnvghtpedugedvrdduvdeirdduvdelrdeipdhmrghilhhfrhhomhepuggrvhgvrdgrnhhglhhinhessggvlhhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhrtghpthhtohepuggrvhgvrdgrnhhglhhinhessggvlhhlrdhnvghtpdhrtghpthhtohepuggvlhhlvghrsehgmhigrdguvgdprhgtphhtthhopeguvghllhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhmrghgjeesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhprghrihhstgesvhhgvghrrdhkvghr
	nhgvlhdrohhrghdprhgtphhtthhopehmrghtohhrohgpmhgrihhlihhnghhlihhsthgpkhgvrhhnvghlsehmrghtohhrohdrthhkpdhrtghpthhtohepshgrmhesghgvnhhtohhordhorhhg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.2.49] (142.126.129.6) by cmx-mtlrgo001.bell.net (authenticated as dave.anglin@bell.net)
        id 673CEB06026C2CE5; Mon, 2 Dec 2024 09:54:21 -0500
Message-ID: <03978220-0153-417c-8479-09239d19c9ba@bell.net>
Date: Mon, 2 Dec 2024 09:54:21 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bisected] ext4 corruption on parisc since 6.12
To: Magnus Lindholm <linmag7@gmail.com>,
 matoro <matoro_mailinglist_kernel@matoro.tk>
Cc: Linux Parisc <linux-parisc@vger.kernel.org>, deller@kernel.org,
 Deller <deller@gmx.de>, Sam James <sam@gentoo.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <84d7b3e1053b2a8397bcc7fc8eee8106@matoro.tk>
 <31c884b9-77c8-48dc-b84c-20e52cdc4d44@bell.net>
 <71fae3d3a9bd816ea268eb73c152b564@matoro.tk>
 <CA+=Fv5Qy0818xS3uW2bh2nVpy-3COUzbq5X0JPY6=YzbfYgNOA@mail.gmail.com>
Content-Language: en-US
From: John David Anglin <dave.anglin@bell.net>
Autocrypt: addr=dave.anglin@bell.net; keydata=
 xsFNBFJfN1MBEACxBrfJ+5RdCO+UQOUARQLSsnVewkvmNlJRgykqJkkI5BjO2hhScE+MHoTK
 MoAeKwoLfBwltwoohH5RKxDSAIWajTY5BtkJBT23y0hm37fN2JXHGS4PwwgHTSz63cu5N1MK
 n8DZ3xbXFmqKtyaWRwdA40dy11UfI4xzX/qWR3llW5lp6ERdsDDGHm5u/xwXdjrAilPDk/av
 d9WmA4s7TvM/DY3/GCJyNp0aJPcLShU2+1JgBxC6NO6oImVwW07Ico89ETcyaQtlXuGeXYTK
 UoKdEHQsRf669vwcV5XbmQ6qhur7QYTlOOIdDT+8zmBSlqBLLe09soATDciJnyyXDO1Nf/hZ
 gcI3lFX86i8Fm7lQvp2oM5tLsODZUTWVT1qAFkHCOJknVwqRZ8MfOvaTE7L9hzQ9QKgIKrSE
 FRgf+gs1t1vQMRHkIxVWb730C0TGiMGNn2oRUV5O5QEdb/tnH0Te1l+hX540adKZ8/CWzzW9
 vcx+qD9IWLRyZMsM9JnmAIvYv06+YIcdpbRYOngWPd2BqvktzIs9mC4n9oU6WmUhBIaGOGnt
 t/49bTRtJznqm/lgqxtE2NliJN79dbZJuJWe5HkjVa7mP4xtsG59Rh2hat9ByUfROOfoZ0dS
 sVHF/N6NLWcf44trK9HZdT/wUeftEWtMV9WqxIwsA4cgSHFR2QARAQABzTdKb2huIERhdmlk
 IEFuZ2xpbiAoRGViaWFuIFBvcnRzKSA8ZGF2ZS5hbmdsaW5AYmVsbC5uZXQ+wsF3BBMBCAAh
 BQJSXzdTAhsDBQsJCAcDBRUKCQgLBRYCAwEAAh4BAheAAAoJEF2/za5fGU3xs/4P/15sNizR
 ukZLNYoeGAd6keRtNcEcVGEpRgzc/WYlXCRTEjRknMvmCu9z13z8qB9Y9N4JrPdp+NQj5HEs
 ODPI+1w1Mjj9R2VZ1v7suFwhjxMTUQUjCsgna1H+zW/UFsrL5ERX2G3aUKlVdYmSWapeGeFL
 xSMPzawPEDsbWzBzYLSHUOZexMAxoJYWnpN9JceEcGvK1SU2AaGkhomFoPfEf7Ql1u3Pgzie
 ClWEr2QHl+Ku1xW0qx5OLKHxntaQiu30wKHBcsF0Zx2uVGYoINJl/syazfZyKTdbmJnEYyNa
 Bdbn7B8jIkVCShLOWJ8AQGX/XiOoL/oE9pSZ60+MBO9qd18TGYByj0X2PvH+OyQGul5zYM7Q
 7lT97PEzh8xnib49zJVVrKDdJds/rxFwkcHdeppRkxJH0+4T0GnU2IZsEkvpRQNJAEDmEE8n
 uRfssr7RudZQQwaBugUGaoouVyFxzCxdpSYL6zWHA51VojvJYEBQDuFNlUCqet9LtNlLKx2z
 CAKmUPTaDwPcS3uOywOW7WZrAGva1kz9lzxZ+GAwgh38HAFqQT8DQvW8jnBBG4m4q7lbaum3
 znERv7kcfKWoWS7fzxLNTIitrbpYA3E7Zl9D2pDV3v55ZQcO/M35K9teRo6glrtFDU/HXM+r
 ABbh8u9UnADbPmJr9nb7J0tZUSS/zsFNBFJfN1MBEADBzhVn4XyGkPAaFbLPcMUfwcIgvvPF
 UsLi9Q53H/F00cf7BkMY40gLEXvsvdUjAFyfas6z89gzVoTUx3HXkJTIDTiPuUc1TOdUpGYP
 hlftgU+UqW5O8MMvKM8gx5qn64DU0UFcS+7/CQrKOJmzktr/72g98nVznf5VGysa44cgYeoA
 v1HuEoqGO9taA3Io1KcGrzr9cAZtlpwj/tcUJlc6H5mqPHn2EdWYmJeGvNnFtxd0qJDmxp5e
 YVe4HFNjUwsb3oJekIUopDksAP41RRV0FM/2XaPatkNlTZR2krIVq2YNr0dMU8MbMPxGHnI9
 b0GUI+T/EZYeFsbx3eRqjv1rnNg2A6kPRQpn8dN3BKhTR5CA7E/cs+4kTmV76aHpW8m/NmTc
 t7KNrkMKfi+luhU2P/sKh7Xqfbcs7txOWB2V4/sbco00PPxWr20JCA5hYidaKGyQxuXdPUlQ
 Qja4WJFnAtBhh3Oajgwhbvd6S79tz1acjNXZ89b8IN7yDm9sQ+4LhWoUQhB5EEUUUVQTrzYS
 yTGN1YTTO5IUU5UJHb5WGMnSPLLArASctOE01/FYnnOGeU+GFIeQp91p+Jhd07hUr6KWYeJY
 OgEmu+K8SyjfggCWdo8aGy0H3Yr0YzaHeK2HrfC3eZcUuo+yDW3tnrNwM1rd1i3F3+zJK18q
 GnBxEQARAQABwsFfBBgBCAAJBQJSXzdTAhsMAAoJEF2/za5fGU3xNDQP/ikzh1NK/UBrWtpN
 yXLbype4k5/zyQd9FIBxAOYEOogfKdkp+Yc66qNf36gO6vsokxsDXU9me1n8tFoB/DCdzKbQ
 /RjKQRMNNR4fT2Q9XV6GZYSL/P2A1wzDW06tEI+u+1dV40ciQULQ3ZH4idBW3LdN+nloQf/C
 qoYkOf4WoLyhSzW7xdNPZqiJCAdcz9djN79FOz8US+waBCJrL6q5dFSvvsYj6PoPJkCgXhiJ
 hI91/ERMuK9oA1oaBxCvuObBPiFlBDNXZCwmUk6qzLDjfZ3wdiZCxc5g7d2e2taBZw/MsKFc
 k+m6bN5+Hi1lkmZEP0L4MD6zcPuOjHmYYzX4XfQ61lQ8c4ztXp5cKkrvaMuN/bD57HJ6Y73Q
 Y+wVxs9x7srl4iRnbulCeiSOAqHmwBAoWaolthqe7EYL4d2+CjPCcfIuK7ezsEm8c3o3EqC4
 /UpL1nTi0rknRTGc0VmPef+IqQUj33GGj5JRzVJZPnYyCx8sCb35Lhs6X8ggpsafUkuKrH76
 XV2KRzaE359RgbM3pNEViXp3NclPYmeu+XI8Ls/y6tSq5e/o/egktdyJj+xvAj9ZS18b10Jp
 e67qK8wZC/+N7LGON05VcLrdZ+FXuEEojJWbabF6rJGN5X/UlH5OowVFEMhD9s31tciAvBwy
 T70V9SSrl2hiw38vRzsl
In-Reply-To: <CA+=Fv5Qy0818xS3uW2bh2nVpy-3COUzbq5X0JPY6=YzbfYgNOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-12-02 1:30 a.m., Magnus Lindholm wrote:
> On Mon, Dec 2, 2024 at 5:55 AM matoro
> <matoro_mailinglist_kernel@matoro.tk> wrote:
>> Hmm, this is my config, also on an rp3440:
>>
>> #
>> # Timers subsystem
>> #
>> CONFIG_HZ_PERIODIC=y
>> # CONFIG_NO_HZ_IDLE is not set
>> # CONFIG_NO_HZ is not set
>> # CONFIG_HIGH_RES_TIMERS is not set
>> # end of Timers subsystem
>>
>> lindholm can confirm on their hardware/config.  Maybe you can try that and
>> see if you can reproduce?  I will try your config as well.
> Hi, I'm on a HPC8000 "parisc64 PA8800 (Mako) 9000/785/C8000". I can confirm
> that building a kernel CONFIG_SMP=n will mitigate this problem.
> I haven't messed around with the config in the Timer subsystem so in my case the
> parameters suggested are unset. (my config looks like matoros)
The clockevent driver was tested on both rp3440 and c8000, and some other SMP machines.
Helge knows details.  I have used it on rp3440 and c8000.

I would try my settings.  The primary reason in switching to the clockevent drivers was to
improve clock resolution.  The best resolution with the old drivers was 1 ms at 1000 HZ.
This caused problems with various package tests.  If config is the issue, probably
CONFIG_HIGH_RES_TIMERS needs to be forced when clockevent drivers are used.

Almost every other system uses the clockevent drivers.  So, there was a risk that parisc would
become unsupported.

I wonder if this could be caused by dead RTC battery.  Did you check output of date command?
Maybe a dead RTC battery interacts badly with clockevent drivers.

I run ntp on all my machines.

What files have bad dates (i.e., is this really a ext4 file system issue) or is it just that system has
a bad clock?

Dave

-- 
John David Anglin  dave.anglin@bell.net


